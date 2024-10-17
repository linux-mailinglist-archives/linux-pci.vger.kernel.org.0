Return-Path: <linux-pci+bounces-14814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28E9A2903
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F28B1F234CE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB81DF74C;
	Thu, 17 Oct 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PYyavfL9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4F1DEFDC;
	Thu, 17 Oct 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182895; cv=fail; b=OEmSb25wGoq0zvk4/fCVvSTsV2vDp6B8NKOLBISh8cg0+rxkwGYLvI3MDAZx7mpIIv0TDn1xIahLtCzyIt7Ggm4RIO+/2g1erxCeG+NXJHwmBBoWYMTMk847EV3iklLydqEQZ3ci30CPuPUBS3hvzFs/IaD8MU95u1TYmD56jd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182895; c=relaxed/simple;
	bh=nztLBXvlxlYWbfRoPZhKqq5CjWM3059a8krkM+h/6QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eaajrMHgMblT+zZoR3J+Rguz7NjowMgVmuMyG45qwAXADJHH5ZdL80ZOkDHiwewj+WkmayHlFGdqlR88pYSrtX4d0Y5lc91URZjRqSQzc292PNWxS9sxHbAP5F/jJP6bPlAxuaYlVr3NZ1tPUODk9eCQWt3nlq9siLX60I0hsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PYyavfL9; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhZoTjvdsZOTZwkqsapT0Ex901a8B9M2dKcFwxdul1lt3Xt7bBKuITpmwWBfreIEkY6xTHc+ZiOxmc705VDREdOdAI+TziywRbTN1r5p7HHkNVNk5gB4qAX2AvS2Kl53ILFqh5rQvMjU4Eg54+kfJIRpUivi7oL/PEPK7zVUBOhywhw2M1pCgT/gXTo6hjUFJX+OdES1eqxr3Bf/Z+jCUoMen+R9ni6TJKU+PBgvkH1rk/9t/725YUPc/pvdEcjdTIedduwqT3d2IV330f54GRS1t9Gws3EICXZDARnqujboc2nqFVaTALO83AkXVf6mRYB9ghbpZONpazrkEXJPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO0aXXLHg9gPStKo0dPFy+YwCjmcsGuayBH6rYi0GiU=;
 b=hZFUFY+Zk+KATjFb2XKpeDT35vN2aslaf4WB3+ZfnFbKXVGgcR+3FcTikgFMgp+Q4bM7Iw7BAJX9aQUJDDSSd14nngdBg/r2ex7nQz8nmV88g3P3ENk8wZxIgvW75RJJ7niG1OWlOKrEcjozZcly/oXLaB5hoecyEQrATP+oUnGJa12d+ZQMtUEjwp0mfW4ZXLca3bhmX6BH7CA6YcRsp00L5hM/sA5caRclpNcEIfrTukTt3ki7unhvv4UfcgL2Ot8gS+s4DM3l4wV1RSXhZY/tIDihBH/nlemFq+fhaFYhuI4N11LI02zve8l3RHep3R90Xd4jdeE5fusGos/vTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO0aXXLHg9gPStKo0dPFy+YwCjmcsGuayBH6rYi0GiU=;
 b=PYyavfL98fKv/kRU3Chb1nGbfH3bDoHAgSPw9fwfwCHwXEXMY88wcEI3yqlYe1p8qpkvapbBfgmcC+Ea+VWMfCsGwy6Wm42B9f7wwpwPKj+dlqI6EIkQuVuSLv9olRdP156qbJprG646cU3KYT9Cfk0WLmsdI14bnXdRhPbixPuSYVP11MHdRXz/+6KwV9Ef3sAoHYRzH6ODyZuwjPf+A4j00ujQVrUFsvMzA1n9DQ+Z5KvLHw2vKcTuVWx4PdjIt37TKCy4Wh+Me2fV+iyNr0fmWq4x20xst+7SUBxTM7YDf2ebowc6kAUanpHesbKBND7uB/nridHxtT9qZBWadA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:34:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:34:44 +0000
