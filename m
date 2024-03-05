Return-Path: <linux-pci+bounces-4526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150F8722D0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427C21C221D8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976F1272C4;
	Tue,  5 Mar 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sBdApPKi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE61272C5;
	Tue,  5 Mar 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652641; cv=fail; b=LSbYAOwadUMLa4TwLhFVVFB245Pelt994ZbwlaC7KFhIFVTYKYStkq7mVs23ECYGXAzuJi4n0RUuBQ0VvUXIC/gtRjVPWATFLWcMJM3jaHN/9t0M00J/QfGF3fK/JNrQV7Ish04DQOi+BpNPvhNkmHkxhnWr7O1ySgQaMGAr4VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652641; c=relaxed/simple;
	bh=kqCFdcIQjD67FrH/9GbZuHcQA3g4/xmNrkm5bqnQo6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qLezlraFsv7xRn91UtA5tanFBwDbLFfTRUJN8GdCAapcre9W/zPAV7kv22zbW66ZerxGqiZQ6MuEQIcReD0UkxIt4Idywe/szg8m6PBi7CjcljKvzgIkR3+3M/RaTZuvVj6McRrNlf2pNiebEsVp6QJKBhygqE5OriOgsi0XFiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sBdApPKi; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk+ERLatwvFan8ZA2l8G4hm8KrSsV+mC7KufSAjoOHr3iTsVjFCRtGTHmNTDQQn6pyMF/G/WvXKmvF3VFsA2XoOc7O7SlQ8BFURyAOPB4/F5QI9A3X909//sc010wnqMYsq+Yt+zFkqdOnXou+9mzlu0fTRom/5icxD+3ZTaG+Vwk/yTzuU3qh1rTenqMkS9YWA5hH+nIMuwIDY7/KiOlNRByKk4ez9UD5QNpxu1LRJOz5OPijUCmcZ/yZOQUxMCQtbGu9gxryVQtPdgkeA04nLGJIeeGan58sFDS5lSicoMoFOdb1ODu6xMlYfxqfnCIqSH8GW8EuigoOPvLjFDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/Z9Oq54PdmOH1zcq2F59tuSS1BPluC+ubKSC3w/7Fw=;
 b=DYfo3qc6ak+NvfYYkMPagbo3YA9k552n70wD7t4ySvU8lrRYLtOYASDz0xPHLbV20gYOkyOLqOwXSA+VJIwNhT4u1d4K+KHT65nkLhGM4vmrByh7IpQ8E0BS2ps5PaD25LoDWLAwq+hVr+lgd/5XSMC05PwyTcZj7h5BwxX3idZCqFD7PbxmgZPD6DBlg+ydo45EJhgwhr4nwIdiYhQoED/xbQcI36et3rl7gZ+ONnJA0nCLAbncglYVP156IU/A40tfEJjoXT3BULeu6dNIYCZD7Z36pwbIqX3C0FUd0fE32IAbDmoIJBL3XV7qjwdXtRSZST+e9wcoiNjmB0iUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Z9Oq54PdmOH1zcq2F59tuSS1BPluC+ubKSC3w/7Fw=;
 b=sBdApPKi4GxR52jH1cAl3CAv1WAQl6btf0fhYCex2+JB9NC0scIH1sxq+qKGTKp78Y4B0vE25YyLJbIrdRv+26QVZYJOxizzbIZ8wlsOf9mul0KgLYzkJ02J0e5ujCqgEslNoz9jNCG9dxkXrH83/bpqMULkfUhMPQxNTZybKKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:30:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:30:35 +0000
Date: Tue, 5 Mar 2024 10:30:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: pci: layerscape-pci-ep: Add
 snps,dw-pcie-ep.yaml reference
