Return-Path: <linux-pci+bounces-3743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2285ADD0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 22:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50C3283D8F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515A53E33;
	Mon, 19 Feb 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGK9bAoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236D54FAA;
	Mon, 19 Feb 2024 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378585; cv=fail; b=bAcNK9EyPdN5y4NSFjzh3We1FJ7vyxt8Xc+gnvF0YJ8mNShd6kyLm+3XY6Qafb8eoyYTOL8us3A4NJ0viTHmMN1x5u4ULfPx/C5qZO6cH+UKdhNZhnCQUG0sO+AJgo8AX31sY26p0kwN2pT93f5Z61S8SGiNZ8eg8g7c7i2AHB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378585; c=relaxed/simple;
	bh=m2ObC3uaVBRbcL8alZLcsAs28xV3N7KKy8ZU4vmW9iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=riYmqXJvdJ7bnG5PJXCg7+MXLnGa+wub/PuDCGNhcnLNNAyLCKFxOgSEpvqrUCFFu26P78PH1q6u8A+BX2CkRDdF0jgKdzdTIHttkCWwKQAq3juXCJb8ozKjX9d3LWPZUaX9uuMfEEz1YJ5Ok0qC4Z+9MQkXqSMR2H4ZwnWX2JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UGK9bAoX; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpdvbdz37Be61mL5yzB5lZtzQkQ4+UhIW4j6G3SatnJsyfYfujzpzUyqVGaDpgoRqB39OfGI5qo01snRb1RaaAqEUvrx1zR/1xin3uE78sT/rdU+U2UU/tuBNRqLTGC1gyb0IIz0Twd/MLDZ8ik67DM1nkjYt0TvDL3TBkl91kPU4Bt8bd6nJC4ds1GewpuCpJ+cF5AJIqLbXZYNui24WRCH7GoxQ5/Rez9WMGUXC+qtDHh3ba6kPegtCNbUYaI9ynMK1/EauvxOtu+jCwqPYnf6EErEnFiF1i7ni1yEGheRyX9FE0K01nVg23zNBhTAnam7fCWpMYmBKKAoieVF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olp4beZHlDh1XNngEu/CRmMdlG+1XLSEFOKmQbHD5co=;
 b=W8TYJIsw6oksSdEp8xmvE/4s5htrUX2ppcK5rc7dGDaRciZz+TxkfZbFF4kQts8l4SUDZ9ofZT7tXwwiB+60e85Z8iJDS/Mj35jm1qJ2Sdzo37BOE6ApLnEO6uH3Up1+z4SDGYvjldhFeR6kV7QTL8ggPxZzRnyyetE6zKluPFMB9fKPsknQTNuxJlfb0KqXFgFxSh1IKukwu+mLNfJVIFeWpMYpwHyVgf/4cesdOoNXfChyyjN6yG5sNkKa5Jv+EmRy8RWYLd4jjqE8IW0HmXXuLDOVptmf5NMiOpS91vWiamBBH6lr2Ntxf8VQqvgqym1FbhNoydLTbvxl7DNuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olp4beZHlDh1XNngEu/CRmMdlG+1XLSEFOKmQbHD5co=;
 b=UGK9bAoX7LuHJxmWac/lCnoGy1ALFnDlMfYomI4jj55tiXhcyRxRmNCgUHGDQOEGzXy//TDKPvL4rLeHSP4VeR90ZZQtiQBst6RN+u3DPBwLOrHyU4JSFp7PX/jcgsVTA29uOobS0wmgDLqPf3SsbWV2hJGjMgbY+vmRWqF8tAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 21:36:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:36:17 +0000
