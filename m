Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125804FBAFB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbiDKLfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 07:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiDKLfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 07:35:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF94579A;
        Mon, 11 Apr 2022 04:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+TDO8vXP5+pQjNHFFNK1pwl757QLBSQ07lc6Jap1S3/Z6u5jLFPaxFtJx2hnQnUus44R2GI6v+kwLOj8oJSHSGymsWZxCZheFOfTDHsj6H3E7KjQWSqO+eTlvFPwvpd+Rh5r0dNbm70iv7xWstIexXoJZ6bGc4D4mB5Ahc1SPaAqqRh0NHbMUmchYS7MRPS1WMPZ//jM6mJ1+O2dAPV/qSUR3Fahtug4KuBjWoWgGdEXPku2eMGYb40oXnKBGNjDhir4IS8l1XXNUykgjBuhPJZyesP5ZUo4EcmYyCnwmsku7Ka1fIxQf/1Gbc5e+6TDH20hYWqFp5dxkM3os1PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iX1PmtBpZz4wviuoMvESjHH6R6BoReNfy+nURZ470k=;
 b=fTvVF7YjlW3Nn+AWd0VDZjHbGNNqgUz55psXje/jk2kBJLttfY3WRE442T9ErB1rlSlE1sHnDKdlSKMGmLo5rQi4pG4zfTbZ33pB49XQxj9me4J+RpUqq6TOpsNqv3codUQUtAYgMKCBS+/BAo5Gf5ARqMPGbZr4ApClfQNbrF4Rfz0DIELrTYXQdgA6OycJcqxNuV+f+CbcdtSg1k4YVm1l/t6pFPov+OPWR8FGZsU6BRRVVExmVqPIrKKM3wSMP11nhWM+j3YBrOQXvIeOb6X4lfVL9CeAdK+kKhDDLxcYWnWKzAg8/ja4YHy5XGcd4JNNBC9K+gfzIaURCVtidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iX1PmtBpZz4wviuoMvESjHH6R6BoReNfy+nURZ470k=;
 b=YVaX5xa75mtmgoO6KMai4I3cUeVht7474kiE9/OA9g7wCFUNYmmQsD9WK/5FDgbjW28ze8S7pt9kKBKQL/RpdZu/eQyHhme3uPoKgkTFXFHXa+7F5xzZ1YuMZjsNLWjv7n8P8fKy32CIi6J3cO3nx9wVHTWySiXYcRLCii2LaZE3t0C/+WS02AXGDPvh2yIoLGHE/YySGURT/HufM6OknwzBnnxyOW94Gz7s189QAMpjOw6pHyKN+GaORONjuxb4oqJ4/1n6m5DJdQGw03m+jBUEOQFihJ+V12iAO3qtjH6bwDLBw/zFOOEXkOTOyS8tpTEsQWLtG6NFUkDsOp7ImA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:33:24 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::f917:a955:6b35:6425%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 11:33:24 +0000
Message-ID: <32856498-0675-ac5d-81f7-9c2ddb728c50@nvidia.com>
Date:   Mon, 11 Apr 2022 17:03:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] PCI: tegra194: Remove unnecessary MSI enable reg save and
 restore
Content-Language: en-US
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211226074910.2722-1-jszhang@kernel.org>
 <YlAi9/OehFyQx5jy@lpieralisi>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <YlAi9/OehFyQx5jy@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::21) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc1a096-80b7-4c20-d2f2-08da1baf16d7
