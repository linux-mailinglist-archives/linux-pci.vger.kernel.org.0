Return-Path: <linux-pci+bounces-30119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A99ADF596
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA118982A4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2113085DE;
	Wed, 18 Jun 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+sRPUQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836A3085B0;
	Wed, 18 Jun 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270450; cv=fail; b=VifIE/TP5Ciq6QqSmajqS+9EQ4O6G6+EspEiDZkwB8q08t8jJE80Or97x9XSgjYkI/f4uZim37VUjCdS7sfK9l/JaUXnIuwhlNIONNPVD30egFDZv02ixK8cvAs5wzj4JFt5y4VkYJWnUxam8FzENaH162LABJREikcGsydbtek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270450; c=relaxed/simple;
	bh=qKsMH5zz1G0MlKcaEdsRuR6TJd4NA8JkV6aLGU9o9fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VpewJfZtcpNmyNwhh/fTsJ/IA/wk1Rgan9YjewsuOwlLqOE4tPmmeq726tOyQTj9RvimTNvkfyy9h2+jl8SxXpyMCQNNW/6s6eDPm+lzL9vhoV3W3KMRDA/RGD81K5xPovOMT9XrEv2d35V8rhyJ7Y+C6Vlz9KPljNsmVGW649g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h+sRPUQH; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhGLwGfp5Wi/ANc6t4i48MAsOLHeWybk9J17E6DbDThzy260hVL5KL5xjciEBi7/79EBYKlmuj9DxJz64MZY0dwc3yrX7e4iQBymESfbLuJ79X4tWyVyJt9XoHbZBfWPyB5y3Rvce86TlmX/zrNljwKpl1f/XLx/vQbhujBp0qZsDRpVQGpZEPXcZJr4n2orUQE5A+tu8dfayuZx1Tq8goaNfUPYGB4RMVbhJNPfgGHePGbedlafwxw/r3CsBFptJP1U5bpaYeGtNxusP+PtI910V4jidOIIMMbcJqWaKIre2tCngEMeXWml6vwJaje+bD1kRk4uJJ4PmmCeL2HjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYDTrR8leugtJ21GtmBuJWvix45VJ1KUfu4CdHOIil8=;
 b=JQrzg85AedFt2bGaljAvHNkRLouhg/E7kmWV0m7COPuZkKkETnuOeuM4h+zCvo2es8vdUlkYtB3zT44BVvjUsFTZhgWWpJVfNFDnmxhf1a+MbS2pIJqvhgFbS5KE3jn0Z1NIOQzyScakjsHC5LjkMjSMz2gp9yjYbIFppqVkfKLLUpVOSscQZVOAczaHiMxjrzhNDP+Qmla8ifjOo3G67dNlQa1T0ovHTizXEF4n6JbLuelfSYIlqQiWM1lBkLCQsaqQO6SnaXZPuT08UtYLtDHa3/fXW1Ia05P+qYhkvSVc9xKBfkGltfKF6PNjywhLNxPyNJTtkKt4Q84iKWgSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYDTrR8leugtJ21GtmBuJWvix45VJ1KUfu4CdHOIil8=;
 b=h+sRPUQHGyUhTsE2ctC584nFcF1v2pSYBpvgCJ0NEeN8fOqOkZj+ogq+mBnD5q0jXoLru0Nc5IbaiwOBSsTXtRKoZvUyIEsJPqRlcvZt1Kks1B1+9oQOj8SA/njE/lx5DT6f1qb+2gXNVf1iEotRuVCVMWO9HCIdfdsInLGrD1ovjY77oH8Qo1lVPZorZ5ye7jrZxUtZLC+8zPt2swIc6LBUcXHs/PGj2TDDtmELDh3y9pBqzHBRLBH30h4EIEMYYjsfuJABX0JV9Vjo7zg4MDbpcn74ZEBHSAxOGueujN7e9z98crMfYIs9TnTqj/Tc19FxEtMQkKR92G/2ntxDkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 18:14:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:14:06 +0000
