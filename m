Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B0568459
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiGFJvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiGFJvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 05:51:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E23237E2;
        Wed,  6 Jul 2022 02:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b80lmijAp7a8Yaa4gt1Cp4SflvV0p7rsWV4LiR/fXaMpEPW/Ru/SCXiurXh8rlge6ov/q7VYBC6IPxRK5qzZDUmbXWoIGB2VQYydHsdx26ME9yW4ZJwGRiVuKvOcckQaKsVU6iX5ajNPGKikea3PW68iN9+yoBPa1l/uEKnrpj2bx7pO0d6YOBMHWxGi1z+97o9hTbhg8CTy2iQ3ND0jARvF+3q+ur6jqq7/Ag//wSbszaEuyIGejo5mERkh+EXoyyYLtg+LJB4ItyuUMHn8vRce+le0HX6gr5+/KAnIOHEyb0GjVdATHEUeftPtJHbIQnLKKktwxgRkgguG9ufqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfHtU0ztxh/BR0dFXIjKg9omMQTZIJ8yZ7VoeSWhJnA=;
 b=MR1sNqzs4acAKvXZSFYrMonykaqrPXob37I8k69gDvxvoM6qO2PJ20yGdlfHMtmkrU7d6Fz5ToE1DPvrJBDpUfg6DhlohZDoaeSoWg4GBM2ePdPve2qK2NnzOf9x9zDxo2ADDHbtqxx77UWHsd4hGysa4NMS9KYMJ6L3++VTK3iU8VQ+LDDzU22ZnZnKskjWDlCCShG75tC341dEhFBUu1OMtcO3DkOvY6shuwqyxmb0ANV0d20n4DYgz7MBJU+NqGTtBQkKQ70BvGmY5kFt9foTDBN9OC9GHeidBjlrJq1EbZiTumyPkl04jtHZKFQa3cNkpyHRlJrNvQvPee5DHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfHtU0ztxh/BR0dFXIjKg9omMQTZIJ8yZ7VoeSWhJnA=;
 b=Tpj3Aw0eRsLiiZ7x6gQNuS5SRMpEJWXnf6pNnHMIWAnZSIPKLNOIWuTMAXm91wbB+OssmOEm/ZVamLbH+enV/hG/gQH4r+/k0p7R7vmrop4CTDNfuLsywf8zHJJMHfoJaYnidaqm5RF/doW2D7vCkXLsqqPW7mh1GuJQPf1JBbQmujR4cMDuqkLMWs6eZ5kz3U2k+9mFqVny8QGzHMQQFarZ11oZnzkzEWVxY8hBYGuOlrloL9dqeCE8ArnEZJtvZKKDb9hd2/pTDRsCwnusuE6W/aGgjQwe7sSusp7b17mtWJ/zKureCUf8rn7vclY9SBk4HpJFFslf2mlmkSHOCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3102.namprd12.prod.outlook.com (2603:10b6:208:c6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 09:51:45 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::3904:2c16:b3b7:c5f3%5]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 09:51:45 +0000