X-MS-TrafficTypeDiagnostic: DM6PR12MB5023:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB50239D30D6A7CF3E225F8CD8B8EA9@DM6PR12MB5023.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XntZ4D32R9nDrwiDXShqRtIV952P/0s49pInhoY/m2e+lQTzHtvn00CI0buTlgfmJmFv9RM3lCq2iBFcm93HF+2fWa8G5I6Tj1Wlfv1Z/TyW2yAdqc/R5y8LApIQkr8lJoqqS6ptv5g/dJClaCB/GC1N1XM5AVIJQRBsFJ40OVHk/euDx/EpoA1nZQ7SB4cxAIhszFfNesQWO8uXv5G8Sm756ZvvTgGdooSguQbYPJHEoLbRezlfCyHdY3RMB0N19gdnc0rS23lVQwmzSfsl7kKqFJI+QuhtEyUGpQTSkqW1UJ2JDvCQ6G9KrWm+5YKt4XjnPd4pEQVGo3U9S3aCCDKk+GpriwWiVZfGhL9m4Pe2EvBxwUPuw7VQZQ+W43l8fZKu5ZrDZVv//Hn/k8CPgnj1yMvSc5ooYU5KDQ5qb5AOlT0rQVnCYNv1S6araL/BV7SHFVhbOQLUnpxnaocAHdYqAKMCj2ty7uPcnAMidxz/x2fJqpomlJCEBmpGwbX/KAIo/tTC2x3ndIiWbc47R40nC5o70y0P7zGXCeZda/sVBmxlYRdvJXdRoY8WMlU7t8g9fh1HVotiRpe9eBksE1SdNCW8KllmxDJR6SAh7X9VVpqswfEoWZ/lggff/6gSTg1aEEQILoP4crbSD4xdWjr21EfSq8khQX64dIRpsKQkfGhgkuibz94Ee5ZzFoDW5Jx5xZvAfR7WwFad0ewMr62+ZKD0aXnwoCi00222TCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(31696002)(38100700002)(2906002)(5660300002)(6512007)(316002)(66476007)(6506007)(26005)(53546011)(6666004)(110136005)(2616005)(186003)(36756003)(508600001)(6486002)(4326008)(8676002)(66946007)(66556008)(31686004)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUUvYzZENFpFWUlTUWRrT29jb1pLdWxoSUlXaFk1bWhhb3JxWWl6NW5ZTVlr?=
 =?utf-8?B?c09OZjU3em1weTcydlhzOXBOSUFrbDRkWTRZSTFXaFVvTWRtYXdicnhCOW52?=
 =?utf-8?B?aVRLZkJsb3dNckhkQ2tQTU1SS1lYSkEzTlRLcUgzaUZGeVRXMFBVWU9BYk9U?=
 =?utf-8?B?YzdrYVVvaHRPMmR4cmdlZFpNR0R5d1BwTFNsVnBBamNGWk9mQkp3R3I4bHcy?=
 =?utf-8?B?YTd5S1J6Y2RFVnRmS0VZMnJ2MXRDbXFQZHpUa2hMZkxld0R1ZVFMY1JmK0VL?=
 =?utf-8?B?WVY0OXk2OFppeGd6dnRuTFhocDJvbEFTM2g3MDVOSFdocVBSeTNxVG5KK0Na?=
 =?utf-8?B?T1dRZGljME9pTEpjS3NwWFlxY3Nhdzc0WVlrbFZBK3NoZDlzS2FLaU0wVVVH?=
 =?utf-8?B?WHVJb2V0WHlibk1Cdi81Q0k0QktKZjNxUVRvWlpCWVhiYWhuRWdMb2FLV05Y?=
 =?utf-8?B?MmhsbWJzMmVxT1RxRGpqSnFvZjl0a0pOaFpxVnJLVTBNLzRPRER0b01BdnFu?=
 =?utf-8?B?MHdmYnA0T1oyeFJSTkF0VHEwOEg1MFNZSTFFU2h0dW9jdzVLS2hhTzJCSVNz?=
 =?utf-8?B?SkdCdXQwb04rNExlSXBsZnpRTXNpd09QMzdKdkNubU1VZlFEdnNjTVN1dmV5?=
 =?utf-8?B?cjQxZTlCSUNtRDNMSEZQaHlvOWdkY1NRYWdaZFgyaS9wQ2FsYzFWV2ZtaS96?=
 =?utf-8?B?ZGo1TkFublZOc1pYK3BBa0dvUVQ5VGo5clYyWjRiTE5wL3VTWXIyL1RtbVRI?=
 =?utf-8?B?MVB3N2J2dk1meFU5NkVJNmd0S0lpOFR5Y2tqY0E5TFlhK2oraVNBbHd4TFFX?=
 =?utf-8?B?TUhUNzJ6R1U5TUhUMHgzVVA1bkZMWjU1V0dBckR2aXcydUJTckZoNW15aEx3?=
 =?utf-8?B?cmFnUTduVWl4N1ZVK2xmdFNDbTlsZDJyUEtTYUhESWlkZi9ZNk1FTmlQUG95?=
 =?utf-8?B?TzhaSllrcE5teE5PeVYxMVBES2lpMHptbForN0J3d0tIMm9qbWVrTWZVSjQ0?=
 =?utf-8?B?YURCSFBRcEZlUTFNMS9uaVZsYnpra25sS25aaTBURkcxSGUzblVQY1lHdHBv?=
 =?utf-8?B?TzZWNG5CcDZnUm9iUG90ZjlxbnRWdG5oSWVuT3VXZkVIL2piMkg5M29GZVFx?=
 =?utf-8?B?UGFNN2h4STllM1R2dXBKa1ZPMTdPdDc1YlRnam1KOUJjYjJybTVUdnE1eFQy?=
 =?utf-8?B?TURMNzBNWDBnVWZLRmZqS2s2MkVMYzNHbzFJTkFybVlvSlczUDlPMHEwYUdr?=
 =?utf-8?B?dEJ5ODNEKzNrN1NEWDlvMTVRbFpyWnVJV3F4TkFKem9TeTR4aUllaFZjS2Za?=
 =?utf-8?B?ZmVXandNbm9DSGR1S29YR3RsOTRJbnZ0UXh0WnJLT09UeVJ2K2Y4SWZaNTNN?=
 =?utf-8?B?V1NxV2c4V1cyRElFc1RGY2lpR1I5N1FGY0xlOExob2pFMHpUZzdkMCs0aFpL?=
 =?utf-8?B?clZ6MSt2SURld3MvZTRSQmVwbm9CWmN3T2FkbmpxRWtQN2ROOWVLMXBtMEZV?=
 =?utf-8?B?TXFYRnVpUTdIWERBZGVzS3NhbzRKYk96bE5LaThzTjF5dDdzbmVzeFJxOTg1?=
 =?utf-8?B?TmVJTll1SlppMDRiY1pkQzZZUDJVQ0F3NGNkZHJEa21JZXY3NHdqS2pvUlBK?=
 =?utf-8?B?UE9oeDdRaG1XdTJqQllGNkNPV2V1RXltcjdjbjFFSXQ3RDl5Q0VWS3VDM2dT?=
 =?utf-8?B?YVp4WHZzZ24zSlBXeEo0ZmM3TThiMm4zODRycU1PUFhxZ2UrUEJUNFUvTU0v?=
 =?utf-8?B?Tjd4YXRhN1hOeW43TFdpbVR2RXl2Z0JSVks3emFBamw3MU5XakU5RDNMVUk0?=
 =?utf-8?B?bHZ4Nmp0K3BxVUZzN1FPa1lwTHlFbW9TdHV0WnpSZFVZL0kyMVRjYWhwU2Uw?=
 =?utf-8?B?U0xUaDA2VUxmTzhOUXJGYUZucXR6NFFPa0VpNldiMkJkNnh2NTVrTDQ3QjV2?=
 =?utf-8?B?Q3NSQVlxaVcvN2kvQmRSR0trcS92cUJMc254M3JqVlRubVBhaExzeFJxMElo?=
 =?utf-8?B?NmFTaGs3NmZlYkZJaElueHVBYmJmMThwNGgvODZYcmo0Y3NLZ0pYZ2hqVU5S?=
 =?utf-8?B?Z3dvVXpXYWRVbDNrR0U2OWRBK2czTEJFb3VIdUNuN0s2bGROQXhvZVVqL1Vi?=
 =?utf-8?B?UVlvNGRTR1NnbTg4RC9CaVRCcUNkNjhsSm1CNzlKN1ZIWDEzZ2psay9Rc1Rx?=
 =?utf-8?B?U1V1WjJ6U2N2OVNCYytCcVlpWE1FTlpWNkp6OUd1QVNJWmQydHNDRk5xbFBV?=
 =?utf-8?B?UzROYWRkaG1wKzVYOU15cndCaVVnV1g0c2VnT3UvNkNWRFowa2ZRaVRXcDRq?=
 =?utf-8?B?V3F4Nm5tamxkSTRoV2RNTG1YYTU5Q0xteVAyMWgydHdvYWxwKzRpUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc1a096-80b7-4c20-d2f2-08da1baf16d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:33:24.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPgOWTRw4VPd6chZevrmZWXoufIOFglou8Af7JeeXSGv7RGYDoAdfj2Tn4njTVkudxQDyfSqCKOFEKnjRaqNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/8/2022 5:26 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Vidya]