Date: Wed, 18 Jun 2025 14:13:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Enable the vpcie regulator when fetch it
Message-ID: <aFMB5ib19TYabeH+@lizhi-Precision-Tower-5810>
References: <20250618082042.3900021-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618082042.3900021-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e10aca-3ff8-4e86-867a-08ddae93e98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AaQJP33OWCjBhwRz53nIYsqOS0zH+e/DowDVZbxIbQqipDXGpObHAF1UXoOI?=
 =?us-ascii?Q?ARnQSxdU8Vs6De1giOWYypTSVH9sAUGOCxY9uPa9SkD4i0ghmkDYAqZ3gNm+?=
 =?us-ascii?Q?ePo7uWqKe7cwdrtnAwvd1b0HepmOVVJQ3R/5NDr2fmFybduRI6NXHwFaHqDd?=
 =?us-ascii?Q?z8pxjVW/kLGDGO9ssVedhdvtYaTrEL/uLh16dcILV0Cd7wjwQixDid9KX6j/?=
 =?us-ascii?Q?mIhmOJVyBIvzteG5tUySugVuAlzf5AxgajUiPyBhDdGoB0jXkmmdlRayV3Eo?=
 =?us-ascii?Q?lPO2o6NFrUiEf+ANKA86GklK3zVFjrBY1Wq9gPcJmoUK5UwKSaliWyyFyndW?=
 =?us-ascii?Q?91bgo41/tJKepzyi4j6ZGWx+eKlLOLnuTZtCPRUxWujeUtvyrOiioHQgl/+X?=
 =?us-ascii?Q?gw0Ippe7NjpfJatlUeawZ6opS96FePm2dT84Etr0m3u0DvFDDMD4W0ZQXiQX?=
 =?us-ascii?Q?0VtrHMxKnD0KTeYxLq/9w9NBWvXqIiYFtL/HPYtx5S8Sc0NcE+SBnxk2qxWa?=
 =?us-ascii?Q?NHpfXlgmTODfkQaaAAIBQDP5q96G+dZHLTSvdoizLvmIqU5KvEBWMV1NJIow?=
 =?us-ascii?Q?VM1uONFzCSZ/5x4yyZSTg03eANSZRZXzFgp+v97iZ2t6Vu2oEkfYAcxxIEIX?=
 =?us-ascii?Q?TvVexH2V4eVq3/51su6RgYyKFVEKMzu2hsuxzfKZa2EtHu+nWkqaGI0b7fKs?=
 =?us-ascii?Q?RURPkC3dJrXb+rJm25bBNt1QSPFVkkfmkPi1/zFwT/ZEibac0K/1Y506iMA5?=
 =?us-ascii?Q?kFKFVWMPL05fAznarjtU47hFJcN1R37k4minCX4aYO/4gFroVwCLea7fra72?=
 =?us-ascii?Q?Dt7cf7HN5vrySYofvgHcuIU6O+1LD188gyu6ocitzjJrxiM3DVOL65/nyUs1?=
 =?us-ascii?Q?e2IjMS+LwV+s58OfmPJFDUiZQQFehFD1LZwUK09xj2uujtq3UuZ8Iy5EOkCq?=
 =?us-ascii?Q?EP4vcBBwDJxFxAA/lrA1Gpr9RUaHOXrtBeENzn5aUfTR33RTYIYx1d8scJAd?=
 =?us-ascii?Q?Lau5svOJnuBW4vbiKpFDpAtQcXaLyOZe5u52yWg620gcfLiX+6X9sj0xcScy?=
 =?us-ascii?Q?80ExeR3J90Qd6Hpj+sStUHHa93QG/odt5T6zft2Qy+cC949gTJSaoRWVeyLE?=
 =?us-ascii?Q?icmOjdOjJecN5Y/wTDZna7UZxL4OgeIxv48IF88YdSvKZizuY+OYD6whIKF2?=
 =?us-ascii?Q?/eJOmJNX6qyFiriACp8wFMUFQy6dCT3qIH1TnRxx0uLYdI5WiKlpoqojeZbU?=
 =?us-ascii?Q?sfmhy2PKN4Z1MoPdDILKcWFja3/PLDTzF8MYjwpCA+bbm1UDXFfTBNJYYbhf?=
 =?us-ascii?Q?nCG0dQFyx/ihxI40vPgrSGtIKXU2RWDyJQjONmeOPC901bJqaAN5znX6GD0Z?=
 =?us-ascii?Q?1vAEgYN77cRkDfELrHmCnFK1/MxG13DRDo+0cLAmntI2MQVazfWcLg39oY9Z?=
 =?us-ascii?Q?J9h1mOjgrR5Z/mymLFWKA7Gario2w91AF1z/PgGPwAaKI4/lmilXXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKJsYByIYU82wL9hHHrXiOzxtCp8t9J15IFYNk54KxijsnoHn6+lOJn6Akdr?=
 =?us-ascii?Q?LSf3DKskBTQb65/DBkhmC7Tk1UQvqhLjOwVMP5dwicUpSdCf/9KTwBCJ8YQJ?=
 =?us-ascii?Q?el3PSaKxfcPm8ucTUAgKQthZ1fknznUmP4KlGCwSfWa2r6Mku/dhNwUWxHWe?=
 =?us-ascii?Q?BEuia/g2qvX7JkR9CldiJ9Y1kEbTCRAt7Olp0imntWYpUHItIjSxsYVlpu5J?=
 =?us-ascii?Q?J+Fpvarp1Fd7XmJzpFLvCDMKVuipN+aQyVh0X4NL4MxzQnPzTrP38XemN/7u?=
 =?us-ascii?Q?DfOcutjuxYS5ccJT8cRtTp8Y+btuI/8rhEiaVuLnnWUxy1hrB1AKZY4b8ooD?=
 =?us-ascii?Q?bWkI+Ftz27V49/tUTFKPia+O/SFF01RgneOummeOAtt4SDRNTONBSnxtB+sU?=
 =?us-ascii?Q?sg10J+jnIIOauTZjtb7PO4LQBuBynoLLt1caoRLF8+Z8XWJHQQryxNgMH4mr?=
 =?us-ascii?Q?qr3t4EPe2qyqqEL5frVKkKfasQVcHaVIwsmVGNpsalVTMzBSfKtRW+R0dzlj?=
 =?us-ascii?Q?0MEeTk+mLOGYasMSuEg48PIZKrwuK8YSudDUQvf1nMChrBoO7vW/wG5obS8T?=
 =?us-ascii?Q?1scGk51zsCLdc4S1040pzLtvUQSeKQGvxFUD3Yz0UzedGE/XNE2HG1XdAyOt?=
 =?us-ascii?Q?P78jyn0ujbB/MWXeiuibiqxJB5iYY+lWmiCzO0cTSVhL0Go/4/WBS/WxTOef?=
 =?us-ascii?Q?eCPdpL8vTUpPCbjG1iV/BwpDJIyIOKnJ064+V/Iga9VzoAldFlzbnYIo81xj?=
 =?us-ascii?Q?VCLxxsPX4CubADjisc30ARG+qSy+q0XfZugiX6wQa6xVxbbut2EaeoUI+11p?=
 =?us-ascii?Q?U8OHlP2jmW5oi5Q6uI2EbNIVtlMamlYT18OvRUmRXGKZ3he/NFqeMH53OGnO?=
 =?us-ascii?Q?1ajV5VSbHf0ayfv5TEqQ1elMNYKqE1yUCjmGYiVBlRUHmpdcLedcpwcCWqEb?=
 =?us-ascii?Q?Qp+NloF197J4UocKKOPINH81Pm2C4krtTwdNadgmXQks3mo7vYjR01s/E+V3?=
 =?us-ascii?Q?8jfny6sPs74UZRKmbM3iqy2Q01cQ5m4ECko49jp1Y3e7y9XGiZ03G7wyIkB+?=
 =?us-ascii?Q?0pbfeCNJxUDS1A3QROu+83TiSvKg8SZBEX1Pt/7j0YnOHMenGofVJx+tkYbE?=
 =?us-ascii?Q?gS4i9c0EKQQ+YcseMWQU8zgCBqiI1AdAc+4h6D1RFHbi7/b5QppCILHYFwIi?=
 =?us-ascii?Q?YKXrcrOPiZk3d9cfc37WAIUGHQwZxMAQ1F2G22LMaTRk5ExyTpu80ruXEcEG?=
 =?us-ascii?Q?pHXdKcn08pksjgR7p34LRuCa5tq+pVZQz8/LZdYvloElDaoqNJ/lCzJ8kB3Q?=
 =?us-ascii?Q?oWa9Unk+mpVM99AjOKz08MXbTGVATU50w0wqdQKL8tSSGJgEXWv3u+O0hV/O?=
 =?us-ascii?Q?uVGrs/zfe0agUfe/HeCTXRN4+bXdLM7qbYA3R44bfhQJjU+uRsn+9mGCjg+N?=
 =?us-ascii?Q?cJovNdlk+jdxC9jTa6qGrYp5E1GR6xLS4sRImixJbnMIpnZr8P+RSLcmpfSe?=
 =?us-ascii?Q?W9z3aUeAv2Ynv+C6OqDD5ujVvHEdEgsgl74EpYnpC2NMEh+d/yQgqCDohGQ6?=
 =?us-ascii?Q?voeNIt1GVVv1u0J0WNHp5T4VdE7pDYClx1+ynBjQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e10aca-3ff8-4e86-867a-08ddae93e98e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:14:06.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZkcKr9Wir63FtO+F8qB8WKvaiLmxNxqvReC7mGxzrF7Zbl088bzFrJjbDKMBFO5dNROLHvVq72YoWf0tn+gTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

