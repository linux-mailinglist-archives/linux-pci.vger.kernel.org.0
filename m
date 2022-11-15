Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C916629E5C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKOQDC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 11:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiKOQDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 11:03:01 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEBF0;
        Tue, 15 Nov 2022 08:02:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghT8jhQ+wfmauGbtm9y8KHUJ/Tjd13J137DGv1P7m4PuWcx2a20e0S42OB7s5ZEXvE/V7Q/BOwV+P75HHUgnjNz+BNkYrKXFHvVtYMXdsrVAfnmXzlYv8awdN0LpLY9C1Y5bhmNiIhoHf6fruvyWb4EPSMALT7eDtZ/QZ3b/8OHmVaJ5NuCsEF68haTG7MH9Bi7o1joVQJPvkX13YEHMMzpll0zD2PwKesdzd1H+hJ8j5usr2lmaR/TZwS+kxB2OuuleNCIjr+AEhS9BAkfaRivu4KOCnmwKiXfiR5z9hk6bAd9FwsUWhBIEaIhPPg9zhGkzLQ6WIAPRcWGQgtex+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/pl8kcnnjATVrdIIipy+KorWG1M2+aj6udN61+Bad0=;
 b=XSLLIzNNIBSbTckrNYRe8tLHDI448fjYUlmM/K++qLBcdYYIqCsojW9x7iTuwCC15SRZ5jvlv49lWUELq/hGgkkbP8hD6pgt3ftUygz7dLLvDgVJcK74X6FWEAoGfC9uqh243P2gVmBAUnMXr4J48Lf34C+lBrAOAgTTWBoG4HMK4yBlnFsKgqK0oOgb+fdzcQw5+BBFdveK0IwN/lOgSoQz8aY4bkqU7js0PFiZ8C/qxFCRoD/zcu7Jl50d4eUDOIATDdu6yCsCWXOXP9mDPNKDgKjLPelpfB5iIn8ZibUMv9pNJljCocwMa0bCYCq9pfTkTBHU+TPnh2vf8kDc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/pl8kcnnjATVrdIIipy+KorWG1M2+aj6udN61+Bad0=;
 b=ECifdB56SbddboJvpzdixjj0b590qHMYdhx3OUtnMEmAr9Bhc7z5iuBAwx+qZS9VJLKtYI1iyeUfnOqCdr7/cdtOZj5pDiG0fIh6M/NKL57kC1qMyoL6JtBIZbaHCIDOVJpIVMU/WRGfQBBR1EwfgVsU8eroHAimG8mu0fwUMLKt3Yrn5RdhGC26O0XHiXoTxG230qFNK9SpypkxkFTDlCOV0haMo/CsV/PJRxMqp290MPeCKvzwWyHQuYbDAzzewiaBw7W0ittwHlckXLR6sXMoq/GpcAwVHXs5guJ5bfRn6zVw7uGMvsPkL3N998PfpO5hrldIu9BXbqi769Y/uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 16:02:57 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 16:02:56 +0000
