Return-Path: <linux-pci+bounces-12766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810B496C35B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C294DB2AE8E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD31E00A7;
	Wed,  4 Sep 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jD89kHdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815D1DA635;
	Wed,  4 Sep 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465732; cv=fail; b=TjaS6p866+uWu04e04UY9KMUiUTwQmdsePaVYv0kbzMuu+zNSBPErIWEWVJ+gpWUgQ39r5FRz+bSWT8JPYNZpzlqj1q62LTTnTHdYvowvUPoL7BJEwiX/YAA1smBgrWOh6U2BCgZcvsZxkYwu/tgHL+e1DsX5l1GWxZ2hxhAuMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465732; c=relaxed/simple;
	bh=D6vdmA6hJ22EYZd+nTXYSC5pEJ7+yvGUpGYHnV4i8/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ex7yZbYzHlqXokgwkJHFKqVuD1Fu6QvzeLdHh0t98gbf6wrTWQVpSI7dKDhs63LBCompbpGcw5bDT6fGqvMPHFrxRlTTH29Rbv4+2hxBGA+Cbvi2Ypv5VjNMF67AwpBXUu9ArFyB/4T9vTBoai9UDU2bR6Jb8Cvvs4GpS6uCfC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jD89kHdD; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1zO+leRFlrvfsLPdbSxmoInyKF419/GWt6WvEo8Jl8ZrtDXTRVT4CX00Omypdx+OT8GxvIAYLcQjb7l5t2GC+OrbIhu6h7/w9N/EDoPTOywhOifi+564Xwp6MVX8K4vxUivPb7IZvanz3M4PaAjEHXA90T342y8Y3rNreHwgnSpZvxOQz+2YzbK4CiefFLfBgd2atbedcCFBTXhf6ku6guJlejz/MuAUnUH2A9OIAvUAtdZXDFVoo2pIE3fu2su02TuuyrXDRNmh2bCCD2W2H8juNExKcAfv4RCpSg2vmLAfaOZdYVyOM9mxgW50IZPl4MvQKFuVkB3M0+uabeCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2TaKot/QQceJdrAo64y04P6FlnkGr9fbpNUlAcrROM=;
 b=usT+DdTMfOFPXd5sDh8xHmnH4WV040VBGSCDpkRfhcCIInaa+HEdA0tCWf7M+XRpHlijXJuuk9NWRXJ9iNdjvu2lr/8xhjofswZHELlPnkd0pwASNG99bAMSkyMC/eLf2VsUk8KoYQlqXC8y9LMyzwvrycXhfjfE3zfFNL5UICOwiyiuRrKtjWI5CmuWXxin+WXdr0KWlgGnBwbMWQVBuTOizLXmv+VG5SN+ohFx2CtPvXwXXL5zCrhI8X021J+YQOBeSZw9S7laEJfblFRYp9+taR6HkfE06CeO/3ymUxMxs5GF9N7aQsKuSyNXSO1pzEe8ykbLfps1U7tpUUxIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2TaKot/QQceJdrAo64y04P6FlnkGr9fbpNUlAcrROM=;
 b=jD89kHdDL1XI3I+eQgUfGeRmppb3vMnsZiTEVPpPTbz9fGZIpWIMVUMjXfOgcBn0RnYzHuOVH3LRmF31fh40rFiJVPVyoaj6waSCdOQU59fptGxwyUHrPUKBIiGxWLtdUx14Qg6omAJC6Bk7ZrtruwB0uYiM0duHT0j1uZhkv2CC1cd/DvPdklnHsrW7nlhbP3eRGiSmppIoi6KS6sObPmuA/8WUcFfQxZB84xMKv+penoL3q48TkwIwZKDJ1qL/aHzB+Vdavj4L+P4en46OM0w9Trzqu+vuTMzkuHEeDHCQdf62a83GMZBFsf+IaETbEELSwB+s9LSgYbT33moA7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10177.eurprd04.prod.outlook.com (2603:10a6:102:465::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:02:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:02:06 +0000
Date: Wed, 4 Sep 2024 12:01:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 2/4] PCI: dwc: Always cache the maximum link speed
 value in dw_pcie::max_link_speed
