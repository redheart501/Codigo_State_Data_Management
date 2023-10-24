//
//  JsonData.swift
//  Codigo_Test
//
//  Created by Kyaw Ye Htun on 24/10/2023.
//

import Foundation

struct JsonData{
    static let healthConcernJson : String = """
    {
        "data": [
            {
                "id": 1,
                "name": "Sleep"
            },
            {
                "id": 2,
                "name": "Immunity"
            },
            {
                "id": 3,
                "name": "Stress"
            },
            {
                "id": 4,
                "name": "Joint Support"
            },
            {
                "id": 5,
                "name": "Digestion"
            },
            {
                "id": 6,
                "name": "Mood"
            },
            {
                "id": 7,
                "name": "Energy"
            },
            {
                "id": 8,
                "name": "Hair, Nail, Skin"
            },
            {
                "id": 9,
                "name": "Weight Loss"
            },
            {
                "id": 10,
                "name": "Fitness"
            }
        ]
    }
    """
    
    static let dietJson : String = """
{
    "data": [
        {
            "id": 1,
            "name": "Vegan",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        },
        {
            "id": 2,
            "name": "Vegaterian",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        },
        {
            "id": 3,
            "name": "Plant based",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        },
        {
            "id": 4,
            "name": "Pescaterian",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        },
        {
            "id": 5,
            "name": "Strict Paleo",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        },
        {
            "id": 6,
            "name": "Ketogenic",
            "tool_tip": "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        }
    ]
}
"""
    
    static let allergiesJson : String = """
{
    "data": [
        {
            "id": 1,
            "name": "Milk"
        },
        {
            "id": 2,
            "name": "Meat"
        },
        {
            "id": 3,
            "name": "Weat"
        },
        {
            "id": 4,
            "name": "Nasacort"
        },
        {
            "id": 5,
            "name": "Nasalide"
        },
        {
            "id": 6,
            "name": "Nasaonex"
        }
    ]
}
"""
}