Message-ID: <f8148686-796f-62a6-e424-733966f7db0b@nvidia.com>
Date:   Tue, 15 Nov 2022 16:02:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
 <20221115020136.GA3973578-robh@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221115020136.GA3973578-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 80df832c-2ca6-46f3-a575-08dac722dc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CepK04WeD5CEzfxuK2iBvUSubeJQdHY2VSOOUiFZidujpG182wdpy+Z/ljB7LK9TcaqxRlZGm7AUggj8UpYhhNkux6HvwYAFWC7qy6F/TH18hNJh8uwKEqqa/WDz3HTIsTE0ElnGybpBTgESnxfmgvpwJ9wlT0g5XyUYwEdU6qCNlUdnWxM+24qjGc3KZHzbkn0h3Fm3Jw1CdDUET1jqHCEbJyMfSFbF5IyXnd+uvOZNy2Yu0rIgUChPXu3LkZXFVbCsTgWZKmAopcYfaNqGQ/wALGrd35geYTjETpCcAwSLxNUsIXS4fH9Z6iF1dQt2nz5lGo1xrK+73kUHtzsBDFsUUV3FU/JwH5SG8/HEFBdy9CzzBS8kGp4XDZ7L8JW/+Q+6MXWm0+alKivcBZvrLKFSNKQNaKk+r8TTDxn1U+EWfxsW3cHpkxM+lLzHC0J5qN7WaLeaeAdsWgKXvOaND6/twn1MwQlw7L30nkjtgouIX6+LG/Ty1HBcljdyNxk+sGfLn4X5v0N9scph9XDT5vX5hlqctAOAnBY8K6lOX+Tuz2FjWioskM8S5f/2WtW/i/K98OlHvq3MiKPAXCnatYUW3b7UBTxGzZhlsr+eXhsjemRS14wUXk9Oy/RnjUgJLy8E5Xk3PtGA1SbpW3WWhwZcKE+8yKdid+k1miQyF8oNBRw4Hvf9iHRQtwDEPnZPkQ+oY2p9Qzti5gDzaURRERrZn1O+TahNZtzdSGf6EHTkmcIrYggga/IX8GukZlJA+wuWnmG/+6PzSYW5/YDNmhgFWUaudyMJ+2114oVk3oZKdMxOUQ74Npn6O3tPPbsXE5Mn57vWPL3tmxwwFkn8Lr+pKo/DG1Lt/h+7l197wC59NhYqS1SDiPAga1b0dhdJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(83380400001)(478600001)(53546011)(6512007)(26005)(55236004)(186003)(2616005)(107886003)(6666004)(6506007)(31696002)(86362001)(38100700002)(36756003)(8936002)(31686004)(41300700001)(2906002)(5660300002)(4326008)(54906003)(6916009)(966005)(6486002)(8676002)(316002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2pHYUljaUttdlBpNzU4Yi8xT1UwdnVQaC8xWENzd3J4VnFZcGxDQ1ZleC9R?=
 =?utf-8?B?bjRCOU1WUXFPWTV1L3lmTkdkdlM3U1Awa0VZVXF0VlRrMmxuTEhGUUR1clk3?=
 =?utf-8?B?Tm9uVWVTRzlwV1QrMmNRRU10blY5dmZoWXJvMXZRWjZ1VitHOXlNdzEyVEtD?=
 =?utf-8?B?Qk82VkgyOXN2MEdMWXgzNHN0bk9tTTlJeDQ4cDZ5RG1XWDhBZElVL3VaOGJK?=
 =?utf-8?B?Z2FPUTZNdS9hSVRoTzg5d1R5aG1pWkJlMjJFdWlpSjFXYjV4SS9QbjFqZGZ4?=
 =?utf-8?B?UHAzd3d1QlozRzZodWJsV3RBWHNnTXZHRUkxZjlzVzRqU24yZkMyQUh3eEdG?=
 =?utf-8?B?c0ZlSmJid0h2aHBXcitWR2FIMktDZFIzcm9vRVludzdIcmg0NGRacGNRM2FJ?=
 =?utf-8?B?WEo1L3N0TVdRV2QzOTZUeW40cW85NmRjOFRuR2pvU3pIYndlc3lOTktBcUs5?=
 =?utf-8?B?K0gvRjVuWEFIN1BqZ0JnM3hYdEVLZ1ltbDZzdUZJMWtwRWhYeUg1MjFTQUFI?=
 =?utf-8?B?Ynk2YkhpSTdZOU1iTEFRL2NJdFpxL1R5Y2duVDZFbm1hRTBWRUdKSXN6RXJS?=
 =?utf-8?B?WWh5VmFFL2J5eXgyNHQ2Si8zWXNDdXR0c0kvK1R4bERVNThKUXBDUUVXTm50?=
 =?utf-8?B?NTBWaUpxY2YxdlpybmhvdkQ4b01VeGR1RUZwdUF3Q2c3bWFOY1YzMXZ3Yzlz?=
 =?utf-8?B?Ky9NQkRReDlMaFdxbzNuaGlpT1laNVNoYmxoTkRZUVE5cWxucVUzc3VoYWI2?=
 =?utf-8?B?bkp4NzB1eWpQUlBjK3VwdDlqaWZ3VmsyaDBkQXpOaW5SZU9TWDNPcFdjZG1O?=
 =?utf-8?B?cHoyVHU3Wk91aUdLNzFNZEppUXhFYndWWWlUOW53c0gyS3J0bWs0ejJjSncx?=
 =?utf-8?B?K0dOd2xRM1dKbUZhdy8wMjhVTHFuWUR4d0dUUDNsNzJrOSttWHNKOTZvTUpV?=
 =?utf-8?B?N0NrbStsS0NJVlppeFI4UG54S1Nwclp5dHFCRWlMNWlzSXR2SDNCc0wvaXlS?=
 =?utf-8?B?ajUrUTFXN0IybDBOU2pUOVVUUTBmME5sMTk3TlZTN2M1UkE1ZHNOR0dVNWJT?=
 =?utf-8?B?RjJWZTFNUUluTlRnS1crYmV1WVBVamVDeWNqNnFaODc3T290eGYrdFM5cTBW?=
 =?utf-8?B?UXBtVXl2RXQ1NlhFY1kyMFRYcExPVmRFTHZkb1VURTB6Uk5HYXcxSnZ6cHJ4?=
 =?utf-8?B?QUU3bE0raWFibmplN1doRkxVV056Tmx6eURGaVlHVHdPbDNnczVyR1IwcjFa?=
 =?utf-8?B?S3NFMWJJMzB4MkxmZFR2Wk1qcDQwSDlNd0RGWGp4cDNUZHB6Lzh1VnJpdWVX?=
 =?utf-8?B?UFNNTHF6N3FWa0I1R1ZnQ252QmhEeUdJSy9FWFlhZnFEbzFFL0JxbXdpN201?=
 =?utf-8?B?U1ZMMFN0Z1BBaTQxcHFVQ0hNUzM2RHZSNHNHTitZbnZGYnE1UEU0THBJQWpI?=
 =?utf-8?B?RDVuWGxyNW1zdFFwS3F1U2pEZWlFNzF6ekk0b1p4SXVwaXU0WGpXQlJCMkFt?=
 =?utf-8?B?NDhwUHVCUStSandJVG9zMi94S3VjSzVnOHlEUkhzSjZTcWU5KytyazJ1QVNL?=
 =?utf-8?B?NjAvNUl1TWlSU2FIUDFGSHZQdEpuNjhqYWNuR0YvOTYrYzMrOWREL3I4NEN1?=
 =?utf-8?B?NGxqNWM3MFN6cUlxd2FxdEhmTWtOZGN5NnduVXpXcmdsd0RraUh6RzViSFlD?=
 =?utf-8?B?V1F4L21XQ1E5MzIwNG1BYW0rcDNWY3MyTmJoODYxQVFXMnMvVk9Tb0JXdVQr?=
 =?utf-8?B?ZSsvZkU3U3E1NC9Xc3hrR3E4SkhCdTN3VDhmZFJ3aDNTWjF1VlZHeEplcFF6?=
 =?utf-8?B?S2VMRzFPSGYwczkvRFBQbTBaT1dBcU1Gb1B6SzVCTWd6eFNvWUVRWjVXTk5K?=
 =?utf-8?B?a3g5U1FvVnhiMThFQ2JFVXZNWFZiNjVBRkt5czRrcDhQc1JJRnJMbDJzRGcx?=
 =?utf-8?B?aFMxMU9uR0htRkpGZ0RZYWo0Q3UzRjZBZzlrVHNDc25nUGoxU3l4NzBVYk1j?=
 =?utf-8?B?ZC9tNDdRa05iUC9QQUhtaEVCcFM3cGlkNjlrSG9RSzdvMFhiV2lXai94T3pJ?=
 =?utf-8?B?L2ZOZ2lnTWdibzBSWUtyOGcwSk1hek1xaW9pbTVMUXppZ3pLR3dpdUFpVTNm?=
 =?utf-8?B?dXd3WmRxdEVqVEdrbTZWWG82U0x6WlhwaDZNN3p0M21kVFJRdEkyK0E0QnVI?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80df832c-2ca6-46f3-a575-08dac722dc07
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:02:56.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNrxHJJHX0bfklfqkfhFM5J56xPJgKd8iaMNnkz7ejpEbx9ioi2MD2t7z6YdggFKIpTZWfQ3HJaR/rAHgrV+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 15/11/2022 02:01, Rob Herring wrote:
> On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Add support for ECAM aperture that is only supported for Tegra234
>> devices.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> Changes since V2:
>> - Avoid duplication of reg items and reg-names
>> Changes since V1:
>> - Restricted the ECAM aperture to only Tegra234 devices that support it.
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++--
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>>   2 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> index 75da3e8eecb9..fe81d52c7277 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -27,6 +27,7 @@ properties:
>>         - nvidia,tegra234-pcie
>>   
>>     reg:
>> +    minItems: 4
>>       items:
>>         - description: controller's application logic registers
>>         - description: configuration registers
>> @@ -35,13 +36,16 @@ properties:
>>             available for software access.
>>         - description: aperture where the Root Port's own configuration
>>             registers are available.
>> +      - description: aperture to access the configuration space through ECAM.
>>   
>>     reg-names:
>> +    minItems: 4
>>       items:
>>         - const: appl
>>         - const: config
>>         - const: atu_dma
>>         - const: dbi
>> +      - const: ecam
> 
> Wouldn't this be mutually exclusive with 'config'? 'config' is not
> really h/w, but an just an iATU window typically.

Yes that is true, however, I was chatting with Sagar and we really need 
both ranges to be defined.

> Where's the driver change to use this?

For Linux there is not one. However, we need this for our port of the 
EDK2 bootloader [0] that parses device-tree and can support booting 
Linux with either device-tree or ACPI. We wanted to have a common 
device-tree we can use for EDK2 and Linux.

Jon

[0] https://github.com/NVIDIA/edk2-nvidia/wiki

-- 
nvpublic
