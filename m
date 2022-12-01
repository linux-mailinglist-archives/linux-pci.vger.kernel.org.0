Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9663ECC1
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 10:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiLAJof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Dec 2022 04:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiLAJoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Dec 2022 04:44:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639E89AFE;
        Thu,  1 Dec 2022 01:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfSYnhdI83CDMfCrrhGCAfIHqqFxjQqVSqKDPnHZ1JB9Lmn8Ji+pWzck5tEPqFLZWvNjt92MI7Vf4rGROvHaf3iuSv0TproJHs9n/bBN0ooRcg42Mp0X+GArgHJY/xSM6Y2Xq50k384xu5HJYWmBC0apWVdK2VAZ+pJYLydh0VJj4GkeLUEpzzuKl5I4V2/hrp0P2VhCmX50+QIxsEW5tmkqZOlYOgvuNRegQNPqFMBJdYFsxcFOWNir6y8qZNc1yyN+ULtJ2uzdN0/pOqKgknOTQTWwAfYQGO1KXyR30RFBclvwPSAfnpxaz4yhvrLFrgIZVTTqk33vttRKXJOOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDfQon3iaLndoknATPr+jYSRc0oe8sdiezR5qyqkCOw=;
 b=RJUqD1K7PJmZVYF//w1tvMzAouUE74lVkeMDWG+ML29yHfSG3baYY3avKsC9U82+kbnsXIriHN/xgcbhOdBQHNPsjHBx/xaulifzHoNil1PGrii301cqID0N2BkXcs4QKKLaPwol/XieF+JYsipvwSsQLBH7ppzOefNolWXx5rxEjagmQKsEoC4Hpd7ahU3E5h3mvEAdOBTlTqjCe9B/TmG6L6WMvToYfHDeTuKW2FPWjXVc/j6dZjf6P3+pgtv/eaI54JVKOYEmUdN2cJWGfo0bHD/+WeWoD8Yf5GXVCt5f7zb4iL6xMIQ9MV9+lvAiKW8cIQGF5ZuqF4WHMGyMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDfQon3iaLndoknATPr+jYSRc0oe8sdiezR5qyqkCOw=;
 b=U13PJ6aFnKlhPIKR4885kueLT3pZNVO5FJ2FZcxbUQ4uDurQU35Ap0iXJ9vcxMRdu9j23pck1e7w18TTias8tplroRIUVLJwbOtDVe4Z92mgliQjRTWyK+CSTu+AEuR2a5/oiSF0V4DP65Wy/o9o+EcGopGefioNNU3y+XrDfiHCC2bdy5jWJYdNzt+cAPjQEDq62HOjfTQlU5uM4q4fhOYx9R8ef9nIVzJzU67bQfwcZXMZ3duvlLJ0bHUaKtJV1KdzgIJnxFr2KJjML8QUIYWJWy3CUF2zMM06daeKiVBWYJ6swI3yyIcnigLfsBc3yKJRWfqOJM2j6Mj/8MdAxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 09:44:19 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 09:44:19 +0000
