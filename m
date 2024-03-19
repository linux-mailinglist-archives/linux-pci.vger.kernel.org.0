Return-Path: <linux-pci+bounces-4907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797F88020F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B39B1C22B38
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4610C81AD8;
	Tue, 19 Mar 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cXtfP3XF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C881ABB;
	Tue, 19 Mar 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864986; cv=fail; b=gOyfEV5hvXg/9+j6pzm9rjitcRfPyYj123NpLDgeqS8+vdwFpwJzskUtfrHruE4MVvgSJ6YQJQhDlgZI4vk2TwOgK9duBRhXALzCrg5gwC0ztcxesZduXxbqJ8xOLICUOctkV9J8fd+7GSDadVuAALRk/7b0vgLXdfNhyu24KS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864986; c=relaxed/simple;
	bh=Fk5lzH7jrxEsIAl/TWDdUucADXbAt+TwmvlLlYxz4nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iV+3qtpdlOCm5w1sf2JeIgIa8t4vzOzeVWsQhmr0aMzIjU9UhCtJZw/9lNsUEY4n+n/w4oeC0ENSDRaEyUDluhS+K98dksjXZ+Rc1ppoMHXl3qI5AnLdfaQXVRjBsQdLF2CQGii7dgQNkWsae+wwv0wFZGcIpMCWMVGV0qfoT0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cXtfP3XF; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLHiXizEn+MCr0JDspA3/qNS5kLNdq0PbJo1nUCYCqvhOFliyPJiQIvWy3O8imNZDwfNnFnf6cL48GgQROEpGUVtSTrEWUf7XArUEyLCtCJt09gnqOVJYjh2KUEQJa5FVCmKM0rqarH7gKMfygAh9M7E0On6VFyuQBHNQkCD5tRP1Njm3hC2jKYAGbMktZJ8Wb8UrhE4n1KPmlVrgIJyIA+L9NlJxKI8akdUERJUmFfM91q3vc7SHSpxieoXsiAVqfRN901dM+ayTQ4NqQYfPsTI7ZaNz4VTMhXkZKz4g1oLU6l+JQ7nwt3q6rXGq7vmETfqgWTNUkglyUzFhS4MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wJ1uUKxK74iKou3CA2cRsOSj/jqz7nl3uGWZlDTBRo=;
 b=lTruw0mgDJNpkh4c1X8GsOi8vW3KshgNNZ+gXcxSgalRJRXIR3bPu42iK31IL6mfVGgZIYvmtKKWilHRMDBpHbj3kO3WlbXeglqBDqR0bO47CHwxXqQy1kiHVxSZ1z59wZ+AMwz1ie0iglv9lPoKj305VWHLOD7dcYHFvRWYfBujmwcKTf6FRS2gtBR+eO6OhfBSPBH9s4MM49MYycTFhz/vkFEC9OswuNf4E3xc+SrOcCpEgj1XSWvwSugZ23m0O58dCw4u+OMNKrR27MSGbD4P9vfml2r5P4HTeZo87U+8gvlfzfpSExeRFCTm+2pwEcXFCyDMSq5jeEEIjX9ngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wJ1uUKxK74iKou3CA2cRsOSj/jqz7nl3uGWZlDTBRo=;
 b=cXtfP3XFn1oRPtbh87Fe+B4FSLcpbGo0Gr7h8wkEOQlJEIuasnYSQCYKeYHALIRWK3kWjTDe7ufJ1ehh5lm36XFd/uv22F89OIApGoPUwIhVb4irZz2is64jjGPuWWFaipsGrrfqPteYCpTkmKsIJi9ZFapPVYHTP2cQo/QkSJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Tue, 19 Mar
 2024 16:16:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:16:20 +0000