Message-ID: <Zec6k0NRu9U6N932@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-4-Frank.Li@nxp.com>
 <20240304182049.GA851904-robh@kernel.org>
 <ZeYcOUAb7NWjTh9m@lizhi-Precision-Tower-5810>
 <20240305143719.GA3310214-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305143719.GA3310214-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: b1347721-3062-4c1d-0b1f-08dc3d2933c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VLJQnna3u0KbhdH8x8NVH6CpqdtPh0N6Qprw2klMbIDWdiSxyAQUAsO94CIIhnx00rLzgRnhFlqBbbGsHbhRBUDqe1CM2YQLKeeS/68rR0b5VEM6+f9KF5hVSQ+jkuUTdu9wMKEza/uc2b7fsh10NBvIO71QfhR+V8EMTkKzpPmf5Lkz3gGyLDhhyi2U+P5g45W8VqIy6AnChNU9B3KmPFtqWL3VHHyY6pIpZS+K+H+0GM9TD1wU/EQHiELPdNdYl0+gtbSeEVXMYQDH4+wl80+8cpyxfeXSLcwdafIo7QPg1RDXIJeAInJM3FBwXlNdJ1V7l1JQ2NbZNF46WtgIp2hMaXboxmtM6nx8b+kw4R+8toGxxpNUBIGwVecYGmTmX/LARPnJOJTYD7xweYLguFvX8jD3eq2QZ2bj4UndkKbpu/pV7wLcVEasYZSjOY1J4Pc3TXnMy3DXoDUvgvWU0ncfEB65JiSPBePnkpmZyXa/lYDDWb0NgmA2vE4r/BBznnCKigxknq4nCdYkY8QA4lwpiZNM19hqbJg5Ieyv/iViCmWvPZDNCvfOAARPOEJZZGesp80uDj0ma3aajSRbgDJZHIVRONexqRghkl1Mv4IY3NibMZ7RHvLKgU82uo9QXcj1gggqTpzU08YF7x9KHiQY83Q00FIzha40Fel6Rno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqVCsGqAbB6TkCb2rBomIUrxlmvDbUwYaWrfhluFZD/O0ri1bdks9dHpp7k6?=
 =?us-ascii?Q?Bw1zvWird3qQFf1Dwl2JDy1fjcal8fJWNtQdOQFMxZzWpcqpmv0QWOvNg0ZM?=
 =?us-ascii?Q?Uq+kYYUYdFlRaOmOfNhi9GlfOcCkTw33mMDC5a+d5h9S9f5qJpvtKmYXg+I/?=
 =?us-ascii?Q?nPIEzvuZGhZ15HdnmeJqdowOdwE9qHKTVESI5oWNUeDhgTZMdSvjs461/rD8?=
 =?us-ascii?Q?6F6iHpu6PAObPbVVkncajO0897A6ifXkiFlBrbWdNu7p55xraTPPTR+PPxu6?=
 =?us-ascii?Q?JV4jc80AvW7OrNXG8LALMWGUCip0CNMvzUEaMbmUHcrfZbChuPOprYLNRwvN?=
 =?us-ascii?Q?/Ilj+6wAT6lfLxbhmNfeybRmfy9+0zyXoBmDhWpBl0VMREJizg1dfBhurlc1?=
 =?us-ascii?Q?NtiEdx9F/HLzD4bS0B6ceAHSbdedI5FpPlZQ/zlU932bTJVcLY9yS9UBGXLI?=
 =?us-ascii?Q?p+75ZEsD0gVf9iqJ8s82WN9Bn7FLCcAx/PHEetQ1MTxTrpZlBBiX0eb2hSSv?=
 =?us-ascii?Q?g4/VW03rNiyeBmmUcJByhKMJKkQW8368+iKf92ecFkIql4nyAtlRsDSlOF5e?=
 =?us-ascii?Q?AGCk3oL+38G8OvC1AeyvvWmRKohabhSWMsgzEtgD62EXkZFBUBQylnSmCu6r?=
 =?us-ascii?Q?pswowz8MTiBmjGYzljnrNt7QLDV22zKeUszthOy/PABYBdARnum14TqTkFm+?=
 =?us-ascii?Q?IE0sBQrXjP9JMX+6H2L3WiHYGZxIb8MZ3pjo6edY8pl8lncXi0u/v+FEFb8s?=
 =?us-ascii?Q?UzIRvAfwFy4AALolrBADyOcZb1H1Tv8+SxiKJOEzlzHsFFC8C8qxhi+wdFcc?=
 =?us-ascii?Q?1++4TklRkBmtCx2l20ei/+85TczxrSW1nEaVWm+W47kktFyRJCP0Z1rUR1ry?=
 =?us-ascii?Q?kak/JHRH27vfhTkQW7mphxwJoPgFAttVOcvC1UTZs3IflqquUJCj/1bVCqYw?=
 =?us-ascii?Q?XIKI3ZjvT3YF89WcObBnUWM6/w6VkY0YcptNVzTdenaldpYevld6F9gmhJfD?=
 =?us-ascii?Q?YMr92fJcParXwm2sMVAYiOeOIchsXxqjC6U2b7d6SPMXdbb1W8mZsAx5uDus?=
 =?us-ascii?Q?jCB6PkFwMe8kwFKe7cfijOh2NbxZf32wOQOc0Kg2ZUQjoES0tPajF6Y9SuYr?=
 =?us-ascii?Q?1q2NRZeS32gPFv3xWAcfXSzbGWyeRkaPnwMsHsXbVfwu4zIpzULh8S/U3hWa?=
 =?us-ascii?Q?u7lUkFFpk/XKst5f9AdqGKn07zxf9AdiOrzHPdQE3e2sznjRkrJ0yGJLq1fN?=
 =?us-ascii?Q?EBQ8DaSFZGM6qC337vfYyVzWD0ybRkf1tWM9VZWluMPM8NSagKXm5pjwF59g?=
 =?us-ascii?Q?shLuNzlGHZ2bFiV7ARZC7q/wZ2fXAI8mLf/5KiEx4LVPGA2knYo6gQAUKDUU?=
 =?us-ascii?Q?i2cMd8cJitdjnNE5AnND/VrR35bI7aCcIullLRhZP0gy8IBr/fjlTPh3HY3v?=
 =?us-ascii?Q?aPdpEQeceo3/Wg6di1Tf5B8RuFQY3/XU3IA2UqdSW74kqzvU03il0NxAcSco?=
 =?us-ascii?Q?8fxFV6C4Qm1NGcJSHt0uhBXx5I+LWJBp1WU6tVRxCydnmEtQE5KFCjLqDjOl?=
 =?us-ascii?Q?3sYCi3NyMKzaEI2MFRhipdd8NyrwqZfbK0gnB5JC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1347721-3062-4c1d-0b1f-08dc3d2933c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:30:35.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox3tFmJ9M/ygBHm7d8sGGIe33t8g4PoI/9sIH+SlgArscWUZ3FOrMxKthxRo/lmYqifnZriUqv1gbtY2eLtsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

