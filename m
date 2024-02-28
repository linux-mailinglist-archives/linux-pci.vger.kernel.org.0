Return-Path: <linux-pci+bounces-4192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E041486B4B6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89331C213DA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8D6EF08;
	Wed, 28 Feb 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="orDniIoc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1436EF05;
	Wed, 28 Feb 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137437; cv=fail; b=XDgeznTRcgbNKrwLeQYEIrO4C+DJGdSC9NQpf0ZltBNG036MguocfC7r3uOp2JJCl0Gml1vYBQyHOe4r0B33+INbQR+9ci0A+FnDjSTVlF8gac7QdEarM3wyNN7TSVGfwsOI7S7KYW8oIXRsPwY5yJg24VLkxncZYTRtecYciiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137437; c=relaxed/simple;
	bh=0GqMBITTH4zuqUOMxYCrZUHWh7zjAnA4tli4MBfa7XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Na4zjkdGEDZabfRwpjDuW/X4sZdRv9aWic7GB2EYn65foV7TzZy3f4Hj/xHOA6NVjQQNZ0I9A3Rtf5fwm60tcpVmADzdnLfBnGGl9Jbu0UT0Nb1Pna2jLjTvEdVHewgzn5xe3ikx9IQcaMMJquMhu8KdVrT7wzjjhuo8MdhtdDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=orDniIoc; arc=fail smtp.client-ip=40.107.247.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnDJSY0UQ7a3HzzHTtxV+sNtoj9WLqQG7+e5RhB7XRxrFXtyU1Zt4h5rvr29DukWNnkdbjZDYVf7VnxFGbVazqYZ8kBl4r3rAJe+JZfuYMvI57sTi/oG6rPJcUNOBf4q4lOF8i6tPh8LxvZGhqyBFrMCSkSs4gQAy60AdLcD4tZYIGTBnrozlsfgf6PQPdOuFsfoObPKn4wQPDiQgLs4GXNLindqqYCK9gn92tpQ8fI9zo/E3lBuVBAtuFobXs8C9ypQ0YYIig23hq/FlfcHCGzaMZVg9NVQ0itUrWoE3ZKnH+D2/GCr7CskXEZ7xBQKYO///GVXY4rCKhK5x/dMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+qInIB242KlBBE2mJLLkCiZuMQ3chf+GExhzT//T/g=;
 b=XB2vwfPNpST36Pe/7HwfKq6/JzxUA+vl/STkS6X9t0E/gZcA2bE1zTnVbhX6brQ/FqiulRfJlvR9UoXuSmfXSsovSZyiSwPq9NuYur3M9IGxmeVHA9083GxRlhflrrgP3TsRSJTu2Jmu6bVycL6aEfZpWnRkyfgjgmER4OGGCX6sUHmdduY150T0xp0JKx3tlYpoVNOVwNt8PxTfIz5SaosZKwVv2JSVhoOQGB0bnti4hQzM6pqzBcdD98pPVY5/wXQSZ8JLnh1VKAmbxxOsTFB9njmKO8CIKRNzEX5y8LOWSnZwclxAzCOs3KmdTBLgThY7IQHWEM4XCYPsPc4+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+qInIB242KlBBE2mJLLkCiZuMQ3chf+GExhzT//T/g=;
 b=orDniIocdrI9P3JM4o6uKP/dOig0yFjfNs+DzgDP5oNofvYGknaU0d3ggJ2nKCTaaBYV8Z7wwHwo6lyI4dYHmc9hzeP996smRGpq61B2Q6Id9lbQQzKfgdP+u1F1i38KGH7tK8hH1Ob+XfkHXzvZ32SCmKyVw6aK7PR43gxzFqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7174.eurprd04.prod.outlook.com (2603:10a6:20b:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 16:23:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 16:23:52 +0000
Date: Wed, 28 Feb 2024 11:23:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <Zd9eDgxx5BiFWYD8@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
 <20240214061412.GB4618@thinkpad>
 <20240228160346.GA4069607-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228160346.GA4069607-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:a03:338::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: a179b4c5-ec15-45d8-26b3-08dc3879a6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XbUouxvU6qZS+2lZ5TXmgv2MFMFEw59zUWG8dw+dGDB70MQucn44pr2MofM1nJbEnG0+N40qqlddAHAUnddPDcRy+m2LJjwbz5lEMiRtoMFQAP4mB2WMYVX+Nxbt5eVo3Hn8nnktDvad4Ile7l6dsGxoNloOPPwnBdrLOxdSw0eGHIHob77sgIbBumITyzPRVg6pWisGN+/R100m40nkW39t0s+Snhyw5hPo2zayblKEm7HZnWnLzCrMT5U9YTNcNCnLTNjU4vJ1A2llStqtNRvNGsK+VvlcYqdGeRftHQ0+g1D9IOemt+x6F93OQDzyGqvKFhheIoIo+u314K/YMTZqu9COJn1tWG/ntxBTpxz7W7pBCB0mGjkp2OuMcamnQqYbzTDebPKHMZIDzqg67/9Lok9aI6OhqxDFAKs7j9sxcr9Rt0NiWVKWb0fDLYL5csqAOB+mCrNXWBo7sSDYhIz+yKIgncBMYh4g+H8WkEo/UA26M2vM129+tM/d8GFj2I33ubKyQn1UWfiYhJ4NoUFU7VTFRVV2YL8A1oAffUA/LysicYOJkjNv0due7eNqhaJNwQhIGWZuoe/zmTy8TuXbkjM7ZFJOcK396DdfB0lI2byJHwgsQHjeccA+Q2xU/Z9pbYsKY4qcETH+Eoz/7EFESp8Z6mI9E8546GHRAQsxpXaACL6vPv6H0i/iZX+ZHI91MTFAlVA0FXXWzgdYUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xnJ14ZMZPreJfXVRfInqGwtUuOKgLrC0wXgctfXbI7QwH9rR8MF+iWfekDH3?=
 =?us-ascii?Q?c97hT+fO7PxgKX08H4UkQ29qThGCo4VarJk6eF6zvDc0nBtmmSF8cE8g3ULu?=
 =?us-ascii?Q?5umf+9JkdEESTi50YLEQtKk73CeAtKBo/OygkWxlz8h0nIHSPeUwulAgOBWC?=
 =?us-ascii?Q?GIkz2GXt7UONvuT2j5dNFNRP9FoXZ3fauaX4ENdmIDoj74yslU8RB/Lscnab?=
 =?us-ascii?Q?Qn722vmlhLRPZj8INv9f+MjFZqRdAqEFWXNu/LFQEkZ07D5T7KfUXKHp4ege?=
 =?us-ascii?Q?5qLpAwQ0VsQSJeKsvCWKGfutGTgyJ33My1ZBuMMtebbVdU8B0PJUXCiBr/CN?=
 =?us-ascii?Q?ir+Lfds2/rgIFBqOqXLefkBs62z0dVKyvZr+RE5G0G5sQIGirsrOzMrY4PN8?=
 =?us-ascii?Q?9O77jzpT5+z+yK6HX1goJQ4ZQefalGTOrN8AQN/jniKSKomIOBc//VK1XauX?=
 =?us-ascii?Q?W2hHYlbP+g5vDuVg8Jpl1Q5asQTpIepDbjHG/sxFSnz+FibYEAaz/T6hOQtr?=
 =?us-ascii?Q?MbG4y65sqxCKQYhMULLZfb24MGqi+nJ+sfGgJrMLKQEWahb9Mlo6QUoBqbeS?=
 =?us-ascii?Q?VXJq++7cs28titZ9C/6jskZ8dAARz5YKrgeGLnkP2eUedcJolRChm7jJ1iAs?=
 =?us-ascii?Q?7Ev2FppjG7D4HN4Xuy3Xgd6FlQaD8qFt/GT6AvN7sfTq4sfifZrIoF6rys8P?=
 =?us-ascii?Q?GnmVDwXV4bHJA60UsTtl+6CRf2j94+GPoXeCf5KCBMbwAdBsmq6U74g6fvlD?=
 =?us-ascii?Q?qnAP9DahNxi7EdopiFvgl4f3hZXpD2Al7SDjeHFIqB5+HDeTV/RZpy9smfYt?=
 =?us-ascii?Q?TSzAe5sw3ZcXTB7IrDFiYiqGyTVXMJWd0XaHbbJkEdWgI+64ZitVuUfE2+PQ?=
 =?us-ascii?Q?G/9frn5ah96/Gg3oNBOB3IF7opTBWrmG8ofQ0mA6htAZFgBhw247td7u5Xg/?=
 =?us-ascii?Q?JoXShe4HnM8oDzAudvmbkgg8E/ls3PFrQ7/04pP2Z8ZhYEcZBdqXXmPt4Av0?=
 =?us-ascii?Q?/ORXdXFpPaAHepGuGlo8r938bN/WmBZlLZflOGygN9FLrwEN43XezDroCptn?=
 =?us-ascii?Q?YMpjLGSp0craSq/9/kXsp/Fib4S1x1a9rtrwg5StGheI1S2/FVJQ4aQZEflY?=
 =?us-ascii?Q?PGl6aSAeq73+6SAv2sJOxgGkr0ymwU4wxk/Kev7/bwkUZeP6E9xhPIe+5o1l?=
 =?us-ascii?Q?MIlDzHKaas5dMCT4VzI8jiZx7D3lSv2B2ZmTVm4+39tMWwR/2lqBf44/8sUM?=
 =?us-ascii?Q?GBWCiAxP/Kyewlt8Y9xS+TRk9cO160SvUnJLFfVtoTNUiD0MVfxJoglUljw5?=
 =?us-ascii?Q?ux2WGXntVQIvo/sDsaOi8Eco+hg0r8nl2IcZDVYGXfqcZawLdl8ZPTqMgwim?=
 =?us-ascii?Q?TojPhVBNL4KJYIVzrc59A1glwKCxWxGO5ROebF0XRD3qzodpt4eZRJsprG2e?=
 =?us-ascii?Q?g8PfqazMPI4sA4csYyNgcEOUjdE3PHKFgBiSiLyik0/sK6PA1Li5a0O/myIJ?=
 =?us-ascii?Q?oz/PNNIiV112WeXjxCjPTHRBs8AuVC4VtRcaXtyNOns45zK8rc3G8nhmPa7r?=
 =?us-ascii?Q?h7G5NYATYlOsVkg6RAc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a179b4c5-ec15-45d8-26b3-08dc3879a6bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:23:52.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D22CQaLpO0xEbkWYeAcBxVzGL6Le3n5+evRgI2Ds9FvwrwkD/oWfWcXESnCnNyVYRycX7mubUha5voDZZY7NQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7174

On Wed, Feb 28, 2024 at 10:03:46AM -0600, Rob Herring wrote:
> On Wed, Feb 14, 2024 at 11:44:12AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> > > On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > > > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > > > ---
> > > > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > > > 
> > > > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > > > >            const: config
> > > > > > > > > > +        - description:
> > > > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > > > +          const: msg
> > > > > > > > > 
> > > > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > > > 
> > > > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > > > would have to be handled differently too.
> > > > > > > 
> > > > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > > > 
> > > > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > > > 
> > > > > > @rob:
> > > > > > 
> > > > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > > > detail direction?
> > > > > 
> > > > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > > > property:
> > > > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > > > 
> > > > > So basically Rob meant back then that
> > > > > either originally we should have defined a new reg-name like "atu-out"
> > > > > with the entire outbound iATU CPU-space specified and unpin the
> > > > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > > > or, well, stick to the chunking further. The later path was chosen
> > > > > after the patch with the "ecam" reg-name was accepted (see the link
> > > > > above).
> > > > > 
> > > > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > > > TLPs, etc are all application-specific features. Each of them is
> > > > > implemented based on a bit specific but basically the same outbound
> > > > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > > > of view it would have been enough to describe the entire outbound iATU
> > > > > CPU address space and then let the software do the space
> > > > > reconfiguration in runtime based on it' application needs.
> > > > 
> > > > There are "addr_space" in EP mode, which useful map out outbound iatu
> > > > region. We can reuse this name.
> > > > 
> > > > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > > > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > > > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > > > mem region. We can config each region size by module parameter or drvdata.
> > > > 
> > > > So we can deprecate 'config', even 'ranges'
> > > 
> > > Not sure I fully understand what you mean. In anyway the "config" reg
> > > name is highly utilized by the DW PCIe IP-core instances. We can't
> > > deprecate it that easily. At least the backwards compatibility must be
> > > preserved. Moreover "addr_space" is also just a single value reg which
> > > won't solve a problem with the disjoint DW PCIe outbound iATU memory
> > > regions.
> > > 
> > > The "ranges" property is a part of the DT specification.  The
> > > PCI-specific way of the property-based mapping is de-facto a standard
> > > too. So this can't be deprecated.
> > > 
> > > > 
> > > > > 
> > > > > * Rob, correct me if am wrong.
> > > > > 
> > > > > On the other hand it's possible to have more than one disjoint CPU
> > > > > address region handled by the outbound iATU (especially if there is no
> > > > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > > > in HW manual). Thus having a single reg-property might get to be
> > > > > inapplicable in some cases. Thinking about that got me to an idea.
> > > > > What about just extending the PCIe "ranges" property flags
> > > > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > > > use the flag to define a custom memory range for the TLP messages
> > > > > generation. At some point it can be also utilized for the config-space
> > > > > mapping. What do you think?
> > > > 
> > > 
> > > > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > > > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> > > 
> > > No. The lowest four bits aren't flags but the actual value. They are
> > > retrieved from the PCI-specific memory ranges mapping:
> > > https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> > > https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78
> > > Currently only first four out of _sixteen_ values have been defined so
> > > far. So we can freely use some of the free values for custom TLPs,
> > > etc. Note the config-space is already defined by the ranges property
> > > having the 0x0 space code (see the first link above), but it isn't
> > > currently supported by the PCI subsystem. So at least that option can
> > > be considered as a ready-to-implement replacement for the "config"
> > > reg-name.
> > > 
> > 
> > Agree. But still, the driver has to support both options: "config" reg name and
> > "ranges", since ammending the binding would be an ABI break.
> > 
> > > > 
> > > > Or we can use IORESOURCE_BITS (0xff)
> > > > 
> > > > /* PCI ROM control bits (IORESOURCE_BITS) */
> > > > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > > > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > > > 
> > > > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > > > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > > > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > > > 
> > > > we can add
> > > > 
> > > > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > > > 
> > > > I think previous method was more extendable. How do you think?
> > > 
> > > IMO extending the PCIe "ranges" property semantics looks more
> > > promising, more flexible and more portable across various PCIe
> > > controllers. But the most importantly is what Rob and Bjorn think
> > > about that, not me.
> > > 
> > 
> > IMO, using the "ranges" property to allocate arbitrary memory region should be
> > the way forward, since it has almost all the info needed by the drivers to
> > allocate the memory regions.
> > 
> > But for the sake of DT backwards compatiblity, we have to keep supporting the
> > existing reg entries (addr_space, et al.), because "ranges" is not a required
> > property for EP controllers.
> 
> I don't know that its worth the effort to carry both. Maybe if it is 
> useful on more than just DW host.
> 
> I believe we had config space in ranges at some point on some 
> binding and moved away from that. I forget the reasoning.

I can alloc a 64k windows from IORESOURCE_MEM windows to do 'msg' windows
in dwc host driver in v4.

But I think it is wonthful to discuss if we can extend of_map bits, add
more type beside CONFIG/IO/MEM/MEM64.

https://elinux.org/Device_Tree_Usage#PCI_Address_Translation

phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr

There are '000' before 'ss'.  If we use it as dwc private resource.

Frank

> 
> Rob

