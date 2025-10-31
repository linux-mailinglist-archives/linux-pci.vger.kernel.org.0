Return-Path: <linux-pci+bounces-39911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5EEC241E0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEFDC34F9BB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF463314D7;
	Fri, 31 Oct 2025 09:22:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023130.outbound.protection.outlook.com [52.101.127.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F31DDBB;
	Fri, 31 Oct 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902578; cv=fail; b=HNZufIQiOL6okM3jQyZS5AKtzFIY715/bJCtyGnhLl1/DNSxYiPI+bDlm8cCIy70adnN/ZzZXok2exoYPzfxIgkp0sf4t6QUj9aUfYFHpzJmQ9+6nCjBJVz4NwWVzI2bWj3aAwSF5ImNaxjMzqZ49RHjB8QSclnqbvA4WOhr90g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902578; c=relaxed/simple;
	bh=Xzkdx4QTafBXsStNTdJT0seGef3G48+xAq12u3A0oeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roRm7TsfF2vl9BVpgXQEct9jqI6NsNSJEgz5iksx90pgzkTA9x2L60eVuO+PkdVTSQg8a93hTU4iWEe2bbqSbwm46tByaNKpjKpHp1TSpji538n08bBuOJA12M5bgSBOvT2o3MJO7By7y+wPVQXH6ntyBrU3QSwg7kd2MOoFtek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcqTrZu7SLxXea5dpBHb4YpOIN6GdiRd+4Bvrhe4Tv9bx+GvYyrSH6H+N88trEcp8uh/ZPDXwrjlDkCYzDy8htm0WD23n0heqgH0Z0B4bAVbclXhQnWcH2hBW9/6p3Mqy9XEMzfkpl9UYQuHkV04g6x9CWjowDpZlaUSQr8RR0AidO93crG94HlaMKqIAfmnqRZhd5RfU2C41yDHNBbYN7+YhNNdYzabE5x3SAP2bnfYzkaPfREXYo5v9ZIUajomtbR3B/gseKPcZXuJE1IFpJ31b7/y9L0rkhjT1IUQCYUfz+27kmaksIiHJHkfDEjYoDMGRMFF1y8MoysbYFM4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6eYtTL0DQhhbLLDjkdPhsGYhqMz2kAOuy2S58hQrCk=;
 b=TIZc1VrPGLUMePCZH0rFeaMWZ6zKyiFt0lPxUFthS/LeB14htfMZ4AYM6+FXz5sANSVfwdPJxr/tJ1QjWFDwTznRbCu6w9HZOuGMf+67J2gVYC17qa4ZCftevdPL83/itVBaOAcsvpSFwqSgvNZK1gHcjf2Y8d1rWiddryOpgUU2qkfpLVO5g4/1AuMTv5+DJt8Xby5wWL9I/o5/EHyqn8bvwWdLAWZM2WcACqor1HS3kjCiLk62Hwvem60WYZCJRwxO2LlXOmtT+ksrPYxZNgwz0OwaTj4Ww93i5+5/ERujFpmIr7h9+dCJcBq9BR2aJp1E9T/lGCOxq7aPam4Xbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0090.apcprd02.prod.outlook.com (2603:1096:300:5c::30)
 by PUZPR06MB5652.apcprd06.prod.outlook.com (2603:1096:301:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 09:22:52 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::80) by PS2PR02CA0090.outlook.office365.com
 (2603:1096:300:5c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 09:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:22:51 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5A30A41C0145;
	Fri, 31 Oct 2025 17:22:50 +0800 (CST)
Message-ID: <0f5a28f4-ecf3-4a47-aa09-ab5b0e08e1d5@cixtech.com>
Date: Fri, 31 Oct 2025 17:22:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/10] PCI: sky1: Add PCIe host support for CIX Sky1
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-8-hans.zhang@cixtech.com>
 <aoxdmg4mxa7j575vzjw66uo5i6ibvfkgkrqhy6bhwpie7v4rk7@yj5fmhplivxp>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <aoxdmg4mxa7j575vzjw66uo5i6ibvfkgkrqhy6bhwpie7v4rk7@yj5fmhplivxp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|PUZPR06MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 1434953c-36f6-46d5-eb59-08de185f10db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VrS0o1U29YYmwxdVM2YWI3OHozSlJBS0txekZTL09QK1M2WlJSK3lCVHI3?=
 =?utf-8?B?bGtJWEZQZGpQanlQeDA0MmRwcHNsNGlOQzJrOWkrOU1OY25vL25ta0hkcVlk?=
 =?utf-8?B?S1MxVTU1Qm9OcFNudkV3a2dVRm54OVpJUFdIbW5GU1VsUzBZRkhPbUZDeTNi?=
 =?utf-8?B?eG1nekpMeXFvOHZnWDRCWEw0RktMYVFTSWtOMmlPZWsxUDRUNXlGRjVhNU1Q?=
 =?utf-8?B?ZVgzTFRRKzZweWdWTG9CaTl6S1l3UlM0d2I1cXhCQkZPbVk5Z2k0VDZNR3dJ?=
 =?utf-8?B?TXA3RmcvMUJyMTNNaTRrZ3JVZTBiS0RIK1g2eU5ZMFZUd1ZzUFZ3MFhvNmF1?=
 =?utf-8?B?TzRoeUNrRlNPZXV6bFZoQUdjaGJnZWwwTUJHTzdzYTVnK2hBU2FENEwxTjlm?=
 =?utf-8?B?VTU4US9RZUFkbkNPRC81T0tCNXhtU2R6cXZKYy9yWW91dURuUkg3aG1MWlJI?=
 =?utf-8?B?M3VLMGtKbHJYWnMrQ3BDUUk2YnVML05pOWVIcnRFemJ1SEsydFlKUHJoaHZ1?=
 =?utf-8?B?b2VjS0RuL0QxblUwNG9FTUpyVk1FVFdSMWE4eFFVS2ZqeHQrVGFwbU1ZSW5o?=
 =?utf-8?B?OGMvbmNqNERHWDd3Y0F3aXdnVlRoT2lGRlpXOG1Ma3FUVUozNW9xOGcvZnpL?=
 =?utf-8?B?YkJCN0F1dmRwMUZUanRMVnU4MWFDQXU4d3BUaUZlYTIwd3cwTnFwOGpRYkJD?=
 =?utf-8?B?Q3pqMlpwUTNidmg2d1BMak5qbDFGZDNReDFmWWJaRGxCQjRpcEVSMkV4K0dG?=
 =?utf-8?B?UnJ2V1RRc3A3YnZzYWRKUklnMnlSWmk1Ym04UkJGUk1qZXh0SGNvK1RESVJp?=
 =?utf-8?B?VVNBb01ScDVjaU1pa0UzdWZGSnpaU2FvaGtZd3ZDU3pra2syYmhCem5HMWJR?=
 =?utf-8?B?U3UxL2VUZ0JWSU5DNmxlOTdjVHNnQnp3YVZ0NWdOdmg0YmorZW5hcmtzRzMy?=
 =?utf-8?B?WlBvamNBWUx2TTZZZjBqR2JOQVFsMGN1WnRRZHR5Skh4dEEvRG1Lc2dwY01J?=
 =?utf-8?B?TWVHSHlSdTd6V3AzNk9xVzBTb3luSUE4SWxNMXdHc21zZWRROThMYzJ1b25m?=
 =?utf-8?B?dTRxb3dJNVdVNXdhUzhDcXdIc3hWZDVRajVETDVTeWlmdkxPYytSZ3E2ZFdl?=
 =?utf-8?B?Y08xTFErZGFDU1ZIMWRjTW1NcnhQSzdkU2ZEK2xxVmZmVk9Rbmo4amZJKzcr?=
 =?utf-8?B?VUhkMGtjSHpDcUhzTnhmdi84Wm9yM0VrMlhZTVJpQTU4UHpvTmNMZDlCZ3RE?=
 =?utf-8?B?cnR0bE9DVUpWTjd1QWJsczRNVExTeG9XSDIwclBsOHhvdjRrdW5vbTdNT2w2?=
 =?utf-8?B?c1h0ckExUFVVQnlXRkFNSEEyTWZNazMvSDBLK0hwbkJSSXZQNWtqNEp2RXpu?=
 =?utf-8?B?alREMlc1SEtPREdPcDJFSEN6QldDejFqOGhJZCtENGwrNStVcU92S2VRZmh0?=
 =?utf-8?B?Mi9NUTlYeWRkWDZOSEllNmllcGNjVGlnQUlhRlBxcGZpTlo1QXpyT3IzYkZh?=
 =?utf-8?B?YWF1eEpiMWlBT3dYeFRvUVpGKzIyVkhrT29wNkxVY3JIWk4xc2U3YXR4eVBk?=
 =?utf-8?B?U285U3ZWZk92NEJSZ0I0K2xScjRlejB5eklYUU5JNVRtMUx5T1JtN1BZdTdm?=
 =?utf-8?B?N1A1OEJ5TUdGSU9SRFNMb1NoczNiNzgyUnd6UlNMVWpRN0ZZNVdVdmpNc2tF?=
 =?utf-8?B?Y1B2QnpFREZLbzdSMVV3Y0FFZGRXaFRjb0xOMFpxUEhydE1Pc2dYbmJRdnRO?=
 =?utf-8?B?SlByang5MGlJUnZ0NHk3UklWNWxmdi9pcVhycHFOV0VWYmFCRmIrMW5kVG0y?=
 =?utf-8?B?aTNVa1YvSmw0a1RLOXRQRHdyUVNoL3U3Y2Z1UHVJd2syeWZ4MnhFTXYyYUZ5?=
 =?utf-8?B?VGwvYmN5OVZxVDZmZjB3cWtOQkR3RElib1g1YUFPZE9vaHFWa2sxeGVPeDNy?=
 =?utf-8?B?bHVhMTRTSzRyWmpIb0xQVlcvbmJ6aWhGbDErVGRMVGxIOXN0aUtUY3dXdWtr?=
 =?utf-8?B?ZWtjUWtITVArNHdXUFBwYkl2VXowVWR4b0ovUnE3M1puRmc5NHluWFR5dFd6?=
 =?utf-8?B?VTFPTG9BeDMwbE5vN09qQjF2Q2xCZ2J1UFU2N0NrbGZBVm5vM0tFZk5rYi9w?=
 =?utf-8?Q?wqP0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:22:51.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1434953c-36f6-46d5-eb59-08de185f10db
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5652



On 10/31/2025 5:15 PM, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Mon, Oct 20, 2025 at 12:28:54PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
>> on the Cadence PCIe core.
>>
>> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   drivers/pci/controller/cadence/Kconfig    |  15 ++
>>   drivers/pci/controller/cadence/Makefile   |   1 +
>>   drivers/pci/controller/cadence/pci-sky1.c | 233 ++++++++++++++++++++++
>>   3 files changed, 249 insertions(+)
>>   create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
>>
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 0b96499ae354..ceff65934e5f 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -51,6 +51,21 @@ config PCIE_SG2042_HOST
>>          controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
>>          PCIe core.
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
>> index 30189045a166..b8ec1cecfaa8 100644
>> --- a/drivers/pci/controller/cadence/Makefile
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -9,3 +9,4 @@ obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>>   obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>>   obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
>> +obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
>> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
>> new file mode 100644
>> index 000000000000..4b0388394db3
>> --- /dev/null
>> +++ b/drivers/pci/controller/cadence/pci-sky1.c
>> @@ -0,0 +1,233 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe controller driver for CIX's sky1 SoCs
>> + *
>> + * Copyright 2025 Cix Technology Group Co., Ltd.
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
>> +#define LINK_TRAINING_ENABLE         BIT(0)
>> +#define LINK_COMPLETE                        BIT(0)
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
>> +                                  "unable to find \"reg\" registers\n");
>> +     pcie->reg_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
>> +     if (!res)
>> +             return dev_err_probe(dev, ENXIO, "unable to get \"cfg\" resource\n");
> 
> s/ENXIO/ENODEV


