Return-Path: <linux-pci+bounces-4880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFE87F0A6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6321F2271B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866B56763;
	Mon, 18 Mar 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qqreoRis"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FB56464;
	Mon, 18 Mar 2024 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791884; cv=fail; b=Pom+QZuqVtvI5WaYHpAEt/0S7cgFjKD6cUN9vvGL/+K6I0Uq9RR8pnl9p1cxeVoSWSrhejwEMVoiY+5PSh/eGoHIxz8GogOAUj318GLyzLcyoPz5MFY/wchVLElmcxOQ+8q5YVMxk8hER/aM7p66k/dgCevQQm/3uHMssSL5p30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791884; c=relaxed/simple;
	bh=DXajepVRN0ssYVNpFw80MeW7n6vRGa2+Xg+aXfj0a6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bFlyvVKWOOGNq86ROg+NKvE9Za6Ldcf6848VVqyoybYkWR+DSj4z5xj4x3o1T7Vhw2HnpH+/nLkqiZtJ+5ZWaDfY9Xz/TGgJqR68I+qZDRHBNJwtt5qR4ZRrR3HI+pHNuBTAgee0d/dZjckknQNl950iqKsoqAhcLfjj7OUihGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qqreoRis; arc=fail smtp.client-ip=40.107.20.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn394pOx/wD0AJElJsTV9t8rVi2LhRClIos26EGZGHJ0Gq2uDEyC6SEHmkey2VhPetjSrYYYmogpmGprOAvn+ugR/zHIrnsuQ4IT4ZiCSEkczM7f2jGBK9E/vScFS2bQR/lfWZzQVjCumOioQ8gfzyeZpboMln+VHViMLBpZiyYfnXVGWjKn5TN9ZbxyLyFHd5KyDCGOU1HjFpGzvTT835Jt/c6bT1BnpwpMEqrq1tlG05JclHutuAQmE2dUeqgyPhwE8/fUSj9hLF56I37HvoC+9sydNPuQXl96jCp/+ag0CviCJKiGs0ju6TcF7ylMyh8pcwvCC8OyMN4Ki/7vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPkMmm5KXGDKYGZ7GBIWYH7bNRztwon/Vx852+eL1+w=;
 b=HlHPkn536RcKeUxuQORhe8Jse4qcG6cv/Q67JTJ6bTsatxVIyUT4uKGJswvOFmlYWsuHGxgel5I4ZtTi9d1jb81G/ZCtbUv5c+fQSUDg/iAAjH/lQiR50QQsgOPU2Fx3ssCdp6gTJs7FD8p31W0qWBZl6qWpqtAgCQs6z2e8nKf/BpXrZ74HlZp3jKOf1x8wJOsya57mdGKDCBas81fkdxAfYWf3QTu8MZPig8yxrXW9tAs1jgNRNp6Jz6Lg87hwJuwuSu3Nn3O7F53Sd3vzEQMH8EgGBc8ryU05X0W1bkmo91ypeXTL+fnEZVtL8eK6z5wZB74Quz630LQ1fQvk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPkMmm5KXGDKYGZ7GBIWYH7bNRztwon/Vx852+eL1+w=;
 b=qqreoRisChzvvS4Z4ZH0E4xm+dVIUKFl8Pm+3AjzG0/AUSBJJaHHisMeX2ef6Q94jArblzrekAaNFksxKKeWDNfPaat15o7YQziNqRxmd1dCAWbeZXyM8zbQwfYKlwp0dfbC/NHM3TRS/vsoUoJRnr2oEvkzdmg9FrMZJ8LJEqc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8086.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:57:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:57:58 +0000