Date: Thu, 17 Oct 2024 12:34:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 05/13] net: enetc: extract common ENETC PF
 parts for LS1028A and i.MX95 platforms
Message-ID: <ZxE8m6xs0QpKuPlq@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-6-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9945cd-ec9f-4520-2e28-08dceec99b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GbVHH0nXRmP10OyqT4glFodI7gFQuDiAWKndFs3vu36k3Ohrzlzz/UQ+pAoU?=
 =?us-ascii?Q?E/roKQTqUgIfsM1Ykd6jMMZD9hrovuONI6SPci/2k24eegRDzZY8ydMy182r?=
 =?us-ascii?Q?4LNikpHvGSRhVswkDQaJKeZ77UcpugOhQA9Rmt1rGlEb8UYvXo0YuWpTSxKI?=
 =?us-ascii?Q?OHrcO8sQfDWelne7mxz+7riaDoKvyG/AluClGAyVGhnfAodebJ0JA+HCtvP/?=
 =?us-ascii?Q?KkV+a6NGoM+tJgTjFSzGrPuhK5PREFE1EYAOTc0tCkrxz6XLAjs9d3CrBBFm?=
 =?us-ascii?Q?v1LejCZLQcEq1FCTkNBbJ56LPwQgtArPw+2hAD8+tAPzYSegKVm4ulMwadUs?=
 =?us-ascii?Q?VBT7TgVE78sJZVYFFTHQ+WYdoM+WAR51b5dog5P8yTm+puhX2F58S2y4mIqL?=
 =?us-ascii?Q?CDLz8Cc5SLvrRTUKKxfzCwlLcus84sdzg6b2R8CYqJHcjcvYgcTZh5QKn73j?=
 =?us-ascii?Q?hTo087BKVYyHG4PSx/vjRHPVRHGulLzeCFVzPwbY5ti5nfHxFHBxhU8wKWdt?=
 =?us-ascii?Q?zjUmcL8FqOgm/4cEpK17ZGpAHX26U+EnN/IWqxsrgxSiBIVe1+TmCY3BhhTq?=
 =?us-ascii?Q?4qMsxXkijPI5D9Qak6XAan3FLE70iPPGNYNBOIMQdH/+1oRxy3Js/Sd6wq/i?=
 =?us-ascii?Q?wUJxVWGAaEQyjdsBNHAGyMmhff1hlG1bgPD8fyvaAcjLP3EoV7+g97ebzsRg?=
 =?us-ascii?Q?9FgE/4cM4X+N1VkD7eHi1rcPx6NTOu/dNaCYxTzoDIF43nbBEzgGX0yqzYfd?=
 =?us-ascii?Q?XSE5r4tOr1PzcaennJIwg8qkeyzzgeFTH83J8fei58u5FagrgfCaTnzTxv9T?=
 =?us-ascii?Q?3nIkFK2YxXBGDXreP/mVHi+/9JslgRX7o+34422WZhEKjXPaY25q/5SeA4qi?=
 =?us-ascii?Q?b7CwjnZjqW6HvfZgwoedyGy/DPxRV1UEo82UpP/EFpFipVmxnvc0e6GPGoAj?=
 =?us-ascii?Q?qRKL0CKA0xR9CnY0LD/u3foDDubnPMOrPgxGxZxDSzwjbf03YAnpmLWVEY98?=
 =?us-ascii?Q?Otg0ZZ/aYeX+cG/jpTfViWYTcZhC4a8ZczNyLGMlVYPKzDlr8sd5w7TLrs9R?=
 =?us-ascii?Q?65aoRTzfnokA4N9xYR3oznSC2LgBRF1CesNz+e9dCqooBrYFxjgTZvC6w/yl?=
 =?us-ascii?Q?U96bW9iFZCqtW2bIMYsaj/uUb/giMQQrhcQfe6X05pGhHJWnnWOLA+IWlgQC?=
 =?us-ascii?Q?JadYaz6RPSETJnKWwMufc93GavsU26r+Ia08/cdPyxZL5IzKQ96s9159BOgm?=
 =?us-ascii?Q?unNo6n7IKNDuASUCOv3QyRnaDOoP+kNUQFYT2HVyIsZQPJinSumMXAzvTGRh?=
 =?us-ascii?Q?IpSndj2DmG2T7kI61mRfqQSljRcqMjvtItHvi1x8txGfraDzrZwrTf1PvNte?=
 =?us-ascii?Q?zVFhLfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4SthCWvDOimqE1mWCSx72HxGMTDuZSYos6UBU6/RMPCP3zMw6uCmKQFP/4B?=
 =?us-ascii?Q?QQFhs4Cr6utD1NOIN3QUWA+RvV3KrUqz24eOERn/hQn4lC5KOPlF5WKsWcYR?=
 =?us-ascii?Q?gOp6hlNAtn4P7I8E0BmNeyh/3z/34pMn63wivOn8DrSuO/QgACDw1Xox0hlb?=
 =?us-ascii?Q?j/eejs90KK8A0pUZ3yye2aZygZfPsZMJOs2+quu8WCfVdZbQ4csPvXeJ81dD?=
 =?us-ascii?Q?m/cM3WGy2cqUIDxWBFc5EWUwSTmj+4D545AwCKt8ShnfZmoIbs8XssUno+gt?=
 =?us-ascii?Q?WPmH+wbfkkOyHJ0u0doBKYHBv3gVten86GC2S5LYfemjfXyDZYpJ4JASg0QB?=
 =?us-ascii?Q?f+ChAyajgH+teWVJQAOXZKRo6xez2QZ9YcslxNA5NsP0BHGqOSyhCY7lj4Av?=
 =?us-ascii?Q?QV16HC8Bi+6P3KRtR07+Db+UJu5xAsEJUvMP47IBX0Los/BeooH3kUj++eeX?=
 =?us-ascii?Q?JNmlL+1+HLlNbxEU1H6vCVOuCs6YOXdMjvVNKXbrZxQC3U9a7oOvfky1QJCh?=
 =?us-ascii?Q?AHcWS5X5pptYSdkH3iGjHSgLp0HU8aKhH5o0f8WLUepTSrIibnWu3HK+CSN5?=
 =?us-ascii?Q?FKXSzEAyWOa0dedkwqHr6j9zEVCqy26wRICgPrA2Kmqt+DCYxA972NB3fhLW?=
 =?us-ascii?Q?pvALv/G/gxa7bjl5eZ9Uz/0q/g7CJnSFMgyzvh3okGagg9rTD8QTIxuJPSqz?=
 =?us-ascii?Q?hbR7GqF6uR8gUi3o9N7ytA3835imZArSfEIOK+jxELSD1V6LKmacpAJEfQRJ?=
 =?us-ascii?Q?OJDcBFmfZzNLpaFH+7bERRDacLqctUZwFleJPIfoMMU+d0mDb9bNbSdZKVyN?=
 =?us-ascii?Q?87GbpNQ/VVvlnplGNJdg4x5MFz7mcWEX9zALmH2/WiTfgCBjNRlqjxxjwMH0?=
 =?us-ascii?Q?XDUaLMzjec63Nw7xLFysiKb9Ktue/X/CbmOLr49z31sELzY6BzI6JubxZOES?=
 =?us-ascii?Q?YPw1zv7iPHavPo7HMnV/TQHTJaVeEljiOKKJXqDKg20gNp763kOIJed4ac2K?=
 =?us-ascii?Q?4ByTni2aybn8/kQ8xjYop5f0xi7/hq57IVYHRzosNZohb0KE5pVlC0dQleLb?=
 =?us-ascii?Q?PVlB8kuspHNcFQThTms2GB7DgimKEoPHsd7GPUQu+hjGtbODxrwqp0ToIGhc?=
 =?us-ascii?Q?RPtbNjnVFQj6XfriLwKjVs9nWbZYBs0qniYucbEnoDLX6htoErMHJsAOhsyd?=
 =?us-ascii?Q?ecmqtpw+CT1H92mh2sAJiHv3VJW7efNE7CoX239STs8WLQkS6I04E6eLAbVa?=
 =?us-ascii?Q?MWvsznrRjBUgXY8ZlWSYlxUAkoGAEuWxTWHvwzMcUZRev9Whs7rYyaHw5Y9L?=
 =?us-ascii?Q?J9EJ6SdzWCE1BmqQ2PVrHfLmm4XJz0MU6TjgHNYuZUCWjBGnGV9It1Q7vFhC?=
 =?us-ascii?Q?PGSUNxeA8Nhs9l/idT7TKAxvECRPNvIg7b00nhyBjAaZjDGE4FKUx2uvyEmh?=
 =?us-ascii?Q?sJw29Tc1lmeZHLuRyQDxwKdBfTreEvir/z49PG/P+OpRJN/CTUXtD5NX2Nvw?=
 =?us-ascii?Q?jaLUT5F2NAZhOiIIDdl+yMaUJtit0MY9eyDV1dxyOh3eXf7fwoMnzL0ITJAq?=
 =?us-ascii?Q?LWDujSYqIw4wL2zFZJRN50ZciXMk4I6jw8Z1n6oO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9945cd-ec9f-4520-2e28-08dceec99b72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:34:44.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHtuC1OY3Zy6U8Cs2iN2BV04U0Ob/jRswgL3POs1Gsaflz+c7jDZ2HJH/r0wNAOa99dYNmDEFx7la5pfmgp1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

