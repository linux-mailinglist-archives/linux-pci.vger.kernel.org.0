Return-Path: <linux-pci+bounces-4962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B82881347
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EB2B223E4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E9446AE;
	Wed, 20 Mar 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWcRx68b"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE513D54C;
	Wed, 20 Mar 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944814; cv=fail; b=n41GLGU0xcwuljXZhsGcGFGkhUF+IzkStch8r19lmlNr2C4eFHauB+OeO2847de/2WtCLaIJY0RVDt6fjoZIhEXDovmbm0RTRxhHfwzEO75jYgwvrqGVLT9nEbDoMuNr6fIju1LZpOTGX4XVFzCT6kbugGnAQP0QujY4sWKkj7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944814; c=relaxed/simple;
	bh=WZ/Yj3k3omxDDkocjXopnkrSBWsYhq7Hh8RD4dMSX7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKttTLlXzukH4/rJVVvWLIqCpW/d0lQP/EwyVy33Ar4qqYe8exm7cXWQ2TqKXRwpDcGewydZ2LM9dM5g8lP7dr0yYp/D15B5/XeFHmWJqCiA4fIkrcoav1G20nCPUSVx7WEGZcCUZZAE0MEKeEcg5POhAyLuRg3sXXzOdiXcD3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWcRx68b; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEElp3wF4vUrsTh6EWvdDfRccCNRevqmhQUoQuN/o31GVmMPyNWYeIZV+dIFeEWGfmbqQ9rIoZ8SfCETFriwo8kYu+Dl8YDSEz15LKImRWHv1sBVT3XqWPBI2FWfeOIXY0TMi0pzq7PRsKgx/DGc4gO2JoOHpGxZdAOyWHlXfn0Vd0LMiHIGbI+vltRqs5a+EoDNjVkp73uwiVBh8eBrM4zIU8iBbjpsG7HxUlTY9S3UmzS7LHCzW8VIoM8MekxAMzw798oJptNDmdRhLZsCWs8pRXeEn18lahPWpScfjFypbCrZ9cu4E2BmT4FDyOLBXFLcNaEUub0dCR0jkr1LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TFCRFZk77bmHJZOcF4V+gDwxOoMetGuLoLfE9l3uDA=;
 b=l7dV88v3iWFiTj1Sz1Jr1oOZT+e6Vfv78lf6uPhyZsq+soVNoLB2mX/82YaqprSBOC0jgYGXp02ZnMx08pBaJ/7ZGAdWnV0AtiqTYi5zcgbbfCR52OcccrJsbQOs6rpdbds+wPizQ7jA4b2svjHdXOMbW8OD2k6bTMM2XucSvX04egyngTpr7Z1gCToSgQO74D+UX2OxZaIejwvJpY0Nv2eEgNeEz/hil9sRnzyGeXJ0Z40MC4G0xVJRSAVQkZRu92jhppHXborWHGuZZBOwrFad0Yo78jmSImoV/eGaODNiqtemr6cC2Us8wQxTGaeNj46wAODnNYRY7Jazm5KBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TFCRFZk77bmHJZOcF4V+gDwxOoMetGuLoLfE9l3uDA=;
 b=WWcRx68bo7OfQsnssJDBcZ/+SRWA8wEZS7tmu1Tw+hlLKYb+Cg4GTLZdpOaYn5ZWvpgJ6eHhfw58ITpyYF+r7DH+4eJHypMUps27ex0k4Y6MoskWArjkmY44uKpBGpgsahUBJ8RnJbh/uCaQ8HKXxOA9KvXDl0TxtgYFFoUIqBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10104.eurprd04.prod.outlook.com (2603:10a6:800:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 14:26:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:26:47 +0000
Date: Wed, 20 Mar 2024 10:26:40 -0400
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
Message-ID: <ZfryIGHZab6NUsz/@lizhi-Precision-Tower-5810>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
 <20240319162829.GC3297@thinkpad>
 <ZfnEz9w6ICZXFZeb@lizhi-Precision-Tower-5810>
 <20240320061034.GA2525@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320061034.GA2525@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10104:EE_
X-MS-Office365-Filtering-Correlation-Id: cc65c46a-031f-4622-4ce2-08dc48e9c69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fm9xPChAV495ZsIiF/HlxXhzxMNVeyV3ANAuz2s+/mYbrRRnKBWLPmNHZsDehNlFp9i+mjp7HcgFMZSYngbQo7aTXCxgiioKmTBRvmopTkGAW2Zbaq5OOVmGkSU3Vh9QqQWikybZg9kjt+90Zf8FBDZKqojldeZJc6VN7tGP9v8y8wblX3VihtvHTNZAMv4kv0HoFX8wl2+bshrTojACrWIwCVoThdmgI/kFp7gNJx/iYIYvgHcaWTNueaP6p5S4Roxsr/Tf3aRdMBXE2boHTNJnyK1/Qhx687swhbmmFzAJR2aa0j0W5hNkhinUmqW7FfiwmuhJRFJYf6zhVS5KLTOYbQKA0qNn20k/sp0NqEBBkAKzpogfkSklMPr4RnjmrnPyitn7Lp8Gr1E55AtHR/4RaqNDP+blBpOhJOS/7Gh/yJ1LY5sHFWhl8bu7Se+xchhIq3zyGcOGZJZLrIyR5jLwRAVYEqDHHLAQYdeJ+hLdRl7IQCuqGiZEH9NSo1Qd4ndXgC5bWGxRrTDeVGA3shkoHh5rBbZK9+PrNGYHCXxpkW8CwM5mUJCK4PHRObAhcYy0ruXXgJFuiBHfnDJ5onXtQIcTcjdN8TGcuDfG/CJRc9Kdy1kyf4HcgsDKi1XJnXrR4pK/HYrIH4DwQhKs/K4TWKcY5JNqaLHu5nYZ2uU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXNYZC85ZXNZOEFDMEZEbDdMWjJ2TmtiWGZLMmx5RE82b0FDalhMVG1nbnlt?=
 =?utf-8?B?V3JQekxMMlBGc2d0WnJFK3hlSWhRazZDUE5aZ0N0YWVIbGtvejFEM1ozdlNI?=
 =?utf-8?B?UXZGaHJsL0t0MmhjNGRXSWRvc2xXbkRzYzd3dFpXaFpXK05JUUZZZit0bTVQ?=
 =?utf-8?B?UFJzejVBcFM1d0pBaUUvdGVYTE5USm93WElFU3JRMEpDQ2phNWIzOU9oT0Z4?=
 =?utf-8?B?ZGJzc0R5di8veUo1TUc3aGJVWDVaNjFzL1VDSy9UdDcrck5vVkpaRmJwRTg0?=
 =?utf-8?B?Ykt5NVFSSWZsVWVxTzFhSy96b2JEZWpPTVRsUWNsL3VXRWFmOXpCdVFkd3ZH?=
 =?utf-8?B?Y3hWeFIyeXNNczg4bUIvOFpqdHlNWERraE50MW9xeENCTS9CLzA3WnFPOGRL?=
 =?utf-8?B?WUl3MVhTb1h1d1RJSFU4RlBhSUFUdE02Z0hWbXNNYXZlMUcxVnd6b3hIblV2?=
 =?utf-8?B?L3MyTlJKSGE1SXhOWU5PdjRFTWhkNnlyTkowV1BkeXFJVTJGclR4QW80ZS95?=
 =?utf-8?B?dlF1RmZhanV5SUNEekp3MG9xOFh5R1JkNEpyWXhTdStBWlBpcGR1bWhNZlc4?=
 =?utf-8?B?WTBCRlpGOW5WazkyWHBPcnN0RjRrSVJoRldGWVB2ODVuTGdQN1Vab3F3a1hl?=
 =?utf-8?B?UmJkemtabzdXZVAzQUhkaHZrNVJHempWSXRZbnZjRzBXYXExZzJNM3Q0Q2tV?=
 =?utf-8?B?LyswZXUwYnRabFd4QXUvZGhsdCtGQjRCZkpZMDN3WlcydHZQTE9nVFZISnRS?=
 =?utf-8?B?eUNORTAyT21xU0RIS1VYdGMvNHdVNEdCbkp4MzUwdjdxdzVwSWUwTTdrQnlq?=
 =?utf-8?B?bFI5Z3V1RXdrOHZKRjV0a2tCYzBZOVV1eGxuNXl5OFIwcjcrMEpYWlYxRXZS?=
 =?utf-8?B?MWVaRVEwWFNqYmpwRUowdWdXelFBaVdCbGJYRHMyZzhyMm4xMmRMUjE3M29R?=
 =?utf-8?B?TWpUQ3huZ1A0L2RlMTdycjA0RTFGSUNMTmN1ZkFNUU9ra1A4dHNFZWY4dW9N?=
 =?utf-8?B?QWhlc1VxS0RoazFkaGVpZWhEaXQvelhlT3Z4dGxtbTJWTVdLK1dLU3l5cTgy?=
 =?utf-8?B?cmlZSVUzTVc0ak1qelppbnR1Vkc1cndCWDdZeGxtUjgzVlpvYTR4clp5Tzh6?=
 =?utf-8?B?Wkx3dnIzVVhpYlU0Wk9VU3lIVWlyTUxEdVBnREVoZWJ0ZUtGT2xoSXR2YXJh?=
 =?utf-8?B?RnpZMFBncUZkWUxxZ3p6L2o2eUJvZzJicTFzTkJUN25oQlhBRzRKbUNRa3Z0?=
 =?utf-8?B?Q0hSblN5ejRsRFdtWDU5OUk3dFM3c3labnpuVUV0aDlFTWNDZjc1OXBFanJu?=
 =?utf-8?B?bXgvb1JLYThxaDVqbm1uK01GVmNNODZoN3JrS3hmVU5QQkhDVEdBMUsrMzNB?=
 =?utf-8?B?SVlXcmJ0c0FOMXdMdGtjcVJuVWxHdi9mMzNsSDZVaHB5eDY5TWFUYzNJUlp0?=
 =?utf-8?B?VWJjdjB4NzA3RURLTkE4K0xMTkZFcjJMTE9TV1BOR2l3ck5WdEFqVVplRDFi?=
 =?utf-8?B?R3VRSkpCdTJSaGh4dTA2anR5SENFYXRONmxIU3ZRS0FYTCt5Uzg4NEU4MXZ0?=
 =?utf-8?B?bE9NejR0RU9wekVNaTdnVzFFSmhva0o1VnZXM0ZrcVR5VWNMVmFyT2FhS0F1?=
 =?utf-8?B?ZWVTSWFLMGtyaXBRVUFoQW12YU1DODlOYVFNek5qKzdNamw4dk1yMWF1ZVBk?=
 =?utf-8?B?Rm03eCtNRkp4cDFIbFVHRHM3eC9UeTM2ODJoeVN3ZGZJbkRMeG5uS3RFRDJ2?=
 =?utf-8?B?MDJ4UnFTRHFlWjdXamJVb0ZBa2pPeVpOazFLRWhMb0hlMnFOM0x0UnB4REZZ?=
 =?utf-8?B?VDVZNkY2ODhISDBOZ05idDVKRE4zMFIvWnZaTXBBbjh1SlpMcFVrREVnT2Zu?=
 =?utf-8?B?S2hmd3BCR1ROWWRmcjNkRGRiQ3V3Y3FZUWhqblpjSTlIV1RXR3dTMWJJR2Qz?=
 =?utf-8?B?UzBKbU9nM0ZEejNXMmVjM1BueFl3eVEzUmpLdS9wMUc0NnlNejBBd0kvcEZH?=
 =?utf-8?B?T24yTXdxeXgxbVJVNWJxaW5WZDJtVUtSUUtteEdjb0QzT1dJclNWOTlIMU9F?=
 =?utf-8?B?akdrMjVudC9SRCtGVjNxVDYxQUJnZko5ZHBUVlpMb2xZTDU0Y292aXUwaVky?=
 =?utf-8?Q?FSoo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc65c46a-031f-4622-4ce2-08dc48e9c69b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:26:47.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk7Pu+nDnzM1CSaSN75hgbrweO76Z66jhIEStVnFXMIFIw5zwyaTHO5fIidppy0jrsbAiKQAYCmOuZbQnjxxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10104

On Wed, Mar 20, 2024 at 11:40:34AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 19, 2024 at 01:01:03PM -0400, Frank Li wrote:
> > On Tue, Mar 19, 2024 at 09:58:29PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Mar 19, 2024 at 11:50:50AM -0400, Frank Li wrote:
> > > > On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > > > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > > > framework for managing the endpoint outbound window memory allocation.
> > > > > 
> > > > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > > > driver from the start for managing the memory required to map the host
> > > > > address space (outbound) in endpoint. Even though it works well, it
> > > > > completely defeats the purpose of the 'Genalloc framework', a general
> > > > > purpose memory allocator framework created to avoid various custom memory
> > > > > allocators in the kernel.
> > > > > 
> > > > > The migration to Genalloc framework is done is such a way that the existing
> > > > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > > > need any modification (apart from the pcie-designware-epc driver that
> > > > > queries page size).
> > > > > 
> > > > > Internally, the EPC mem driver now uses Genalloc framework's
> > > > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > > > based on the requested size as like the previous allocator. And the
> > > > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > > > for the memory allocations.
> > > > > 
> > > > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > > > is now used to hold the address windows of the endpoint controller.
> > > > > 
> > > > > [1] https://lpc.events/event/17/contributions/1419/
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > > > >  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > > > >  include/linux/pci-epc.h                         |  25 +---
> > > > >  3 files changed, 81 insertions(+), 140 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > index 5befed2dc02b..37c612282eb6 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > > >  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> > > > >  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> > > > >  	}
> > > > > -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> > > > > +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
> > > > >  	msg_addr = ((u64)msg_addr_upper) << 32 |
> > > > >  			(msg_addr_lower & ~aligned_offset);
> > > > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > > > -				  epc->mem->window.page_size);
> > > > > +				  epc->windows[0]->page_size);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >  
> > > > > @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > > >  		return -EPERM;
> > > > >  	}
> > > > >  
> > > > > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > > > > +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
> > > > >  	msg_addr &= ~aligned_offset;
> > > > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > > > -				  epc->mem->window.page_size);
> > > > > +				  epc->windows[0]->page_size);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > >  
> > > > > @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > > > >  	dw_pcie_edma_remove(pci);
> > > > >  
> > > > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > > > -			      epc->mem->window.page_size);
> > > > > +			      epc->windows[0]->page_size);
> > > > >  
> > > > >  	pci_epc_mem_exit(epc);
> > > > >  
> > > > > @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > >  	}
> > > > >  
> > > > >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > > > > -					     epc->mem->window.page_size);
> > > > > +					     epc->windows[0]->page_size);
> > > > >  	if (!ep->msi_mem) {
> > > > >  		ret = -ENOMEM;
> > > > >  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> > > > > @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > >  
> > > > >  err_free_epc_mem:
> > > > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > > > -			      epc->mem->window.page_size);
> > > > > +			      epc->windows[0]->page_size);
> > > > >  
> > > > >  err_exit_epc_mem:
> > > > >  	pci_epc_mem_exit(epc);
> > > > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > > > @@ -4,37 +4,18 @@
> > > > >   *
> > > > >   * Copyright (C) 2017 Texas Instruments
> > > > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > > > + *
> > > > > + * Copyright (C) 2024 Linaro Ltd.
> > > > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > >   */
> > > > >  
> > > > > +#include <linux/genalloc.h>
> > > > >  #include <linux/io.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/slab.h>
> > > > >  
> > > > >  #include <linux/pci-epc.h>
> > > > >  
> > > > > -/**
> > > > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > > > - * @mem: address space of the endpoint controller
> > > > > - * @size: the size for which to get the order
> > > > > - *
> > > > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > > > - * always gets order with a constant PAGE_SIZE.
> > > > > - */
> > > > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > > > -{
> > > > > -	int order;
> > > > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > > > -
> > > > > -	size--;
> > > > > -	size >>= page_shift;
> > > > > -#if BITS_PER_LONG == 32
> > > > > -	order = fls(size);
> > > > > -#else
> > > > > -	order = fls64(size);
> > > > > -#endif
> > > > > -	return order;
> > > > > -}
> > > > > -
> > > > >  /**
> > > > >   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > > > >   * @epc: the EPC device that invoked pci_epc_mem_init
> > > > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > > >  			   struct pci_epc_mem_window *windows,
> > > > >  			   unsigned int num_windows)
> > > > >  {
> > > > > -	struct pci_epc_mem *mem = NULL;
> > > > > -	unsigned long *bitmap = NULL;
> > > > > -	unsigned int page_shift;
> > > > > +	struct pci_epc_mem_window *window = NULL;
> > > > >  	size_t page_size;
> > > > > -	int bitmap_size;
> > > > > -	int pages;
> > > > >  	int ret;
> > > > >  	int i;
> > > > >  
> > > > > -	epc->num_windows = 0;
> > > > > -
> > > > >  	if (!windows || !num_windows)
> > > > >  		return -EINVAL;
> > > > >  
> > > > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > > >  		page_size = windows[i].page_size;
> > > > >  		if (page_size < PAGE_SIZE)
> > > > >  			page_size = PAGE_SIZE;
> > > > > -		page_shift = ilog2(page_size);
> > > > > -		pages = windows[i].size >> page_shift;
> > > > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > > > >  
> > > > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > > > -		if (!mem) {
> > > > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > > > 
> > > > I think it is not good to modify caller's memory. This funciton suppose
> > > > pass down read-only information. And set to epc->windows[i]. I think it'd
> > > > better to use epc->windows[i].pool/windows.
> > > > 
> > > 
> > > What do you mean by modifying caller's memory? Here, the memory for epc->windows
> > > is being allocated and the pool is created for each window.
> > 
> > windows[i].pool = gen_pool_create(ilog2(page_size), -1)
> > 
> > 'windows' pass down from argument pci_epc_multi_mem_init(
> > ..struct pci_epc_mem_window *windows, )
> > 			     ^^^^^^^
> > windows[i].pool = gen_pool_create() actually change the caller's stack
> > memory.
> > 
> 
> Hmm, you are right. Will fix it.
> 
> > > 
> > > > > +		if (!windows[i].pool) {
> > > > >  			ret = -ENOMEM;
> > > > > -			i--;
> > > > > -			goto err_mem;
> > > > > +			goto err_free_mem;
> > > > > +		}
> > > > > +
> > > > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > > > +				  NULL);
> > > > > +
> > > > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > > > > +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> > > > > +					windows[i].phys_base, windows[i].size, -1);
> > > > > +		if (ret) {
> > > > > +			iounmap(windows[i].virt_base);
> > > > > +			gen_pool_destroy(epc->windows[i]->pool);
> > > > 
> > > > I think move all free to err path will be easy to understand.
> > > > 
> > > 
> > > It is not straightforward. First we need to free the memory for current
> > > iteration and then all previous iterations, that too from different places.
> > > Moving the code to free current iteration to the error label will look messy.
> > 
> > All from current iteration.
> > 
> > err_free_mem:
> >    iounmap(windows[i].virt_base);
> >    if (epc->windows[i]->pool)
> > 	gen_pool_destroy(epc->windows[i]->pool)
> 
> Initially I thought it would look messy if the memory for current iteration is
> freed in the error labels. But now I implemented it and it doesn't look that
> bad. So will change it in next iteration.
> 
> > 
> > > 
> > > > > +			goto err_free_mem;
> > > > >  		}
> > > > >  
> > > > > -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > > > > -		if (!bitmap) {
> > > > > +		window = kzalloc(sizeof(*window), GFP_KERNEL);
> > > > 
> > > > According to below code                                                    
> > > >                                                                            
> > > >         epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
> > > >         if (!epc->windows)                                                 
> > > >                 return -ENOMEM;                                            
> > > >                                                                            
> > > > epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
> > > > I think you can direct use 'window = epc->windows + i', so needn't alloc      
> > > > additional memory for epc->windows[i].
> > > > 
> > > 
> > > First we are allocating the memory for 'struct pci_epc_mem_window' _pointers_ in
> > > epc->windows. Then we need to allocate memory for each pointer in epc->windows
> > > to actually store data. Otherwise, we will be referencing the nulll pointer.
> > 
> > I think two layer pointer is totally unecessary.
> > You can use one layer pointer 'struct pci_epc_mem_window       *windows;'
> > 
> 
> How can you store multiple 'struct pci_epc_mem_window' with a single pointer?
> Please elaborate.

struct pci_epc
{
	...
	struct pci_epc_mem_window       *windows;
	...
}

pci_epc_multi_mem_init(struct pci_epc *epc,
 			   struct pci_epc_mem_window *windows,
 			   unsigned int num_windows)
{
	...
	epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
	...

	for (i = 0; i < num_windows; i++) {

		struct pci_epc_mem_window *win = epc->windows + i;
		
		*win = windows[i]; //copy everthing from 'windows' to EPC 

		win->pool = gen_pool_create(ilog2(page_size), -1);
		...
		win->page_size = PAGE_SIZE;

//below code also can be removed
//+		window->phys_base = windows[i].phys_base;
//+		window->size = windows[i].size;
//+		window->page_size = page_size;
//+		window->pool = windows[i].pool;
//+		epc->windows[i] = window;

	}
}

Frank

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

