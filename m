Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BD62840C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiKNPgh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNPgg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:36:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8870513F2F;
        Mon, 14 Nov 2022 07:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGUPxx+xNj23yctHI9MeVRM9ohEFo/iD4gfoFVR8Hf6FrOSeL1AwDkEQhf/xnVd4PZKou/nnkU+T2N/fldQwsDz2Wh2kvWYKrmfnh1L21YAVioeEW1JFAMdO7Ja70LN7wXPccQW2oWopkXUh97tN/Es1BXRkjuRxrnen6XtETXY2mRuCaNMojCIqGGYFJTSNr1UuRAh/T4mil+DJ6qLz2A3frmYnOKWwc6yWtIr3xZ/2lQAEJluxE1Z6P7F7QmkxC+INIh4Q7TlOheqLqkJl/M71iPuJiDgKzbxC8nTw/lMdUoi3SzCOsWJvrj6H28JnVEdmR43CukxFKRUb9uoabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzxP7+M5oO8OUuUI9El0prRbZ22WJRxqFrYrXKIxJfU=;
 b=nifbiDdfYykDcG9mCQJHpEAyIMWowF+gMlyZ7xAsT6EiXLBx77iQ6iP/P3NRA+v6wseANl/WwPSn5w4P3SZtx+ZP4M2p8FCDb3a7vyEASdf/OnQlAAiSNxfUL6zCFrwke1z2PVUdjPvdOfBJxRp3aD970TAWFzagJ5UoRmfX0hq9kYTkeyvVpk0qIpBxLBJTyIyR/b6dNqPuLhzrbJLeAPp4n0WgHvLq3l3IYtGEAETjRDa+f3ORzzx8nFSF+zRszl+DcHytt8rBXFIummePB355nvQawSnvfP0aFy4FoQiixGZDUAjTfuGOqQNV7VolRzUmmJdNFR0zlLrKYS3wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzxP7+M5oO8OUuUI9El0prRbZ22WJRxqFrYrXKIxJfU=;
 b=cfUOyNyMeJEuI14JbufDsX8eeQ+YFiSO890Y47dAwd4hxiogEtFDqkHmUAz+pdx/dXewtbM2kFOS82ZbD+/z4tAA9/ncQBXpi3WJIBF6hrB3JJodZThdJAKONvS5M4yqhlZMmN9wIW9QyBF/F6w1PZC5wmeFIlcoXbQ8oaDs/KKsyGsoaLbIsHLlG4DhWc/7xL3+hIATZPD15ebSJIohHoRDCqldtLrxbXD+RxBbN4M/7kwIHK/aXFjQDYBYGyfz3rAuy1UAQ5qtyFcydzElH/JoDwpMXKWCG3f+TUX9OayA0htJ9g9OxzkK/cahPJYZRO/5vmYq6ZN288pvpBby2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:36:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:36:32 +0000