Date: Mon, 19 Feb 2024 16:36:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <ZdPJys6OWGewNgX4@lizhi-Precision-Tower-5810>
References: <20240214194145.2669744-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214194145.2669744-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9ceff7-87ef-4045-f521-08dc3192ce15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bZ3VJgOkFe1OT9ez4P/sHm/Pu59IU8RvPLRyuxqd5GfCrrZSkOa9sLuCy8fxdE66H/EORKlpisVK1st7UXGIl/bF5JuAvqNMWdlcJ3K6YBXVRKeqCBy5hWBdXS0FOQOPxJ8KUfZYTqqqkSsfYt9M0A4sqFtmxZWumDYNqB2IQU/xoPn3LRAsj1ZbWh41MMZHrnYZxg/HJSSZn+uWvCi2iLbA4k+l8x+1OIVLe6BVtj2lV9mq9u6Dt1Tm1vwG3Emrfe+Tp4oMOeUcvogotd5SCDWnAMZqGKUFLzi28GC2KdHcWZaYaEc0R9TCZiBZ0Ynjj90ZFRQmeH3kVDSqGVyBSb1Kezd2vrEc6b8ESAwmrEl8GltZx2O2oQ70aBraGkshwQPpb+qBPmN00IpI7bF+AlgeFxlHEq4dLJsYVa14pNzaOMebe6bROBPKah1sZTdA1lcjtBOxVvNGNuJupyKc+wxv9yeYUeI8nECQCN95Gozkq0uQvgi9UN3UWM9iYMWUwWHytcFtzVQ+mT42azGVWV6TOKDRT7rZgzU2rjCCk4eSrRvX3pN1oZl19T78sosS5mPQlDjxBOUXCGzVp4OZKUMGqMY9RSquh5OIpmgm4mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Aoljys9jPnpUtsfyRZ/yvoJD+jQIQPS61TmLN1H+SHUEWbRG61+LxETdpJn?=
 =?us-ascii?Q?W0nzsbFxgSGzaKNickFV9NWU5ZqZotPrHArVZiaBBfhFUtZ4iQZUZUwlNSXS?=
 =?us-ascii?Q?A0ORIemxQpVL76LmeyrVGEK3A7kxWe4Hde/hSnZ49D/qUeZ5mEdABb8PBnOG?=
 =?us-ascii?Q?msjrMHfvge9hPELdtmnPCIv/I+bMlprmt1UektW0DmXmoYqZuZWftMXqT3Zw?=
 =?us-ascii?Q?2mnnn27aubCLTquJFKMtMxu6gvb885MLZU7MdGfrnIU6lWa9gpBGI/KRL637?=
 =?us-ascii?Q?HJn5NpGYuDcPlqNqD+E4vgh3uSsAMM2t3qHLN2wAR9YAET7ew4+sdieoMxyF?=
 =?us-ascii?Q?bqAySwd0i/V3rcUFo5oL0/ErjGCIWlOHbdUz/uzkbX3WnLqXS73uFISUtHXM?=
 =?us-ascii?Q?WqmZcisSf1oGg8jUTQWZpLAkV1+/2UrpQNYW2G8vV9TULmnt/EWLE3HAfgeK?=
 =?us-ascii?Q?C2p5I8I4rEaq8IIbXTodoo1tFOgeHImJ7bX9XrEe6YcF5nab0eguvpAgwj3v?=
 =?us-ascii?Q?xLRdeDlJifrKa+0Gsbv7p5QhYNs/8vGuB9p3yhXK2YGCN0NHAf0RO8ZrLjnb?=
 =?us-ascii?Q?5q5JOh6SCXJch7jQIq65QrK0o482d/nv2PWYWzkHhTP8w8rKFgQFCGGlmKeh?=
 =?us-ascii?Q?7S95vRKWALFzUSqXAHDgIoKm+y0jCB7cnnKqUESGkUvC86iF4atlzjoc6ZjO?=
 =?us-ascii?Q?xY3mZiBoKbJhE5aYIpt3mslHUUZiVilqSta9gEs0gfITkVbuypk9jBR5maCj?=
 =?us-ascii?Q?rEaFHMqg1E/7Ep5cQrdwQSxCtUYvJxYHdQLWA700uSvWB57qrRvz30TSZfAG?=
 =?us-ascii?Q?6vXLq8d5Rjv3a3Q1ePXIJusPyDq52l1IJCpY0X/y08JZlY4ybjTBBLhY1mz5?=
 =?us-ascii?Q?c7pcqmFfkhmiIDX47t8dyxf0b2YDUKkx3mGn92IIo9lnoRQge4HyTfmRf2K8?=
 =?us-ascii?Q?aAHxqorReJOwMW807FYdzU7UFhR3vZiDBF5sG64bDE106G+qwIWy1/Y4wUQg?=
 =?us-ascii?Q?VxW6nzV/pXQ6W9Zgv+8MSJggzTeIUGJmU917p1YLxr/G41x2+i9SZD6eMRJc?=
 =?us-ascii?Q?eB0BwFeJxnxbu+SzdwGEVh3pxhYIzE9pLygT8l0Mo8KtV2JXPXDrABN0+kCh?=
 =?us-ascii?Q?OjjF5hBNrVzHsiiffjeZyAOqtp3og5RM0RDsO9d0bZW86flQ29RLw08S/XdZ?=
 =?us-ascii?Q?FEQycJM30Ovvpe2TcUUfoO4ivALZJitcVrCHVTlCyLyawuOwtTbTOgNw2Z9s?=
 =?us-ascii?Q?NLr0DeJfq77mWyhgbP3w/GdHBcyQ9qlj/GQseNfEpdeJkxa9yNoNaaYw6OEH?=
 =?us-ascii?Q?9qk597/m2yOGRv1sFZh8KGx/4LDvNN0rGtKVuBM6yzbFdm2My0R/Jud5xD2H?=
 =?us-ascii?Q?/thbyC8gjqm01LHD0zYehtN9i8vPgDFNvItHlu0chDqpX7+y+HjwD7kMDXVG?=
 =?us-ascii?Q?LUNObAjZhLxRwzLApv2osF4ueBzAGjxOHayLDgtORVeKCPA/4goI63ZLnHVi?=
 =?us-ascii?Q?PLU/JplkZhC/EKVXYZM4fKhPPl6e5zhduUGfO0bizocEg21wDFtH0n6Vwcau?=
 =?us-ascii?Q?X4vxk0FGfaZnDRBqgXamaxyT3crWYtnoXoX6VxGk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9ceff7-87ef-4045-f521-08dc3192ce15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:36:17.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTYxVnjifcsQ6GhbmfZLlCWqEYfda1SXvRMQnwKx/pzbwKv3t2pUjDbctCYpwPvqwm3X7NxhQwCwjSjnFVg1jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

