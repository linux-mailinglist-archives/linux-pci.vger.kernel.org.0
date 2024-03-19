Return-Path: <linux-pci+bounces-4900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BEB88011B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC968B212A6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39342657AD;
	Tue, 19 Mar 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JrSWhNWq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BD651BB;
	Tue, 19 Mar 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863464; cv=fail; b=tcSjJjj50eOKEc+L/F9BK8pAbIGum4IePGiLGcFOQcdmg0Y0GycfYBaSZYMMKTwaXouXFVNf4NHvKqOTl8OPP9qaA0FmbKB8AtGZTauxcrcH87daKxZ0qqlOQUqqqbUpZ6eNvNEyRF3ZuLHKNMPe3BXmaL8w1r8KY6BqNwwmuk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863464; c=relaxed/simple;
	bh=mIFVDXQWfqjK9WLWc+mjtcEwKQCZN7OrBndBhMD3QxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOy8Vj5+CfkeOKObkQakW3IZ8Ahtt3NSTva7ajsIZEA5r4iS2DTLeNZrH+WhUuJdsGkohKRPC3ECzKWgz3TRCfKdIrMub03SeN6vEuoK3mKs+cx/oRslPh8i3qfMufOGGS5rvEidcFRngS3Ynf+0ii0sxOJUyntpVzOcK+Wa9AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JrSWhNWq; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BajugwwsSqcQW9IUkU/Vh20y1ztY6IaMYmJe1HjGUDeYsdXQCIpVLBu/3Q+Ar0F6wY46l9HCD5gurN0ACqiTISkZ9zAW6ZafXgFJxNIA6ox/8kqBF6YnXUEP7x836DAsdepxkfyUlRdz/e/7o9+Hi80M0KhJ8ynyPsZcvN0fNdVsIAT6tU31vks6UrUQlSnPSWyLwr7UIL4sAddOT1NTO4XAbt6MYsKSIqqqeaboeMBGtzjmbsNW3G4orf3p/J9NSAo3j4cPTClaIg7kswo4xSkFXvPBeIq1Gnei1Xg5+GAl4FmUgHs8QJPaWtEqFkEnry+y99Gdz91Q9yxxe6YkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVgCEen0YQOVudTpz76RD2pNt6wXB4XW/h0p7cl/TeQ=;
 b=e+ugBLsPY+jhvnsp0aPvDLPCWSd+rExMYhtSCtqpoz5wC50xoYBxtpsaGhMFDXyU4yc6MliGVM8/fT85urv0JxCHHO1xnYCGf9kbk+5IZdtr+Y4/ibFhoxUltVuYibHMY6GUunfrXYRslRGJA9cDes26csDqff5ZJMjpXPh4ImrmYkgHfiv9LbRPOFH0OZXmyj5dpwjscxxFP9rJDscpxd3E4ocuYYTKSvMLrGJ0fkcrfx2NV0HHQiGrIG0alsLAmGPXqhrRr5mzx8CHUOv4DtTl/pNzlrr/24/n/GnUmaF8gAXEblCXE/ltdOFTUUU3ixFPGKg9R8sleYvm8bTGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVgCEen0YQOVudTpz76RD2pNt6wXB4XW/h0p7cl/TeQ=;
 b=JrSWhNWqUFBfRbeGrN9AnKXlOVScAz5wnQxgJh22ty0AymGY0Konnp7L4xSq0DoRMjzszVLA2du1xlz21o1FSXCvA/92VaHQ/a8Ubu9hDJr1IUnIx3OUqYuPpum+5ReBNeQPuTMqhwWcBshsFF4V8PPfexTt2a1/7wn3+aVmJPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 15:50:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:50:58 +0000
