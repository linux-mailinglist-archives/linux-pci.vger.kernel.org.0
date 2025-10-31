Return-Path: <linux-pci+bounces-39963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E89C26D01
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2216E4E3653
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BE313533;
	Fri, 31 Oct 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TkWd+rJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142730DD12;
	Fri, 31 Oct 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939993; cv=fail; b=uZPeQ+IpMynMVdqth4XWIHMLvL1z4IFJtEbXaPETPBKAyBYclOqWIMFM/WK7xmqQwZk54xRSqrCe0jRjb5XHNcjpst1Kz9XPKwTDpH/XihArtBvzk8Ql+CGopn58Y9U3VQE0QwZlzX4G+DG9jAX+I7nPtAnM9AtWxSSQJ6iLv2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939993; c=relaxed/simple;
	bh=1ZcZEq6O+DMmQtdN/Ld7x9quLfn/NU6W2zvS0QnWVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTRDeDm8VkL8D5uskq9RK2HOUjx2zRboF7B4N2k6r6+iNnGbbOFLjFT80GH6P46DOSwyEnXsKUpUEOgqVivP4H8S/qF6Ahb0Ivk/QA64n2MJFRmVJJ4C5q0Xs/G31FCd2EZH3oNWKlA/LQ83JwGTQ0XCQvb5Sq6GrtTJOX2ulHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TkWd+rJP; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad5KmeIT2f4jrfHQ1zWTZp3druKOjRq1twKsbGI1CPa3Wjf8EwMPjdlRWcweuZBERKwDLhOs1eKJWqXxjBdz7AvxZAtC0HO6yxXrq0bgqjfSw4S65RcX5pM6OD5GczQzF3v17B6DrxP+Gls1ZzHXcbXixBozUTCL0bXkiYW4rR4AngKyrkHzNJ7Kftmdzc7nn9RYyRZ8yrH27MRXoWk+IbXHaVkK6gDi1Bc4r8sLgN3O57agzVg79QyCnV1ZGLM9F7nxhRgEOZT9n5pylSNX3cnPsU8F/iaMpKQSxoJpP2Srs2XnU0ljii+1RUVeD7LHnRCjBuN7ArBiEt3pxQ0nuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH8d4iCvjzF3eeDcHghktMazZvERL7xU3FN2rOyCWN0=;
 b=WcTdBOFYSD8+IrFc569ffD3TUGtC35LGIpzQDBA0OYB1KkTyzBZ0dbEECwfbxBmul/zxnHOnOSLYEzvY9/zYiArCCgHskuSi5gzzNEFiK6GcbfStK/TTNdgX2yXWBXefE/EBp0wskoMpm27auNR4xNWR4qXUzU5YH8cVHE1i60pFqJDjwcdPTmf7yTf+UqIo54kV55O/l6kJULbIUxgmnckpAO1CYHsv8xYTMgTcdyK9v5NAjaq+88fq8yfQby004h541yLV/7yKt4cGvLC+7lG97LzjsKZsPbNX+JdFDXBvCoc8OHBvCRTE5sTYYALP7z5yU6v4FtGL2Vbl9aqPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH8d4iCvjzF3eeDcHghktMazZvERL7xU3FN2rOyCWN0=;
 b=TkWd+rJPPRySqL9gF3rZvAbQawJMlaTC2bbQaALyrHqovStZ9D9IRQ0vvAIlEdLB7Rn2QwPl/fJn0Z22mXvktDCGETh4f8o3cu42vPBuDqmfs4+U8MObUDcqxckQZUDfugmJnFgCFm3Oa7fgiTybwsCdCWr1SOJur0AQ7jc1X6p3lKHke6sJn9rQV4x/lrhtWzQhJwwMqJm22E+StixxQ7U2ZMrcs3bcVL4Z8RHgbGRQgXcZh3eY4/C6HjbvE9IvC+rNEaNWfREvdOe+jauNtzVLZkGBqzu4RI1mrbnKxEhW7DyIfxvtxsHsuiKjj9XF567VxTCReEz3aUwBLqlOqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI2PR04MB10090.eurprd04.prod.outlook.com (2603:10a6:800:227::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:46:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:46:26 +0000
Date: Fri, 31 Oct 2025 15:46:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] PCI: imx6: Add a callback to clear CLKREQ#
 override
