Return-Path: <linux-pci+bounces-4470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD39870A19
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC9F28155B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96BE78B68;
	Mon,  4 Mar 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ouLbdISb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185D78B5C;
	Mon,  4 Mar 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579334; cv=fail; b=Ez295xbYofGVZ2/5beCg6nE58cQOIamO1E556P/PNKFPzrt68dzo4SpDZ2tkFUsWNW2lKfBYgLIss8YiawhDx4ZeEylB2hvH0wXBpE2jH/x4tM81dmodaJHV6toyfBAQTsALrPJVBrhJ9eLq4qAET6+QScnX2r0DHk6jRy7GA2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579334; c=relaxed/simple;
	bh=z1eeRwchmhltHx5m2zh9+9Xvu3zYIzbGKlhL6KXNgAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nto+ZgduWYp33Ew5KLqF1BTaoLwtxRMTFqAfFYbljrMYqus0tw50i1Yq9w9m6qpqdBoiaPr4Vadda1hbQyM0qyLvVDSLfKw19OW4afztbye/g1y1oyD+263KiE6YyyJwMblQNZBc2QXSLX/VY+sM02CQkbrOfLtIBoyIPAzB4dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ouLbdISb; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Qmv3F7LKlahMRHiM4VgzMmS7xaBp9Nhsnhn/cz2hdqrhqEC2o57NuiZzs4poiOxHgBTXqu1UC2AliWXXNma8dJFF10GrXv8nbxaW5BzRiNbYf2gz7rimZAm0LZGOe9JzX0SPnxZaH75xbVCuhak2pfvA4hnkqi8fu6abGsErb4Vk1Bl6fw/L+sx+jpg79ycuX2YicK1zmvOsZJ8qeH2YumT6XhSX7E61f+jl9JL88L7Hsp3T1RZ0fsFPK2SIH/U7mV4fDGqpltaJ68ceMnDCvW+SNcNpPpV/lVU5tDOPBYfe5G9YIof2bDQo17ZRZ7flwCFpWC8r8hxMtQ+1QnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn47uum3Yi+6Vsz6ZdsjDMTT5dJEZ4BHF6+SAmGblrg=;
 b=SfNv72VWTKUYVwet0Np+q4Zpfx3yZ+bJQIldm6LiXpZHTMJAy7EbUUQH5aI//L7J9ivf5ep4h6QtZCZ9mqfnO0Wk2bwQuFV1bFvruvsh6boejKjYgztYb8/gmAh5mTMZxell3rPxeAYlS7Bt2XOOL8Tg/qjkqkl1Ybp9k6TLUyq5EXSDNslGn/V5F3WENVMs2Dmjo05APPXaHzj0SGvA596eiiLnMq1d8V4AJGnEZ0KDAYmj/HzU00tH4EyPjibfUXVuD929XSk/S4cRbrN12Aw5gPcAEGriBQt5ChcuRGYMWiMpvosK8wX0EH6GeTasLntyb3cDHgTOfR3ucp2b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn47uum3Yi+6Vsz6ZdsjDMTT5dJEZ4BHF6+SAmGblrg=;
 b=ouLbdISbvnpRSAlJwFTCNRAWMvdNjavWrLl/RnXNXIhorSAecJn+0O93Xs40HcdaigGhrpfYBxY3ihajpIMZ14qGoxxjB7LiU6j1sRvaByeA92lg0f3+jPoyqTdr2Of3tKlFq/tc0JiI2W3DC4vQ4LYmert+EK3NTLAFSn3hYjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10149.eurprd04.prod.outlook.com (2603:10a6:150:1c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 19:08:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 19:08:49 +0000
Date: Mon, 4 Mar 2024 14:08:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: pci: layerscape-pci-ep: Add
 snps,dw-pcie-ep.yaml reference
Message-ID: <ZeYcOUAb7NWjTh9m@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-4-Frank.Li@nxp.com>
 <20240304182049.GA851904-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304182049.GA851904-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10149:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d1ecac-b10a-4504-3402-08dc3c7e85b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRsAjY6HvqgzddTJ72SOwDKb5lyd2pQN5oAkyOrRNI2Xibfnc9Od6UgUFXUSQCeF8xBugPjSN8thyHZtMU+bzn+SQBsIIh5o+1EwjMXnhCA38vMlpboJSHfNeyNI7YmAOk6Cj/0fBCRzbPEe2MeiKFdBy7EaxhuDd7dgd7cC96nMb+sMVw3/5086AEG+xgs3w7XqVlirn+kP8SOG31m4ARQEDrF6UvWS85T802COw3vU/nlbNLy0/+2Fy2/1buJMSayQQMkXZtivEhFVU+5z8pMoXWljvQLBxKF+rubaWhlLix6/HUIRChqTFwivsPxhvlOkgc4WFNtWcA19n6bIMvcv6Ic5HEYfR1MIMF35wXVud5qdASbEMVqKiIpaKkGTsR6Or/SOOBuB/guD59t8ov/vexu/iM1L0GveJTR4/LNelI/2B2Thb//IIQX2PWzAXtJmqystEt8Wcfco+MNHzVWwNDmQwwkM4H82L5k8YQePLbYGGy7qh2x7teRuoPrOXNEY/siJL/faGnbMeJCsA426TdWWk1ceMjIdUkAkQqMpfcrrvDC8bJx8uYUrPwE8E3YVyueR9BNrglnnf7r1MwkoX9Q9EaLqf7Bjpvv52lrskkYZWTsjW1tDvcYNhOnbd4N4foo5kaHgDTMlB+a3LEvj1cpvyoQv7ky5f7NhJkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTQwnEpeo5lL+VxHySdrX8Z06eaLc20xjnXqoaKPiZxsVJxrOocjBEU7+Pic?=
 =?us-ascii?Q?/r4ipp/NERZVLOw8tMgrgrTwlZMdlsULyx75RaRG+st2nhLbkZ4jNvzcHTnW?=
 =?us-ascii?Q?tZmyQADXJJhLT6lzNVgfVLYsQo+krSGLBPBVzb2On+OqRwVlFjQjB6us02HU?=
 =?us-ascii?Q?XRSeDqImbEK8Ecn1/boRebGyxqY7b4ZyN1gMyhartkAxufLVGoUPku+gisgb?=
 =?us-ascii?Q?aH7Y4eaQnemqTq8A4Cftx3KLV6m7+Rp7OhWXI3XWIC1N3EQabT62oul3Xhlt?=
 =?us-ascii?Q?RcrvvJkHUrueLtUNrvlfIKBUmNx+2ppQUQXyHVV2WIzTCkxS8E3WAP07rLtp?=
 =?us-ascii?Q?AO+xCEr/8NuJ7L0UJEa+lXWjKfP+jRvPHVwmk0uKKj9RO53MAgRphppFTRDP?=
 =?us-ascii?Q?gwTs4bK8LuWz9DRZ2UpmpYDTpbpoQ3W/EgxHarYmfWWYSWDM/Ke9roIkrIyU?=
 =?us-ascii?Q?zGANVdWeLHvCqXHdTsEnwhNa03HWbK8TMspkvrWE1SDKYUaq1hPwZKUMgHqT?=
 =?us-ascii?Q?Mx/9Nrc88vUh7ygByXANca2jUccFZLamx188UtZGdD8DlJiGtz84b/Cw+Gk3?=
 =?us-ascii?Q?7PuxTw3SjqFlWz/EiDqodexBGVpfqEbgS+bVCWWPsT28zBS2D7hB7UqEYYiV?=
 =?us-ascii?Q?2zM4C2d7Wsc6MUyTRrzdm/ZqHTPhjUFcLwAom5FVR7hg1XthxYCSb8kj/HSO?=
 =?us-ascii?Q?V2cKH7xKjCFQ0Gqgm4BhaD1Wpk77cqgFXfSKKiXQMX2pw4HgQy7KnZhEBwsl?=
 =?us-ascii?Q?X1Wou9RIbHjQHWszSTIMo6ltOaHZMdOXS0upSvwzYAPf0ojn4yp2lQoDwppV?=
 =?us-ascii?Q?LxmfoOphFKpD6JwzMxszXlaeVoAeOKS//tzRsFa+txlzkactyjFSrKgY5hSz?=
 =?us-ascii?Q?EDsYpoMYSqOp5FFA7H8g5e51geaSVjh9Vdzx90WrVC6v2YFlu5/sIfcrW1Ag?=
 =?us-ascii?Q?7ZgRqc7CiOzlv3AslGni/XjJqDBUENU6a2fuu38TGPAjgnWAnXUoG8JhnC/v?=
 =?us-ascii?Q?5u7/kZaVlgQBQ/XKky8fjNOGPt7m2OADu5Gtwsgme/T5zj5IfnSKY0r3Ud3a?=
 =?us-ascii?Q?5rwqDKZNcHrYnU7q9N+0luKgyU3YrM7N/ad9gyRw0ab7Nzh6dIp0CvIonJxx?=
 =?us-ascii?Q?AjL0GImdFgL1OqbuYqkTb4CrGW7ukpDLCuC4J4tGKYEk+XUuoHt+qVU/MDEs?=
 =?us-ascii?Q?MARiVL18W7LpL0ESGjoL6XDPCo0ephGaZtmk9N5PBbQowL1lZEK3/vwy8cz5?=
 =?us-ascii?Q?5GVUsOZ1whWCQImgQf1Xuzd3YT4Bs1EkY7HqnzaMHjYUxuoelAifl+i/0ZcB?=
 =?us-ascii?Q?hv/wqquFUBLCFR3WAgBVirCBhic6DJ0j28/cbBAFhjJ+co3aETlbDllqpQ3c?=
 =?us-ascii?Q?BQKCHW+CoV5k0+oRxQbG8kO48bEz9dqfwOTzwdnxn3Fbm1QufP1b4J3fQGc+?=
 =?us-ascii?Q?d4ttvDE1nRsC8LbE/8IxtJQL6W9no/JVwfmT88Cz6Z88Yua+UZex405CU1Px?=
 =?us-ascii?Q?sG86hi2XY3/S5wV6LnQNR9XsCOfei424bwnr9NypNYCcHV+Bxl5r5lZf7Fmr?=
 =?us-ascii?Q?k7vCd3hdEVXRs65bwY0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d1ecac-b10a-4504-3402-08dc3c7e85b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 19:08:48.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpGr2v6M2hLBgCGWmTpd13Z2hI932OSmlTTv0T6HVfwDx/XdQmOhZHiCmS5NbSMbG+ujo8PWpZSEvyRJ9AP3fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10149

On Mon, Mar 04, 2024 at 12:20:49PM -0600, Rob Herring wrote:
> On Fri, Mar 01, 2024 at 11:27:41AM -0500, Frank Li wrote:
> > Add snps,dw-pcie-ep.yaml.
> > 
> > Remove context that exist in snps,dw-pcie-ep.yaml.
> > 
> > Add an example for pcie-ep.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
> >  1 file changed, 29 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > index cf517e4e46a33..07965683beece 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > @@ -10,8 +10,7 @@ maintainers:
> >    - Frank Li <Frank.Li@nxp.com>
> >  
> >  description:
> > -  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
> >  
> >    This controller derives its clocks from the Reset Configuration Word (RCW)
> >    which is used to describe the PLL settings at the time of chip-reset.
> > @@ -35,31 +34,18 @@ properties:
> >        - const: fsl,ls-pcie-ep
> >  
> >    reg:
> > -    description: base addresses and lengths of the PCIe controller register blocks.
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    maxItems: 2
> >  
> >    interrupts:
> > -    description: A list of interrupt outputs of the controller. Must contain an
> > -      entry for each entry in the interrupt-names property.
> > +    minItems: 1
> > +    maxItems: 3
> >  
> >    interrupt-names:
> >      minItems: 1
> >      maxItems: 3
> > -    description: It could include the following entries.
> > -    items:
> > -      oneOf:
> > -        - description:
> > -            Used for interrupt line which reports AER events when
> > -            non MSI/MSI-X/INTx mode is used.
> > -          const: aer
> > -        - description:
> > -            Used for interrupt line which reports PME events when
> > -            non MSI/MSI-X/INTx mode is used.
> > -          const: pme
> > -        - description:
> > -            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > -            which has a single interrupt line for miscellaneous controller
> > -            events(could include AER and PME events).
> > -          const: intr
> >  
> >    fsl,pcie-scfg:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> > @@ -68,10 +54,7 @@ properties:
> >        The second entry is the physical PCIe controller index starting from '0'.
> >        This is used to get SCFG PEXN registers
> >  
> > -  dma-coherent:
> > -    description: Indicates that the hardware IP block can ensure the coherency
> > -      of the data transferred from/to the IP block. This can avoid the software
> > -      cache flush/invalid actions, and improve the performance significantly
> > +  dma-coherent: true
> >  
> >    big-endian:
> >      $ref: /schemas/types.yaml#/definitions/flag
> > @@ -85,3 +68,24 @@ required:
> >    - reg
> >    - interrupt-names
> >  
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pcie-ep@3400000 {
> > +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> > +        reg = <0x00 0x03400000 0x0 0x00100000
> > +              0x80 0x00000000 0x8 0x00000000>;
> > +        reg-names = "dbi", "addr_space";
> > +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> 
> PME or...
> 
> > +        interrupt-names = "app";
> 
> app? You seem to just be changing the names to make the example happy. 
> What do the dts files have? You need to make those pass.

It's on my plan.

First need change 'regs' to 'dbi'. 

https://lore.kernel.org/linux-pci/20240229194559.709182-1-Frank.Li@nxp.com/

After that, I can update all dts.

The second step:

Change EP side interrupt-names. 

Frank

> 
> Rob