Date: Tue, 19 Mar 2024 11:50:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
X-ClientProxiedBy: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e3e60b-655b-4cfd-9242-08dc482c5e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kRLIoCduUzoSZr4N1t2zDfDV98Ch8dS+uXLsmD8vFpjCl28WCEazbvqJsrvz8wlIDagUVEjPHqHLLIwbepcrsaSPe5PkWW1yJzFU4cljxAj6d8jPFZ8dIZPpfKAWTzfjpymPgeNNv4XpgPC3BCk5bnVnSTjIXG2MVJhsyf4auxpaQL/OtmB9j1Zp1447PgyZJ104XAwhNIz46vzTu9IfQntByVP7xLARPgkU6HPSDZg12NHta21AFB6mvY4lKM9g+R2C2PGAr9m8ScNNLD4CrBhNv33zNNs8H1ey11PCyPzNxtJ8Do/DItWwoC0bEu6mkseg9GfH0i6/e91EpRAIQiRUeH7PvD+X0X0sRaPxR0GGIfHwV7Yo4GVSuzoBt9Uln0Xj22M4cQ/GqTlPWKdtDwsnHk3VdhwPQgKJmZZ1S3eH5fIvR+JIxWcUYxidWNwlZdwbUbd4eadBwH5bDpTm1jQ4lYDbFvHtIJDwXLnGEHXrQRWmpYDgimgkc0OHOD43psrzgdpKpvhzBc8R+TA26QzUJc2V+yDOzxQaq7j7aTmPUs30LTs1OhhdEd0TiX/nWeIXoDWi/qJCcRWYpnVcvGblxfpXfZiMAX9Liu3gz1fD17NZieb/kWj9SC2otzveJVS3wSr3iH6I8dWqWVzNXMXH64sh99wmg9rWouPYy/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHdH/7+hUnrvqu5iOKfUWYi5IEIgmIUDA8lhx1L6beVIcb2VD83rKDTMsfQP?=
 =?us-ascii?Q?opVLntcSOaFs+FVTkot8IIW5OAIb80auJNgBC+zsUF3HGNa332GlEKkp2RLk?=
 =?us-ascii?Q?VK9D5cA26OKD9Gn/G2x8l6LHs4cosvaEnbLmZRCbWAW6J+bwh4UGhDpMvPT+?=
 =?us-ascii?Q?QNZX4+Ssf8TDfcl90WQdULU3ecuR6Fwc9NGmIIhHV/gDOn0rCbn0W16m92/8?=
 =?us-ascii?Q?+dszvE+tKoHvfEC/EBSZu2+6VsuZ+ervjOXmaVezlVhx3F54BOxwd1fimHL8?=
 =?us-ascii?Q?QdI3PROH6AMOnKxCQp1AylnthD5iwlJ5qX6sGhKYSO2UTSPSjB6q/m6N3Xi6?=
 =?us-ascii?Q?qWBPT+hP9JDHEpYM1XkTlIZXi9NLZe4T+S4XOcHyhbMIDPH6y0Ap6T6YDK1h?=
 =?us-ascii?Q?LPog9Bs0sBLTFnFPWj3DyANa6Z56Y4FHY7jNv+UrxGnjtk/E+J2e85xpp/66?=
 =?us-ascii?Q?W2ykc/9QXuwXYpMI3FVXrQVN9ij7+K5U6tfkLREAdL9PWBrOORq62UpbR3ux?=
 =?us-ascii?Q?TsqVgccD1TphsCJrHQtMXflMRnHU+HJTgaHNJbsyatedcR/v97z0b/4UP9yG?=
 =?us-ascii?Q?7xvEHidNMIUg9SzNnKsamgbH66HmekgLWVCRlwVuxSEmqKmzo0zsifmKe3rv?=
 =?us-ascii?Q?ZmHu0SIwTu1ychamkma/rnNF9/kVFpSl1GV/z5EMBO09BC1ELWWrR13xIsbo?=
 =?us-ascii?Q?JKzFC5ZaFLLQATBneeWV4MQ+iCqRTeupv+vfpocR2/Px3gT447mDa+4yMglG?=
 =?us-ascii?Q?oBEOeN6bjfAzxLPPs3GpdwmR5T8pmPlFkdd5IOOIVSHwIVTNYnAV8Nws84id?=
 =?us-ascii?Q?Pva4BWQpNh0ZgZXj7jWcEDJxzozahFoVDYJGiggF57eg9TBy6I/FsN35jPbw?=
 =?us-ascii?Q?+aUxTwVcYgyc6cUiAW3S7NjCrJRvn5jA2wv3tD9ufla3bGH/veCfkStVkvGm?=
 =?us-ascii?Q?uq//9xev97rwe6ns30urCjEgEdn3wJKJCn9RJikdm4NAKgl/9RAH39fkMuno?=
 =?us-ascii?Q?A4CRBTUrk1uik11Or6v0IydBWdKB/todNoyhX1itnRogZSNPqsdhJdObf8Fo?=
 =?us-ascii?Q?mS6G3T1hXhWxM8KXd4CMQeDx2so2EQdcy32kWn8KII/3LRsIBIj7XF6EMoUj?=
 =?us-ascii?Q?n34YW9gyYAl+kPGrMhd2+505tcCwTM/bP+pJch9VwhmmqvNg8fWByBlZrkSr?=
 =?us-ascii?Q?iXhf+TPeiULFPFm00AbBRK3Ync/551URkLXUn+IkWytfoj0G6lnmiv02baiX?=
 =?us-ascii?Q?2vRs3FAErDA+VJN8Bixr5qopZkWorfvGmQH4bf9cd/vR+s/j6k6hWsW6ejvD?=
 =?us-ascii?Q?OJ/Ef8PvKlfe3aYT0/JtPrryxBniLlJyWBYi4fawgy7datgJoWyCK+bjqh56?=
 =?us-ascii?Q?pVNJK7d2epeOBrQX/jFnL5uYlLO74O29RZ7FOJXalqittpAeZrEs4lU6hROb?=
 =?us-ascii?Q?W3jFtD4TlZNxsQklKtb1DRV4QwpontklzL79xEpBqiHedrQm0YgzyyN3/2gF?=
 =?us-ascii?Q?C0G23aojJFl/LiGbUSBDRTE2r+IFOrcVmP+TlODLiH3iDIP2h6ZPKPDWoQYa?=
 =?us-ascii?Q?e+k9rGb0/XHC8kA/Wcs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e3e60b-655b-4cfd-9242-08dc482c5e44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:50:57.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxFidQxhAXy804SQD23tGVBmk8PYdKykDyqaFr4sKWRXPltLp7I/BKsesAbJA1wxgmW7JoG8Omhl5XyydOE0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927

