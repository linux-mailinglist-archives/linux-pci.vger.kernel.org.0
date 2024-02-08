Return-Path: <linux-pci+bounces-3248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B684E939
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D416284137
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99115381CE;
	Thu,  8 Feb 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EW9vRrlo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CE381C5;
	Thu,  8 Feb 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422392; cv=fail; b=O5WnFyeRDnUVwPOo5uagdWumXVHsio1P3N2p4xWNDpqynV+uLHpsUwwpNCBs004R2UTl1VLD32lkOuDZoE1Y0mU4E8Fx2FZw4rlKtWx2ubSYfh+ignfU6Us0sCt0YsSO+WwFth8rgY9iZX9cDoyFYzPuS78sZa8Y1NPvJtssblo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422392; c=relaxed/simple;
	bh=D4VmHs6ZfNrhYFVjwClRktXybw/oqMMCgNzWwI7r/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=da9TtvXce1adcQO5n6PaAyWKZR0RIIKBc2WOMBTa+ECvs0lZ2u4JyDjPV9o5/mj9iNTrpLv4scIN8pz7VGua0A3bvDK+8xnMcS8/DPzDrZAmWGVLu60o6eZiFrG0YZAdspOTRRRdLqIx0HIXUB95u6O8rJIIIBKGaqhw6XyTN4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EW9vRrlo; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkcX3Opy7y1oYKE5qyIWXNnePkc+rUDEBx3tTIAOoFCYfSrtVF1t2SwLKLcfU7Xi7/MQOGSH/+1LVXc0TqNpRBx+ZX6HUhc8Dw6PLKP+0P4VqBwelVyzunB390YhS2g6hN3r3HHgLRus5+N2i1AWM67U2ZzUKJ04FnMQnbZK4XOaNe6OAhM6h5OWG87mPlgor98VVc4gBhmV6I8fUhYg7oYdCtnk4bdLNp5HlXHnG3uiaVjJRuvd2MPy4ylO8MSdv8BbCxDZOt34Wn7twr2bPwDcfjNmO8/N/BoQNEbdG62RiIKJpFvkEMoMw5OukeSGsvF2+zIa9iSAnFSeu2hxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iexPuQ9kM0wsJA0zRGkAQMQ/5A7303mGWYlhkBAwgwk=;
 b=iFwAFDfCboEQeJ75ZWJuXM9O022W0by8fzL42VlbrrimbfI1S3evzQvuNh3tmGn5wRelNCtA771gOrQyAsTfEYHCKCwlDSX2qdSr2XchC/w1zW/KNQ0EX4HGdrd5ZkxpGdBKje4AJ5aKmy9QvUMtmMFmCrn4TENAhv+X/VKQkfQIjzJPBSswyie2sdUAV9S47Jincyi86VMlgwcrTFpgxcWt1wz6jGdzmvfD5His3O1Ezxv8mTCaqUf0USuwKUiHUK/b+ydJUuhnyRiesydoOzkKezvOdZyj1N6YBQGPW+vt1PK/wD4QYnckeeRcEIy+B4E9a10uXV/rS4GgRq6IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iexPuQ9kM0wsJA0zRGkAQMQ/5A7303mGWYlhkBAwgwk=;
 b=EW9vRrlo23lHnGZ9qpzaVE7CZgKB7A+xIM0Bszg+YiXQcQ78MQj8UaY097q1Js73hIEBQ4Rj0obvOBFvH/Sttogf0W+sSMOiUFbeGmUeZ7y+6VGYPm23Pr9XwP+kdy0m+XIJA3E2C3GhJq//NjVmskCptk/6VHzDQC6Hn/YIvec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 19:59:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 19:59:45 +0000
Date: Thu, 8 Feb 2024 14:59:37 -0500
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
Subject: Re: [PATCH v2 1/1] dt-bindings: pci: layerscape-pci: Convert to yaml
 file
