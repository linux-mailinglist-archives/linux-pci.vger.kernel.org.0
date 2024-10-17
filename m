Return-Path: <linux-pci+bounces-14815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBB9A292D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D212283A51
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF41DF978;
	Thu, 17 Oct 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eRV5d8Ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4A1DF274;
	Thu, 17 Oct 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183203; cv=fail; b=LnOs2QspWi5IAGs5Vmez92jYNVRa1n5a1vpWDZx0SmaeLhnFlHxdp0A/MxOGcCJcYuFSJQZGtCqNyUvp0Bau+UjW50E7sUMaE+DZLv9LZ1ag5X7xBWYURbatOYyKimNym6LsK6CsoYeRP52DmjTj/ImNYan22tkGgLpJaA1K2R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183203; c=relaxed/simple;
	bh=74XCxOEJo1bXqgokGBQlIoEdfY89+SHYa6BwQmlXRs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huCeU63vMqtYZOARf+MyLOsxE4sGvJ03f6dlKQjmBtnl5Mgcz5tY/r9lzsq45JIkaWT0F8xoEztSiYLPa+AhKuwhv7NZxlkoE4T0gyYVK+kFd5rc2iNIgkHK4zw9EaZO8eij5mD4XHrbozbD8U2z3p9E+1Ewuk8PrKV8+ee1ujE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eRV5d8Ep; arc=fail smtp.client-ip=40.107.249.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itbk5bNkTD/ZlhRObaNYakSvJuGzME2CSzZX5K5rvsFSO/dQX+FvdR4dqPMTCF6cpEvJgnnf15jmfk5eujSv6jNca8n18SjNQn8+DhZPCBSQtLQnhyyfvaoJwd/WR8jJS+nEmFSvZALcgF2g+eDgMAAQ4jchyto8OXhRQ8CKoISRaRmA7usWBNXGrYA38iDuQZdhwGEjV7vakvklSUgq4jDAXK6ksirmn83B3bMlKy3hWVd9fbZ7n9vhvQvcMP9elydOg5EoXUS/sQtz5vNYav7re8/QUS6FCu4tPPyL6ei2xzh8159fYBxLTnXIRPbzPz2jUmHR1Z1XY88BYx1sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW0+njVcacr1H9NzFPnYWUZP2KxkRiKS4WB70VIZ3qU=;
 b=rYhPOkejKPS6gdncJoAWxAMgoXhAih9VWCPbrCE5f+9tPfBQgmxYjY+EBNMg9Lgd7089MIB8vWwlB3vTfcDQdIJirC7E4pKcUHfPgLjUY/CtcaEtmwK1X6jyHxWDsh1+aWyl4KZhYRSINbsf6znhBcLUN1MSlqQvABR8sW9QqJpCwQJ7xsvT2mll2jGmEZuQKe/RIWWAVKDpyNLpe0TbFcgPUlmB/9LEWhRyEaWpn0k4YiQLLm/JHxgpv1HgvqD8ta3RHwNpo7iq3cw7LPrET+TEaKGFc1umv+BL+d3C1In9VcKrCVXYhPUp+1RDom+mXxhC0VJJiK3vDLV+hDaYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW0+njVcacr1H9NzFPnYWUZP2KxkRiKS4WB70VIZ3qU=;
 b=eRV5d8EpsdwK2aq/meVWpeywJ8EdUS+k9FGZJ9SoOH0SfsoHR5mS850xYPoqmWO90nz8VpVL+C5+x65ohkBI7ASBiKii3UpjJtAPSl+U74XxM+E9Ap9RsEQm6PUZoE5J6F9vGoi/nW5CGPTm9BEHDzsw0ObqHcCdqGYmeysrxCnECVx8bc+jEU3PBXDP9jfVNFf4WwBF12zbjiAUyGH1CVlXT24ttetCc1pm2Mj5gK50gMYWkf3Ytu/DSYjZQhh+J+zZox6ZnfqlBYcvk0mwBIqER25lEG/MOaJ4dvckp5zike4/EGNe01SdI0rW7EhJULvyPn/dJ8wFoQQbvk1KBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 16:39:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:39:54 +0000
