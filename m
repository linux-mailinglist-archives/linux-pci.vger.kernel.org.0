Return-Path: <linux-pci+bounces-17709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551339E4836
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE3E280CCD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE38239198;
	Wed,  4 Dec 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VuzKZrXt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99F1A8F6C;
	Wed,  4 Dec 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353127; cv=fail; b=r9AXRwLaMTCIkfB+SVgCTP5pI2JYabN9QVtlndd15SKOMv2OqGYpOSWwX5jhBwmB+l/LnKJe5FZdeDiRAqfije7qaP6sxUbi4PwdoTUFVdEDtSkKEn9UkWufCS/5HlYoTp8FG3NwVDGdU/4jgksV7i1RZ8dpirJTxn4S6JdD3Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353127; c=relaxed/simple;
	bh=xm0EEKzYFlaWu7GtxU/8lJf4+LOiE7WQ2DbhR2UGSc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FU23P/qbzgtD69w+Vh/EMijOtP2pqgbrUSNhOzuwAkMoHfNiQ4opvOcNdjzbaQnGrYrw0eGdR1/fIMf+EUEGM4YGIBrJ6P8ffvlcBRr79bWkOQj01qEjhCbEfi5++FeMX14MDO0ZXCVctCijnnunwnqE9thEGXSCaZJlJvmcnNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VuzKZrXt; arc=fail smtp.client-ip=40.107.249.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCW45sYph13BWOlQ+sQZiVFN/8cI2xDHQ5TM/FGUKf5z8+zCYyAssiE6eOBDak+311izvJpx5unArWWPA9NsNvigGxX+jpGpdBvOoOeqeJm/nJjTYfxrrvkCtdheSptwRwu7DC+joZ+h4KizIhGzht4IWsS2MJoU5hCTcRsq4VZ+nbWb1Cn6+U8R6tS3gOQmeu3R26XMjLM+O73PODvAlqXCcTxiLv+u0suKHRNTOMk6wyPnsrtrhYhJBzZwn/al8a9wFhegHKS6hkFxTSecNQjXJmjsn57axb0j9T5avPG+XTYrrIitOeoYjMsFRlw8U00s1wl/t0wmqznRL8mf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d38mrzySOcu/swGJr0BmcoAN6DqJZPpH7YiBxGAdX0=;
 b=HK2WskvOdVrJuojP5DZuFkWrM7kCnE75uAv9qac64HMlljdYGDZFCtsm9fXX9f1cA6lXuj4D4LOVwOWIUGw0bICAMtzkAFMPCaAg7oSejOZIa9OXqL68CE1bbqjUGkpPfmymKXbdI5hi7LX8BdIs3BUaKilICSWksVmaDFntQg3uvqA0BkGeBrWlvXai66NBx0PShuelF8eduLsQQTIPiDZYrnlQX5JeEy8osrByxkdnes7TvOsvaXDWv2dWEu79eWUMBlhReBriXgIBGatyyUenIC3gNNm83X26KsZM2im7fOXWa7CTcvGFJGWFudW0IT/vG3++mMnB6tDeuY8/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d38mrzySOcu/swGJr0BmcoAN6DqJZPpH7YiBxGAdX0=;
 b=VuzKZrXtkvCF7XfUsSqOK6aOmM1INK5j5IlDpw/A9vXsf1e8bQYhvBjgeYbZVTvtDJoIOAYY53shiDL0ZeI4YIVikYvXnE+kOarFSvikxxogxgVTcqU5B8d2yMiZBct6SFBCI5mXwHtpG3FaYpqPlL3vB26KfXDoQAiEXcKKuFrIPN34peUJHqUBJzYgVCXFdl1lgNRh7VrF6FQw0GIoq9YgO71AHgYslE9sOMO1e2Or2c0wp2CCQLqPamrjaxOpE0Ynrg/FwPyibKI8cUm4maV3NSX7TgA/gDItIE4ZSqAtgtpWZxkXhIa8fwxxNqiUSUxmKL68alHjta7e0OnL1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 22:58:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 22:58:41 +0000
Date: Wed, 4 Dec 2024 17:58:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 06/11] irqchip/imx-mu-msi: Convert to
 msi_create_parent_irq_domain() helper
