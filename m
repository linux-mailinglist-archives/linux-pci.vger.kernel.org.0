Return-Path: <linux-pci+bounces-3832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301F85E144
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0B1F253E4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9580639;
	Wed, 21 Feb 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TayG6iuA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E7F7DB;
	Wed, 21 Feb 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529609; cv=fail; b=N8T1JioNbKdCVx0cjg9oVA7trdXPoTedCQ3NASBXTtPa49AnQVSeZMClQhBmpxlChufL8Er6DqPvQcczqGqqy2Lz+6jYLU1AjitHPmXvh7u/X8g0/0F914CkcqEhMn7QmQygPCSXYfMQX4FyKPDF7rOdZynGZX1YPWJ+wsbC0NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529609; c=relaxed/simple;
	bh=HNdZ8yKkmipkjppjTC2sBddxCjBR+g8bzr2EZTAjplw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xnp6I8MfuaN/d9kuANjOZzfXV9oM4m2maXZrC0xUzOsg1dLx0LEq9d8BeI2Ebl1tn0xCgK7lulNCwhpFnZVGS52D/eqPP2VtRJy0MtT6Ecz48Bw6z2/THYMaALXAEGW6Rtm2OsH2YUOMiWMUpImv12d9CNDX91cEUfbvNtOh3qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TayG6iuA; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Sy9Mv2G9BOGIDwikFIde3/LAlOMps39GZjDG4HDdmdKPWzHh/7q66JdylmF7zzC6u4QRmYEhMTU8tmg2w7BHaNdaNU3CoiOruwmMT1PCf6fmOWjaNw34ik5m2Me6BAgj6wSnBLAWoFy17M0+H1x0fw2X/v4ouYtsH3zHVOswQ3X1Au9mf/rsRHYSOcPwrv6eJdDW+yYVz/tnNFWIx9dsEqbYI1U9YE5r/VK0JQPK8S/gdtGmj4KS+MXZfKQI+dRT4MLnEEAulmQ9Ru9qRlzt6+g2R53hel2wE/j3Iqqpp6hJIpDtkcwN86L5i+GDMSPqinFJvxh3+XzM9hQ47OKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmfNpiqcUCnckaX3gpGwYeD+d25j6AJ/z4s2PBR0sGM=;
 b=gQhBi0KIvvmbNJIruh37JmGO6JsWbbs9u5nS8gx0BEOKAxjb/37t0txmN6kH+aPRcTIf9GqXG2/6r7Y/9mY8XzvZ2oRKePMYA+7B0cHuTaCyQByW/jK7dtqEapvFfAzAx9YuKjoOZeGizuVEgQCjP9qeyzf2fN8j+AGz5grnyfMBePrmKLhTk5iAIEO2NRp6jrWQaY4OWJXHW6ApOr1c8C8HTlwAKERoazIU83mLSEIcRuZfdsPATOSvB6fxDrjE7c7BuZXOVW8qQzEZgsL6JHjY8paF7f4NCFZZ17+/+od62gtVXfGNONNGWEvf4ZdIoz2i2oz44gNVlUL78ZFQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmfNpiqcUCnckaX3gpGwYeD+d25j6AJ/z4s2PBR0sGM=;
 b=TayG6iuABsGNlKOtAa1mMkRRmsSklCtpOA5qrSIx1H95SxQn9FHGtDZ7tzFdkzJnhStRVuZhb6KsxnCHjdqBwT2f3GtWmkc3LfP/Aj0Cv8Z2QF7eVpIDK4PmymueC/RWbN5MUkjYo+vQspbtkrJW5lcgTRHOejIb+pXbka/XZy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 15:33:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 15:33:21 +0000
Date: Wed, 21 Feb 2024 10:33:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: bhelgaas@google.com, cassel@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v11 07/14] dt-bindings: imx6q-pcie: Clean up
 irrationality clocks check
