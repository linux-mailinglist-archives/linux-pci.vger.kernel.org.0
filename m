Return-Path: <linux-pci+bounces-35212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F5B3D6EF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335A173AF5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374FC1FBC8C;
	Mon,  1 Sep 2025 03:05:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022075.outbound.protection.outlook.com [40.107.75.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A251E1E16;
	Mon,  1 Sep 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695910; cv=fail; b=INOIXc5fo4g/0fiUf8omVFj9qeuu51aTOasbI0e4x7nUXBw4sMxnp5YysgWbQIlhawpoNVagbuLhV1vmZkoX9vl2wwv3VGcHQz8S5yXkMeBA1n8rmOUti47JCfQs0fkfwF9Wu5Ix0BnHCkPUElX3MI4O3ghBiCHrdPPDzUbA+oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695910; c=relaxed/simple;
	bh=gi4b1y+TPRxUATV26/TkdU1p2nomlfh5bSVV3QOCY/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg6yGewEYQC5vPi2k8zA2PeH3rJ9rx1fOoAjNJA+UgUCVESKW/9ECZDlWF6zsG1aG1FmOy4q+OGMjtCMnAg5IhszzyFZ7C+/DgSK9CmMCmDfoWDd8u3kfeYvWVsx8tVVVuqY2UEYGKyhdtr5rkPaxz75/wqmDeFDUBy7pYMgiKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLl/m5YrWhhTJbty7T+t3oP11bmM2IjWiR+yWxI36L3ENvRLjjlqWH6xy9KuESH1xTjKgwzNGyvaN3cq75s9Z8QGmQVO9a9JhpMQs4ZLl2rkfAZiSe6Y5gYyBGDzNvHj/lL09ZOTt06WZ20sFeM8ZASha0tkLisUZBMwZTedhTDB3vR1qi2P9ABc42M9SXDC1x5X7BHfFtvZ+v+d+pVd0JGxiUozUX9WazQK2fQR+T75gMnsySNbWUcL/kLwQk8pkg0UoCUr5e/c3epuWxfQcmYY1ERsou0Lh6wK2sNFZnRoen+yiRzPrRoV9UxzBvTLeLS+0OV2AxewgCvb8EoJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmnBCJ8719Otbm++ewN44BHdd3tqzY4gE+SrAFcOJYw=;
 b=SBLgWk//JZStg5dEvsAzWocWYUTv8Dw2ZZxY8Lzm7bYBqM4JIT14PBzH367V9NSTS5NtYx1qqL3S/Egr1nLn6FeZ14UNuQHfG1qY3Ev/IVH+HQQzAXZzDGyU8+ZslFxg7Hktb4NVS736xW+JrDCk9kGRY5nGgSljrRvLltSlvNjujP1Ay0RwWYkoF+Az0RcdjtksZBHdPwOk39x3YTCiROBO0JguPhGSgIrt5GrNC0vhbQi/OBnfEZLXsaj/HlwE1DCZ5ye0SmnDmYonSu041oKS2RGoeGGI4TIvH2v8QzCPqFSAqXhR/oVCVTBolfVoWghLXRxGh9nMlHawPjofZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) by
 KL1PR0601MB5568.apcprd06.prod.outlook.com (2603:1096:820:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Mon, 1 Sep
 2025 03:05:00 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:36) by SG2P153CA0009.outlook.office365.com
 (2603:1096::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.4 via Frontend Transport; Mon, 1
 Sep 2025 03:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:04:59 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 979AC41604E2;
	Mon,  1 Sep 2025 11:04:58 +0800 (CST)
Message-ID: <6e195d6e-2d3f-4550-bee1-05e085832034@cixtech.com>
Date: Mon, 1 Sep 2025 11:04:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/15] PCI: sky1: Add PCIe host support for CIX Sky1
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-13-hans.zhang@cixtech.com>
 <ssk2aolyodglbfvql66uk3snopnyneocoom2ymqhqc4lywugfo@2hmsuzgrutuw>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <ssk2aolyodglbfvql66uk3snopnyneocoom2ymqhqc4lywugfo@2hmsuzgrutuw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|KL1PR0601MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd0aaa3-dcb6-478d-40c9-08dde9045680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZZa1VhS2YrYUtKY1N2Ymo2aXJ3S0prWTJSbGFGWlN4MEN0UjY3U2tyU09x?=
 =?utf-8?B?VC85Sng4R050RGVqOVBFdEN4ckxhUjdUYU1FdVY0VjFPZmZZRW9udmdkUEJV?=
 =?utf-8?B?WnoyM3grV2Z6MlJwemFLdlAzclhKcWlaZVlMRmFTVm9nbDFvdm1EL1JHTjNH?=
 =?utf-8?B?OW1NZGtRYjJVcXk4V1lGR212NEp4c0wycU92VjVQVE12VmIrS0NseWVpWkRY?=
 =?utf-8?B?RDJ2SW5yNHFIU0dBMXR3RHlLREFhRSsrY3ozc2I3bEtJQTJ4V0paR3BtZ1Bx?=
 =?utf-8?B?ZGFXWE9Kemd5WjhXUWUzdDlrNzFTeERGaHBER1pQc0J6TUw2U1BuWXpVcUlp?=
 =?utf-8?B?Mzg4c2I2Q0RzcWVnVW12ZVhXZ1ZxTXR0R3JGbmp2bGErQXdBcXFNWmZPUmZq?=
 =?utf-8?B?ZG9RWWVRc21kYnpLbVBiMit0QUdwR05QNGtCYnA2bk1rT3l5WnRscGFUT2ds?=
 =?utf-8?B?NUw5VlQrTW5nVE82RFNpZXJZbTcyUnA0WFNWUU5FN0Rzd2NzUWZYOWI5UVM4?=
 =?utf-8?B?bmVyc0ZMYUpOZElMN1N0WHJERnJjS04raUQ0YmlYQ25RVllHcTJhWDRBUHEr?=
 =?utf-8?B?b1B5VlhUM2hyTjJwb2JiUDNaUExLYlJtQjRIMUpzYjNuYkVHaWluaFBXa2Ja?=
 =?utf-8?B?VVhwai9LL2xjaWpwanY5ZGRlL0hVei9Belc3MHhvNXlPKzg0MGZ2SGpDK2N4?=
 =?utf-8?B?anJzMUZzYldHWEM5NXZXOHhTL1lVbEkzTlorOGpHa0MxSWFkK00waTlITHRU?=
 =?utf-8?B?WHhPdkdWdDRTZHpoUjBPbWMwaUxVaEszQTBSQ2ZHMVpKcmVFVE55ekdramhs?=
 =?utf-8?B?bHorQ24rWlkzVFgwUk5ycjJPQVBlMXZNeGZFUGxDdGxBQ1JGN3ZiN0l2STBV?=
 =?utf-8?B?MTUycThJc2JOUm9BWVUzbFhSNUtMN1h3ZHk5Z21BYUxKcVhQTzZwUmdsSWVh?=
 =?utf-8?B?UGN6R0ljVkJYSWRnK0FObFRlbzA3clZRVGJyNzUyenNaY0JsOVpQYmZBWG4z?=
 =?utf-8?B?VDNYaVQvWGxyaHpFN3Jmc2dkQkU3QTFQV2lPV2NrN2FsdGpHRTdTY3Z4RFhW?=
 =?utf-8?B?YjQ3eXZ2NStUZnFUMnF5d282MjRPV1czOGw3dGhESDUrMDJKNldRU2JDMFo3?=
 =?utf-8?B?OHB1MVNlblJHZ3lBY3EvbFlUN3NTeUsveEVnV01UOCtoWWJOQVF5VkpUK2Jq?=
 =?utf-8?B?S2RpUVBzNnB6T2lxN1ZHdTBNRnBZTTc2VTVrMHNBN2JwM0VLZk1NZTMrbXlD?=
 =?utf-8?B?aG1qeGI1OEwyL1Nmb3lyaUhSZlYwNlh1TzRYbDNidnp1am1CN0xzKzFJeHRO?=
 =?utf-8?B?ZjlKWnhXL3RqUW1FcXVsN09UdVpGS21EU3hETkh6eElKK2FWd1VFZUxVb0RS?=
 =?utf-8?B?RUtEY1ZwdStTMUIzUEdHMy9IOHpHK1F1QkdESXErLzBHUHVsMUtodERRZU1N?=
 =?utf-8?B?UHVnSWFTS2p6eWYxeU43RFlHb292R0hNaXFpNDA2VTh5NnprODZDTDNReE5K?=
 =?utf-8?B?Q3FFWmFCYytyOEI5NWhxQU1KWGxqNTVSZDY2R0YrRnNPS2kxc1RzQzZkbEFl?=
 =?utf-8?B?am9MMGs2TDI4b3Z0bUFQVmc4ZjFuR0pmTlJpMVVteHU3ZW9XL1ZnaWRnZWpi?=
 =?utf-8?B?ZjNYcys2dVVQblBTM0Nwby83UnFVS0VORVpPSmxJNWtXcFhMOTJ0bVg1Wm5D?=
 =?utf-8?B?bGRCL1l5UVEvNzJ2MXN6ZFRmV1prWEJ0NXNjYXI0ZkdsSkdaM0R1KzVhY1Nv?=
 =?utf-8?B?SHE3NVBiRUFkekoyQWFFSFFjUEpSUkZYaEtzam5uMkdrWVU2d3Y0ZkxRZzhT?=
 =?utf-8?B?UXR5a05wdEpxMko2TXZ2cUc2Sm93QXlwRW04d3lPL21wQUkzQnpoeGRQanp5?=
 =?utf-8?B?NUtqUWt0YlBRdy9hYUlFSE9UYm42N2huckFDeVJadmxINDh2ZDVBUW5VcXRp?=
 =?utf-8?B?VDVjcXY1S3dVRmVrTGhYQWRxQzV2M0p6WmJZK2xueHgydC8xZVpzNjQ5RUt2?=
 =?utf-8?B?cjBFZHJFSGh6VXlGMkYwQmRxdGJJL3ZWY3BWUkZLNUJ0dzhYSmhoeWFDT2pJ?=
 =?utf-8?Q?0fYn/j?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:04:59.5067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd0aaa3-dcb6-478d-40c9-08dde9045680
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5568



On 2025/8/30 21:29, Manivannan Sadhasivam wrote:
> [Some people who received this message don't often get email from mani@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, Aug 19, 2025 at 07:52:36PM GMT, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
>> on the Cadence PCIe core.
>>
>> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>> Changes for v8:
>> - Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
>> - Use devm_platform_ioremap_resource_byname.
>> ---
>>   drivers/pci/controller/cadence/Kconfig    |  15 ++
>>   drivers/pci/controller/cadence/Makefile   |   1 +
>>   drivers/pci/controller/cadence/pci-sky1.c | 232 ++++++++++++++++++++++
>>   3 files changed, 248 insertions(+)
>>   create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
>>
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 117677a23d68..26a248cdc78a 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -42,6 +42,21 @@ config PCIE_CADENCE_PLAT_EP
>>          endpoint mode. This PCIe controller may be embedded into many
>>          different vendors SoCs.
>>
>> +config PCI_SKY1_HOST
>> +     tristate "CIX SKY1 PCIe controller (host mode)"
>> +     depends on OF
>> +     select PCIE_CADENCE_HOST
>> +     select PCI_ECAM
>> +     help
>> +       Say Y here if you want to support the CIX SKY1 PCIe platform
>> +       controller in host mode. CIX SKY1 PCIe controller uses Cadence
>> +       HPA (High Performance Architecture IP [Second generation of
>> +       Cadence PCIe IP])
>> +
>> +       This driver requires Cadence PCIe core infrastructure
>> +       (PCIE_CADENCE_HOST) and hardware platform adaptation layer
>> +       to function.
>> +
>>   config PCI_J721E
>>        tristate
>>        select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
>> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
>> index de4ddae7aca4..40d7c6e98b4d 100644
>> --- a/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>>   obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>> +obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
>> new file mode 100644
>> index 000000000000..7dd3546275c5
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe controller driver for CIX's sky1 SoCs
>> + *
> 
> No copyright for CIX tech?

Dear Mani,

Thank you very much for your reply.

Will add.

> 
>> + * Author: Hans Zhang <hans.zhang@cixtech.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>> +#include <linux/pci_ids.h>
>> +
>> +#include "pcie-cadence.h"
>> +#include "pcie-cadence-host-common.h"
>> +
>> +#define STRAP_REG(n)                 ((n) * 0x04)
>> +#define STATUS_REG(n)                        ((n) * 0x04)
>> +#define  LINK_TRAINING_ENABLE                BIT(0)
>> +#define  LINK_COMPLETE                       BIT(0)
> 
> Extra space.

Will change.

> 
>> +
>> +#define SKY1_IP_REG_BANK             0x1000
>> +#define SKY1_IP_CFG_CTRL_REG_BANK    0x4c00
>> +#define SKY1_IP_AXI_MASTER_COMMON    0xf000
>> +#define SKY1_AXI_SLAVE                       0x9000
>> +#define SKY1_AXI_MASTER                      0xb000
>> +#define SKY1_AXI_HLS_REGISTERS               0xc000
>> +#define SKY1_AXI_RAS_REGISTERS               0xe000
>> +#define SKY1_DTI_REGISTERS           0xd000
>> +
>> +#define IP_REG_I_DBG_STS_0           0x420
>> +
>> +struct sky1_pcie {
>> +     struct cdns_pcie *cdns_pcie;
>> +     struct cdns_pcie_rc *cdns_pcie_rc;
>> +
>> +     struct resource *cfg_res;
>> +     struct resource *msg_res;
>> +     struct pci_config_window *cfg;
>> +     void __iomem *strap_base;
>> +     void __iomem *status_base;
>> +     void __iomem *reg_base;
>> +     void __iomem *cfg_base;
>> +     void __iomem *msg_base;
>> +};
>> +
>> +static int sky1_pcie_resource_get(struct platform_device *pdev,
>> +                               struct sky1_pcie *pcie)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct resource *res;
>> +     void __iomem *base;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "reg");
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "unable to find reg registers\n");
> 
> "unable to find \"reg\" registers". Same for below prints.

