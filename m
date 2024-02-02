Return-Path: <linux-pci+bounces-3047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB181847C29
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134791C22F06
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 22:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6185925;
	Fri,  2 Feb 2024 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qxIB9Jnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12708060E;
	Fri,  2 Feb 2024 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912544; cv=fail; b=trpRrPA5eXIcLuySD95Q9O1Q1JvdcRVK6uCvi2JWiB99Ot30LfXUGjucWM8iNm1ZY548NPOOQ+eO6GGn3tMJpyOXF46c91dn3GmAA6Me/frNUlC6D61wC+YFbebvb4IExR92ORSAG7tsP6wDYcfFSpLSj0fyr6sibqy7W4eMA90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912544; c=relaxed/simple;
	bh=vUjkUzRhIgXiPaqCoIRRDdWEe282r9GTzdoCK9L072U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TmcLBmwXf6dGCTIEScHryjqKTrGo2C5khPzx8vJMQ41BXVraz5Zjoxqec6bBhlycd22dqztcRfdXMviR8f35tGHqUGt/kv9WK6NGJQxvmljzRRpjYytILqYjMC/daREM3H3ncS79hXRIl1i6n4rjk4t7QwwL6O/UEmeXDpnjptQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qxIB9Jnb; arc=fail smtp.client-ip=40.107.13.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DneoF/JmQZ7bUKG0U9paW9HESS3tGXaFgWYKIv58A7fYq6nMljuk6ExV4gDmIQVc7sX6oArc/adyIAF5hJqRa9ATfsFXXOS0P/Jx3LKpHppFFOiktaGCx0NpYnA7vd1IzvSRJME4k/jThe+59YMeBcUw8eBCf0HYAt2EpdGcVB4NVGuEFKH4YOxtVPP9uSUR8Gi33DpcsyjTTeMo4mzsavo5144nVb2PA9oxOdxtxjdEBbVp1t8VqvlfSIMyAztlWR2lRooaIv8tCcZ+eiie/dgT/lHRErqkaozsW54OB+c/o/mcesQ2nt7MWsNyq8VbHPx7gNWW3iOkUWTwp+bR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VVJvUYYFk1zVP2UvppMHmRxvD9YLNQYkkveyqZTa8o=;
 b=hhguomFeyMZLGwVdRIbz1msucU4Izd8ZZNS8bRY1VJ48DxVUo6X3zHGNeLd71duukxcGplLYos62fvTSUgaFeWJQxNTdKpxERZdSKMa4MZnpxG3QFz4MetupKz1brJOs4tTeo68KNNBFT0UPE7EihQKtHquUuYGDo6hwt605nG0qqlWhEYf4k/FvP1GGqQZ3rIzRYmXZiyGkEXSDsLNDLKTfbBHeJLwBYEQN91cGcvZ2BROfLjeMCQUovZPJEtcf7CjcjKFWBbKTw2uFKLKAOrBfRT9MLvEU29exhlpvEKU2MWR7CLzUUQxXek2/1Qa+yzK/Nyt5ksEafk7U1RuCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VVJvUYYFk1zVP2UvppMHmRxvD9YLNQYkkveyqZTa8o=;
 b=qxIB9JnbZMSRpt0iw4mshdZeESN3/fQmKjTHnI6iRoS/Ue4/QqJWx9d7Iv6Adm5obLqRQ25t4IsitAXqK3rBvmzDC1oTefDDCBA79bspUNdooLvKil9HA1pMbMQKeBbwoOyE0uOq3Cyr3wr+eUxLWDjRw7Ea1V1EeMRG8qekbnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 22:22:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 22:22:18 +0000
