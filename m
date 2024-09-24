Return-Path: <linux-pci+bounces-13455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA80984990
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBA1C23501
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F096D531;
	Tue, 24 Sep 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmMF9+vq"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC41AB6EF;
	Tue, 24 Sep 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195212; cv=fail; b=Dx30eI2YxRqXrE+fnIBzESM0zoGegybOOKO3oScVunIt41OBaJZLNAnR47JTiu7REGkw7bFHXPriHTsOJM4FZHQrNHeFnfT9AEko/8giPKi7zKuUPuicKpd5O5I6vNgv0k4Un8eTQR7iXGanLS/qCDkAqP61sWT5MXTe3v69iW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195212; c=relaxed/simple;
	bh=mQbLwWlVk4K9zuVJ/50XHpByzaFuA2Vp8g5pQchjj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z99Vq9zmQa93KHL0xBTgQAEtr6s1byLtofEZ7v23UeV2j9GBYw9y+lNJYxrzIfK+NNcZvxbKBJiVTXVxASt54+wqXxsFxkFuh71ArX0Xf5OoCtC4l/d9ld30UcR2/thHiGyKTJ/dLrLUIENMAEKFp5EwM7TKGyL1v8d3bgOIC08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AmMF9+vq; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8lS4L6XxZHizj+a/9RllZpGvgqeyR+Ij0JkAA+avElLQUgUqoGmbn4FXCfJByk9HydgWsRmOA8ieeKzIDElHlBS+v+b2DTt06zzdxmwM+c0k9im6J17XNnVCIU0LaG8IA7nyc7u6jeZMFyXZ9ddlFap6KyVa+snaHGn0JBILrSeMOvzasoZU703APqHQWYYQmEUbtTrKEPyfAQ9p4BQn3KJeMyTdTnqhXnwxSVCzkhfZbev9MUaRKPXyVpSlXXzTysx67y+KIsJvjx2YhftC06FzXAgaM2lEALXp6F0WxUSneQG6fixY9ri1CJtNZ6f7ahlMW9VfPMnnxnuv6JyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n03lyZH/oibrqJE3/m6iXJQD79DGV+ppnk/R7jRTIg8=;
 b=C6prTfZWbdvXK4orZ4eNhHRCiQ6bbWicbo6Y7gnGGzbU8ndVu4RrRWUhyMNrUG+Xyf3BPw9a+C8m772jcQkuE8zKZMPoEGLT0vbF5Sk3GjYB6wdbRH1WoiIq6PeovHJd43OPFyc5033s6t+fImH5w6WfsarZzFhBONbTis3GVi0ISCs0s3zNhr3EGJdYM+yd2QvW6+aZtLeQz9Vy97nkKAmv9K5gMKQN/KHxT5tw2z8LR5i6nvbZkVekKIHKim02XHaJhWqGeybYfUXCs3sLeu4wXtc0nqq4qouBNDnoERTYlKwYlipgTsdB6XFHy8w8+uHODGklXcbFRN+JfFatKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n03lyZH/oibrqJE3/m6iXJQD79DGV+ppnk/R7jRTIg8=;
 b=AmMF9+vqDO4g8ixX5ehwSl4cHtRBA6ajTOI/8QPMvNKR3sLZXJvEl119GIaVwlcVbvIgJ9Dj8IesJFyyF96C6argYgev6+MWYy3hIPkSJXIj06vFgj2+b14fy19i02LrN8T9pnGjeBKTgp6jo2BfegwjQQPRzcBbYMt98gWjQ/K5z7L41RlAQdhbla+rMLMP9/YAhTjCtKAG1hQlPtAbxOh4ftO23Q/JognhfLgc8exmbJyJG7uC7DpZ8d5uGR7pxKd3HPjXuZSUjtrOzi6wHC5LorgvAV1i/MOoEoa6FnIRlaCu7UAjJZFJUshzOCPcUZHGq4D/2WDk9RnPQwtJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10127.eurprd04.prod.outlook.com (2603:10a6:150:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 16:26:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:26:42 +0000
Date: Tue, 24 Sep 2024 12:26:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com, s.hauer@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v1 8/9] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PCIe PM
 support