Message-ID: <ZcUyqaxf52GivQnd@lizhi-Precision-Tower-5810>
References: <20240207231550.2663689-1-Frank.Li@nxp.com>
 <20240208-subfloor-polka-96bbbbc27fb0@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-subfloor-polka-96bbbbc27fb0@spud>
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4811c568-9042-45b9-05a3-08dc28e07f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6hH3l2pBxgC9k+MBHXsG9nX9rFlyogE9Y275KlsWM7UeejwiGseXrXjyDRSdP6QU4BMDpMwDshToXafRSfuz6+dXs3MDVHMJjRzVWr7CReHARs5VocAEF/dpIDkEqHyd8vpOtsfn8lSlWxnLeVtt/UqL9f0jaPf+GHhxgw8jNc2BlYdGBtNu8t++06KHa/1AKaYRDjm3ITf0ucovvp/Dpo1XY/PyT2RhUzRtCOeZhH5pbUdX5aq42MWAQHIB9hZlX+hJb6tkyzRqlpvdSWgEdTdMp97xwUijmU80EnWSTheIL+Y2DvhhIl8IPE7JA0RE21x7+yAaep9Yf6BPlLVQDKyspB/V8HsmuBAsBi+mjpT4q6F3FKeTzitxIf2t1qHuqweJXw23C/pU0C6lAhp1zpNNO8y5pZTXAxCd5CTmXIAZWEgYV4KEQq0lM8y2fLfwogtxO+vSW3/p5fn4+Adfx3gGVUN8OlNPWYKAMgEg+B3PnK/i02baCVFjO52nxxu2Ck7Zug352+8n6psGZcxs+9T4tqGOEYIjWZucSATXv5WqyUAqFD4WraRpzHCRQGR1VFXLj6KKgy//IBQB/Ebtk1pcRKetndd7rFF9WrEoY2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(5660300002)(7416002)(30864003)(41300700001)(33716001)(83380400001)(38100700002)(26005)(86362001)(6512007)(54906003)(8676002)(478600001)(52116002)(8936002)(6506007)(6666004)(66946007)(6486002)(6916009)(316002)(66556008)(966005)(66476007)(9686003)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhh/ITMHa+OKg4xmiie9j2cbUFVcpl52UckrycZYOpzchi8sXWOv/XmDPfEd?=
 =?us-ascii?Q?9n/VATcKBG+Y1WqteoU97tmL5Lq0x4rDMwx8XJL5gjOl5rYpB82MP/ZQrwII?=
 =?us-ascii?Q?ZsH6fMsLwu33SeFtVUP3gw6l/FILlHA88d43y/GaKxrZgHnZ2N15nBegE60q?=
 =?us-ascii?Q?Rylt2TYvGOVJx6VyLMiTGENR6wDTCPQ6EcS8lJ5kzYjpZtY384rdGYrw1BZQ?=
 =?us-ascii?Q?xNdWFz1e7tyZJOSRvZqTUUBUK36i2KBOJyXYBm7fkv6L0sPQ9fq3h8hLOzbz?=
 =?us-ascii?Q?NsV9gWofd8fG+B2KoimWphPKgtOoVzYf/nACYshmxscw+2GViLWR78On21qi?=
 =?us-ascii?Q?Cf9wGqha0XzkhyA5hsReSCeDS0D7DVEQQ6djTA3F9c/gFcqLWKcm1FMWwwUX?=
 =?us-ascii?Q?gy4k4VCJfazzF2UwX+Zv6KfRmqNDBVRSWm1mZAv0SM+ZzlCP9vS/Z51cpO6b?=
 =?us-ascii?Q?/3X5h9lZzftESyiBldI2oAnsArulGqbDjWRB9JHwBw3VaiP3RIrVvQDMfBjx?=
 =?us-ascii?Q?jP12BcW7kudgu/6s+OHart3OEimzKWbwrS+yHe6U38wSnE0Pp4ALUJm/9KHo?=
 =?us-ascii?Q?60BOltYyf/3tQq9FD8bcXCYzqSlOeFI8XyTeXvGBFFaquKYN8YQPCmCsEmHb?=
 =?us-ascii?Q?xUS0937b3lUozPKrJo7Ecak8FgMf7EXzTRVSwT38VM93vS4usbN7O/Kt4I/N?=
 =?us-ascii?Q?4aaJfBGe36Uu3Wm3M0tLlDLSzCt/MCBifejLJ0FleOXwISF131SB/Nis8dnr?=
 =?us-ascii?Q?n4rguhUnUIuSBOzR+AztdDRBol1DQXF0qaS5l9pVqv+0QV9UNMhTdSfZX8GJ?=
 =?us-ascii?Q?GTfe699xjyWjWDEpjVqJUqifkRsnKVUG2kecBJIVedg88DZLoQZFG+H1rn7v?=
 =?us-ascii?Q?MdVYlDhWPRafhWhxNKYHqUYhmn9Q92emFXQ6nG1/pFZtqq4g6knVG7EJzcpP?=
 =?us-ascii?Q?F3Q03CuETFZVP77dQyd2QuZco5BnACR9Fn1fn6o1m5iFw1UXHdbPOKfKktQ6?=
 =?us-ascii?Q?8sVHXMB04h3NipnSTKxth5wQmz1anK2PEcX1upKr0CbHPyEXK2ahrQ3GqEFu?=
 =?us-ascii?Q?57Bsf9hExGvMaHh8LQ7HPhioeIYSHvdmFmsf8ZJIg+c0mzBZdW7uRSfPwYsy?=
 =?us-ascii?Q?qw6gHm0bxqEmrL7CsPwhk7BHV72A2b3jox4jZ9FK+ZmNBfVa9RBrth+g64wo?=
 =?us-ascii?Q?6/fpsOjziHcp3B4R43MAsfpMw9lUbU0KpFdi/nSTpkGDO2MmLdVsW29/PFVn?=
 =?us-ascii?Q?6Kor7MzRRSYEyfuMUgD063gbDDupDAgTIEut7yitPrlHmD+0UCfSH0f5Qtpx?=
 =?us-ascii?Q?k7iErz2i9H0xPenD2uGmu2d2DNIM6w+GAkDHNIxe9Y29SfCL6DO/kgvlsNp4?=
 =?us-ascii?Q?S0bCtF/h1iYgTn7vBbYB1+G2JFuYBI342d7aneu2C0vFKMirVAlk+ilFSVHS?=
 =?us-ascii?Q?a7RszNe8ru+W7ee/CW37T2Ky/Za/kMHYPXgzslx/h0mjRUkbBquOz8LXNFrK?=
 =?us-ascii?Q?iUrRQYePO0d+YMXtVrjSekxnx9ERUg0zg9o8h3lhXFGNKmVGIvyyGU5whRSm?=
 =?us-ascii?Q?5uHirHyDh1cFtw5KPnf52tCpWkhQD7h1zOHQwgZY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4811c568-9042-45b9-05a3-08dc28e07f0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:59:45.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO/5kirmxN50SbV++XTn/RiuDJJsyhsZtylVmvMIJ/P+m8KS9bhCLOaw1x/7y/BU05sNd14xWyr/utGcJX0l2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

