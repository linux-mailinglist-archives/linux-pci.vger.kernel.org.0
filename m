Return-Path: <linux-pci+bounces-39061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4614BFE01E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFAC64EFEEA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535332A3F2;
	Wed, 22 Oct 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYTKs5cO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9032860B;
	Wed, 22 Oct 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160874; cv=fail; b=fOjidjHsBwMn2/346VuqkmBjmpS/bH3ACQLFvZcyabeWDPw7tMDNMr4o0AUDCkJFVzcFbRet5nIJBbrQjlHhfBuUUwKrI8tQfoGHlvv5cf3bPJ49v2r6+wA7A+RTz3teGT7cep4j6XT1Zgc9ZomZqYI2HGI9LdSTN6LyxHRiAuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160874; c=relaxed/simple;
	bh=wWrSI52evbd/1suoayLBF/RHfgcQbuKJ1DCCuoxoUdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SDxdfwFF7y1fklYd+VakchlsTAYGm4QGWUcQFkHGrRvQ/EY+frGIx6128USQl0JfMOdzZFaDKRSfvxtXXJ8ntE9wn6EnoO6AD/SkSn3ZAc10UXotUXpYpJvlDKFrlUSTKgYT5C5EweAj9OM3Z0fqCQeiI+ODNoydsfVZsaszmsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYTKs5cO; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShRUe4QL5QtxnQ2jN54a1xj+R56SAlsQojga0YdXCdXZjrZF+QbVZbI23M+PX5WZgPAOr+xaKaW2VIEzRWda2PRgdZuvgf1G6Lqm91YW7Hk/z3ZXSjTsF3s9G6oSS1nuGWdOvgZBv0igcFfHpuQvwGxEo0tNcWJjT8xEP/CboeVm2/wIn+Vq//u1cqLKkYattay9IciFKfY6CMqpCqNi2DKmMXB7CfKV09H381gVerltVbuE1rztufhiF3YLRVfzmPzK1v7FeluSQd8BtKXnbPs3hnwNsH3Fhp+YfWumTGkZ67WSMHtPXOmWsYL6GGYHW71GWSKPTVIeKkxDE9H6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOXPKvLieErSO+gsP09cF/DTGGe9WgHtpX9hSOiLeRY=;
 b=kx13INKz7obgK5tIVDS/KH8Tgu1f8WRhAlzmdChUezLKRrgFeRH2I+CfR/H+3eHDQxslxJIFHdWlGe7SHmJpQIb/ErS6oEE5u0zYJGg1cdLmFwZNUAvp1CWQqqRODtLy0X0bfPiIQbG6ev3Y3Tx8eqzDA4VetbCEtDAVqPLOgVCOFAM0yg9xXGRvIaao0IZB/50h+WjQe0a7brZqphtSg6iQ3Y8xcheKa/7uUxONgyLQwcEOaT7EyPDKEMs2VOpz+2EQ4dtUvir54oisMhUgOc9PB8wxeglclg3NoVFjTz9ZLs6ui0k9Gna000vsDEi8icZ7/oW8hC5TfCkEt4hXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOXPKvLieErSO+gsP09cF/DTGGe9WgHtpX9hSOiLeRY=;
 b=UYTKs5cOr/ZDH2Fg6cZoRjZyk/4D3+IrCw4of0AGe2ZgU7qGbX8xCLkRApz8ViTJEqzx1xtJQfEDJd0oqzgzOJvMijEB7BdSWIbDXitwnhm4vPFfI/Wc+aRFEW1ByJnFS5al6JuJFEYs/p0MDHN71KYOEkF4uNOolgNknAJhpTFAmyG62gKWQ6682WgBe2wJDOFgkWjhREMsljYmdmXrC+Fp/JmA/cWekzboGWd1wMftrUUtMCGeG7nxM4R1Rs/0iszu/tC49eriurVR8M2mscyRSRP3QPv56KzF2JzM9hv3+0jiYjxCVkF1VFZZVot6BLvom/leE4Osdg2mdzJ9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBBPR04MB7931.eurprd04.prod.outlook.com (2603:10a6:10:1eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 19:21:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:21:08 +0000
Date: Wed, 22 Oct 2025 15:20:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 4/4 v3] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe
 driver
