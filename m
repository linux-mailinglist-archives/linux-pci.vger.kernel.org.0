Return-Path: <linux-pci+bounces-15220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DA9AEE36
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F40C28554D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CDF1FBF78;
	Thu, 24 Oct 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DNjszLHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BF1FBF40;
	Thu, 24 Oct 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791301; cv=fail; b=a6nutTozP+evt90+ZFjbYeheOj/y8EFNgb8AD9vGg5r3vr2En0CrCT3MbcjX233t2/JvFJm2idHCsa9/ixRCHhe7iCxmGXmEobFNsCcfddbr8rIZkcfjoktwvcK44hXd3ADzGuxPzwQ00Nr/Q5yH67FxApWsk3lIzEAy0tQSsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791301; c=relaxed/simple;
	bh=ggDMtAH8zEo4mj0vCiUJJPN8+wZqlpAmFQjT6LWawdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LWPR1l+fBkpcjgHiy05HQeJ7yGMsjsufyog8dX2foOw+33zEhubXRhJhwml5Aa7sZT24YMnPTEX4/pfc3YRYRz308XpcQsI/WAI97lXmWkTRan8XAgi8zOHOgKW5WRfru6N8Yl8ROQhwkS292z1U3+OyFaNeEjYN1B8gyNwVmhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DNjszLHy; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n58T77EaSVv/0+GptvcpTxoqcWPcVXpfK1AshFTjrMzuDLLuaCGyZeR7nouQQB4VoYF+pjLyAweXgJF006JX/wGTlI7soYZxSDm3Cn5q0IDzZ8sI5piztsLfh0L0DxZwR0NrW8Uus+Wp/VVoW5SlLT+43G1TDlP84U2nUzkErBG5QAXgx6+gOQbZLea1Px1iKtVII3hI0r4Kv3pFFAM0C7akZwPTfoLJZG5hxePqHw7Cw36S4J+Q9ChvFy0bcNhMIvizEjSmWX7LBsQJGGZ5RnpxnsukhVg2cJORF2d3h1oBWBh/Xhgcynl0pgdIlgrfXN0TXcHfOQ1aK54wxK/7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkSx8yYMb84ZzRG1knbKWT2yzOXAr6NaKa2U51NXUjs=;
 b=hmW4B31RB0tu7lpqD7OSwN9wHJvlO5iY+cLbuj31JljtGBs5HvTjnF2NEz2H9w7XyD6xsWoSmtfIYlv72OfqBm2gcv5YWUj0BKQ4wxwfIf29v1ReV40QGtG9gQdsIybUJEuDeulOWVoe/XzdPRPk8h24k1ofqgkqxMg+lvOaV7BKBIaLL790YVb5r4aY5flQt5BaXckUPgoS8/qnwfTZuIUyG5GS+/JMqn3yXkWplsyG5PEOeD5cwDuLrsZG+Fk+5YyIJFIRgIpk1C7peDJAby+jc1htHVzJtBi5bbDZf13dSzfinNWuS88OT8u8W6VXmajeiZALcNNjZN88fkgmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkSx8yYMb84ZzRG1knbKWT2yzOXAr6NaKa2U51NXUjs=;
 b=DNjszLHyCczFkRJ73RGmKvp07/DJXaPNjiUJQ69/MFx6h7/NRTvxPKFqpfET9rNHip7LAwmb/yOQ+JOAHY1CZlc/DMuErRIYNdCR7GebXcvs0cRlcpxusMIeaPzmnHDfEA+EPBLn3ZCF6c0ft6FHstZRBN35EDmGZFbxv3HEDMFx16q7y40eniYrgp8Pl4EIPWz4eY1j01cVsEkStmAMla9/XpmQvapbfnUUbClgke6HAM0XVtB9QZa9PZ0ep86EbNY7udHAuS47lj5l7VzyEy/bi/88XW5KMu+rBf6S5KicDLaV2cJGfyBOgKSClu/cVdtUCdBo4FVgEE6kObvhCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 17:34:55 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:34:55 +0000
Date: Thu, 24 Oct 2024 20:34:51 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <20241024173451.wsdhghmz4vyboelu@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-7-wei.fang@nxp.com>
 <20241024065328.521518-7-wei.fang@nxp.com>