Message-ID: <ZtiEdGNuDRp7Naby@lizhi-Precision-Tower-5810>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-2-ec39f7ae3f62@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10177:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd5798f-c95e-4628-7087-08dcccfaecba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAGwb+PNcXisGXOWxcG/CdRyEssSLRPbFQSzjO4j4+QaFMQqwVBDVgxLvzrg?=
 =?us-ascii?Q?OdkisNoxgl2ZUDnKXtl9s47gFm3qQjdUm2m13zlLOOG5hvGOHZCfTgUN4G+U?=
 =?us-ascii?Q?0zW55R82bzF9EP8oaF2WoigMoEYIEduktmt31vddd/vRoiYD0TxiNKFIgOGo?=
 =?us-ascii?Q?BlnjqPUV/r2XVq0Mo/acsrrGdY0FFHd7eJHZ4Ya2q+y26IblvBrzwl5P7WNr?=
 =?us-ascii?Q?T9VdJ0pW/tX1m5VbVhgNTjSLpBmJzyYuBSfYosDV2FmfdbTaGV5wD625MWP8?=
 =?us-ascii?Q?NuoU2aUkttGPWNRQBoMw26y8bu3Ddb3bRrfU5fGoxuFwTrLeMZmt9f7MGtBn?=
 =?us-ascii?Q?KU2eEuYGxgZaEb8WJpDmwqRF6NhlCEcXhKQmD7M/N8VAY/IoVwFjJiGwhoTS?=
 =?us-ascii?Q?OB7pn/IP8owyJuu/bJzvzjcymvyCAhBGIkcUeIsnYFWxZRAKe36yDZ6h9rHI?=
 =?us-ascii?Q?ozqXw0xb9KHUdL2NXDQ3w/PWIgKXlS1uMOrVtaVYdDcVpd14SxU3GDITLWAc?=
 =?us-ascii?Q?PbXbnGGkcAg111wlVZkgBMElihE987zKvfrvh3PNzNqh1UCPtY3SrxQTO1KF?=
 =?us-ascii?Q?VX90/LYND7bR9fWI4iQzPfomEiaKP937+cKg7qsNjNZFiWmWNpopwiO/qOsz?=
 =?us-ascii?Q?rp0Vwsr9wXR8m3GqRB/NVi9djpEgD8qrdjYA5HCkShtveBe9Nfcgl44CiBGQ?=
 =?us-ascii?Q?7X/eRUmOKy0yHFNYEau/FAN7TarRT/IBrOa1my5C3VRXHEV7oE5602qGFcEj?=
 =?us-ascii?Q?QrClfjS+jRA9qc4hvzV/BraWeHkY78UiG2qr8PC8GvRy+d2Tnyp+tMCtnfkW?=
 =?us-ascii?Q?mOL6BZz9CdRBDlJNtPhc57aIuirj2Nu2/BX1NfbB/29B2AzPgwVvj0+hHzE4?=
 =?us-ascii?Q?EO+BRsQdU39JK6YPxy9o2hQ+uD5kAN8hUTF4rKEuVJVO334QsQ6gdVvEx4CE?=
 =?us-ascii?Q?0wCCXXp3J4zV+s4r/U6B7Vu3IaXFYNEEbtYt6Ppmwuq2ArkcYgfBaNjQ6LBb?=
 =?us-ascii?Q?oxJROGcMPodTvhUc87Enj2DYHq53uXWv8rrSnGreRmmzEYTAm5+ji4rLIArl?=
 =?us-ascii?Q?ZAEWt7ABa9T52N8psEIRUm6d5jpOApepTZKH1mF9Dm07CTr849GBs+rWfxIe?=
 =?us-ascii?Q?AzyJ2cLKlI1w5GUGDxL9PETQMRLm6djqEH8fqIVqlctFhlNKCcpCQetJ2hkc?=
 =?us-ascii?Q?b1pQ8eQj/irrybihiGLwMhn0I7Z1CKI6ZkprXzMpCCTSl/sW0E8tX0/eMPFv?=
 =?us-ascii?Q?kCHQXn126np5jHGbCFYcr1CdxMD0wyqjH+c8fa5kxWRQqixdS1Rtqs7XZPBk?=
 =?us-ascii?Q?brHWH8em6BBGajYRVy+F8lxiUaRCDuNpl2zKzuz+qgh/eHBkeDwXuV7Uz/Zl?=
 =?us-ascii?Q?eVcCKhMSGfH7XG89AdPwfL9bn7Hw62o8U03PoJixo2JqKvIEZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCDC/u64LzPhOj8lkfW8OAhra0HPxFG12Ko1uWzrpXCV1psQfihd5V5G2ddl?=
 =?us-ascii?Q?8xCPUa+SBzoUcoe70iVQNERu9mbY4cQ0YW/auReXCsAiepUjdvWQrJlACc9d?=
 =?us-ascii?Q?ZjYzL1ZyYQH106kES/eJhHd1U/6PevV6lBWdMGVdO8ukfGy2E0d+AfKVFCy/?=
 =?us-ascii?Q?Xhi/bcxgMm255+pkU+RJXdOpP5d0qzGlEaHuW+exPSR/Dr+Iiw5IzJMYE/Hw?=
 =?us-ascii?Q?/W47m9k3bSoK4YoxIdHv9BW/1di31FejD57DT05ws1x09xK49TqT8mMrRUjD?=
 =?us-ascii?Q?z6bzyu2GiIqof0Aqj41Bbt5w8zOeqZAS3A0JLza2rU+x0g6Jqg3gOallKiKo?=
 =?us-ascii?Q?E5ov3C6gY1fwkyzsJNBth1VMeh8iN2yVZxgzS95wsb3Dao3/IWe1AZokBGJG?=
 =?us-ascii?Q?axABf60+0JHCkT1yCXHTB1iqGxTE09O++CPXaWxm7HBwUZqmlaWZGRtyII1c?=
 =?us-ascii?Q?s9O/Fa6Yivm/Zojs1fS8hzfGptragke72V0dRCmVtGX1XWwQBxY7tZ5cztsA?=
 =?us-ascii?Q?OMTGtyIt51Safz8j7FCuH0DMYGZtZQP3xjTajTetRoWS0YwK3tLun7hOkKpb?=
 =?us-ascii?Q?U0XUH3iAGYR2qBhiYTfobxeAPd33U3uYWPiAji3wGkTDjGJhTnyzUJ0BTYPZ?=
 =?us-ascii?Q?Ka/IWmahkrQaLFy0B9H+zFb4xTsZa3NPcS13/vsULaxNeoJ3zwnbArceN/EJ?=
 =?us-ascii?Q?o9iHl573BRviW1NUe/A0I/UyugDIw20ec5cUpOLfAF3j+VzK8LWIe4rhlm4l?=
 =?us-ascii?Q?zlVW4oTDZGoilf7ySU9GFyKZTRiJ54zM0bwHCSkz2VLxosf/zyyPqvJlWv9H?=
 =?us-ascii?Q?NwhNPNbHf8/d4/smhcYkSfwo49rc6lLak6UFb6Vw6SVyQPSSSz9S99y+JFqa?=
 =?us-ascii?Q?BtSqIZwZJTPHADQ44ofXJemjIM6jXw7tI31bEx1jUHB5ZtltU/Ik2QKlg7z3?=
 =?us-ascii?Q?kCypk2gIXiJnLU61xf1pnkjvhTAaue4F0PyFo7bFbWeANvG1zURCajC6Wu2H?=
 =?us-ascii?Q?9GghB/P49V4xgTeE9Hcm+xaDo77gmKYfHFc14kVdSHlDsk+KMlYFSC8OFd3p?=
 =?us-ascii?Q?rkI4Xuxvc7K2lFkW76e0D3NMdebQRCtTJPbpJsYA4Mpe/YbPYLQL6p7qcNSQ?=
 =?us-ascii?Q?bCxP+0grpwX+GNEi5RGcsXuK+XqIGuVKPam7GG8+27M0xF2fnKU7PrPTDJca?=
 =?us-ascii?Q?fIusy8Z0DnmArUtriv0R89Loo0nyfSC582UyPnGbmkZjLxXUfiXKgcROa/BS?=
 =?us-ascii?Q?iCRGK3G8gUUD0Z7SO9w/eWIaHXXKr1Q32ZFNPeknLk1EqavjxTpEv8gHoyPr?=
 =?us-ascii?Q?3lAyThbtZltCw+Jrtpv1ALw6o2PvORj2vcQ3vHQg/tamTOBYPYYpOFzlxfO7?=
 =?us-ascii?Q?N611KCv+veY+vA+BMxY/QB8tgaCMoLyJlBjBk7+sJRxRc0L71kcOCCJuqLs2?=
 =?us-ascii?Q?AGfZ1DMO3s/jo/FfLVuscTWvpsR+i5Ih+QdZf4U+TOwgYlsIMasecedeoy9d?=
 =?us-ascii?Q?/8TkZeWG3579v1S/h3KLOUgSGZwa9mdZQJQEFWmCCby8/b0dxxTkVAUbJMsh?=
 =?us-ascii?Q?7kiqGcOstaAWKmKu1qzRxnzzDzAL5l0Mcp4mKiJH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd5798f-c95e-4628-7087-08dcccfaecba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:02:06.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLkhOaGeVSYPhvTelEsc+72EiP4iSxtkqlTAilQxpDBwV3410Kr/E2YjWjWfMvi67k067iWTIgfJtzc1Vc+X0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10177