Message-ID: <1940f7ef-3119-59c6-0ddc-9498806766c9@nvidia.com>
Date:   Thu, 1 Dec 2022 09:44:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: tegra: Add uphy lane number and intr in p2u
 nodes
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, vkoul@kernel.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, vidyas@nvidia.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, nkristam@nvidia.com
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
 <20221124083510.3008139-3-mmaddireddy@nvidia.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221124083510.3008139-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcc909b-b2ed-4377-0d55-08dad3809d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yv8SSE5vw7cFGvTwqlSMjHFZHjw9ro+RIa73SzMAr0L9fDFgDcnygh/3AjmHv7TwfEuws+2qbtIKSFscZr1t01W4tydWwz5ffrJYLEYLDxwbbJdGK4wKdDnhthN08hRSQUoUMqf2Gv6fPIxMlRLJkmFjrP+2rPtCQPLG0uwDO7+k6sqcqpflMoxZCeYlYf22BFJ9zFCufrbjesupd+3uEJTDqQwBhJwa4s+iYUS0dFJPknCU6MXCWiqr5j3eIMb6mf65Dh+fjq0jUmrpkO/6dgRpPZvmv4DrPzyAu0tyhLbGIQZ4PmQXTaJ7kji3RFFGsTWfr+g3LWAHMlctJz1gNEYoqTbOqvUXCdCqs7ZJwYdVt3aZupoquntuGcs7rle5THKU14J1MsLLq0jik9675OT4xmzmSFiZjDXNEHuYh22ih1cU/oaSA4tu9l3j0EOtrwGokc9nNXaTXGyULePkcNe7asmLOX4Dg2fOkfuEOgra01r6ZAua7Zt6AohWNJ6yRQifj+9OI06U7jXpZxNPTe7z0cPDiRkgie1emPokGPxb0JnkNtHgZzLY6zY48h8J/WfdWEIbJZ8nm6zqYxLnwDaeu5zVfSTLNlww3Ks/4EZl9amGGf+gqr34tHDlaRF209cWov8speftoqmRPZNMA68thBBaQU/sPd5ejOwUkmOtbCyYo2ye7Sajw95p3VrSNxRZp1iNrSFhHAZR7pIu2idMgfAGDU2peng3aIuGDhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(7416002)(8936002)(66946007)(36756003)(38100700002)(66476007)(4326008)(107886003)(66556008)(41300700001)(4744005)(31696002)(86362001)(6506007)(55236004)(6512007)(6666004)(53546011)(6636002)(316002)(186003)(26005)(2616005)(6486002)(478600001)(8676002)(5660300002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEgxUXdkS2YwRHN3d2xVdFR1aXpPdkdTUDhNM1gzVVZaZlllMUJocWdIR21q?=
 =?utf-8?B?QUpCc3dDeG1NMnlJUjZpd0d1aDhvdjBlUHJmYlpadUJpZlF6UkFncjBvUExx?=
 =?utf-8?B?ektTamE0RHJHb3N1ejN5VVBXcjRraytrNU1SVDN0TS9OcUhtR2s0NVl4bWdZ?=
 =?utf-8?B?d2xzbGpOeFFsalFET0NWNVJLOEt0WmRtU3QybWZYQ2k5d1VYcFBKZVZyRzJS?=
 =?utf-8?B?ZW1nQkI5Vy9zOGt4azZqK0xTSTFuaWVCaS9EaVRHZ0lVQXRNRnR0cWZOWjI5?=
 =?utf-8?B?WmpLRk1LUGVGM1hlSFRyVUZPMmp0bGpSSlN1Q25EaFVKMHRkcXh4SmVaVWlv?=
 =?utf-8?B?eXJKanNsRWNQbnRjWEMvMlNTdlYvOGMzanYzZnlKWXpBUCt6SUVoaWJ2VXEr?=
 =?utf-8?B?RU5lUmlPNmV1TElYWGhqZWUwaldzdFIwZnFZRVNUMFJmYjV3ZzJzSTBVd2dT?=
 =?utf-8?B?Nkg4OHlrV0tOb3VQZGVPclc3Vm1pSko5T29zYTJja0xRTFEyVnU1eEpEa2Y4?=
 =?utf-8?B?U3FjenRhRmwzS2x4SFkxV3VZcG5LUzRJWFl4MlBla1Q1RUNiN2tWNW5WZ1Yy?=
 =?utf-8?B?a3NxVjZFb05yMG4vYkE2Z1NmMEJ6UlJOQllOc2oyVmpITXZXUnByQmhVTld1?=
 =?utf-8?B?YmRRMm9ETWFZRndCQTFvSEZoRktGNGZ2L24xY1FCdG5JRzFRaU5UNytUUTQ3?=
 =?utf-8?B?MVU2ZGNpY0ZIQTd6ZDRzekVpaFhFcEg4WmpobVNFbzk1anhTbk5UdXFrNkhW?=
 =?utf-8?B?cFdpd2YwNUpwWm5Eem5mR0lONzJuQUM4bHdvdWpDejJ0dWtyTDNxS2J5d1NW?=
 =?utf-8?B?ZVp2QzVrdXFSWTVqYXR0REJyNDFubERnWWdoSzgvZGJUb1BJYjJiTzVmRmxQ?=
 =?utf-8?B?eTVDTGhNdnBBUng3aVFFbG1OYUsvOFoyN0Zvd2FuaW9mV1VCczVoWkNwdzhC?=
 =?utf-8?B?UDcyOXVvTXlndlNOL3VPZWJNK2swY3AxY0tIWTRyTS8yTHdwai9QTmVJYyth?=
 =?utf-8?B?dThKeWIvTlMyZkZZbHR5bGdnUUJ2Z2dabk05N0ZCUnNEYTdtRkhvNDRhWVVw?=
 =?utf-8?B?UnJNcGhpdExNZ2x6ZFJwVnU4NDBTaTlYemNaVGVaUDJKNWR1aE5NMDJoNHpP?=
 =?utf-8?B?dnZBQlNhS2x6UzhBM0ZaL1B6MHB5UmdUU3dYUGIxY1hYNWZjWXZFM0l6Ykxj?=
 =?utf-8?B?K2RuWjExVDZJV09leUN0bnFBUXN6M1VDL0VMTXN1dGFHbW9WWkRxejVKNER1?=
 =?utf-8?B?T0R0NWVMVnFpVmp2cnMrVXdPMHZ2aDMwb003TkpnOWlMVWR0N3BuOUhzZFhj?=
 =?utf-8?B?RlVHSHppM01zSXowOU80My9xY2FSQmVJOHNrQmVFM3V2NDNuTWtZdktCZkFy?=
 =?utf-8?B?alNvYnIwOWtTTFA0VG9TbkEvMDEvaHlONllzeE9BLzFNOSs5VTBUR0VySlk4?=
 =?utf-8?B?NTRxaUl4L1NvUHdrUUxjbXF0WktXQTF0d21UTzRnZTRZRnRhVVRsZTFnM0p1?=
 =?utf-8?B?cm5vd21SL014VlNQdG84Z09ISzJmbGFxaHA5RWppeWxXYm9zcXJVR09oS2ln?=
 =?utf-8?B?S2pxd1Yyb2hQY0FoajZEb1R2amdkTmp5MjRucmlRb0QvVUN1Wnd5SzM1UTA0?=
 =?utf-8?B?VmNoL0owRU5GVVZUaFdWcG1HQ0pMUXlONVhIT01RMytVWWRQajJXMTlpOUoy?=
 =?utf-8?B?MHNNb2RydkVVNjFiM1BYNldENCsrdEZzWUxxTDNhVis4YlVjVkJPVDQwOGov?=
 =?utf-8?B?cGVxbVVWQWRnNXpQQVBtWkJwWmtYbjhuOGJ2RTczbWRVM090TlNmUDBWT1Vs?=
 =?utf-8?B?QjBrYlJDMGM1RDdGc283bmxuTnV6WS9palhFdVdWMXhGY2lQZXNVZ1I3eGNh?=
 =?utf-8?B?T0tiTDEwc3hPa1pJWnNGbVVRbjJmckJFRjZ2SnJmMTNOcHVmWG5tNmJPS0Fw?=
 =?utf-8?B?dmJ4dk9RcVFhK3JDajJRck04SmtjcHdrOVplS3JlRmZuYjZjL01lb1BxWVNQ?=
 =?utf-8?B?UThzekk0QmErTVlWdE8vUUdUNmQ3T3UzNWcxa2d5WmYwK01WeHA2OWdQZGFn?=
 =?utf-8?B?RVlSaGtOYmxpeFpiOUpJL0dnVDd3V0tQbFBPMlY1Vnh5SWNIYS9WMkhOajRv?=
 =?utf-8?Q?2dvn1SEPGNuL9t+xY5yCbQ1cE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc909b-b2ed-4377-0d55-08dad3809d5b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 09:44:19.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCeaTebU0n8XH/yapINM6edDUa/JELJ36lak7lE8FizzI0VbNDJICKPhtvU/zlAmn8hXpLEcyJLlYTu7BI8dsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 24/11/2022 08:35, Manikanta Maddireddy wrote:
> UPHY lane number is required to exchange lane margin data between P2U
> and UPHY. Add uphy lane number in p2u device tree nodes.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 120 +++++++++++++++++++++++
>   1 file changed, 120 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index eaf05ee9acd1..ec8a28a9d380 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -1109,6 +1109,11 @@ p2u_hsio_0: phy@3e00000 {
>   			reg = <0x03e00000 0x10000>;
>   			reg-names = "ctl";
>   
> +			interrupts = <0 336 0x04>;


Please use definitions and don't hard-code the values apart from the 
interrupt number.

Jon

-- 
nvpublic