On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> As proposed during the last year 'PCI Endpoint Subsystem Open Items
> Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> framework for managing the endpoint outbound window memory allocation.
> 
> PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> driver from the start for managing the memory required to map the host
> address space (outbound) in endpoint. Even though it works well, it
> completely defeats the purpose of the 'Genalloc framework', a general
> purpose memory allocator framework created to avoid various custom memory
> allocators in the kernel.
> 
> The migration to Genalloc framework is done is such a way that the existing
> API semantics are preserved. So that the callers of the EPC mem APIs do not
> need any modification (apart from the pcie-designware-epc driver that
> queries page size).
> 
> Internally, the EPC mem driver now uses Genalloc framework's
> 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> based on the requested size as like the previous allocator. And the
> page size passed during pci_epc_mem_init() API is used as the minimum order
> for the memory allocations.
> 
> During the migration, 'struct pci_epc_mem' is removed as it is seems
> redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> is now used to hold the address windows of the endpoint controller.
> 
> [1] https://lpc.events/event/17/contributions/1419/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
>  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
>  include/linux/pci-epc.h                         |  25 +---
>  3 files changed, 81 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..37c612282eb6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
>  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
> -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
>  	msg_addr = ((u64)msg_addr_upper) << 32 |
>  			(msg_addr_lower & ~aligned_offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  epc->windows[0]->page_size);
>  	if (ret)
>  		return ret;
>  
> @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EPERM;
>  	}
>  
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
>  	msg_addr &= ~aligned_offset;
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  epc->windows[0]->page_size);
>  	if (ret)
>  		return ret;
>  
> @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  	dw_pcie_edma_remove(pci);
>  
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> -			      epc->mem->window.page_size);
> +			      epc->windows[0]->page_size);
>  
>  	pci_epc_mem_exit(epc);
>  
> @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	}
>  
>  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> -					     epc->mem->window.page_size);
> +					     epc->windows[0]->page_size);
>  	if (!ep->msi_mem) {
>  		ret = -ENOMEM;
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  err_free_epc_mem:
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> -			      epc->mem->window.page_size);
> +			      epc->windows[0]->page_size);
>  
>  err_exit_epc_mem:
>  	pci_epc_mem_exit(epc);
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a9c028f58da1..f9e6e1a6aeaa 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -4,37 +4,18 @@
>   *
>   * Copyright (C) 2017 Texas Instruments
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * Copyright (C) 2024 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   */
>  
> +#include <linux/genalloc.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
>  #include <linux/pci-epc.h>
>  
> -/**
> - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> - * @mem: address space of the endpoint controller
> - * @size: the size for which to get the order
> - *
> - * Reimplement get_order() for mem->page_size since the generic get_order
> - * always gets order with a constant PAGE_SIZE.
> - */
> -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> -{
> -	int order;
> -	unsigned int page_shift = ilog2(mem->window.page_size);
> -
> -	size--;
> -	size >>= page_shift;
> -#if BITS_PER_LONG == 32
> -	order = fls(size);
> -#else
> -	order = fls64(size);
> -#endif
> -	return order;
> -}
> -
>  /**
>   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_init
> @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  			   struct pci_epc_mem_window *windows,
>  			   unsigned int num_windows)
>  {
> -	struct pci_epc_mem *mem = NULL;
> -	unsigned long *bitmap = NULL;
> -	unsigned int page_shift;
> +	struct pci_epc_mem_window *window = NULL;
>  	size_t page_size;
> -	int bitmap_size;
> -	int pages;
>  	int ret;
>  	int i;
>  
> -	epc->num_windows = 0;
> -
>  	if (!windows || !num_windows)
>  		return -EINVAL;
>  
> @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  		page_size = windows[i].page_size;
>  		if (page_size < PAGE_SIZE)
>  			page_size = PAGE_SIZE;
> -		page_shift = ilog2(page_size);
> -		pages = windows[i].size >> page_shift;
> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>  
> -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> -		if (!mem) {
> +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);

I think it is not good to modify caller's memory. This funciton suppose
pass down read-only information. And set to epc->windows[i]. I think it'd
better to use epc->windows[i].pool/windows.

> +		if (!windows[i].pool) {
>  			ret = -ENOMEM;
> -			i--;
> -			goto err_mem;
> +			goto err_free_mem;
> +		}
> +
> +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> +				  NULL);
> +
> +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> +					windows[i].phys_base, windows[i].size, -1);
> +		if (ret) {
> +			iounmap(windows[i].virt_base);
> +			gen_pool_destroy(epc->windows[i]->pool);

I think move all free to err path will be easy to understand.

> +			goto err_free_mem;
>  		}
>  
> -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -		if (!bitmap) {
> +		window = kzalloc(sizeof(*window), GFP_KERNEL);

According to below code                                                    
                                                                           
        epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
        if (!epc->windows)                                                 
                return -ENOMEM;                                            
                                                                           
epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
I think you can direct use 'window = epc->windows + i', so needn't alloc      
additional memory for epc->windows[i].


> +		if (!window) {
>  			ret = -ENOMEM;
> -			kfree(mem);
> -			i--;
> -			goto err_mem;
> +			iounmap(windows[i].virt_base);
> +			gen_pool_destroy(epc->windows[i]->pool);
> +			goto err_free_mem;
>  		}
>  
> -		mem->window.phys_base = windows[i].phys_base;
> -		mem->window.size = windows[i].size;
> -		mem->window.page_size = page_size;
> -		mem->bitmap = bitmap;
> -		mem->pages = pages;
> -		mutex_init(&mem->lock);
> -		epc->windows[i] = mem;
> +		window->phys_base = windows[i].phys_base;
> +		window->size = windows[i].size;
> +		window->page_size = page_size;
> +		window->pool = windows[i].pool;
> +		epc->windows[i] = window;
>  	}
>  
> -	epc->mem = epc->windows[0];
>  	epc->num_windows = num_windows;
>  
>  	return 0;
>  
> -err_mem:
> -	for (; i >= 0; i--) {
> -		mem = epc->windows[i];
> -		kfree(mem->bitmap);
> -		kfree(mem);
> +err_free_mem:
> +	for (--i; i >= 0; i--) {
> +		iounmap(windows[i].virt_base);
> +		gen_pool_destroy(epc->windows[i]->pool);
> +		kfree(epc->windows[i]);
>  	}
> +
>  	kfree(epc->windows);
>  
>  	return ret;
> @@ -128,14 +109,15 @@ EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
>  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
>  		     size_t size, size_t page_size)
>  {
> -	struct pci_epc_mem_window mem_window;
> +	struct pci_epc_mem_window window;
>  
> -	mem_window.phys_base = base;
> -	mem_window.size = size;
> -	mem_window.page_size = page_size;
> +	window.phys_base = base;
> +	window.size = size;
> +	window.page_size = page_size;
>  
> -	return pci_epc_multi_mem_init(epc, &mem_window, 1);
> +	return pci_epc_multi_mem_init(epc, &window, 1);
>  }
> +

Remove extra empty line change

>  EXPORT_SYMBOL_GPL(pci_epc_mem_init);
>  
>  /**
> @@ -147,21 +129,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
>   */
>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -	struct pci_epc_mem *mem;
>  	int i;
>  
>  	if (!epc->num_windows)
>  		return;
>  
>  	for (i = 0; i < epc->num_windows; i++) {
> -		mem = epc->windows[i];
> -		kfree(mem->bitmap);
> -		kfree(mem);
> +		iounmap(epc->windows[i]->virt_base);
> +		gen_pool_destroy(epc->windows[i]->pool);
> +		kfree(epc->windows[i]);
>  	}
> +
>  	kfree(epc->windows);
>  
>  	epc->windows = NULL;
> -	epc->mem = NULL;
>  	epc->num_windows = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> @@ -178,55 +159,42 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> +	struct pci_epc_mem_window *window;
>  	void __iomem *virt_addr = NULL;
> -	struct pci_epc_mem *mem;
> -	unsigned int page_shift;
> +	struct gen_pool *genpool;
>  	size_t align_size;
> -	int pageno;
> -	int order;
>  	int i;
>  
>  	for (i = 0; i < epc->num_windows; i++) {
> -		mem = epc->windows[i];
> -		mutex_lock(&mem->lock);
> -		align_size = ALIGN(size, mem->window.page_size);
> -		order = pci_epc_mem_get_order(mem, align_size);
> -
> -		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> -						 order);
> -		if (pageno >= 0) {
> -			page_shift = ilog2(mem->window.page_size);
> -			*phys_addr = mem->window.phys_base +
> -				((phys_addr_t)pageno << page_shift);
> -			virt_addr = ioremap(*phys_addr, align_size);
> -			if (!virt_addr) {
> -				bitmap_release_region(mem->bitmap,
> -						      pageno, order);
> -				mutex_unlock(&mem->lock);
> -				continue;
> -			}
> -			mutex_unlock(&mem->lock);
> -			return virt_addr;
> -		}
> -		mutex_unlock(&mem->lock);
> +		window = epc->windows[i];
> +		genpool = window->pool;
> +		align_size = ALIGN(size, window->page_size);
> +
> +		virt_addr = (void __iomem *)gen_pool_alloc(genpool, align_size);
> +		if (!virt_addr)
> +			continue;
> +
> +		*phys_addr = gen_pool_virt_to_phys(genpool, (unsigned long)virt_addr);
> +
> +		break;
>  	}
>  
>  	return virt_addr;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> -static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> +static struct pci_epc_mem_window *pci_epc_get_matching_window(struct pci_epc *epc,
>  						       phys_addr_t phys_addr)
>  {
> -	struct pci_epc_mem *mem;
> +	struct pci_epc_mem_window *window;
>  	int i;
>  
>  	for (i = 0; i < epc->num_windows; i++) {
> -		mem = epc->windows[i];
> +		window = epc->windows[i];
>  
> -		if (phys_addr >= mem->window.phys_base &&
> -		    phys_addr < (mem->window.phys_base + mem->window.size))
> -			return mem;
> +		if (phys_addr >= window->phys_base &&
> +		    phys_addr < (window->phys_base + window->size))
> +			return window;
>  	}
>  
>  	return NULL;
> @@ -244,27 +212,15 @@ static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size)
>  {
> -	struct pci_epc_mem *mem;
> -	unsigned int page_shift;
> -	size_t page_size;
> -	int pageno;
> -	int order;
> +	struct pci_epc_mem_window *window;
>  
> -	mem = pci_epc_get_matching_window(epc, phys_addr);
> -	if (!mem) {
> +	window = pci_epc_get_matching_window(epc, phys_addr);
> +	if (!window) {
>  		pr_err("failed to get matching window\n");
>  		return;
>  	}
>  
> -	page_size = mem->window.page_size;
> -	page_shift = ilog2(page_size);
> -	iounmap(virt_addr);
> -	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> -	size = ALIGN(size, page_size);
> -	order = pci_epc_mem_get_order(mem, size);
> -	mutex_lock(&mem->lock);
> -	bitmap_release_region(mem->bitmap, pageno, order);
> -	mutex_unlock(&mem->lock);
> +	gen_pool_free(window->pool, (unsigned long)virt_addr, size);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 40ea18f5aa02..37ea96ed3432 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -87,30 +87,19 @@ struct pci_epc_ops {
>  /**
>   * struct pci_epc_mem_window - address window of the endpoint controller
>   * @phys_base: physical base address of the PCI address window
> + * @virt_base: virtual base address of the PCI address window
> + * @pool: memory pool descriptor
>   * @size: the size of the PCI address window
>   * @page_size: size of each page
>   */
>  struct pci_epc_mem_window {
>  	phys_addr_t	phys_base;
> +	void __iomem	*virt_base;
> +	struct gen_pool *pool;
>  	size_t		size;
>  	size_t		page_size;
>  };
>  
> -/**
> - * struct pci_epc_mem - address space of the endpoint controller
> - * @window: address window of the endpoint controller
> - * @bitmap: bitmap to manage the PCI address space
> - * @pages: number of bits representing the address region
> - * @lock: mutex to protect bitmap
> - */
> -struct pci_epc_mem {
> -	struct pci_epc_mem_window window;
> -	unsigned long	*bitmap;
> -	int		pages;
> -	/* mutex to protect against concurrent access for memory allocation*/
> -	struct mutex	lock;
> -};
> -
>  /**
>   * struct pci_epc - represents the PCI EPC device
>   * @dev: PCI EPC device
> @@ -118,9 +107,6 @@ struct pci_epc_mem {
>   * @list_lock: Mutex for protecting pci_epf list
>   * @ops: function pointers for performing endpoint operations
>   * @windows: array of address space of the endpoint controller
> - * @mem: first window of the endpoint controller, which corresponds to
> - *       default address space of the endpoint controller supporting
> - *       single window.
>   * @num_windows: number of windows supported by device
>   * @max_functions: max number of functions that can be configured in this EPC
>   * @max_vfs: Array indicating the maximum number of virtual functions that can
> @@ -134,8 +120,7 @@ struct pci_epc {
>  	struct list_head		pci_epf;
>  	struct mutex			list_lock;
>  	const struct pci_epc_ops	*ops;
> -	struct pci_epc_mem		**windows;
> -	struct pci_epc_mem		*mem;
> +	struct pci_epc_mem_window	**windows;
>  	unsigned int			num_windows;
>  	u8				max_functions;
>  	u8				*max_vfs;
> 
> ---
> base-commit: 256833a66670ff28b7c1bddbd17973619e5281fd
> change-id: 20240317-pci-ep-genalloc-fa89f5e487e3
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

