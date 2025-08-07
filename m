Return-Path: <linux-pci+bounces-33524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB0B1D330
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C10A18896A1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF5239099;
	Thu,  7 Aug 2025 07:21:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022076.outbound.protection.outlook.com [52.101.126.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAE1EDA02;
	Thu,  7 Aug 2025 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551271; cv=fail; b=kg4cxnF00aZnd1EjukFNPRhu+/tkKIxAuTB7hIXIVAa5n7UUEi7USRDIeocY3PPaY5F0Di+oG8ivsPhk/kjrXRYDHNY7uoEuIts0FjUXVKmbtpM/DAhg+xYWgiihrv+uGvOGrHjjoa0GhEZIZ8+rD08P5565SGGtDks5/DmmGt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551271; c=relaxed/simple;
	bh=CA8r/LusqQQaz4cVZr22MLnbcrh4LMIgOdzERpbrzjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9Akiw/JwZ3V8CEbzdPYTo8TDY7nl4v8ZMK8944xm+ORKeK5k6F8VDKONrnevCRNDKWe09vKON3sbBSzmnfSlOFy1N5oYB+himv1pvFb+dLOwmvWVwyqBucYQXuJ0oIWWGuxZ3d/BQ+0BX0jI+sCCbJyAvU3IM2IRIknimI8giI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9k6sEB7EmvWOhZ7OysIWKfiBy3Nb8DM03RZdOrQq8RZyQH7YBpES3IcK7iJwPQz6YuYWbfTH22BLF3Ue8hbYF5kQDrDxnLh+UyRuTQepuEGaPW0ShJCnWDvI8tJYoWba3fzW2eatAtTFWP9M22NyGWyvu5rIf12TCBztnj/8hRcFyoONDkc7XqsGwkdKkjZ5isF+lTwH/twGTzOSm2zahgO4rerOWX7YzBG4yuVptZa75AN5aj9VvpqCy6EhdHEINKEzKyEbAI9oD6CPeDX5PvIM0PRiuh3au9K8O4AshshQuBVQOnSLnqTmpqmxRKaa8fnSp3eFklKLCsaxkFrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gfLukVho6EgOfJbOIgjOVul8doQXxHp5WZpRC94zEA=;
 b=vslJGKFUFIsjastp9+rynVWrHcmXhy3lbyeZNTK0FqkmUw2WhLFj5uybDLf4Q7Q89qSc1x55uioQaRy2sKxyn+uvVzEo+mXvamaLUbyviuuCIUjEZ9TNhiOGu7+BcrFm6npo31ow8f3wOVP8TYSJkpUGPyw/t67dy9aW+IppuJgLVnpzCzSKrIRoyhnXMqHx72B98UIDJuowMKzvQFZpNswKPkbX1/nRbxR0YFu57yFUUHt+2WoIuJKiYCW27W/6YWTPdHz9dMsXWklpI65FOt0kpJBqjQ/30xPFvOGvGysicRaIJLZjJvCI8S4tKVGdlnhcCpAsUxfE6DmdtkVwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:404:42::22)
 by SG2PR06MB5189.apcprd06.prod.outlook.com (2603:1096:4:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 07:21:03 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:404:42:cafe::db) by TY2PR06CA0010.outlook.office365.com
 (2603:1096:404:42::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 07:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 07:21:03 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C3BFA4160CA2;
	Thu,  7 Aug 2025 15:21:01 +0800 (CST)
Message-ID: <b721ecf5-5da6-4ab1-b352-b7ce19d1b13a@cixtech.com>
Date: Thu, 7 Aug 2025 15:21:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
To: Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com,
 Zhiqiang.Hou@nxp.com, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 Jonthan.Cameron@huawei.com, lukas@wunner.de, feng.tang@linux.alibaba.com,
 jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
 <20250807070917.2245463-3-hongxing.zhu@nxp.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250807070917.2245463-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|SG2PR06MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5b4c5-49ef-495f-51c4-08ddd582f7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFVsWW9xUjl4bStReXRaS3FpZTdMamJEaHpBVWpoKy90d01hS0tZUzFRRzcx?=
 =?utf-8?B?MHlHNzlhdHo0RHo0M1YxN0drUU9ydlVTK2VHSEduVUUra1hTK2pxbGtBU3Y1?=
 =?utf-8?B?bmxDbzZhNHRSdE9FQkd1K2JwRUlNQjllTmhCM2ZsaWhZZnV5Y3R6LzBGdjIr?=
 =?utf-8?B?UlNPS2NxSHQrUVMrbmViMjFOa3VibkNzRXFFaWpUU1VrbW5WYlRCcExHbzQr?=
 =?utf-8?B?NExzU3JJeHVHVGdHTlVTU0tkZUIxTmZId2xwU1ZyUXFmTWFMZGVsQnpLbjdm?=
 =?utf-8?B?bFZ1NkhINFZlWGZjWFFDaTRUN1Q2WVl5WUtUQUI0ZTFDaEQrRWd4Y3d5V25U?=
 =?utf-8?B?SlpwL21tcnZhSExydit1MWxGQjNTVVYwUjlOVXBmNXMvMENqQ0kwa3A1eVZS?=
 =?utf-8?B?ZEZmdEhTWnZaRThYRlhFc2xyTXJtZG1WRnJPMUNVMVpNNzNiRW96ZHZ5Q3ZB?=
 =?utf-8?B?U2NsZnVYa01NV3l3V2gwREdQMmxpWVIwMU9POGpVNUNab2RTeXdCUGxOakR5?=
 =?utf-8?B?NmpSZXF4U08wd2EzcUJiNzJsdDVBeUV4bWdWdDlZTTI5SmZXeUJHK3h6VUl0?=
 =?utf-8?B?dmEzL25IWk1tT1B0TmNCTk8zNHJEeDhvRjhHQXFrbkgwRVczWjBuY3hnWTk3?=
 =?utf-8?B?OVFaZG1ncHk5NUgzVVhVWDNySHdRTkNtYmIvMHhQQW5iU0VtdGN0Z2lJSUg2?=
 =?utf-8?B?YSswT1VseG0vVzJ0enNXbm1ZTE02eG5NeGJXU3dQNXVLZlpWRklNOEJZdEUx?=
 =?utf-8?B?a3FCWXZwYWJyMHVpVnUreEFNTmowcVdEMWFWeU9ZMXg0NXVwY291Q3JoOUxr?=
 =?utf-8?B?UDdiczdQRC85Mm1vaFdRRG1QMUk1WlRwd1VyNjJtcHd2bUtNd25tQVB0VjZa?=
 =?utf-8?B?UmdXUmQ2ek5aRDZRRnFhUjMxOWVGbjR2YVN1dmQ2RUFVM2NHc3VMQU1OY0k1?=
 =?utf-8?B?b0szd2gvRzBXSFpQQXB0ckVBbjZTZmZPT0plZ2JtZi8yZWMweWF1TEM5Skxh?=
 =?utf-8?B?Z1N6NmdtWXo0N003a1dmQ0s5WEt4dmZpeFkxdEY3MjlXaHphVXl6OWZYRkVR?=
 =?utf-8?B?Tng2clZEcEZUNElJdzhVODJ1SlE3M3R0MFEwNklGNEtkeUN1WWNGOEFhTnNw?=
 =?utf-8?B?UkNhWWlGSWVGOE00ZC9KOFpRaW1RVnFreU1VaGVZSStSdFRKYU94NUVycHNh?=
 =?utf-8?B?Mkt5NEkwUitIV29ZQ25ESDh5aDE5YWNFRnVGTlhMV083V0FhZGd1Z3ZGMTVW?=
 =?utf-8?B?M1BXTXNENlJjUjBSVVZTOElkbGhJVWYvSG5JTlU3N2Z5R3hSTDFqeE1xTkhp?=
 =?utf-8?B?VE5TV0p2cU41aEpVOWdsb1ZKMGlFcmZQT2JTYkY2OTEwQlpIOFVPeTgwTElS?=
 =?utf-8?B?dEhZa0NZRzBQd1U3TnFRNlpFeUVESmJrUFpYNG5FUXY5eWFvQnBBaVZsMGxl?=
 =?utf-8?B?aENCMkVDbzFReVpMS3ByaTZWcG92c04rMEp5bWNJSFdWNGtpMkJET013NzBB?=
 =?utf-8?B?SVdJSytRYzg5STBxZkJOZEF2L1lkOFZvbVJOa1kzei9NV1pPbWtwZmRXajRS?=
 =?utf-8?B?WVA0aGsySUZWWkFOM3NqcGVacGdXb3dSZWorT1pXWkxnc1VwUnRzd09KOHZO?=
 =?utf-8?B?R0RvWlByWnlKbktuOTlYNzZGVTVwRWdpM0ZrTUgzSU9rak5ReDNUa1c0cmhV?=
 =?utf-8?B?Qk9naFF3VllIdGlzMnB3YXQ4eG13SWI1Y0NudENLbE1tc255YUk3aEUzNDla?=
 =?utf-8?B?WkRLemcrRjc5VWwrVFBSWVdRa3J5TWd1VUM1Y0x6SDdLUDFITGJ2S2NsZ09B?=
 =?utf-8?B?aExpMjRieGpEVVdaLzVZQ0I3WDdKeEtMbTNseUNiRFpFeFZoaHNYTXpNNFVk?=
 =?utf-8?B?NkxNYmhqS0hFT25EUlJlOUphaEp1c1g2NzRXLzU2SUR2OUlrQkVMazF3MmtF?=
 =?utf-8?B?aDlSZnNkd1pTcGdkaUxaRG9sNFZHOElQc2ZoS0NFUGNBNXVtajFUM0JUdnBF?=
 =?utf-8?B?Y0dWSXhYVGYvbkt6T3IvK0VYMmJjUmZ4TUVHVkw5d2dNQU5JTkVrWUM3cTN6?=
 =?utf-8?B?NmpCMHdoRkM2c3RtcmpTT0hUMThienJ2UnlFQT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:21:03.1225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5b4c5-49ef-495f-51c4-08ddd582f7cf
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5189



On 2025/8/7 15:09, Richard Zhu wrote:
> EXTERNAL EMAIL
> 
> Some PCI host bridges have limitation that AER/PME can't work over MSI.
> Vendors route the AER/PME via the dedicated SPI interrupter which is
> only handled by the controller driver.
> 
> Because that aer and pme had been defined in the snps,dw-pcie.yaml
> document. Fetch the vendor specific AER/PME interrupters if they are
> defined in the fdt file by generic bridge->get_service_irqs hook.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 32 +++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 906277f9ffaf7..9393dc99df81f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -13,11 +13,13 @@
>   #include <linux/irqdomain.h>
>   #include <linux/msi.h>
>   #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_pci.h>
>   #include <linux/pci_regs.h>
>   #include <linux/platform_device.h>
> 
>   #include "../../pci.h"
> +#include "../../pcie/portdrv.h"
>   #include "pcie-designware.h"
> 
>   static struct pci_ops dw_pcie_ops;
> @@ -461,6 +463,35 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>          return 0;
>   }
> 
> +static int dw_pcie_get_service_irqs(struct pci_host_bridge *bridge,
> +                                   int *irqs, int mask)
> +{
> +       struct device *dev = bridge->dev.parent;
> +       struct device_node *np = dev->of_node;
> +       int ret, count = 0;
> +
> +       if (!np)
> +               return 0;
> +
> +       if (mask & PCIE_PORT_SERVICE_AER) {
> +               ret = of_irq_get_byname(np, "aer");
> +               if (ret > 0) {
> +                       irqs[PCIE_PORT_SERVICE_AER_SHIFT] = ret;
> +                       count++;
> +               }
> +       }
> +
> +       if (mask & PCIE_PORT_SERVICE_PME) {
> +               ret = of_irq_get_byname(np, "pme");
> +               if (ret > 0) {
> +                       irqs[PCIE_PORT_SERVICE_PME_SHIFT] = ret;
> +                       count++;
> +               }
> +       }
> +

Hi Richard,

As far as I know, some SoCs directly use the misc SPI interrupt derived 
from Synopsys PCIe IP. This includes PME, AER and other interrupts. So 
here, can we assign the interrupt number ourselves?

Also, whether to trigger the AER/PME interrupt in a similar way. 
(generic_handle_domain_irq)
Because there may be a misc SPI interrupt that requires a clear related 
state, what is referred to here is not the AER/PME state.

Best regards,
Hans


> +       return count;
> +}
> +
>   int dw_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -476,6 +507,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>                  return -ENOMEM;
> 
>          pp->bridge = bridge;
> +       pp->bridge->get_service_irqs = dw_pcie_get_service_irqs;
> 
>          ret = dw_pcie_host_get_resources(pp);
>          if (ret)
> --
> 2.37.1
> 
> 

