Return-Path: <linux-pci+bounces-15722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A929B7F9B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58191F21345
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E221A3BD7;
	Thu, 31 Oct 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CKIrde/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1295136664;
	Thu, 31 Oct 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390697; cv=fail; b=kPNimkPzBO7vSLH3EtyZUGvhN1zDhp/hm4kqaEb2SaLa4UJN4WbV/UNXT/nx0b7cRALs3k0/gDe+RCeF9SbC5AiVd4chUs5yoo8izxViXyPpmmNJ9OTaV09nyMBbxmAKcFaF+SnbHg5n7p5jWF1wwBxKJMSIl4ZfniXNa9JbIb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390697; c=relaxed/simple;
	bh=WglXJG0NLrxj/N1z514PK3w/oMKw8mVJbBK328GYvjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghLgm56T1rcjHkZcKHSCp3KoNo89/ByE2JRzbVDZLCG1juKeI3fPhkG4SVf20WKCiD/S3ZPXuXEoK7TulfxSr0BBw/hbJOV6bhgAXn6PS+kHPSrTt1enkY4/3vazCN4jLtVkF4xeNPa3GJAZ0AyhoPXkNFyQi0iWa0XFyDp00Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CKIrde/0; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyRMJ96lEoBAXjGVUEBX82YitGTzoGz9y6OOIUdu7eFRawQNzB14PIfFjryIN+AC9HBXns947NtDaNlTYvqfaunaeo+GQyxMMiqEbHAtxfJToPpfz87htIlg1B06qL3n5t6YFGuCs5r/MzDxHf/dszdS9wSFDORPNjLkY0IqzsxYPAYIjeV+9dKiXZRbBwaA8XxepqaLgPdEJ8n6HBbr4T84LL6frUIc7tg95A3rzU6P/9i7lvg9DufuqcirQLAPk94zDYdW+US/9jXxr67NKP2P7Bxo+UjYBa/nY2/gClnsm+3Y36WRbi4+2u7YusKJEsLneFcFsY80dTwAGkNs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1hdgWxKF15miiqCJmZwWJ3mw3AGTQF65cwQeAfEvHk=;
 b=RXtQ9lEKvUHFt1VUG9/0vGUNfdf8iGsEdeeP3CAXuGQQpuOkhnE9twWNbYfk3m8M15DDWvssuybKpEE96EWG2XApsfcjXe96ScSFdcOT3mLkPkA7+jMw2Olf7jG/qgeqh2wB5XGSk5sclLbRV2rNh5+NsNjoLqz4QfDuPgJ8RO6Bog2K2LZKCRShNcs0WNtc9oSGKKakRmgNnWW5sqjfjzxWZtZsX83Fn/NEPWu5f/5Bj4eJ+pHyDq01IopyoRcrDseyBRj9qTr9gJv32MT2XEQa7h5FJ4qTPB5dLQPeK66KOAwTmh5hH5sK8n3JJOn8XLxqf3RcpBlZwsYhDp9XHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1hdgWxKF15miiqCJmZwWJ3mw3AGTQF65cwQeAfEvHk=;
 b=CKIrde/06YzcC0j9wDD4NsiHWVJ6RfK/7DpbOsB2EKnfcCL71QbKeRBaE+9K1fNEtVajLH0Uk5S1jagENnbClKc3g4sisFoW2mHPI6iIL57kHCDqG2MLPaOPtDG3lgI1oGxssrQ3b0O2ysSgM+SKt+b3oOiUiTf46xaXhiP0a7KSnyTWmKoQZTzfBy3fE/omqPlYa0OaI5WS8JnR/G32swnBiIP+RW552TKdSQiegaW/Z0JUh1laoSwg0cD1d9HH7hVyn5PCSLMPAZ8u0nwL244krE1gQrIMYPLtXp0fsGxRbjAXxL97JdWhYaiANoHU/oIdnzaWsVoQnhTdkgn8+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:04:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:04:51 +0000
