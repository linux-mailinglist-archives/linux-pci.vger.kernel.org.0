Return-Path: <linux-pci+bounces-14101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06392997285
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6AE28330A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD437198833;
	Wed,  9 Oct 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JG5/u3Du"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4643207;
	Wed,  9 Oct 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493349; cv=fail; b=cvhfnuBDnuPwAjGIvyb1ZfmcAwrTlTPbc8hI88BCEDrndKPZXNAEWNVfLKylSm0dpx2JPgUCXVJauvgZEDDkqxf/70JxzcyOirFfT8EJLBljsp8m43I679DgTD6M2VBCbrZojSURCRmtM/hNkVQ3kOMXhTiKuepdknEHHB4hLUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493349; c=relaxed/simple;
	bh=f5dNfJTk9CBnTNXD36Ref/e4fIdkX/fBAEwYSrfA7lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7tFByvTs5aZSqSC0i+dPESdjBFeNiImyyGnAS09egO3HsyWy80TtF8hHY3VqbW5ddy94NdXAezKy+rDY4jzXVN5C8UWo6X8KhtJzkiGQernPw21moarimH/pQno+9hGpB6WNluztgKdiGYgKsLB377FaBZYNGMpuvdyOtZDqV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JG5/u3Du; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWHY/5p7UrUnEdFeSzXVVYeHVV3bE0R1DcdRm0BJXsFKsZO1UmMz2/0CuGSZ9nqRS2R8J/hguAJHo/ya7oFtDcJjvUOYtUh6n1aIBiZiX+HeEg3rsOkYv2NyZKSvX6p64D0D8KHnEcHZeqkuNsSCAbzR7xdbi8/gYSAUjcViX2xaOR+2mJt/8qcWvkd3umgwcMb+4uezHaXpfuJFEaDwnfU9gMN52YdzhHMtQDwX+wxb/gO3Q/557A5kbrHQNrWPqfVrzcUv2aOzDMQoze2Rk0bOxIMUI5ej6B1bz6PO6KhuydPE+pv8ytxU2UrkNGua90XfgfiLNq9I9cZJrK8DdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhWbi3T+IQvqGoQVt+opl6wKD12/bf7NhCcsbdPjWu0=;
 b=Vp/Rz6EqqrNdQwjNmbiq0wyFhF7og+h/Oxl0nnK7r0v1FEzItzeJcSvJpppwXJWvZvnnKmniznmgtkeahmHiyG1cDlU2zNDwfU6xx3qrVFxT4hcOFkwc5NNRL/ExKB/6j+JGbfWclEPlbSm8WRW2Zg8iAWoCvAGBgUPB0tlPEveouJNVeLGtjuNGV/QKV5qNThZ0oyKzdxBOoF3LVP40SSjc+2QypU0PfkMS31+57cCOWCkYjy5sgT2FQp36Xz+AFzR4ptO/nvpT344XW7vmIQuGFfuAcSQ9V0RfwhVb5sZi+lIt3/qAK6FnEkUKYD5H34IFflRyhwvcMJ3fA8tRYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhWbi3T+IQvqGoQVt+opl6wKD12/bf7NhCcsbdPjWu0=;
 b=JG5/u3DuxpPTfaXSRllQlCj9c/RKTSYU70798sVhnpxjFE5peolZRUPeTxPSczgb54rEAoF8BQkVvuP6tcKICHxi3YzZS+jQ94ClfqzLLlq5fzk80wiZe+4B/TzBsbh9iZ+xJgtP/mE5V6fl0GoVrZL8hMsxHpefxEtwB5nGRLNuqBl6VFrxpD9DXb2R78t6MWNC/XNhWjfyly4zINul6ANiffEynTbECPQZ49zFTaX3cHCUEODI43Z0r7HkHSOcIinOuoJ4cX6wgtNTY0Yyuh3n+OyUZYBg5MDWfXU4GY/HuMYUEtrMTUeGSLYA7hlk+RH6132+PpepRdTFSTNhlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:02:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:02:23 +0000
