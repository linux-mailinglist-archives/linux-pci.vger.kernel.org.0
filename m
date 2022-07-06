Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D93568607
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGFKqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiGFKqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 06:46:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C723BD1;
        Wed,  6 Jul 2022 03:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8dfLQdvx/GcbMMliCr6Z7vSNTlBzxMy13dwg7CTXYonVw90gb8+xsH+jXvQftN0vbl/4XeibGzs4dN7TwdMd29UKJSpJrNkmYHeFTh90eN/+OO0zzBdhPkU43ljOvmBOpyIxyhRzmxSXwYsd8WY2XUcnPSevblHb5prNfEoeYrVHpgxcb5DItbBzTSx+gjTr5qaxMjxQwI2lsS7B6e90J/ozJ0b+K5oyBcxZEPkB5UEpGL/VNrRstgOtRuwP1KSDuJL+bTT8kh1+y/VeqDFINy1b4lWenYoVMro8MJQYvCPhEHGqqWFpddLiIfDTwg/koH6YC7c+jyrXy/Qon5s5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAtwduuOIMhuVKmPno+RFZISlD/llPdaDsV55v/TcPs=;
 b=lSbmOTfCc/bOndD0VR+e2miEVRx389JdgOSycUPs1ojo6TwVlS7LldC4K0geJSmAjuA/qxPKkpjilEb5caZGEtOvYiT1CcvfCSkQURs66EakiRvbY4/YPiGTpYd9rbcWw4e1vBC2r3c8UyQGwdKm3YUZl+CssxEG3Xo6IsUB07cJtr9HEUcmV5VTzefjPi8j+fz0l09UeQkkJ2hcwXJn6BQoGdwJn45+KRXLXWCyiio0hy6Y36Ud6rwyvpXQTNIwp3vSpz5aJmbQE6R/wKFt+yMCmK6ggkAY/07psS2wz7zFtTzeFJmP6S1Urz6JEUpw95lK2xJS92MMaNHdZbkbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAtwduuOIMhuVKmPno+RFZISlD/llPdaDsV55v/TcPs=;
 b=uCsz8OHEHjd3NRRO7L881r0+VfQteP/PEi185g+Wp823IIGf34s+lvTCSpDKcsSNNjmlD0FIHLj6g8qa+jjrzTQv8Ro84YATj4NPEySu3hpi5YG8BBOEi9JcMPr2ViicsZ6TLcUQKXCiro6mkCMHk4vC/Ul7FnnciD0nwhBp5kNEFMJWmkhiqw8GM65LqG9s8YvGZa8dsVeuXsqmTEIHYj5PaaYAYW/vpMVMIuIbp93Wvc9tqR2GP7rPttLxn/DxumPPbTNIn6XLqSHVUJwuqk7rBh1RerwlkDIW2pTtxK933+T2tfCZhVsrb6blDXqGcg+IEMKUE88UGwjra1njjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 10:46:39 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 10:46:38 +0000