Date: Tue, 19 Mar 2024 12:16:12 -0400
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
Message-ID: <Zfm6TKhBmqDfvxs4@lizhi-Precision-Tower-5810>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY5PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:180::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 78021e7f-5b27-4865-258d-08dc482fe9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P+uHcRzWbd3VsVLWCqqJOTdYeHST8/cKiUhOnwGtpxsdjlNJvS8ohL6+89mjxRRDxoVNhZcj7ApP/3FryAzVjIrWlbpsmJaRdu3f5GQDTudi43KfPpa16SREGIK/5xgvMnWylVa51DUFL7orRcGhntjMx5i3YgP6sDsotzO6fbMiZZzNENa5rmSA5U2ZKzuqSzdGS8dH1r663nKXnh/jNdPcxwMrsOagcqV2tfv/48DI7Gk4CbJkvX7rkHiMPJd2L3uZR8PmJAIP1sREFaXj2T7HKkj0yyKV7nbijzPHFomg5r34f2koU35Y/4qCloNGopDuCcO449daVUdo8w84KAGlXiMDclk2guQCRyZvKEtx/RP5/hu3eZDwC0qIDCn+ZsiLVch/eVBUH0Y3h6TtTlnF77p8NKRpe4ZWt1LihkitlPl1J6GsCGsGaM4te2jqPt75vUHEfxEb8K1VK1S7kcLCm5H0bPDP5rQ122HFQwFi+pUqVKdvsVO9cANQCfTGLVVUqIb5Kc+Ll0K0NSeUeRZNcV/MsGl/AnvkFDLlE/omt4+cv/jBxW6E64QWo7olU4xZz+cA2u+slO+GVWoruMK2+ubPCgoMRU/mc9QxDYSeUnuw0w0cngKNQ1JP7WwOSX/FESeXxYsEENzGdXzwK0z3WAVSMnSWn6vEPQcXWVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qG+O9hq9o6m4iJ3JlsgDt8CnFlJFywSFxASBjvzD8b7R9nMBQjm0c+/XnKbX?=
 =?us-ascii?Q?tml4560ZbaAT2pIg9gz1cwvOwsLP9wvpRy+tmOKI6I3lOaivz2jSuLvr9CLN?=
 =?us-ascii?Q?/QFqvyQzLca9z1p80gGgzn6Qzabk47cW0KFaGtOtm+abXDeQBUW9uNo47NFI?=
 =?us-ascii?Q?XCFmNyob4NcVGvc0es5LfF5djlP2AZNnK6ftP70SkoRBCkhPhurFsEkzDrze?=
 =?us-ascii?Q?ZKIdAgLcshj8WEGd8QOnU18cwcEGXL1rjEaIqYA8BmlZXHDOCwbzmq2DP8Rd?=
 =?us-ascii?Q?J5xjuMA5IhxWBhuboj88cpRIvKxcpNpXAZcMoVpcVCzwGGcNfrN2avjEbNnJ?=
 =?us-ascii?Q?zom4XHjd8YTxARd4Vvx+VkqgFi6zXX4P4gNvF73FSSRbjUFkPFY2RzGRX4Kq?=
 =?us-ascii?Q?9xBrRwDGQps57fheOMXxoiCQ05hn8KV4JQkK8Rndu0DH+M6uNf04bc43tqt1?=
 =?us-ascii?Q?Xv4jHS3mSMtKuPtCc/HFqGvnEtzLusa9Csvh1gJ015dv1041wOlND9iiydyU?=
 =?us-ascii?Q?x0ZTSAA+864OSGGtd5gxeUPHkk7lYT3dfxTsoB1l6F27mpwbzNnBxN3xvhyA?=
 =?us-ascii?Q?e0aeeXlbl2P8IDUgWqyRg5R9IKkuf9FFe8zMKNlSdzCM8ULomlw5HYJowSIX?=
 =?us-ascii?Q?pG5sjk7RbY0n7VscxaOhzWvRji2I/UYPOo9Z7CsJM6gTIscm5m8C687dIoaK?=
 =?us-ascii?Q?WbX4HQnFzNuC40WYxmthCE6ziTSKj6RCtVq30JxsSQuR5h58OtpxP4R65pP0?=
 =?us-ascii?Q?A+1XjT6TnGxlYwwPWnQkvA/ENP4VE2Lal2ciCgXLXbDyBbMnu6DzhbcfkdV8?=
 =?us-ascii?Q?xqflVyyj+TV140Sc1D7hf98fLNCP44+wrGfUPkJhy/1IZsDqna4IRJadU+GX?=
 =?us-ascii?Q?/QpOMuo6mvpDbJQ+Ne8TnrcnQS4ztMO6BUuKAuP8TxfJu/zdQYJQnEXFE2a4?=
 =?us-ascii?Q?a1Lu9eSWjD4VpgrJYZWueZoq+z0UwPcPPqAx4P0ZLuUPmBuyZxo/zQlLO/H0?=
 =?us-ascii?Q?peWZwzmMAlOmXITRw0moprr+kfw4Tn48m7c+EoRvKbcIZxF8xUcKzrtohdwu?=
 =?us-ascii?Q?VmR+BWGyQlixJxASc4bRJN3rAatYQXqgifu63IwysDAf6GgmALFfBxHvCMq3?=
 =?us-ascii?Q?fc5ZHcb0MSBZMgHqRWq4BNqpn8rZQrBp5EyksVbgTs7ltwXq43TOTrg/SypX?=
 =?us-ascii?Q?7zs7LYyLiKRQpb7MdcXWiB6doVV+O50l+ULCe3//r3+IVp9SiAfMDOsgEgre?=
 =?us-ascii?Q?o7luFL06LdJpv4XW3rrtZnMiRTJw85mO1aNClBr2UwNSnyJXtSZ6eAm4Kx4x?=
 =?us-ascii?Q?Kq3QiAWr+tfS1qzrRoLKGHcNRMIpLC0jXsAtLZPZEjoYbC0nN3Zl8enRho4j?=
 =?us-ascii?Q?3CUnyj0x4GcCOz5yLfePQfCEnWpsjghrmdGpyY3Y4Jr0SHqqWYw9E7JJCjL1?=
 =?us-ascii?Q?tn6cLV5moqeXDvNqaOuWNiUbegEwi0CxYY3pem1g9kLclQC9p401L2gS4Ycu?=
 =?us-ascii?Q?gYvfA+j5SaOVQxcTPTIiJGR6pZLdnjENhNJNGvECwslUUcCHimh2wLNLixi6?=
 =?us-ascii?Q?IvOzjFd4umv7YPLAfO1Ik1gDrsVvGh7Sy8hVViYs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78021e7f-5b27-4865-258d-08dc482fe9c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:16:20.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaF3+Uv76TaS7QxWTJ1QKblEEVjgjtsLH9v8DD1Xc+p2YqumK55uXdLEe9Pewas5ugQF0xqbZK8uQtSHC185iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911