Date: Fri, 2 Feb 2024 17:22:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <Zb1rD4WK5D0ckKos@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-6-Frank.Li@nxp.com>
 <20240202215431.GA728556@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202215431.GA728556@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0194.namprd05.prod.outlook.com
 (2603:10b6:a03:330::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 411d930e-7ced-4ba4-1ac2-08dc243d6ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qI6EouQTEEouOZ6BqOhEgffXEFamMlzFROFJNyPUhkktOc9ntdH4MaUn53+5mdjjj9v4iB5BloGFhWBpggEYTfNks93SKR8dS6z8uY8YESe1syHMmlRSyVeLOW6kS2aYfNAg+fWFHDFkCVgyZIXu/B6SB2MWH3S/M6iQqWPQmcvBXj7M3kYBZ4JrzJS8iOpmff9iV1zunkfmF/JKDqsfPV2eSsqlAt0Te+WGashLZiEnoGbt2mmSlQPO6vPLJCKiiyCQGiep/5nOro3rVIS4rQJh05byljpGsADQnARRdSCyk18bspGDY7yljeSfTOXGQd0K0dfGMoe9FzpmlEIov2Dk4HvuRoBilhivFncYSliXh1udn44B+XWMPSOkrA2VC0+y3qQ+bDAnlQdYLRBxGsTIcH+4zIfOSFSIsdr67FtwFiSwZ87yBlm6gae09c4m5uA0uv8Z0ckoeRy51vZDVlYZSWdaQVWf2WTDR+XiQFaW89d7Pd2hxttbj5IA7kcEnPQEwCm1Gw1MbILyjzBQDzQyhGaIDJZEpzl+mTLg9HMjgOhcRpO6C2+0hCEFgziCOGzgDLovHUvwx6LexxD/sQGjS+KcfEnIwaAlXqTvLu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38350700005)(6506007)(52116002)(478600001)(7416002)(316002)(38100700002)(6916009)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(5660300002)(2906002)(86362001)(26005)(83380400001)(9686003)(6512007)(33716001)(6486002)(966005)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zaYkygNxKWEqfAhxlytI5dfJe0MdEq5vI0HIrzWHDvd3wcwrrcK8Gu1uVowV?=
 =?us-ascii?Q?+0nn/c1cgubf56/YqwtzPu6qfWjmtVpCCVCKWoJTnKX4ZkWrTb0bqyjPnxFD?=
 =?us-ascii?Q?Lwue+djxbdcgzhegNfpx/OQgaWMHHyS7Qebm+7otMu4xXu4MvhQU2XPiy1yU?=
 =?us-ascii?Q?YOlt15vEnlxyol77Si1ZMq22uCGNcAjlGcUwOzMJt49k1YEcoJf0QuYRAZLz?=
 =?us-ascii?Q?0P3qM3NMVQZDFHeIORALMKRafGV5dOOaZtLky1u96BoUVcPtRDCGZioBfHam?=
 =?us-ascii?Q?eSU88Am1j64XmtK3jUUolv36BtoRChQCldj7NKZuV3rztbf60EXeomlaECuP?=
 =?us-ascii?Q?YqFbohb9p2DmErFU4J+W5XcFYLsg6rKyUPzybETm7tuYsc/NJ/IjwAE6puHI?=
 =?us-ascii?Q?jCJD097REyitomU+d88ovsepT8gEdKwR2T0cI8wgPEWy3AZc7eFwlc2SUzBA?=
 =?us-ascii?Q?8KLhg8mb+ecM7aCgq2c0VFufS3oGQbehsb6GBcSToNdn13BydhFB7bxIgmM/?=
 =?us-ascii?Q?5IBT7bo1lyuhaSkrcjAIoMH9o7Cl9IgVY6ShZpYx8fecfEBnDOyq+kRm0b6M?=
 =?us-ascii?Q?ET4XEg9SAsXLnxIDQjEZnV5osSDFJ1zs+D/6vn+Epy1faAomkuS3tcTW6NNT?=
 =?us-ascii?Q?l++3Zw5f6pzePd8FOsvDZqtvj+1gmD1sZQSReX1eE/SKjXtafAAKDVxtSb9H?=
 =?us-ascii?Q?QACqSWFG5IypgM7gFk6bSweOMC+ZeRsrplqJW0COXBWPQ2N7xm/BnOtXiyuN?=
 =?us-ascii?Q?mL6WivsB2RUqdYZrzv6LaxPDI4sTJfNy+brArrKpfSq/H4uqf4mrm1hBpF7Z?=
 =?us-ascii?Q?JnoEo2GgydrgTIKapNT2Gwo4hjKf2ye47s2FyM2+UNGZmuCy46zmZ/xQHlCT?=
 =?us-ascii?Q?06wmm5v3i2bE0MpXLt1SL/aJaqtiYcweZqiENS9M8J1OuMP2g1KMXROoJ5o9?=
 =?us-ascii?Q?sRhtBMu57pxeSkQWprnFf9wntONX1wgdKouGaNmq3iPiVI0fwrMDIkzOwd+/?=
 =?us-ascii?Q?QQaiA7rq91a8DLxkrtPAuvBmm3/svk93Q0TdtlZ+FYGUwXP3hDp/959/nFaR?=
 =?us-ascii?Q?AJsg1v5aRF2v7jwpALEXy6H6irkP4a8E4crWQmnEbNsdcpXLdIntyDgypE5U?=
 =?us-ascii?Q?mkJu7q8NsAwDEQMjLYmI3RVtgFx3B5k9Fs8cuQOXwsnPpMLPunF+pjqL8VU3?=
 =?us-ascii?Q?FMyD2tVUu6Hh0JOGFTNyXyZNC/m9r2BjdB1VtTG+S+yydCJtYtRam/vRU4Qu?=
 =?us-ascii?Q?SVyi/ZdelZ8BqNTHYc6HubhtFFCWiJaaUNowZEfElylRg0sej8Xw+0Ik/0CW?=
 =?us-ascii?Q?L/pazNKSUDgr4K6hzPkBtmzkd1DXG82qNe3rps0+Ogs00L4MHjqtUlNYUJeq?=
 =?us-ascii?Q?zUMTWFJen+Zp2JEoHxKLSmrRaeSW3fV5kID0RpGkm2RZz4mcFDLNbeOoD9Zq?=
 =?us-ascii?Q?vqA0fThhdZOKjVc5HV2Cz1MibOLS//EB77Nx+JcVPRZN5beU3OqtykqAoSaG?=
 =?us-ascii?Q?siOBiCW8J1uy6tnuSwqQajbfHtcWeEBvVW6IHbdAieI1u1zxXeczXa2F87jA?=
 =?us-ascii?Q?n/5NQLxHPQBgMLF8DDA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411d930e-7ced-4ba4-1ac2-08dc243d6ab8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 22:22:18.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N7ohEbJIPXC+dLSbZQzPrx0+xjZb6q3+rnwpMpkAGhH5iHIXkyjTlfcXhd+Ay126gILqaJc25JYb/o4fAYIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823