Message-ID: <3e21dbaa-b478-5713-5355-319d2843167f@nvidia.com>
Date:   Wed, 6 Jul 2022 15:21:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     kishon@ti.com, vkoul@kernel.org, kw@linux.com,
        p.zabel@pengutronix.de, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-3-vidyas@nvidia.com>
 <cab66a0d-18d1-77ba-c0ac-06f802874c0a@linaro.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <cab66a0d-18d1-77ba-c0ac-06f802874c0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::23) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536c5cea-609b-427e-fb1e-08da5f3522a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0JHcU1LZi9uRjdKbk10bk40SGdDc3paNThCdG9SRHR4RVgwV2QvM0R5NzB4?=
 =?utf-8?B?dVMxd1NPajMwOFRBbzlBa0dRank5bmM3UzV0MHNjRkwzdzNXd3FiS3RJWExM?=
 =?utf-8?B?TGFqejVGT1Fod0dVUWpXMlhNWlFJSlVTMXBzbUo1aU1mSUVXajEvZ0V5UFdr?=
 =?utf-8?B?V2RLRWdnajJvNzdVbXloR055YVY0b0xUOEdZR1lkMjNRZTZOUWFkTmhZV29Z?=
 =?utf-8?B?aWhNWGEvZ0dONG5ySnduUk04ZTRUR25MN0pySFRGUEZFaTZHbE9HeGhtYytH?=
 =?utf-8?B?bEFnV0FZZEdsaWlpd2NCT254YTduTzU2VnFDK3gxWXppaG9vNXQ5QnRYRTgr?=
 =?utf-8?B?NVdYdFZCSytDbjJobUtsaXVmajFSWWE5TXo3VzN1RzI0MlNlRGFENXBEQ0FV?=
 =?utf-8?B?YkVzOGNiRUlONTFQVHFYdWtXaFVMdGErdDJ1aGJWL2V6ZUZLeE8vMkVsTEZs?=
 =?utf-8?B?c2RaRUpNN0VtZEFVSlNTSFppM1ROL0g4QmlBWGFreHZOWHE1Z2ZYR0NqZlli?=
 =?utf-8?B?TEdTUGpjdCthak91QmJxdFpDMFhDZThFTXBVRVZiaWxPaVdMVi9kWXJoaDZv?=
 =?utf-8?B?NHRBN09reXBtUUZPRTlCWmVSY1l2cVhBWjNEdGdaRHNXZ2ZBcTFEZ3kzWWU4?=
 =?utf-8?B?Z1h5aG1FU0xaeVpWRXFnbDQvN2V5ckx0UDJLUUJrNGlFRVo1cHJKT3YwMitm?=
 =?utf-8?B?WFh5VGxZVENxU1gwVXhXWUZvVU5YT1V1Y1UzSTd0ZTB3cnRlbnZidTd5bGJa?=
 =?utf-8?B?R0owMUFiQ1FuZ2ppOTV1K3pDZmN0aitSWjhBNGlNWS92bHZCY2NKOXZxR3Ro?=
 =?utf-8?B?MXRuTy9EOE5hNHFZUTgzYlVJMTBZSVUweWJKRE53UzhSWUVYaHpKN3lsUTMz?=
 =?utf-8?B?N2pDSUdQZzlDQVZod3JFYTUxbVV6ZEdjMTllT014RlJsQ1pnMEUzck5WV2xk?=
 =?utf-8?B?eHQwZnZQUGNKRjhqcmZoSXhRaDlSMWRKT3lNeXBGU1Q1YzJSdFJPaVJpaWNm?=
 =?utf-8?B?RC9NQ3ovK1B1ZTUwL1Jvdk4rKzhQTVY5VGtNSlBuMHloYnVJcVYxZ3dJTUFw?=
 =?utf-8?B?aW42MW12L3Q2S0Z6czFwa0lkQlpBcXEzMHRoNHZ6SnN0c05Qd0RtZTdjcTF1?=
 =?utf-8?B?enhvOU9ESGtEOEs2Y3NuWnhrL0hwN2k1M1hFK2RCMUs3MWM0Sjlrd1pBYm55?=
 =?utf-8?B?b1hzSEttRVRJTTBFTDJiWkZJTnpxSkxURER3QlBGOUl2MTAxT3NQU0dUek5E?=
 =?utf-8?B?QmQ5Z3p3OEtoWFZyNkl0RXBSTXAreEt2aEE4MjNUS2huZFo4SjdxZ2ttajlm?=
 =?utf-8?Q?cGyQkYjGaBYmZYM0KQZZ7k1GfO6vqi8hq9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(66946007)(83380400001)(2906002)(36756003)(31686004)(8676002)(66556008)(66476007)(2616005)(6506007)(4326008)(186003)(6666004)(107886003)(38100700002)(316002)(6486002)(30864003)(6512007)(26005)(966005)(7416002)(478600001)(41300700001)(6636002)(8936002)(53546011)(31696002)(86362001)(5660300002)(76704002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0o1eHViYStOanBSQ2s5U1lwTEpsRUV0RDArL3hIWVpyRU84VS9oRXp0SzRT?=
 =?utf-8?B?Wm1vQVlvak1qa2lKN1dGNG5wbjB0bGk2OGhieXlxeitFSkJ6U0lGQ3ZQQzVL?=
 =?utf-8?B?UVlyb0RTYVR5ZG5mc2xOMTV2S0ltcVRjeFd6Zko0MkNXWXp0c1czdlRFbFpL?=
 =?utf-8?B?d2ZqRjBOdWE4MlZLWFROTFRWK2gxSnA1NEVaWXRHcS81ZXV4UUZjcjNRT3R5?=
 =?utf-8?B?bUNUa2NSS2xSZjZPMkorWTBOeGhlaHRiTnFHYXFDL1V6RE04eWxuaThvTlQy?=
 =?utf-8?B?SzhObmZYRFFTbTBjN1h6UDhrOXp4NUV5bFVTWEdvVGN3YlFaN1JoZmlTYUtB?=
 =?utf-8?B?QlNsODhRNEh3WjBBUUxCai8vYkwwZ2hEbTMwdnJNUmdCSEtOUDBPTHk0Y0Uz?=
 =?utf-8?B?RjlhdXgyaDd5ejJDczJJV0pDYUN1OHFZQ25rWFVMaHAxM2JEVTRCN21scXF3?=
 =?utf-8?B?aGlPUVRhR3RBazR0MldDSVNnVlFWVk5IUFB2Mm1DMlErQTFXVU53QXppYnVV?=
 =?utf-8?B?aHNJM1gva2x5aGlRaFFTN3dQbEdpL1ljZmlPdHVQWmtWUFJaZitEbzQvVDJL?=
 =?utf-8?B?a3lib2ZLS1lWeS9LcFdyL011bjhQUkVYU2FmZ3hwb0RXbWZ3ems4UUtDOWht?=
 =?utf-8?B?ZmhlR3pxelB3STJZVHF6OExhMXdhU0tENHFRRFZCMlYyR3RYT0ZvT1F6RGxk?=
 =?utf-8?B?d3RhR1B4RE83T0s3ZENqeFkxbDBOa2YwVyt6TXMyMzVaU205aVh2Sno1Qm11?=
 =?utf-8?B?bDFodjdjeW50SFV6VEdiUTJ4TUpLNGFKYTBoNVZOREFTc0cxMUdlSHFyYjJr?=
 =?utf-8?B?OHhrbTVJUVlEMnlGTnlHeUVtS25ETU5FWEpjRHRzdVRtVFhxM3NxN25ScUtS?=
 =?utf-8?B?eHBncUFJcDU4aFE0K0IwemRMOEI5VVZob3BDUmxjV3pyVFh4Y1Fab3UreFFj?=
 =?utf-8?B?QVNLR1RGYXlFTkpmUzVKOVJLYnU4WEREZEJCOW96R2FIRDV6eFh6QzM1NWJw?=
 =?utf-8?B?NHBXMUI3ZWZlTDE0Q3ZuUU1QaTdSSzdKbHBIQmZaejRRWWlFZDBRR001Z3dQ?=
 =?utf-8?B?TXlFcy82SmNZQXp5QndEUWZqd1hGZkk2OXhkRjBxYTZmOHpJb3pSOUFyMnIv?=
 =?utf-8?B?STY4YlRUMTAyVk5jZDNtR1dxZVZULzZ2dTlISGxuTnVmKzQrTmE2VzJyMGU0?=
 =?utf-8?B?ZWZsVnpjRHordGxjcUxreXBScDQvcEVqQjBjSVJ1a1F5V0dJdU01VHhZM3lj?=
 =?utf-8?B?ZUIraE55MEs5VXpNV056L0VXK3BPUmE5UGVqeUtORkJYNDgyYmFQT2d5eU04?=
 =?utf-8?B?YkhQVllycFpHR284WVFkbjFCbUttaHVwNVcrNmpzeDhIakVJMlRMWVJDOTN5?=
 =?utf-8?B?WDlCYVNrdHA3RlI0V3RhMTFCa2V0TGRaSTBhL28yVk1ka3BqK3Y4NnczT1Fo?=
 =?utf-8?B?OHhDTjNDL1IzVkd1UzVERkFmcXRFWFNIajRiTFZ0SnJZckJNTEgrcDVpaE00?=
 =?utf-8?B?VCtWM29VTXU1YlZFekRGdkRIM0dvUWZMWVMzZHhqRm9tU294TWhhd2NRRExw?=
 =?utf-8?B?bHcxSUw4bU5hUkVpb0o2UlFNZEFSTDVCVTQ3K0o0RUhQVjRTOTViN2xFNlRR?=
 =?utf-8?B?ck9MNjA2UDhHSVNxbEdIUlhNazAvYUFJSnBuRWlyOHZSc3d6NkFFSlRybnlm?=
 =?utf-8?B?M0g4VGdObGR2YU5LVWY1alhRdHRuWWEvUFdkYkdoZ3dYZmtjcy9xN20xeG9k?=
 =?utf-8?B?cHZDUjZkY1NQYUQ0UjlEbXBJTVpDV2FQbnZ4Ykt3K3dTeWJBbjhDOXZ4ZmdO?=
 =?utf-8?B?ZDc5UjJJdnc0aWZwM3NtMjZJcVJhV3FjNmZ6SHdORXE1Y0MvNkVFSUEzZ1Qy?=
 =?utf-8?B?cWZDZmpRMUY3S3Z4bm9RTThrY0N3Rlc3dkd3eTFBSVVad0JhUmVCamN2dXcw?=
 =?utf-8?B?QnN0aUlxOTlOUGpRUEg4c3RUbE5sRjlEcm00ZENKRnRHY01IZUxMR3Q5bVlN?=
 =?utf-8?B?L0JkSVVmNjhnU29hZE5RaEtocURFK2VGaWVtK1FlVG1zeWE3eEJPUzBmU3Mz?=
 =?utf-8?B?czQvc3NkTmJJdlozNlRycUZCV2hqcTc3Z1VyNklsYWFJK1dSd2JUSTZwU1gy?=
 =?utf-8?Q?WM0yF6Oc0a0h6QCxyJ46Uzvmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536c5cea-609b-427e-fb1e-08da5f3522a1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:51:44.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HwMS7F3CjpY8VcwFVDqHTGo4e1iGa0ypxJ2f3078x5ljbU6JEBDCO0tz0pnn1slTeD4Ve8mZDYS9Sqb5ffnmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3102
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



On 6/29/2022 11:59 AM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 29/06/2022 08:04, Vidya Sagar wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Convert the Tegra194 PCIe bindings from the free-form text format to
>> json-schema.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V3:
>> * New patch in this series. Added as part of addressing Rob's review
>>    comment to convert the existing .txt file to .yaml schema
> 
> You need to rebase on newer tree (judging by address list). Changes on
> some old kernel are not accepted.
> 
>>
>>   .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 239 ++++++++++++++++
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----------------
>>   .../bindings/pci/nvidia,tegra194-pcie.yaml    | 254 ++++++++++++++++++
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
>>   4 files changed, 494 insertions(+), 246 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> new file mode 100644
>> index 000000000000..4f7cb7fe378e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>> @@ -0,0 +1,239 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie-ep.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra194 (and later) PCIe endpoint controller (Synopsys DesignWare Core based)
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Vidya Sagar <vidyas@nvidia.com>
>> +
>> +description: |
>> +  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
>> +  properties defined in snps,dw-pcie-ep.yaml. Some of the controller instances are dual mode where
>> +  in they can work either in root port mode or endpoint mode but one at a time.
> 
> Wrap according to Linux coding style, so at 80 character.
> 
>> +
>> +  On Tegra194, controllers C0, C4 and C5 support endpoint mode.
>> +
>> +  Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to operate in the
>> +  endpoint mode because of the way the platform is designed.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-pcie-ep
>> +
>> +  reg:
>> +    items:
>> +      - description: controller's application logic registers
>> +      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
>> +          Unit) registers of the PCIe core are made available for software access.
>> +      - description: The aperture where the root port's own configuration registers are available.
>> +      - description: Aperture used to map the remote root-complex' address space.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: appl
>> +      - const: atu_dma
>> +      - const: dbi
>> +      - const: addr_space
>> +
>> +  interrupts:
>> +    items:
>> +      - description: controller interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: intr
>> +
>> +  clocks:
>> +    items:
>> +      - description: module clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +
>> +  resets:
>> +    items:
>> +      - description: APB bus interface reset
>> +      - description: module reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: apb
>> +      - const: core
>> +
>> +  reset-gpios:
>> +    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used as
>> +      PERST input signal. Please refer to pci.txt document.
>> +
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 16
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    maxItems: 16
>> +    items:
>> +      pattern: "^p2u-[0-9]+$"
> 
> No, because this allows any/unspecified order. Please list the items, so
> the order is fixed.