Message-ID: <aPkumTnIVQdertG2@lizhi-Precision-Tower-5810>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
 <20251022174309.1180931-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022174309.1180931-5-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBBPR04MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4314aa-99c4-44d6-d622-08de11a026de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yK/KmNa7cc7DIlxu+34xFR//TjUCRnezmTCU44vw9X4KWIwK7oRctw34EACq?=
 =?us-ascii?Q?BVmA+7TRBjkjrMjlpIA096rIH29ybbkGEuR8Fjdzj5xYawMIAse5E4YyWPQN?=
 =?us-ascii?Q?M5R/XKStEE2MxbesXrQXyXVp3FI5eGBn5snWTrVku1nhF+5qcx8BRhSpXXJN?=
 =?us-ascii?Q?6uVjYnaZvhNyDeC2cgbxIyQXdI5noaww2OXge1WWT4NpBaRaA8FsnJqxUqkk?=
 =?us-ascii?Q?Ofi1EV9x7THddMeHyHRQlDzeAUJisWCXZfVu6DJHD5YvT1iKA39Nnbx0LgF8?=
 =?us-ascii?Q?AR1o+W1BEkhaYSu0/JFCjFiJ8fYeBuhFAmreFhwlx162zDY3hj74wjhVkZQ+?=
 =?us-ascii?Q?NkKIceCWf5WD7FLqsaPNS/Kaw7tfALcCDP1MUnTRpvDJNYImrXIVX/XI28Q5?=
 =?us-ascii?Q?du+3QXhkxZMRvaGvWWi7+euZP7BkaQ9uS+YBCRZaJ6/l3r1GrV2bbNfKRZty?=
 =?us-ascii?Q?5LgAAoaXDEwB1BTt++Un6Hlkibm+DN6nqb4ZsNP29n81S6QesLfpi0LS7wIg?=
 =?us-ascii?Q?UV4L0yZ3EffpEKGxEnwaldTN8KdJ64qMsLchXJ7SpC37Zd/2KcBtc+WIavDG?=
 =?us-ascii?Q?Bz55QQ57hwUJ+ZTpoQb+HWoNt2z7HdRCuty5ftGXG/qQgnjl/O1XUxr/25+j?=
 =?us-ascii?Q?8AYT7hPuq55O7xdK8z34vwt4BfmAhgz7pUweG66saZYIppHPBciZSE66BRoR?=
 =?us-ascii?Q?wn7TRxJiGhBDu6cv5oFRgxybclyNXCNxvVawv8bK6h/xvcvHR18oOjblhRmu?=
 =?us-ascii?Q?Ii0buKcEGjcv1DP+zZeuwKYTbNwAGQwPCEeP49pg2fi/jq6Pk3esE3skFE95?=
 =?us-ascii?Q?sIJXwh7XPMWXfn/s4bCQSvEw6bd9647fFYT1YOOBeF7RwfEG8kgsIu4D4nAF?=
 =?us-ascii?Q?L0w2dhZLd2GajC1ASs1tPmYRTS0QcK3DtAu3xAowwZLTvivCJ9C4DWLSD9f6?=
 =?us-ascii?Q?BD0NA3gtV719eR9FY5wXwiCmkp5Uy39jvUEfrc3TECBRW1ph5FoZcO2Tmg5T?=
 =?us-ascii?Q?EZkaBPxdnyQCieX7Eip0AdeL04rB20wYCB37tN4LFV70O5bc0LynY9XxRoMH?=
 =?us-ascii?Q?WPOsmU1rJIcN/sqPWsjW5VUj+BC/Hon/Pgd6yrqStIvZiOQAw3Ad+9BedniG?=
 =?us-ascii?Q?rEe6UO8fRKVGd1yG0TGKikgX7HHUq4msdF20mH3aUPs7MGaVvL0ZF+DLZrRi?=
 =?us-ascii?Q?0Sdk43J5Y+6U5SaFN5IuNY8bGDC0pqSwNrUh6Cj5Ct9NxDW0sCPPRoX37fTu?=
 =?us-ascii?Q?pGr0OFFrDwZj87J7fFydxukr8RbV7pv9eR2GImicWSjGjA5rm3m7RskKMaFZ?=
 =?us-ascii?Q?t+N8OKbF7qpGhE5QrhbYpB2Bew/DuUqOEJFZmGNHFlpE8YNf6HQmut6185sF?=
 =?us-ascii?Q?R2KrQpAlXodZmQu6hCokwbePhpdRefrXUxmCFZ8m4NjSgQ3QV5f+sRkzrSXA?=
 =?us-ascii?Q?E21Uida5eo16jsoD1LtQoGezCgR/9K3I2NubE8vZJmd8U4m/LIlEjmnkmY/T?=
 =?us-ascii?Q?ryT+4lrVTD4qGIr2NdbOgmwRTBlP9sBJnazw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4upvsBkPAF247Fw/zrIEbzD0uPMBN6SRZ4KRdvvEijRabzGv3xgDePo60FxY?=
 =?us-ascii?Q?bwjMxIWDEL3G16itlOEPE9qYLrrw87jTZDbyJ8eIdnNE3TXl2PlP7M0SzVMs?=
 =?us-ascii?Q?f9L/WfPosTDGIUqrpyplizl34p4QH4vpwaR53dkZuHpPEO2G3KCC/t9XECKU?=
 =?us-ascii?Q?UxGscmXvhJ7GrIJexKrJPIWtYE/BRmTzwulVS6owWZSA5EK1dGuUELU71f+v?=
 =?us-ascii?Q?RnkVp8OmiLPtdS0kUOeSMoSWZANv0M4h/QV5FUcQDbDlKYyC1YWkwJpncBfK?=
 =?us-ascii?Q?f90Ob34RB+hdhxua0CEOY7GKl/S0AhO135pAq5InRV+yOBcKFV/ZGT2UJcjQ?=
 =?us-ascii?Q?mM4msdLetGFty5iZLs7T2EGp02SglhQ7NNkSjH5wqpC8i+8E8EIEy9eMVpaq?=
 =?us-ascii?Q?y26K0yOGH7OIZL+lAX2mYBughGLHfZyNwEBGO5hetjzdYTBKWOwc8I1mgPDG?=
 =?us-ascii?Q?GLYV+WGRHALyMFJdLLXNkmnkaJbW5F2pZobTJBG1Tvey1br7pdSntJEXfor2?=
 =?us-ascii?Q?vGBrEhPPEssTFtpiIXHzW8qwfefRbSKji6QsNPB8kEnMW7UlNEdV0HOy0nw/?=
 =?us-ascii?Q?OW94kmbdr0PNMeK8iEhj3egfuNlSDwUzyuCRVrXcCHFCCunLxNkx5tBE8Pkf?=
 =?us-ascii?Q?TIsxb7H2ebgRZaAEqwyCx2RGVl/TGGvFGwEYNiEdOiFHQeVknYmEFLUaEHCF?=
 =?us-ascii?Q?X5Rv0wpSB3izy2UvzP0DXc/7WqLz5X88IsoOQ1eUc8fs1As2mOK7jmEFev1a?=
 =?us-ascii?Q?jgSWIb3lNCuiMnua6IOs6/OWWwoY4S72+UW1/WGNJU6eSm7x7IBnqGUWYuGq?=
 =?us-ascii?Q?ettNMox+of3mdB1awPpnXxNswmR/G1QcHCWUnkDbw8aB+yO2VlMlLwbopCO1?=
 =?us-ascii?Q?KCjSDOyl89z4GkTsBwJS0r9zuotsa58rBlNe5KsoiiibnFNmSnR4anuxbgi4?=
 =?us-ascii?Q?cSTV6bMo6O07GIIwPDQQq5DtEYaHQsRpdTeW5cGpxwVm0myUIEq+TvGnVd2f?=
 =?us-ascii?Q?ojr2jnfujZk5MAejKNkfw/3xm1uzy0VRc31+A3B0Mg8eRt9DnHza6ccwesBT?=
 =?us-ascii?Q?79pph/iJAkMMl6+Zvrsuxeo8Wr80RG7g14Gu6OmfIU024peSpiEBOdZ1/Q+/?=
 =?us-ascii?Q?dAxx2dxuAZwNPv77KaQH3Z9eewbRpgmqFI1q7NA2NVvmB+GDEtOcFiZhweyB?=
 =?us-ascii?Q?dZAVVEyYD+rXLjz9OP5Ama+OmKjSkxRJVayRaUgvqFoP3QXbAb6opY2eGG5a?=
 =?us-ascii?Q?EPVzZV8ND9bI7xbPes6h+wumvb4DVOuELbCG8f0qII4K+ENXKrMGctvZwfFm?=
 =?us-ascii?Q?KhvsdPKpZEclHe/Eto+KIKEfccoazD4Q8vAg5M3VVE6wooRBvF/Mfx2ezwGq?=
 =?us-ascii?Q?PG2uvA4epE3vXBc/jy+R9pC6Rz6NE1jAtcC3KfvF+zdiqFfauFISDLaShsDv?=
 =?us-ascii?Q?9tSrDxecT9d9wytSWcMtfBuUgnk9r/YYGAETiMUrm1kNhWiKGrr4GyriTSXu?=
 =?us-ascii?Q?w9KtlF/+234EJGIL+3KIao6J71/rTerQPh0sBlezrgrtgFwF2JnDSK7AlhuG?=
 =?us-ascii?Q?BV8NFw43p1ZsVGhexePmQ4egoL+qjYhK18ZMjW4C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4314aa-99c4-44d6-d622-08de11a026de
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:21:07.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fdz6ZV/J8QzwrCBa4EAwDz9o+qhwwtUWICxwq1RCYjrF0mrXm4hmPHhWD6iTGGMREo2tAd9LcGisJM8Wxw6ECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7931

On Wed, Oct 22, 2025 at 07:43:09PM +0200, Vincent Guittot wrote:
> Add a new entry for S32G PCIe driver.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..e542aae55556 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3132,6 +3132,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
>  F:	drivers/pinctrl/nxp/
>  F:	drivers/rtc/rtc-s32g.c
>
> +ARM/NXP S32G PCIE CONTROLLER DRIVER
> +M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
> +R:	NXP S32 Linux Team <s32@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> +F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
> +
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
>  R:	s32@nxp.com
> --
> 2.43.0
>