On Thu, Feb 08, 2024 at 07:26:15PM +0000, Conor Dooley wrote:
> On Wed, Feb 07, 2024 at 06:15:49PM -0500, Frank Li wrote:
> > Convert layerscape pcie bind document to yaml file.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Please don't send new versions before giving people a chance to finish
> the discussion on the existing ones. This is not the first time in the
> last few days I am asking you this. Nobody pays me to review DT
> bindings, so you'll have to accept that I will take some time to reply.

Usb-glitch patch
v1, I sent at Jan 19. 
v2, I sent at Jan 21.
v4, at Jan 24. 

Generally, I send patch quick because I accepted their suggestion. It will
be clear base on the new version. There are not big dissension need be
discussed. 

About this one, I think first one have bigger problem because just convert
txt to yaml file. Base on this version will be easy to discuss futher.

The samething for me, nobody pays me to work this patch, which is my extra
work.

Frank

> 
> Thanks,
> Conor.
> 
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     - remove '|-'
> >     - dma-coherent: true
> >     - add interrupts and interrupt-names at before Allof
> >     - remove ref to snps,pcie*.yaml, some reg-names are not aligned with in
> >     drivers
> >     - Add an example for pcie-ep
> > 
> >  .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 102 +++++++++++
> >  .../bindings/pci/fsl,layerscape-pcie.yaml     | 167 ++++++++++++++++++
> >  .../bindings/pci/layerscape-pci.txt           |  79 ---------
> >  3 files changed, 269 insertions(+), 79 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > new file mode 100644
> > index 0000000000000..399efa7364c93
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> > @@ -0,0 +1,102 @@
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
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
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
> > +        compatible = "fsl,ls1028a-pcie-ep";
> > +        reg = <0x00 0x03400000 0x0 0x00100000
> > +              0x80 0x00000000 0x8 0x00000000>;
> > +        reg-names = "regs", "addr_space";
> > +        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
> > +        interrupt-names = "pme";
> > +        num-ib-windows = <6>;
> > +        num-ob-windows = <8>;
> > +        status = "disabled";
> > +      };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > new file mode 100644
> > index 0000000000000..793986c5af7ff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
> > @@ -0,0 +1,167 @@
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
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
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
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > deleted file mode 100644
> > index ee8a4791a78b4..0000000000000
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ /dev/null
> > @@ -1,79 +0,0 @@
> > -Freescale Layerscape PCIe controller
> > -
> > -This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> > -and thus inherits all the common properties defined in snps,dw-pcie.yaml.
> > -
> > -This controller derives its clocks from the Reset Configuration Word (RCW)
> > -which is used to describe the PLL settings at the time of chip-reset.
> > -
> > -Also as per the available Reference Manuals, there is no specific 'version'
> > -register available in the Freescale PCIe controller register set,
> > -which can allow determining the underlying DesignWare PCIe controller version
> > -information.
> > -
> > -Required properties:
> > -- compatible: should contain the platform identifier such as:
> > -  RC mode:
> > -        "fsl,ls1021a-pcie"
> > -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
> > -        "fsl,ls2088a-pcie"
> > -        "fsl,ls1088a-pcie"
> > -        "fsl,ls1046a-pcie"
> > -        "fsl,ls1043a-pcie"
> > -        "fsl,ls1012a-pcie"
> > -        "fsl,ls1028a-pcie"
> > -  EP mode:
> > -	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
> > -	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
> > -	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
> > -	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
> > -	"fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep"
> > -- reg: base addresses and lengths of the PCIe controller register blocks.
> > -- interrupts: A list of interrupt outputs of the controller. Must contain an
> > -  entry for each entry in the interrupt-names property.
> > -- interrupt-names: It could include the following entries:
> > -  "aer": Used for interrupt line which reports AER events when
> > -	 non MSI/MSI-X/INTx mode is used
> > -  "pme": Used for interrupt line which reports PME events when
> > -	 non MSI/MSI-X/INTx mode is used
> > -  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
> > -	  which has a single interrupt line for miscellaneous controller
> > -	  events(could include AER and PME events).
> > -- fsl,pcie-scfg: Must include two entries.
> > -  The first entry must be a link to the SCFG device node
> > -  The second entry is the physical PCIe controller index starting from '0'.
> > -  This is used to get SCFG PEXN registers
> > -- dma-coherent: Indicates that the hardware IP block can ensure the coherency
> > -  of the data transferred from/to the IP block. This can avoid the software
> > -  cache flush/invalid actions, and improve the performance significantly.
> > -
> > -Optional properties:
> > -- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
> > -  this property.
> > -
> > -Example:
> > -
> > -        pcie@3400000 {
> > -                compatible = "fsl,ls1088a-pcie";
> > -                reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
> > -                      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
> > -                reg-names = "regs", "config";
> > -                interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> > -                interrupt-names = "aer";
> > -                #address-cells = <3>;
> > -                #size-cells = <2>;
> > -                device_type = "pci";
> > -                dma-coherent;
> > -                num-viewport = <256>;
> > -                bus-range = <0x0 0xff>;
> > -                ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
> > -                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> > -                msi-parent = <&its>;
> > -                #interrupt-cells = <1>;
> > -                interrupt-map-mask = <0 0 0 7>;
> > -                interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
> > -                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
> > -                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
> > -                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
> > -                iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> > -        };
> > -- 
> > 2.34.1
> > 