X-ClientProxiedBy: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 88773a63-59e5-4791-d5fe-08dcf4522ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAXCU2WiDSVVWd0JYSvOtWj2lnmrHQ/iMbenJ3hjtRhz0+EG2gQ3cm44SdMw?=
 =?us-ascii?Q?7U5sjxOzGIG1irPyX1eGyp/N4zQI9+H8DSNtpVj+wj6tMBsslTz4krOSaHKA?=
 =?us-ascii?Q?YNtqdIzwOhc0Sfnt3ataEaJj0OkGzHvW1ftda7YBh8jtJAdhuglhkQOAMnTg?=
 =?us-ascii?Q?kkOfZTW9rXwKKiuh7uN1ElWII7i5RofX6jCcn8ufcE3mih6JkezOnEhGwapI?=
 =?us-ascii?Q?bHNmeOgDCBl+7JoV6hlj0qdUHIvFPif0GCXxjA9RkvBhIJiLaiEfqQVZKP+x?=
 =?us-ascii?Q?UfzI/4rw4QhDrRhYYh0p+HnTkacb3h3yW2jvu4FWvr/0pAiDyFzZMYR4sFRM?=
 =?us-ascii?Q?5B/MMUA2+jYREM54nC0UO9eLeHtK3ll8Uu04r6/yTF7UoNRIYCi+gEDJlmog?=
 =?us-ascii?Q?CqBwH1pqEqPqIJUDdBOy00qMLW8GJdZP5H2zGSvf1cgnT5R8zUEaqdpV6H5X?=
 =?us-ascii?Q?K0GLyka+aMhprphYtDzR/h5e/YOCOQLJ5gKBmgX7Zu2EMxg1KDJM4tNaDwcs?=
 =?us-ascii?Q?qs2OEcyowFE+1sJ2OyZy45vg016l3RNlONrTmrJJEPCAVW8q+8/ORGVKmk3T?=
 =?us-ascii?Q?5IG70kFShkOvM+qe6v7hYz224BUdzUjwk2ea6TJKAy16KW4SqMp/0FKrjtml?=
 =?us-ascii?Q?NBsObpwlytQABiCrhTncUiV/bbe1VSj65OAwrhs8y6vWVxn48xnKRMwGwPue?=
 =?us-ascii?Q?nZGltkweNtjYBZbS5tTZazpDFV18SDjbkZ4XPD5EsuBSFdHKZxy69U/hAO+7?=
 =?us-ascii?Q?f70+GGWND54FrLYxcY+LHXxj1sXqERRwnj+oSqma4EgBFWDgITbNODBOvlPw?=
 =?us-ascii?Q?04F1q3xsm3RQ3h5qH5mUZDiuLxwBK8p68B2U3jtu8rtc/hRRlGnies71WqgH?=
 =?us-ascii?Q?7JUDXP1YuOVjD7SfKa83AT3Q9J/0UVBMlssVxctbNhhriiVBIYOJHoWuNvM0?=
 =?us-ascii?Q?h8e2OtbOiDjdC0RR96PgL1Y4w1ICp9TwJXCZdVkIJGRouP0ZHRRcZM2nt3nL?=
 =?us-ascii?Q?ChJDytfJAdUv6dtn/S0bw6Q7famcDoP32McaibyteMuzzo6V5cTQOu1j3h7E?=
 =?us-ascii?Q?PCaFRdgeV+6ZaxQYBgP5GDl5XmZ8jccSws6YH7pIoCifNPQM2XF4voK0Yr7E?=
 =?us-ascii?Q?U5RiFnmr8Y5zqmLcZgqHn1sBL+Q8sYxQ0vO/ggiNAO1Qn9BvWVcMz5YXEj14?=
 =?us-ascii?Q?HL7Oc3IbJCkdw8PGb2Yy98UbJbmfKaWAKlh2X0gtF2OEgUL/6zcmUfyGz8WW?=
 =?us-ascii?Q?h3Xsmd3EvnU2PkW33l7ddpiJV/z4A7bd9O8/CYYP5LdBs+m/C8aRVSHSLAkn?=
 =?us-ascii?Q?vVVl5rlO6Cz4xbcKzMiqC7Gf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAK820qQh17ETc4TMOtxYKLSdlHuVn1tEeI5RW5X7VYplxaE0VxDAnUjKaEv?=
 =?us-ascii?Q?wN+wnheAzwqMJUhiqkC0fl367hzFAuyFO/IykRuiWPlzoqFGhzLp23kuEOGr?=
 =?us-ascii?Q?OYibJeD+efJVCG+jmVzSEgnbcksGVNtZP1DpctLUwXXlojwVvo1fzCXOnrvl?=
 =?us-ascii?Q?l9WSxC0lU7KreD4Gwe3cSsVBbQfubyDPI0O6CSbfI9mX4d371lXBjgGH9E+Y?=
 =?us-ascii?Q?KpNiAAZrgxctJ8CHIRFCE1+Ou52ETK1lxrIyB32mq9SNEPego6btF6DZLLAu?=
 =?us-ascii?Q?jhjDFgg4p1IKcESvcfJBlf+QQWitcexGSwHBjnhQp50hCWu2Zdl4dzh+R5Tj?=
 =?us-ascii?Q?nc02dLaxizyss7jDq7iVUmmE/FAxWVk8eYKgI8hcs4jjl9PVhxMAiKSKqGy3?=
 =?us-ascii?Q?BQNHHIpw6ej5+PexzOSzwfgKV42H9bJ9zGrq0qVTBM0xJrmnf1/WsC3jBiBQ?=
 =?us-ascii?Q?U0re/GSZeijGcW+nxFndTUcSWgsUOxd3H31oCA+yfkKzRIoxQrgASi+KI41j?=
 =?us-ascii?Q?RM8C5qgk9rUy11eQaOzm/5Cb8nJAQCAC1eS52JNLuZ4hLBqBieVwDHKCbJOD?=
 =?us-ascii?Q?cGvcZdNqY0nfti8V2NfThMEIATsVM3LqXjEgDZoSEuB9loBYdFzmvONCYiiF?=
 =?us-ascii?Q?AfhCA3BDLAR0KmNxYaSdBGnV+cOMZ6kp5S0k1eJhN1iX34970xeeDodAUvCk?=
 =?us-ascii?Q?G7ECd4/vuwDoiJzyv21ZwA0CiA202k4KO6i54dJdSr8OdRLaDcH+dDPrnH5J?=
 =?us-ascii?Q?qD1v/euuOuJC2FGUYEni3O+iSsVy+IKawLuQAcVKs+5DZf+K6C/agBD2J92h?=
 =?us-ascii?Q?OcmDjJEYK5fLFKnBywo98SEF/YrWCHabmQHLgzopIOa3X4gXchmLN2zrZqMM?=
 =?us-ascii?Q?ElIjWigI/hej1qHywP42cx8Gvbs2nHXi+cEBjGpxo4T2TwNVqWADyQEsvRlJ?=
 =?us-ascii?Q?uwtKuOkVaqoB0oNkRCo7/s25dIwy+bR0Lbz/BLdHC7ZGDnxonlTGCPp5GYc7?=
 =?us-ascii?Q?Cc5Kl9PhCW0XETHTU4UbZj/wuCIten3pw2fw5F65/aqUtsH1oCJ3Tbh4E63d?=
 =?us-ascii?Q?UXGE6CgwsUzz3UymqdhH4OlIhNJr4OQ4V2CCox6NwWnRYyzMlmz3lH1CtXrL?=
 =?us-ascii?Q?3D51WNpqpnApywTOqmdYIGDR4KA5BKcRBfp+17mXiSzhYK+iBQoxU36CpA4W?=
 =?us-ascii?Q?ArL7FAb2r0WsImLATaUlpsemKUBBrm0+1KxclC0DJ8xSqzX1qQndkMM+7kEs?=
 =?us-ascii?Q?mW2oe68Q4f+d0z58e/NijoXeT5NYTt0aFTn5indMlxQi9cDUIb6ogQQEtCYz?=
 =?us-ascii?Q?lDXRZT0YOkojO8rYscjbxttGnazEV8yS0YC6ko6H7Rlv+o0qKF862rL0NggS?=
 =?us-ascii?Q?tIkMiLI2juTZXeSnQffJmPlWtRQzUrcZ+EYPteMy3e2GACwcZvBjeOvy6syL?=
 =?us-ascii?Q?5E18k/ic+mKLaFeoMCaBQnk5AewZJat/b+NfQF+vKXF4C2RFM4TNgVPIVyRP?=
 =?us-ascii?Q?bEVRA23GDMka2Yppqj34YP70cj6JjGD6M3nvfUnU+kA8rJC5e8kh73AL3po0?=
 =?us-ascii?Q?TmEm6lSue4p6b0QPLnXLHPvezHWt/iBmswzME9na4ZcDEibMm2cGdOJ2haMo?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88773a63-59e5-4791-d5fe-08dcf4522ca0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:34:55.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JZovbar6ifKQEs8N4uhjSetWX8CAOtCi659Bl43CTOlgUipNUY1kBCma5upbz7dxwxv6O36lkTNkOMKpjUlwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389