Date: Wed, 9 Oct 2024 13:02:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 04/11] net: enetc: add initial netc-blk-ctrl
 driver support
Message-ID: <Zwa3FoLZlGJrAEBr@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-5-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: d218fda7-64ad-4275-0335-08dce88424fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4fh+CE4QEeTSmMyQ7uH0/qOcHSCOVDRRaek4jfyzjCW5wj76Y2JOpyvhQoc?=
 =?us-ascii?Q?ow257r8T1rTk/KORV+LwViDxm8BLpW6BCmXkrvPvgRA2hyPlEl9KqS7DQlIk?=
 =?us-ascii?Q?OS/jWTCmCffM9B5HGIUipu7TZ+aB1Vvdhbil7hBvz5UheMJszHDinPQKNGPo?=
 =?us-ascii?Q?gywiYrm9IcxCpqd4GX4mBuSUuHFgTiXq7fdrNAlWmLbl9wL0wOIohQ0MuGxd?=
 =?us-ascii?Q?jNdDAt6eUobKXW2qSHaildpt5YCHa/l7A1aHaD+d+T91d7/BRhX7Be/dgE/x?=
 =?us-ascii?Q?9qMhgzo3FWExLK1Gs7pggRqE6v47CBQaLqrcUmfIMUoinnxoa3E0Cftcn/D0?=
 =?us-ascii?Q?Z1qaWFRrEo/407Jc/kLkoTDpPRcE+aTm4pchaJSM6VRMVRTIwn7V3z/zXFt7?=
 =?us-ascii?Q?cKxopTiQIfTRGKRWEOEv5rp/oQJBNGDV0uej/f4NyRRaFZ+bw13jO1E5yHu5?=
 =?us-ascii?Q?evOG1y8BlDrKH3F9ibZiUMT7Pl56JhSlgab+TT6gwwHBZJ61wkpEuqfdeCMH?=
 =?us-ascii?Q?7CpV5XFXfJBdjL9AkPJ3gn5TiH7J9Ek8xKM7gNp9tK3lne7Fc5bWB8kz/gMz?=
 =?us-ascii?Q?IsaXUrvacPennTBHDapvJxReF3IoYOUMu2XeoJia17WJN4l8bFU+MoQ7czJe?=
 =?us-ascii?Q?LbMr5FxYOE7SZg9NHQ4QGjbeU4lx4A+zC5iR4DN3bsC+ZWuR2rVzSJosRHtZ?=
 =?us-ascii?Q?cEfavz0hkqkUKWXn0TTVgfMhsKcMOnlecGGUlHG8osh1gstVb3o8hsLSTY6d?=
 =?us-ascii?Q?KV8v6HUkSmdJRThCcaEY/7f661MB6Iod2IFv31g3vBRxx+TjiIQo1D/COzer?=
 =?us-ascii?Q?Mi7cyLAaltL02e37T4PffHpvCZf70PPxaVFQd5MN2J7iLEo4ijnDeGwtV2qb?=
 =?us-ascii?Q?hIHaXoNkJYovNbOEOnPJlwuZUBg3TjJuR12hrXm159gKn5VC6fIEFyJv42tD?=
 =?us-ascii?Q?td3T+mRG38LOV+hAKKlsjVw2+QnhyyRIo28vJWeBdBHrF1Q8JS6Of93RGIXL?=
 =?us-ascii?Q?oI4UuimzGgHusz/xFm5UpVdOEFxMB+l+tN17iOzCncmlbUOd6u6tDOMMQvSb?=
 =?us-ascii?Q?991piWj+CPSK1SzbSWjX+p/NGWkCWyRi13B09t6ny6xbxqUUKpuYiN1lgS4o?=
 =?us-ascii?Q?+rA1OmcKRFWKHvIJU9/S6z+f0gdLrE3nHlMmBTehTIky1zIoWXqZW05y8Dqs?=
 =?us-ascii?Q?uDeu4h+s587RZZ8vBxNAEouEA/VEPc5jAQHrd2hA4kHhiyWQqcsjnOBB5kS+?=
 =?us-ascii?Q?8hRvWywIXOQtcNbCVTjXDFwJ/VQAmdmUcto5OzN3d0QXQ6q5MEmwnhr1YJeN?=
 =?us-ascii?Q?osmZsW+mhe+GfC5rUP9mq32j9IjMrGJ03n0YVC35qtQzew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yIcZUnf0mk2s1bhQCP7u5+TyS7hEc4kXM7azsFzBWosIXmevpY08/apIx3/W?=
 =?us-ascii?Q?lNL1OaPkLGEeOQOc18unEDwsShl6Ha018K6ABgqOLX97kHmJdXJ/B6j3Lm9v?=
 =?us-ascii?Q?hmdYWtiFoKcLiVpKlQogWHrkfVhl+eOhhG2TMRDyk3QbbXl1jP/JZarHTVAg?=
 =?us-ascii?Q?nxPZ4l/3iFe00d880ZkH4RRVB9h+7oQMSQk7wu/PZp/+oHTCjdzGMtIJ6u9R?=
 =?us-ascii?Q?mncHUTplkNkkCFY5Xf/UK3S1+9CJyFrPyV29iUYBU6+UEZpu7TJ3cJrabqRJ?=
 =?us-ascii?Q?Jvuh6UX07LzsDOYq5OT1pO76LeepTMscU2L+Aq5kJ/YzK0MjmFzOK5Pnrjvk?=
 =?us-ascii?Q?W3oOYUNjJcBrFbmHWmQsAw/Z6sz+t3Ss6pvccVeigREBIem0eIoh2kaEtqFJ?=
 =?us-ascii?Q?NgyYkKqcR5U6buN2LnYMNT+yJE1g3QSPmqJ4R7u2F0lP+DSErcx7ozrAtCva?=
 =?us-ascii?Q?8PWByc/fxU7k9Tuoum/72LFWuEw5foKRc86rAe5M52btxKWz6yN2npBKQNwi?=
 =?us-ascii?Q?mQTrinU+C4ZdgYDwE0L8Lh2F9pIylYtnja0J1T9mR0MT4RUEdGK+/dJcBy//?=
 =?us-ascii?Q?Mcs5oK1eGym8O2+Yi6EEFqAcSkX1bHbwywJ9xkyx4ykDsNTrQC28DBPj21fQ?=
 =?us-ascii?Q?gsc0PAsCd0/ge8wymlgPqeWIRYN8SzSYIPBJHsfqbIqEWS8tV91f8j8/8D1u?=
 =?us-ascii?Q?lz4QX6bfh5LXFbe3cDuHZBHSfXPn5RLTNrY7TnbJeLfJpZY9eOo7fVrQrWvw?=
 =?us-ascii?Q?fMQcuIU19EYFpKdoFnE+f5OOiRwj48G8D0RgeN8v1Wzo/NExO/6TfdtM8MAF?=
 =?us-ascii?Q?bFNgC+A6sDTauEpUvY38yZ6rfaq9Mqn1Khd/dsvb90Mu+LEl1cxweFcGelQP?=
 =?us-ascii?Q?8PMm6HSwn5wrbbh+/JrY/0D9toPr1nGPsWq0OTUagzercWxDdDNMfdsTd+Py?=
 =?us-ascii?Q?X7B6+btPN7z72Li/5TtygSzMFYRrs58CCqfS1eYPqkIHab7HyMXKu4M3m7H/?=
 =?us-ascii?Q?pqX+czzhMCRO9pni1nzbpf+oZprdAHJ4p6VfAIGHY2RhywMdc9vvcHtf9INa?=
 =?us-ascii?Q?bM8SDi6xnNzVojDUCW7dSMcDqp0iHKGoAhHZBDgQN9DFiJZsuvogha+m+bOf?=
 =?us-ascii?Q?E9IUns432mtAmNdIkkkoi4VPLrWfhCaurIn3FICVlNwio/oGH7pIFsJJLKI1?=
 =?us-ascii?Q?1Yw3ItgTczgN7t/TVkR525cpw0+c+/VYW6AgOjzmIe4TS5giPaumaj/O6nVw?=
 =?us-ascii?Q?Aem/M9tnZO24TIiXywmrzqi8j4Q8NAbNx2umP0fVg4gOR02AtpE08qXkl65g?=
 =?us-ascii?Q?9yHS1TS01l05ZoHkin4qkrTBUjeA7REvqBvHT0ml1V3e4RFcpVo25ACD0R5+?=
 =?us-ascii?Q?5mN0F60n0NepDWzrhztXW5InV9yzsee9fG95zRWCXjX1nd6ZHzD19oUIF5ir?=
 =?us-ascii?Q?UbYcMoyKIWcXaIadkqN17Si5SjI+EAZrL+aNWWJBb/5N2QE5vVba7NWtYevP?=
 =?us-ascii?Q?+VxgsXy5lYqKLb/IGzWYOB9+Rn0iirB6wqe1Mr0I4QmqDiOVf7sdzNMPwBU6?=
 =?us-ascii?Q?gjb+2Blkfg9ExIuLJTUzETr89ph5wtVRN4jr9Q35?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d218fda7-64ad-4275-0335-08dce88424fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:02:23.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mcdkMcT3I2Ps49yx0zslHtVZXQX/OMuFEBAwHcbOXB5oXaWk8F4cIvnNdjgzbhm1i1XIsPRpbxXxpgMxq/jqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897

