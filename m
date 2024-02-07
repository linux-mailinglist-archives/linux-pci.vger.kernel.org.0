Return-Path: <linux-pci+bounces-3216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205484D027
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BFE1F26BF2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A818286B;
	Wed,  7 Feb 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SW1Wg5LN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952282C6C;
	Wed,  7 Feb 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328174; cv=fail; b=uG4Ld7VAcIuy1N0w2jkjSrTOsImGkEGVuCY4oCi7E0V0or1Jmw4s5gLCBObwfwOqvXrUEm9vgKaTKjVTf7n8SwYioT2IzMWZcvQVgcvCu9caK/iiBXO9iL4oslYHhjbSCe0Y6xzAmE3TKwxZWRZlDUrJdjM8YGsrnd1nwMteOMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328174; c=relaxed/simple;
	bh=3oZP++KCdfj2gHycN1UzAQeoOrdejJpQ64fg09/xZLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ns2nc6HySyxfxclbkA6WS7ZkpjQxKMQzvIxtTPU2e0geJC9PA/Z/8/lvzflcv3SUpcIKb1lKde2QWEkmB+rfiU/oqplT9qomdarwn7l65qMthdONyQvNxnPBY99+CQbSpKIH6AXApMgEXPcqHuZZGKoBAt1mWOY9eDEwgmoSuGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SW1Wg5LN; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMr4hoG+/KTi9zkaAm9lnwqaCF2GE5MfSWKQUmS3Hi0YEALDp7ZP1VJCWjo25Z4Fn/TLJi+PHlHyz7e0lXu2pxflrYStp5W3Al6vw4krOos/3STDwjyxlsorfCl67i3Cdyh45Oi0UvZ3CSN+rKoS2lUYeGYr+Z6kDBg2L/NVqyBuPjt5zKUqJl6R3ozANuKTdDW1y1Q9tSWyrUlWW+Yfz+nN9mA0SkYlykgVO+ibVWF/lT7ziNeZXa+bnmV7xk7NRjWUyUBrUQp5pqIcVEqzt9feR9DccXRc0EJ4yjXCIHVt/+vPs/k3TZCMWum6mo03cH+brlw7slaZ4DVVfGpx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSSfMltVLACx8AfS+RkqCrRpOu4akAyCd1AZB+CqFY4=;
 b=U//1nCnBA/rBLi9lEm+dGLjTaWb30H8yEv+8qF2N78WU9PjVqj/78Z+ApUyS3OBQHmhK0DmjVJFAxpsBXouyiugXPprH4uLqE9ESEHKA6hXEvThLC4GX4t/2lKTTyWjbtpGeNxZMxE69CqRJhoYetqRn9WXS30d3Ys/hJWkHGkLyUu8AyBcw6TiNpAKBAUzdulpbByFaTYU2pjuPlMvx3yYLjsq2uivMAsHOKYJ+ZfdXoNPUW9ZkM/hyqWCA3V8mHl8t15Lf4JteqFRwln/JdebnDLZXdh39sMI4N8rjxK0TPwf9rEiEWIBs0LmXdzpurNDO4ygiM/ZMB7MMBPgPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSSfMltVLACx8AfS+RkqCrRpOu4akAyCd1AZB+CqFY4=;
 b=SW1Wg5LNpQAOk6FHcyjzyi/a7vl8Qd3NqPtYPPNetcm8uEZMqzHDhE/6dl4gVTUAXXUyv0intn5OUZ3rEYCX4gly8yrmirLR97ts+5Qmf1c9D7TLhcute9UclOuup+VihFziuxSTtTZzJS2pMACMWZ5c34S1JQfeLcakpi99FPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 17:49:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 17:49:27 +0000