On Fri, Feb 02, 2024 at 03:54:31PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > Avoid use get slot id by compared with register physical address. If there
> > are more than 2 slots, compared logic will become complex.
> > 
> > "linux,pci-domain" already exist at dts since commit:
> > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > 
> > So it is safe to remove compare basic address code:
> > 	...
> > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > 		imx6_pcie->controller_id = 1;
> > 	...
> 
> I have no idea what this is telling me.  I guess you don't want to use
> IMX8MQ_PCIE2_BASE_ADDR to decide something?  That much sounds good:
> the *address* of some MMIO space doesn't tell us anything about the
> function of that space.

You are right. If there are more than two controller. The check logic
will be extremely complex.

There are some discussin at below thread about linux,pci-domain
https://lore.kernel.org/imx/20231206165953.GA717921@bhelgaas/

https://lore.kernel.org/imx/20231217175158.GF6748@thinkpad/

> 
> I expect the "compatible" string to tell the driver what the
> programming model of the device is.
> 
> > +	/* Using linux,pci-domain as PCI slot id */
> > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > +	/*
> > +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> > +	 * controller is available.
> > +	 */
> > +	if (imx6_pcie->controller_id == -EINVAL)
> > +		imx6_pcie->controller_id = 0;
> > +	else if (imx6_pcie->controller_id < 0)
> > +		return dev_err_probe(dev, imx6_pcie->controller_id,
> > +				     "linux,pci-domain have wrong value\n");
> 
> Maybe I'm missing something here.  It looks like this driver uses
> controller_id to distinguish between hardware variants or maybe
> between two Root Ports (slots?) in the same SoC?

Yes!

> 
>   imx6_pcie_grp_offset
>     return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
> 
>   imx6_pcie_configure_type
>     id = imx6_pcie->controller_id
>     if (!drvdata->mode_mask[id])         # <-- looks unsafe

I can add safe check here.

>       id = 0;
>     regmap_update_bits(drvdata->mode_off[id], ...)
> 
> (This "mode_mask[id]" looks like it will reference garbage if the DT
> supplies "linux,pci-domain = <2>".  A bogus DT shouldn't be able to
> cause a driver to misbehave like that.)

Suppose I can use dt-bind doc to force to 0,1 and safe check here.

> 
> That doesn't seem related to "linux,pci-domain" at all.

I added comments about
/* Using linux,pci-domain as PCI slot id */

We may add new property about controller-id, but there already have common
one "linux,pci-domain", which value in upstreamed dts exactly match our
expection, I also found other platform use it as slot id in kernel tree.

Any way, we can continue discuss the better solution here. But I hope
it was not block whole 16 patches. we can skip this one firstly.

I still have more than 10 clean up patches my local tree.

> 
> Bjorn