On Wed, Feb 14, 2024 at 02:41:44PM -0500, Frank Li wrote:
> Convert the layerscape-pci PCIe binding document to yaml format.
> 
> Additionally, changes for the layerscape-pci endpoint part:
> - Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
> fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
> - Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' is
> required by snps,dw-pcie-ep.
> - Add an example.
> 
> Changes for the layerscape-pci root complex part:
> - Add required property: 'reg-names', "#address-cells", "#size-cells",
> 'device_type', 'bus-range', 'ranges', "#interrupt-cells",
> 'interrupt-map-mask' and 'interrupt-map'.
> - Interrupt-names requirement split to each compatible string.
> - Add register name restrictions: 'reg' and 'config'. 'config' is required
> by snps,dw-pcie.

@conor
    Any comments about this one?

Frank

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     There are log discuss at v1. If I missed something, let me know.
>     
>     Change from v2 to v3
>     - update commit message, show change compare txt file
>     - add failback compatible fsl,ls-pcie-ep.
>     - add commit message about 'addr_space' and 'config'.
>     
>     Change from v1 to v2
>     - remove '|-'
>     - dma-coherent: true
>     - add interrupts and interrupt-names at before Allof
>     - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
>     drivers
>     - Add an example for pcie-ep
> 
>  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 110 +++++++++++
>  .../bindings/pci/fsl,layerscape-pcie.yaml     | 182 ++++++++++++++++++
>  .../bindings/pci/layerscape-pci.txt           |  79 --------
>  3 files changed, 292 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> new file mode 100644
> index 0000000000000..b384a0b2fe22e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe Endpoint(EP) controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This PCIe EP controller is based on the Synopsys DesignWare PCIe IP.
> +
> +  This controller derives its clocks from the Reset Configuration Word (RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'version'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller version
> +  information.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,ls2088a-pcie-ep
> +          - fsl,ls1088a-pcie-ep
> +          - fsl,ls1046a-pcie-ep
> +          - fsl,ls1028a-pcie-ep
> +          - fsl,lx2160ar2-pcie-ep
> +      - const: fsl,ls-pcie-ep
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: addr_space
> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to the SCFG device node. The second entry is the
> +      physical PCIe controller index starting from '0'. This is used to get
> +      SCFG PEXN registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
> +      this property.
> +
> +  dma-coherent: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - anyOf:
> +          - const: pme
> +          - const: aer
> +      - const: intr
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1028a-pcie-ep
> +            - fsl,ls1046a-pcie-ep
> +            - fsl,ls1088a-pcie-ep
> +    then:
> +      properties:
> +        interrupt-names:
> +          items:
> +            - const: pme
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie_ep1: pcie-ep@3400000 {
> +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> +        reg = <0x00 0x03400000 0x0 0x00100000
> +              0x80 0x00000000 0x8 0x00000000>;
> +        reg-names = "regs", "addr_space";
> +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> +        interrupt-names = "pme";
> +        num-ib-windows = <6>;
> +        num-ob-windows = <8>;
> +        status = "disabled";
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> new file mode 100644
> index 0000000000000..988929729580a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Layerscape PCIe Root Complex(RC) controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
> +
> +  This controller derives its clocks from the Reset Configuration Word (RCW)
> +  which is used to describe the PLL settings at the time of chip-reset.
> +
> +  Also as per the available Reference Manuals, there is no specific 'version'
> +  register available in the Freescale PCIe controller register set,
> +  which can allow determining the underlying DesignWare PCIe controller version
> +  information.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,ls1021a-pcie
> +      - fsl,ls2080a-pcie
> +      - fsl,ls2085a-pcie
> +      - fsl,ls2088a-pcie
> +      - fsl,ls1088a-pcie
> +      - fsl,ls1046a-pcie
> +      - fsl,ls1043a-pcie
> +      - fsl,ls1012a-pcie
> +      - fsl,ls1028a-pcie
> +      - fsl,lx2160a-pcie
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: regs
> +      - const: config
> +
> +  fsl,pcie-scfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle to the SCFG device node. The second entry is the
> +      physical PCIe controller index starting from '0'. This is used to get
> +      SCFG PEXN registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If the PEX_LUT and PF register block is in big-endian, specify
> +      this property.
> +
> +  dma-coherent: true
> +
> +  msi-parent: true
> +
> +  iommu-map: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - bus-range
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,lx2160a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          items:
> +            - const: pme
> +            - const: aer
> +            - const: intr
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1028a-pcie
> +            - fsl,ls1046a-pcie
> +            - fsl,ls1043a-pcie
> +            - fsl,ls1012a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          items:
> +            - const: pme
> +            - const: aer
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls2080a-pcie
> +            - fsl,ls2085a-pcie
> +            - fsl,ls2088a-pcie
> +            - fsl,ls1021a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names:
> +          items:
> +            - const: intr
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,ls1088a-pcie
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names:
> +          items:
> +            - const: aer
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie@3400000 {
> +        compatible = "fsl,ls1088a-pcie";
> +        reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> +            <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> +        reg-names = "regs", "config";
> +        interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +        interrupt-names = "aer";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        dma-coherent;
> +        device_type = "pci";
> +        bus-range = <0x0 0xff>;
> +        ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> +                 0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +        msi-parent = <&its>;
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> +        iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> deleted file mode 100644
> index ee8a4791a78b4..0000000000000
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -Freescale Layerscape PCIe controller
> -
> -This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> -
> -This controller derives its clocks from the Reset Configuration Word (RCW)
> -which is used to describe the PLL settings at the time of chip-reset.
> -
> -Also as per the available Reference Manuals, there is no specific 'version'
> -register available in the Freescale PCIe controller register set,
> -which can allow determining the underlying DesignWare PCIe controller version
> -information.
> -
> -Required properties:
> -- compatible: should contain the platform identifier such as:
> -  RC mode:
> -        "fsl,ls1021a-pcie"
> -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
> -        "fsl,ls2088a-pcie"
> -        "fsl,ls1088a-pcie"
> -        "fsl,ls1046a-pcie"
> -        "fsl,ls1043a-pcie"
> -        "fsl,ls1012a-pcie"
> -        "fsl,ls1028a-pcie"
> -  EP mode:
> -	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
> -	"fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep"
> -- reg: base addresses and lengths of the PCIe controller register blocks.
> -- interrupts: A list of interrupt outputs of the controller. Must contain an
> -  entry for each entry in the interrupt-names property.
> -- interrupt-names: It could include the following entries:
> -  "aer": Used for interrupt line which reports AER events when
> -	 non MSI/MSI-X/INTx mode is used
> -  "pme": Used for interrupt line which reports PME events when
> -	 non MSI/MSI-X/INTx mode is used
> -  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> -	  which has a single interrupt line for miscellaneous controller
> -	  events(could include AER and PME events).
> -- fsl,pcie-scfg: Must include two entries.
> -  The first entry must be a link to the SCFG device node
> -  The second entry is the physical PCIe controller index starting from '0'.
> -  This is used to get SCFG PEXN registers
> -- dma-coherent: Indicates that the hardware IP block can ensure the coherency
> -  of the data transferred from/to the IP block. This can avoid the software
> -  cache flush/invalid actions, and improve the performance significantly.
> -
> -Optional properties:
> -- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
> -  this property.
> -
> -Example:
> -
> -        pcie@3400000 {
> -                compatible = "fsl,ls1088a-pcie";
> -                reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> -                      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> -                reg-names = "regs", "config";
> -                interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> -                interrupt-names = "aer";
> -                #address-cells = <3>;
> -                #size-cells = <2>;
> -                device_type = "pci";
> -                dma-coherent;
> -                num-viewport = <256>;
> -                bus-range = <0x0 0xff>;
> -                ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> -                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> -                msi-parent = <&its>;
> -                #interrupt-cells = <1>;
> -                interrupt-map-mask = <0 0 0 7>;
> -                interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> -                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> -                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> -                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> -                iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> -        };
> -- 
> 2.34.1
> 