Date: Wed, 7 Feb 2024 12:49:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <ZcPCn8q7viB/qcOH@lizhi-Precision-Tower-5810>
References: <20240207062403.304367-1-Frank.Li@nxp.com>
 <20240207-yoga-mobility-90a728f6342c@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-yoga-mobility-90a728f6342c@spud>
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: 540d6676-ea95-44c5-33ca-08dc280520c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2lmXNsxARyjLTdTxdBLP/aflbw+U3YoObD2w3ADxYF6B1qbAntuIlfjtX8eJhVaUsJFh/uVoc9tDyJTJ//B0DTX5ZphLTpj9J0SvjYTNy0xDg8e64it2AZ9gqROz47zKB0fLWhliy14MwBbHNqUsKZLAvhIanwSSj/GnvsOsvnnGC3ao5FKbbwmy6G78MBa2wJP1BeyUZLgn1CKBu5O0gHPxb1rLxNwS6YB7kX6LSG70K/CCiu687zpRn/eoEXzFXpnFIkveme3LaBqrAhmcamWBZ5TgAdjTJ8rn/QFiBJVL0/sav8Pt75fOnDQGHbs0mtUgXxNokKY5zwnhrQw2Op7LXixmCKgiqdO3/XlSBjLsM2STgwXzt9kfu402N8cyl3p5j0Yg0C0hBkB1r5k4YCSosnkIdwcmNENjXLzUtTExd1ymcaDI72lAR6AgpXDx3pJ7UhiLD1O6HBuEP9zPSXGJWRxd9pBSbSbtTq8BYvENaSV9LXRkh8K1RqQ2bmh79W9J3BXolM96YI/cCkzaN9cB4tJjlGeJ6vX2+UQ+ZE7nlHQ5IBco+pJ/WWpgIa+weZM2iUiFxstKotDPo61H587PtqEeDUiJoEqHBtrjU/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(5660300002)(8936002)(7416002)(83380400001)(38100700002)(966005)(478600001)(6486002)(6916009)(66556008)(316002)(26005)(54906003)(8676002)(66946007)(66476007)(4326008)(6506007)(52116002)(6666004)(9686003)(6512007)(33716001)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OWlGA7gJImtzVh5CVaYUxBHL/IxMsNwynSUgBZpsa9Xu567NCYyio5MR+qFu?=
 =?us-ascii?Q?L33viyuKUz3gbpSrqwPegf033WyKMEr1PYajXcDHShCq14zvqXGXKSXxvRsI?=
 =?us-ascii?Q?E+v4EqSm1ghPh1n7IHZd6mdCquRJ73afRvoY6ty1IN6RTDj2WxyBxTFyAmrV?=
 =?us-ascii?Q?d6u55lrNj4ZF1VAX/UfUPdCgn4ApphLgvEQXef5oesrUKJgbb0XcTL5o4Fo7?=
 =?us-ascii?Q?tV/nt6zeJ+MCnWO8oeV/Sc72CJwf4tJiJ4M3b3NJVqv7Xr0v8Lq5sBUbZWac?=
 =?us-ascii?Q?euFH+GrTa3L4N95gdIo/V92k3CPCNlAZDrSybmTBl+9KplE2dXgS8xEShwwL?=
 =?us-ascii?Q?MsTcG0zrJDF11LZUEDItz9OodOp9jguvtUTGfFRnGw8CpCsAQJ7HLDJpIBDH?=
 =?us-ascii?Q?bBiOsxTAwRKTpvA2JhtxPjFZPZGxHq35/lU8sucV0FEnUOUkVkgu2+wcEc/X?=
 =?us-ascii?Q?/G4RrMJ77x99l/u1NbaHYr7eFwpYYdzL2Pf7TmcnX4xllPZ26xtPsjOz4e+t?=
 =?us-ascii?Q?gTrFehREvfZO0B//2sofVqnkb+SQ1vIS+V+QThRfcpKpJAdK77tvsQEj+m8t?=
 =?us-ascii?Q?YT1tug8NLtGBy+hYbLhVaBhJTIIzob9oyBpD57umiKw82BUP1IOx3IQIrh2h?=
 =?us-ascii?Q?DZ5gahsxOnRnDRH2KcKp0Jhssfvgnf9TNAUeBQR+enwBogDP3p4mhNGLXpVI?=
 =?us-ascii?Q?CYY5qh8IcXHpWTwxehAzztPaht7njh9GMG2CRJXl02LjKIPyQ0Y29GzUSZEv?=
 =?us-ascii?Q?/cdZ5uRL79gnV5LmctLJeNSRUussia+hpKsJI60bZKzh4/on1I42v/aGqB0D?=
 =?us-ascii?Q?qaYXZ0yWKdEY2onpXYd6NM85nxA0WVBi64z+P0hUT4b/eKVD7Z24sUfC77Su?=
 =?us-ascii?Q?cq98o0+azHJIsIBH1GW2xP/b6umLAdKhgwNAfo0d+DGpaR7WXQmMTy/4Gs/T?=
 =?us-ascii?Q?3egyOjgCEgMpyq+s0YbHsUj553bMYyQo3Tu5q7zqBDO5ZwU4J7rNDD6eZK/J?=
 =?us-ascii?Q?7wHogI/KTeI60iopJDbT0wsqqY4fxs8tKRTvJjEW+IPwrxykqN/M5r3qy7ed?=
 =?us-ascii?Q?QGOVsOOYDLx87qUmBEpNcyCyel1u5pFVgP+GdGEU2w2wEoC3oaFBN8i9pCN4?=
 =?us-ascii?Q?ln/MGkduzV9+7zEaw4oye+yKjdY5Ju+8/ICByckVxD8OAujihPLHPMF+wRaT?=
 =?us-ascii?Q?95FMfTBzIistCUilm7tOTs/jNTYUdE7yShSNpmooQMJ6E6L/IMGkH8Sm1+Ci?=
 =?us-ascii?Q?ZQcixKHxrjJb/Z7Nw5p6lcHFVvslLX1DPXCMrP/0Al2QdZ0DMarXPOd205aE?=
 =?us-ascii?Q?LLqNmt99d57fJelI5SfJ3BucZL+PxHjmEI8b+JgG749zk+ahBqs2ZH5G35nn?=
 =?us-ascii?Q?jfmCu/jHRNFy1ecxEu5lnCgf5XTorQhHWM4wyicTupJe1Y+A3GWg1ET9Jjef?=
 =?us-ascii?Q?vyK45APNqEvZntYSGHrDmTSFussg/os9YQbw+3ZirOFDS5/I2V9KG6Pxz4hi?=
 =?us-ascii?Q?V8kxzUDRmI8TA9PkQy1CG1BDjxZjyP3IFQbXQfKwoK2V9YGFsXWkOlMUTIi1?=
 =?us-ascii?Q?jWZ0MCcWP9WIoxuTbC4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540d6676-ea95-44c5-33ca-08dc280520c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 17:49:27.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IrjX+AgWbloWVSKP8TDyuQYmeRULLmFgLZwWs8Ng1aJhg1DBxdtxukB2OUV1RhsAYvoBlWJQpJL+kJSxT4OOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

