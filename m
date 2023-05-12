Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288F700106
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjELHHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjELHGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 03:06:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC2106E4;
        Fri, 12 May 2023 00:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP0G1Aek2AtZUvCpLL39YVJUSpbYnwcLg2RcPx8pymiTOWmInj6GDj/f4H2+gsJ8Q2UXmpgCHyKPx1X8vmVL7uzE+HOM1Tfr0mO96dQzGgSHFMS51GowL+X4Fn8JwXO5TIvzU3F9dro+rvyxGQXLIys8ufkL+rnztH4NG0ddkKSfvG6eGQHQPgZ6T/mkZmBLYJYEU9jtCfSCLRNwQdyM7YkugE5VwV1s30uy6xzyY19LY37clwbVDrs1lQnGgE6jVC6POFthnsEO+9j5D3Ze0YjiGVrFAh1pHt0eKnbTIF8I3LDKAF/IRqYBb1eqUYk+okV7sBqNfz/PTizPNo64ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/46uv75LaDtyUxvZKeQ/WbanQsN3yeLLHiCVANmd0k=;
 b=ev3FBweDCABol46pYB2S8SzV6JD5ssXkChTt44KDtH9prB3AWgJXlmUhy0k5U13oG7bxsslINi0sxXv71Z21lqF31ECMKA5stXZA8RrUNnDmJwFDuhQgKqfmBT4cXORbMT2XE5VFzaJ6rMKlu9bmLXnSmZWlV7TwIrnXpGwW6cWgJJmbDjeFb9Gd7lCR1MrgNXLMkcaWVxfSBJGd3Em2bt8FwheiuTTYrz5rJcBrr7qxirTjfBeEtNU+4YAXfuo2jJcfAQF/+wDCpfL+F/u6TrAKtxPWmFBsFbaCPLAKG34ZEPx81brO0TADQ0POKch8er2YrVf1oApgaUjmEI//hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/46uv75LaDtyUxvZKeQ/WbanQsN3yeLLHiCVANmd0k=;
 b=y5fkxWr3/t5fBNel1eKg5iJz6ab3ubY2c1tRqBKQyh6Q/RA+3IA3DJRQCPATGIErIKxcaDGQTUS3qfmtr8MW31Lpd+qpgzGChAHh8XAMjHj+wY1cLNvX8x6zHelk6c8HJ89idCg8Nqc2/NXJYBuVV3cs7oI1zZsMmT04K4QAgRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 07:04:58 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 07:04:58 +0000
Message-ID: <9d2d0996-326a-828c-ac0d-187c7e956d77@amd.com>
Date:   Fri, 12 May 2023 09:04:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
References: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
 <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
