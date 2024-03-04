Return-Path: <linux-pci+bounces-4459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACE4870886
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF482819CF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC8612F9;
	Mon,  4 Mar 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hV5i0GVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D360B94;
	Mon,  4 Mar 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574441; cv=fail; b=ehaoLneGsItqfdUmcd6Qh+F0+L1ugCPVpNOAd61Wr0hbYvYdWcdck9wWUMuL1ylPBWAdftx3MBBwg75lX8yEkyc++Cl9H6vkFkRQKk6sPNDenNUSpsnPp74IJPfeiPSmXbMqMAc6sEAe77c4cIEo9Fmxfw45ovk3SO8rYdpPcOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574441; c=relaxed/simple;
	bh=VU6GsskFtaxOE2tlkCxECjOzSzo975KAutjnUsfWL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9pLt9OqbgSjDOXr70KSB52JPqBs8cilfqlAdz/75TNCKRgYkFkmjPjL3kAWqny5kdZJtZI5yJePBuAAysooIqAMaDzlV8495WnDOCICIBDOD2mRmKRnyfJdiBTNhPZqIBqWLhjTIBxd9UNVLbOk7hyqWLBgbd8WJEbwkgTUp58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hV5i0GVD; arc=fail smtp.client-ip=40.107.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoVuUOZutaMmrnbiyCQUrvh0sdpMmTWmRs8S4mYQWAHjiNMAqp5XIdZkdqzsgAc1bv0wsg5h5VITlWjKnvN9gV6mvbaG8/9VpCWpqkHZydFS6gUloJoJKepwkdDbFJNUGQ7rFIQrjvsXBj+a/udYJMG3nBwQXJwu8+caJHFIhoCunbEwBRByBMMx+IpK75Fu3iYcVJRWAqED8IXDC1oOUlqhMZ/434XF9z/WvoldpE1RFqfahtRXnbmn9wrKyrNUUact0+6+OjRjTQ6Kd7zsDbOIbeV73NY1vzWV22hANht4YRAkKFNsqPL8YC6UwVeyioyFQgMe9U+xRlHb8YKMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8pAQNWw5w1vtItsj0SrV7n+INIjzfrCRVerYtuKIFE=;
 b=BT6uX7MW8dpcs2R9WKH+iHis/p3hcRx8kHlP/zHogMfwAMJI00aMr/2g1EQqqdeNTzCrm2y9B1v2eePC/DFzeaTV3ByMB85DOWgx9f515A3lGyiuXtg3fZWiCyfoGbim8lcCVAzSoHF3AsIOBawA8UbWfyU183VtOYmq2UnM2PiJJRLHQpMarqbsUSY4V5gOMVDRtrjDw9krGefJ/QF0EXFTAndN5r8szLrvBmA6cKVeMIXKza7MDcoispooNg8Tomd2e9dksWForjjeSdOqJzp0/9hehk4OuPzErJNg/HHbxNjgm8ry0lHKQ8rDaIlQCcs9jjD/oGg8gkLjb7vHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8pAQNWw5w1vtItsj0SrV7n+INIjzfrCRVerYtuKIFE=;
 b=hV5i0GVDRRKdUJsTe9nSOOJEyEo+/zKF0tpV3Er328abnTvZAMN/BTGvTBVK3zyy0yNoTj/S+IF9TTQxynVZorcVJJoOHefrBTwTgqvVxc5hpU1YnCm/qD3LceyF8s77OouP6c/vZ7cg6+2rw1pv+9NPmniOW/+HhwNUSMbkyFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7347.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Mon, 4 Mar
 2024 17:47:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 17:47:15 +0000