Message-ID: <ZdYXtmJgTQ63jq+C@lizhi-Precision-Tower-5810>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
 <20240220161924.3871774-8-Frank.Li@nxp.com>
 <ZdXVN17SogJG1RgZ@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdXVN17SogJG1RgZ@lpieralisi>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a721eb4-ee1f-44ad-ce5a-08dc32f26f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rh+Oa4e8Fv4S/OBXgCi5oO9DuaGnyDWyWnINKX7YVcH81aEUAgGVgN/gHIgqigpt1pF/yv3vRoBmJ15Ki3P1YqeJs1NnH0JzbXCB9djqyd/GjdLadcBFrSQqaqP9y6S2rfr3ISOuQkRMEo3OAh2HyVWydLZ9Ao2hXyhZDG/tQ+pPNBdNpc3iRraGa3DADD+10tB44hL2+uy6TqFXymAO896sEJ2t4Oz9hdHBCe4NPf1fzvWdbBRUJF8SWA5bu9xSgJgFth4IvymlCo8sKNL8oPHyItJY+Yjsgo5Up43lOsGSdwI5nTpVFjRcAB/oLxFLduUmFZLl4qTRPyb5kqU/gtao4K7RoeiRp34qR/lwPQZ+9xJhci9YE6WlSUzCtIyNRuoWNYCJnEQNLWxnuweqaERHYMxXpVqA3N4U3DoyyQd51ul532q4f204zf1eKeS4yjAwbKYUcVJ81QGnFFAfbWqPEcvH9wPMCOxHT23GFbyJ3TPdYdzBbKxAr2dFtPlSYI9vJ6OY+L2tQkFfoQH77/KCTUzMNXfdgChgON4G9TQBKPwt3PrzFmNqOH4BCHwAitWLwqWIjqSLeM4323KPf27Lju795gaNgXm4NvF7iCzDJ+sjfTk7/P3kXh9Dd3cg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01F6XAH0wvX7H5Y9Gewq3+845LDFenZ/A7ZVf3DLEEyXIxjFxRuKmaIZ7H8+?=
 =?us-ascii?Q?DGjbLMNfo4vh5LBUPTNucOxBIR2VWvatIDBntsB6uNnMFQQH5Lh5ed4o0gxc?=
 =?us-ascii?Q?7WESfR9fxE9cfv5AOYJ5n0uS6nJBYkW472oMgGTtd97HK9utg0TAwOOUpeW0?=
 =?us-ascii?Q?wKkbdAgQfR1aZUswAGSZ/sQNEP8LWJlijQeP8zxxKH2mj6WK67o7jSuhSQOg?=
 =?us-ascii?Q?itOuASXJta6cPtgm+CnJGYnUlwPm2zdyaONc5Y4Ea8lIXvYYDy5iiYr4Ef08?=
 =?us-ascii?Q?IVJEGiH7Dx8jdNg2DcIRwr6vtXzTnF4i56usDZJp5Wi1bS302ppm72WIBxdR?=
 =?us-ascii?Q?EMY6flds7MevQjW7aHaW+yG+vcmBpWPkPx+DAQ9QHnQWB5AAAFMsAhZCzdkr?=
 =?us-ascii?Q?meZuS2f7nYe4C75Ok6LDO0lyfIJF4c8A7Ldt4DxKIDAewBSdaTJ5XkdJSiYc?=
 =?us-ascii?Q?d66YPGh25+mwGq3UCzjPuPq8BhZSuyusc2nAx4r3HKDrvanF4Av9LExJyhpq?=
 =?us-ascii?Q?agP+5w38GCR1s0Grn5QD5B/ZKjB3POWVST1jx8CHDHftJjkchEIwZ1Q8ewLX?=
 =?us-ascii?Q?t6h/ZFYXgKRN7mBAh3GU1z2Q+t6Z2LX/I22Z/WG9JE1Z+hkVcGJr7XujjUVb?=
 =?us-ascii?Q?O+vSAYGwMgUoR+8Zv+Cd/z7SHGII7YiUSc3NJ1DCc7D0kouehooWmzaFwrBI?=
 =?us-ascii?Q?HaRtEkkC7D1Htt4cJwi7LknqBxwYNQL0Tobmt4rseYMXjaqkEjaFlcZmYpVB?=
 =?us-ascii?Q?DnGRANo9RxRZfNU//5shJQ8Sh42iK74Eks1hHqRrIhpk3qGU9vT9HbInLGu8?=
 =?us-ascii?Q?woXv3RPn75fPB10i2lru8q3tjzowsfgbJDkbJ0VktL2NhKGr8eEAmqXFF+73?=
 =?us-ascii?Q?9A1nEul60wSTCbZqmGV6RrUpxhdByRp6Ney5KSJg3ljayBbB20wWyvmMuzKc?=
 =?us-ascii?Q?PGlG3hYyRGYsPyQey6UcOjNp442hfapua09htjgNOH71Qykg8r2Wy1sv1OFh?=
 =?us-ascii?Q?fSpvzt17rfPZj8pIBoueB8Rs6rCmlhVbFfZi6F1pE/G+lBJK/qY9EfKUUn1I?=
 =?us-ascii?Q?nuyevQh2EG9XcEHVd35ysIGm9RuLVSSaon89YTDRuVZEzvgFlOu79rAnOPz7?=
 =?us-ascii?Q?tx8L2uTeXuuauwGk5W2sKG42uithcfb8KpS6dxnIkCQgVGtHxiXYzBUn1Wdq?=
 =?us-ascii?Q?cUDE8rHGfyaBMe0nmVO5DgAhclo/w6Y5IGmeBO79YrP7jWbdHVbmn+yg85NV?=
 =?us-ascii?Q?Pvrlig9jzOmydT6eR58C6+0LJRVFN788qTo7Ko09XZgwyMsTw4Ecxlas18SA?=
 =?us-ascii?Q?DPodIHona6pvOMKyYqyqN/xyrk7qoT5GrAXeogu3masOuDF0b2D86ulcfkA2?=
 =?us-ascii?Q?tiafiCRRswCRGynKy41gTUu7a4Dcve8WrUQbe2dP4DvvZuG5m9RUI7ETRyIW?=
 =?us-ascii?Q?CVDWu1/vL0MtFRbZJDFbU2FeBhbBBylvOyjq4URP0AEJ2qbW5N0vjPAWUSP/?=
 =?us-ascii?Q?1rmi/zC82h5Q0ZdVUiRzZXkSXBLc7d+Y4836C3+rzD62q86bVDtoUMcal6dT?=
 =?us-ascii?Q?IatKc9bbY7mkZjoeOBm6SugPeNJz+vl+grzcCLHF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a721eb4-ee1f-44ad-ce5a-08dc32f26f60
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:33:21.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzwDL/4CrUoRwaA7g9XC3oXqmMGWH6X3UpScno0xCI9zRHXt52KfLZ+7AvCy2c8yc9QCqKh+YG+ZXYMomWumQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