Message-ID: <049113cc-1031-2576-0fcc-92f391841a7b@nvidia.com>
Date:   Mon, 14 Nov 2022 15:36:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
References: <20221114140916.200395-1-jonathanh@nvidia.com>
 <20221114140916.200395-2-jonathanh@nvidia.com>
 <d8edc185-52cd-ffa1-7b46-2ec84d0d712c@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <d8edc185-52cd-ffa1-7b46-2ec84d0d712c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cf2756-2503-4bbc-901e-08dac65601d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvR5NzUOGzxaq3Nm4f6s102HPrOuvozmc5NHqGKXPkcOZhB5M+fb7mKz791/nLZVGbskd9NkQYQjMX5XlGilvzbVyhzWXXTcjFseLe44HOkAU99Lhw1OkNDD9XIgb2yalXmWszycv9MD8COjBhxwXOjsVVzM4z1XPZE/bSenjN+9GvtIXVdVZU9GtyjCSC+cjOAUjw9sY3ZWvZTF9RIAIaiA5wqOVx5A2uTRnK3HP3ySme2jP0BmIn3uCbef+cOh6uBSsgwhB6wJ5Htjc3RpTddClFN4hcYsM2VSIvZTPGlIQ3lIvIVP1etUxiHUoUMmgekyAhY4fPjmRkX0NouFVSdcffe95A66EJTicwNXOXxTz/XPY74josAN4qb7u3SfHnUdK8HA7OvjD0eCgGa6d2oLgFoPzr1m8eLnzI0bz8xWIqZp/3uBmzmKm0PRdeEM8fHyfDWHq78wZiH5x8q8+JjiQzc/R2LQCrTMziqptWytKRvUl8ftn5Hw8ijvfxA6fQfJskXJlIULHL4dPwjcIntdCr5frVJW/6UMMRjfxqk8cgpeX5jFRd31PitktpWEFEO/YEtYtjPe1Ya5n+RR/Cg2iOO1CODgw7hllEhikw1kyE4s8NS7fZEcaPY1WJrVMPjFd32NifTu4WyRXaAlBC9p80xyw60Bl279HnkWBORGs2HD6wOBtWvLLKU2h1r/s3lhaFXqzjtXPcTfiLa0fYx9l54aA3ZR+fZrYi2/ql65FKzrwCI6aLR3DvlHTgOY1N12uaE4DUP1Qj168IGK1ORkXTH/h9OGgqKfC5SLj80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(107886003)(6666004)(31686004)(41300700001)(53546011)(8936002)(38100700002)(6486002)(6506007)(83380400001)(478600001)(5660300002)(110136005)(6512007)(86362001)(31696002)(316002)(2616005)(66556008)(8676002)(4326008)(186003)(36756003)(2906002)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T01rU251aTFaZFcxSFBoYm1TREhnY3cydHBKdm84STIvT3V3cE1iRHRVUmw2?=
 =?utf-8?B?cThHenhZMUYya1Y5WW1seWZ2SEQrek5jWHgvcE1IUEdXZ3hKWndBV01yUEpK?=
 =?utf-8?B?dE1yS1Y2RmxQdFpLNGE2azNZcFM3RDRHZEx6YWc3eVRJdW9sMW81a3hxSy91?=
 =?utf-8?B?Rk5XZkVKdlhOczhKQ1RCZDBTMExXY25oUDMwYmYvcjgrSkt6NmVYcmxYRDEx?=
 =?utf-8?B?TERxSVVmQmF3TThLcC8zV1V4aGU5eitIS2pqaEJ4ZDViVFR0TC9uNjZRYUlZ?=
 =?utf-8?B?Uk9VN2dJSmZJcUJVK1ZmY25CcFo1bGo5Q0paS2NnQ1hZVU5JdUt4cWJlSU1a?=
 =?utf-8?B?NzhnTDdMMEU5K0J3bmxqZjFIa0NZNHVjbDVrdCtZNTZKWUFDVy93aHU5d1Jv?=
 =?utf-8?B?S2VHS0ovY2J5NEFXTS83V1NpL1ZhT1RhcEh6anFaV1BteGpZWEQweitEby9o?=
 =?utf-8?B?UVphYnM3TnM2S3c2TjZpdUN1MEc2bEUrOGhNTzRHKzcrVXpDL1YxMEhiRWRC?=
 =?utf-8?B?UTVtbFl1QVFTWlIvVEVTRm51TitRMC9QOUZhaEV3ajZiQnEzTXQ3M3N6eG1S?=
 =?utf-8?B?Nkl1YjliRUN5OHBESkxLZFExTmVNSW9iNG1JY3lBSjMvRzdOcWRzbHlXUzg0?=
 =?utf-8?B?QmlkNFBKNE5melNWK1FTWVRuYkhxSHNYSDMxUXNaR0hxZmlUVmx3ZW9pL1Y2?=
 =?utf-8?B?WHFXZHhvbDNEaGE2RjNKN0xtenMxSWdKK0JBUzdQVlNEUlRFc3Q5VWUwT3Ux?=
 =?utf-8?B?SDJyR2lGRlc3RkdtYmZUVGd4SVp1UHdZZ043U0twSkRmc0Jva2dySVllVm16?=
 =?utf-8?B?VU9SOTNXZG1wWURiVUNzK0ZrMnE1VTh6bTF0blNGclQ4OFovaS9ad2MrM25j?=
 =?utf-8?B?cEQ1aUQyRFE5aC9rdjFvczFDY0ZYT2g4aldKQllvVkliZ0NtN3ZvK0laUUhP?=
 =?utf-8?B?M2xFd1QxQkloZ0kwb2xwQ2ZIU2lSUTNjaFFScmN4MkxOUlNsTGxhMXJRaUls?=
 =?utf-8?B?QkF4YkR2L1NUMEcvNGh4emhWSGQrUytOKzRGVUxncHZFanFwOTNFeFNqWmhx?=
 =?utf-8?B?UzBLeUhHMFlzYTJsNVlBQ1NHeVVWT2NtUUpvMkw3dkZRZTROSndJWGdrWUh1?=
 =?utf-8?B?TG1VdGhoeDRVaU44VDhRbTBkVkdaQlYzNXlSSU1OSDV1VnlyMk5JbENMV2pH?=
 =?utf-8?B?TnVKQ1hhQVQyaWhOOXBaM3drbHI1UVk3aEsvaGxaQk9sTHFVbHBiWG1KY1hi?=
 =?utf-8?B?emVVTi8rbkJsRFZvckJhcDJNNFJNOW5YT0JnRWs1V0FweVR4ZHlZWVVSd2M5?=
 =?utf-8?B?Rnp6VWd6aXJrTzJ0V3lWbnJoV1dWQmxnUWxoR3AzdTFwMENpdytxbVJ3aUhm?=
 =?utf-8?B?SytKNUEzbDZ6Q1A2NlNhUDByTERYMDBRdFlQcG9tNWVmVFFYMU5vdE1aQ2hP?=
 =?utf-8?B?NjhYb2dRemVTdGdYdW5UZXFmOGJMWk05bFJlTVhMTXdrbFV6WUoySU9wUWFo?=
 =?utf-8?B?L0hCeHhtNWpnTDl3TW94bXhJdEZ2b1NUeFd2cERSc25yOW9STkF4SDIxSllB?=
 =?utf-8?B?SUNDSkE4dUk5dTc0M3Y0d3M2RCs0VWkxOFlhNVp2NURKRWdzNlpvdlJvY0NI?=
 =?utf-8?B?b0t4ZHVZUjNQUHd3OHZEZDFNWjNQR1dwQlhMRFdkbGI4RjVCYkZxaThpOXIw?=
 =?utf-8?B?ODl4a2xsRDJXdkhsa0srT2phQzFlTWZvdkpWY3VDVU43ODRxNlZoWnJVN3Zp?=
 =?utf-8?B?dzVXV0FzUVNMeHNVdE9kYlpLSmlsM2hJdEFJcmk2TU5KMHVkYlBoSnlFKzNr?=
 =?utf-8?B?TWpFRm54S2hhRFAyZVB2K0gvaEZFY3c5bXB0TjgzZ1Nnc3QrRUIrOHFkQWoy?=
 =?utf-8?B?MDg5TC9mNVRlZE9hWlNnME9kUUZRS2tZa1NSU1BMR05rNVJzR0VLU3d6UVNy?=
 =?utf-8?B?NVRyRFdCWDUvaEg2VTdyWjZTOXFINVlDOU0xT3hrN1EwdllOUzRqaW9lTVhk?=
 =?utf-8?B?eG91eHR5bTNSQjAzd2hRbWM4Q090dElXdUs4OUtwV0pHOU5XUno3YzJZcFdp?=
 =?utf-8?B?OWsyQTY2cGp1NksyWW02MjFtTDdTZXhtTFVCS0hYNGNvb1FCcTF1THl1eFFU?=
 =?utf-8?B?QUVUS1BhQWt3d25tMWJzQ3RPb2lZYVNlR2huKy9US2hldFhrdGY4YXFQUFcx?=
 =?utf-8?Q?gbmUT2sqXn6MgcEexFTU+K0sCqFq7WTqKho9a7mpdZdo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cf2756-2503-4bbc-901e-08dac65601d7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:36:32.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvKeERC9qpYYxOEwi/w7tcVyPYFEGFDMDt/mn1q+TnVw02QnVu1LfGTuf/dP1p02IOfOJ+Xhf0ZATgMDQmEKww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 14/11/2022 14:23, Krzysztof Kozlowski wrote:
> On 14/11/2022 15:09, Jon Hunter wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Add support for ECAM aperture that is only supported for Tegra234
>> devices.
>>
>> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>> Changes since V1:
>> - Restricted the ECAM aperture to only Tegra234 devices that support it.
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 76 +++++++++++++++----
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>>   2 files changed, 62 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> index 75da3e8eecb9..7ae0f37f5364 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -27,21 +27,12 @@ properties:
>>         - nvidia,tegra234-pcie
>>   
>>     reg:
>> -    items:
>> -      - description: controller's application logic registers
>> -      - description: configuration registers
>> -      - description: iATU and DMA registers. This is where the iATU (internal
>> -          Address Translation Unit) registers of the PCIe core are made
>> -          available for software access.
>> -      - description: aperture where the Root Port's own configuration
>> -          registers are available.
>> +    minItems: 4
>> +    maxItems: 5
>>   
>>     reg-names:
>> -    items:
>> -      - const: appl
>> -      - const: config
>> -      - const: atu_dma
>> -      - const: dbi
>> +    minItems: 4
>> +    maxItems: 5
>>   
>>     interrupts:
>>       items:
>> @@ -202,6 +193,60 @@ properties:
>>   
>>   allOf:
>>     - $ref: /schemas/pci/snps,dw-pcie.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra194-pcie
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 4
>> +          maxItems: 4
> 
> How you wrote it, you do not need min/maxItems here, because you have
> items below. However see further comment.
> 
>> +          items:
>> +            - description: controller's application logic registers
>> +            - description: configuration registers
>> +            - description: iATU and DMA registers. This is where the iATU (internal
>> +                Address Translation Unit) registers of the PCIe core are made
>> +                available for software access.
>> +            - description: aperture where the Root Port's own configuration
>> +                registers are available.
>> +        reg-names:
>> +          items:
>> +            - const: appl
>> +            - const: config
>> +            - const: atu_dma
>> +            - const: dbi
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra234-pcie
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 5
>> +          maxItems: 5
> 
> Similar issue.
> 
>> +          items:
>> +            - description: controller's application logic registers
>> +            - description: configuration registers
>> +            - description: iATU and DMA registers. This is where the iATU (internal
>> +                Address Translation Unit) registers of the PCIe core are made
>> +                available for software access.
>> +            - description: aperture where the Root Port's own configuration
>> +                registers are available.
>> +            - description: aperture to access the configuration space through ECAM.
> 
> This is unnecessarily duplicated. You can keep the descriptions of items
> and reg-names items in top level (with min 4 and max 5) and restrict
> maxItems for 194 and minItems for 234 here.


Yes I wondered if there was a good way to avoid duplication. It looks
like I cannot have 'maxItems' and 'items' at the top-level, but
obviously I can set 'maxItems' appropriately for each device.

Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml: properties:reg: {'minItems': 4, 'maxItems': 5, 'items': [{'description': "controller's application logic registers"}, {'description': 'configuration registers'}, {'description': 'iATU and DMA registers. This is where the iATU (internal Address Translation Unit) registers of the PCIe core are made available for software access.'}, {'description': "aperture where the Root Port's own configuration registers are available."}, {'description': 'aperture to access the configuration space through ECAM.'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list

Thanks
Jon

-- 
nvpublic