Message-ID: <aQUSCC+XHBuBA5y+@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-12-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-12-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI2PR04MB10090:EE_
X-MS-Office365-Filtering-Correlation-Id: db6511c4-29c5-4e48-d7a0-08de18b62d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKP42JlMgQIybmjOOT7ChM0KYrAcpAO03teSC6gNRhrN9ehBVsBYl8q6yPCK?=
 =?us-ascii?Q?W9FTmC8MzG8p9yUJiHX1OHW0Zw9/OCkOlYTHUBztd+n9QMPRLgNk+A/Wy9xN?=
 =?us-ascii?Q?tK+Qx1B2NpfRlffgJDT33hf+v74t3or8bBtpki63DhQcJMofaYw93h29ME1x?=
 =?us-ascii?Q?8RWw2hEo0xv7ivK2Fovtz/da50BS0A5UKlRCZmVqo+ZX/dcNQSFk2N28Xe32?=
 =?us-ascii?Q?EGa+bI4TAHpDkMGqwqyoe+rWr+FKZSrQLxI2/RnQFLpELcv5m8x8ipobCDEb?=
 =?us-ascii?Q?9MhoH2TQ+fJG5cWjxv5MC4Ol5ytlA+ODxhb9yeD+V3XPvIwg9nJiX1LPGSAJ?=
 =?us-ascii?Q?NFBb52CrdqmqP0Xj7M9M9smYOKPtYcp6Rb49VBFXrIdHaLd626yhl3B7Eujs?=
 =?us-ascii?Q?k63e8aJFHT9c4Es83xv62UvB06qyixYN7bIOurkshmlyPf+Y2sa5N8gyNJD2?=
 =?us-ascii?Q?WdZbEVMcBDaxYhJEyo/PK3FR3EVJpQvjtSKttln+WTKqSt6QniNoQu2rQO+T?=
 =?us-ascii?Q?tjZitIcn40lNBFfXV2ZPo0kcldgoJ/6+1udMjj/tWsiDkin1DTKYNWlp4DMw?=
 =?us-ascii?Q?KOZbl3DHtqvkR4a40s3cPcO1CKFnm7b7rkwkoHuSCvWTs/njBjODbXAhAjXy?=
 =?us-ascii?Q?U2zW2sEE+LPeO48Aq39VJm4iIGUGQs+YIu7zK7aMVrpk0Jpb0ET2x1eLkf1W?=
 =?us-ascii?Q?ETTL62a1TLM6uvU/4gHo5qSgxDnqQH5L45wvRHT6LNEnjgGMQTxnuXrrJPAx?=
 =?us-ascii?Q?+Qbtp0i+wN31v8U3wnH7jSPSfLn+GqzikqZmvTQLULFtNY40NHvFmh4TEqNe?=
 =?us-ascii?Q?ozlCISyfYV4cHUoiiphS7D+kkZyFtwXnLz3/bb/Aq7012X/3Cs+Lv9AC7NT8?=
 =?us-ascii?Q?ulgoo/VMv9yFfpgWKaw9cTANr0w+9DG2zWPqU8sss/fxHcl6IAOFik+4ugKt?=
 =?us-ascii?Q?kGWk78c7GErcYd9kkvTEoi8hek4WH3HG00AY5CnIXJPiJPrcsSnzzs1nrgmI?=
 =?us-ascii?Q?FRXo6qYPUiNZX9WDfVx/7iGAsfJg+Es3LRr+/GRjxNVwjVhlnH3xXIVkiX0G?=
 =?us-ascii?Q?rjtLgEfwEuMaOn8c1AiC21ZuAaNp5+zXBVnG8MTJ7GA4W8xUGSUp/OEF3juf?=
 =?us-ascii?Q?EFkmEP5gtaxWBMNhGnHauNXzVG+iRfrhEzUomEwKAtbbwCSdtFMjXylu8+Jb?=
 =?us-ascii?Q?koT8mhw/QyJUtTWo3/Fn3pFJL9cW8DSlk9ru6MlbV1NvHnH5FMszR3FA8OyS?=
 =?us-ascii?Q?TvubvM6tGs0/nBjUbifkn7E7h4aov0pFqdiMzbWWjso6+iCGXDDwY4nh3idi?=
 =?us-ascii?Q?Djm3TtP3EkSZj/b3XRVm8XRRAzqY0lpJT2L79TCj5P30wpI4EWvEsd/yWyTL?=
 =?us-ascii?Q?olQq9+LMbI+dIwRjDfDwOHz+33XY2mtyiosJo1Bk937x3hwnVMefndqM3LZF?=
 =?us-ascii?Q?pRaugFblid71uhDUG1uVGlOUQ2Kq/8URhUE13/vIByv51mEvn8dcpPhdrZWG?=
 =?us-ascii?Q?jsA8QbAH2GszwT+22K+EyScUg9ADbJeStvt4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rx652cVYyVzzDlgT8Tf+/8ec0Mg7loNbkFIzB1TDPUXycv+taynQhwdSYNhE?=
 =?us-ascii?Q?bDiyzQtvm1RFefm0DNkQpBCnffRe3hrQN/EHiqqkTReFUqegCSTLj5sMIZaZ?=
 =?us-ascii?Q?r2Utbu1/dcvgRfF75hUfipdUL0mhivHN12GKOiaD9ynETZt2jVHjVnD1FM7v?=
 =?us-ascii?Q?jO/8yt6c+fTlREwe0htQipj8MX9frvqMYQwVXMIY2mPdPIOZSFR1GQ1+W7v6?=
 =?us-ascii?Q?WSILEonl09W/VBzSaShQm0dQ1z0R+SV2gaJi8yS8jo8EC+F23hE1EHyeAVUH?=
 =?us-ascii?Q?bW10Wc372KR1a9zci3omU4A0k5mLxnvYZGdPyNFBBXraXdrGAAy0nJYM0ErI?=
 =?us-ascii?Q?qp2yCzHYbyNKHBpa+bkzXOjeEwcbC233Kn824/yYV5GJbdJdW+GwHHjPhUEv?=
 =?us-ascii?Q?bSD9bAaSFNJ05E59JoQFUCx4KdQocB5DSFaixxhEstqldsFQBpDeW8Un2Op4?=
 =?us-ascii?Q?s+qEiDBiw8kJRCi1BF9Zw3IkIE4Yupy4SEyapZvIPQoAUZTcQkZlsEXc9IZU?=
 =?us-ascii?Q?X8oCyliw7qIXV+colO+P5+fxGzUDsggm5pCsDpMtaNzQurT5YqFSAN9tZoKO?=
 =?us-ascii?Q?FBo8gGidNO1B6t48fYxE+RG95bcKJBchREOGJvk8wVw3ZZhu4eNN+Ff8yoAx?=
 =?us-ascii?Q?TXPoo6xfbB+bSuIrQ7O3WDYjtaVvNI587vf4bA7GrzeIUcPD0KjKLcAGgSnU?=
 =?us-ascii?Q?1+wgky1fHbr6kJyocvt3OeKRlY5WuNHpl6b9DDW5ylwdgMaWff6xuP3/g5ct?=
 =?us-ascii?Q?C3+tiyauh6syxWCRw3jsr7gvh/JE/50PNwX7VZSeNZ0CbvesmYuC/4G62C4y?=
 =?us-ascii?Q?FHUXgxzacoN8SoejuIMpAyhS4kinkXm3UIiZg+NmZ6yir7sutsIkZHw9Kl5G?=
 =?us-ascii?Q?JPmJMFdlGCfIuhqiV+q3YezPhHYXZlygOn5fLQXVkYObkw5m/VwqmvHnduY/?=
 =?us-ascii?Q?VlSyp2ABL8gF7VBCxu92cGUOPgzNaxW4ZJUTfbOsF5rnAT9FqQrroMLh1a5f?=
 =?us-ascii?Q?ByF+bUzaBe9p95JZyqfpYpG5M0zsu/qni/mAltCKclVgahRq8ZiZQ7ckffVP?=
 =?us-ascii?Q?IEuUoOtKjsjp7cv+p84rhq2PtwiVMj0D+ntkKl6dB1uBfLwS4FF3rnW9Tu4Y?=
 =?us-ascii?Q?HSagzuTGej08avLI61ZQnOgHcJWGvS/9miWPBjqMXf3c9hKBD7oAsJtpzQeq?=
 =?us-ascii?Q?9OB9tScoWqz/HGVLF5MhSsZ+77xpIT+Sx4CwbIqHC9ykSm/pYVLjC9bqG3f6?=
 =?us-ascii?Q?SwNCdcRSBeQLV7vE9nQwDXiguKWI0ZilaShjWxWddqs+AjTaMZehRhQ4+JBL?=
 =?us-ascii?Q?t0ltDYn4HP1qZEFb+vsJmSqZNbMtPTdsiP35q4ln7peUIUDuvEkw+nYyAE9Y?=
 =?us-ascii?Q?5pr1Fy7dYZG2G1yyVnmXyCQ+fzfTtjZgue8KN6vm/TMq1d/P0Q4gEIHaPVGL?=
 =?us-ascii?Q?b3DmKz1PJ+fTezyITx2/QlohHNaoYm6QVqDNmNBM9GMsyvZehjOTs1y1vARJ?=
 =?us-ascii?Q?bqmSgz8MNphfjVZGG00gWP7h8RKsdscLdJnbwXaohyAl26fpg/hVjdAJjlaO?=
 =?us-ascii?Q?fPS//q6xDQ/MiJJn55iLCfFMqP1QkEpKiPIzhf9H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6511c4-29c5-4e48-d7a0-08de18b62d8f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:46:26.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3eJi/gXcZXa0XoN4mC6dP4etjpUCfHoiIb/aYn06J0NDLE6QtD0o6NzIIpGPTeFCw0f35afsrdSyWHWqx7XdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10090