Message-ID: <Z1DelMq8m7eG9SA2@lizhi-Precision-Tower-5810>
References: <20241204124549.607054-1-maz@kernel.org>
 <20241204124549.607054-7-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204124549.607054-7-maz@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 71699ede-8a70-405a-47af-08dd14b73204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpQCtZN6/O9v4i9cerPldRoEFV608wY1IXUcSIMYFun+nNGqL07ZD27o6fTO?=
 =?us-ascii?Q?6H48w1MNcqYFv1pxIuOWwtu0h7lqINaJ454TihbhtUmSgNwFi+IOvnGEgiLr?=
 =?us-ascii?Q?no//IpmxcuU9Y2AmVGN8vh+F/rxF+u5BzqPlii1U0LZuask0QuCIJf7xvosp?=
 =?us-ascii?Q?MJxFirjsehac8m7LRvryejzBOQxbhpVJQ0WrUATzCYlQ0PPeMiBhyKoGK65T?=
 =?us-ascii?Q?ty7HBL2N2sgm8jJG4lesCOZhtlLAfmHtKc0XEzu0QpBORauCgayNEOfEDV+C?=
 =?us-ascii?Q?9xhR66jZvCE/LWZFjC+eU8MLXrJgIuhXxsYVxPbtVFc+4ofYwt7Dc2QJrba2?=
 =?us-ascii?Q?tl1u6gL/CnVb1AG76n0+ccPpi+ua6ZAUFN4dJVUbNbHGCTJJxx6sq4tKIF11?=
 =?us-ascii?Q?rml5Iec8U122XQGRAJn3Ii/M35HWOqlheq2sKXIe0Y9KzH64Z0OAW6Nw+AS8?=
 =?us-ascii?Q?95Hb9SdAAV3OxzBxAMEApoo1Kcw+HNPanu4qORnuugpa+1hvPWSK6ri0MKrQ?=
 =?us-ascii?Q?SJeGmNujHLwOCZQHvvLNe0YLDk5t+Aae4itDaJnvR/RweSe65Rh5MJwaRBeR?=
 =?us-ascii?Q?SeOnqz1ZY74r9kHKp7l1jAY9zQnkM8raThPDD+C37IVHwXmt/TC8j3yLiQ64?=
 =?us-ascii?Q?zbTcbeQha0v+KAr0nlPJMk155aV3fhHiJSXRPtVFI+PKc9cR8+QxLns9Lg71?=
 =?us-ascii?Q?49aXatc3dW88QejLDDo/RIJ8Rm4BXTA3uO4jzqQrRkdB0eiOYsL4nyJnRtNG?=
 =?us-ascii?Q?TiSZg0whBeTaeIARzu8g8qs3OGsHUmnNFUJUXy+5iG99LbVxKOmbXVB3Xcml?=
 =?us-ascii?Q?PZLC7G8cgwX5c64skmaiuK2qKWwa14wV+CEnGoGeSEf/Lyp6kohZzTrMK/lf?=
 =?us-ascii?Q?EnRvByMpkWEi2FVbVuNkOdpFD6pXcNXIU7N0+JoPVddQCKRVtMUfUCU38ild?=
 =?us-ascii?Q?QgHNLDAJIFGWHXggy/rlBwqtAsbdmotgvZlQme7OfNCogAEj+JZtE+VmjOet?=
 =?us-ascii?Q?/POmgJ2GgaCRI9oxWlZkl9Rdydrnf99qSb44wU4e2xdCXZtHvLxYzyzAfVoK?=
 =?us-ascii?Q?3avg3Xq8q34BIwT/B5LWIHf+p3yndcl6NieBgyNQX4W+FqxWwA2gPmFW2Sd8?=
 =?us-ascii?Q?YhFDpey7K1HMEZI00RMqrFhtCqeWEqHpeVC/sUQQBiv3wLIzVw8xFGsL47s7?=
 =?us-ascii?Q?nzL6gCLdxc37JNBrEH4lohO115Fv9Jknxl91k/D8L/LlaY2qdZDMlR0I8tgU?=
 =?us-ascii?Q?jLVaHDQFtrnfpPltbsRuSDTJ8oHsT6r391s+QxinEFWcS7ovXelThGIUUHDV?=
 =?us-ascii?Q?A4M/q4n2X5OrtoWsGZxqIeFDF8xpXr4Om3D9FE6adix/eTPwz1vy/+KhFWyO?=
 =?us-ascii?Q?yS2j6n1ZOFxxfmPYXWH+UlwB+GVLNrbbHqWFqhQDWAlfbzTT4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9fIUOi2cMaPxOcDyvV6I+UvVi3S8ad92EEi/f1ioP0evP43z7Bs0+zkX1oe?=
 =?us-ascii?Q?L42TDUoGIreq5hNnnVPtPdyq6ZmuszXCG32kzELN2hHD/nh3qyXq1E96tRf8?=
 =?us-ascii?Q?gRIxifl4YCKGHinqxD51zuLEv5DtO9lNdhptn2ilv8m5GSsfwwaMR2R14hg4?=
 =?us-ascii?Q?I6gt7MaMb0JcLLeBgD0GL9KhAnjiPrWhNAbhtae8FVS7ULCG24ALvqqDp6Lx?=
 =?us-ascii?Q?U7h5/nysvV3cA5D4/gUzhg3Nf0itFFiW+wGVNa3kYVzGefC/gGeGryDFZRG6?=
 =?us-ascii?Q?51ws7aM3b9tO94gitHJQVtq7fU2+vUstxFwrYjxyffw2PCIPk0mCDzVlybq8?=
 =?us-ascii?Q?Ove7aR3FE/KLLdlwLz3hpM5h9dmx3nvZVHUyyZmgQmlx/6KAmqWXkADWY3ni?=
 =?us-ascii?Q?f47jEIl6k/dooocNxn1gmxl/oDIq73ljWx791NNi4gDH11XmAyqoZh+hE86W?=
 =?us-ascii?Q?pJkHqwg2k2VQ6sbTGXWkZrgHyKGj15d+DjukDDPB991RnyXooThQGOfrXR+W?=
 =?us-ascii?Q?I7wTCMKeNSGS7etoiqJ1aNBMOOkMjD6GzMeVJJme/iVFS4w9v2NydlvuhU53?=
 =?us-ascii?Q?ejldlDZgY4xrMFd7tcKWHjJp5oDifT06nbNcdXw6ZKw+xCzJmsuQdM7UfbwK?=
 =?us-ascii?Q?Sd8RaySuG+6ay2/qIOyez0wPjSnSmREMkXRZ9Ag/k5/IdHC4GSbT+tTpQ38i?=
 =?us-ascii?Q?pnJ2bKg1oAHeNmNe9CIdpilIzAD2nA2rs7Nr/bJFZVfiqZHejrxWBNZnXdsw?=
 =?us-ascii?Q?Zu75QovnPQPrFvZpeWrUslws0ipAs3TPhGlSIsCT9Bg0RCN9ccttlKhjQoPL?=
 =?us-ascii?Q?yDo84hpA+FWEuMhJ2dIYzUscQCqpX31ZYRyMiKPH3hPAJzCHJjPC67FqipuZ?=
 =?us-ascii?Q?j22Lq8BhDJSNNqhnV2k101S7mqNCAL0n4Q89K0Ufllu88VgiUIxmCdl3rfJS?=
 =?us-ascii?Q?EWVrCud+00S1EoQPzQj8XXjHClZWBZ9nri5OHB+nNLXQmXkqMtazHP1f+YX7?=
 =?us-ascii?Q?b5RGk7Ah+qTDZhS0jKobCOHLUK9L61pUINH0PaFJgNWe3WfI5vhVxyvIEKoA?=
 =?us-ascii?Q?4Ulk7eQHyVCnMFw3Mb7lvrNZVDeqm3t+OuRTXe6OHeQgno7S/yBcAnoh8vJ7?=
 =?us-ascii?Q?5M624/Vz0UOmKClp457JiF3GeW5StmtGRWi5GXGM3T7ASixNDa8rdPpt+5tP?=
 =?us-ascii?Q?YdEvBCno8OEBRw9sAI3n1LJ5/6yQQSjD3T5DZI7akF4BqJisapsknhNinv+t?=
 =?us-ascii?Q?eVamJLdkXtI+mcxTDzh9dWUWQctWPfRG7Yvk41ZHBgJ7kqLGKFYW+UbMIaNP?=
 =?us-ascii?Q?/citGEGgbTyrGRSrsbMq+PVGtCpBIS1zGCZv5k8S6A6uZ3IB1Z0mFcpsJ+1a?=
 =?us-ascii?Q?e1lixAT2SehaNZ+eOJgbGTHGGiayKTq1EGxgFnUpf4Cc4p59ELLo1ZCjr0KT?=
 =?us-ascii?Q?eZvk7DklKbZycPSe+Ii6KgTGxxXXguyG8vFDUNp9ksH9zdnlPCFDhQHZQyE7?=
 =?us-ascii?Q?wNNRn+zoEIekXosZAbxZjA0r1LT1VnC1spLBPrqAEvShtjBEOyIRHygV1d6E?=
 =?us-ascii?Q?GiSlyWkWkgDHjx/Mrg0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71699ede-8a70-405a-47af-08dd14b73204
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:58:41.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6DiAyy3BT9hMKjBwpOcxOmGv7Ieau4jIiR+QZQcUp2iVncrg/Lpl2BDz3O3+faezhid4DE2xZg2Vt2ISwhsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493

On Wed, Dec 04, 2024 at 12:45:44PM +0000, Marc Zyngier wrote:
> Now that we have a concise helper to create an MSI parent domain,
> switch the IMX letter soup over to that.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/irqchip/irq-imx-mu-msi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
> index b3f656c6e7708..b73968423bb9f 100644
> --- a/drivers/irqchip/irq-imx-mu-msi.c
> +++ b/drivers/irqchip/irq-imx-mu-msi.c
> @@ -226,17 +226,15 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
>  	struct irq_domain *parent;
>
>  	/* Initialize MSI domain parent */
> -	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
> -					  &imx_mu_msi_domain_ops, msi_data);
> +	parent = msi_create_parent_irq_domain(fwnodes, &imx_mu_msi_parent_ops,
> +					      &imx_mu_msi_domain_ops, 0,
> +					      IMX_MU_CHANS, msi_data, NULL);
>  	if (!parent) {
>  		dev_err(dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
>  	}
>
> -	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
>  	parent->dev = parent->pm_dev = dev;
> -	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> -	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
>  	return 0;
>  }
>
> --
> 2.39.2
>