In-Reply-To: <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0046.eurprd03.prod.outlook.com
 (2603:10a6:803:118::35) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddb99a2-471c-4182-790b-08db52b73269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GGUFDhQHUZt601nMAcIIWUtlDMJu+b+Wlg5YaYmDUTTYQnMtV4FqcT/Ylql8NIxuMX9TKuxfKXToPzreomUrg8rw5P+TUb/Jbo94aWVG/I7g2g/2eKlRvO0cwXhnEvgQtOzcGFbkgii4uYsN8p0ZFPDUhkKuXZbbagZQyIXAQA+ZHzUVgz52/5Y4VfoqZkCLkd5Yigx7COgTSTCt369pMfHXEmR5iU8yWB0s76u/wOm948+C42wMgAYsbqjTPKjrSXNmfDLGSfFBX0pSW821BTXabJPtJ+lKyc7DIR2e0wP2QpQChNKBMYvfXaZ6k9Hk+XvU38WZN9Zuk/z5cl1tw73gH+RqexAFOmAq6F6LV1OgdmoivD9PrQw2kuVQa+jJIp19e3OksGcFXLhFvxOwzSIrdiXVMA6q35E0itVTlzFw1TRpmGX0qstgQJsFeyZHyJZp/bEhw3M/gjEVnkjl8vgvogubdqc9a2pcO9nbPiZd9oe+2tSDBQNHZwmoRZon5MODIVCqoR9QBD69sFDQRInWVXoAPvDIGbN+sEHDjZyAxnu6xl53sVf3yuvT5aRd0UjQPXShunInDKDDDF7A8+q0YbZadeeZ6UWv1dCiNK0WxSPGR/JdDYTgSXCkatTDvsJAZwbJr5/8+RNaEzWyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(31686004)(5660300002)(44832011)(478600001)(6486002)(6666004)(41300700001)(8676002)(8936002)(316002)(26005)(6506007)(53546011)(6512007)(66946007)(4326008)(66476007)(66556008)(2906002)(83380400001)(30864003)(2616005)(186003)(36756003)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZNYjBPTEZ2WGlDVnF4NFl2WWVUWFRVU0sxaTRzUCtrOXZrQjBTTDB1QmRG?=
 =?utf-8?B?Z3d1dDFPVXE5RkZybkhTNGJOQlFMT3hxcHZuRW1ac3o3clZkM0V0VVMrWmZU?=
 =?utf-8?B?SGRlbCtpdGdCd0Qzb1g0d2YzOUxVZ1ZTMnpxSGdlczAyNHJxWUp5R3dNcmhU?=
 =?utf-8?B?NG83R3k2MHNsUGJ5M3ZyajRzZFFKamNoZlhKZjRPbmVkU3lIRGN3TWhsZnVl?=
 =?utf-8?B?dXdZM1V0S3hBcGkvZEpsYkFHaEJqMVJubFcrYVYrcTYzRC9RcG5nV3Jtdkdz?=
 =?utf-8?B?L3Fsa0h3elJJK3I5ZDdGVVRVQ0JnVzNRN3hBaUwrQXJ2MHpUdlJqV2tZbG16?=
 =?utf-8?B?REx0RGczMFp6TzJNc096NDlmbjB0V3hjR2ZoMnJ2VnFnUWF1emlRTTdWYjhn?=
 =?utf-8?B?bk5iOTBOa1pHZnFpeTRWSlhkSWVqT3lyQ1BFVWJHUk9OWStVUlpncHNodzFQ?=
 =?utf-8?B?enhlMWNibmxEenFVOEMwTXdPMXBPRzdzL0tPejZHaFVtTGVvL080SWRpakRS?=
 =?utf-8?B?bFpZaWtUWisxUm43OVY1aXE5NEw2QU5qZi9ibjVhZWdTS3ROZ2tyQ2tzTEpT?=
 =?utf-8?B?bk1FOWk4MWw4K3VoM3FPOCtyWlVIQThYbWRCc1pLZllualVOSUkxdFoycUlj?=
 =?utf-8?B?NXBZNkNMbmZCSzVrRittcFN3OWpqejVjenpXWEQzNXZzWE9MbWc3ODlvUURS?=
 =?utf-8?B?QWU2TmI4cTJDWHlkaTl4S2RIZUNMVTVXTDlBYUJiN2xuK1JzT1M0QzhoSURW?=
 =?utf-8?B?dHY1cmN2NWVSSXhFcnQ1ZHFvdlRyUGFhZCs2L2xvcWRPbjlmMkNJZ1pOOHlC?=
 =?utf-8?B?Ky9YNkMzRmFyRWVxVjh4QkpDWDNhY0lQNm03aHpaWWZpRmRDN1hSMVhnSFJ4?=
 =?utf-8?B?dEcvY0RsWWdlbnppQ1NJSEdXV09Id1VuWldUNDZwWUFIYTJUQzdYWVN5N1pE?=
 =?utf-8?B?L3JKOHVLaGtaQW5pR2wvNG5pUUZhckdZSm0reEs3czI4N1BLL1JuOFJLSWdO?=
 =?utf-8?B?L0pLaEJ1ZTlPVjU4Z01aWjdsdDVoSG9iOVMwM2U2T3hKNk9mSHBROXJGeCty?=
 =?utf-8?B?WERsdkJrc2NaS0plRFhJZHZFRnA4dzZMa2MwcGdSTndsS3VZNms3dTFyMS9S?=
 =?utf-8?B?YzkrbldIenBJNENENVd0V2dTRjRxaTVHSUFYZzFkQ1RKOUFSeHpIcTFuVWZj?=
 =?utf-8?B?YzBXV1lwMDBJVU0vcmM3NVJneks0ZFVSRllnb2JQVGErbGpEekgvWkkwRXM3?=
 =?utf-8?B?SmJyQ0xJT25GVGsvdGtENW8zL3dEM2xuRHc3M3dHMFpVeHRJWElWWWErYlM3?=
 =?utf-8?B?cnhzK3AvTXNqYzZ5b1diclVWcllxNGFxN1lhMndQc3duMmFCdFM1R1o3eEkv?=
 =?utf-8?B?Vzc0S3Q4VmJwSVQ5S3BxOUU2VkNlc2J3WHF5eERWUm55Rlo4N0czbEpyN3lp?=
 =?utf-8?B?VEh6MXlvRjRpMjhnblhsb0F5Y3NxVlQxYVRJRzdCcGl6bUhIZUpZQ0lMOXRl?=
 =?utf-8?B?YTExWlIrRVo3MzNacmdKd0NlakpFdGRoU0hKd3FjVUZrdnRSQmFCOXVTVnI4?=
 =?utf-8?B?WVVCMVk1RUlNNDRhV2ZjVVFQWGprczQ3T24yK0g4S2QxZTBwc1JYYk1YSWta?=
 =?utf-8?B?UXNkOVBzR3RETW1XNFNROERvS3J0cTFGSG91Z1Fjak9JUUJ1cEtoL241ZUJm?=
 =?utf-8?B?MWZZSG52WkF3VUFaN0lrOW4yb1paVWlKYkFiQUEwZVB2eFp2YUhQUVJ6Q1U0?=
 =?utf-8?B?VDA1UENzU0VsUERtRnk4akJNd2Y0MDkzUmdGdEQ5VVR3eFh3MmkyWmI1TjJk?=
 =?utf-8?B?ZzgzVi9HTDRFZzdEQld5T015b2E0enR5aEJjblJDS0I1dzVCbm9hZDVhNk44?=
 =?utf-8?B?TVMrcDNnODBuWlhEY3dkVGRJK1Bvcnh1K29TSTJXSUZ6NXRXTGI2K2hvL3dp?=
 =?utf-8?B?Z3U3RlA4VExoc1pBRGp2Vkt1TForQy91RmF2Y3lzc3NWWnhWdnVQL1pGWmkz?=
 =?utf-8?B?R0orZ3JxRTY4ZzQyVVBnYVpGNWYvQmdGSkJCdktaRzBQbE1VZEUrWUxzaWs2?=
 =?utf-8?B?UGR3NHNwLzFOek5tV3M2bkliQjZ3V09iYUh5Qnc1RHZoNUdUY2ZtdDRxRDV6?=
 =?utf-8?Q?HYfboIkKk5BXpxJEjhSDZNqHw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddb99a2-471c-4182-790b-08db52b73269
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:04:58.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwKZT1PY6QRA9xeiG6PLbTVRTxMV3g154l+E3t/hiRyYRJXPTG7+Uf0/OPZTDhlS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/12/23 08:27, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v2:
> Remove unnecessary inclusion of headerfiles.
> Added a subset of interrupt error bits to common header files.
> Added pci_is_root_bus function.
> Removed kerneldoc comments of private function.
> Modified of_get_next_child API to of_get_child_by_name.
> Modified of_address_to_resource API to platform_get_resource.
> Modified return value.
> 
>   drivers/pci/controller/Kconfig              |  10 +
>   drivers/pci/controller/Makefile             |   1 +
>   drivers/pci/controller/pcie-xdma-pl.c       | 800 ++++++++++++++++++++++++++++
>   drivers/pci/controller/pcie-xilinx-common.h |   1 +
>   4 files changed, 812 insertions(+)
>   create mode 100644 drivers/pci/controller/pcie-xdma-pl.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 8d49bad..e088956 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -343,6 +343,16 @@ config PCIE_XILINX_CPM
>   	  Say 'Y' here if you want kernel support for the
>   	  Xilinx Versal CPM host bridge.
>   
> +config PCIE_XILINX_DMA
> +	bool "Xilinx DMA PL PCIe host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCI_HOST_COMMON
> +	help
> +	  Say 'Y' here if you want kernel to enable support for the
> +	  XILINX PL PCIe host bridge support, this PCIe controller
> +	  includes DMA PL component.
> +
>   source "drivers/pci/controller/cadence/Kconfig"
>   source "drivers/pci/controller/dwc/Kconfig"
>   source "drivers/pci/controller/mobiveil/Kconfig"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 37c8663..f96896f 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>   obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>   obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
>   obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
> +obj-$(CONFIG_PCIE_XILINX_DMA) += pcie-xdma-pl.o
>   obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
>   obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>   obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
> diff --git a/drivers/pci/controller/pcie-xdma-pl.c b/drivers/pci/controller/pcie-xdma-pl.c
> new file mode 100644
> index 0000000..7399fb4
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xdma-pl.c
> @@ -0,0 +1,800 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Xilinx XDMA PCIe Bridge
> + *
> + * Copyright (C) 2017 Xilinx, Inc. All rights reserved.

