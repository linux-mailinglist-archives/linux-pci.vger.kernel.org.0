Return-Path: <linux-pci+bounces-33525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10975B1D332
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBC61888C29
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D4237180;
	Thu,  7 Aug 2025 07:21:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023110.outbound.protection.outlook.com [40.107.44.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3648235041;
	Thu,  7 Aug 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551296; cv=fail; b=LG2bDG7DNHag66WvVsRksdGIdh4MLiJPYnj7M1wxYnUQmV35OrOfdFIGFv3BpduJfDn9ViWXOyODLIAYTT8TufK75egng3mpoPXipWj6Lh/OTCw7JPyJlwuswfgvxHhBO5TfnJ0hJKfc58W+qZnIgM1e2YxTBhsJdbyRl0OVnHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551296; c=relaxed/simple;
	bh=CA8r/LusqQQaz4cVZr22MLnbcrh4LMIgOdzERpbrzjE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hEW6NkJJsva2T81JgeXO5zsvjY++445GHeOIusIlsjvBibNY9MK/zYwfu5pwN8p+jwPRZRmxsXiKoudqRmvHlWclb+ibk0FnF0QtRbSxvrC35X+jSwezW/M07kF/OIAzhJpCPZ78Qa35pMHttz1NL6CBbodHCg8qNlP4CVz8EPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnVUCuZLnPhs0Wa2x7TrvJ3GRx58y4MJCVbgZyiJ93HMwJLLv8EHvl0frEILFEn8KcbvbS4FYENraUN0Fq59D7bO9/145Y4Vo26bn+4HXZTfP2bJ8dWiqBGawShNFset+/9a9Zls2e0J0FDc2EohOjZEh+AnvMb5xDBj+agJKUK0Fu0uC4u4n8Co12uqlloUI2pGXsqwPNfBU/qVm/vTgftRcqEByiCQGXZtSllUj6Uvzuwwg111UHNX4AUBfFrMgnR+AWzgyeAAmKzsP+BviZP4YNA0bc04x0GUWrholuiNRdmlRqstVymb1FILkXMnUDwDzmPExRsDmtOl4HaRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gfLukVho6EgOfJbOIgjOVul8doQXxHp5WZpRC94zEA=;
 b=CUKpljVibvn+nIKNI4t1bM3b6d3enztQICbh8MjdneyUv9UPT02senP1h0pSqZ1SGWWbEAFoKeTCwbuoZtbYxK9qbt7u9eDNnEl7M9yT5QUqEvOBQtGfopxYfoEw+k+i0+TtY5HCfBcUf1Oe37aJdIkBccVBOJkMBtlMAw6GgJR0OvgyLFx+E0yAsySS3/f+QYQlxfshpRzam0QPgTD047G7aNaPjIm+ffsb+wA0Lf75eKBmTT5ooY/3nCNiL1qr9ifVoZ8ryzPj+q6OLreGl2ynjix7w2NuUjAGMp0dNEHqvRRVTGa3fN6LwruhtpZ4C4KFY1zdx5xCIABkV8vG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0087.apcprd02.prod.outlook.com (2603:1096:300:5c::27)
 by SEZPR06MB7124.apcprd06.prod.outlook.com (2603:1096:101:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 07:21:30 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::6b) by PS2PR02CA0087.outlook.office365.com
 (2603:1096:300:5c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 07:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 07:21:29 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CFE694160CA2;
	Thu,  7 Aug 2025 15:21:28 +0800 (CST)
Message-ID: <2f501b15-bea3-4893-b218-ca96ff1e0561@cixtech.com>
Date: Thu, 7 Aug 2025 15:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Zhang <hans.zhang@cixtech.com>
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
In-Reply-To: <20250807070917.2245463-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SEZPR06MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: d32f0e3f-bf5f-4fb4-6cb1-08ddd5830790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d04wb3hzMjQyTGtkSU1mcmJQSlIvcCs1L09nWnBVUG10YUI2UUNVdUZleXFX?=
 =?utf-8?B?OXJFbnp2Rzk0bXQrMWFxTXdvNDFyMGozMnVNQWRTa3dWMEo2S1pwbGMzTXUv?=
 =?utf-8?B?YzYzMHdLUCtKM1FJM0cxbDE2eFFEU0YvVkRWbWV3eHFTZ2dnWFA3Z2E1OEpB?=
 =?utf-8?B?bVREMllwUDdIS1FBRjYzRVF3UzFoei9tSzBKcmpEV25MWnVHUW1HMzJ6YnlE?=
 =?utf-8?B?b3pSaElFY3JwYklkbWlwTjdYNVdDVHYxZ0hVQzRrOFBJaXVTazZmUUxKT2Nr?=
 =?utf-8?B?NHc1SmNiTVEvRm9UeXg2ZGtoTE1WN0QxM3JFeU8xSW5EL3hZQmloZVhGRHBl?=
 =?utf-8?B?OWV2YUIzR3Fhck9lQlhyVnFqUHFsTE15U3JZQlQ4TjA4RDAwci96MTgzQVhu?=
 =?utf-8?B?dGhZYWk0SzF2VVdpNDgrMmlldXpRTGMySG5USUNwbjdDTnZWOERLMndrZjlv?=
 =?utf-8?B?d0ZFQkxlRWUzSWRGdkFaTitrNUtOME1OOUwrYjdCMGJDa0h3dmhnTjRQcytX?=
 =?utf-8?B?ZXdzUm5BQ3kwTEpGbG9hSHBkdU8xMTZFTyswdVhJektldElWeTZtd0tvdDB3?=
 =?utf-8?B?TTJ6V3AySW1yS2lMZGZxTTJaMi9HRmlYTVFFRjUzeThvUkpka1c3YTVWS1hU?=
 =?utf-8?B?bDM5eTlpVWpsUjJlVHhuVnN1Y1VndzR3bjdHeUJNM1RORHQvRnNqZ1F5T0Ev?=
 =?utf-8?B?Tk81VmhIMWNjdDhOQzQ4NHllU05SanNRV1pQNlg5ZEo1WVZMb1FXdVFxdlRp?=
 =?utf-8?B?Ly9nUlo0Z0t5V2liZ25WMUN1VUlLM1RnL2U5TXZQNFNGd2hYcnhIYU1IbE1R?=
 =?utf-8?B?TFVlcXBnd2lLeTdUSy9EbVI5VFdrTklmcExrQWZkZ1cwbngxMVovYk1aV1cy?=
 =?utf-8?B?ZHhZM1ptdXliNzJNR2hsT2g2aElBOG5hZXRRTXNJZURqaTlzREljSWlCTm1Q?=
 =?utf-8?B?Qm8xWnRtaW1Ecm5JdmNLcWxKczlkYW1GOGhHeVpRcEdoWDFMM3hzTkg2MXRT?=
 =?utf-8?B?cTJjcTBFSGlFYXVDUW9Dc0h2T0hHRlBGMEhzV0wzRk1uUlkxZE42b0s4b2NF?=
 =?utf-8?B?T2lFL0RSQlF5M0VZb2ZUNFZwZ1FDVWpZVXZQOG1xamM5V0RKQy9nVlNNRHhh?=
 =?utf-8?B?ZjN6cXdKVVdxT0NQNVh6VkpyZlBNbXFIbkR0WThvSFFWcU1CK3VCZUdrbjcx?=
 =?utf-8?B?WlNKQVcrRHRDQ3N1WnlwT3lQSHNoVXNqZTNkLzZFcllZL0E2SXI3VmRVWVJM?=
 =?utf-8?B?NDhWK09Lb0IyZVl6alVXNkU3SEs1RVhqWThhbVYyYncyRm1WbHlEYnFDYmho?=
 =?utf-8?B?dEdHdzdSSXk4cTlaTS9FZ044WDl2VktZNkMzM2MrTTc1cFlnaUF4KzVzdG5P?=
 =?utf-8?B?UllkU2tjV2Ixb1BJM0dYVXRuTVJkN3UyS3JSb1R6OFFjMk91T0FCeVVYVWM5?=
 =?utf-8?B?b2ZqRnFQYjZHbnMyYW1obGprZjYySjVtdnZqWEZMSjlSVXlYd0p2NlFnUjZi?=
 =?utf-8?B?a25hSGVOejJEeTRsbGRBRk44cFAzYjNHeEZvS3pOUFpUdjFIQXozZS9GelRS?=
 =?utf-8?B?Z3MzVmVWVHliRnFNdVp3cjRxRktEZUozMmZybERDLzFUMUo3MDE4OWhCVExa?=
 =?utf-8?B?R0cxeHY4UDRzK3Y3Si9DR0h3VkFNYVFMTW1oczhxbkpZMzNnWW5BNkVYY3VP?=
 =?utf-8?B?Ujh1RUtrU21hNzdGZzNqYVJFS21xN2tFL252RFkzV05FN2lwU05aY01TYzRx?=
 =?utf-8?B?YW5xVkRDcHVBN3VaRjhRRTJCdkN2SzRxR3dYcVhZajYyeHdGWEFKVHJpaFRn?=
 =?utf-8?B?K1FrWXlaS0NSOFpLMFpGd21EbUVLam01MVFFc3YzZzVNRWxHczdjNVRrK1RP?=
 =?utf-8?B?T3ZORUdXV0srV0xOZVJocVdiQWJtYmQ4clZzRE9LVitObGtCVlJHeXlObEkz?=
 =?utf-8?B?U3huS3RnSzM4czBSY2t1ekZYYmFLR0kyclZoZlNQeTRpZzBUellQTEVEdWt2?=
 =?utf-8?B?SnJmc0RRVXU2TFlUbVpXYVdJNTBvWlVTR2pYckgyWXhzSHZDeXp6TkF0M1hh?=
 =?utf-8?B?djlUSitxV0lWQWhPbTdqcjd0ekhWcEZ4dlAzZz09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:21:29.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32f0e3f-bf5f-4fb4-6cb1-08ddd5830790
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7124



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

