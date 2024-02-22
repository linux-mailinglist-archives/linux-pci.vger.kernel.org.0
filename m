Return-Path: <linux-pci+bounces-3884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB026860293
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6127128E80C
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C63FE2C;
	Thu, 22 Feb 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kb8zyzul"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1014B827;
	Thu, 22 Feb 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629773; cv=fail; b=MmOYWlbudH/G/4AQhg1SU3j3IVibxFdbgnETwBrWHgdAPRD5/ExwCcHlLQfTWtR71Lsm1dJWSr7Ckbe+EinjJ58IpHshrU8hkaX65VOhlykST60Ci2AR4qcnOTZ24BRoUXUZWX8F99gW4Tr8BVb+3fyST/Ny/yIgYIipOtmhz7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629773; c=relaxed/simple;
	bh=5Ial0LvOBhqk063pM+4MoM0o/dJ2wY9FvWISP7XAqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JnHKIEPCbO4pSdM0XQVAPRUig2L2jjRmQseQDwhOrXweda4icZsYkWNyFIZGC6WkumoIJA4CwU2ZqcbLabGH/oXeDKsCRs9CK/+ROrjWlxsjYYSFenfuTBjY7InwKn44f7l34Ibdflu57fNMwf+k2A2dmSjrImQlS0oH0M8MEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kb8zyzul; arc=fail smtp.client-ip=40.107.15.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhKG1JLmeT81xwP+RR1vZDJh2hDBp9SectqYakWK8E699iW1tK7gGTUB2rFLQ3tbfivvIcni4PtXeQG9gvwDFuCRl+ZaJ2ES8jwXbUluYmKHtSy/P9GDvfDWmeU1K7TcNbNBHITpMuCiNW0Hxxd4S0kkoFYy/+//zbCq+VMRZlWAGkBar92qDM9xi8uuyYt1U2C/3fFfKAqAJKffFpH06wapwfRgRC0xICW6nBSy40bEJB3vl+GZjTujA1EwLgWBO5hSoQyxl7X+rCx9cUfWKclASI+QAUD//fa8UJudLEVNkKTRrPjUEmXr3r5FxbSf4wEdruhlOLurx+NDgPCjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy86+zEtUXAjfSDxIVGvWWPFHrMYg13P2B49/CbfXqs=;
 b=ZhcyYQU5vUxXcOrzP0dwOCdQWY85vgk+bJese2c7MuNJ+BfCcKJBW2N01OjFrtYuutshrDJ1HY3Fhcg+QovnMZueu/oPldbYRSOvzihy0zsAkjiG6eCHMfnh0DduzlOFupZjAxNZwAVFJ0S6SvVjdTXzYeFcO74dGovcPY5v3X2fMjy7mFwWq3AcKM4knCULzbNnjQSzh5OHKFV8PN6q8tN+RwFU4XIIVMJBFGnBh5zPlzIv5ga0mMIzD5x4rHdozo/Am2gW4OklxYvG+gDxLnE68EDIkvE8yBXqHioGkh21jRS75Qc+kzLHU66Cr0t3UQd3eKaomgb+DhMVYva8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy86+zEtUXAjfSDxIVGvWWPFHrMYg13P2B49/CbfXqs=;
 b=Kb8zyzulstSrOKnYQ/sb8E4AYzvKKkO3wdiWUHrtv6A6ZrAee10ytVzJzZa3jNVOeJ92r1pSVfcL2HGROhDk1+m6JwqO1u29Qc84NAwJoY/Xfupn60NrSR8Xic98K7GV1NJBlaO2mBFXKTNvaygB/0QRDO142Z+hWG7rpB4dvmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9807.eurprd04.prod.outlook.com (2603:10a6:102:384::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42; Thu, 22 Feb
 2024 19:22:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 19:22:47 +0000
Date: Thu, 22 Feb 2024 14:22:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 format
Message-ID: <Zdee/kY0IkXKwN6z@lizhi-Precision-Tower-5810>
References: <20240214194145.2669744-1-Frank.Li@nxp.com>
 <20240222183048.GA3652979-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222183048.GA3652979-robh@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d1974a-ee25-44cb-5cbb-08dc33dba718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+GzhVMJUU+CQj9jhSBeB+nQUAI7sbOMIcXfhXQ/dr/lnj1dv0VXZgE5qrMfEbzrF5iRAn1+4u11C/+NBOBtqEKIwcYX7kzNqY6T1QSbSiN9M1efCLPqicPd1Z9q6AtPPtPfNC5lZXF8hqhrIcP4LuKYjaWRsCnK1Qzt570KO71/f3K3gFUGfIj/SvkB6nIs5BXg0RoI8p3k5gNXKI/F40dkfnx/JkP2QKrLlCVyc59/AZMSYbz9Sc0HBi8/iW9bKW1hiRih01xClBoZlpn3VgOXcD+7pz/pqwOc5mLP9dgEVOoNm/JvO6SpGtZHzwc+4NisCt6GzuivQEHFFSZtEAqkBFG6gD7yXo23ZELDr8I7ucCyuYOdgGA1ejKkNJ0dSp6xR5uak9vh1o09JoXQJF81ltA8FApiMgbDdRY/240QvoSjliGvSqTMnWCLo6lygbo/kHmBBc1X/YLo6jnlXE6XmUs/OMADQ7KBp6aXMuVUCzHxdaMkVf4lX2VrUVzG51uptmqQMRqvIiwhWEkVtTIV+WfwuqCg1DmW9h0f/ejFQYztYkOMwBU1cBt5eGveKDalYj0OxiFBlsLAqFFDXkLJAHcKZ441ee3vRFSDXuwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pAX5oRmKcvzUu+JLKrRmHk8tI0jSLDLdZ3X3BchUGQxBNubeq5uxKtLNEvAu?=
 =?us-ascii?Q?3LqGJ+mLmwP/Z1pK30xu6HU8MlBo5bNWWbUNaCEY1DmT6f+BgTv1mlyPij4f?=
 =?us-ascii?Q?QAOw5R57kEl9uW5dAkb1FMKD5xv2CH8+i64rX5w4SnSZJe1H+EqXfSKh3uDL?=
 =?us-ascii?Q?cFtLSBbkUcXye/frkOKVdtBSjnhdNkkmqsvVLxDduZle+j7j3shDOBRJkXhh?=
 =?us-ascii?Q?4Kw5DhRlceeTCZpDhlocn1LEGHWVytV8GUzwvHDMDTslaCfASQxcdugcwui4?=
 =?us-ascii?Q?HnWoVDrvtKzYgaW9O9olnW3ROSIkV2uLCrMZ+4q7Z7VGOUpEREq6v/oDpKij?=
 =?us-ascii?Q?Qb8PRvKP14L6wB4BLjLyuTxmio2uVGqcqAjvtJiikcMfFUbKGPmruvyN9ezu?=
 =?us-ascii?Q?bVvCkpfQ3bcwqowmOdZu8DHYS+1HvIYHPCFUhbbtcn7+mgzltpPsjY+A7+h0?=
 =?us-ascii?Q?gdItuXMtoYiIuDiZR2PZMXfCCJZqot1PlDv3h67ColHWMvsg9lJVOyZz4bHn?=
 =?us-ascii?Q?XW0+elX/rje2Ukkj9zzYgpB55p+o3gLzJBzOjnTdeR/WWdLudZgM1pITGIBU?=
 =?us-ascii?Q?nHGzuYE9j3DWYzLSAkA4Ptrobl01thvkFLer52DfMB0uWWoQKC+dURVOUld7?=
 =?us-ascii?Q?Zl+BolTk9QZQHRAiG8dcnk+MxcOhJq94kNmLKOLS94xRiOdsVPEUdSuCWNbt?=
 =?us-ascii?Q?dODOYpMEKO0RxpCzC8SgGpsjFlNxLZlsqbI2b1X5Kfwx6Fw5oeHh4V8EjsPz?=
 =?us-ascii?Q?AXJx0Ql6kPwuQXyc0HE1dd8U6/oqyKTABxxGqdRjgY26HiINnMxzbfD7wnBf?=
 =?us-ascii?Q?8C4O/t9NWhHmjRp9um4NH59zd/U43v5gQHBHAd5+Xxcctxf8CxW1HQVcjo76?=
 =?us-ascii?Q?EIJ6xugZBCdFgx9Cj4il5VkQyto+wUZq4bB/XBHUQQLF9QKtLJUSGmYQqJnH?=
 =?us-ascii?Q?131Qqsjer/97fzqEcw9FLLJq0aZV9E1/lEE1hWXsODGR5LC1B/LFjwyFRQCH?=
 =?us-ascii?Q?a4IknmneYmqjJSBGkHp8vjqjoGhA1QPsqNdmI58AUaZaJZC5ssXCK4/sblUA?=
 =?us-ascii?Q?JjRQPrBa9FCSxjR7UG6qyfS/LrySdExrobgoP6dWOg6Zjhol0x5iVyGeJSVC?=
 =?us-ascii?Q?y5C9ox9kW6ljW1JMEiRsFo+Ji9hNJI643VNCfjMC9qVrTGfqHuJCjE0xrHO/?=
 =?us-ascii?Q?4kL24mUurCFMuUNiWoF6oBWI15rQe+3Oex3OmB468yYvy3j9k9gR3BGQ+yG4?=
 =?us-ascii?Q?+TJRJrkIRe3u8gpBGG4jY1lH3c5rJLxMRBzjD/eYJS65uSgSoxMkGPr/gcQQ?=
 =?us-ascii?Q?GSjS1nHyr8iT0Km6lfmX3Vm/eWWw0qJCb6EtxpAAV4ocGJpu9rNTNAiWZ+WW?=
 =?us-ascii?Q?G6hVrQCGi95g1jMBFhqmEcpeNNlT7rzUT/Hu87uJhflV2Cp1W7JvDm0ZWOmn?=
 =?us-ascii?Q?fsKaw6v+hH0OKYDfam+dUacdphBnDK1IG1FIZCPcm0Yxb16l5Vl6n3K9wqRz?=
 =?us-ascii?Q?DWct8UfKfa2Ns2SNyZRMNvNQV1bJB0mF63Mi9QOtBE0d51+tYC5dXZrTqFms?=
 =?us-ascii?Q?v7qI/b6ZyzQ6aj+dm/c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d1974a-ee25-44cb-5cbb-08dc33dba718
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:22:47.5674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM5R0Rg0b9pp0QgcOOrlP2wWHhXuiAchyX3nrYLygXjZrfFEOq8Sr/ZxTOyiuy/Ugkg7gRQIoCxSpdqpDNqsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9807

On Thu, Feb 22, 2024 at 12:30:48PM -0600, Rob Herring wrote:
> On Wed, Feb 14, 2024 at 02:41:44PM -0500, Frank Li wrote:
> > Convert the layerscape-pci PCIe binding document to yaml format.
> > 
> > Additionally, changes for the layerscape-pci endpoint part:
> > - Add interrupt name 'pme' restriction for fsl,ls1028a-pcie-ep,
> > fsl,ls1046a-pcie-ep, and fsl,ls1088a-pcie-ep.
> > - Add register name restrictions: 'reg' and 'addr_space'. 'addr_space' is
> > required by snps,dw-pcie-ep.
> > - Add an example.
> > 
> > Changes for the layerscape-pci root complex part:
> > - Add required property: 'reg-names', "#address-cells", "#size-cells",
> > 'device_type', 'bus-range', 'ranges', "#interrupt-cells",
> > 'interrupt-map-mask' and 'interrupt-map'.
> > - Interrupt-names requirement split to each compatible string.
> > - Add register name restrictions: 'reg' and 'config'. 'config' is required
> > by snps,dw-pcie.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     There are log discuss at v1. If I missed something, let me know.
> >     
> >     Change from v2 to v3
> >     - update commit message, show change compare txt file
> >     - add failback compatible fsl,ls-pcie-ep.
> >     - add commit message about 'addr_space' and 'config'.
> >     
> >     Change from v1 to v2
> >     - remove '|-'
> >     - dma-coherent: true
> >     - add interrupts and interrupt-names at before Allof
> >     - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
> >     drivers
> >     - Add an example for pcie-ep
> > 
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 110 +++++++++++
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 182 ++++++++++++++++++
> >  .../bindings/pci/layerscape-pci.txt           |  79 --------
> >  3 files changed, 292 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > new file mode 100644
> > index 0000000000000..b384a0b2fe22e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > @@ -0,0 +1,110 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale Layerscape PCIe Endpoint(EP) controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +description:
> > +  This PCIe EP controller is based on the Synopsys DesignWare PCIe IP.
> 
> Where's the reference to the DWC schema?

reg-names have not alignned with dwc schema yet because this driver
upstream early. ('reg' vs 'dbi')  If Add dwc schema, which will cause many
warning when do dtb check.

I plan update driver and this binding in future to add dwc schema. 

Is it okay? or I add ref dwc schama, and omit dtb_check warning now?

Frank

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
> > +    items:
> > +      - enum:
> > +          - fsl,ls2088a-pcie-ep
> > +          - fsl,ls1088a-pcie-ep
> > +          - fsl,ls1046a-pcie-ep
> > +          - fsl,ls1028a-pcie-ep
> > +          - fsl,lx2160ar2-pcie-ep
> > +      - const: fsl,ls-pcie-ep
> > +
> > +  reg:
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: regs
> > +      - const: addr_space
> > +
> > +  fsl,pcie-scfg:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: A phandle to the SCFG device node. The second entry is the
> > +      physical PCIe controller index starting from '0'. This is used to get
> > +      SCFG PEXN registers.
> > +
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +  dma-coherent: true
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    oneOf:
> > +      - anyOf:
> > +          - const: pme
> > +          - const: aer
> > +      - const: intr
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +
> > +allOf:
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
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pcie_ep1: pcie-ep@3400000 {
> > +        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
> > +        reg = <0x00 0x03400000 0x0 0x00100000
> > +              0x80 0x00000000 0x8 0x00000000>;
> > +        reg-names = "regs", "addr_space";
> > +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> > +        interrupt-names = "pme";
> 
> > +        num-ib-windows = <6>;
> > +        num-ob-windows = <8>;
> 
> Not documented and deprecated.
> 
> > +        status = "disabled";
> 
> Examples should be enabled.
> 
> > +      };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > new file mode 100644
> > index 0000000000000..988929729580a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > @@ -0,0 +1,182 @@
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
> > +  big-endian:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: If the PEX_LUT and PF register block is in big-endian, specify
> > +      this property.
> > +
> > +  dma-coherent: true
> > +
> > +  msi-parent: true
> > +
> > +  iommu-map: true
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - device_type
> > +  - bus-range
> 
> This should never be required unless you have some restriction in the 
> h/w. DWC generally doesn't.
> 
> > +  - ranges
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#interrupt-cells"
> > +  - interrupt-map-mask
> > +  - interrupt-map
> 
> The common PCI and DWC schemas already make most of these required, so 
> you don't need to here.
> 
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,lx2160a-pcie
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> > +        interrupt-names:
> > +          items:
> > +            - const: pme
> > +            - const: aer
> > +            - const: intr
> > +
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
> > +            - fsl,ls1021a-pcie
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
> > +
> > +unevaluatedProperties: false
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