Again 2023 now.

I see that you use spaces for indentation. Better to use tabs if you want it.
282:+	.name           = "INTx",
283:+	.irq_mask       = xilinx_mask_leg_irq,
284:+	.irq_unmask     = xilinx_unmask_leg_irq,

362:+#define _IC(x, s)                              \
366:+	const char      *sym;
367:+	const char      *str;

486:+	.alloc  = xilinx_irq_domain_alloc,
487:+	.free   = xilinx_irq_domain_free,

593:+	.name           = "RC-Event",
594:+	.irq_mask       = xilinx_pcie_dma_mask_event_irq,
595:+	.irq_unmask     = xilinx_pcie_dma_unmask_event_irq,

Checkpatch also reports this.

WARNING: please write a help paragraph that fully describes the config symbol
#35: FILE: drivers/pci/controller/Kconfig:346:
+config PCIE_XILINX_DMA
+	bool "Xilinx DMA PL PCIe host bridge support"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on PCI_MSI
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel to enable support for the
+	  XILINX PL PCIe host bridge support, this PCIe controller
+	  includes DMA PL component.


WARNING: DT compatible string "xlnx,xdma-host-3.00" appears un-documented -- 
check ./Documentation/devicetree/bindings/
#851: FILE: drivers/pci/controller/pcie-xdma-pl.c:786:
+		.compatible = "xlnx,xdma-host-3.00",