Date: Mon, 4 Mar 2024 12:47:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: conor@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, helgaas@kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <ZeYJHLpHb0UGv8S+@lizhi-Precision-Tower-5810>
References: <20240301162741.765524-1-Frank.Li@nxp.com>
 <20240301162741.765524-2-Frank.Li@nxp.com>
 <20240304173204.GA777171-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304173204.GA777171-robh@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b053a77-4a24-4814-1466-08dc3c732134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oOnpn7irosUNXjobL3GOUUseCFbuWBpSKD9IaV3vzROIIAMVrt57FS3aRyd4dXNy1735Ewb096qxI9mMICmmOKx3jW5p1Rhlf2EZw2Bm+Dbi7OLHU1NzdQtpMTY7UIPFUqX+jOwHQfce/Of5sF+l+4FaYuKJvEX5Pw2W1Ql8DpvzHmEvjBoeyJODG2DDRW0qF+tWVVg8My3CYBmeOy9e5659OQiwE8qVOcBe2xvkl7wbG5eprjzCzSfmjC17QrbHTWxEdILAu/xkxsFc5vD9c/0Pxki7zP+7lmFrzZ2+BmbhOU2pMmHSAWhLq+eyYWXWpjJffcL42a4oWdtFkZr2uDWlRQx9DW81hiz4hZDnKhxIVVcCvOfC0z+27PKyO6N+53zSk0YwT3hkxx4rvCLkN+ySW+qpisoa1AMlwAYTTI3u0XH78XnDiJzXGryiJiJHcJg17GMPev/0rK9HKAGfQy/hfbPCGB5Kv/JRE9LunOrAdtMyq8PeNXPfxEzDcPrHKf3HtrBUZHD65zCqCJC9FaKhC46mY86t2eFiXvqXMV0Cu3/cgDSnrlXgC/Z2EbkYIEU1UjFXCt+l816FuSGTnlPLkhYQXAR9OuJnvpnTQSHLPOCbw4yH7ISfu5KlBzDvWUHQPz8n1NFDAnC9rj/tKmXeg4NaQ7yHp55trCO3d08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vx9K4MvAgmYv7QUNAtJVl04b/CAKOBh09qx4iBNrowYAz6V2qjPGWyTw4pw/?=
 =?us-ascii?Q?10pppiU3w7CEWsA1APA1RVsCDMcl/9s2tlzq+YmzYOPKB0U7eSgrIjlhf4Ol?=
 =?us-ascii?Q?IM2vYYVlsqXau/MsGtFF33Nv2zjLPxuaMtmrN7vHDrEew5cs/3ZZ9DE/7V92?=
 =?us-ascii?Q?GrntlgmJov3SmeJ/91KVJJbLQ1qB/X7EvBVN2NSxQCpXfU8b4vYWFishxfAb?=
 =?us-ascii?Q?N0ug3Kr7dVfbCFMqbpNF1NE0bvoVbNaAXKMwo5epy+/VdJyeCGfvIai/LJJP?=
 =?us-ascii?Q?DIq0/smO6qlcO3eR84Admy/WhbK29SDKaCRR5YffrLI7+oy22jIDYxtTKY9g?=
 =?us-ascii?Q?o8qbXYa+mAAxmqer/omIL7QSsAQ4vY7XBQZQBBBtpA+8HzQAHkICKIws7ybB?=
 =?us-ascii?Q?tXVJoiy+x1k//zpRw2DvjPxwlgs5r5kIaVvSWGC/cWXL9lWVP9Pq8kbfOpCU?=
 =?us-ascii?Q?7qleeRHRA0aKqEitQ1QFadmv2V/OtR2q1739nU4GlzIsKNXp1qTYBIe8ZbhM?=
 =?us-ascii?Q?ivJyHn8qGT+F7asi244aU1MvkQkNoQT3ubsTkdERiBwgbLR4JwNTqC8VzIqg?=
 =?us-ascii?Q?koQ93bRYWrYAXqWcRMlxDVH2Hu+V0+R1yBpTMp4QfLliHn70pqqyAVMRW/c0?=
 =?us-ascii?Q?bxCgETTwxMJlrzAnK1bQ8UpOgAMuR8xu5lJFTTGLes8s+LUoaJNp3G/KASWY?=
 =?us-ascii?Q?MkqWzbinB1ZtAKrywTSe7UXpi4GPFFzSz9vbbr5DZdtQ0hL8Bm1m+nNNIhPu?=
 =?us-ascii?Q?uiC9virNQ0aBa3DGbBh32SYXWKySmf8wwQDksPUfS0nwQf3AbemrrERVxgoX?=
 =?us-ascii?Q?Iu+0fBrpl4UiBXdtDJ7tLO04DJDZBaeIESBlryHPP2daITlG2TaR6vwyQJfN?=
 =?us-ascii?Q?zcDB/oqu+vsqcMJZrzeGTqQXMx+/zGX2K/QsNe1bbVkjhMjjaVRnu7BSUH2p?=
 =?us-ascii?Q?LXOySow3JBtF8Yo7u+luPZt1fOuUbLwzU2AtdSep7SkfWhOl4G6PRESmKnaP?=
 =?us-ascii?Q?XojF4K+GuHSa+93r59e1atMy9VjpfReSG0p7z0VIzFPY5L9H0pqwMqn61GR1?=
 =?us-ascii?Q?f/KiLCIPPwX+kxEgF/AqHQpmyn0G++/zzp7Zihwhz+Yi7jV0W0fXdx0vUBMz?=
 =?us-ascii?Q?qvtjSsmDcYXwcDv3Rq94RWyoKNhEYG4PiqnCiWIDBCdjVnH7LFuf9YvKtQBT?=
 =?us-ascii?Q?sccRCdgU15I9q6in8Kwj0RtRoqYEA7yAC4BSeVVdVBIxGFR7HCCoet37eM7R?=
 =?us-ascii?Q?K8Ay9t4ZzlSIQmUYTYROtV/B7Ruuk5rIwBTtONXI8HMViG/PtJ+nDa0DQshK?=
 =?us-ascii?Q?kfFyR/CDb9+hFkJVyBmFtzof2q2L8GJ2GuvvalyWFKHRzik2qVx3PziYPVD7?=
 =?us-ascii?Q?aWtVIXntB4m3VU+HpJmJ2/WMJOgDWz5+ZKJ0pKl//RNVBQOlDjtXf0sq+3RP?=
 =?us-ascii?Q?EOhRjNniO9zzv6hsd3gS7rpbwOYRToR+h3rO6X/Dg24TnQBGlWNpGf8zETPi?=
 =?us-ascii?Q?37Ew3n46a5PS/PDb5PicIdF15fWuG3jHEgTtiLLxgK4Xncwu9yrM9Z27zkuI?=
 =?us-ascii?Q?YiAJVvNs0U7D7ZygYnvGIUXM9T+85NcCCaTG86GW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b053a77-4a24-4814-1466-08dc3c732134
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 17:47:15.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyzHGsDxbH3MMd6MHN7HyOcl4+yPp13SBz4jBWOaVo1RB8vhtVYuVraZpTnu06e2UtMOGyFzsXh3OwsLmzXb4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347