On Wed, Oct 15, 2025 at 11:04:28AM +0800, Richard Zhu wrote:
> Clock Request is a reference clock request signal as defined by the PCIe
> Mini CEM and M.2 specification; Also used by L1 PM Substates. But it's
> an optional signal added in PCIe CEM r4.0, sec 2. The CLKREQ# support is
> relied on the exact hardware board and device designs.
>
> To support L1 PM Substates, add a callback to clear CLKREQ# override on
> the boards that support CLKREQ# in the hardware designs.
>
> The CLKREQ# override can be cleared safely when supports-clkreq is
> present and PCIe link is up later. Because the CLKREQ# would be driven
> low by the card at this time.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index aa5a4900d0eb6..7cd0dc62ffd3b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -138,6 +138,7 @@ struct imx_pcie_drvdata {
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>
> @@ -151,6 +152,7 @@ struct imx_pcie {
>  	struct gpio_desc	*reset_gpiod;
>  	struct clk_bulk_data	*clks;
>  	int			num_clks;
> +	bool			supports_clkreq;
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
> @@ -729,6 +731,16 @@ static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  	return 0;
>  }
>
> +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx8mm_pcie_clkreq_override(imx_pcie, false);
> +}
> +
> +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> +{
> +	imx95_pcie_clkreq_override(imx_pcie, false);
> +}
> +
>  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  {
>  	struct dw_pcie *pci = imx_pcie->pci;
> @@ -1345,6 +1357,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
>  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
> +
> +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> +		if (imx_pcie->drvdata->clr_clkreq_override)
> +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
> +	}

Does below codes look more clear?

	if (!dw_pcie_link_up(pci))
		return;

	if (mx_pcie->drvdata->clr_clkreq_override && imx_pcie->supports_clkreq)
		imx_pcie->drvdata->clr_clkreq_override(imx_pcie);

Frank
>  }
>
>  /*
> @@ -1763,6 +1781,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	/* Limit link speed */
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
> +	imx_pcie->supports_clkreq = of_property_read_bool(node, "supports-clkreq");
>
>  	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
>  	if (ret < 0 && ret != -ENODEV)
> @@ -1896,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1906,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1916,6 +1937,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> @@ -1937,6 +1959,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.init_phy = imx95_pcie_init_phy,
>  		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
>  		.enable_ref_clk = imx95_pcie_enable_ref_clk,
> +		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
> --
> 2.37.1
>