On Thu, Oct 17, 2024 at 03:46:29PM +0800, Wei Fang wrote:
> The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
> used on the i.MX95 platform (rev 4.1), except for the station interface
> (SI) part. To reduce code redundancy and prepare for a new driver for rev
> 4.1 and later, extract shared interfaces from enetc_pf.c and move them to
> enetc_pf_common.c. This refactoring lays the groundwork for compiling
> enetc_pf_common.c into a shared driver for both platforms' PF drivers.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
> driver support"), it just moved some common functions from enetc_pf.c to
> enetc_pf_common.c.
> v3 changes:
> Change the title and refactor the commit message.
> ---
>  drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
>  .../freescale/enetc/enetc_pf_common.c         | 295 +++++++++++++++++
>  4 files changed, 313 insertions(+), 294 deletions(-)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 5c277910d538..39675e9ff39d 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-y := enetc_pf.o
> +fsl-enetc-y := enetc_pf.o enetc_pf_common.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 8f6b0bf48139..3cdd149056f9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -2,11 +2,8 @@
>  /* Copyright 2017-2019 NXP */
>
>  #include <linux/unaligned.h>
> -#include <linux/mdio.h>
>  #include <linux/module.h>
> -#include <linux/fsl/enetc_mdio.h>
>  #include <linux/of_platform.h>
> -#include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/pcs-lynx.h>
>  #include "enetc_ierb.h"
> @@ -14,7 +11,7 @@
>
>  #define ENETC_DRV_NAME_STR "ENETC PF driver"
>
> -static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
> +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  {
>  	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
>  	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> @@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  	put_unaligned_le16(lower, addr + 4);
>  }
>
> -static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -					  const u8 *addr)
> +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +				   const u8 *addr)
>  {
>  	u32 upper = get_unaligned_le32(addr);
>  	u16 lower = get_unaligned_le16(addr + 4);
> @@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> -static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> -{
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	struct sockaddr *saddr = addr;
> -
> -	if (!is_valid_ether_addr(saddr->sa_data))
> -		return -EADDRNOTAVAIL;
> -
> -	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> -
> -	return 0;
> -}
> -
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
>  {
>  	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
> @@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
>  	return 0;
>  }
>
> -static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
> -				   int si)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_hw *hw = &pf->si->hw;
> -	u8 mac_addr[ETH_ALEN] = { 0 };
> -	int err;
> -
> -	/* (1) try to get the MAC address from the device tree */
> -	if (np) {
> -		err = of_get_mac_address(np, mac_addr);
> -		if (err == -EPROBE_DEFER)
> -			return err;
> -	}
> -
> -	/* (2) bootloader supplied MAC address */
> -	if (is_zero_ether_addr(mac_addr))
> -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> -
> -	/* (3) choose a random one */
> -	if (is_zero_ether_addr(mac_addr)) {
> -		eth_random_addr(mac_addr);
> -		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> -			 si, mac_addr);
> -	}
> -
> -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> -
> -	return 0;
> -}
> -
> -static int enetc_setup_mac_addresses(struct device_node *np,
> -				     struct enetc_pf *pf)
> -{
> -	int err, i;
> -
> -	/* The PF might take its MAC from the device tree */
> -	err = enetc_setup_mac_address(np, pf, 0);
> -	if (err)
> -		return err;
> -
> -	for (i = 0; i < pf->total_vfs; i++) {
> -		err = enetc_setup_mac_address(NULL, pf, i + 1);
> -		if (err)
> -			return err;
> -	}
> -
> -	return 0;
> -}
> -
>  static void enetc_port_assign_rfs_entries(struct enetc_si *si)
>  {
>  	struct enetc_pf *pf = enetc_si_priv(si);
> @@ -775,187 +708,6 @@ static const struct net_device_ops enetc_ndev_ops = {
>  	.ndo_xdp_xmit		= enetc_xdp_xmit,
>  };
>
> -static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> -				  const struct net_device_ops *ndev_ops)
> -{
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -
> -	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> -	priv->ndev = ndev;
> -	priv->si = si;
> -	priv->dev = &si->pdev->dev;
> -	si->ndev = ndev;
> -
> -	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
> -	ndev->netdev_ops = ndev_ops;
> -	enetc_set_ethtool_ops(ndev);
> -	ndev->watchdog_timeo = 5 * HZ;
> -	ndev->max_mtu = ENETC_MAX_MTU;
> -
> -	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
> -			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> -			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> -	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> -			 NETIF_F_HW_VLAN_CTAG_TX |
> -			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> -	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
> -			      NETIF_F_TSO | NETIF_F_TSO6;
> -
> -	if (si->num_rss)
> -		ndev->hw_features |= NETIF_F_RXHASH;
> -
> -	ndev->priv_flags |= IFF_UNICAST_FLT;
> -	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> -			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> -			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> -
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> -		priv->active_offloads |= ENETC_F_QCI;
> -		ndev->features |= NETIF_F_HW_TC;
> -		ndev->hw_features |= NETIF_F_HW_TC;
> -	}
> -
> -	/* pick up primary MAC address from SI */
> -	enetc_load_primary_mac_addr(&si->hw, ndev);
> -}
> -
> -static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_mdio_priv *mdio_priv;
> -	struct mii_bus *bus;
> -	int err;
> -
> -	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> -	if (!bus)
> -		return -ENOMEM;
> -
> -	bus->name = "Freescale ENETC MDIO Bus";
> -	bus->read = enetc_mdio_read_c22;
> -	bus->write = enetc_mdio_write_c22;
> -	bus->read_c45 = enetc_mdio_read_c45;
> -	bus->write_c45 = enetc_mdio_write_c45;
> -	bus->parent = dev;
> -	mdio_priv = bus->priv;
> -	mdio_priv->hw = &pf->si->hw;
> -	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
> -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> -
> -	err = of_mdiobus_register(bus, np);
> -	if (err)
> -		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> -
> -	pf->mdio = bus;
> -
> -	return 0;
> -}
> -
> -static void enetc_mdio_remove(struct enetc_pf *pf)
> -{
> -	if (pf->mdio)
> -		mdiobus_unregister(pf->mdio);
> -}
> -
> -static int enetc_imdio_create(struct enetc_pf *pf)
> -{
> -	struct device *dev = &pf->si->pdev->dev;
> -	struct enetc_mdio_priv *mdio_priv;
> -	struct phylink_pcs *phylink_pcs;
> -	struct mii_bus *bus;
> -	int err;
> -
> -	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
> -	if (!bus)
> -		return -ENOMEM;
> -
> -	bus->name = "Freescale ENETC internal MDIO Bus";
> -	bus->read = enetc_mdio_read_c22;
> -	bus->write = enetc_mdio_write_c22;
> -	bus->read_c45 = enetc_mdio_read_c45;
> -	bus->write_c45 = enetc_mdio_write_c45;
> -	bus->parent = dev;
> -	bus->phy_mask = ~0;
> -	mdio_priv = bus->priv;
> -	mdio_priv->hw = &pf->si->hw;
> -	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
> -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> -
> -	err = mdiobus_register(bus);
> -	if (err) {
> -		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> -		goto free_mdio_bus;
> -	}
> -
> -	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> -	if (IS_ERR(phylink_pcs)) {
> -		err = PTR_ERR(phylink_pcs);
> -		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> -		goto unregister_mdiobus;
> -	}
> -
> -	pf->imdio = bus;
> -	pf->pcs = phylink_pcs;
> -
> -	return 0;
> -
> -unregister_mdiobus:
> -	mdiobus_unregister(bus);
> -free_mdio_bus:
> -	mdiobus_free(bus);
> -	return err;
> -}
> -
> -static void enetc_imdio_remove(struct enetc_pf *pf)
> -{
> -	if (pf->pcs)
> -		lynx_pcs_destroy(pf->pcs);
> -	if (pf->imdio) {
> -		mdiobus_unregister(pf->imdio);
> -		mdiobus_free(pf->imdio);
> -	}
> -}
> -
> -static bool enetc_port_has_pcs(struct enetc_pf *pf)
> -{
> -	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
> -		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
> -		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
> -		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
> -}
> -
> -static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
> -{
> -	struct device_node *mdio_np;
> -	int err;
> -
> -	mdio_np = of_get_child_by_name(node, "mdio");
> -	if (mdio_np) {
> -		err = enetc_mdio_probe(pf, mdio_np);
> -
> -		of_node_put(mdio_np);
> -		if (err)
> -			return err;
> -	}
> -
> -	if (enetc_port_has_pcs(pf)) {
> -		err = enetc_imdio_create(pf);
> -		if (err) {
> -			enetc_mdio_remove(pf);
> -			return err;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -static void enetc_mdiobus_destroy(struct enetc_pf *pf)
> -{
> -	enetc_mdio_remove(pf);
> -	enetc_imdio_remove(pf);
> -}
> -
>  static struct phylink_pcs *
>  enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
>  {
> @@ -1101,47 +853,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
>  	.mac_link_down = enetc_pl_mac_link_down,
>  };
>
> -static int enetc_phylink_create(struct enetc_ndev_priv *priv,
> -				struct device_node *node)
> -{
> -	struct enetc_pf *pf = enetc_si_priv(priv->si);
> -	struct phylink *phylink;
> -	int err;
> -
> -	pf->phylink_config.dev = &priv->ndev->dev;
> -	pf->phylink_config.type = PHYLINK_NETDEV;
> -	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> -
> -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_SGMII,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> -		  pf->phylink_config.supported_interfaces);
> -	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> -		  pf->phylink_config.supported_interfaces);
> -	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> -
> -	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
> -				 pf->if_mode, &enetc_mac_phylink_ops);
> -	if (IS_ERR(phylink)) {
> -		err = PTR_ERR(phylink);
> -		return err;
> -	}
> -
> -	priv->phylink = phylink;
> -
> -	return 0;
> -}
> -
> -static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> -{
> -	phylink_destroy(priv->phylink);
> -}
> -
>  /* Initialize the entire shared memory for the flow steering entries
>   * of this port (PF + VFs)
>   */
> @@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	if (err)
>  		goto err_mdiobus_create;
>
> -	err = enetc_phylink_create(priv, node);
> +	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
>  	if (err)
>  		goto err_phylink_create;
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index c26bd66e4597..92a26b09cf57 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -58,3 +58,16 @@ struct enetc_pf {
>  int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
> +
> +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +				   const u8 *addr);
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops);
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
> +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *ops);
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> new file mode 100644
> index 000000000000..bce81a4f6f88
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/* Copyright 2024 NXP */
> +
> +#include <linux/fsl/enetc_mdio.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/pcs-lynx.h>
> +
> +#include "enetc_pf.h"
> +
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct sockaddr *saddr = addr;
> +
> +	if (!is_valid_ether_addr(saddr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	eth_hw_addr_set(ndev, saddr->sa_data);
> +	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> +
> +	return 0;
> +}
> +
> +static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
> +				   int si)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_hw *hw = &pf->si->hw;
> +	u8 mac_addr[ETH_ALEN] = { 0 };
> +	int err;
> +
> +	/* (1) try to get the MAC address from the device tree */
> +	if (np) {
> +		err = of_get_mac_address(np, mac_addr);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +	}
> +
> +	/* (2) bootloader supplied MAC address */
> +	if (is_zero_ether_addr(mac_addr))
> +		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> +
> +	/* (3) choose a random one */
> +	if (is_zero_ether_addr(mac_addr)) {
> +		eth_random_addr(mac_addr);
> +		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> +			 si, mac_addr);
> +	}
> +
> +	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> +
> +	return 0;
> +}
> +
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
> +{
> +	int err, i;
> +
> +	/* The PF might take its MAC from the device tree */
> +	err = enetc_setup_mac_address(np, pf, 0);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < pf->total_vfs; i++) {
> +		err = enetc_setup_mac_address(NULL, pf, i + 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +
> +	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> +	priv->ndev = ndev;
> +	priv->si = si;
> +	priv->dev = &si->pdev->dev;
> +	si->ndev = ndev;
> +
> +	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
> +	ndev->netdev_ops = ndev_ops;
> +	enetc_set_ethtool_ops(ndev);
> +	ndev->watchdog_timeo = 5 * HZ;
> +	ndev->max_mtu = ENETC_MAX_MTU;
> +
> +	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
> +			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> +			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> +			 NETIF_F_HW_VLAN_CTAG_TX |
> +			 NETIF_F_HW_VLAN_CTAG_RX |
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
> +			      NETIF_F_TSO | NETIF_F_TSO6;
> +
> +	if (si->num_rss)
> +		ndev->hw_features |= NETIF_F_RXHASH;
> +
> +	ndev->priv_flags |= IFF_UNICAST_FLT;
> +	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
> +			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> +
> +	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +		priv->active_offloads |= ENETC_F_QCI;
> +		ndev->features |= NETIF_F_HW_TC;
> +		ndev->hw_features |= NETIF_F_HW_TC;
> +	}
> +
> +	/* pick up primary MAC address from SI */
> +	enetc_load_primary_mac_addr(&si->hw, ndev);
> +}
> +
> +static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_mdio_priv *mdio_priv;
> +	struct mii_bus *bus;
> +	int err;
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Freescale ENETC MDIO Bus";
> +	bus->read = enetc_mdio_read_c22;
> +	bus->write = enetc_mdio_write_c22;
> +	bus->read_c45 = enetc_mdio_read_c45;
> +	bus->write_c45 = enetc_mdio_write_c45;
> +	bus->parent = dev;
> +	mdio_priv = bus->priv;
> +	mdio_priv->hw = &pf->si->hw;
> +	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +
> +	err = of_mdiobus_register(bus, np);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> +
> +	pf->mdio = bus;
> +
> +	return 0;
> +}
> +
> +static void enetc_mdio_remove(struct enetc_pf *pf)
> +{
> +	if (pf->mdio)
> +		mdiobus_unregister(pf->mdio);
> +}
> +
> +static int enetc_imdio_create(struct enetc_pf *pf)
> +{
> +	struct device *dev = &pf->si->pdev->dev;
> +	struct enetc_mdio_priv *mdio_priv;
> +	struct phylink_pcs *phylink_pcs;
> +	struct mii_bus *bus;
> +	int err;
> +
> +	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Freescale ENETC internal MDIO Bus";
> +	bus->read = enetc_mdio_read_c22;
> +	bus->write = enetc_mdio_write_c22;
> +	bus->read_c45 = enetc_mdio_read_c45;
> +	bus->write_c45 = enetc_mdio_write_c45;
> +	bus->parent = dev;
> +	bus->phy_mask = ~0;
> +	mdio_priv = bus->priv;
> +	mdio_priv->hw = &pf->si->hw;
> +	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> +
> +	err = mdiobus_register(bus);
> +	if (err) {
> +		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> +		goto free_mdio_bus;
> +	}
> +
> +	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> +	if (IS_ERR(phylink_pcs)) {
> +		err = PTR_ERR(phylink_pcs);
> +		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> +		goto unregister_mdiobus;
> +	}
> +
> +	pf->imdio = bus;
> +	pf->pcs = phylink_pcs;
> +
> +	return 0;
> +
> +unregister_mdiobus:
> +	mdiobus_unregister(bus);
> +free_mdio_bus:
> +	mdiobus_free(bus);
> +	return err;
> +}
> +
> +static void enetc_imdio_remove(struct enetc_pf *pf)
> +{
> +	if (pf->pcs)
> +		lynx_pcs_destroy(pf->pcs);
> +
> +	if (pf->imdio) {
> +		mdiobus_unregister(pf->imdio);
> +		mdiobus_free(pf->imdio);
> +	}
> +}
> +
> +static bool enetc_port_has_pcs(struct enetc_pf *pf)
> +{
> +	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
> +		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
> +}
> +
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
> +{
> +	struct device_node *mdio_np;
> +	int err;
> +
> +	mdio_np = of_get_child_by_name(node, "mdio");
> +	if (mdio_np) {
> +		err = enetc_mdio_probe(pf, mdio_np);
> +
> +		of_node_put(mdio_np);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (enetc_port_has_pcs(pf)) {
> +		err = enetc_imdio_create(pf);
> +		if (err) {
> +			enetc_mdio_remove(pf);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void enetc_mdiobus_destroy(struct enetc_pf *pf)
> +{
> +	enetc_mdio_remove(pf);
> +	enetc_imdio_remove(pf);
> +}
> +
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *ops)
> +{
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
> +	struct phylink *phylink;
> +	int err;
> +
> +	pf->phylink_config.dev = &priv->ndev->dev;
> +	pf->phylink_config.type = PHYLINK_NETDEV;
> +	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> +
> +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +		  pf->phylink_config.supported_interfaces);
> +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +		  pf->phylink_config.supported_interfaces);
> +	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> +
> +	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
> +				 pf->if_mode, ops);
> +	if (IS_ERR(phylink)) {
> +		err = PTR_ERR(phylink);
> +		return err;
> +	}
> +
> +	priv->phylink = phylink;
> +
> +	return 0;
> +}
> +
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> +{
> +	phylink_destroy(priv->phylink);
> +}
> --
> 2.34.1
>