Hi Mani,

Thank you very much for your reply.

Will change.

> 
>> +     pcie->cfg_res = res;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "unable to find \"rcsu_strap\" registers\n");
>> +     pcie->strap_base = base;
>> +
>> +     base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
>> +     if (IS_ERR(base))
>> +             return dev_err_probe(dev, PTR_ERR(base),
>> +                                  "unable to find \"rcsu_status\" registers\n");
>> +     pcie->status_base = base;
>> +
>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
>> +     if (!res)
>> +             return dev_err_probe(dev, ENXIO, "unable to get \"msg\" resource\n");
> 
> s/ENXIO/ENODEV

Will change.

> 
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
>> +             return ret;
>> +
>> +     bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
>> +     if (!bus)
>> +             return -ENODEV;
>> +
>> +     pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
>> +                                 &pci_generic_ecam_ops);
>> +     if (IS_ERR(pcie->cfg))
>> +             return PTR_ERR(pcie->cfg);
>> +
>> +     bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
>> +     rc = pci_host_bridge_priv(bridge);
>> +     rc->ecam_supported = 1;
>> +     rc->cfg_base = pcie->cfg->win;
>> +     rc->cfg_res = &pcie->cfg->res;
>> +
>> +     cdns_pcie = &rc->pcie;
>> +     cdns_pcie->dev = dev;
>> +     cdns_pcie->ops = &sky1_pcie_ops;
>> +     cdns_pcie->reg_base = pcie->reg_base;
>> +     cdns_pcie->msg_res = pcie->msg_res;
>> +     cdns_pcie->is_rc = 1;
>> +
>> +     reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
>> +     if (!reg_off)
>> +             return -ENOMEM;
>> +
>> +     reg_off->ip_reg_bank_offset = SKY1_IP_REG_BANK;
>> +     reg_off->ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK;
>> +     reg_off->axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON;
>> +     reg_off->axi_slave_offset = SKY1_AXI_SLAVE;
>> +     reg_off->axi_master_offset = SKY1_AXI_MASTER;
>> +     reg_off->axi_hls_offset = SKY1_AXI_HLS_REGISTERS;
>> +     reg_off->axi_ras_offset = SKY1_AXI_RAS_REGISTERS;
>> +     reg_off->axi_dti_offset = SKY1_DTI_REGISTERS;
>> +     cdns_pcie->cdns_pcie_reg_offsets = reg_off;
>> +
>> +     pcie->cdns_pcie = cdns_pcie;
>> +     pcie->cdns_pcie_rc = rc;
>> +     pcie->cfg_base = rc->cfg_base;
>> +     bridge->sysdata = pcie->cfg;
>> +
>> +     rc->vendor_id = PCI_VENDOR_ID_CIX;
>> +     rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
>> +     rc->no_inbound_map = 1;
>> +
>> +     dev_set_drvdata(dev, pcie);
>> +
>> +     ret = cdns_pcie_hpa_host_setup(rc);
>> +     if (ret < 0) {
>> +             pci_ecam_free(pcie->cfg);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id of_sky1_pcie_match[] = {
>> +     { .compatible = "cix,sky1-pcie-host", },
>> +     {},
>> +};
> 
> Missing MODULE_DEVICE_TABLE(). Your driver is not going to be auto loaded.

Will add.

> 
>> +
>> +static void sky1_pcie_remove(struct platform_device *pdev)
>> +{
>> +     struct sky1_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +     pci_ecam_free(pcie->cfg);
>> +}
>> +
>> +static struct platform_driver sky1_pcie_driver = {
>> +     .probe  = sky1_pcie_probe,
>> +     .remove = sky1_pcie_remove,
>> +     .driver = {
>> +             .name = "sky1-pcie",
>> +             .of_match_table = of_sky1_pcie_match,
> 
> Use .probe_type = PROBE_PREFER_ASYNCHRONOUS.

Will change. Thank you for your reminder.

Best regards,
Hans

> 
> - Mani
> 
> --
> மணிவண்ணன் சதாசிவம்