On Wed, Sep 04, 2024 at 12:41:58PM +0530, Manivannan Sadhasivam wrote:
> Currently, dw_pcie::max_link_speed has a valid value only if the controller
> driver restricts the maximum link speed in the driver or if the platform
> does so in the devicetree using the 'max-link-speed' property.
>
> But having the maximum supported link speed of the platform would be
> helpful for the vendor drivers to configure any link specific settings.
> So in the case of non-valid value in dw_pcie::max_link_speed, just cache
> the hardware default value from Link Capability register.
>
> While at it, let's also remove the 'max_link_speed' argument to the
> dw_pcie_link_set_max_speed() function since the value can be retrieved
> within the function.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 86c49ba097c6..0704853daa85 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -687,16 +687,27 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>
> -static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 max_link_speed)
> +static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
>  	u32 cap, ctrl2, link_speed;
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>
>  	cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +
> +	/*
> +	 * Even if the platform doesn't want to limit the maximum link speed,
> +	 * just cache the hardware default value so that the vendor drivers can
> +	 * use it to do any link specific configuration.
> +	 */
> +	if (pci->max_link_speed < 0) {
> +		pci->max_link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		return;
> +	}
> +
>  	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>  	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>
> -	switch (pcie_link_speed[max_link_speed]) {
> +	switch (pcie_link_speed[pci->max_link_speed]) {
>  	case PCIE_SPEED_2_5GT:
>  		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>  		break;
> @@ -1058,8 +1069,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
>
> -	if (pci->max_link_speed > 0)
> -		dw_pcie_link_set_max_speed(pci, pci->max_link_speed);
> +	dw_pcie_link_set_max_speed(pci);
>
>  	/* Configure Gen1 N_FTS */
>  	if (pci->n_fts[0]) {
>
> --
> 2.25.1
>

