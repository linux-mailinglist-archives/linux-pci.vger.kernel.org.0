Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B852E62847D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiKNP6E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiKNP6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:58:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F562ED4D;
        Mon, 14 Nov 2022 07:58:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Napmh4SypAJe0iuZHk1B2C6gxsDIqVIrWU4Gewd0+dMp7PJBTu+pVNlcGX3GgEHOf+/tE7VXmPvTurrLZkSFV8XgVKfPFOmODlBqDAM8wF4+rjtjqOZuatqHp8/bF1dB12MSq+lUhw0I0yvXfxBQJ8lZ2HmJGGYpeOqoZJQt3GAy7cyxcCLoBY5oJ2Rze98XkVNnmdH6+Z1WOYXC+7RIW6NNEAf2eWWtA5RBSoRvezzfeckVAGjYMXEf8S9JnfacKnm6oGQUQBP09/ZUHKxwdA/KKrWsYeX1GPhSzXGCGYBM4gyKl6kQxZwCabGnuHh1Iqcip8wR2ZkmO7P+VR8zBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrcd7dG81BvOpUNr0yiZucqlsdxxPcPQ7yDagg++BuE=;
 b=grmNv28gggPPoZfTHMEYQqHcydYbrvOpGqMKGTCthHTrGRn4+7b0l6UmL7Z8LIh+fjDE/9bhkliaYrAbFnOe/DjMiP6TCl9ATn6HlZAlp3t2LHeeBRvMkFZus1EjsPolvoNKpEWSafOQKhHV+5kRLwiYYKuC1Lioh2YOxBPcop3tl5joOWQnlzkAJUQXadlp4Nlbz5GqanJB0Fjxp8pwXocOUCom/SfcWK/vo3+DCo4+JRKwQJ4XT/1Njzn46s/vChdJHWhWDaaSKQSsl4Rql0E4OG9zSIZNt2PNj/xlS6T4iiQVLgU3iAhWOr54rHXs4l76VYM3bu/uv8hMotpZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrcd7dG81BvOpUNr0yiZucqlsdxxPcPQ7yDagg++BuE=;
 b=g6Ort8B0g5quQPFNyAJx3vP8OKFs9rbPPZyVkdTfSI3ECXPQAVlfKNH9zjH7RQdI6cQ+S/v/ctLNtWBfrDhyRWI+ZgFE312O7ZWI9cwPGF/r4YTb34pDRjLFni6F/2MMhFRGI13hLvAEq4uqL2GWGWjlao9lbycilphJpHhCM3oJX+MapXlcSy6v5H7CMMtri6QRXPgxZ1ccgdFYx7U8J5vm75t1nBcGE7Q6I4b3Tv7kxItz+D9Z3q/CEGUoYJIPo0f9Zb4Exzd1M/MMbjyHpuzQ2Fp753oPCu1jWTmX9DGYVKTBGrx1ZC9IXywBPEz5FtaBOx/B6BQIlgNMXk5n7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 15:57:59 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:57:59 +0000
Message-ID: <9b6b819b-1e3a-2561-6b04-f9fc086e0d9b@nvidia.com>
Date:   Mon, 14 Nov 2022 15:57:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
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
 <049113cc-1031-2576-0fcc-92f391841a7b@nvidia.com>
