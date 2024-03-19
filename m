Return-Path: <linux-pci+bounces-4917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE608802E3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 18:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42BE285393
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA21111B1;
	Tue, 19 Mar 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ruRB/108"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95241119F;
	Tue, 19 Mar 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867676; cv=fail; b=P9W5orwIu+AOAE6WC35Tqa3nQJuFGGNL1VH1jxSQRKDDitw+mvmnXo3ybAvD2zwSefrSgfN/TfI+8JBuYEML0o5w5HEJM5GIZCZs5355Joe6goeWp6Mt8TqfYr4Hdqpygkw3M7rpVIFsqUNMnAk5sc/sjligx3PQl5RQSwZncdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867676; c=relaxed/simple;
	bh=laOwOivk0HFJzfGlQ8PN72kBidySslTL3EOSHYKvTmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHqCLwiWt1ksNeuHwnY/UYDxmFLEP3+QktJj72++5QD1OlXu7REfSkX0oKyopbmiTbwVWZd7VpVMykrMKcgwR8uKtLx8nTz1yr83hVcrkSKao+VnJjH5mYh4rNaZidMt48M5YkWmzgtlfw+16HjebqwCk08GGM9LbK9ke33MQzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ruRB/108; arc=fail smtp.client-ip=40.107.104.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoNyXXtPIWC4Tc6pJfgcwwMBr2ERAcFE8drHKw/w96ox6acwdrdnmZtZ/G7vJ63CE3gs9MmzerdFYadTgxntlPl6lALRFTEoMnO+vRd86aYYcUtVa36y+FnEcatnPao97opcDTNxeFFTwDFHh0mc7gw3wZJ0+PF6lRAdA9G2r326SJlbEcBsJWBHBFk78Lufe1JhWSu6FGQA42iQh0KyD+7MWevB7PdCLmxjCmMW88UGF4D8P2SZM95KjjT5I8ClRx4jm+8UB4cgxCmBl3ztxEUVWH64SRrbkc0hywIaLPI4w2NYA7dPoQJzE1M+uA/zdVTPVzYLGLyQzH6SnMzzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEcNO07XDzxMgsk/A1K9yAtEdLP1/j4xG8rRUqAO80=;
 b=cEd6top2pFLAmuJ6OnAvoZUnPoDnmLmOCFG1T6gqFLNY8++iycIqfm9wHSdjkBwdosglCfYwyDQXdMDOsgw9TFAD13jvMWe4lS7KNKed7frN/X+Zr9rywit0+1mChOmia17MSsHEMgoQU7WbknAUuiIkFWaVFKKZ2fQ+9AXy+TCqPnoSBMc7NYaor29Tb6BUrmUhlh2BwqaTzuVDmM3jWBpgZGpsq24V2AlBGzFOi6as5Yj3kGR3yuSeYVmGJ+WtaUoSlI6CXRGMCXV+2jBzm3hGy2K/18PZHiQPEMSbb7wi1pvu/XDEWnxbjdZZF0/nguLf49+4z6Bqfw1HMo3lZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEEcNO07XDzxMgsk/A1K9yAtEdLP1/j4xG8rRUqAO80=;
 b=ruRB/108BF2dyyRn2L0aiGA1aKJZ8vSsqPU/x24H8Tn0QEKzNpEXVaryXBk0lIMcD9cscleZ74lapXKfj6/kC2KBx9puO/DmDapf77FjbdmIqIQntAAav4n6Gl5rtD6GrDW0ivTRkJ0b+qxgW64i+E3qqOQB7WhYH5kNZYBJEJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8568.eurprd04.prod.outlook.com (2603:10a6:10:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 17:01:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 17:01:10 +0000
Date: Tue, 19 Mar 2024 13:01:03 -0400
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
Message-ID: <ZfnEz9w6ICZXFZeb@lizhi-Precision-Tower-5810>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
 <20240319162829.GC3297@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319162829.GC3297@thinkpad>
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0545678b-e5fc-4215-08bd-08dc48362d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gZ0DkJxyqi1OLRgxhKx16NWi4qE0mhPxjxwhypuYX3HjnwWn4kCvUMATRws/JQdg0lDR8FF+whN4iBjs3C9/iKyA4CLOEkfkPioT984mjWMXuMW9w/JziVQra5ujGyzYo/X/fAQDfMLelfvFuzkcByjw6BxO2dPCIxwcxhOlX/hS8OEQnlmy6JbbqnohhPbthbr/U1nrddixmtSq6k/T6T0JiPTK84OgH8Zu9Iygyc+J/J6NeC7X3WiWHj4OiIa0fjxu2F2muBGjVsTSKX5lgJfnm5mU1NS1STqcxz5QGaHp1J6vnqTG14pT0qCmA9Dqum8VVNuiVtETKIZQtLoOJQLqLSGYVIMPd2LgrUAG+KzJGLNVzD5gMXXv56M6N1U4uCNlkLVwYe1cgI64N+N743ud4JTpsbZ5aNghaPTYav4VrEEBrfvRZ+MQznJdLnqiA+F0XhL2ZHYEU7mlXEEXWEZMICPVeL81oTLXYfiBG1jEXumPMPWGKvOUj1rlZsXAeI5QiErXg7t27dpXzOyTCjZydHp17gD6JMFYvMCT+w6fvZP8KABeillDtoSAZWzH88JTW2PMJd4NnZAwFtFqrCRO4JZyob/1NuyVRyegzlEitHhM42M7A0GtYlgVtG4xT+cRtl2TWdeDeEz2Xav2EHKfC+CefxorBcJ7U+prUU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3ZHbkE2QTlzU3V4eG1rNDlkaGlEcUtWSjRZTTVobC8rSE1BYXR4amczVW9u?=
 =?utf-8?B?ZnFUVXluNFVSY3pXdzhlMFB2dmV5U2I1S0ladjhNanRiMWd2T1gyNWNQb1hi?=
 =?utf-8?B?NXBHYVBDcGN6SWpTV29ibWt5S0hyOFdIZXRnLzFWVFFIdjVBOW0zSE02clg5?=
 =?utf-8?B?MFFwNExNdFVUUktOdHZKY0pqNGJZVDRlTkVwV0NtT1V0MlppYWpnTVl1SFdy?=
 =?utf-8?B?eGZwd05TRG5JQmdsK0hQcE4xc3RkMm5zQ1BIZGRuUHBUbFRJUFBHYUhlV2Qy?=
 =?utf-8?B?bEJSbXcxQUhBUGpxRHVWN3N0ejZsUUN6dHIwMWdyNFZrUFNaRlRVMFV2NnMx?=
 =?utf-8?B?YlFsZ0J6dWF2Sjd6cUdRVEE2dDNFMmpiM25hc2xMa3RBdFJxN3FNNEVWUnBC?=
 =?utf-8?B?Y3RPZGtHaFlWbEt1cXJzVVoyNVo4K1FETFRuVmE5djBKblBmUGxibFpEQ2g5?=
 =?utf-8?B?RDA2MUd1b0t1b0h2RlZXVlRtK1BQT2NFdGxkcDZ2TkVhVUpraGY2K0VYZnlC?=
 =?utf-8?B?OStHV1pxdVNyb0RUc2ttZTJHeEI2RThSSGZNdFZWQVlsL2lJS1FqTlM5OHZZ?=
 =?utf-8?B?ZnVXbWtqWGZ3MWMyeDZzK0w2MzYwUUcrdUljK3YvZnk0Z0ZROEV3a25hMkJa?=
 =?utf-8?B?U3k1RDVxSHdUaG85LzBhT1daUDhrUmt2ajY3N0ZuNVZkcGNVMDJPNk9MdUZL?=
 =?utf-8?B?aGN2L01rQVp2SWRJcWtUdXc1U3hpVFBCUS9SZHY1bXNXM0pXTm80NTN6OHdi?=
 =?utf-8?B?dnJKSFdVQ004YjB6aUgwelpaTlhQc3dySjlaWlNKR0dkZ0NqZnVqakxtbktK?=
 =?utf-8?B?eUFwYnlmYUMrVXJXSDFJa1hJVUxKOUMrWlk5ZFhOWThDTmN1MnpGQjc5VFBj?=
 =?utf-8?B?Vm16ZDRVdzRLOFkycnJ1eUZod1BzdytHRWNncDk2N2tYOSt5RGNDN1BxK21U?=
 =?utf-8?B?N0FxdFlEVFhpcmM4L1Fkak9MNzU0UEREcnpiekxrdzgyYThkMlgrcnlsNEZG?=
 =?utf-8?B?REhralV1N1VBRXl5RHRSVmd0WVhHQUFBRDY0UTAzdkVoOXZFRzRiUWpEemZu?=
 =?utf-8?B?S3UxQnk0YStkUnQ4Tmw4Z0xEWFJIQm1WWUhsYUJHUXNjNm5zU0NaTGVCNmdW?=
 =?utf-8?B?VXpBaEVOV1dpaXp3VUlWQ0pJSUNqNzJIRDhwcTErcVUrMTVKKzNsVWovQmd6?=
 =?utf-8?B?SStxWksxMlBuenBjQVFFcGt1ckJxOU1CVGtsMXVySjE2czhqVU5Pd3RpWFkw?=
 =?utf-8?B?ZmtCMjE2a1djS1dVTFFEcGVyNHJtajdzRENLamp6RTM0dGtWUDZXWmkvaUhW?=
 =?utf-8?B?a3BJOE1sdUJvNmVCb2hxNk1rU3hkS3JjQWE5RUVCRi8vUGwxYUtlb0tsYTNP?=
 =?utf-8?B?cXBQRGlhWXhZb05YWS92TVo2emlwZXhEQVJKYk9ESTRPbTBnT2lFcWN4MWtF?=
 =?utf-8?B?VXQ2c2g5T29nT2ZqVTM0SW5yQjBKYU5KZUVFOGRYeFdpNUMvTW1DSVJPV25N?=
 =?utf-8?B?eHFkNDA0TnBEQ2ppOXBzQkV2MitpYmpmQ3JqNnlWUXFkVWg4cjRDeXBxTDMy?=
 =?utf-8?B?U3NvQnRZbWxGSUs1ekkyZFBuOURsbmxHZ2xTRTRyYnBZdEtzdnRjRmg4bGJ3?=
 =?utf-8?B?TzdpT0IyZlNOR1E3TVJ0NitMWnJqZVhsUVV4UWpKMXNvanZ5NnQrRkpkTjRB?=
 =?utf-8?B?RDc5TWFlUXJEL0pGUUVqMWo5cVBIcURZMlJ4cE1FSXJKTlVjL2NrOFZ5RllO?=
 =?utf-8?B?OVhUUGw5RXp3aVF1M2FKR0ZGckx6L0UrbEM3d1JORGxIOTFkd21RODc1aGVz?=
 =?utf-8?B?WmwzTTZTK3hGbk9JRjg2c0RYSjZLSXExVnN2bnA5WE5nU244MGJDelNRUGd1?=
 =?utf-8?B?MlFPM25VQzJzV2RBZEtCN3pMdEd6Vy9ER2hrMVdub2FIK084UVlObmlCbjdZ?=
 =?utf-8?B?SWlhS25naS9QTEd0blhkYXpxQUx2M0RMZ1dsdXdyckhyQzBIajhGSUJBdC9R?=
 =?utf-8?B?ZWNoVE13alBJUzNYdDl0Z2ZWWW84VCtWTlpzSWlSNmRjNTc2UXphMlkyLzBl?=
 =?utf-8?B?QUF6QUxIZHM3ejlPZnpGKzZBQUUrZEI5RzErbm8rRk03RUZlS1d0UXprU2c2?=
 =?utf-8?Q?SGaZw5apRb6HlBrEYJvqc9bZ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545678b-e5fc-4215-08bd-08dc48362d0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 17:01:10.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVVfpQPpMStc94r/B8LHzZi214BO0mL2mvCM9CJD6LiUMcMmDpA4mO40Yp9v0C8dN0dEjbqCfOeBDPTye1rBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8568

On Tue, Mar 19, 2024 at 09:58:29PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 19, 2024 at 11:50:50AM -0400, Frank Li wrote:
> > On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > framework for managing the endpoint outbound window memory allocation.
> > > 
> > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > driver from the start for managing the memory required to map the host
> > > address space (outbound) in endpoint. Even though it works well, it
> > > completely defeats the purpose of the 'Genalloc framework', a general
> > > purpose memory allocator framework created to avoid various custom memory
> > > allocators in the kernel.
> > > 
> > > The migration to Genalloc framework is done is such a way that the existing
> > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > need any modification (apart from the pcie-designware-epc driver that
> > > queries page size).
> > > 
> > > Internally, the EPC mem driver now uses Genalloc framework's
> > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > based on the requested size as like the previous allocator. And the
> > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > for the memory allocations.
> > > 
> > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > is now used to hold the address windows of the endpoint controller.
> > > 
> > > [1] https://lpc.events/event/17/contributions/1419/
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > >  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > >  include/linux/pci-epc.h                         |  25 +---
> > >  3 files changed, 81 insertions(+), 140 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 5befed2dc02b..37c612282eb6 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> > >  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> > >  	}
> > > -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> > > +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
> > >  	msg_addr = ((u64)msg_addr_upper) << 32 |
> > >  			(msg_addr_lower & ~aligned_offset);
> > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > -				  epc->mem->window.page_size);
> > > +				  epc->windows[0]->page_size);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  		return -EPERM;
> > >  	}
> > >  
> > > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > > +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
> > >  	msg_addr &= ~aligned_offset;
> > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > -				  epc->mem->window.page_size);
> > > +				  epc->windows[0]->page_size);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > >  	dw_pcie_edma_remove(pci);
> > >  
> > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > -			      epc->mem->window.page_size);
> > > +			      epc->windows[0]->page_size);
> > >  
> > >  	pci_epc_mem_exit(epc);
> > >  
> > > @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	}
> > >  
> > >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > > -					     epc->mem->window.page_size);
> > > +					     epc->windows[0]->page_size);
> > >  	if (!ep->msi_mem) {
> > >  		ret = -ENOMEM;
> > >  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> > > @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  
> > >  err_free_epc_mem:
> > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > -			      epc->mem->window.page_size);
> > > +			      epc->windows[0]->page_size);
> > >  
> > >  err_exit_epc_mem:
> > >  	pci_epc_mem_exit(epc);
> > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > @@ -4,37 +4,18 @@
> > >   *
> > >   * Copyright (C) 2017 Texas Instruments
> > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > + *
> > > + * Copyright (C) 2024 Linaro Ltd.
> > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >   */
> > >  
> > > +#include <linux/genalloc.h>
> > >  #include <linux/io.h>
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > >  
> > >  #include <linux/pci-epc.h>
> > >  
> > > -/**
> > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > - * @mem: address space of the endpoint controller
> > > - * @size: the size for which to get the order
> > > - *
> > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > - * always gets order with a constant PAGE_SIZE.
> > > - */
> > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > -{
> > > -	int order;
> > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > -
> > > -	size--;
> > > -	size >>= page_shift;
> > > -#if BITS_PER_LONG == 32
> > > -	order = fls(size);
> > > -#else
> > > -	order = fls64(size);
> > > -#endif
> > > -	return order;
> > > -}
> > > -
> > >  /**
> > >   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > >   * @epc: the EPC device that invoked pci_epc_mem_init
> > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >  			   struct pci_epc_mem_window *windows,
> > >  			   unsigned int num_windows)
> > >  {
> > > -	struct pci_epc_mem *mem = NULL;
> > > -	unsigned long *bitmap = NULL;
> > > -	unsigned int page_shift;
> > > +	struct pci_epc_mem_window *window = NULL;
> > >  	size_t page_size;
> > > -	int bitmap_size;
> > > -	int pages;
> > >  	int ret;
> > >  	int i;
> > >  
> > > -	epc->num_windows = 0;
> > > -
> > >  	if (!windows || !num_windows)
> > >  		return -EINVAL;
> > >  
> > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >  		page_size = windows[i].page_size;
> > >  		if (page_size < PAGE_SIZE)
> > >  			page_size = PAGE_SIZE;
> > > -		page_shift = ilog2(page_size);
> > > -		pages = windows[i].size >> page_shift;
> > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > >  
> > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > -		if (!mem) {
> > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > 
> > I think it is not good to modify caller's memory. This funciton suppose
> > pass down read-only information. And set to epc->windows[i]. I think it'd
> > better to use epc->windows[i].pool/windows.
> > 
> 
> What do you mean by modifying caller's memory? Here, the memory for epc->windows
> is being allocated and the pool is created for each window.

windows[i].pool = gen_pool_create(ilog2(page_size), -1)

'windows' pass down from argument pci_epc_multi_mem_init(
..struct pci_epc_mem_window *windows, )
			     ^^^^^^^
windows[i].pool = gen_pool_create() actually change the caller's stack
memory.

> 
> > > +		if (!windows[i].pool) {
> > >  			ret = -ENOMEM;
> > > -			i--;
> > > -			goto err_mem;
> > > +			goto err_free_mem;
> > > +		}
> > > +
> > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > +				  NULL);
> > > +
> > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > > +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> > > +					windows[i].phys_base, windows[i].size, -1);
> > > +		if (ret) {
> > > +			iounmap(windows[i].virt_base);
> > > +			gen_pool_destroy(epc->windows[i]->pool);
> > 
> > I think move all free to err path will be easy to understand.
> > 
> 
> It is not straightforward. First we need to free the memory for current
> iteration and then all previous iterations, that too from different places.
> Moving the code to free current iteration to the error label will look messy.

All from current iteration.

err_free_mem:
   iounmap(windows[i].virt_base);
   if (epc->windows[i]->pool)
	gen_pool_destroy(epc->windows[i]->pool)

> 
> > > +			goto err_free_mem;
> > >  		}
> > >  
> > > -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > > -		if (!bitmap) {
> > > +		window = kzalloc(sizeof(*window), GFP_KERNEL);
> > 
> > According to below code                                                    
> >                                                                            
> >         epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
> >         if (!epc->windows)                                                 
> >                 return -ENOMEM;                                            
> >                                                                            
> > epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
> > I think you can direct use 'window = epc->windows + i', so needn't alloc      
> > additional memory for epc->windows[i].
> > 
> 
> First we are allocating the memory for 'struct pci_epc_mem_window' _pointers_ in
> epc->windows. Then we need to allocate memory for each pointer in epc->windows
> to actually store data. Otherwise, we will be referencing the nulll pointer.

I think two layer pointer is totally unecessary.
You can use one layer pointer 'struct pci_epc_mem_window       *windows;'

Code logic will become simple. 

Frank

> 
> - Mani
> 
> > 
> > > +		if (!window) {
> > >  			ret = -ENOMEM;
> > > -			kfree(mem);
> > > -			i--;
> > > -			goto err_mem;
> > > +			iounmap(windows[i].virt_base);
> > > +			gen_pool_destroy(epc->windows[i]->pool);
> > > +			goto err_free_mem;
> > >  		}
> > >  
> > > -		mem->window.phys_base = windows[i].phys_base;
> > > -		mem->window.size = windows[i].size;
> > > -		mem->window.page_size = page_size;
> > > -		mem->bitmap = bitmap;
> > > -		mem->pages = pages;
> > > -		mutex_init(&mem->lock);
> > > -		epc->windows[i] = mem;
> > > +		window->phys_base = windows[i].phys_base;
> > > +		window->size = windows[i].size;
> > > +		window->page_size = page_size;
> > > +		window->pool = windows[i].pool;
> > > +		epc->windows[i] = window;
> > >  	}
> > >  
> > > -	epc->mem = epc->windows[0];
> > >  	epc->num_windows = num_windows;
> > >  
> > >  	return 0;
> > >  
> > > -err_mem:
> > > -	for (; i >= 0; i--) {
> > > -		mem = epc->windows[i];
> > > -		kfree(mem->bitmap);
> > > -		kfree(mem);
> > > +err_free_mem:
> > > +	for (--i; i >= 0; i--) {
> > > +		iounmap(windows[i].virt_base);
> > > +		gen_pool_destroy(epc->windows[i]->pool);
> > > +		kfree(epc->windows[i]);
> > >  	}
> > > +
> > >  	kfree(epc->windows);
> > >  
> > >  	return ret;
> > > @@ -128,14 +109,15 @@ EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
> > >  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> > >  		     size_t size, size_t page_size)
> > >  {
> > > -	struct pci_epc_mem_window mem_window;
> > > +	struct pci_epc_mem_window window;
> > >  
> > > -	mem_window.phys_base = base;
> > > -	mem_window.size = size;
> > > -	mem_window.page_size = page_size;
> > > +	window.phys_base = base;
> > > +	window.size = size;
> > > +	window.page_size = page_size;
> > >  
> > > -	return pci_epc_multi_mem_init(epc, &mem_window, 1);
> > > +	return pci_epc_multi_mem_init(epc, &window, 1);
> > >  }
> > > +
> > 
> > Remove extra empty line change
> > 
> > >  EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> > >  
> > >  /**
> > > @@ -147,21 +129,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> > >   */
> > >  void pci_epc_mem_exit(struct pci_epc *epc)
> > >  {
> > > -	struct pci_epc_mem *mem;
> > >  	int i;
> > >  
> > >  	if (!epc->num_windows)
> > >  		return;
> > >  
> > >  	for (i = 0; i < epc->num_windows; i++) {
> > > -		mem = epc->windows[i];
> > > -		kfree(mem->bitmap);
> > > -		kfree(mem);
> > > +		iounmap(epc->windows[i]->virt_base);
> > > +		gen_pool_destroy(epc->windows[i]->pool);
> > > +		kfree(epc->windows[i]);
> > >  	}
> > > +
> > >  	kfree(epc->windows);
> > >  
> > >  	epc->windows = NULL;
> > > -	epc->mem = NULL;
> > >  	epc->num_windows = 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > > @@ -178,55 +159,42 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> > >  				     phys_addr_t *phys_addr, size_t size)
> > >  {
> > > +	struct pci_epc_mem_window *window;
> > >  	void __iomem *virt_addr = NULL;
> > > -	struct pci_epc_mem *mem;
> > > -	unsigned int page_shift;
> > > +	struct gen_pool *genpool;
> > >  	size_t align_size;
> > > -	int pageno;
> > > -	int order;
> > >  	int i;
> > >  
> > >  	for (i = 0; i < epc->num_windows; i++) {
> > > -		mem = epc->windows[i];
> > > -		mutex_lock(&mem->lock);
> > > -		align_size = ALIGN(size, mem->window.page_size);
> > > -		order = pci_epc_mem_get_order(mem, align_size);
> > > -
> > > -		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > > -						 order);
> > > -		if (pageno >= 0) {
> > > -			page_shift = ilog2(mem->window.page_size);
> > > -			*phys_addr = mem->window.phys_base +
> > > -				((phys_addr_t)pageno << page_shift);
> > > -			virt_addr = ioremap(*phys_addr, align_size);
> > > -			if (!virt_addr) {
> > > -				bitmap_release_region(mem->bitmap,
> > > -						      pageno, order);
> > > -				mutex_unlock(&mem->lock);
> > > -				continue;
> > > -			}
> > > -			mutex_unlock(&mem->lock);
> > > -			return virt_addr;
> > > -		}
> > > -		mutex_unlock(&mem->lock);
> > > +		window = epc->windows[i];
> > > +		genpool = window->pool;
> > > +		align_size = ALIGN(size, window->page_size);
> > > +
> > > +		virt_addr = (void __iomem *)gen_pool_alloc(genpool, align_size);
> > > +		if (!virt_addr)
> > > +			continue;
> > > +
> > > +		*phys_addr = gen_pool_virt_to_phys(genpool, (unsigned long)virt_addr);
> > > +
> > > +		break;
> > >  	}
> > >  
> > >  	return virt_addr;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> > >  
> > > -static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > > +static struct pci_epc_mem_window *pci_epc_get_matching_window(struct pci_epc *epc,
> > >  						       phys_addr_t phys_addr)
> > >  {
> > > -	struct pci_epc_mem *mem;
> > > +	struct pci_epc_mem_window *window;
> > >  	int i;
> > >  
> > >  	for (i = 0; i < epc->num_windows; i++) {
> > > -		mem = epc->windows[i];
> > > +		window = epc->windows[i];
> > >  
> > > -		if (phys_addr >= mem->window.phys_base &&
> > > -		    phys_addr < (mem->window.phys_base + mem->window.size))
> > > -			return mem;
> > > +		if (phys_addr >= window->phys_base &&
> > > +		    phys_addr < (window->phys_base + window->size))
> > > +			return window;
> > >  	}
> > >  
> > >  	return NULL;
> > > @@ -244,27 +212,15 @@ static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> > >  			   void __iomem *virt_addr, size_t size)
> > >  {
> > > -	struct pci_epc_mem *mem;
> > > -	unsigned int page_shift;
> > > -	size_t page_size;
> > > -	int pageno;
> > > -	int order;
> > > +	struct pci_epc_mem_window *window;
> > >  
> > > -	mem = pci_epc_get_matching_window(epc, phys_addr);
> > > -	if (!mem) {
> > > +	window = pci_epc_get_matching_window(epc, phys_addr);
> > > +	if (!window) {
> > >  		pr_err("failed to get matching window\n");
> > >  		return;
> > >  	}
> > >  
> > > -	page_size = mem->window.page_size;
> > > -	page_shift = ilog2(page_size);
> > > -	iounmap(virt_addr);
> > > -	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> > > -	size = ALIGN(size, page_size);
> > > -	order = pci_epc_mem_get_order(mem, size);
> > > -	mutex_lock(&mem->lock);
> > > -	bitmap_release_region(mem->bitmap, pageno, order);
> > > -	mutex_unlock(&mem->lock);
> > > +	gen_pool_free(window->pool, (unsigned long)virt_addr, size);
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
> > >  
> > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > index 40ea18f5aa02..37ea96ed3432 100644
> > > --- a/include/linux/pci-epc.h
> > > +++ b/include/linux/pci-epc.h
> > > @@ -87,30 +87,19 @@ struct pci_epc_ops {
> > >  /**
> > >   * struct pci_epc_mem_window - address window of the endpoint controller
> > >   * @phys_base: physical base address of the PCI address window
> > > + * @virt_base: virtual base address of the PCI address window
> > > + * @pool: memory pool descriptor
> > >   * @size: the size of the PCI address window
> > >   * @page_size: size of each page
> > >   */
> > >  struct pci_epc_mem_window {
> > >  	phys_addr_t	phys_base;
> > > +	void __iomem	*virt_base;
> > > +	struct gen_pool *pool;
> > >  	size_t		size;
> > >  	size_t		page_size;
> > >  };
> > >  
> > > -/**
> > > - * struct pci_epc_mem - address space of the endpoint controller
> > > - * @window: address window of the endpoint controller
> > > - * @bitmap: bitmap to manage the PCI address space
> > > - * @pages: number of bits representing the address region
> > > - * @lock: mutex to protect bitmap
> > > - */
> > > -struct pci_epc_mem {
> > > -	struct pci_epc_mem_window window;
> > > -	unsigned long	*bitmap;
> > > -	int		pages;
> > > -	/* mutex to protect against concurrent access for memory allocation*/
> > > -	struct mutex	lock;
> > > -};
> > > -
> > >  /**
> > >   * struct pci_epc - represents the PCI EPC device
> > >   * @dev: PCI EPC device
> > > @@ -118,9 +107,6 @@ struct pci_epc_mem {
> > >   * @list_lock: Mutex for protecting pci_epf list
> > >   * @ops: function pointers for performing endpoint operations
> > >   * @windows: array of address space of the endpoint controller
> > > - * @mem: first window of the endpoint controller, which corresponds to
> > > - *       default address space of the endpoint controller supporting
> > > - *       single window.
> > >   * @num_windows: number of windows supported by device
> > >   * @max_functions: max number of functions that can be configured in this EPC
> > >   * @max_vfs: Array indicating the maximum number of virtual functions that can
> > > @@ -134,8 +120,7 @@ struct pci_epc {
> > >  	struct list_head		pci_epf;
> > >  	struct mutex			list_lock;
> > >  	const struct pci_epc_ops	*ops;
> > > -	struct pci_epc_mem		**windows;
> > > -	struct pci_epc_mem		*mem;
> > > +	struct pci_epc_mem_window	**windows;
> > >  	unsigned int			num_windows;
> > >  	u8				max_functions;
> > >  	u8				*max_vfs;
> > > 
> > > ---
> > > base-commit: 256833a66670ff28b7c1bddbd17973619e5281fd
> > > change-id: 20240317-pci-ep-genalloc-fa89f5e487e3
> > > 
> > > Best regards,
> > > -- 
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

