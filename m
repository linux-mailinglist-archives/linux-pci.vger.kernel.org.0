Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064D963FFC3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 06:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLBFPU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 00:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiLBFPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 00:15:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34571D15AF;
        Thu,  1 Dec 2022 21:15:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy9qb0vRcu85W5lxF+AzyyAVz3TzfdqZbYdV3fAm/A4ioPRBiu5BObp6o7M41WQSMjRQRXmOnjqL86oQbtf/dUi+OgdvMO5Y0V2IpnE1vALl7tETMBg5c4JYamf9/IsQRV/NIcKEa8nRf0Q4lHCP+UUcIepm/m8KBPCHX9AU3t1vXB0NigusvBcEfAgDx4dgwWIjFbYf2xmwGfDk9gOPVT+UnJ2JysAHmfZskYwRJJyRWcPcvczc4YO1knoBUYhe5IC8oX3CcqTMvwaeM64j2NlkrhKN+SWdf3te0Bke40hezPSsQxXf224m+0ngJIrQfzNRl5WJVnsJfLmZEXlP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lQuaVTtaWP7epLRpwxnl2hjN2LwLeOQ665Rf5prEKY=;
 b=bqyHWok0AbvMWiVTaG7OiMp8L34ttdarMbKnuQAtnuE0oFO0UT4gVl+v652USEdJQrCtNVcUyv36wBMsy9fQwavyjtOW1ugMmDEESTOaZrA54EVY49zL/nJvtdoF/xe+cZPwEPXH2EKYty6ZWmYBv9QyrWCynbjNbx4DknmsMSv0mUaYWPG7+7fnDJ71cQxAMpMkO0fUeORE4FC9cefWAgw6U2hLfEvagExZd3q8/4/8EOtwp3LAmAyZ2/iXexrTh0/caDFY4YarmzRzfB2mVTiDhR1PYGEQ0bsjqb1ZeG2Z9rF/6KJaZ2qBjgQfLY0xJ6+vd3YDi1h7k77uocjiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lQuaVTtaWP7epLRpwxnl2hjN2LwLeOQ665Rf5prEKY=;
 b=leUn/ilqwiBMLzg6ERZIhTMzdUpvtwmr473FvcUrsPniNmfuPS1Zdd+KnbhbDOA0p3w6sBCQKTzQjW2Py8IwvvGzh9bNLkg2EbHKYzrYVbQsR9Zyu44e434v6mABU9Yfm7/8NzsEbHvKqIikmOqQhdlltDntkv21zU2VDo2nwaMbl8jLEaDFBivyTJICXEYq5sQPTbys8RBuHEdqXleBob0rDFmFe0nZbaFTcbOTQPUy98M/WynjHocbMDmacq63sqpsrxQP8jFMPBnOOkl/oo8i2DwEIQag3plxsMXl9RvGrw2727d0qhWt3T5PdrhsqyfbdkS6vddI+s6vrstGWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 05:15:10 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b%3]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 05:15:10 +0000
Message-ID: <099c5fab-3edc-71ba-ed65-2002ed2427fb@nvidia.com>
Date:   Fri, 2 Dec 2022 10:44:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] arm64: tegra: Add uphy lane number and intr in p2u
 nodes