On Wed, Feb 07, 2024 at 05:17:55PM +0000, Conor Dooley wrote:
> Hey Frank,
> 
> On Wed, Feb 07, 2024 at 01:24:02AM -0500, Frank Li wrote:
> > Convert layerscape pcie bind document to yaml file.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  |  84 +++++++++
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 163 ++++++++++++++++++
> >  .../bindings/pci/layerscape-pci.txt           |  79 ---------
> >  3 files changed, 247 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > new file mode 100644
> > index 0000000000000..3b592c820eb4c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Layerscape PCIe controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |+
> 
> Are you sure that you need this chomping operator?
> 
> > +  This PCIe endpoint controller is based on the Synopsys DesignWare PCIe IP
> 
> > +  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
> 
> You shouldn't need this statement given you have the ref: below.
> 
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
> > +      - fsl,ls2088a-pcie-ep
> > +      - fsl,ls1088a-pcie-ep
> > +      - fsl,ls1046a-pcie-ep
> > +      - fsl,ls1028a-pcie-ep
> > +      - fsl,lx2160ar2-pcie-ep
> 
> Where did the fallback compatible go?

So far, no fallback compatible needed now. each devices already have its
compatible string.

> 
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: regs
> > +      - const: addr_space
> 
> The example uses "regs" and "config". Where did addr_space come from?

Example just show pcie-host part. Not show pcie-ep part.
pcie-ep part need 'addr_space'.

> 
> > +  fsl,pcie-scfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: A phandle to the SCFG device node. The second entry is the
> > +      physical PCIe controller index starting from '0'. This is used to get
> > +      SCFG PEXN registers.
> > +
> > +  dma-coherent:
> 
> dma-coherent: true
> 
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: Indicates that the hardware IP block can ensure the coherency
> > +      of the data transferred from/to the IP block. This can avoid the software
> > +      cache flush/invalid actions, and improve the performance significantly.
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> 
> This was not previously required, why is it required now?

Actually its needed. 

> 
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - device_type
> > +  - bus-range
> > +  - ranges
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls1028a-pcie-ep
> > +            - fsl,ls1046a-pcie-ep
> > +            - fsl,ls1088a-pcie-ep
> > +    then:
> > +      properties:
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> 
> Please define the interrupt properties at the top-level and constrain
> them on a per-device basis.
> 
> > +
> > +unevaluatedProperties: false
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > new file mode 100644
> > index 0000000000000..e3719da306f25
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > @@ -0,0 +1,163 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> Only brief comments here, as it most is the same comments as for the 
> > +
> > +title: Freescale Layerscape PCIe controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description: |+
> > +  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> > +  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> 
> Same two comments here as above.
> 
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
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: regs
> > +      - const: config
> > +
> > +  fsl,pcie-scfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: A phandle to the SCFG device node. The second entry is the
> > +      physical PCIe controller index starting from '0'. This is used to get
> > +      SCFG PEXN registers.
> > +
> > +  dma-coherent:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: Indicates that the hardware IP block can ensure the coherency
> > +      of the data transferred from/to the IP block. This can avoid the software
> > +      cache flush/invalid actions, and improve the performance significantly.
> 
> Same here.
> 
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +  msi-parent: true
> > +
> > +  iommu-map: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> 
> Same here.
> 
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - device_type
> > +  - bus-range
> > +  - ranges
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#interrupt-cells"
> > +  - interrupt-map-mask
> > +  - interrupt-map
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls1028a-pcie
> > +            - fsl,ls1046a-pcie
> > +            - fsl,ls1043a-pcie
> > +            - fsl,ls1012a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> > +            - const: aer
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls2080a-pcie
> > +            - fsl,ls2085a-pcie
> > +            - fsl,ls2088a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +        interrupt-names:
> > +          items:
> > +            - const: intr
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,ls1088a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +        interrupt-names:
> > +          items:
> > +            - const: aer
> 
> And same here.
> 
> Thanks,
> Conor.