On Tue, Mar 19, 2024 at 11:50:50AM -0400, Frank Li wrote:
> On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > framework for managing the endpoint outbound window memory allocation.
> > 
> > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > driver from the start for managing the memory required to map the host
> > address space (outbound) in endpoint. Even though it works well, it
> > completely defeats the purpose of the 'Genalloc framework', a general
> > purpose memory allocator framework created to avoid various custom memory
> > allocators in the kernel.
> > 
> > The migration to Genalloc framework is done is such a way that the existing
> > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > need any modification (apart from the pcie-designware-epc driver that
> > queries page size).
> > 
> > Internally, the EPC mem driver now uses Genalloc framework's
> > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > based on the requested size as like the previous allocator. And the
> > page size passed during pci_epc_mem_init() API is used as the minimum order
> > for the memory allocations.
> > 
> > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > is now used to hold the address windows of the endpoint controller.
> > 
> > [1] https://lpc.events/event/17/contributions/1419/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> >  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> >  include/linux/pci-epc.h                         |  25 +---
> >  3 files changed, 81 insertions(+), 140 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 5befed2dc02b..37c612282eb6 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> >  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> >  	}
> > -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> > +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
> >  	msg_addr = ((u64)msg_addr_upper) << 32 |
> >  			(msg_addr_lower & ~aligned_offset);
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  epc->mem->window.page_size);
> > +				  epc->windows[0]->page_size);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  		return -EPERM;
> >  	}
> >  
> > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
> >  	msg_addr &= ~aligned_offset;
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  epc->mem->window.page_size);
> > +				  epc->windows[0]->page_size);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  	dw_pcie_edma_remove(pci);
> >  
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > -			      epc->mem->window.page_size);
> > +			      epc->windows[0]->page_size);
> >  
> >  	pci_epc_mem_exit(epc);
> >  
> > @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	}
> >  
> >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > -					     epc->mem->window.page_size);
> > +					     epc->windows[0]->page_size);
> >  	if (!ep->msi_mem) {
> >  		ret = -ENOMEM;
> >  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> > @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  
> >  err_free_epc_mem:
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > -			      epc->mem->window.page_size);
> > +			      epc->windows[0]->page_size);
> >  
> >  err_exit_epc_mem:
> >  	pci_epc_mem_exit(epc);
> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index a9c028f58da1..f9e6e1a6aeaa 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > @@ -4,37 +4,18 @@
> >   *
> >   * Copyright (C) 2017 Texas Instruments
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > + *
> > + * Copyright (C) 2024 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >   */
> >  
> > +#include <linux/genalloc.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  
> >  #include <linux/pci-epc.h>
> >  
> > -/**
> > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > - * @mem: address space of the endpoint controller
> > - * @size: the size for which to get the order
> > - *
> > - * Reimplement get_order() for mem->page_size since the generic get_order
> > - * always gets order with a constant PAGE_SIZE.
> > - */
> > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > -{
> > -	int order;
> > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > -
> > -	size--;
> > -	size >>= page_shift;
> > -#if BITS_PER_LONG == 32
> > -	order = fls(size);
> > -#else
> > -	order = fls64(size);
> > -#endif
> > -	return order;
> > -}
> > -
> >  /**
> >   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> >   * @epc: the EPC device that invoked pci_epc_mem_init
> > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >  			   struct pci_epc_mem_window *windows,
> >  			   unsigned int num_windows)
> >  {
> > -	struct pci_epc_mem *mem = NULL;
> > -	unsigned long *bitmap = NULL;
> > -	unsigned int page_shift;
> > +	struct pci_epc_mem_window *window = NULL;
> >  	size_t page_size;
> > -	int bitmap_size;
> > -	int pages;
> >  	int ret;
> >  	int i;
> >  
> > -	epc->num_windows = 0;
> > -
> >  	if (!windows || !num_windows)
> >  		return -EINVAL;
> >  
> > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >  		page_size = windows[i].page_size;
> >  		if (page_size < PAGE_SIZE)
> >  			page_size = PAGE_SIZE;
> > -		page_shift = ilog2(page_size);
> > -		pages = windows[i].size >> page_shift;
> > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >  
> > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > -		if (!mem) {
> > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> 
> I think it is not good to modify caller's memory. This funciton suppose
> pass down read-only information. And set to epc->windows[i]. I think it'd
> better to use epc->windows[i].pool/windows.
> 
> > +		if (!windows[i].pool) {
> >  			ret = -ENOMEM;
> > -			i--;
> > -			goto err_mem;
> > +			goto err_free_mem;
> > +		}
> > +
> > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > +				  NULL);
> > +
> > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> > +					windows[i].phys_base, windows[i].size, -1);
> > +		if (ret) {
> > +			iounmap(windows[i].virt_base);
> > +			gen_pool_destroy(epc->windows[i]->pool);
> 
> I think move all free to err path will be easy to understand.
> 
> > +			goto err_free_mem;
> >  		}
> >  
> > -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > -		if (!bitmap) {
> > +		window = kzalloc(sizeof(*window), GFP_KERNEL);
> 
> According to below code                                                    
>                                                                            
>         epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
>         if (!epc->windows)                                                 
>                 return -ENOMEM;                                            
>                                                                            
> epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
> I think you can direct use 'window = epc->windows + i', so needn't alloc      
> additional memory for epc->windows[i].

I just realize struct pci_epc_mem_window **windows in epc. But my comment
should be valid also. pci_epc_mem_window *windows should be enough. Needn't
two level pointer.

> 
> 
> > +		if (!window) {
> >  			ret = -ENOMEM;
> > -			kfree(mem);
> > -			i--;
> > -			goto err_mem;
> > +			iounmap(windows[i].virt_base);
> > +			gen_pool_destroy(epc->windows[i]->pool);
> > +			goto err_free_mem;
> >  		}
> >  
> > -		mem->window.phys_base = windows[i].phys_base;
> > -		mem->window.size = windows[i].size;
> > -		mem->window.page_size = page_size;
> > -		mem->bitmap = bitmap;
> > -		mem->pages = pages;
> > -		mutex_init(&mem->lock);
> > -		epc->windows[i] = mem;
> > +		window->phys_base = windows[i].phys_base;
> > +		window->size = windows[i].size;
> > +		window->page_size = page_size;
> > +		window->pool = windows[i].pool;
> > +		epc->windows[i] = window;
> >  	}
> >  
> > -	epc->mem = epc->windows[0];
> >  	epc->num_windows = num_windows;
> >  
> >  	return 0;
> >  
> > -err_mem:
> > -	for (; i >= 0; i--) {
> > -		mem = epc->windows[i];
> > -		kfree(mem->bitmap);
> > -		kfree(mem);
> > +err_free_mem:
> > +	for (--i; i >= 0; i--) {
> > +		iounmap(windows[i].virt_base);
> > +		gen_pool_destroy(epc->windows[i]->pool);
> > +		kfree(epc->windows[i]);
> >  	}
> > +
> >  	kfree(epc->windows);
> >  
> >  	return ret;
> > @@ -128,14 +109,15 @@ EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
> >  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> >  		     size_t size, size_t page_size)
> >  {
> > -	struct pci_epc_mem_window mem_window;
> > +	struct pci_epc_mem_window window;
> >  
> > -	mem_window.phys_base = base;
> > -	mem_window.size = size;
> > -	mem_window.page_size = page_size;
> > +	window.phys_base = base;
> > +	window.size = size;
> > +	window.page_size = page_size;
> >  
> > -	return pci_epc_multi_mem_init(epc, &mem_window, 1);
> > +	return pci_epc_multi_mem_init(epc, &window, 1);
> >  }
> > +
> 
> Remove extra empty line change
> 
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >  
> >  /**
> > @@ -147,21 +129,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >   */
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -	struct pci_epc_mem *mem;
> >  	int i;
> >  
> >  	if (!epc->num_windows)
> >  		return;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > -		kfree(mem->bitmap);
> > -		kfree(mem);
> > +		iounmap(epc->windows[i]->virt_base);
> > +		gen_pool_destroy(epc->windows[i]->pool);
> > +		kfree(epc->windows[i]);
> >  	}
> > +
> >  	kfree(epc->windows);
> >  
> >  	epc->windows = NULL;
> > -	epc->mem = NULL;
> >  	epc->num_windows = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > @@ -178,55 +159,42 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >  				     phys_addr_t *phys_addr, size_t size)
> >  {
> > +	struct pci_epc_mem_window *window;
> >  	void __iomem *virt_addr = NULL;
> > -	struct pci_epc_mem *mem;
> > -	unsigned int page_shift;
> > +	struct gen_pool *genpool;
> >  	size_t align_size;
> > -	int pageno;
> > -	int order;
> >  	int i;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > -		mutex_lock(&mem->lock);
> > -		align_size = ALIGN(size, mem->window.page_size);
> > -		order = pci_epc_mem_get_order(mem, align_size);
> > -
> > -		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > -						 order);
> > -		if (pageno >= 0) {
> > -			page_shift = ilog2(mem->window.page_size);
> > -			*phys_addr = mem->window.phys_base +
> > -				((phys_addr_t)pageno << page_shift);
> > -			virt_addr = ioremap(*phys_addr, align_size);
> > -			if (!virt_addr) {
> > -				bitmap_release_region(mem->bitmap,
> > -						      pageno, order);
> > -				mutex_unlock(&mem->lock);
> > -				continue;
> > -			}
> > -			mutex_unlock(&mem->lock);
> > -			return virt_addr;
> > -		}
> > -		mutex_unlock(&mem->lock);
> > +		window = epc->windows[i];
> > +		genpool = window->pool;
> > +		align_size = ALIGN(size, window->page_size);
> > +
> > +		virt_addr = (void __iomem *)gen_pool_alloc(genpool, align_size);
> > +		if (!virt_addr)
> > +			continue;
> > +
> > +		*phys_addr = gen_pool_virt_to_phys(genpool, (unsigned long)virt_addr);
> > +
> > +		break;
> >  	}
> >  
> >  	return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >  
> > -static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > +static struct pci_epc_mem_window *pci_epc_get_matching_window(struct pci_epc *epc,
> >  						       phys_addr_t phys_addr)
> >  {
> > -	struct pci_epc_mem *mem;
> > +	struct pci_epc_mem_window *window;
> >  	int i;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > +		window = epc->windows[i];
> >  
> > -		if (phys_addr >= mem->window.phys_base &&
> > -		    phys_addr < (mem->window.phys_base + mem->window.size))
> > -			return mem;
> > +		if (phys_addr >= window->phys_base &&
> > +		    phys_addr < (window->phys_base + window->size))
> > +			return window;
> >  	}
> >  
> >  	return NULL;
> > @@ -244,27 +212,15 @@ static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >  			   void __iomem *virt_addr, size_t size)
> >  {
> > -	struct pci_epc_mem *mem;
> > -	unsigned int page_shift;
> > -	size_t page_size;
> > -	int pageno;
> > -	int order;
> > +	struct pci_epc_mem_window *window;
> >  
> > -	mem = pci_epc_get_matching_window(epc, phys_addr);
> > -	if (!mem) {
> > +	window = pci_epc_get_matching_window(epc, phys_addr);
> > +	if (!window) {
> >  		pr_err("failed to get matching window\n");
> >  		return;
> >  	}
> >  
> > -	page_size = mem->window.page_size;
> > -	page_shift = ilog2(page_size);
> > -	iounmap(virt_addr);
> > -	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> > -	size = ALIGN(size, page_size);
> > -	order = pci_epc_mem_get_order(mem, size);
> > -	mutex_lock(&mem->lock);
> > -	bitmap_release_region(mem->bitmap, pageno, order);
> > -	mutex_unlock(&mem->lock);
> > +	gen_pool_free(window->pool, (unsigned long)virt_addr, size);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
> >  
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 40ea18f5aa02..37ea96ed3432 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -87,30 +87,19 @@ struct pci_epc_ops {
> >  /**
> >   * struct pci_epc_mem_window - address window of the endpoint controller
> >   * @phys_base: physical base address of the PCI address window
> > + * @virt_base: virtual base address of the PCI address window
> > + * @pool: memory pool descriptor
> >   * @size: the size of the PCI address window
> >   * @page_size: size of each page
> >   */
> >  struct pci_epc_mem_window {
> >  	phys_addr_t	phys_base;
> > +	void __iomem	*virt_base;
> > +	struct gen_pool *pool;
> >  	size_t		size;
> >  	size_t		page_size;
> >  };
> >  
> > -/**
> > - * struct pci_epc_mem - address space of the endpoint controller
> > - * @window: address window of the endpoint controller
> > - * @bitmap: bitmap to manage the PCI address space
> > - * @pages: number of bits representing the address region
> > - * @lock: mutex to protect bitmap
> > - */
> > -struct pci_epc_mem {
> > -	struct pci_epc_mem_window window;
> > -	unsigned long	*bitmap;
> > -	int		pages;
> > -	/* mutex to protect against concurrent access for memory allocation*/
> > -	struct mutex	lock;
> > -};
> > -
> >  /**
> >   * struct pci_epc - represents the PCI EPC device
> >   * @dev: PCI EPC device
> > @@ -118,9 +107,6 @@ struct pci_epc_mem {
> >   * @list_lock: Mutex for protecting pci_epf list
> >   * @ops: function pointers for performing endpoint operations
> >   * @windows: array of address space of the endpoint controller
> > - * @mem: first window of the endpoint controller, which corresponds to
> > - *       default address space of the endpoint controller supporting
> > - *       single window.
> >   * @num_windows: number of windows supported by device
> >   * @max_functions: max number of functions that can be configured in this EPC
> >   * @max_vfs: Array indicating the maximum number of virtual functions that can
> > @@ -134,8 +120,7 @@ struct pci_epc {
> >  	struct list_head		pci_epf;
> >  	struct mutex			list_lock;
> >  	const struct pci_epc_ops	*ops;
> > -	struct pci_epc_mem		**windows;
> > -	struct pci_epc_mem		*mem;
> > +	struct pci_epc_mem_window	**windows;
> >  	unsigned int			num_windows;
> >  	u8				max_functions;
> >  	u8				*max_vfs;
> > 
> > ---
> > base-commit: 256833a66670ff28b7c1bddbd17973619e5281fd
> > change-id: 20240317-pci-ep-genalloc-fa89f5e487e3
> > 
> > Best regards,
> > -- 
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 