On Mon, Mar 04, 2024 at 11:32:04AM -0600, Rob Herring wrote:
> On Fri, Mar 01, 2024 at 11:27:39AM -0500, Frank Li wrote:
> > Split layerscape-pci.txt into two yaml files: fsl,layerscape-pcie-ep.yaml
> > and fsl,layerscape-pcie.yaml.
> > yaml files contain the same content as the original txt file.
> > 
> > Do below changes to pass dtb_binding check:
> > - Remove dma-coherent and fsl,pcie-scfg because not every SOC need it.
> 
> You mean 'remove from required' right? Because they are still here.
> 
> > - Set unevaluatedProperties to true in fsl,layerscape-pcie.yaml.
> 
> Sorry, but that's not acceptable either. You need the $ref's in this 
> patch.


Rob:

If I squash this 3 patches, it will match most your comments. And will back
to my previous v3's patches, 
https://lore.kernel.org/imx/20240214194145.2669744-1-Frank.Li@nxp.com/

Bjorn Helgaas suggest split to patches:
https://lore.kernel.org/imx/20240226210842.GA211190@bhelgaas/

First one will be equal to origial txt, then add change base on that.

I need a clear direction before I continue on this.

Frank

> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  87 +++++++++++++
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 121 ++++++++++++++++++
> >  .../bindings/pci/layerscape-pci.txt           |  79 ------------
> >  3 files changed, 208 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > new file mode 100644
> > index 0000000000000..cf517e4e46a33
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Layerscape PCIe Root Complex(RC) controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description:
> > +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > +
> > +  This controller derives its clocks from the Reset Configuration Word (RCW)
> > +  which is used to describe the PLL settings at the time of chip-reset.
> > +
> > +  Also as per the available Reference Manuals, there is no specific 'version'
> > +  register available in the Freescale PCIe controller register set,
> > +  which can allow determining the underlying DesignWare PCIe controller version
> > +  information.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,ls1028a-pcie-ep
> > +          - fsl,ls2046a-pcie-ep
> > +          - fsl,ls2088a-pcie-ep
> > +          - fsl,ls1046a-pcie-ep
> > +          - fsl,ls1043a-pcie-ep
> > +          - fsl,ls1012a-pcie-ep
> > +          - fsl,lx2160ar2-pcie-ep
> > +      - const: fsl,ls-pcie-ep
> > +
> > +  reg:
> > +    description: base addresses and lengths of the PCIe controller register blocks.
> 
> You need to define how many entries and what they are.
> 
> Missing 'reg-names'?
> 
> > +
> > +  interrupts:
> > +    description: A list of interrupt outputs of the controller. Must contain an
> > +      entry for each entry in the interrupt-names property.
> 
> You need to define how many entries and what they are.
> 
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: It could include the following entries.
> > +    items:
> > +      oneOf:
> > +        - description:
> > +            Used for interrupt line which reports AER events when
> > +            non MSI/MSI-X/INTx mode is used.
> > +          const: aer
> > +        - description:
> > +            Used for interrupt line which reports PME events when
> > +            non MSI/MSI-X/INTx mode is used.
> > +          const: pme
> > +        - description:
> > +            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > +            which has a single interrupt line for miscellaneous controller
> > +            events(could include AER and PME events).
> > +          const: intr
> 
> The way this works is the common schema defines all possible names. This 
> schema needs to define how many entries, which names you use, and what 
> is the order. So you need to add 'pme' and 'aer' to 
> snps,dw-pcie-ep.yaml. 
> 
> I imagine the order of entries is a mess here, and I don't expect 
> there's any new Layerscape platforms coming. So this binding can just 
> say:
> 
> minItems: 1
> maxItems: 3
> items:
>   enum: [ aer, pme, intr ]
> 
> > +
> > +  fsl,pcie-scfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Must include two entries.
> > +      The first entry must be a link to the SCFG device node
> > +      The second entry is the physical PCIe controller index starting from '0'.
> > +      This is used to get SCFG PEXN registers
> > +
> > +  dma-coherent:
> > +    description: Indicates that the hardware IP block can ensure the coherency
> > +      of the data transferred from/to the IP block. This can avoid the software
> > +      cache flush/invalid actions, and improve the performance significantly
> 
> Already listed in the common schema, so you can drop.
> 
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-names
> > +
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > new file mode 100644
> > index 0000000000000..3f2d058701d22
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Layerscape PCIe Root Complex(RC) controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description:
> > +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> > +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > +
> > +  This controller derives its clocks from the Reset Configuration Word (RCW)
> > +  which is used to describe the PLL settings at the time of chip-reset.
> > +
> > +  Also as per the available Reference Manuals, there is no specific 'version'
> > +  register available in the Freescale PCIe controller register set,
> > +  which can allow determining the underlying DesignWare PCIe controller version
> > +  information.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,ls1021a-pcie
> > +      - fsl,ls2080a-pcie
> > +      - fsl,ls2085a-pcie
> > +      - fsl,ls2088a-pcie
> > +      - fsl,ls1088a-pcie
> > +      - fsl,ls1046a-pcie
> > +      - fsl,ls1043a-pcie
> > +      - fsl,ls1012a-pcie
> > +      - fsl,ls1028a-pcie
> > +      - fsl,lx2160a-pcie
> > +
> > +  reg:
> > +    description: base addresses and lengths of the PCIe controller register blocks.
> 
> You need to define how many entries and what they are.
> 
> 
> > +
> > +  interrupts:
> > +    description: A list of interrupt outputs of the controller. Must contain an
> > +      entry for each entry in the interrupt-names property.
> 
> You need to define how many entries and what they are.
> 
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: It could include the following entries.
> > +    items:
> > +      oneOf:
> > +        - description:
> > +            Used for interrupt line which reports AER events when
> > +            non MSI/MSI-X/INTx mode is used.
> > +          const: aer
> > +        - description:
> > +            Used for interrupt line which reports PME events when
> > +            non MSI/MSI-X/INTx mode is used.
> > +          const: pme
> > +        - description:
> > +            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > +            which has a single interrupt line for miscellaneous controller
> > +            events(could include AER and PME events).
> > +          const: intr
> 
> Similar comment here, but the names are already defined in 
> snps,dw-pcie.yaml.
> 
> > +
> > +  fsl,pcie-scfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Must include two entries.
> > +      The first entry must be a link to the SCFG device node
> > +      The second entry is the physical PCIe controller index starting from '0'.
> > +      This is used to get SCFG PEXN registers
> > +
> > +  dma-coherent:
> > +    description: Indicates that the hardware IP block can ensure the coherency
> > +      of the data transferred from/to the IP block. This can avoid the software
> > +      cache flush/invalid actions, and improve the performance significantly
> 
> Drop
> 
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +unevaluatedProperties: true
> > +
> > +required:
> 
> > +  - compatible
> > +  - reg
> 
> Both required in common schema. Drop.
> 
> > +  - interrupt-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pcie@3400000 {
> > +        compatible = "fsl,ls1088a-pcie";
> > +        reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> > +            <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> > +        reg-names = "regs", "config";
> > +        interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> > +        interrupt-names = "aer";
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        dma-coherent;
> > +        device_type = "pci";
> > +        bus-range = <0x0 0xff>;
> > +        ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> > +                 0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > +        msi-parent = <&its>;
> > +        #interrupt-cells = <1>;
> > +        interrupt-map-mask = <0 0 0 7>;
> > +        interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> > +        iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> > +      };
> > +    };
> > +...