> 
> On Sun, Dec 26, 2021 at 03:49:10PM +0800, Jisheng Zhang wrote:
>> The integrated MSI Receiver enable register is always initialized in
>> dw_pcie_setup_rc() which is also called in resume code path, so we
>> don't need to save/restore the enable register during suspend/resume.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 9 ---------
>>   1 file changed, 9 deletions(-)
> 
> Need an ACK from Nvidia folks.

Looks good to me.
I couldn't verify it on Nvidia platform as we are facing some issue with 
suspend/resume sequence.
I'll verify and update as soon as I could get suspend/resume working.

Acked-by: Vidya Sagar <vidyas@nvidia.com>

- Vidya Sagar
> 
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 904976913081..678898985319 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -186,8 +186,6 @@
>>   #define N_FTS_VAL                                    52
>>   #define FTS_VAL                                              52
>>
>> -#define PORT_LOGIC_MSI_CTRL_INT_0_EN         0x828
>> -
>>   #define GEN3_EQ_CONTROL_OFF                  0x8a8
>>   #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT       8
>>   #define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK        GENMASK(23, 8)
>> @@ -2189,9 +2187,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>>        if (!pcie->link_state)
>>                return 0;
>>
>> -     /* Save MSI interrupt vector */
>> -     pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
>> -                                            PORT_LOGIC_MSI_CTRL_INT_0_EN);
>>        tegra_pcie_downstream_dev_to_D0(pcie);
>>        tegra_pcie_dw_pme_turnoff(pcie);
>>        tegra_pcie_unconfig_controller(pcie);
>> @@ -2223,10 +2218,6 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
>>        if (ret < 0)
>>                goto fail_host_init;
>>
>> -     /* Restore MSI interrupt vector */
>> -     dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
>> -                        pcie->msi_ctrl_int);
>> -
>>        return 0;
>>
>>   fail_host_init:
>> --
>> 2.34.1
>>