On Tue, Mar 05, 2024 at 08:37:19AM -0600, Rob Herring wrote:
> On Mon, Mar 04, 2024 at 02:08:41PM -0500, Frank Li wrote:
> > On Mon, Mar 04, 2024 at 12:20:49PM -0600, Rob Herring wrote:
> > > On Fri, Mar 01, 2024 at 11:27:41AM -0500, Frank Li wrote:
> > > > Add snps,dw-pcie-ep.yaml.
> > > > 
> > > > Remove context that exist in snps,dw-pcie-ep.yaml.
> > > > 
> > > > Add an example for pcie-ep.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
> > > >  1 file changed, 29 insertions(+), 25 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > > index cf517e4e46a33..07965683beece 100644
> > > > --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > > > @@ -10,8 +10,7 @@ maintainers:
> > > >    - Frank Li <Frank.Li@nxp.com>
> > > >  
> > > >  description:
> > > > -  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > > > -  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > > > +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
> > > >  
> > > >    This controller derives its clocks from the Reset Configuration Word (RCW)
> > > >    which is used to describe the PLL settings at the time of chip-reset.
> > > > @@ -35,31 +34,18 @@ properties:
> > > >        - const: fsl,ls-pcie-ep
> > > >  
> > > >    reg:
> > > > -    description: base addresses and lengths of the PCIe controller register blocks.
> > > > +    maxItems: 2
> > > > +
> > > > +  reg-names:
> > > > +    maxItems: 2
> > > >  
> > > >    interrupts:
> > > > -    description: A list of interrupt outputs of the controller. Must contain an
> > > > -      entry for each entry in the interrupt-names property.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > >  
> > > >    interrupt-names:
> > > >      minItems: 1
> > > >      maxItems: 3
> > > > -    description: It could include the following entries.
> > > > -    items:
> > > > -      oneOf:
> > > > -        - description:
> > > > -            Used for interrupt line which reports AER events when
> > > > -            non MSI/MSI-X/INTx mode is used.
> > > > -          const: aer
> > > > -        - description:
> > > > -            Used for interrupt line which reports PME events when
> > > > -            non MSI/MSI-X/INTx mode is used.
> > > > -          const: pme
> > > > -        - description:
> > > > -            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > > > -            which has a single interrupt line for miscellaneous controller
> > > > -            events(could include AER and PME events).
> > > > -          const: intr
> > > >  
> > > >    fsl,pcie-scfg:
> > > >      $ref: /schemas/types.yaml#/definitions/phandle
> > > > @@ -68,10 +54,7 @@ properties:
> > > >        The second entry is the physical PCIe controller index starting from '0'.
> > > >        This is used to get SCFG PEXN registers
> > > >  
> > > > -  dma-coherent:
> > > > -    description: Indicates that the hardware IP block can ensure the coherency
> > > > -      of the data transferred from/to the IP block. This can avoid the software
> > > > -      cache flush/invalid actions, and improve the performance significantly
> > > > +  dma-coherent: true
> > > >  
> > > >    big-endian:
> > > >      $ref: /schemas/types.yaml#/definitions/flag
> > > > @@ -85,3 +68,24 @@ required:
> > > >    - reg
> > > >    - interrupt-names
> > > >  
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    soc {
> > > > +      #address-cells = <2>;
> > > > +      #size-cells = <2>;
> > > > +
> > > > +      pcie-ep@3400000 {
> > > > +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> > > > +        reg = <0x00 0x03400000 0x0 0x00100000
> > > > +              0x80 0x00000000 0x8 0x00000000>;
> > > > +        reg-names = "dbi", "addr_space";
> > > > +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> > > 
> > > PME or...
> > > 
> > > > +        interrupt-names = "app";
> > > 
> > > app? You seem to just be changing the names to make the example happy. 
> > > What do the dts files have? You need to make those pass.
> > 
> > It's on my plan.
> > 
> > First need change 'regs' to 'dbi'. 
> > 
> > https://lore.kernel.org/linux-pci/20240229194559.709182-1-Frank.Li@nxp.com/
> > 
> > After that, I can update all dts.
> 
> No! 
> 
> I'm saying you shouldn't be changing the dts files. That's an ABI 
> which you are likely breaking. You should adjust the binding so the dts 
> files pass. The exception is if you know the change is safe and not 
> going to break the ABI or the dts is just been wrong all along (e.g. 
> missing a compatible the OS doesn't rely on).

The problem is that I have not method to make dts check without warning.

If using snps,dw-pcie-ep.yaml/snps,dw-pcie.yaml, it always complain 'regs'
and 'pme'.

If update snps,dw-pcie-ep-.yaml/snps,dw-pcie.yaml, there are two name
'regs' and 'dbi' will be the same thing. it should be bad.

If don't included snps,dw-pcie-ep-.yaml/snps,dw-pcie.yaml, I have to
duplicate most parts, which already in these files.

If you have good method, let me know.

Frank

> 
> Rob