Date: Mon, 18 Mar 2024 15:57:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <ZficvkryqzdwJIEd@lizhi-Precision-Tower-5810>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
 <ZdNwxAi2KH/P07bi@lizhi-Precision-Tower-5810>
 <ZdzJMtgcaCPpJNNW@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdzJMtgcaCPpJNNW@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zsmNPBqhRLZGv6mpqdLKtRbppQIfU2g1FBHETYwkcEcRXeQAXheA720bNthPPiT1QCgN/Ksm1R5m0JxV3/326Ewx6t/V/JtYYKYoBHlFTSo2Zp78AK2g7dCJSuIDSs3Le2riNg8XF5rfWlMCM0V8xgMTXPjIYtFs/rvbdaZSd+hWRyP9DWT0b2S1H1DkD33K6dPMKJWiU4jrjB8O6XTKm6SvSY49wfVBs4dB5gdbX+7DgekhAriHefuvKHialJ3Ct2fIxDL6BhhRtcF9aqw6jUrwmILXRioMISg4JteoZken+ZdfQW1hpPHZMcmRrJx9npro8Cg98hcQIvK9Rqjbmz0gtDeFi+jARhPHApkAZ0PjfMm/NPfeRygWtpD45CwNtDzvLj6EeBrW85flyXPEY2nvhS2TU5AYirm5gzJ270N3WqLJz1Q302YJOUiRfGhZpWUN0VEFzTq/ZPgqIWtjrCnu92r/hfYvVmV5f0Ln4BMLJxKSCapGUSDZjaOxtwF1nLiufBDNM4uS02kwrNJtlvO0c8imA9mXgW8vvKcCm1NY3nW4i1I2nRBqYEHKiz5x5ti0Zcb3ZFWH47iCJq6vYfKNctG771hZ6P3YDAiq78DvODMLZvzr0FyAg5ocVPFLfwVOPUVnRzAAgeJCVAlU2q5MGO9UxHWI+Wq6Rks07Mc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FZh8AXNYjaCOkbOm3yk1i7IELJlCEpcnLBGWS18o25OVTPspeZKlpyxLsq1W?=
 =?us-ascii?Q?sPaD53pHNZDU5ifkbikwIMAG55cLUcA/Hm66da+BFO3mGrG8GFWyCyeTbzUg?=
 =?us-ascii?Q?IhRwzpXdPtayiYpBCUwdAn9ZNyqMq0VZlaZJW2YI1Qnm8GAxj1GqdrUIuJu6?=
 =?us-ascii?Q?L8HkEiNqQm7QcipqjAO0L6DtZsDklUWtA715bqXgoJUatMByjIhxA702Eyd+?=
 =?us-ascii?Q?kTJVCgRKwdAt5c0EspM3xwcBAmKFKtNZR+7yKAQp/difsleD43NKvHMHqnXJ?=
 =?us-ascii?Q?ebiO1Da9tK4Tx/LPnJNdijMI2ZXAAdsOftcbSOc1BvLFNdq4sbqXOFAFCDwJ?=
 =?us-ascii?Q?7/9Otap/sxYKfKNZED/Ebi/gS5b/FB/q1/8BDy7BFOg8YbBMZEdyq0vBpvuP?=
 =?us-ascii?Q?E2SXNjqbS6Z6tTTL1rF+gnVP1sd8+mFtE0m0I4u3+oQEm8b2//NvhQen5yem?=
 =?us-ascii?Q?75O4nTokZxKgn8gGRXGZ9HGJ24ZowsATMDOovgIqNTdvIjkw4E5Zy0id12XR?=
 =?us-ascii?Q?Th9U1kK8ABFCbLikEyHrCoLQp9leRv3fLb1NMPR3S6hXkHdSYH/A8365wq7j?=
 =?us-ascii?Q?z47dFRj+33QobzhkrEjrUCgHtvkEp38FUwt4hCKtOQ1GTLh/IyN/3iMmbCbQ?=
 =?us-ascii?Q?1+Y04u24u25VgXdUaAh+5UtoJ/alKk02LCJNd8MElVGP5wkWjQetnuFYrrXh?=
 =?us-ascii?Q?HhSl3YaGamoDyxI1qHx96UzgBTJVSMat722rQoqm2TUp60IoA5HWw+GorBJ9?=
 =?us-ascii?Q?7qduP/EfUquYyIa7hWUuuE9q+S7LxuT38+CCYHV+GdYe5FXJzyhuSyWt+yPs?=
 =?us-ascii?Q?R6I4h5SVsVzozkT0DxmdOgR21/8gMJiV7nmpGxUZfxILIRyQvw2CglEAqeFu?=
 =?us-ascii?Q?skWQPllSKuH0uq8UcfkS+BP6NMl1qHoAHOdrc1oi7DM2kqJwTryaW4LcMu1W?=
 =?us-ascii?Q?Pt2k4zVMex6/ry75xF9v5FoSBJ5pQbnNtZDOS9snIxN7Ti4yPf3T2chfyzfl?=
 =?us-ascii?Q?ZUw7Dlnt/i+Vf/cBarMjmn1XiUwDyAZyFidZm93ZTGllzU7cHWE6YehOsq+G?=
 =?us-ascii?Q?Es37ftAOBX0En7++p3n0u6IBmkMbcNEciEpdlwm30e1VmVKu/NMVnj9eCTlj?=
 =?us-ascii?Q?uT+wfu6YKSItGcZwcVAohbtYkKDjTRCeC9no1CBIw0cxITYbl0cAVzAL4/bE?=
 =?us-ascii?Q?vIWxJhuyRq5/R13RfgbQFmiuylxwZloFE5Fm4bK68wlM4Dxrfeg9Yzx1C+rO?=
 =?us-ascii?Q?QG5Ap3jibJZT06i32RbUJ/XB8LKnK1ZQXvIfsdGzdnpzC2Ya2unhdLe+H25A?=
 =?us-ascii?Q?uDq4m+R8HVPCBEaQw2IZ9cvL+WN2CWFckcYlAcx4ZIu8PB6NYdRiDRbtWTcY?=
 =?us-ascii?Q?e0Gu/v/7y3BAHuGrKyhYkRusLGyzm2gvMTs8Emuqb+dBlGpNAqRXNL+9B2Ko?=
 =?us-ascii?Q?6JjhMmLuPeAvRKRWIM4YHeh5Q6lQpBfiS46JxCBR9H4I9+EuU2DmKp33FEbC?=
 =?us-ascii?Q?rUHjGQ2VakNt3VeeuwldhqJw55cERsiNbzkkkERSkTroWYGlu+1Ycn1gJ4SD?=
 =?us-ascii?Q?yV7b2XY5eoJWV7yshYSr05FTlRAwHno7/CeGfwgK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f52a7dc-721d-4a29-6924-08dc4785b581
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:57:58.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT2pnvqEBhNVAMmw+UywZ1PjFrJW0Nq5mwro8Jrh4UQYf6WHkua6Wyd10xT+h7xM35Yw4epvvzQUhqPafrHiIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8086