In-Reply-To: <049113cc-1031-2576-0fcc-92f391841a7b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 7307a1f3-905d-4700-3f3a-08dac6590092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BfoBAbwZJFHen5rKPEjv8a3J74zOg3kjprZlQ/+d8nPW4+LpGMzQYFq8Iyvhsm32FOmciOP12zl9DZKkuoxaGlB2D5KP8CfImqbA7wZYovFHEPqb6U3S91/VxSUMhYApqM68Cmfol1KNxK2IVmbG2mfcqbTB3lkjC+j/2dKlSMLUwSUXN1HgDDqICGNzmzdJl7sV07PEF1xbTZVZPjjKAFhxDwdTDKZpGUj4CXTWpJN+do0fDu6sBWXs9ypGveuCEDhzQXaQrgaAGohtL0QmvSqNSjZ1V9IGjLiIjEdcJAP68csG+FnSV1Yeqz+BXElAe79lq/Mq8Jv0CM6rVyQZLhxHkaBGRtZCk8DRSD+ziawFuo63laTMw2ArE6JhjdmXt5s9SytoDfpRdKbuV55nEsTtjMXYpGcBSD7D2CgBmSCL9xYJ0wSdf2ccTk1lU15Fg+0XeOa57KvFR3eXWvSfdVp+1NAxS4WI2T6YVH7H6LDaR6hug+435SdmjtTQBxQs8lPypdNFOtnKobfbzGSLJdIXPgKtz/2zOmQFGVtO8oTXQY6shSa3jDyIAgnDEmIIOXPaGqA0QdJDNYsCmknZ4fyfhF5n0xDEEBXQRMp4HR5zr6YwNwoIFxsMsuIofMkkIpllHHAYw8tqhr1vOvppxruJoEvdz1I17lFog8ciqcSmyVce+nIf0mb4R4vz+GfOFWenikr7vOslmTzwIzV20+8rUKrJmGb0588LCtVGvEG+/t8uxJGr7PHVw4sVKA4N24k4ufWQSMquGXDRjzFxCvftakuflu74m8viSbPubA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(107886003)(6666004)(478600001)(6486002)(110136005)(31686004)(186003)(2616005)(8936002)(36756003)(6506007)(41300700001)(2906002)(5660300002)(53546011)(316002)(4326008)(66556008)(66946007)(6512007)(8676002)(66476007)(83380400001)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9pUkpEQU9CSXhaN284eitPL2JBZk03YXMvTXJZVlpuanR2K3lPc0pObVNt?=
 =?utf-8?B?N2QvNEpRTllVcnJMS3BVd2NSa1ppc3JaMlE3aDNub09SWnd2ZXhnVzFKV1dy?=
 =?utf-8?B?VWprYmlLeUY1Nm4wV0ZXdEkzVmduYjMwL2ZYT3ZhUXhMTk9wRWFRNmovYjd3?=
 =?utf-8?B?M1E4WGNKcm1OSThaOW1vL3l6MlhJb2U2Q2VXK2UyU1lsMVFiN1daZmxFN3p5?=
 =?utf-8?B?Ym1RdmZiOU1uQkxWTTlWcDFmS1l3Njk1NGhnanNPcTlNeUVzWE1waEREU1FV?=
 =?utf-8?B?LzI5SmNId0VuVmxuYWc0a3gwcm1uMmdpNjZZN2tQcyttV21XOXRjOWtqVHU5?=
 =?utf-8?B?ZVFicVNXWnlHVmladEN3YjhSdis2eFc4S3A1b3M2WEpIOW9EMDljb3JlUk9h?=
 =?utf-8?B?amtqSXlxU0VCVXNnTGw0MlgwcTdzVno1Y2J3bTd3aHV6dEt1NmxNbEVJdkQ0?=
 =?utf-8?B?Rkt0L01DenZtV0hXTFpaaTVmMXhPbDUyVHFoUjFFNmxTZkVTOFJFc1VZQjVh?=
 =?utf-8?B?bERBVUdNQWdRbHdOa1lsb3V2Q0htMkZSODB2NGFJYXQ5YmM0bldubzVDK2ta?=
 =?utf-8?B?SzdSbEZaNUpCeWw0MnIzK1FhZWJCQjlrQmRBblJwZVdzNWdaUllMTWtMNGh5?=
 =?utf-8?B?WmZnSlVvcFNJazJqR3h4alVVOS9jTXRjNzRlejdsKys1QWUrVVVjUkx5UVV5?=
 =?utf-8?B?N0t5V1dhS0M0UitaczlMb0FIN1VHcmkyQzIyeGR3THROaUdyd0NiVmVzUDNM?=
 =?utf-8?B?V2pvbVIveG5UU29IRkdORDh4b2s2Z2MrY1pzODZOQmcyR0pIbE8xL3I1bnlo?=
 =?utf-8?B?d01OTXdvYmlHWWZwMUZpdHQvWVdySWxHSkxmNVpaaS95aFcrZ042U0pUanA4?=
 =?utf-8?B?MDl5d05uaEV6a3V1RkFHS20wV1NpNjczTnhEWnpRTnJieEIzUXhGdmlINVFR?=
 =?utf-8?B?VzhCckk3Uy8rb3E4WjVWaHRlRkgxMGtIMWhFRDdnelZRQzNYa0VhQUsvV2c1?=
 =?utf-8?B?c1BlbDZYclpXN2xXS1A3U0MzOFRCU3lDTHNDdDlWV3RGZ1AyTHMybnBKSTlk?=
 =?utf-8?B?OWpmVmV4ZEVwenBvQmh0TXozRllIMUgrWCtlOEU4UmdqcGQxVEFSU0llOFlZ?=
 =?utf-8?B?a2U1M1RxQy9xRVhKWTQ3U3lid3UwOEdJcGpXNEtrQms3UFVGWEdPakpubDhK?=
 =?utf-8?B?NmNGRU5LQm8wNHJETGlvaEVEazZwSVZQOU90YytGdk5FSkNyemdDK1pyMitC?=
 =?utf-8?B?NXJNR2JwcHBtTkFHR240bXl1WGM1ampHYlRsaDVOR0o1N21RdlNwZ0UweGdP?=
 =?utf-8?B?Z0JKNFQ4clRwcG9WN0oySTNiRVRrOGFuTThBZU9YSFhEZUQwRDU4R01PQ3JW?=
 =?utf-8?B?OXBweGs0cGVtc1ByV3BvRTJDZXhNMUU5MGxCZ0NVZ3ZnTEVzN3c0YVpYclhS?=
 =?utf-8?B?ZkxOWXEvQUNJeUF3SDk1R2R6bXdjNUI1UUt2ZGh5NDJTbTZZQWFORWgxcFNl?=
 =?utf-8?B?bkJhWmNqUDk4Y3A1dWR5SW1OWXZveDl0RWJUTElBSENEZWVwZ1NBWUtLQzZH?=
 =?utf-8?B?cFp3NGM5cE4zYkFWc09Ka3ZBSXNBRE1XNVZLMCs3TXJLc0I2alMwMHM1eCtK?=
 =?utf-8?B?cUJBSnd3ckxIV3BYanFpZFhCTVFpcHBHM3E1YzlxVTRDcnYzVTg0OTFHb2ZU?=
 =?utf-8?B?SFAyekwrSllHUkFZNTRZMkRTNXpUOE10d3pubVU1WER5Z0NtcG5UeUlWWjlq?=
 =?utf-8?B?R3FLYWxRMjFwM1NuOE95cnMwU1ZWOHViSHBSQ2VLUGxPbWIxWEh6MnVDaiti?=
 =?utf-8?B?bEhxaEFBZW8rTnRWQXVPUTN3b1BlaG1RZ0RQMlArbGhaekxVZ2NEQ2drTG5T?=
 =?utf-8?B?QTZJci9wWXExc1lNVzJlR1NqaDN0dW90N3FkZDdrOTRuUTFuMVIwQldFeFdD?=
 =?utf-8?B?OCt2clltZEIyYUVzajJ4WDhBUk1LYVF5SnV5VitzVzVsV09abUcrNG5SK09U?=
 =?utf-8?B?ZjhiSFE3N2xYeU1IRzkvVTk3MWJzaDlaRnFzd1Y5THNCRUU3aEtCYjdtZVR0?=
 =?utf-8?B?bTNac0E5T095MjBvSWdHWG16djg3MVZTcDFQelIvYmNuRVFYc2NlZUdzdWVj?=
 =?utf-8?B?V0M4Rm5iZHhVQTVDV3JwZ3JjRXhEQWMvcDl0OVduVW5GY3kxc2tNcytkb0ZB?=
 =?utf-8?B?dlp0KzNlc1hGand6L2pDM1JMcnNFSnpCT2kvdzM2c3V6KzJER1hiK1h5WFdo?=
 =?utf-8?B?cEFtSzV1VFNXbnFoN1V0ZDFaVXB3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7307a1f3-905d-4700-3f3a-08dac6590092
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:57:59.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmpbh0++XosUf3If1kQKAs42Q4nCQcwmQpY7Zz8jaAXAwYZi4W8IwDz5zvQH+0Rb+RHUWOxaQ9AJXKZSb5vvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/11/2022 15:36, Jon Hunter wrote:
> 
> On 14/11/2022 14:23, Krzysztof Kozlowski wrote:
>> On 14/11/2022 15:09, Jon Hunter wrote:
>>> From: Vidya Sagar <vidyas@nvidia.com>
>>>
>>> Add support for ECAM aperture that is only supported for Tegra234
>>> devices.
>>>
>>> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>> Changes since V1:
>>> - Restricted the ECAM aperture to only Tegra234 devices that support it.
>>>
>>>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 76 +++++++++++++++----
>>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>>>   2 files changed, 62 insertions(+), 16 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml 
>>> b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> index 75da3e8eecb9..7ae0f37f5364 100644
>>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> @@ -27,21 +27,12 @@ properties:
>>>         - nvidia,tegra234-pcie
>>>     reg:
>>> -    items:
>>> -      - description: controller's application logic registers
>>> -      - description: configuration registers
>>> -      - description: iATU and DMA registers. This is where the iATU 
>>> (internal
>>> -          Address Translation Unit) registers of the PCIe core are made
>>> -          available for software access.
>>> -      - description: aperture where the Root Port's own configuration
>>> -          registers are available.
>>> +    minItems: 4
>>> +    maxItems: 5
>>>     reg-names:
>>> -    items:
>>> -      - const: appl
>>> -      - const: config
>>> -      - const: atu_dma
>>> -      - const: dbi
>>> +    minItems: 4
>>> +    maxItems: 5
>>>     interrupts:
>>>       items:
>>> @@ -202,6 +193,60 @@ properties:
>>>   allOf:
>>>     - $ref: /schemas/pci/snps,dw-pcie.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - nvidia,tegra194-pcie
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 4
>>> +          maxItems: 4
>>
>> How you wrote it, you do not need min/maxItems here, because you have
>> items below. However see further comment.
>>
>>> +          items:
>>> +            - description: controller's application logic registers
>>> +            - description: configuration registers
>>> +            - description: iATU and DMA registers. This is where the 
>>> iATU (internal
>>> +                Address Translation Unit) registers of the PCIe core 
>>> are made
>>> +                available for software access.
>>> +            - description: aperture where the Root Port's own 
>>> configuration
>>> +                registers are available.
>>> +        reg-names:
>>> +          items:
>>> +            - const: appl
>>> +            - const: config
>>> +            - const: atu_dma
>>> +            - const: dbi
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - nvidia,tegra234-pcie
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 5
>>> +          maxItems: 5
>>
>> Similar issue.
>>
>>> +          items:
>>> +            - description: controller's application logic registers
>>> +            - description: configuration registers
>>> +            - description: iATU and DMA registers. This is where the 
>>> iATU (internal
>>> +                Address Translation Unit) registers of the PCIe core 
>>> are made
>>> +                available for software access.
>>> +            - description: aperture where the Root Port's own 
>>> configuration
>>> +                registers are available.
>>> +            - description: aperture to access the configuration 
>>> space through ECAM.
>>
>> This is unnecessarily duplicated. You can keep the descriptions of items
>> and reg-names items in top level (with min 4 and max 5) and restrict
>> maxItems for 194 and minItems for 234 here.
> 
> 
> Yes I wondered if there was a good way to avoid duplication. It looks
> like I cannot have 'maxItems' and 'items' at the top-level, but
> obviously I can set 'maxItems' appropriately for each device.

Ah I get it. The 'items' list is defining the max. I have fixed up and 
sent out a new revision.

Jon

-- 
nvpublic