To:     Jon Hunter <jonathanh@nvidia.com>, vkoul@kernel.org,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, vidyas@nvidia.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, nkristam@nvidia.com
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
 <20221124083510.3008139-3-mmaddireddy@nvidia.com>
 <1940f7ef-3119-59c6-0ddc-9498806766c9@nvidia.com>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <1940f7ef-3119-59c6-0ddc-9498806766c9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: be4a58f3-6044-4a6f-a179-08dad4242f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EruvrVKS4E3f7ezxmMW8LAU76DmLateuOCG3EMq+N5LSNBrjYFi9klvMCC6xsL5DZXsc7ulEINnKMNUYiHkRG918nvkXRkm2VccmYid+UDQTSFZrcfkVcoJZkK7rl1y+6sGV9Ey1ceB37YsQtNR7FaulmdraRTiSDYJUmGmyDnSxJpU3zf3dfJxUpj95HwY+dINtx6CJtn9AVkX2ArgZT1eiLApOXjQF+MGe0RDsCu2ow7hSO0tasrRT7fqnnV4Q1JadUAM1lpxq1yOubXIsLaIFAvzjCnhmvRbOrpLqoe+GwytaFgGMi028JISxiyOHJl09vpxanykOXQ2xc3G3xKVZBz+3I0q+546awEoyMJnUz4uKLGQAwKwkYILA6YHPRjtBazgLv/G9nG8EXJ7i8LN1WY6MEpO4bPpQa0vNZmzqunJH+qDOAVQNbVsMil2P6H8UXC1rnQ8LmuFbFDAIMJEWWJ/wOT+ytaQ/HMuWuH9jpqEY39vyDNJHCVnjfR2ec8YbBJJ2Hq+hQ2MbyHs5UoK4xk4kkjQFC5n9GUSCTIND00F/0w3F14O50cuuWwViOg7RV9nbyiZaXm+JvSvoQ/tpMnVFFlhGu3dM+zKtsQuGbKzHmr3ojxBqifs9+Jvth/codc2MbLTaiGYnyjFRRrp5dL/CUgpNFRP1uxIezft3mq8jFm1y1LQeJYqp+Tmpi6bXDQxyZ8uBILmBpfT1dQqh45i5LV+jhVbAvgER1Bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(31696002)(86362001)(6512007)(36756003)(107886003)(6506007)(26005)(6486002)(5660300002)(186003)(8676002)(478600001)(8936002)(4744005)(4326008)(66556008)(53546011)(66946007)(2906002)(316002)(66476007)(41300700001)(7416002)(6636002)(6666004)(2616005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3FNRXJwWUxPWHduWXh4R3VZUnY1VnVEczZyVWo3QzM5NUxpZExpVVZYU0Yw?=
 =?utf-8?B?OHVXTGs1WGFBNEJrS0J5MzNQaGdaL2NCT3k5dXBKQ3VYS2NTb3ROYnpPNSt0?=
 =?utf-8?B?Zk45emhUV1dtOVNlNE1QZ0NRRG5ZcUJYK2dlS0VoMEFHZURMRFZYc1hMc3NX?=
 =?utf-8?B?WUFSWGVNOFlsa0dLeFRrSDBTWDdnS3dRMmJKVXE5cUs2YS9IMnkvOE96Uld2?=
 =?utf-8?B?REg3SWF2LzNRZHE0bWZxOTZxdXdRMGthTmtUSisySXFkeUI3Mkd4cFp5WGFt?=
 =?utf-8?B?YXNNcDNXTDAxSDdKaFhmK2craVVSRzI3eFYyRTRuQlRmcHZGbUpMNHBKS1NE?=
 =?utf-8?B?NnlYYzMyN1hKbHJxVHNYZURBa1l1U09LNDRSZlJxY2RXbk9MZkowbmp4TjZz?=
 =?utf-8?B?c3VBdzZ3ajlURzB5OFpWMU4yTHZhMEIxV1NPRU9ZOGhtR3k1amNqSG9sVnBH?=
 =?utf-8?B?d25QUElYaW9zcWs2d2ZjdnY1NEZ1L2JkOFN4U0I1N3lzZ2h3K2lBbkcxWlpZ?=
 =?utf-8?B?cXlEWkNnZ0ZnZ0RBZmVFNzZQK0k2QklPNTU4dHVyODFkYytyK3lBbnlGM2lh?=
 =?utf-8?B?SmtBRmsydWphNlgxcWZkNURnY0ZrMk5pbkU2amZYdFdhM0NIakU2M1p0cStY?=
 =?utf-8?B?a1M1UkpLRkJBV245Si9hbGdZNVVUTy9oZ1AyWm50dXcxWmtEMmM2T0Jnd2dk?=
 =?utf-8?B?USs4Z0RYRjNNRGNHNmtUbjZid1BCVDBZSHlDMVBwSE1XTCtHeURKeEdhWUJy?=
 =?utf-8?B?OFVPa0FVS1pIUHR0YWRtUHJWdlZaazRCbHU1N1dySWFrcVZBRXdsdkhTeUsy?=
 =?utf-8?B?KzVPTmtwLzJFQzk0ZWpxaTRpWDg0RkJDSWVZSk00SlFrQlNrL1dkWTJrZklp?=
 =?utf-8?B?ajVsUU5yRHRzRGhFVnRIYnB4bWY0L0JiRmptekpWbVVMRnVkd3VjU3U4Qml4?=
 =?utf-8?B?aHIrWGtTekhhVWVwRy9QbmJ5dDV1L3BHQnQzRjFQcFhicTZxSjJXZGZlQTNC?=
 =?utf-8?B?N1pYOWVaaVhrTU81VktwTjVad1hUcDd0NUxzMUwxOXRQTXYxZStQWUc3NnJp?=
 =?utf-8?B?czNmZ0VtMVYxN1NNK1ZmbTNVYU5ZSmtUL2NRV0lRRGdnY3JkSGZMSkxUUDBq?=
 =?utf-8?B?aVhqYWxmSnd5NVhFbDJHU1Urc05lZnVMNVdiZ0VLdFZ4NlFCTTJkV0pTYklB?=
 =?utf-8?B?VDJqWTFoSWRETXhkMEE5dzg2S2RTNHh3R0cwRUg5TkVDMFFlVTkzeEU4L1Nl?=
 =?utf-8?B?R2hpWHNHTlBmcjJoc1k1allkY3FNVlNmUjUzODd5R2ZxbWh0dkI2UG0wUDdX?=
 =?utf-8?B?UTk0UTZlZ2JKLzBpVXhpLzZsUy9VNUdaeFJyRE9JYXVWc1dNeHFMRVdsaGpy?=
 =?utf-8?B?Z3V5VFFibXJ2VVN0Zkk0QVNHMDE1RmlPVEtGRERKcDNLVi9OMWJFWEpDRUpE?=
 =?utf-8?B?UGN6NkdLVEVvV1dac1RVdDAxeEcyRkx3cUppdEFSYytlZkFBNVljcFdMdDRp?=
 =?utf-8?B?LzczVkhtTVNiUFZ0aWNwUnAwcWI4bCt2TGJFUUZSVXRIRnZVdmJFdG5xN1N0?=
 =?utf-8?B?MkoxSXAxaG9QSExRclFPU0lXaUMzQ3pSNk8yY1ZGeEprZHhOdDgzMTF6bEtz?=
 =?utf-8?B?VWp2RFJpbzVnb2JrZUR6NXN0aU4xcTFCWGVPWlMzNUdzMHpkb0xjQ2lVbGk1?=
 =?utf-8?B?MzljWm9kNFFEY1BkTnk2SHgxZ1pTMkc4c1NvNDFIcWhxNlp0NUkvSVFyV2Ew?=
 =?utf-8?B?V1RNQkRObWVIRDJKcm5SL29HOFl4bFYwbHE4MUg4a0t5TXBvZjg3RG16Ukla?=
 =?utf-8?B?TldLUXM1ZWpyWEI1bWFYbDZRWmloaHUwV05VcDR6NUVKS3M3Zm9LbmlEQmZ4?=
 =?utf-8?B?TW0rU3ZpRGh1NlNOaW9VOG5hWjF1Q21xZDlLQlVqek5nL1pSa3BNRGdKdXo3?=
 =?utf-8?B?T1JWcHdMWTRKak9UeGxhYlYyZHlWdXdVQVY5WWR1d2tQVWd5NS9MWE82b3U4?=
 =?utf-8?B?UGVtUjZCMTNNUDBSYVhSTml0Vm1NN0lFYmNscUlYSUJyYUFSUm01SkVYZmhK?=
 =?utf-8?B?eE9mR1hCdDZWZks5eTBpS0tEL1djc29kcU8zbUZ0TW9WYVpZMGVBQmhCUnJo?=
 =?utf-8?B?OHV1dUVKanloeXNxSG5tNmo4MDFIRFVUMEhqMUxwSzNoaWVSeG84NS9Bdk1R?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4a58f3-6044-4a6f-a179-08dad4242f0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 05:15:10.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCIjJC3fIyDRk/5MHOROnBOSl/Ew6XshXDwSrRE8Tt5MDEjrxd63qW12SUTErGrxxrxn0HYIDmgRghUOyCM11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12/1/2022 3:14 PM, Jon Hunter wrote:
>
> On 24/11/2022 08:35, Manikanta Maddireddy wrote:
>> UPHY lane number is required to exchange lane margin data between P2U
>> and UPHY. Add uphy lane number in p2u device tree nodes.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 120 +++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi 
>> b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index eaf05ee9acd1..ec8a28a9d380 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -1109,6 +1109,11 @@ p2u_hsio_0: phy@3e00000 {
>>               reg = <0x03e00000 0x10000>;
>>               reg-names = "ctl";
>>   +            interrupts = <0 336 0x04>;
>
>
> Please use definitions and don't hard-code the values apart from the 
> interrupt number.
Ack, I will address in V2.

Thanks,
Manikanta
>
> Jon
>