On Mon, Feb 26, 2024 at 12:24:02PM -0500, Frank Li wrote:
> On Mon, Feb 19, 2024 at 10:16:20AM -0500, Frank Li wrote:
> > On Tue, Feb 13, 2024 at 04:50:21PM -0500, Frank Li wrote:
> > > Involve an new and common mathod to send pme_turn_off() message. Previously
> > > pme_turn_off() implement by platform related special register to trigge    
> > > it.                                                                        
> > 
> > @mani:l
> > 
> > 	Do you have chance look this patches. Actually other patches
> > already reviewed. Only missed
> > 
> > 	PCI: dwc: Add common send PME_Turn_Off message method
> > 	PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
> > 
> > 	This patch will reduce customer's PME_Turn_off method. Many code
> > can be cleaned after this.
> 
> @mani and @lpieralisi
> 
> 	Do you have chance to look these?

@mani, @lpieralisi and @Bjorn

Any comments? It will benefit for all dwc platform. If this method
accepted, we can remove all customized PME send function at difference
platform.

Frank


> 
> Frank
> 
> > 
> > Frank Li
> > 
> > >                                                                            
> > > But Yoshihiro give good idea by using iATU to send out message. Previously 
> > > Yoshihiro provide patches to raise INTx message by dummy write to outbound 
> > > iATU.                                                                      
> > >                                                                            
> > > Use similar mathod to send out pme_turn_off message.                       
> > >                                                                            
> > > Previous two patches is picked from Yoshihiro' big patch serialise.        
> > >  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
> > >  PCI: Add INTx Mechanism Messages macros                                   
> > >                                                                            
> > > PCI: Add PME_TURN_OFF message macro                                        
> > > dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
> > > to map PCI msg.                                                            
> > >                                                                            
> > > PCI: dwc: Add common pme_turn_off message method                           
> > > Using common pme_turn_off() message if platform have not define their.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Changes in v4:
> > > - Remove dt-binding patch. Needn't change any dts file and binding doc.
> > >   Reserve a region at end of first IORESOURCE_MEM window by call
> > >   request_resource(). So PCIe stack will not use this reserve region to any
> > > PCIe devices.
> > >   I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
> > > will skip it as expection.
> > > 
> > >   Fixed a issue, forget set iATU index when sent PME_turn_off.
> > > 
> > > - Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com
> > > 
> > > Changes in v3:
> > > - fix 'MSG"
> > > - Add pcie spec ref in head file
> > > - using function name dw_pci_pme_turn_off()
> > > - Using PCIE_ prefix macro
> > > - Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com
> > > 
> > > Changes in v2:
> > >   - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
> > >   - Add Bjorn review tag at  Add INTx Mechanism Messages macros
> > >   - using PME_Turn_Off match PCIe spec
> > >   - ref to pcie spec v6.1
> > >   - using section number.
> > > 
> > > - Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com
> > > 
> > > ---
> > > Frank Li (2):
> > >       PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
> > >       PCI: dwc: Add common send PME_Turn_Off message method
> > > 
> > > Yoshihiro Shimoda (3):
> > >       PCI: Add INTx Mechanism Messages macros
> > >       PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
> > >       PCI: dwc: Add outbound MSG TLPs support
> > > 
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
> > >  drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
> > >  drivers/pci/controller/dwc/pcie-designware.h      |  21 +++-
> > >  drivers/pci/pci.h                                 |  20 +++
> > >  5 files changed, 197 insertions(+), 64 deletions(-)
> > > ---
> > > base-commit: e08fc59eee9991afa467d406d684d46d543299a9
> > > change-id: 20240130-pme_msg-dd2d81ee9886
> > > 
> > > Best regards,
> > > -- 
> > > Frank Li <Frank.Li@nxp.com>
> > > 