On Wed, Oct 09, 2024 at 05:51:09PM +0800, Wei Fang wrote:
> The netc-blk-ctrl driver is used to configure Integrated Endpoint
> Register Block (IERB) and Privileged Register Block (PRB) of NETC.
> For i.MX platforms, it is also used to configure the NETCMIX block.
>
> The IERB contains registers that are used for pre-boot initialization,
> debug, and non-customer configuration. The PRB controls global reset
> and global error handling for NETC. The NETCMIX block is mainly used
> to set MII protocol and PCS protocol of the links, it also contains
> settings for some other functions.
>
> Note the IERB configuration registers can only be written after being
> unlocked by PRB, otherwise, all write operations are inhibited. A warm
> reset is performed when the IERB is unlocked, and it results in an FLR
> to all NETC devices. Therefore, all NETC device drivers must be probed
> or initialized after the warm reset is finished.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
>  drivers/net/ethernet/freescale/enetc/Makefile |   3 +
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 476 ++++++++++++++++++
>  include/linux/fsl/netc_global.h               |  39 ++
>  4 files changed, 532 insertions(+)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
>  create mode 100644 include/linux/fsl/netc_global.h
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 4d75e6807e92..51d80ea959d4 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -75,3 +75,17 @@ config FSL_ENETC_QOS
>  	  enable/disable from user space via Qos commands(tc). In the kernel
>  	  side, it can be loaded by Qos driver. Currently, it is only support
>  	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
> +
> +config NXP_NETC_BLK_CTRL
> +	tristate "NETC blocks control driver"
> +	help
> +	  This driver configures Integrated Endpoint Register Block (IERB) and
> +	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
> +	  includes the configuration of NETCMIX block.
> +	  The IERB contains registers that are used for pre-boot initialization,
> +	  debug, and non-customer configuration. The PRB controls global reset
> +	  and global error handling for NETC. The NETCMIX block is mainly used
> +	  to set MII protocol and PCS protocol of the links, it also contains
> +	  settings for some other functions.
> +
> +	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index b13cbbabb2ea..5c277910d538 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
>
>  obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
>  fsl-enetc-ptp-y := enetc_ptp.o
> +
> +obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
> +nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> new file mode 100644
> index 000000000000..b8eec980c199
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC Blocks Control Driver
> + *
> + * Copyright 2024 NXP
> + */
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +/* NETCMIX registers */
> +#define IMX95_CFG_LINK_IO_VAR		0x0
> +#define  IO_VAR_16FF_16G_SERDES		0x1
> +#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_MII_PROT		0x4
> +#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
> +#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)