On Thu, Oct 24, 2024 at 02:53:21PM +0800, Wei Fang wrote:
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index 92a26b09cf57..39db9d5c2e50 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -28,6 +28,16 @@ struct enetc_vf_state {
>  	enum enetc_vf_flags flags;
>  };
>  
> +struct enetc_pf;
> +
> +struct enetc_pf_ops {
> +	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
> +	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
> +	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
> +	void (*destroy_pcs)(struct phylink_pcs *pcs);
> +	int (*enable_psfp)(struct enetc_ndev_priv *priv);
> +};
> +
>  struct enetc_pf {
>  	struct enetc_si *si;
>  	int num_vfs; /* number of active VFs, after sriov_init */
> @@ -50,6 +60,8 @@ struct enetc_pf {
>  
>  	phy_interface_t if_mode;
>  	struct phylink_config phylink_config;
> +
> +	const struct enetc_pf_ops *ops;
>  };
>  
>  #define phylink_to_enetc_pf(config) \
> @@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
>  
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr);
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
>  int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> @@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops);
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> +
> +static inline void enetc_pf_ops_register(struct enetc_pf *pf,
> +					 const struct enetc_pf_ops *ops)
> +{
> +	pf->ops = ops;
> +}

I think this is more confusing than helpful? "register" suggests there
should also be an "unregister" coming. Either "set" or just open-code
the assignment?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index bce81a4f6f88..94690ed92e3f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -8,19 +8,37 @@
>  
>  #include "enetc_pf.h"
>  
> +static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
> +{
> +	struct enetc_hw *hw = &pf->si->hw;
> +
> +	if (pf->ops->set_si_primary_mac)
> +		pf->ops->set_si_primary_mac(hw, si, mac_addr);
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;

Don't artificially create errors when there are really no errors to handle.
Both enetc_pf_ops and enetc4_pf_ops provide .set_si_primary_mac(), so it
is unnecessary to handle the case where it isn't present. Those functions
return void, and void can be propagated to enetc_set_si_hw_addr() as well.

> +}
> +
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
>  	struct sockaddr *saddr = addr;
> +	int err;
>  
>  	if (!is_valid_ether_addr(saddr->sa_data))
>  		return -EADDRNOTAVAIL;
>  
> +	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
> +	if (err)
> +		return err;
> +
>  	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);