On Wed, Feb 21, 2024 at 11:49:27AM +0100, Lorenzo Pieralisi wrote:
> Irrationality ? I think you mean "duplicate" or "redundant" ?

I initially emphasized the negation logic code (*not*) below. I may have
used the wrong term.

I am okay simple said
"Clean up redundant clocks check"

Frank 

> 
> Lorenzo
> 
> On Tue, Feb 20, 2024 at 11:19:17AM -0500, Frank Li wrote:
> > The bindings referencing this file already define these constraints for
> > each of the variants, so the if not: then: is redundant.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v7 to v8
> >     - add Manivannan Sadhasiva's Ack tag
> >     Change from v6 to v7
> >     - rewrite git commit message by using simple words
> >     Change from v5 to v6
> >     - rewrite git commit message and explain why remove it safely.
> >     - Add Rob's Ack
> >     Change from v1 to v4
> >     - new patch at v4
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
> >  1 file changed, 16 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > index d91b639ae7ae7..0c50487a3866d 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
> > @@ -150,22 +150,6 @@ allOf:
> >              - {}
> >              - const: pcie_phy
> >              - const: pcie_aux
> > -  - if:
> > -      properties:
> > -        compatible:
> > -          not:
> > -            contains:
> > -              enum:
> > -                - fsl,imx6sx-pcie
> > -                - fsl,imx8mq-pcie
> > -                - fsl,imx6sx-pcie-ep
> > -                - fsl,imx8mq-pcie-ep
> > -    then:
> > -      properties:
> > -        clocks:
> > -          maxItems: 3
> > -        clock-names:
> > -          maxItems: 3
> >  
> >    - if:
> >        properties:
> > -- 
> > 2.34.1
> > 