Date: Thu, 31 Oct 2024 12:04:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Message-ID: <ZyOqmH8hDCBE6+Dg@lizhi-Precision-Tower-5810>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
 <20241031080655.3879139-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031080655.3879139-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: 417689fd-b214-458c-a6f7-08dcf9c5c030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdQShJHmIXLHPezF85550+NLuBiiJW58hJK1UtoqMmFYzUBarmQzetePXNlh?=
 =?us-ascii?Q?bbxH1ZiyzQ0IdLHp6q2a/exifB2f2V+SaQ0c5sROW/oQloeLBujA0e5WKLqH?=
 =?us-ascii?Q?yiJDEoPVBr9Zezknf+W++OOitypWOF5Z5pgVs5hYdK7ooF+j0nRDYbtYkHbI?=
 =?us-ascii?Q?SSxZJeMXEvbGJiIo9BHVDz6YBujNqO91OR+i0FESqMfi58cwZ5Lpvm8awrzm?=
 =?us-ascii?Q?iy14UI6qRdfO3fLOAllzZESVBsrl3mdoU6hpx1gSQDHgXV2+1ILi1ZrbkOhN?=
 =?us-ascii?Q?9iJaZwg3P5DqDZabiZsyx6iSWrNtdT2d1btJMMY6BAnFHdhx7TQg4a/Jn0GU?=
 =?us-ascii?Q?s4ykc60voXYsWw3xdVwzWDRB5aljnEXa3zTxQTkR8roygvNnht/W7G1Lyzxj?=
 =?us-ascii?Q?+yCNtXybPK9gzIZkhlWM+reiyg2s/aMCXt3CcbCpmiF1P7XJ0BMKleYwq9lO?=
 =?us-ascii?Q?YeZv6/SfPJtgOeJrHdseFr5x3P3ffbdO+01DKH5Jy00WbmhaUgnGQLAhP4Bb?=
 =?us-ascii?Q?+KUQR3nRIpetylNQzuEL6eYlrCGmeYgyTAVZW6QPdR0RAXIBdZf2Sq+OUToV?=
 =?us-ascii?Q?x9CiuGt0R1mLhBhwqFGpkeUQbZCLFMjZ53lYizjgJGlUaUG7v4S96M1KKXZz?=
 =?us-ascii?Q?BejMm+kjzdH78YX3l5nEEQTNwJ+cpcjjrTTP9uFOKUgb1JYnogNTegpTK7t5?=
 =?us-ascii?Q?pFcU5BvNw4X2jPBIwvg/ANyqMMBlCqsM2YMYfwxlfH4H2vPsF/pZlhxI+2LN?=
 =?us-ascii?Q?qHaH6OdH622GmNRzS8HXOEWLSNX1urOI3Q1aHLC4Nr8XnwiYhQ3TRBxYcQJ0?=
 =?us-ascii?Q?30fh5n1aMxDFbcUE1kX40H9YCPT/vUalL66+7Y0U59bDnuL+pthBcOe2Tgsq?=
 =?us-ascii?Q?/iSKrUatf+QtsP4bkk2JRdhPjwBHpbEgY77LACSnvh9/luBs3b4LIDjFcpoi?=
 =?us-ascii?Q?2s9a3/vk26jpNb6ou/ieSeVxU74kHqauDEqYW0eZ4ZBx97O9o4edWkQg5esv?=
 =?us-ascii?Q?Z6h0fq4J/oBxWB4U9/mplgrQVrchcrb5kSMtBb3PWl1WlsrbscC2v2a9E6LR?=
 =?us-ascii?Q?AW70vAp77nUFdLfm4prxpYUKkfXbcUFPeBLRM/bjWRyhmw2BnPFM7tUULxS7?=
 =?us-ascii?Q?q9ha95ck9ChbI9sc527vnPcOxZaGq8DrXWL5XQlm9xm5VxqVBdzUwpVku1Di?=
 =?us-ascii?Q?NDgSIcjeBbWP3OWRIHrC+3sLm7SJU523kPLWC538B2nwtji/eYB6ObDVAoGv?=
 =?us-ascii?Q?kX+79bQ6dvCgxt8eifh0W/Q9aNvsNEt76JvBNKoDA67xWSOlnK/ptLsEl4I8?=
 =?us-ascii?Q?9n8fUj8aRpRfoRlloHL/m+BJ+pbPr1qftnHN+2gdsgsCRsZX9F/eNiy8tiP7?=
 =?us-ascii?Q?Qx76A8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aq+hgvzIyKXTk+jKYvKf5STHVnwipWHV3gNARsbCExwoZo958bz6ofqgbpMt?=
 =?us-ascii?Q?8L9b7ndzLbDxI/HA7b1IOztuHaGGsGhpqalK5QMGDcUZ2WmRRj7qYc6dpHaQ?=
 =?us-ascii?Q?F4cWKJtK/Ul1XJyaGrS9mR8tbq9XcYmyLlWBCLA824chl+JrNvG7VP9JS4Id?=
 =?us-ascii?Q?lquMRdRNvnrp3FKRnR8KoxcNFfD274Ung418oAQc1jZcuvaV14yJuWwx5nGv?=
 =?us-ascii?Q?yHW4YWQzNHml41uOFMzPNjYVQKLqWxXp1EOoIKPJYedDdc21kOhDM6JAAkA/?=
 =?us-ascii?Q?mPZJnasZRxs4h5eRlw1pDKQVvM5IXGFm6GikfTUIvgQJGodNc7syQuMG8bs0?=
 =?us-ascii?Q?1aI+GScoZmoCeyUjtbvlVLupeXnyzzxzaL9XDdlfHOIpqnMr9khNUdCubWXI?=
 =?us-ascii?Q?FUFIZDdeMBXw312dMgL89dwL2oGPDFq1ez0xNnxXNsn+2I3e2/1btSpVJHbU?=
 =?us-ascii?Q?KQaPwiMZ1qt+AwqIhdXrMe19IbzefWraQ2hCmJPBlcKcexmlxpYuqybkoEMQ?=
 =?us-ascii?Q?Get0sPcMXuJZHLjNME1w+7bl5U0oHX3mKjwA9b0zpFLHAgZQb4pCroAkwywA?=
 =?us-ascii?Q?s1vveBU68MlIGbXbF+xVc+GBge5edU8teJ7qGmCJ6P1+fyVufWd+dJzbSMCU?=
 =?us-ascii?Q?ZV9naoTZG55aIkTxfRH8XUfgklhW7fVA/MdGmf3CTMI3YX9b9aSNscmXLqAX?=
 =?us-ascii?Q?Z6eBgOz/kEfjS5YH0WExO2T1ec1ab4sx6qNuTiRD4LeApRXFGviIJkTpwD0l?=
 =?us-ascii?Q?XQRC8EckHPJDlKfDAnyc0d6MgECv3B6MwlXTO0WSvTi15uSCQIANoOdqPDMI?=
 =?us-ascii?Q?HSAVjeAA2rA1QKICIFtuQ+TVlevRsapeyXL5xh4yR+vZbnAhTaW5aggc3a+M?=
 =?us-ascii?Q?AxZPXmymyGiC0IALLs8A0CqSmaxLFsEtrnIGue3eDdnzhlhJtBZl4rCFxn/M?=
 =?us-ascii?Q?kts3SGrhKsG6J2j2kHUS/25oSkEwEvyD+u5hpM4jfynhuVZAl4jNOcHHbLiV?=
 =?us-ascii?Q?v0xhj4D5SG5zHgg0xNGyrXlTAFsokaAY9CHbRqhYwOgKVygY4EXwBbZMwi5W?=
 =?us-ascii?Q?Es9Hi4MqNV3MpPUsbXT+Dv6+3f98PYtc6AEG8iW6wHyo4wQ48POYPo3szN52?=
 =?us-ascii?Q?ggr9xYE70waTkPzPCmluKaM2yFVd7Gxx4e27ASwq5Tp//bnAAbK/v0BeU/3k?=
 =?us-ascii?Q?ztYKcysmKPbO0SluWc0iFhet9nPjf1MoQ/jt15KjW0VmYu/KEbB0z0GMwohF?=
 =?us-ascii?Q?iqLbkfxMxcZHtLc18HVUZ007XLhOtCdFteZOQaWqi1B/6oJjEdBBtq1Wt9kl?=
 =?us-ascii?Q?ZLmx0lMuCI+nsbxBHk7duEwTsjTjFQdI0Anny+ObqLwTefiGChGl8oGBHwUg?=
 =?us-ascii?Q?lsHA63BlQZq51P0cWlGLX+O5lk+ZYy6B44/WsRU+o1zoRzQU7wf43LlLefid?=
 =?us-ascii?Q?QTCNBRTV3vnKlYSJGBtCz6NNZMZmfQCwSMVrI73typ2hQpUxbicg0L+qrgy9?=
 =?us-ascii?Q?kqBqWttgKyT30NZDEbzjOpiuPP+1DeAVm28EBuHFNPPkGXAu7ZfwZO3fMqQ7?=
 =?us-ascii?Q?BNkVkGbPIwYx1TmWZAthzEVWBcggWTkXnaCVCOZb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417689fd-b214-458c-a6f7-08dcf9c5c030
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:04:50.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSfjw1Zy4WFriw5SmIQonnbsj/ywht3gRcQ8eqGm+2810wWIb0zLjeX6BOsCALl7PGHWT7XXqntRcgykVuiTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Thu, Oct 31, 2024 at 04:06:47PM +0800, Richard Zhu wrote:
> Add "ref" clock to enable reference clock. To avoid the DT
> compatibility, i.MX95 REF clock might be optional. Replace the
> devm_clk_bulk_get() by devm_clk_bulk_get_optional() to fetch
> i.MX95 PCIe clocks in driver.
>
> If use external clock, ref clock should point to external reference.
>
> If use internal clock, CREF_EN in LAST_TO_REG controls reference output,
> which implement in drivers/clk/imx/clk-imx95-blk-ctl.c.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f105417..73cb69ba8933 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> +#define IMX_PCIE_FLAG_CLOCKS_OPTIONAL		BIT(9)
>
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>
> @@ -1330,7 +1331,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
>
>  	/* Fetch clocks */
> -	ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CLOCKS_OPTIONAL))
> +		ret = devm_clk_bulk_get_optional(dev, imx_pcie->drvdata->clks_cnt,
> +						 imx_pcie->clks);
> +	else
> +		ret = devm_clk_bulk_get(dev, imx_pcie->drvdata->clks_cnt,
> +					imx_pcie->clks);

int require_cnt = imx_pcie->drvdata->clks_cnt - imx_pcie->drvdata->clks_optional_cnt;
devm_clk_bulk_get(dev, require_cnt, imx_pcie->clks);
devm_clk_bulk_get_optional(dev, imx_pcie->drvdata->clks_optional_cnt,
			imx_pcie->clks + require_cnt);

So we easy to add more optional clks in future and without lost required
clocks safty checks.

>  	if (ret)
>  		return ret;
>
> @@ -1480,6 +1486,8 @@ static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
>  static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
>  static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
>  static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
> +static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
> +static const char * const imx95_ext_osc_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
>
>  static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
> @@ -1592,9 +1600,10 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> -		.clk_names = imx8mq_clks,
> -		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_CLOCKS_OPTIONAL,
> +		.clk_names = imx95_clks,
> +		.clks_cnt = ARRAY_SIZE(imx95_clks),

Suggest add .clks_optional_cnt = 1,

>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
>  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> --
> 2.37.1
>