> + */
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include "pcie-xilinx-common.h"
> +
> +#include "../pci.h"
> +
> +/* Register definitions */
> +#define XILINX_PCIE_DMA_REG_IDR			0x00000138
> +#define XILINX_PCIE_DMA_REG_IMR			0x0000013c
> +#define XILINX_PCIE_DMA_REG_PSCR		0x00000144
> +#define XILINX_PCIE_DMA_REG_RPSC		0x00000148
> +#define XILINX_PCIE_DMA_REG_MSIBASE1		0x0000014c
> +#define XILINX_PCIE_DMA_REG_MSIBASE2		0x00000150
> +#define XILINX_PCIE_DMA_REG_RPEFR		0x00000154
> +#define XILINX_PCIE_DMA_REG_IDRN		0x00000160
> +#define XILINX_PCIE_DMA_REG_IDRN_MASK		0x00000164
> +#define XILINX_PCIE_DMA_REG_MSI_LOW		0x00000170
> +#define XILINX_PCIE_DMA_REG_MSI_HI		0x00000174
> +#define XILINX_PCIE_DMA_REG_MSI_LOW_MASK	0x00000178
> +#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
> +
> +#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
> +
> +#define XILINX_PCIE_INTR_IMR_ALL_MASK	\
> +	(					\
> +		IMR(LINK_DOWN)		|	\
> +		IMR(HOT_RESET)		|	\
> +		IMR(CFG_TIMEOUT)	|	\
> +		IMR(CORRECTABLE)	|	\
> +		IMR(NONFATAL)		|	\
> +		IMR(FATAL)		|	\
> +		IMR(INTX)		|	\
> +		IMR(MSI)		|	\
> +		IMR(SLV_UNSUPP)		|	\
> +		IMR(SLV_UNEXP)		|	\
> +		IMR(SLV_COMPL)		|	\
> +		IMR(SLV_ERRP)		|	\
> +		IMR(SLV_CMPABT)		|	\
> +		IMR(SLV_ILLBUR)		|	\
> +		IMR(MST_DECERR)		|	\
> +		IMR(MST_SLVERR)		|	\
> +	)
> +
> +#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0FF30FE9
> +#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xFFFFFFFF
> +#define XILINX_PCIE_DMA_IDRN_MASK	GENMASK(19, 16)
> +
> +/* Root Port Error Register definitions */
> +#define XILINX_PCIE_DMA_RPEFR_ERR_VALID	BIT(18)
> +#define XILINX_PCIE_DMA_RPEFR_REQ_ID	GENMASK(15, 0)
> +#define XILINX_PCIE_DMA_RPEFR_ALL_MASK	0xFFFFFFFF
> +
> +/* Root Port Interrupt Register definitions */
> +#define XILINX_PCIE_DMA_IDRN_SHIFT	16
> +
> +/* Root Port Status/control Register definitions */
> +#define XILINX_PCIE_DMA_REG_RPSC_BEN	BIT(0)
> +
> +/* Phy Status/Control Register definitions */
> +#define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
> +
> +/* Number of MSI IRQs */
> +#define XILINX_NUM_MSI_IRQS	64
> +
> +struct xilinx_msi {
> +	struct irq_domain	*msi_domain;
> +	unsigned long		*bitmap;
> +	struct irq_domain	*dev_domain;
> +	struct mutex		lock;		/* protect bitmap variable */
> +	int			irq_msi0;
> +	int			irq_msi1;
> +};
> +
> +/**
> + * struct xilinx_pcie_dma - PCIe port information
> + * @reg_base: IO Mapped Register Base
> + * @irq: Interrupt number
> + * @cfg: Holds mappings of config space window
> + * @dev: Device pointer
> + * @phys_reg_base: Physical address of reg base
> + * @leg_domain: Legacy IRQ domain pointer
> + * @pldma_domain: PL DMA IRQ domain pointer
> + * @resources: Bus Resources
> + * @msi: MSI information
> + * @irq_misc: Legacy and error interrupt number
> + * @intx_irq: legacy interrupt number
> + * @lock: lock protecting shared register access
> + */
> +struct xilinx_pcie_dma {
> +	void __iomem			*reg_base;
> +	u32				irq;
> +	struct pci_config_window	*cfg;
> +	struct device			*dev;
> +	phys_addr_t			phys_reg_base;
> +	struct irq_domain		*leg_domain;
> +	struct irq_domain		*pldma_domain;
> +	struct list_head		resources;
> +	struct xilinx_msi		msi;
> +	int				irq_misc;
> +	int				intx_irq;
> +	raw_spinlock_t			lock;
> +};
> +
> +static inline u32 pcie_read(struct xilinx_pcie_dma *port, u32 reg)
> +{
> +		return readl(port->reg_base + reg);

one level of indentation is enought.

> +}
> +
> +static inline void pcie_write(struct xilinx_pcie_dma *port, u32 val, u32 reg)
> +{
> +		writel(val, port->reg_base + reg);

ditto

> +}
> +
> +static inline bool xilinx_pcie_dma_linkup(struct xilinx_pcie_dma *port)
> +{
> +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;
> +}
> +
> +static void xilinx_pcie_dma_clear_err_interrupts(struct xilinx_pcie_dma *port)
> +{
> +	unsigned long val = pcie_read(port, XILINX_PCIE_DMA_REG_RPEFR);
> +
> +	if (val & XILINX_PCIE_DMA_RPEFR_ERR_VALID) {
> +		dev_dbg(port->dev, "Requester ID %lu\n",
> +			val & XILINX_PCIE_DMA_RPEFR_REQ_ID);
> +		pcie_write(port, XILINX_PCIE_DMA_RPEFR_ALL_MASK,
> +			   XILINX_PCIE_DMA_REG_RPEFR);
> +	}
> +}
> +
> +static bool xilinx_pcie_dma_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct xilinx_pcie_dma *port = bus->sysdata;
> +
> +	/* Check if link is up when trying to access downstream ports */
> +	if (!pci_is_root_bus(bus)) {
> +		if (!xilinx_pcie_dma_linkup(port))
> +			return false;
> +	} else if (devfn > 0)
> +		/* Only one device down on each root port */
> +		return false;
> +
> +	return true;
> +}
> +
> +static void __iomem *xilinx_pcie_dma_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn, int where)
> +{
> +	struct xilinx_pcie_dma *port = bus->sysdata;
> +
> +	if (!xilinx_pcie_dma_valid_device(bus, devfn))
> +		return NULL;
> +
> +	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +}
> +
> +/* PCIe operations */
> +static struct pci_ecam_ops xilinx_pcie_dma_ops = {
> +	.pci_ops = {
> +		.map_bus = xilinx_pcie_dma_map_bus,
> +		.read	= pci_generic_config_read,
> +		.write	= pci_generic_config_write,
> +	}
> +};
> +
> +static void xilinx_pcie_dma_enable_msi(struct xilinx_pcie_dma *port)
> +{
> +	phys_addr_t msi_addr = port->phys_reg_base;
> +
> +	pcie_write(port, upper_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE1);
> +	pcie_write(port, lower_32_bits(msi_addr), XILINX_PCIE_DMA_REG_MSIBASE2);
> +}
> +
> +static void xilinx_mask_leg_irq(struct irq_data *data)
> +{
> +	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;

having them on single line is preffered.

> +
> +	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void xilinx_unmask_leg_irq(struct irq_data *data)
> +{
> +	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;

ditto.

> +
> +	mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip xilinx_leg_irq_chip = {
> +	.name           = "INTx",
> +	.irq_mask       = xilinx_mask_leg_irq,
> +	.irq_unmask     = xilinx_unmask_leg_irq,
> +};
> +
> +static int xilinx_pcie_dma_intx_map(struct irq_domain *domain, unsigned int irq,
> +				    irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &xilinx_leg_irq_chip, handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = xilinx_pcie_dma_intx_map,
> +};
> +
> +static void xilinx_pcie_dma_handle_msi_irq(struct xilinx_pcie_dma *port,
> +					   u32 status_reg)
> +{
> +	struct xilinx_msi *msi;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;

ditto

> +
> +	msi = &port->msi;
> +
> +	while ((status = pcie_read(port, status_reg)) != 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			pcie_write(port, 1 << bit, status_reg);
> +			if (status_reg == XILINX_PCIE_DMA_REG_MSI_HI)
> +				bit = bit + 32;
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +}
> +
> +static void xilinx_pcie_dma_msi_handler_high(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);

reverse christmas tree. it means swap these two lines.

> +
> +	chained_irq_enter(chip, desc);
> +	xilinx_pcie_dma_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_HI);
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void xilinx_pcie_dma_msi_handler_low(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);

ditto

> +
> +	chained_irq_enter(chip, desc);
> +	xilinx_pcie_dma_handle_msi_irq(port, XILINX_PCIE_DMA_REG_MSI_LOW);
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void xilinx_pcie_dma_event_flow(struct irq_desc *desc)
> +{
> +	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +	val =  pcie_read(port, XILINX_PCIE_DMA_REG_IDR);

I personally don't like to use more spaces for indenation but up2you.

> +	val &= pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(port->pldma_domain, i);
> +
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IDR);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +#define _IC(x, s)                              \
> +	[XILINX_PCIE_INTR_ ## x] = { __stringify(x), s }
> +
> +static const struct {
> +	const char      *sym;
> +	const char      *str;
> +} intr_cause[32] = {
> +	_IC(LINK_DOWN,		"Link Down"),
> +	_IC(HOT_RESET,		"Hot reset"),
> +	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
> +	_IC(CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +	_IC(INTX,		"INTX error message"),
> +	_IC(MSI,		"MSI message received"),
> +	_IC(SLV_UNSUPP,		"Slave unsupported request"),
> +	_IC(SLV_UNEXP,		"Slave unexpected completion"),
> +	_IC(SLV_COMPL,		"Slave completion timeout"),
> +	_IC(SLV_ERRP,		"Slave Error Poison"),
> +	_IC(SLV_CMPABT,		"Slave Completer Abort"),
> +	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
> +	_IC(MST_DECERR,		"Master decode error"),
> +	_IC(MST_SLVERR,		"Master slave error"),
> +};
> +
> +static irqreturn_t xilinx_pcie_dma_intr_handler(int irq, void *dev_id)
> +{
> +	struct xilinx_pcie_dma *port = (struct xilinx_pcie_dma *)dev_id;
> +	struct device *dev = port->dev;
> +	struct irq_data *d;
> +
> +	d = irq_domain_get_irq_data(port->pldma_domain, irq);
> +	switch (d->hwirq) {
> +	case XILINX_PCIE_INTR_CORRECTABLE:
> +	case XILINX_PCIE_INTR_NONFATAL:
> +	case XILINX_PCIE_INTR_FATAL:
> +		xilinx_pcie_dma_clear_err_interrupts(port);
> +		fallthrough;
> +
> +	default:
> +		if (intr_cause[d->hwirq].str)
> +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +		else
> +			dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irq_chip xilinx_msi_irq_chip = {
> +	.name = "xilinx_pcie_dmapcie:msi",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info xilinx_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		MSI_FLAG_MULTI_PCI_MSI),
> +	.chip = &xilinx_msi_irq_chip,
> +};
> +
> +static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct xilinx_pcie_dma *pcie = irq_data_get_irq_chip_data(data);
> +	phys_addr_t msi_addr = pcie->phys_reg_base;
> +
> +	msg->address_lo = lower_32_bits(msi_addr);
> +	msg->address_hi = upper_32_bits(msi_addr);
> +	msg->data = data->hwirq;
> +}
> +
> +static int xilinx_msi_set_affinity(struct irq_data *irq_data,
> +				   const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip xilinx_irq_chip = {
> +	.name = "Xilinx MSI",
> +	.irq_compose_msi_msg = xilinx_compose_msi_msg,
> +	.irq_set_affinity = xilinx_msi_set_affinity,
> +};
> +
> +static int xilinx_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	struct xilinx_pcie_dma *pcie = domain->host_data;
> +	struct xilinx_msi *msi = &pcie->msi;
> +	int bit;
> +	int i;

single line

> +
> +	mutex_lock(&msi->lock);
> +	bit = bitmap_find_free_region(msi->bitmap, XILINX_NUM_MSI_IRQS,
> +				      get_count_order(nr_irqs));
> +	if (bit < 0) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, bit + i, &xilinx_irq_chip,
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
> +	}
> +	mutex_unlock(&msi->lock);
> +	return 0;
> +}
> +
> +static void xilinx_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct xilinx_pcie_dma *pcie = irq_data_get_irq_chip_data(data);
> +	struct xilinx_msi *msi = &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +	bitmap_release_region(msi->bitmap, data->hwirq,
> +			      get_count_order(nr_irqs));
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops dev_msi_domain_ops = {
> +	.alloc  = xilinx_irq_domain_alloc,
> +	.free   = xilinx_irq_domain_free,
> +};
> +
> +static void xilinx_pcie_dma_free_interrupts(struct xilinx_pcie_dma *port)
> +{
> +	irq_set_chained_handler_and_data(port->msi.irq_msi0, NULL, NULL);
> +	irq_set_chained_handler_and_data(port->msi.irq_msi1, NULL, NULL);
> +}
> +
> +static void xilinx_pcie_dma_free_irq_domains(struct xilinx_pcie_dma *port)
> +{
> +	struct xilinx_msi *msi = &port->msi;
> +
> +	if (port->leg_domain) {
> +		irq_domain_remove(port->leg_domain);
> +		port->leg_domain = NULL;
> +	}
> +
> +	if (msi->dev_domain) {
> +		irq_domain_remove(msi->dev_domain);
> +		msi->dev_domain = NULL;
> +	}
> +
> +	if (msi->msi_domain) {
> +		irq_domain_remove(msi->msi_domain);
> +		msi->msi_domain = NULL;
> +	}
> +}
> +
> +static int xilinx_pcie_dma_init_msi_irq_domain(struct xilinx_pcie_dma *port)
> +{
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
> +	struct xilinx_msi *msi = &port->msi;
> +	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
> +	struct device *dev = port->dev;

reverse christmas tree

> +
> +	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
> +						&dev_msi_domain_ops, port);
> +	if (!msi->dev_domain)
> +		goto out;
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> +						    &xilinx_msi_domain_info,
> +						    msi->dev_domain);
> +	if (!msi->msi_domain)
> +		goto out;
> +
> +	mutex_init(&msi->lock);
> +	msi->bitmap = kzalloc(size, GFP_KERNEL);
> +	if (!msi->bitmap)
> +		goto out;
> +
> +	raw_spin_lock_init(&port->lock);
> +	xilinx_pcie_dma_enable_msi(port);
> +
> +	return 0;
> +
> +out:
> +	xilinx_pcie_dma_free_irq_domains(port);
> +	dev_err(dev, "Failed to allocate MSI IRQ domains\n");
> +	return -ENOMEM;
> +}
> +
> +static void xilinx_pcie_dma_intx_flow(struct irq_desc *desc)
> +{
> +	struct xilinx_pcie_dma *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long val;
> +	int i;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
> +			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
> +
> +	for_each_set_bit(i, &val, PCI_NUM_INTX)
> +		generic_handle_domain_irq(port->leg_domain, i);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void xilinx_pcie_dma_mask_event_irq(struct irq_data *d)
> +{
> +	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	val &= ~BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void xilinx_pcie_dma_unmask_event_irq(struct irq_data *d)
> +{
> +	struct xilinx_pcie_dma *port = irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val = pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	val |= BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip xilinx_pcie_dma_event_irq_chip = {
> +	.name           = "RC-Event",
> +	.irq_mask       = xilinx_pcie_dma_mask_event_irq,
> +	.irq_unmask     = xilinx_pcie_dma_unmask_event_irq,
> +};
> +
> +static int xilinx_pcie_dma_event_map(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &xilinx_pcie_dma_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);

nit: newline here.

> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops = {
> +	.map = xilinx_pcie_dma_event_map,
> +};
> +
> +/**
> + * xilinx_pcie_dma_init_irq_domain - Initialize IRQ domain
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_pcie_dma_init_irq_domain(struct xilinx_pcie_dma *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node;
> +	int ret;
> +
> +	/* Setup INTx */
> +	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return PTR_ERR(pcie_intc_node);
> +	}
> +
> +	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
> +						   &event_domain_ops, port);
> +	if (!port->pldma_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
> +
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						 &intx_domain_ops,
> +						 port);
> +	if (!port->leg_domain) {
> +		dev_err(dev, "Failed to get a legacy IRQ domain\n");
> +		return PTR_ERR(port->leg_domain);
> +	}
> +
> +	irq_domain_update_bus_token(port->leg_domain, DOMAIN_BUS_WIRED);
> +
> +	ret = xilinx_pcie_dma_init_msi_irq_domain(port);
> +	if (ret != 0) {
> +		irq_domain_remove(port->leg_domain);
> +		return -ENOMEM;
> +	}
> +
> +	of_node_put(pcie_intc_node);
> +	raw_spin_lock_init(&port->lock);
> +
> +	return 0;
> +out:
> +	return -ENOMEM;

used only once - use it directly.

> +}
> +
> +static int xilinx_pcie_dma_setup_irq(struct xilinx_pcie_dma *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq;
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;
> +
> +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq = irq_create_mapping(port->pldma_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map interrupt\n");
> +			return -ENXIO;
> +		}
> +
> +		err = devm_request_irq(dev, irq, xilinx_pcie_dma_intr_handler,
> +				       0, intr_cause[i].sym, port);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	port->intx_irq = irq_create_mapping(port->pldma_domain,
> +					    XILINX_PCIE_INTR_INTX);
> +	if (!port->intx_irq) {
> +		dev_err(dev, "Failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(port->intx_irq,
> +					 xilinx_pcie_dma_intx_flow, port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(port->irq,
> +					 xilinx_pcie_dma_event_flow, port);
> +
> +	return 0;
> +}
> +
> +static void xilinx_pcie_dma_init_port(struct xilinx_pcie_dma *port)
> +{
> +	if (xilinx_pcie_dma_linkup(port))
> +		dev_info(port->dev, "PCIe Link is UP\n");
> +	else
> +		dev_info(port->dev, "PCIe Link is DOWN\n");
> +
> +	/* Disable all interrupts */
> +	pcie_write(port, ~XILINX_PCIE_DMA_IDR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_IMR);
> +
> +	/* Clear pending interrupts */
> +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_IDR) &
> +			 XILINX_PCIE_DMA_IMR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_IDR);
> +
> +	/* Needed for MSI DECODE MODE */
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_HI_MASK);
> +
> +	/* Enable the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
> +			 XILINX_PCIE_DMA_REG_RPSC_BEN,
> +		   XILINX_PCIE_DMA_REG_RPSC);
> +}
> +
> +static int xilinx_request_msi_irq(struct xilinx_pcie_dma *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	port->msi.irq_msi0 = platform_get_irq_byname(pdev, "msi0");
> +	if (port->msi.irq_msi0 <= 0) {
> +		dev_err(dev, "Unable to find msi0 IRQ line\n");
> +		return port->msi.irq_msi0;
> +	}
> +
> +	irq_set_chained_handler_and_data(port->msi.irq_msi0,
> +					 xilinx_pcie_dma_msi_handler_low,
> +					 port);
> +
> +	port->msi.irq_msi1 = platform_get_irq_byname(pdev, "msi1");
> +	if (port->msi.irq_msi1 <= 0) {
> +		irq_set_chained_handler_and_data(port->msi.irq_msi0,
> +						 NULL, NULL);
> +		dev_err(dev, "Unable to find msi1 IRQ line\n");
> +		return port->msi.irq_msi1;
> +	}
> +
> +	irq_set_chained_handler_and_data(port->msi.irq_msi1,
> +					 xilinx_pcie_dma_msi_handler_high,
> +					 port);
> +
> +	return 0;
> +}
> +
> +static int xilinx_pcie_dma_parse_dt(struct xilinx_pcie_dma *port,
> +				    struct resource *bus_range)
> +{
> +	struct device *dev = port->dev;
> +	int err;

move it to the end.

> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return -ENXIO;
> +	}
> +	port->phys_reg_base = res->start;
> +
> +	port->cfg = pci_ecam_create(dev, res, bus_range, &xilinx_pcie_dma_ops);
> +	if (IS_ERR(port->cfg))
> +		return PTR_ERR(port->cfg);
> +
> +	port->reg_base = port->cfg->win;
> +
> +	err = xilinx_request_msi_irq(port);
> +	if (err) {
> +		pci_ecam_free(port->cfg);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xilinx_pcie_dma_probe(struct platform_device *pdev)
> +{
> +	struct xilinx_pcie_dma *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *bus;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	port = pci_host_bridge_priv(bridge);
> +
> +	port->dev = dev;
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	err = xilinx_pcie_dma_parse_dt(port, bus->res);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		return err;
> +	}
> +
> +	xilinx_pcie_dma_init_port(port);
> +
> +	err = xilinx_pcie_dma_init_irq_domain(port);
> +	if (err)
> +		goto err_irq_domain;
> +
> +	err = xilinx_pcie_dma_setup_irq(port);
> +
> +	bridge->sysdata = port;
> +	bridge->ops = (struct pci_ops *)&xilinx_pcie_dma_ops.pci_ops;
> +
> +	err = pci_host_probe(bridge);
> +	if (err < 0)
> +		goto err_host_bridge;
> +
> +	return 0;
> +
> +err_host_bridge:
> +	xilinx_pcie_dma_free_irq_domains(port);
> +
> +err_irq_domain:
> +	pci_ecam_free(port->cfg);
> +	xilinx_pcie_dma_free_interrupts(port);
> +	return err;
> +}
> +
> +static const struct of_device_id xilinx_pcie_dma_of_match[] = {
> +	{
> +		.compatible = "xlnx,xdma-host-3.00",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver xilinx_pcie_dma_driver = {
> +	.driver = {
> +		.name = "xilinx-xdma-pcie",
> +		.of_match_table = xilinx_pcie_dma_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = xilinx_pcie_dma_probe,
> +};
> +
> +builtin_platform_driver(xilinx_pcie_dma_driver);
> diff --git a/drivers/pci/controller/pcie-xilinx-common.h b/drivers/pci/controller/pcie-xilinx-common.h
> index 015dba3..986e9bf 100644
> --- a/drivers/pci/controller/pcie-xilinx-common.h
> +++ b/drivers/pci/controller/pcie-xilinx-common.h
> @@ -19,6 +19,7 @@
>   #define XILINX_PCIE_INTR_PME_TO_ACK_RCVD	15
>   #define XILINX_PCIE_INTR_INTX			16
>   #define XILINX_PCIE_INTR_PM_PME_RCVD		17
> +#define XILINX_PCIE_INTR_MSI			17
>   #define XILINX_PCIE_INTR_SLV_UNSUPP		20
>   #define XILINX_PCIE_INTR_SLV_UNEXP		21
>   #define XILINX_PCIE_INTR_SLV_COMPL		22


M