Message-ID: <398a9370-6c2d-319c-2e23-038588fbf004@nvidia.com>
Date:   Wed, 6 Jul 2022 16:16:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        vkoul@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-3-vidyas@nvidia.com>
 <20220630210449.GA3283899-robh@kernel.org>
 <e971a557-3387-efcf-87ec-983b998c5e93@nvidia.com>
 <2829e71b-1769-ce24-f810-d63e619aa5f0@linaro.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <2829e71b-1769-ce24-f810-d63e619aa5f0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::28) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b869752-65f3-4969-3a6d-08da5f3ccde5
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oS4Y57DwNUQpdIDhvrdgr+AR75PuO+E0fbSmx84tYGsqOz9uRES1QsqJ9dm2XAv5aJkaCvd/nIc3VrOf7igQNG/kKAAdLx1YUmHEuXA6NOpPHHXhUZr2newRypNKbJlgnG/mzU7yc+8DSQwtsq3CjyYrJ4OFqFELP7YMsAu25btZvPC2ndTS0flBvoOK4IgTu9+xgiRX0QDL+Q47RayhbEZxkmO19nFS9vRr0VL/fzmeaaSDfi4TynPF0t6W2Hs276eGMLUfIoOpbyBca76M45Y7k12+GYPZGxKFLphHfUMPXU4jmD+yCeLY6XWs18k4T4CiCewaGQDNPG4LseWt7h0eMgnVRVhq9IWFqQxculmTLKVB3I2jXrU+TT5ajaCcMJY65XrkS/mDX/yEAu4I7Sd2yKUDB199K3OR9Eha6P4rcbZiOGDh8MiDnH8+Tb0dgwNMe/IKlHNTpCka9S0QQmy0pvlxbhNVeXA10dKvplUm0bk45nb3skNo6C4Hv6VFzkPy6I1MHhuI0A03x0sdLYABBy9FidnvoS7feq6uCFLIARaIqkxhJVafUSd4QlGfKEgTXfKdU14KkM1i4zZw31dPKeX+op2vBd81dKqcYtolcu/8NftE21jhRUsGihiNFLvz99apQhXNwSZ1Go9hpFI1hlUBAXSid7qi6eNMoQmoR7CD/6tvhlpHxmBiyLPIAdoq9qaqB1u4G0AIG/dNtgO8l/HXavcZ74mk11qCrOLz9n8y+GEgNyYkCL+W/smDcg+cs9X0hEb/n3Ahsc3fjzAC6VWL56UXzeJ1raCL32eRpVMZKd7W1kj/A72neM7o8Rkw0rPlfRte3HXept6DmQdJRcw5kAZlpH7jePgXAUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(186003)(7416002)(26005)(6506007)(83380400001)(41300700001)(2906002)(6666004)(110136005)(53546011)(316002)(36756003)(31686004)(38100700002)(6486002)(8936002)(31696002)(107886003)(5660300002)(86362001)(2616005)(66556008)(478600001)(66946007)(6512007)(4326008)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNaQkhOTDdNeVFuWWVCY0JtM2dBdVZpd0lFYUFINHl3RkJVZWVyS3EzUGZL?=
 =?utf-8?B?eUEzVC9GTmhLcVo5aW5JWWt5TTlWUHc2cG9lZnY0OWE3TXNPM3gxOFZacTZW?=
 =?utf-8?B?MTRjUWVtUHJ3Mm5wZjI3WStxSk5mUUNPY3hRSUxNM1JQK1RXdmE4c3NIZTI2?=
 =?utf-8?B?elBhald4VFBZSXY3aTdndDBmdWZTK3d5MC9tWDU5bU85dlRBVGJNcldZSVln?=
 =?utf-8?B?cnBzRXZjRytWMDhINS92UWhJeHEwdVhmL0xSM1JpSEtFUzJVbWRjcTFtaTFS?=
 =?utf-8?B?VUdQeWhJa3VOUkNneHRSZjVRUzE5QVBGbWJVYTJiQ1VTYzVRNkt0Nk44SUt0?=
 =?utf-8?B?eDc4emNJTmUwY2ZGM2pYdWpRQWRPL2ExWXdINzg2Umo3UUdaL0JZQnFBS1Rm?=
 =?utf-8?B?cHFYa2gvbURndzFNRFU1WWRCNUwzZkxEUEhCQ29PTXh3YmhxZEs5VUUzdk9n?=
 =?utf-8?B?SDRnRjBUdnVHMHpkYWVSYXcxL1JYRHRYanpMSWh0SWVqUXkvV0dmM3hVZldl?=
 =?utf-8?B?NXVPMnJWRVMvZ2hqMnQzVzU5cHp4Rmc2TUsydFU2UU5JZU5zTTc0VmpYM2tP?=
 =?utf-8?B?Y2l4VVJ4eFYraThRcUJ1NVN6akhuNllmOUlFY3ZkelA0UEhvdEk1TTVaczd5?=
 =?utf-8?B?QzdVbWVPcEN2TmNNYkV2R21XZjMzQVpQaWEwMFR1MFVjR3kyM0x0eW0yVXgr?=
 =?utf-8?B?K21jeUsrSTlJYVhKSUduRXQ5V20wTGFFczQ3LytOb0U2bU9mQ0NpQnJjVHFI?=
 =?utf-8?B?K3Q5cXpzNnB4NDlZNzNqNXFrTXNMVExhbzFGSnJ1b2dSbTEyRXhienVYVmhK?=
 =?utf-8?B?SWQ4MXdlWUxWUm90UkFuS2R1TXZWN1VUMVNTMHYxWW5JZ2g3MkxUbmFGMVB5?=
 =?utf-8?B?OWcyUlVkdU5oWFcxRGdlRlowZm9HQkh0MFh5dXBiYUp1Y1NKaHBVWjhnNGpV?=
 =?utf-8?B?RVNYQzNobjcvL3ZUSVViYWRJbnRZejI5VkM2d1E3M0NNL0dHSXRzMHd0bGx4?=
 =?utf-8?B?UHdmd1RSUlhETmE5amFYbTF2UENLNkxOVVk2MXRHUDUxSFRFenBaWHVPYlMv?=
 =?utf-8?B?azNXZGdrUER3NHFISWNOWWwrU1NiejRIK1BOalc5YlZDNGpMdWJSdUwySkpz?=
 =?utf-8?B?TU1TZjFMZ0N1VFkzdHNuMWx3blNGMWFXMG1tMmVyWkU0V2g4d1RJcmlFY2Nq?=
 =?utf-8?B?bjIzV2JJYjE3cGllRFRQc0xpUEdhZzNRU1Z3ZzJaMWY0R2ZHZUgySVY2VmJy?=
 =?utf-8?B?QkJvYkRBQ1ZGakhBWllLYjREYjhNb2Mvb0ozNXZYaGdHSVl3T3dWZWZUWSs1?=
 =?utf-8?B?L1A3YWFqS2xVc3RCL3NxdEZONnFSdi9QbXZGSVpDRjBNejBNdXI0OFV6WC8v?=
 =?utf-8?B?OGQycDJqakVnajh1RlV1NFZsZk8xSVNMTXIvM3RzTGIzS3ZVSHhVQTRUTlVX?=
 =?utf-8?B?T2ZzWXlrMDNSL1RSSVZtM29McmxlZDVCY2tGY0hNbXJQcnorZ0RKdmV2ZXdS?=
 =?utf-8?B?Z0U2S2NKUXVScS9kaWpuZDhkN1I0SVJQTnBZclYzSE5rNjJWYXIwY01oVXNS?=
 =?utf-8?B?d0tUb2tQbEM4czhHdGlYa1FrSEtHVnVJS0RoQWhzNUU0V3BvU01KOUxWSjkx?=
 =?utf-8?B?bkZwaERXd002dWxYdXdVYkZ6SENkUGx1NDN1U0xiSTRvanBaU2Fjb2JEZnNx?=
 =?utf-8?B?S1A0cmV3R0w4dUlDUlMxR0NpaVIyNzVIejBsbUwzeEYxQm9QM0Fkc3NWaDRO?=
 =?utf-8?B?RDJlMTBXbWEvZ0VocHFNeGs5MGxzQy96MFFWSUc5NzM3amZTS3Nid2QxNmcw?=
 =?utf-8?B?RUNFNGxXQS9qT2FidVBwNDlHNjJBQlJSVmRlczBZNjl6Wis2VHJTa090eEJn?=
 =?utf-8?B?Rnpmc3M4YjR4anRGZ0QyZXlzZVZpMm5pK2FSOVhIMk0wUmloYUczeVgzcFFY?=
 =?utf-8?B?emc5Unh3Ui9UYjZuOW1MZUJkR0dCNmdzWnJKWTlLVVdESFhEOGF2VktKRTVL?=
 =?utf-8?B?OHBhcFlhRk9aOUJFc3BYV2F0a25KWWhoREFqWFh2YWk1T3A1T2p4VnR6TmRu?=
 =?utf-8?B?YXQrUGNub09JSlIrR1k4aTE1Y1VjSXB4K1pnMWlkK1Nrb0wvVFk4dDh5U1pv?=
 =?utf-8?Q?HWDE2c6u5/r7oJIQNTMZUOqwZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b869752-65f3-4969-3a6d-08da5f3ccde5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 10:46:38.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BKf+4TW1tB/Cma+ghUiASW3FglW6HiwC4GhMevWre9XgRbi+hKxZvFu8cJ+ScLNmlc7OFiRjmr1zc8WJqu+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/6/2022 3:36 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 06/07/2022 11:53, Vidya Sagar wrote:
>>>> +  nvidia,bpmp:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description: |
>>>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>>>> +      are the controller IDs for each controller:
>>>> +
>>>> +        0: C0
>>>> +        1: C1
>>>> +        2: C2
>>>> +        3: C3
>>>> +        4: C4
>>>> +        5: C5
>>>> +    items:
>>>> +      - items:
>>>> +          - minimum: 0
>>>> +            maximum: 0xffffffff
>>>
>>> That's already the limit. Just a description is fine.
>>>
>>>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
>>>
>>> maximum: 5
>>
>> Setting the maximum to '5' is resulting in the following error.
>>
>> pcie-ep@141a0000: nvidia,bpmp:0:0: 4294967295 is greater than the
>> maximum of 5
>>
>> Could you please help me understand why I'm seeing this error?
> 
> Trim your replies.
> 
> Why adding minimum:5 to the phandle? Rob said add a description. Nothing
> about minimum.

I'm sorry I didn't understand the review comment clearly.
There is one description added above already. Are you (and Rob) saying 
that one more description is needed?

Thanks,
Vidya Sagar


> 
> Best regards,
> Krzysztof
> 