Will change.

> 
>> +     pcie->reg_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>> +     if (!res)
>> +             return dev_err_probe(dev, ENXIO, "unable to get cfg resource\n");
>> +     pcie->cfg_res = res;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "unable to find rcsu strap registers\n");
>> +     pcie->strap_base = base;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "unable to find rcsu status registers\n");
>> +     pcie->status_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
>> +     if (!res)
>> +             return dev_err_probe(dev, ENXIO, "unable to get msg resource\n");
>> +     pcie->msg_res = res;
>> +     pcie->msg_base = devm_ioremap_resource(dev, res);
>> +     if (IS_ERR(pcie->msg_base)) {
>> +             return dev_err_probe(dev, PTR_ERR(pcie->msg_base),
>> +                                  "unable to ioremap msg resource\n");
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +     u32 val;
>> +
>> +     val = readl(pcie->strap_base + STRAP_REG(1));
>> +     val |= LINK_TRAINING_ENABLE;
>> +     writel(val, pcie->strap_base + STRAP_REG(1));
>> +
>> +     return 0;
>> +}
>> +
>> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
>> +{
>> +     struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
>> +     u32 val;
>> +
>> +     val = readl(pcie->strap_base + STRAP_REG(1));
>> +     val &= ~LINK_TRAINING_ENABLE;
>> +     writel(val, pcie->strap_base + STRAP_REG(1));
>> +}
>> +
>> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
>> +{
>> +     u32 val;
>> +
>> +     val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
>> +                               IP_REG_I_DBG_STS_0);
>> +     return val & LINK_COMPLETE;
>> +}
>> +
>> +static const struct cdns_pcie_ops sky1_pcie_ops = {
>> +     .start_link = sky1_pcie_start_link,
>> +     .stop_link = sky1_pcie_stop_link,
>> +     .link_up = sky1_pcie_link_up,
>> +};
>> +
>> +static int sky1_pcie_probe(struct platform_device *pdev)
>> +{
>> +     struct cdns_plat_pcie_of_data *reg_off;
>> +     struct device *dev = &pdev->dev;
>> +     struct pci_host_bridge *bridge;
>> +     struct cdns_pcie *cdns_pcie;
>> +     struct resource_entry *bus;
>> +     struct cdns_pcie_rc *rc;
>> +     struct sky1_pcie *pcie;
>> +     int ret;
>> +
>> +     pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> +     if (!pcie)
>> +             return -ENOMEM;
>> +
>> +     bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +     if (!bridge)
>> +             return -ENOMEM;
>> +
>> +     ret = sky1_pcie_resource_get(pdev, pcie);
>> +     if (ret < 0)
>> +             return -ENXIO;
> 
> return ret;

Will change.

Best regards,
Hans

> 
> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்