Date: Thu, 17 Oct 2024 12:39:45 -0400
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
Subject: Re: [PATCH v3 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <ZxE90Tk3/37hOlUM@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-7-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ae6fd1-458f-4cdb-9948-08dceeca542e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KPjiWM9UYf9g0NXyi8hZ8qf1qFpbRGYpusgZd+m3kx50SAWXiOnlGCLzpsXw?=
 =?us-ascii?Q?tdTRknie0DP+KOOsW6TcNWR0+vZwkMq500mkCmu0H3PwLDISVbQj5oxQapQB?=
 =?us-ascii?Q?9D3RGCXfdGfUwFpmct592dBKtyyzbCv1KRrFFKrRbLrdSYTXyZ7qEeEICSSz?=
 =?us-ascii?Q?E+KHPjW0qAPQG6jXqgY8LbpD9SyMUGPN2J2LCwO2WNN91crT/7SIZKC14YX1?=
 =?us-ascii?Q?5Qm0HjE3tCdgA5q7lhLapmvPscJ6SjhLfeIf/v4pV0kWvNwt2SKUJwP7a3wJ?=
 =?us-ascii?Q?EXCpghmdwiCl2hh3i9rWB6F0Okt4QGnG2Bjt90x7sVDWJZWbGYJFulJK69fB?=
 =?us-ascii?Q?RCN+rRFletkqgTesBOi2UDoXQ6L/+LzczuZyU/fV6GoDALqc71TQVb/vsDQs?=
 =?us-ascii?Q?v0sfirUv8EJTIUJE+zNo0Npt8fea9oZWJtmvC8b3Gzkb2GAHOFWJxOLcSBSs?=
 =?us-ascii?Q?cTxHYRgUOGtSyMPb60MV0EABOutgIouW6PzhGNJTNeyYSS3wVPmvX5/G+KqZ?=
 =?us-ascii?Q?sCEW5u4qF1ZRr1ZuSJ/sav1ge7NM6Bwhb7Nu3aVSP1G+M1umEw5gUIxk1XKB?=
 =?us-ascii?Q?sQC3gv+6EXvy919B618nF8RD+LB0oPsoqoO1juuQ4bBOyJHezYkDXEib52J3?=
 =?us-ascii?Q?LLkbijAshMDFeiW1NHlmsqI0dtNCjrLW95SpXDZ0VHqIPxVve8y1QuF1mNz+?=
 =?us-ascii?Q?rK3JIpzdcu/yYRp0OZrKRaB3b24gzz4ywbKJzQKRtaPo388lGtf8TkNUfvXQ?=
 =?us-ascii?Q?oOsbS1qMDHY5u7DuWMgSn5U4NDHYtB23M8hhSKYIfhOftxJGpmPPsY/0Np4g?=
 =?us-ascii?Q?8SX0SOD4Ll3WbNb011oSlbLrOhWQLCJcRAlv+E6UwlA3++T+jeivODcgHWE7?=
 =?us-ascii?Q?Xaka9p41AcEmZlRg3EnWiM07eB1stxsn0wKvgEqenmDaKon6qQp70SRV2dNm?=
 =?us-ascii?Q?+pIssMvdCtmIjm+mKpfcdZcTr+grXKkslZAs2x8QpIMzI/h9x0nMre0ZlG5/?=
 =?us-ascii?Q?SypXxnlp5zR/jIqBAwXi/Gt+3/lbzub4tw/Nxr5IFI8YLNA3g/LqI6r6fSUF?=
 =?us-ascii?Q?Qtr803EWvmC5qOMjroIacZUzD0j5rHIBQ7Aaq2HX1NkoyRnZHPsllLMMKB8I?=
 =?us-ascii?Q?wCm8MObdfFHUcYlxdg6nHyqcbTbXpkDeadcRxg+Be/hHgT/KoLpk/4OXduRw?=
 =?us-ascii?Q?lnIKmqzXaXqmwL8R/ZTXOs09RKbYexdkm0gzFSkZ6D8oURReLNPpZGoLUHMo?=
 =?us-ascii?Q?09mAvk9+atGdZ/dV2bhuAEaYp/XUYo8bM9lxF3ID5B3QWHzl6AuLhcYv9Ooq?=
 =?us-ascii?Q?zY7E0a9goRNgQ9+D/FF4d6YDSP2AWdkon/vtOPZxlOb7JLcikuPNqtpY5Fds?=
 =?us-ascii?Q?11I6E1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U8X7YG6sVmJtSdhzc7uZ3WkrqSC6Al89RdI1kIbex2etI9vdppVWX5nv+M4E?=
 =?us-ascii?Q?T8IA8uNvl+Pq6jRQtofrFcnnnXu8LdWpWQqITTGOGqTidNo4/ppDx6FO5sMb?=
 =?us-ascii?Q?ZylPY2PqtWYQdtX7wKAohyXJHfmK8uLoHRWy68PrLmtobrdphg54+oQxLG2E?=
 =?us-ascii?Q?6njRKG28QP69Pc07rG7QVOkDeBHipXtWKlZ90R243WyHKu94219Aj+YWmMyg?=
 =?us-ascii?Q?CaoJY40e0i8V8ZjMSgTwrdo7XUQSF8Z8Hl8MRHcRsaUsCVm4MTeUeDfX/WVy?=
 =?us-ascii?Q?4zpv+Kh4r3B4YtxHj0K3jXyQdef3xtiMzuewMRUJM9n1lFRS/UfMr8HxmFj0?=
 =?us-ascii?Q?sRX8G+T5NonvuH0YqNS5F/yFjiLHUQa9zjRZHbUfhWBC4plZnBoMvp8i9xH0?=
 =?us-ascii?Q?yS/K7vwAhll5ZoYLVBqU3BZAhaNL8sWrT57zoQnVmiCS2MJzN6kIez7QgDZj?=
 =?us-ascii?Q?1bbCA/pvHOoVw9CrwzbsoPf+sVVd8VsfJhkH8XZkuYVC7gx0AiLUe1XY373o?=
 =?us-ascii?Q?jfRAZYjhijVlsVxKVGdyNK02rozI/rSIwbI+L/R25upDDqQNFp5FujFKuiSI?=
 =?us-ascii?Q?gZxnueF4jFadxYn4nT1byp/Gys28kAWoZM3CMRzDRwEqeWT5YGOPUm0AH2ab?=
 =?us-ascii?Q?e6nsykYlp2Bl0+uytSAQOmBC3WGZ0MrZ3QXqwTBwA0+Lg43bc76GmpFw9s9Y?=
 =?us-ascii?Q?WYwkfqV+8aqK4dZrTGkMyhfR0MXf1tfhFhSo1YQYL6cEzBagEJvJhkdE2m0m?=
 =?us-ascii?Q?iyqy4PpzSZsA/XPOs9nRqmOeWDxIp39bVrb8w6iyy+QlZ/hpvKV6BDGIfFqi?=
 =?us-ascii?Q?1nOFRcuLX6+8wa4+kkbxKq3u5BHsRsDmqmRcmsNgb4ZINaiEUjhpUkDNJZ9O?=
 =?us-ascii?Q?nl7NO7+gZwbm0s1SD3xMWp6noWw+0O61U6FzMVGkHPSmrtqoLVjFEzdtBeAl?=
 =?us-ascii?Q?iwBPPLvaFSS1+WCanfJ0xNSgNYjdM5yi8yQ7L4SYsCOcDeMMTtrEdU+Rmbny?=
 =?us-ascii?Q?AqtOcchzk93b5oKcAIJUc/e0FSLB9hTBthZLmXE7/doZ9Gb1jCoB+yKAHacB?=
 =?us-ascii?Q?WMF4Ahy/HIXu/nHx4vINFRx/xnyqWRZG05OYvi+zpXS95AAg/nv0vNzfEJsA?=
 =?us-ascii?Q?lAhAWchPg1t/xgH/bfW7ohCETiX3Eybaetu01hKMkVtTrf49m2cb3AANUcps?=
 =?us-ascii?Q?iqjsMFMoVgvJ13KZwvluHiF4sLL3C+ZRsngF0g9L89NFRDn3MfXvmWDexamf?=
 =?us-ascii?Q?yrgnxJk4L3nE9mF1dxi+DJN2mNhWf53iXCTGeKPI1FB4Aa+uMYWyqbbkltxY?=
 =?us-ascii?Q?t7n9KLEyVgoWa6y+iUEJTRrFhmeaIxO69RKXfgRaxKahC7m3+Q3s5Gf+NWpR?=
 =?us-ascii?Q?tJ+S6o8zF0CziHpW2ApMgFwJXSPp7ukIvbjcSQtY64l77+4zonnuyZ0iNoJ+?=
 =?us-ascii?Q?E8nfrOHA5HQXAf0Yt/vInKmrfrsVRcaV8K54gAgFuuMTVyIy4YkvDt2gAU+1?=
 =?us-ascii?Q?eHZzlbPYc+quJpJ6ImguWZenKLm5+qBsksZHnzQPfdXAidhGaS1sMEtMn4Nl?=
 =?us-ascii?Q?NT36wkTCWIgNL0l8k16ABgLdh1hivtagq20rXcPI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ae6fd1-458f-4cdb-9948-08dceeca542e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:39:54.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC21Nd/hhz4v+Togj46FFlRwQ5zo1PnfuzctvLI42Vlz3eSUMRq1bbwamizG4QQxpG5NTGbvfMzFBZf83bOYLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

On Thu, Oct 17, 2024 at 03:46:30PM +0800, Wei Fang wrote:
> Compile enetc_pf_common.c as a standalone module to allow shared usage
> between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
> different hardware operation interfaces for both ENETC v1 and v4 PF
> drivers.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
> driver support"), only the changes to compile enetc_pf_common.c into a
> separated driver are kept.
> v3 changes:
> Refactor the commit message.
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
>  drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
>  .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
>  .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
>  5 files changed, 96 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 51d80ea959d4..fdd3ecbd1dbf 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -7,6 +7,14 @@ config FSL_ENETC_CORE
>
>  	  If compiled as module (M), the module name is fsl-enetc-core.
>
> +config NXP_ENETC_PF_COMMON
> +	tristate "ENETC PF common functionality driver"
> +	help
> +	  This module supports common functionality between drivers of
> +	  different versions of NXP ENETC PF controllers.
> +
> +	  If compiled as module (M), the module name is nxp-enetc-pf-common.
> +
>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -14,6 +22,7 @@ config FSL_ENETC
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_IERB
>  	select FSL_ENETC_MDIO
> +	select NXP_ENETC_PF_COMMON
>  	select PHYLINK
>  	select PCS_LYNX
>  	select DIMLIB
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 39675e9ff39d..b81ca462e358 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -3,8 +3,11 @@
>  obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
> +obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
> +nxp-enetc-pf-common-y := enetc_pf_common.o
> +
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-y := enetc_pf.o enetc_pf_common.o
> +fsl-enetc-y := enetc_pf.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 3cdd149056f9..7522316ddfea 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -11,7 +11,7 @@
>
>  #define ENETC_DRV_NAME_STR "ENETC PF driver"
>
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
> +static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  {
>  	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
>  	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> @@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  	put_unaligned_le16(lower, addr + 4);
>  }
>
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr)
> +static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +					  const u8 *addr)
>  {
>  	u32 upper = get_unaligned_le32(addr);
>  	u16 lower = get_unaligned_le16(addr + 4);
> @@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> +static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
> +					       struct mii_bus *bus)
> +{
> +	return lynx_pcs_create_mdiodev(bus, 0);
> +}
> +
> +static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
> +{
> +	lynx_pcs_destroy(pcs);
> +}
> +
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
>  {
>  	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
> @@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
>  	enetc_pci_remove(pdev);
>  }
>
> +static const struct enetc_pf_ops enetc_pf_ops = {
> +	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
> +	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
> +	.create_pcs = enetc_pf_create_pcs,
> +	.destroy_pcs = enetc_pf_destroy_pcs,
> +	.enable_psfp = enetc_psfp_enable,
> +};
> +
>  static int enetc_pf_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *ent)
>  {
> @@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	pf = enetc_si_priv(si);
>  	pf->si = si;
>  	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
> +	enetc_pf_ops_register(pf, &enetc_pf_ops);
>
>  	err = enetc_setup_mac_addresses(node, pf);
>  	if (err)
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

Is it possible get_si_primary_mac() return failure?

Frank

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
>
>  	return 0;
>  }
> @@ -70,11 +90,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
>
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			   const struct net_device_ops *ndev_ops)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(si);
>
>  	SET_NETDEV_DEV(ndev, &si->pdev->dev);
>  	priv->ndev = ndev;
> @@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_NDO_XMIT_SG;
>
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
> +	    !pf->ops->enable_psfp(priv)) {
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
>  	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
>  	if (!bus)
>  		return -ENOMEM;
> @@ -184,7 +211,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  		goto free_mdio_bus;
>  	}
>
> -	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> +	phylink_pcs = pf->ops->create_pcs(pf, bus);
>  	if (IS_ERR(phylink_pcs)) {
>  		err = PTR_ERR(phylink_pcs);
>  		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> @@ -205,8 +232,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>
>  static void enetc_imdio_remove(struct enetc_pf *pf)
>  {
> -	if (pf->pcs)
> -		lynx_pcs_destroy(pf->pcs);
> +	if (pf->pcs && pf->ops->destroy_pcs)
> +		pf->ops->destroy_pcs(pf->pcs);
>
>  	if (pf->imdio) {
>  		mdiobus_unregister(pf->imdio);
> @@ -246,12 +273,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
>
>  void enetc_mdiobus_destroy(struct enetc_pf *pf)
>  {
>  	enetc_mdio_remove(pf);
>  	enetc_imdio_remove(pf);
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
>
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops)
> @@ -288,8 +317,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_create);
>
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
>  {
>  	phylink_destroy(priv->phylink);
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
> +
> +MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.34.1
>