On Wed, Jun 18, 2025 at 04:20:42PM +0800, Richard Zhu wrote:
> vpcie regulator is used to provide power to the PCIe port include WAKE#
> signal on i.MX. To support outbound wake up mechanism, enable the vpcie
> regulator when fetch it, and keep it on during PCIe port life cycle.

how about

Enable the vpcie regulator at probe time and keep it enabled for the
entire PCIe controller lifecycle. This ensures support for outbound
wake-up mechanisms such as WAKE# signaling.

Frank
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..7cab4bcfae56 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,7 +159,6 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> -	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> @@ -1198,15 +1197,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	int ret;
>
> -	if (imx_pcie->vpcie) {
> -		ret = regulator_enable(imx_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
>  		pp->bridge->enable_device = imx_pcie_enable_device;
>  		pp->bridge->disable_device = imx_pcie_disable_device;
> @@ -1222,7 +1212,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	ret = imx_pcie_clk_enable(imx_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> +		return ret;
>  	}
>
>  	if (imx_pcie->phy) {
> @@ -1269,9 +1259,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	phy_exit(imx_pcie->phy);
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
> -err_reg_disable:
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  	return ret;
>  }
>
> @@ -1286,9 +1273,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		phy_exit(imx_pcie->phy);
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
> -
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  }
>
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> @@ -1739,12 +1723,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
> -	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> -	if (IS_ERR(imx_pcie->vpcie)) {
> -		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> -			return PTR_ERR(imx_pcie->vpcie);
> -		imx_pcie->vpcie = NULL;
> -	}
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vpcie");
>
>  	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
>  	if (IS_ERR(imx_pcie->vph)) {
> --
> 2.37.1
>