This isn't one for one replacement, it also moves the function call
relative to eth_hw_addr_set() without making any mention about that
movement being safe. And even if safe, it is logically a separate change
which deserves its own merit analysis in another patch (if there's no
merit, leave it where it is).

I believe the merit was: enetc_set_si_hw_addr() can return error, thus
we simplify the control flow if we call it prior to eth_hw_addr_set() -
nothing to unroll. But as explained above, enetc_set_si_hw_addr() cannot
actually fail, so there is no real merit.

>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
>  
>  static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  				   int si)
> @@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  	}
>  
>  	/* (2) bootloader supplied MAC address */
> -	if (is_zero_ether_addr(mac_addr))
> -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> +	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
> +		pf->ops->get_si_primary_mac(hw, si, mac_addr);

Again, if there's no reason for the method to be optional (both PF
drivers support it), don't make it optional.

A bit inconsistent that pf->ops->set_si_primary_mac() goes through a
wrapper function but this doesn't.

>  
>  	/* (3) choose a random one */
>  	if (is_zero_ether_addr(mac_addr)) {
> @@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  			 si, mac_addr);
>  	}
>  
> -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> +	err = enetc_set_si_hw_addr(pf, si, mac_addr);
> +	if (err)
> +		return err;

This should go back to normal (no "err = ...; if (err) return err") once
the function is made void.

>  
>  	return 0;
>  }
> @@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_NDO_XMIT_SG;
>  
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
> +	    !pf->ops->enable_psfp(priv)) {

This one looks extremely weird in the existing code, but I suppose I'm
too late to the party to request you to clean up any of the PSFP code,
so I'll make a note to do it myself after your work. I haven't spotted
any actual bug, just weird coding patterns.

No change request here. I see the netc4_pf doesn't implement enable_psfp(),
so making it optional here is fine.

>  		priv->active_offloads |= ENETC_F_QCI;
>  		ndev->features |= NETIF_F_HW_TC;
>  		ndev->hw_features |= NETIF_F_HW_TC;
> @@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	/* pick up primary MAC address from SI */
>  	enetc_load_primary_mac_addr(&si->hw, ndev);
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
>  
>  static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
>  {
> @@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  	struct mii_bus *bus;
>  	int err;
>  
> +	if (!pf->ops->create_pcs)
> +		return -EOPNOTSUPP;
> +

I don't understand how this works. You don't implement create_pcs() for
netc4_pf until the very end of the series. Probing will fail for SerDes
interfaces (enetc_port_has_pcs() returns true) and that's fine?

A message maybe, stating what's the deal? Just that users figure out
quickly that it's an expected behavior, and not spend hours debugging
until they find out it's not their fault?

>  	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
>  	if (!bus)
>  		return -ENOMEM;