Message-ID: <ZvLoOUOiYIzLnA5H@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-9-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727148464-14341-9-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10127:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e5a643-1244-404c-7049-08dcdcb5ac99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sPqn7rVwsXCutKjcJZyTdYNUwIuZCBlzqhZmPMAskTIHdAaqLuGnNjUQRxWc?=
 =?us-ascii?Q?QS/k7N9uTfhRkyUAXbX9SHV4xpTxiCGeRYRWsDLVjoAnIgI+fqDLj4mG5ckI?=
 =?us-ascii?Q?fPnvhIBOSIEM2q28u2jRsZRn2xy4V1vzl32ko2L2PoSORufvHhoZdN4EmPZE?=
 =?us-ascii?Q?LBuHoQ78F437S8li5dg6AlBBdaPJZvc/7sd9aFQDIePmk7wS9r4JgbPg5d97?=
 =?us-ascii?Q?Ki5VSKOHValdVRgM7KN5cw8MAcTBUsDBkgYcH8su1i1Aou5KygEuTDGFDy/T?=
 =?us-ascii?Q?a42cj7vNUlwVCAU+fDKfOO5Qk1h0JIJBHyyUvSFoN8Orca4vHULgZWyPu4SD?=
 =?us-ascii?Q?+GkMoHdkXS2IevOXpG7OW1crblg4T6/20KnI64c0WUueqBOwGEJpkAGTLs3R?=
 =?us-ascii?Q?j80moofxwphVlvpawD12MI2DI6av0ZY2UzrIBrDnmZRt/8sJKZ84fXEIaj1u?=
 =?us-ascii?Q?uV2GJdt2JvtYJlCf0OowsVVBM6usFqHM6UyTwdfvJx3T6fhjmo3JUdZMAwu0?=
 =?us-ascii?Q?bcUFqzHnqeDk3c40Ulw7Bb70EKskLxsQvSPPLsyGalY60k2VD3PMSRuuXEc/?=
 =?us-ascii?Q?oKJRh6mwyW5isP7BXuc+Ll9K3qJD4Q0yh7VDE4BcwAlEcR8JBgXZulty6gFF?=
 =?us-ascii?Q?wKwKtrVf+sqn9LEMhjYyC0at1U5k1QO5nbRIXd6jtKCNuQ5j2dMRHqu2+/cd?=
 =?us-ascii?Q?ZFSGNnjsjLktEdfrkqvYHIghZBwZNXqJL2vvusAWdG8h7cjO8s6HfNpJQ+V5?=
 =?us-ascii?Q?pthVHglN5XDlaGb4jztYNSom3IIBHmElUTbXlTVv6UHSPiZ6T98Kr7rGjXqC?=
 =?us-ascii?Q?9EzQz5WOV1nqus0QKpl7kl8tCzLPMT5R7mwcN43qBeo/UhnlrwNmQ6ugMZXl?=
 =?us-ascii?Q?hb2NIunr+bCryx3CFRP3Dy4KNzIfb3v+mKgn1MZQq5qx+QF12Ub7Na09rcjk?=
 =?us-ascii?Q?Q2WXhIoFTix7a92GJ3iKz/YxVZ95jRWUY+iZquyFt7z63KA7zPelV2n4qoAn?=
 =?us-ascii?Q?F6CiYfse+JB1me3R7Q+yTXNQlPbtM+hTj/RUx1XCTYMMRySYgISoCeAJzJLf?=
 =?us-ascii?Q?Jn9mL8swuyahkabn2Rg7lN+8dVRvEAUN3DtZH6UBlaW2mn01P83posm78gCl?=
 =?us-ascii?Q?U/Tn3zSrPaIsIA/KEkz0kriGtWMplkcjXyhT13MIzmhjRbAmvU6DETyn5B6b?=
 =?us-ascii?Q?RSVw75GZvpMliBCuu+UmolVkhxRWDW+calt6Vkip2aTrGq55jMjd2NLhj/R3?=
 =?us-ascii?Q?JjOY1EXvoGIcdXDMICpKPHg7Aed55VX+O4hTd/5/WjC9UVtp9VHezplYuajE?=
 =?us-ascii?Q?Z43YVqnfu32a0+70I1YkeGL/I1lj2XQeqDSAFDB9aq/R4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qpHHe6H03PAg8AyJ9/twXEhA2PcUQOQnd3kdW2uPB8R+kul4/mCwc5Ogw784?=
 =?us-ascii?Q?teROkdNv6+lhLJ4QjhLFoo9lD3mEQ/PO9T0hY0CSBVA6BP8z5NwFu++0mXou?=
 =?us-ascii?Q?9kNESxHWtFXoVFPXOLj8i7svMtgHGINeq8Hkdal/yLkFJNCWXOQhFqKFuXDZ?=
 =?us-ascii?Q?ndmEtXQrHntlw2e/wdc+fohMbR+Xy3fQKgBxaG+koGsJ81hEgDiBbSix+JcJ?=
 =?us-ascii?Q?d3QDaIPJ6koaqT2ypPphvlyGeMaj5MPh8vwdIDAayb54dinYRyTr1DRru+nN?=
 =?us-ascii?Q?3GtZYtzSyGUiTeAHqn6nGSERvbNq38SrJpJLkGnq2WhbpUjOl+ydN+fCaHkF?=
 =?us-ascii?Q?Kx3+hmw1IKRVotl1opK1ZV4D/pezKlxEa45CuC1nOgVHk3tGPQBxl30oH1gu?=
 =?us-ascii?Q?q8xoDNn3IStrm0We14PF/323r6jduMTl7qjj/Aw55zBORKvu40QQxO8VwmGi?=
 =?us-ascii?Q?vtLCWPHTj4Fvt0F0P8FF6dgROwcIXcxtj3a61tCHszXEjxd7xv6bW5j5VCdK?=
 =?us-ascii?Q?PfNUMnedG7UD1qvjmWadyiBpOMAiFrE2EUa8YZ3Eu8PDRUG3PMZiI7nRNr+S?=
 =?us-ascii?Q?uC0SxMSV3MWshMcupaY5/oxBrtoWup7xOlUqSWYZGoBY4lhZ7QOHX9Yli+TH?=
 =?us-ascii?Q?nvSExLWgjjGvWqjrgOvbaM2iUAAfKsnuW+C2BGYRYGU1Y2FekrT7o2BrQxJc?=
 =?us-ascii?Q?nlP+y8Cer3JdAPK2ZxrMJI0+Juzo5ScYI6/DFZ2NfuAH6lMrZlAFifD0TQi0?=
 =?us-ascii?Q?PU26DmE5jRHp8Htb/DO+VrCLS6yCxMUXMLM63F8SDAtNmVIeqDEqsX9do4lf?=
 =?us-ascii?Q?pBJ6gw+DQfFkhIwo2AqMox7H64Da3LwlaXyPzq5y+0caLbJ4xuAphuYUbNW2?=
 =?us-ascii?Q?p9vkkEfICUan+w3dPxdBD/h54VQdvv82IwGKYxDwL1CupQNH39YUvm2xMTLa?=
 =?us-ascii?Q?qY1Dr4x8XCG1mrmvDtyRmfNqPkuS9FrPNWSjVT8pX1krINZMxO0vYG5YHC1L?=
 =?us-ascii?Q?MaOOD50t3R0kO1nNJJ0rrfps/mqwrMh9kco1vmmsWOuFgcfaLRDkKnaJ8gW2?=
 =?us-ascii?Q?ShG4mOEo8QZw3QuxCgnEZlAmayzmZ5Wz/XxaH4LV9l5xOs1Z0mVGv0/tZuC/?=
 =?us-ascii?Q?6NIscJv+XpLUwYGgwvvZDp+09lqWYlC0n57yUdoG+nS53mUjp/fO1OmTOo85?=
 =?us-ascii?Q?5KvT1tEELRyQwxVxjUO5Qs4wSj5AdsvEZtmYlWEDNMO88xw5FNmO4tofCsor?=
 =?us-ascii?Q?J03wopLY4+QT9OqmyQDcdw5nF8rTJKsHGvohQWBBMtzvOPxqmM8xtIva3zGr?=
 =?us-ascii?Q?dm3E+/uAb/j9iAbU5uyiqHT7NKjQvP2SNFcCRqz125WYg0Y4G/Wa47FyD+zm?=
 =?us-ascii?Q?Gp1Ygvy4qsotA4BHngEiVEUJfX2tkwv75Ppnw88eRidUajjZUi0nj4byfXN7?=
 =?us-ascii?Q?umoUrB7r4eRswf0FFNBUIh+wzqpSubM4UJtsPaBnprxC1AEITk/Z40FQyJlN?=
 =?us-ascii?Q?4Ra2n4VJp5T4YpoTei7ZJ5VtvQ6a1vgru1YxHUc1rDcdMwbIrGkErPX0akUY?=
 =?us-ascii?Q?goe9t7AWm+HZa7aOtys=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e5a643-1244-404c-7049-08dcdcb5ac99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:26:42.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5NgiWl6H/YokE5kDsqIkT+cJLhgkncJAUY6hitkgx030KJ7hDmMgZpcy1wm05g4Slz8gQlnrwIZ0/WVfR50LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10127

On Tue, Sep 24, 2024 at 11:27:43AM +0800, Richard Zhu wrote:
> Add iMX8MQ i.MX8Q and i.MX95 PCIe suspend/resume support.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 36df439d43ae..a8505cd3b53d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1497,7 +1497,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.flags = IMX_PCIE_FLAG_HAS_APP_RESET |
> -			 IMX_PCIE_FLAG_HAS_PHY_RESET,
> +			 IMX_PCIE_FLAG_HAS_PHY_RESET |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> @@ -1535,13 +1536,15 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
>  		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
> -			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
> +			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.clk_names = imx8q_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8q_clks),
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.clk_names = imx95_clks,
>  		.clks_cnt = ARRAY_SIZE(imx95_clks),
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> --
> 2.37.1
>