need #include <linux/bits.h>

> +#define  MII_PROT_MII			0x0
> +#define  MII_PROT_RMII			0x1
> +#define  MII_PROT_RGMII			0x2
> +#define  MII_PROT_SERIAL		0x3
> +#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
> +#define PCS_PROT_1G_SGMII		BIT(0)
> +#define PCS_PROT_2500M_SGMII		BIT(1)
> +#define PCS_PROT_XFI			BIT(3)
> +#define PCS_PROT_SFI			BIT(4)
> +#define PCS_PROT_10G_SXGMII		BIT(6)
> +
> +/* NETC privileged register block register */
> +#define PRB_NETCRR			0x100
> +#define  NETCRR_SR			BIT(0)
> +#define  NETCRR_LOCK			BIT(1)
> +
> +#define PRB_NETCSR			0x104
> +#define  NETCSR_ERROR			BIT(0)
> +#define  NETCSR_STATE			BIT(1)
> +
> +/* NETC integrated endpoint register block register */
> +#define IERB_EMDIOFAUXR			0x344
> +#define IERB_T0FAUXR			0x444
> +#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
> +#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
> +#define FAUXR_LDID			GENMASK(3, 0)
> +
> +/* Platform information */
> +#define IMX95_ENETC0_BUS_DEVFN		0x0
> +#define IMX95_ENETC1_BUS_DEVFN		0x40
> +#define IMX95_ENETC2_BUS_DEVFN		0x80
> +
> +/* Flags for different platforms */
> +#define NETC_HAS_NETCMIX		BIT(0)
> +
> +struct netc_devinfo {
> +	u32 flags;
> +	int (*netcmix_init)(struct platform_device *pdev);
> +	int (*ierb_init)(struct platform_device *pdev);
> +};
> +
> +struct netc_blk_ctrl {
> +	void __iomem *prb;
> +	void __iomem *ierb;
> +	void __iomem *netcmix;
> +	struct clk *ipg_clk;
> +
> +	const struct netc_devinfo *devinfo;
> +	struct platform_device *pdev;
> +	struct dentry *debugfs_root;
> +};
> +
> +static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
> +{
> +	netc_write(base + offset, val);
> +}
> +
> +static u32 netc_reg_read(void __iomem *base, u32 offset)
> +{
> +	return netc_read(base + offset);
> +}
> +
> +static int netc_of_pci_get_bus_devfn(struct device_node *np)
> +{
> +	u32 reg[5];
> +	int error;
> +
> +	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> +	if (error)
> +		return error;

Avoid parse these common property "reg". if you need untranslate address
you can use of_property_read_reg(), if you need bus translated cpu
address, you can use platform_get_resource().

Frank
> +
> +	return (reg[0] >> 8) & 0xffff;
> +}
> +
> +static int netc_get_link_mii_protocol(phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		return MII_PROT_MII;
> +	case PHY_INTERFACE_MODE_RMII:
> +		return MII_PROT_RMII;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return MII_PROT_RGMII;
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_XGMII:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		return MII_PROT_SERIAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx95_netcmix_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	phy_interface_t interface;
> +	int bus_devfn, mii_proto;
> +	u32 val;
> +	int err;
> +
> +	/* Default setting of MII protocol */
> +	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
> +	      MII_PROT(2, MII_PROT_SERIAL);
> +
> +	/* Update the link MII protocol through parsing phy-mode */
> +	for_each_available_child_of_node_scoped(np, child) {
> +		for_each_available_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "nxp,imx95-enetc"))
> +				continue;
> +
> +			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
> +			if (bus_devfn < 0)
> +				return -EINVAL;
> +
> +			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
> +				continue;
> +
> +			err = of_get_phy_mode(gchild, &interface);
> +			if (err)
> +				continue;
> +
> +			mii_proto = netc_get_link_mii_protocol(interface);
> +			if (mii_proto < 0)
> +				return -EINVAL;
> +
> +			switch (bus_devfn) {
> +			case IMX95_ENETC0_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_0);
> +				break;
> +			case IMX95_ENETC1_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_1);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	/* Configure Link I/O variant */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
> +		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
> +	/* Configure Link 2 PCS protocol */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
> +		       PCS_PROT_10G_SXGMII);
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
> +
> +	return 0;
> +}
> +
> +static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
> +{
> +	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
> +}
> +
> +static int netc_lock_ierb(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
> +				 100, 2000, false, priv->prb, PRB_NETCSR);
> +}
> +
> +static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, 0);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
> +				 1000, 100000, true, priv->prb, PRB_NETCRR);
> +}
> +
> +static int imx95_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	/* EMDIO : No MSI-X intterupt */
> +	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
> +	/* ENETC0 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
> +	/* ENETC0 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
> +	/* ENETC0 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
> +	/* ENETC1 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
> +	/* ENETC1 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
> +	/* ENETC1 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
> +	/* ENETC2 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
> +	/* ENETC2 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
> +	/* ENETC2 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
> +	/* NETC TIMER */
> +	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
> +
> +	return 0;
> +}
> +
> +static int netc_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	const struct netc_devinfo *devinfo = priv->devinfo;
> +	int err;
> +
> +	if (netc_ierb_is_locked(priv)) {
> +		err = netc_unlock_ierb_with_warm_reset(priv);
> +		if (err) {
> +			dev_err(&pdev->dev, "Unlock IERB failed.\n");
> +			return err;
> +		}
> +	}
> +
> +	if (devinfo->ierb_init) {
> +		err = devinfo->ierb_init(pdev);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = netc_lock_ierb(priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "Lock IERB failed.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static int netc_prb_show(struct seq_file *s, void *data)
> +{
> +	struct netc_blk_ctrl *priv = s->private;
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCRR);
> +	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
> +		   (val & NETCRR_LOCK) ? 1 : 0,
> +		   (val & NETCRR_SR) ? 1 : 0);
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
> +		   (val & NETCSR_STATE) ? 1 : 0,
> +		   (val & NETCSR_ERROR) ? 1 : 0);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(netc_prb);
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir("netc_blk_ctrl", NULL);
> +	if (IS_ERR(root))
> +		return;
> +
> +	priv->debugfs_root = root;
> +
> +	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	debugfs_remove_recursive(priv->debugfs_root);
> +	priv->debugfs_root = NULL;
> +}
> +
> +#else
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +#endif
> +
> +static int netc_prb_check_error(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	if (val & NETCSR_ERROR)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static const struct netc_devinfo imx95_devinfo = {
> +	.flags = NETC_HAS_NETCMIX,
> +	.netcmix_init = imx95_netcmix_init,
> +	.ierb_init = imx95_ierb_init,
> +};
> +
> +static const struct of_device_id netc_blk_ctrl_match[] = {
> +	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
> +
> +static int netc_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	const struct netc_devinfo *devinfo;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *id;
> +	struct netc_blk_ctrl *priv;
> +	void __iomem *regs;
> +	int err;
> +
> +	if (!node || !of_device_is_available(node)) {
> +		dev_info(dev, "Device is disabled, skipping\n");
> +		return -ENODEV;
> +	}

look like needn't above check.

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +	priv->ipg_clk = devm_clk_get_optional(dev, "ipg_clk");
> +	if (IS_ERR(priv->ipg_clk)) {
> +		dev_err(dev, "Get ipg_clk failed\n");
> +		err = PTR_ERR(priv->ipg_clk);
> +		return err;

return dev_err_probe(dev, err, "...");
same for below error path.

> +	}
> +
> +	err = clk_prepare_enable(priv->ipg_clk);
> +	if (err) {
> +		dev_err(dev, "Enable ipg_clk failed\n");
> +		goto disable_ipg_clk;
> +	}
> +
> +	id = of_match_device(netc_blk_ctrl_match, dev);
> +	if (!id) {
> +		dev_err(dev, "Cannot match device\n");
> +		err = -EINVAL;
> +		goto disable_ipg_clk;
> +	}
> +
> +	devinfo = (struct netc_devinfo *)id->data;
> +	if (!devinfo) {
> +		dev_err(dev, "No device information\n");
> +		err = -EINVAL;
> +		goto disable_ipg_clk;
> +	}
> +	priv->devinfo = devinfo;
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
> +	if (IS_ERR(regs)) {
> +		err = PTR_ERR(regs);
> +		dev_err(dev, "Missing IERB resource\n");
> +		goto disable_ipg_clk;
> +	}
> +	priv->ierb = regs;
> +
> +	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
> +	if (IS_ERR(regs)) {
> +		err = PTR_ERR(regs);
> +		dev_err(dev, "Missing PRB resource\n");
> +		goto disable_ipg_clk;
> +	}
> +	priv->prb = regs;
> +
> +	if (devinfo->flags & NETC_HAS_NETCMIX) {
> +		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
> +		if (IS_ERR(regs)) {
> +			err = PTR_ERR(regs);
> +			dev_err(dev, "Missing NETCMIX resource\n");
> +			goto disable_ipg_clk;
> +		}
> +		priv->netcmix = regs;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (devinfo->netcmix_init) {
> +		err = devinfo->netcmix_init(pdev);
> +		if (err) {
> +			dev_err(dev, "Initializing NETCMIX failed\n");
> +			goto disable_ipg_clk;
> +		}
> +	}
> +
> +	err = netc_ierb_init(pdev);
> +	if (err) {
> +		dev_err(dev, "Initializing IERB failed.\n");
> +		goto disable_ipg_clk;
> +	}
> +
> +	if (netc_prb_check_error(priv) < 0)
> +		dev_warn(dev, "The current IERB configuration is invalid.\n");
> +
> +	netc_blk_ctrl_create_debugfs(priv);
> +
> +	err = of_platform_populate(node, NULL, NULL, dev);
> +	if (err) {
> +		dev_err(dev, "of_platform_populate failed\n");
> +		goto remove_debugfs;
> +	}
> +
> +	return 0;
> +
> +remove_debugfs:
> +	netc_blk_ctrl_remove_debugfs(priv);
> +disable_ipg_clk:
> +	clk_disable_unprepare(priv->ipg_clk);
> +
> +	return err;
> +}
> +
> +static void netc_blk_ctrl_remove(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	of_platform_depopulate(&pdev->dev);
> +	netc_blk_ctrl_remove_debugfs(priv);
> +	clk_disable_unprepare(priv->ipg_clk);
> +}
> +
> +static struct platform_driver netc_blk_ctrl_driver = {
> +	.driver = {
> +		.name = "nxp-netc-blk-ctrl",
> +		.of_match_table = netc_blk_ctrl_match,
> +	},
> +	.probe = netc_blk_ctrl_probe,
> +	.remove = netc_blk_ctrl_remove,
> +};
> +
> +module_platform_driver(netc_blk_ctrl_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> new file mode 100644
> index 000000000000..f26b1b6f8813
> --- /dev/null
> +++ b/include/linux/fsl/netc_global.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/* Copyright 2024 NXP
> + */
> +#ifndef __NETC_GLOBAL_H
> +#define __NETC_GLOBAL_H
> +
> +#include <linux/io.h>
> +
> +static inline u32 netc_read(void __iomem *reg)
> +{
> +	return ioread32(reg);
> +}
> +
> +#ifdef ioread64
> +static inline u64 netc_read64(void __iomem *reg)
> +{
> +	return ioread64(reg);
> +}
> +#else
> +static inline u64 netc_read64(void __iomem *reg)
> +{
> +	u32 low, high;
> +	u64 val;
> +
> +	low = ioread32(reg);
> +	high = ioread32(reg + 4);
> +
> +	val = (u64)high << 32 | low;
> +
> +	return val;
> +}
> +#endif
> +
> +static inline void netc_write(void __iomem *reg, u32 val)
> +{
> +	iowrite32(val, reg);
> +}

why need two layer register read/write wrap?

netc_reg_write() -> netc_write() -> iowrite32();

Frank
> +
> +#endif
> --
> 2.34.1
>

