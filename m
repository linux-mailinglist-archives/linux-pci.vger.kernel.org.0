Return-Path: <linux-pci+bounces-22683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F370A4A678
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781C3188912D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC21DF977;
	Fri, 28 Feb 2025 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ng780++i"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12771DF726;
	Fri, 28 Feb 2025 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783898; cv=fail; b=TrGOxc+Nc4BZyN+VgWS7Ft5pov0S2Zu8KCglPAjukrZqXyUqV//IOmKWOU8wMOzaCat0CgHkg6ONn49RM0EwaTIYvieV9jc7HWZQufX0DFiSCF1sRGU9sf93810VjMw5Du6smPNUfzEnFFrX8z39pBrG06p455pyMIIlUeODoXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783898; c=relaxed/simple;
	bh=5EuHTpfexiFoxuPAAxudkuYEVdjUCXZUHmx15LOTAv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AJgdNeEF35cLpTiHTkwxMmUqBfECxvDjpdlFlC+9QimiAFoGpW8m9cM+FYeg94+2djI2uSRwDJt5CQT1rAxqODdKAKeGY7KuGnK3fkISijE+n7NNzqhuO0rMpBQ8ded6/K9JHe4Rd+ZO9ce24MVweehKuP22zgR+EEOGqcUv5jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ng780++i; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0FAhw3kHq3I5HWDDBVT1Bdbnb+bZ1gKNDXPT3oEnnTlnvBK3kB0akXRFxAL3GB6YV88UPlkIrcgVN6UnDZtLSDC+LQMAIP8vs1Dx6FVIPMQ9XsB6Sj+NEUX7ttMv3PATvuQi1xwvTrcf8m1zyvEXZMYWIMUYTXx+2FiMl4Dbk0WKvatLRYNKT8q55bNOrYA9hdgjTkkAdu/yqfFEQq+kbV+B5jQBPpyrnD/t3LUfiCEl+BQI9BSFLeu2YZ47+WssWFEGjv9AItt2jdn37OyCS8FyY3kuovamVFzu0kaCB3eMcx/aNcAqx3y7p8ugevetDzddIwwf6p8mPSvcga6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH6cS7fUcwLHEcY+xOYJkTGB27PGPhsmoKJHxmcsTiU=;
 b=HyTgsioQTlD3TWUvdhOKUk/23UC9+zPUeS+e/A/5G86i+5x2jJ7B5+K0+If/KQ8Vl0G1hgMT5IHyYaxjXiIljjYyyvPPkFvnJwXIqWMiugcfaoQpi5qPLaqfGtHNJePKLcsS/TiC1jCHOsLIE/7ljXr1tN8W7OYRfKTndTdaBqar/k1NcnY1KCOW1BgA3VONNZthk4wKsxbG13QmYW3Q7hhRxzVDnuIo4HHveE7qXPyFR0gtezm/XRxOz1BYvaVZC80gbmpCqFIPuPcBZRkig3XUj1WhPSf0MvO5Yz7oBmNfq9aLJRWrg2aSxliuMNq7oyvneF7dRnBszNYLOqVS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH6cS7fUcwLHEcY+xOYJkTGB27PGPhsmoKJHxmcsTiU=;
 b=ng780++ifCwSvoxiVY0rsO8CZToAfDjsuuYaGzFStXBbarr7cAeIN0PpcfKDHwdPVoueSZjZYYUWXfliJ2ip4XAyo0XTr3vKnn8XbjrbrVwLgsuE7IKg74pAGrOEW7WRT7IazanD35piBy4SLff0XgmxcO7FpArPJjv5sQxPyP9NIhosTV6uis07nq11v/S8rUxCtUQjlZWFKRvegoowmo8qPGZqr6XXeMLkMZeXqsNLtjK5oFYtneNw6VLZEpBVVCV0wmsaIpRBMMubuI3CEEBjbz5vCcONt4SK0Dflmqw54BND9K5grf2BZTHCSP3z9nBngtg2yKwOuYv2Ng/iyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10899.eurprd04.prod.outlook.com (2603:10a6:150:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 23:04:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 23:04:52 +0000
Date: Fri, 28 Feb 2025 18:04:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes
Message-ID: <Z8JBDkslkViKSuc1@lizhi-Precision-Tower-5810>
References: <20250226024256.1678103-3-hongxing.zhu@nxp.com>
 <20250226220826.GA561554@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226220826.GA561554@bhelgaas>
X-ClientProxiedBy: SN4PR0501CA0028.namprd05.prod.outlook.com
 (2603:10b6:803:40::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10899:EE_
X-MS-Office365-Filtering-Correlation-Id: ac689ade-c6a5-4e8e-38a5-08dd584c4f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9OCRC1SAtj/M5F5sQisvLRffzQjsLUHZ9nFMH7nSTOP/+reEdPxtER7xUK72?=
 =?us-ascii?Q?h8y72/ik433mC8TGfPzzUOBSXA2RT9j12pLBfrYW1jZ7CUEFAre2q5gr70kN?=
 =?us-ascii?Q?reVkI/v21Fvla+/SORYR+tBoD0Z2pQVH79wfGzFx/Ko329A8wTsuwp6+/m8V?=
 =?us-ascii?Q?ybZK2VLLj8KazRpa5LUOgh8fyKQhmRv9xtPxp+6CrAUllOTXGHTXBWo5ZDK4?=
 =?us-ascii?Q?NipNVeqxcUfohaTZvTPZTdt1B4f3siigIH6mMYOXJ/x1gjA4aK/okHX1QU4h?=
 =?us-ascii?Q?BkeNEU0DiOPaFgqp0GTaQcfSk+mNGi4lGTwfGWGsfZ+R57fu8ewds6DPkCZF?=
 =?us-ascii?Q?tydnYYTDjwNWS5f4B6W8O+MtULBveJqAlSDS9+Jm0Hji24FneDmfSx3561gq?=
 =?us-ascii?Q?7bPBt8D1X1z1qzOu+LhrRWBTz34BIXUC8EzO72b3xkOnfFih67jfKbuBZj/6?=
 =?us-ascii?Q?wEQEXVhpNfzp3DLPXSxrl+ypNkhgxe3mro1Xggujryf0aUTbnrRNplDpRSXz?=
 =?us-ascii?Q?tpgfrs3AI2kuliUFG6Fq63GGLSnjaYhdSDeXVncOYXZSDR0D7fRyu6zATATj?=
 =?us-ascii?Q?Uj+wY3i+HIEt76gO4NV+nsAmeT1fQa/Lt+EeQ3zJjVtS/bCB6j0E6dWfKA/Y?=
 =?us-ascii?Q?59I0VH8uWwsEe8kIYMehgtCwINRiaeFwgW8gdiMGDm3mI8ON6S3kGYmGjbYC?=
 =?us-ascii?Q?gOgXNB0851DjT0N0M2XHRoQbRIjEwWkJlYzOFjNRzFxDTdc1pJ3HryQIY+ev?=
 =?us-ascii?Q?jcRoevENz6jhD1jhLhVoN/rePFWKv4zUnFS04iqTTtmAaCKraVJiaCUDMRRf?=
 =?us-ascii?Q?bp+ffWbDz0i7ATQp3YdoP3J8w3Iiu1zAzAf+0/1qXvH54/ot/C+C45VaSdUZ?=
 =?us-ascii?Q?ck/9nhSnDMnoAsQALhFGP3h54A773FrXL06KpyNeJJI4beOJewKK9QRghCiC?=
 =?us-ascii?Q?IsP/gKEttWZ0bJ0tv4YdVKha3YI/Rml6bkCI9gjxV/6qAaBFZkTs99p77ekK?=
 =?us-ascii?Q?SVviI2V4zBXIhNph3VBxgihSdD0haRMOj783/2OtjaX9psU6hvjHHE7TrFoH?=
 =?us-ascii?Q?qjlKyt8lKD5I6OhIckbub9Fmm0nb4tnGwuzAHW6FPCAeLHWlTIJowqpgoGBZ?=
 =?us-ascii?Q?BjA/b8N2DEgI98ZlQO6L89uVYrSS1VGeXQMOrYensYqDMG/V9UBLnQP7eFST?=
 =?us-ascii?Q?7QPIbrBE0tqv907XNAt1Yef7mu5smUY9eWIO3VVimMsYt1boPMYs7KxIH7/C?=
 =?us-ascii?Q?wncxsWXx/K1v1qxJuTcoWHQ804TzNiEqLYancAC3NbiMzggcoL1ocHfVNUif?=
 =?us-ascii?Q?145ZdVH9jEABxAeSYkObuyun+kcjm5L+fgQR13mrbhhkwqYYFFlT8tGJ7rDR?=
 =?us-ascii?Q?ugR8A3XDg8F3WAFjD+9bONVQDHgeAQhHuPG2rWF1kNfxJ2V6kydsbFP/4XMO?=
 =?us-ascii?Q?9YJrLBko4K2K6s3/iAMVPajvfCqtgRPf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q50h/PDm+gPp3BQUdh369xtwOcaXbOIJ6c+8Bi3rl2EvGy0UWtWbf6QXV1nr?=
 =?us-ascii?Q?OjFWPj7QghDjfmRvB1dDIVknhzfWCgs+BTFas9zTHITvy7PWNVdhrihj292T?=
 =?us-ascii?Q?z2BQLoSLNeq00LEMd9gDyuOVz8iRScl0JXzWfPjfLLkQEjH1iF/JX+rrm9qm?=
 =?us-ascii?Q?kFajtvmFdLg/57kYFLX57l5QPr5FaU32obtCgtO2cIBQ+EEcI9kal5Ls9Vfr?=
 =?us-ascii?Q?HJQ+/x5AsgcERR8aVXMvJ45J/8mcXUgU/xqLB+by0ONQvm1CsgyAL2AFvbIJ?=
 =?us-ascii?Q?dFBEANbri7ygd8gxhtxetq2OzdQpJUSArTNz2KM7/bgGhz+g8wDAguG+iasq?=
 =?us-ascii?Q?RH/hx5pEGmrKytPbHmWVRH1mb2WixPQLXnbDj35isKvv7prheGDJhCUlYUZH?=
 =?us-ascii?Q?W2Sfb8QNLeBTat9aiGeJ6nIFkUGRNHimLbhN7LTqCN6j0r9hxC7NglW0A4fk?=
 =?us-ascii?Q?AHNkoQuvafceq3KQWpQSPC2Z+WAC825zxFUCOSU84FEAV0bfdwVn/yC6MvGU?=
 =?us-ascii?Q?vB2VHxmREZgXJApjrkghfEhCp1i5A90ArzJiaNxoY3+NxEGguwbGX6WOo7mY?=
 =?us-ascii?Q?8VS4LUaH0C1/n9LQdfv98IAq52MUh5KGiMGFCyLvBa5aIhWUOX9eBbSeGdI+?=
 =?us-ascii?Q?wF3M5VuChF+lwxF5+PTthJZ8BMFKRPwRqFjnGWb5hTyUhYNavhmumiUiiZqn?=
 =?us-ascii?Q?regxIPFZJUOc5c34Lx0uadSaTLZU50ZuLpeOOX6iIrZOUdof+ITeaTzBqKYg?=
 =?us-ascii?Q?J+0enFRTPoin/uwfg/kZhj9BUajEaExxnPoRKELAXrS80aJ3NndaZG0ISik9?=
 =?us-ascii?Q?cqboT+xgM5gQARIpU6JbCYrjOffrfs5rbjT53lI8S848z0zJaoWcir1uZroD?=
 =?us-ascii?Q?8qc6n7MO1X95ILTpKjKnUuOYGPq0Op8a8tncq0HwjlqMdkO6RUbZAa14icvX?=
 =?us-ascii?Q?LkcDsnsQlVyUDlHb3L07wtMUMi1w8m6FvbXkWoiiIQWIsAz+7dp7jSAPX/Ll?=
 =?us-ascii?Q?hGFgF8YvcJuw8wzsjyUNh5Z0pqvzrVEllGLT0Hg7j6rRzBvpu56gsOoL9DfE?=
 =?us-ascii?Q?uvtDBiot4qAL0l6nLmAlPyCM54kb/aq2z56d6mmohSkad/wnICUyDah8m6kH?=
 =?us-ascii?Q?6muGC7la8i7co1/rAEQuDLNOzXsuR2mh+YqZeGyqFMOYSyeAMPEche8mrJ4F?=
 =?us-ascii?Q?VcJ4fshP2hyEYCCPs6Z3qWns39is/DYv13Lc1chmd2lMNDJhzkCGV/GCDa5/?=
 =?us-ascii?Q?SUKwHDQxZLpfMHk3owOPk86lv35QUgwcJ0bqJyKlp3+AR3ngYFuhVUzjT9qH?=
 =?us-ascii?Q?uDyceQrOloQhhve2LG3y7+zzAxS7tbIXfT91tJogvRyOTYu4RZ6ngo0pI87n?=
 =?us-ascii?Q?3ifVgDOoGefciC3174lCY+rvdLWs0LLq0tgeqCr+cp3N9hFNvIdRP6sNz4MO?=
 =?us-ascii?Q?UbiJ6pgtEO/2BYCzRbfzPQngkke6dLelViYVhh+FmL+00HAx4MjieSuU39Gk?=
 =?us-ascii?Q?BxLCEditOD2w+Yog65cS7RMnx2eubrx6XasEP3NPcdOBWQ5PMQWvK1kgezLO?=
 =?us-ascii?Q?U4uschZ0L4Mm9fihUNw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac689ade-c6a5-4e8e-38a5-08dd584c4f0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 23:04:52.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 649GJl9+oLpfOTurnPXbd3h1/Plto+2+TeKcoDymi7CaWhxuZ7SUroRJwp0bgP0QtYbpWhB8/EiW3o+IOwDEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10899

On Wed, Feb 26, 2025 at 04:08:26PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 26, 2025 at 10:42:56AM +0800, Richard Zhu wrote:
> > Use the domain number replace the hardcodes to uniquely identify
> > different controller on i.MX8MQ platforms. No function changes.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> >  drivers/pci/controller/dwc/pci-imx6.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 90ace941090f..ab9ebb783593 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -41,7 +41,6 @@
> >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
>
> Nice, thanks for getting rid of this!
>
> >  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
> >  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
> > @@ -1474,7 +1473,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	struct dw_pcie *pci;
> >  	struct imx_pcie *imx_pcie;
> >  	struct device_node *np;
> > -	struct resource *dbi_base;
> >  	struct device_node *node = dev->of_node;
> >  	int i, ret, req_cnt;
> >  	u16 val;
> > @@ -1515,10 +1513,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  			return PTR_ERR(imx_pcie->phy_base);
> >  	}
> >
> > -	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
> > -	if (IS_ERR(pci->dbi_base))
> > -		return PTR_ERR(pci->dbi_base);
> > -
> >  	/* Fetch GPIOs */
> >  	imx_pcie->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> >  	if (IS_ERR(imx_pcie->reset_gpiod))
> > @@ -1565,8 +1559,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  	switch (imx_pcie->drvdata->variant) {
> >  	case IMX8MQ:
> >  	case IMX8MQ_EP:
> > -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > -			imx_pcie->controller_id = 1;
> > +		ret = of_get_pci_domain_nr(node);
> > +		if (ret < 0 || ret > 1)
> > +			return dev_err_probe(dev, -ENODEV,
> > +					     "failed to get valid pcie domain\n");
> > +		else
> > +			imx_pcie->controller_id = ret;
> >  		break;
> >  	default:
> >  		break;
> > --
> > 2.37.1
> >