Not all controllers are going to have all of them specified. Number of
these entries depend on the number of lanes assigned to that particular 
controller. In this scenario, I thought specifying it using 'pattern' 
should be fine. Please let me know if there is any other better way to 
specify this.

> 
>> +
>> +  power-domains:
> 
> maxItems: 1
> 
>> +    description: |
>> +      A phandle to the node that controls power to the respective PCIe controller and a specifier
>> +      name for the PCIe controller. Following are the specifiers for the different PCIe
>> +      controllers:
>> +
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> 
> No need to list contents of the header file.
> 
>> +
>> +      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
>> +
>> +  interconnects:
>> +    items:
>> +      - description: memory read client
>> +      - description: memory write client
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: dma-mem # read
>> +      - const: write
>> +
>> +  dma-coherent: true
>> +
>> +  num-ib-windows:
>> +    description: number of inbound address translation windows
>> +    maxItems: 1
>> +    deprecated: true
> 
> This property was not in old bindings and you did not mention any
> changes done during conversion.
> 
>> +
>> +  num-ob-windows:
>> +    description: number of outbound address translation windows
>> +    maxItems: 1
>> +    deprecated: true
> 
> The same.
> 
>> +
>> +  nvidia,bpmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>> +      are the controller IDs for each controller:
>> +
>> +        0: C0
>> +        1: C1
>> +        2: C2
>> +        3: C3
>> +        4: C4
>> +        5: C5
>> +    items:
>> +      - items:
>> +          - minimum: 0
>> +            maximum: 0xffffffff
>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
>> +
>> +  nvidia,aspm-cmrt-us:
>> +    description: Common Mode Restore Time for proper operation of ASPM to be specified in
>> +      microseconds
>> +
>> +  nvidia,aspm-pwr-on-t-us:
>> +    description: Power On time for proper operation of ASPM to be specified in microseconds
>> +
>> +  nvidia,aspm-l0s-entrance-latency-us:
>> +    description: ASPM L0s entrance latency to be specified in microseconds
>> +
>> +  vddio-pex-ctl-supply:
>> +    description: A phandle to the regulator supply for PCIe side band signals.
>> +
>> +  nvidia,refclk-select-gpios:
>> +    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used to
>> +      enable REFCLK to controller from host
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> No need for ref. But you need maxItems.
> 
>> +
>> +allOf:
>> +  - $ref: "/schemas/pci/pci-ep.yaml#"
> 
> No need for quotes.
> 
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - num-ib-windows
>> +  - num-ob-windows
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - power-domains
>> +  - reset-gpios
>> +  - num-lanes
>> +  - phys
>> +  - phy-names
>> +  - nvidia,bpmp
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra194-clock.h>
>> +    #include <dt-bindings/gpio/tegra194-gpio.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/tegra194-powergate.h>
>> +    #include <dt-bindings/reset/tegra194-reset.h>
>> +
>> +    bus@0 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0x0 0x0 0x0 0x8 0x0>;
>> +
>> +        pcie-ep@141a0000 {
>> +            compatible = "nvidia,tegra194-pcie-ep";
>> +            reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
>> +                  <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
>> +                  <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
>> +                  <0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
>> +            reg-names = "appl", "atu_dma", "dbi", "addr_space";
>> +            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
>> +            interrupt-names = "intr";
>> +
>> +            clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
>> +            clock-names = "core";
>> +
>> +            resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +                     <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +            reset-names = "apb", "core";
>> +
>> +            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&clkreq_c5_bi_dir_state>;
>> +
>> +            nvidia,bpmp = <&bpmp 5>;
>> +
>> +            nvidia,aspm-cmrt-us = <60>;
>> +            nvidia,aspm-pwr-on-t-us = <20>;
>> +            nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +            vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +            reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
>> +
>> +            nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
>> +                                          GPIO_ACTIVE_HIGH>;
>> +
>> +            num-lanes = <8>;
>> +            num-ib-windows = <2>;
>> +            num-ob-windows = <8>;
> 
> Skip deprecated properties from example.
> 
>> +
>> +            phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>> +                   <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>> +                   <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>> +
>> +            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
>> +                        "p2u-5", "p2u-6", "p2u-7";
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> deleted file mode 100644
>> index 8e4f9bfb316d..000000000000
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> +++ /dev/null
>> @@ -1,245 +0,0 @@
>> -NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> -
>> -This PCIe controller is based on the Synopsis Designware PCIe IP
>> -and thus inherits all the common properties defined in snps,dw-pcie.yaml and
>> -snps,dw-pcie-ep.yaml.
>> -Some of the controller instances are dual mode where in they can work either
>> -in root port mode or endpoint mode but one at a time.
>> -
>> -Required properties:
>> -- power-domains: A phandle to the node that controls power to the respective
>> -  PCIe controller and a specifier name for the PCIe controller. Following are
>> -  the specifiers for the different PCIe controllers
>> -    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> -    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> -    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> -    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> -  these specifiers are defined in
>> -  "include/dt-bindings/power/tegra194-powergate.h" file.
>> -- reg: A list of physical base address and length pairs for each set of
>> -  controller registers. Must contain an entry for each entry in the reg-names
>> -  property.
>> -- reg-names: Must include the following entries:
>> -  "appl": Controller's application logic registers
>> -  "config": As per the definition in snps,dw-pcie.yaml
>> -  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> -             Translation Unit) registers of the PCIe core are made available
>> -             for SW access.
>> -  "dbi": The aperture where root port's own configuration registers are
>> -         available
>> -- interrupts: A list of interrupt outputs of the controller. Must contain an
>> -  entry for each entry in the interrupt-names property.
>> -- interrupt-names: Must include the following entries:
>> -  "intr": The Tegra interrupt that is asserted for controller interrupts
>> -- clocks: Must contain an entry for each entry in clock-names.
>> -  See ../clocks/clock-bindings.txt for details.
>> -- clock-names: Must include the following entries:
>> -  - core
>> -- resets: Must contain an entry for each entry in reset-names.
>> -  See ../reset/reset.txt for details.
>> -- reset-names: Must include the following entries:
>> -  - apb
>> -  - core
>> -- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> -- phy-names: Must include an entry for each active lane.
>> -  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> -- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
>> -  by controller-id. Following are the controller ids for each controller.
>> -    0: C0
>> -    1: C1
>> -    2: C2
>> -    3: C3
>> -    4: C4
>> -    5: C5
>> -- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> -
>> -RC mode:
>> -- compatible: Tegra19x must contain  "nvidia,tegra194-pcie"
>> -- device_type: Must be "pci" for RC mode
>> -- interrupt-names: Must include the following entries:
>> -  "msi": The Tegra interrupt that is asserted when an MSI is received
>> -- bus-range: Range of bus numbers associated with this controller
>> -- #address-cells: Address representation for root ports (must be 3)
>> -  - cell 0 specifies the bus and device numbers of the root port:
>> -    [23:16]: bus number
>> -    [15:11]: device number
>> -  - cell 1 denotes the upper 32 address bits and should be 0
>> -  - cell 2 contains the lower 32 address bits and is used to translate to the
>> -    CPU address space
>> -- #size-cells: Size representation for root ports (must be 2)
>> -- ranges: Describes the translation of addresses for root ports and standard
>> -  PCI regions. The entries must be 7 cells each, where the first three cells
>> -  correspond to the address as described for the #address-cells property
>> -  above, the fourth and fifth cells are for the physical CPU address to
>> -  translate to and the sixth and seventh cells are as described for the
>> -  #size-cells property above.
>> -  - Entries setup the mapping for the standard I/O, memory and
>> -    prefetchable PCI regions. The first cell determines the type of region
>> -    that is setup:
>> -    - 0x81000000: I/O memory region
>> -    - 0x82000000: non-prefetchable memory region
>> -    - 0xc2000000: prefetchable memory region
>> -  Please refer to the standard PCI bus binding document for a more detailed
>> -  explanation.
>> -- #interrupt-cells: Size representation for interrupts (must be 1)
>> -- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>> -  Please refer to the standard PCI bus binding document for a more detailed
>> -  explanation.
>> -
>> -EP mode:
>> -In Tegra194, Only controllers C0, C4 & C5 support EP mode.
>> -- compatible: Tegra19x must contain "nvidia,tegra194-pcie-ep"
>> -- reg-names: Must include the following entries:
>> -  "addr_space": Used to map remote RC address space
>> -- reset-gpios: Must contain a phandle to a GPIO controller followed by
>> -  GPIO that is being used as PERST input signal. Please refer to pci.txt
>> -  document.
>> -
>> -Optional properties:
>> -- pinctrl-names: A list of pinctrl state names.
>> -  It is mandatory for C5 controller and optional for other controllers.
>> -  - "default": Configures PCIe I/O for proper operation.
>> -- pinctrl-0: phandle for the 'default' state of pin configuration.
>> -  It is mandatory for C5 controller and optional for other controllers.
>> -- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
>> -- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
>> -    improve performance when a platform is designed in such a way that it
>> -    satisfies at least one of the following conditions thereby enabling root
>> -    port to exchange optimum number of FC (Flow Control) credits with
>> -    downstream devices
>> -    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> -    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> -       a) speed is Gen-2 and MPS is 256B
>> -       b) speed is >= Gen-3 with any MPS
>> -- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation of ASPM
>> -   to be specified in microseconds
>> -- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASPM to be
>> -   specified in microseconds
>> -- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
>> -   specified in microseconds
>> -
>> -RC mode:
>> -- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
>> -  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> -  in p2972-0000 platform).
>> -- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
>> -  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>> -  in p2972-0000 platform).
>> -
>> -EP mode:
>> -- nvidia,refclk-select-gpios: Must contain a phandle to a GPIO controller
>> -  followed by GPIO that is being used to enable REFCLK to controller from host
>> -
>> -NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
>> -operate in the endpoint mode because of the way the platform is designed.
>> -
>> -Examples:
>> -=========
>> -
>> -Tegra194 RC mode:
>> ------------------
>> -
>> -     pcie@14180000 {
>> -             compatible = "nvidia,tegra194-pcie";
>> -             power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> -             reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> -                    0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> -                    0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>> -             reg-names = "appl", "config", "atu_dma";
>> -
>> -             #address-cells = <3>;
>> -             #size-cells = <2>;
>> -             device_type = "pci";
>> -             num-lanes = <8>;
>> -             linux,pci-domain = <0>;
>> -
>> -             pinctrl-names = "default";
>> -             pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
>> -
>> -             clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> -             clock-names = "core";
>> -
>> -             resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> -                      <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> -             reset-names = "apb", "core";
>> -
>> -             interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,  /* controller interrupt */
>> -                          <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;  /* MSI interrupt */
>> -             interrupt-names = "intr", "msi";
>> -
>> -             #interrupt-cells = <1>;
>> -             interrupt-map-mask = <0 0 0 0>;
>> -             interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> -
>> -             nvidia,bpmp = <&bpmp 0>;
>> -
>> -             supports-clkreq;
>> -             nvidia,aspm-cmrt-us = <60>;
>> -             nvidia,aspm-pwr-on-t-us = <20>;
>> -             nvidia,aspm-l0s-entrance-latency-us = <3>;
>> -
>> -             bus-range = <0x0 0xff>;
>> -             ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> -                       0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01E00000    /* non-prefetchable memory (30MB) */
>> -                       0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>> -
>> -             vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> -             vpcie3v3-supply = <&vdd_3v3_pcie>;
>> -             vpcie12v-supply = <&vdd_12v_pcie>;
>> -
>> -             phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> -                    <&p2u_hsio_5>;
>> -             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> -     };
>> -
>> -Tegra194 EP mode:
>> ------------------
>> -
>> -     pcie-ep@141a0000 {
>> -             compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
>> -             power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> -             reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> -                    0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> -                    0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> -                    0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
>> -             reg-names = "appl", "atu_dma", "dbi", "addr_space";
>> -
>> -             num-lanes = <8>;
>> -             num-ib-windows = <2>;
>> -             num-ob-windows = <8>;
>> -
>> -             pinctrl-names = "default";
>> -             pinctrl-0 = <&clkreq_c5_bi_dir_state>;
>> -
>> -             clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
>> -             clock-names = "core";
>> -
>> -             resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> -                      <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> -             reset-names = "apb", "core";
>> -
>> -             interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;  /* controller interrupt */
>> -             interrupt-names = "intr";
>> -
>> -             nvidia,bpmp = <&bpmp 5>;
>> -
>> -             nvidia,aspm-cmrt-us = <60>;
>> -             nvidia,aspm-pwr-on-t-us = <20>;
>> -             nvidia,aspm-l0s-entrance-latency-us = <3>;
>> -
>> -             vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> -
>> -             reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
>> -
>> -             nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
>> -                                           GPIO_ACTIVE_HIGH>;
>> -
>> -             phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
>> -                    <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>> -                    <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>> -
>> -             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
>> -                         "p2u-5", "p2u-6", "p2u-7";
>> -     };
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> new file mode 100644
>> index 000000000000..4a49dddf33bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -0,0 +1,254 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra194 (and later) PCIe controller (Synopsys DesignWare Core based)
>> +
>> +maintainers:
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Vidya Sagar <vidyas@nvidia.com>
>> +
>> +description: |
>> +  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
>> +  properties defined in snps,dw-pcie.yaml. Some of the controller instances are dual mode where in
>> +  they can work either in root port mode or endpoint mode but one at a time.
> 
> Also not properly wrapped.
> 
>> +
>> +  See nvidia,tegra194-pcie-ep.yaml for details on the endpoint mode device tree bindings.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: controller's application logic registers
>> +      - description: configuration registers
>> +      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
>> +          Unit) registers of the PCIe core are made available for software access.
>> +      - description: The aperture where the root port's own configuration registers are available.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: appl
>> +      - const: config
>> +      - const: atu_dma
>> +      - const: dbi
>> +
>> +  interrupts:
>> +    items:
>> +      - description: controller interrupt
>> +      - description: MSI interrupt
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: intr
>> +      - const: msi
>> +
>> +  clocks:
>> +    items:
>> +      - description: module clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +
>> +  resets:
>> +    items:
>> +      - description: APB bus interface reset
>> +      - description: module reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: apb
>> +      - const: core
>> +
>> +  phys:
>> +    minItems: 1
>> +    maxItems: 16
>> +
>> +  phy-names:
>> +    minItems: 1
>> +    maxItems: 16
>> +    items:
>> +      pattern: "^p2u-[0-9]+$"
> 
> Same problem.
> 
>> +
>> +  power-domains:
>> +    description: |
>> +      A phandle to the node that controls power to the respective PCIe controller and a specifier
>> +      name for the PCIe controller. Following are the specifiers for the different PCIe
>> +      controllers:
>> +
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> 
> Remove as well.
> 
>> +
>> +      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
>> +
>> +  interconnects:
>> +    items:
>> +      - description: memory read client
>> +      - description: memory write client
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: dma-mem # read
>> +      - const: write
>> +
>> +  dma-coherent: true
>> +
>> +  supports-clkreq:
>> +    description: see pci.txt for details
> 
> This comes from schema (pci-bus.yaml). Remove here and in EP schema all
> properties which are defined by pci-bus or any other referenced schemas,
> unless you customize them more.
> 
>> +
>> +  nvidia,bpmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
>> +      are the controller IDs for each controller:
>> +
>> +        0: C0
>> +        1: C1
>> +        2: C2
>> +        3: C3
>> +        4: C4
>> +        5: C5
>> +    items:
>> +      - items:
>> +          - minimum: 0
>> +            maximum: 0xffffffff
>> +          - enum: [ 0, 1, 2, 3, 4, 5 ]
>> +
>> +  nvidia,update-fc-fixup:
>> +    description: |
>> +      This is a boolean property and needs to be present to improve performance when a platform is
>> +      designed in such a way that it satisfies at least one of the following conditions thereby
>> +      enabling root port to exchange optimum number of FC (Flow Control) credits with downstream
> 
> Not wrapped.
> 
>> +      devices:
>> +
>> +        1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +        2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> +          a) speed is Gen-2 and MPS is 256B
>> +          b) speed is >= Gen-3 with any MPS
>> +
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +  nvidia,aspm-cmrt-us:
>> +    description: Common Mode Restore Time for proper operation of ASPM to be specified in
>> +      microseconds
>> +
>> +  nvidia,aspm-pwr-on-t-us:
>> +    description: Power On time for proper operation of ASPM to be specified in microseconds
>> +
>> +  nvidia,aspm-l0s-entrance-latency-us:
>> +    description: ASPM L0s entrance latency to be specified in microseconds
>> +
>> +  vddio-pex-ctl-supply:
>> +    description: A phandle to the regulator supply for PCIe side band signals.
>> +
>> +  vpcie3v3-supply:
>> +    description: A phandle to the regulator node that supplies 3.3V to the slot if the platform has
>> +      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
>> +
>> +  vpcie12v-supply:
>> +    description: A phandle to the regulator node that supplies 12V to the slot if the platform has
>> +      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
>> +
>> +allOf:
>> +  - $ref: "/schemas/pci/pci-bus.yaml#"
>> +  - $ref: "/schemas/pci/snps,dw-pcie.yaml#"
> 
> No need for quotes.
> 
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - interrupt-map
>> +  - interrupt-map-mask
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - power-domains
>> +  - bus-range
>> +  - ranges
>> +  - vddio-pex-ctl-supply
>> +  - num-lanes
>> +  - phys
>> +  - phy-names
>> +  - nvidia,bpmp
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/tegra194-clock.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/tegra194-powergate.h>
>> +    #include <dt-bindings/reset/tegra194-reset.h>
>> +
>> +    bus@0 {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0x0 0x0 0x0 0x8 0x0>;
>> +
>> +        pcie@14180000 {
>> +            compatible = "nvidia,tegra194-pcie";
>> +            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +            reg = <0x0 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
>> +                  <0x0 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
>> +                  <0x0 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
>> +                  <0x0 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +            reg-names = "appl", "config", "atu_dma", "dbi";
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +            device_type = "pci";
>> +            num-lanes = <8>;
>> +            linux,pci-domain = <0>;
>> +
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
>> +
>> +            clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +            clock-names = "core";
>> +
>> +            resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +                     <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +            reset-names = "apb", "core";
>> +
>> +            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
>> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
>> +            interrupt-names = "intr", "msi";
>> +
>> +            #interrupt-cells = <1>;
>> +            interrupt-map-mask = <0 0 0 0>;
>> +            interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +            nvidia,bpmp = <&bpmp 0>;
>> +
>> +            supports-clkreq;
>> +            nvidia,aspm-cmrt-us = <60>;
>> +            nvidia,aspm-pwr-on-t-us = <20>;
>> +            nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +            bus-range = <0x0 0xff>;
>> +            ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000>, /* downstream I/O */
>> +                     <0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01e00000>, /* non-prefetch memory */
>> +                     <0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>; /* prefetchable memory */
>> +
>> +            vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +            vpcie3v3-supply = <&vdd_3v3_pcie>;
>> +            vpcie12v-supply = <&vdd_12v_pcie>;
>> +
>> +            phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
>> +                   <&p2u_hsio_5>;
>> +            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> index c90e5e2d25f6..7e0bf941fbfe 100644
>> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>> @@ -35,7 +35,7 @@ properties:
>>       maxItems: 5
>>       items:
>>         enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
>> -              ulreg, smu, mpu, apb, phy ]
>> +              ulreg, smu, mpu, apb, phy, appl, atu_dma ]
>>
>>     num-lanes:
>>       description: |
> 
> 
> Best regards,
> Krzysztof
> 
