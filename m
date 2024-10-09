Return-Path: <linux-pci+bounces-14102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F69972D8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 19:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987432814CE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0313F43A;
	Wed,  9 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzWUKdR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013028.outbound.protection.outlook.com [52.101.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6360D14A611;
	Wed,  9 Oct 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494192; cv=fail; b=GHhr5zIGMk4CDbAXZCiXzaGrUJs5bufFrXqMZSF3KBR40bPAnHNKa+Q6CvveFJcW+U98/IA+dEY9d6lH4iTMtgPZiVcUpUhhfnXkDNMk3cqHST/7V2V1lUulusQwPWGCBsQ3LdCI6Oem/SHVPPhVRG/ToEXYnGYsCaZaPp6BjzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494192; c=relaxed/simple;
	bh=xxwJIB8mBkt9+x1xa9N9ZKXd1+9F1eRbvN75zyoxuds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFONATnKXwrN2T5Xuxe/S1hWhuGxeE4ixutzwkbJA0nVPXFNwN6A9YNTP/+4O1ZZz2RW9DeJNRNfABH8ybHwkdDQBspjr3JVRi+ySwDYzIhYPMLVN5HGxoImQ48KY9HSd+5g+CDnUJRelqGSa8c6NBteCFKQ4Hi41qdahcW+zOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzWUKdR5; arc=fail smtp.client-ip=52.101.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blLyCSwaSapWHClMINFfJEvdhMtFdMk0T7aUAKcPuy4YF8aFA6czVyeTex3KL0BaSRZAWDzyg6Puh0kw6uo0anRll6T9lreFW2Vgb60ufL595UVoQEHVqFHipaNVzfmJwqk+1c2pfKZJ10EFOAizJ/UxSicNNhn6cdD3ew2EjTqzGdTbQQ6UChAVS/ygd9AF+6vlWd//RCFfibFpDpmReM4xrzaPOd1ne19zCWWweePbUT/eRCUkYKhS7vDngfsZzu61VR6rnapY0BzKfMOKJGEjf44B2Ty0Lrd4gSgB/P8bK72c/n+DEFL9pVo3/a8FPcpb9SASzg20SaqY3AEbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQoXHRq1QKo/C6d/g+MQQPf578U6DVhKFiFy0+bM/xE=;
 b=OyTnWQb8+tuOQpgrTXsKMNtHN+SeEEmO7gN3fYmYC2UnpXbVdloXrKOiAeDPUm43/lNuRpC7UseHhBydXhrTP2jyjF2rdHyITE/NXGC0P7fWYWzdHxXbkGqfOvbJcnzYvLypaWVMmTUa7N9fdIYNyW/HfJgBb7Mbc9o/RIAg901rIMaqKt/6b64gNpdvHjeXpHb7B3YgrPrTcDSvdGteOmyhvSJMZA4HeCjR+aiUZ9gNTB7c1Sur3jUGOiKbLf57n/xh3WzOAqUW/emt0Jq8Dh269pYtXLywmLyBHvLf5CSmthyHcJAH7oMB0zg5UsjeRkjU7XkBed5eao0Gu+Us/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQoXHRq1QKo/C6d/g+MQQPf578U6DVhKFiFy0+bM/xE=;
 b=MzWUKdR5Z0YpdW2rjUh0mKp1I0Gp3XheFo3tiPgVyBxnKkxJNDp9KopT5tHZ9RbgmENwE+IjtUym5U4NDVZikHO40fiUwBAG68NGA3qenPwildPDJHLx2PpcKzNUS/Gd2qvdZcOWhjDWPje7DC8QhB1E66YEge0X7x2RerQnYAq5F3vXJjE7CN7aw7jU9whn/x2KFTeQS1trSwooL9JgywtgwQHAd+vd76zCsp9QVhrjT6sAsO0aPJ0lpJHLUGaYFMmvlLKVhq6Z+e98QGTYLPm/VWDMVR63hGhqv2Zwt5fp7ccrQPsrAm5Da2QUdM2NhtH7Zdh6MHS7Vzt634AV9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:16:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:16:25 +0000
Date: Wed, 9 Oct 2024 13:16:15 -0400
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
Subject: Re: [PATCH net-next 05/11] net: enetc: add enetc-pf-common driver
 support
Message-ID: <Zwa6X0sz7VfKG8/f@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095116.147412-6-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:a03:100::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c88b4c5-ea01-4e13-2ff7-08dce8861a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJqCqRIxYrzf3hQryPXdiURghgpUsczzaMkGBS+eqmrj+MinyJa1Iyfmh068?=
 =?us-ascii?Q?a7C5OXZgXD2d0eXZndv4mpgyzpEJ6rU8ngOUVVNF//KiL+lL+tOLyHRCRUQa?=
 =?us-ascii?Q?ugdT4iEWa7OsLtopcFUlKYRpde4Z2p0NxIAS4X85DXiJ/IRSqjukwzhH4yNB?=
 =?us-ascii?Q?qrpb6D9JsL5aT6iGlZf70F9Hn3zRm18Ycq2SLN4NZtFVbd7IpPfLbHLRBIxm?=
 =?us-ascii?Q?4awoEVIhLwFGT5yNoonVg0eqiYqiKsqpo9n5q4otO1KuZbynIVvqFG8yd86s?=
 =?us-ascii?Q?hTZerPQz/Rmy8Ql0zfm4lg+hPg2unEQOvXCSO7gBdJjGT31CjzWPMw1cO6sJ?=
 =?us-ascii?Q?x2l4P+JE4p73QYermRfSVqTwIILEPBaqFyXzKLWk6E9tLXTNZZjQtEKqFLTe?=
 =?us-ascii?Q?T0n9K+aNdpaxQDSKxM+jgAvWen4Uj3w0/uHbOygK/5UlLo5hxn8/nH3u3gh3?=
 =?us-ascii?Q?eNnWEzr99cyZSkh177ICZsAEVOIfpNPqklzkAObK6H4NibjDUULuUMvKBcBO?=
 =?us-ascii?Q?FzxC61QBzGT1hzRjhzMYR/acVm7PBkmO2ntmdW5UQV/0Eqed3s46tPxXF4mV?=
 =?us-ascii?Q?xsWOsknjRTL6SH8FcBIUx+XXBSdks0E5QOoHvaBL2LcI7Ln5h7su0xlccxuA?=
 =?us-ascii?Q?l0K/8aqoR8MBySIuItK1jK4Pov/qAqiDtQ+rOlaqrWOOfJWg68SZxruj0ziJ?=
 =?us-ascii?Q?q+xA+M/+07nWqfWHy66KqSO+vd7zqqDP/777fjkOqN0mc0zn7JOww3X4l8zd?=
 =?us-ascii?Q?nYjwMB023lbfymgLtHwACUsEteMRqVzfEEVVKrXc0TdeFGrKWyARsoxhZgVU?=
 =?us-ascii?Q?GazRFbbKQTwKEHmyol+tsOi5jDIvWp6LeWBnjo/HZEKSczWJYACpbbTfi2cM?=
 =?us-ascii?Q?9ERCIPXPugL/R2ARrm8lO1RPmu/JPDuG1DUWINWbxbescL+OMTurOqld5wp5?=
 =?us-ascii?Q?fCmcMRjNn39farWgggdCQBsjvh625GqtZtwbE9nEnwrgiJg7fQGBA5YDfoEK?=
 =?us-ascii?Q?od91SqxThnQNbAEn6g3szmiA30CY/9Y2wbwESxOtI2VuCN7BYorjm0j56KiQ?=
 =?us-ascii?Q?zS7Io9o207ePqMFChgFQKmrOawy8dMBDY1mwRyWnKIJtLzFW3t+3asC0Vn8n?=
 =?us-ascii?Q?Nspvq+gfHr9cO6A9Il7NHwUBLTGDwMNhKlqK11WD0L4dKm3OiCtuiApimKA/?=
 =?us-ascii?Q?aT10q+CqO4JvmIB1+AcoIuwD9LJepxxzqmck9tAnGAGxXEWHYtxoR2+28g7z?=
 =?us-ascii?Q?2WzdqoUbfr9uLr2afK3l0Dro0kg4NWXrIOEZgiNC1a1oz7yvA3MnYkEJk0e4?=
 =?us-ascii?Q?/QPUVOWNzfRXRuaJCcs0IeGRuQeudp3xnUbVDLhAiQ0+Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BeLUuS59xLzJ0DXjk2ADZgBGd9rqH6bOc50OJxmXKso0MtXweLGBOQYJwmeQ?=
 =?us-ascii?Q?M0/obDAE/yZbwS5aQ+SmNYpMAusASwXGefy6KRnZ8t97I3VzqUOvACK4VW8U?=
 =?us-ascii?Q?s1pkrdci12j2D3Gh9eWbY1bNmT0vLxo8hE9NgpUxPGeNXObLhGAjTEn5TyO6?=
 =?us-ascii?Q?tjbvPMVeKCXblD4R6RY5E+wlmJ3rO7pDKFKH3qms8CFpG8tVYuKCgarQl7pw?=
 =?us-ascii?Q?ZbwSzU7Z290Dqe17Ziljdu1nQzYPJym+mcnPjRe4hdClooV7UN4RkobBi8Nc?=
 =?us-ascii?Q?watTlzwCpZUIQKd2nPzc7mMHT3034LXhsMR4zKXDXr9WTN3n938vD4AsNmrK?=
 =?us-ascii?Q?l8Xbk4m8SUnBzQnkIJtuqqbuZbqumrcbmJXjgnNx+wun8eOFVAsaE4WyQ6wY?=
 =?us-ascii?Q?3kGer5QgVBJHJQyHTsnYXMS4qozwkAHM4NP0wb+pwZAiMXgnNlel1y4sf8et?=
 =?us-ascii?Q?ScTOP8sF4s/dGuCKcIaRNqp2Dg1wSxi9mD4He4Ba4BxztQUngNlU03vrR2x0?=
 =?us-ascii?Q?X09KkB4ZpS8QS/D01p5ROPgU3ilQl79CBhGjhz0PzfUAXHGy1JYK4EJnA0fQ?=
 =?us-ascii?Q?EQaE4QR7aIOF8ftmlRc41reptS7D9FE6nMwHGR7Ssse4i1IEe79KI6omY4W8?=
 =?us-ascii?Q?jeWDk9xj1gOfEMtnODoO75p6ThhaBatbEq0PKIQnCB4WtaA6HSB+t3V6TDGU?=
 =?us-ascii?Q?+YA2NgS6Hci1N/j9nws5KtDYwVpN+eoo9ZSlCv8CUKAIpZSlzalfAT1JrPi2?=
 =?us-ascii?Q?E09i7hhtA2FUuD4VBb2Q6Vi7JhqcX9wh63Llpca7nC4prmWhft8o9mb5ayuZ?=
 =?us-ascii?Q?5kGYdGAGHFiN3c/6gCXMjCVTqAy4fp8o2Mzt0zksLHNJzNVJj66rJ+4q1l5D?=
 =?us-ascii?Q?RDcPqI1NiVjtEjFRY+LEkng4PR/H2x0ZG6hnI9gyG1fwvm2nGISbpgoKyn8x?=
 =?us-ascii?Q?qR5xteZt8+zAbJwzfuhMC+qPnh+6Fgu7bWV+v9dCB3eJ47wbCuuG7DNFTn+t?=
 =?us-ascii?Q?Pks696lht3z4lWzffNpFvSA0b1ey3bi20qOwdStsdKQpBJBL5CpQ55t4iuHm?=
 =?us-ascii?Q?ODMJT51WM/RlJNluGRyxrSk5dw49pJxRf37B9u2yJubUFGq/t/AfJ9BBnOaO?=
 =?us-ascii?Q?/04jnEtanB4HPQAbnBBtTJqMsWJ2Fpb0erbWRP9K6nQonx/CWKfaVURystq4?=
 =?us-ascii?Q?vmLGjv/rk17PtwFZF3JwYsS3mjrg+XUymzdaAGTnVuvL4IsCARalZFwm7eag?=
 =?us-ascii?Q?Ink9dLUIKVShWOSx0oM3P2rfk2i3+MFiOlrU/Q1ZaQOr9Jp0vfutsEdn7dED?=
 =?us-ascii?Q?MCwM17RIDVHh56XDeAwPu6wteR9dLNTsTf+VryYgtyKL/W3L2rbLKLjqoqHI?=
 =?us-ascii?Q?MfUjfBWN6Vbgbo4YJuurZkP8wPJP0tsomteWZch3gQ8j//ixGLfagQXQ+Tlq?=
 =?us-ascii?Q?AhS+h8KPFe8YCkj+tX/g0NQouJiBXyoUAnbWJ5A/GSKZuGBU2ndcgee3fRin?=
 =?us-ascii?Q?W5l7y787IV9WXXb+UD3cD0HIiOBZqgVrQ0aNtV7A817RGoRSXzZycL67YtzS?=
 =?us-ascii?Q?ZEpleNijc8id9NS3W1c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c88b4c5-ea01-4e13-2ff7-08dce8861a9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:16:25.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QIY1WE0B0oOSr3WrxQeXjx/TKYRUx4kqvlbw8/ewgOoTtYBfG+kbcgQyKomagr7uVTDDnRXzQvxkJOHgjUTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

On Wed, Oct 09, 2024 at 05:51:10PM +0800, Wei Fang wrote:
> The ENETC of LS1028A is revision 1.0. Now, ENETC is used on the i.MX95
> platform and the revision is upgraded to version 4.1. The two versions
> are incompatible except for the station interface (SI) part. Therefore,
> we need to add a new driver for ENETC revision 4.1 and later. However,
  ^^^^^^^^^^
 just Add a new driver ...

> the logic of some interfaces of the two drivers is basically the same,
> and the only difference is the hardware configuration. So in order to
> reuse these interfaces and reduce code redundancy, we extract these
                                                     ^^
extract these .. in order to ...

> interfaces and compile them into a separate enetc-pf-common driver for
> use by these two PF drivers. Note that the ENETC PF 4.1 driver will be
                               ^^^
Prepare to add support ENETC PF 4.1 driver in subsequent patches.

> supported in subsequent patches.

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |   9 +
>  drivers/net/ethernet/freescale/enetc/Makefile |   3 +
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 350 +---------------
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  28 ++
>  .../freescale/enetc/enetc_pf_common.c         | 375 ++++++++++++++++++
>  5 files changed, 431 insertions(+), 334 deletions(-)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 51d80ea959d4..6f3306f14060 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -7,10 +7,19 @@ config FSL_ENETC_CORE
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
>  	select MDIO_DEVRES
> +	select NXP_ENETC_PF_COMMON
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_IERB
>  	select FSL_ENETC_MDIO
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 5c277910d538..b81ca462e358 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -3,6 +3,9 @@
>  obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
> +obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
> +nxp-enetc-pf-common-y := enetc_pf_common.o
> +

I am not sure why you can't link enetc_pf_common.o into enetc_pf.o?

Frank

>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
>  fsl-enetc-y := enetc_pf.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 8f6b0bf48139..dae8be4a1607 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -33,18 +33,15 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> -static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> +static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
> +					       struct mii_bus *bus)
>  {
> -	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -	struct sockaddr *saddr = addr;
> -
> -	if (!is_valid_ether_addr(saddr->sa_data))
> -		return -EADDRNOTAVAIL;
> -
> -	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> +	return lynx_pcs_create_mdiodev(bus, 0);
> +}
>
> -	return 0;
> +static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
> +{
> +	lynx_pcs_destroy(pcs);
>  }
>
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
> @@ -393,56 +390,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
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
> @@ -656,55 +603,6 @@ void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
>  	}
>  }
>
> -#ifdef CONFIG_PCI_IOV
> -static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
> -{
> -	struct enetc_si *si = pci_get_drvdata(pdev);
> -	struct enetc_pf *pf = enetc_si_priv(si);
> -	int err;
> -
> -	if (!num_vfs) {
> -		enetc_msg_psi_free(pf);
> -		kfree(pf->vf_state);
> -		pf->num_vfs = 0;
> -		pci_disable_sriov(pdev);
> -	} else {
> -		pf->num_vfs = num_vfs;
> -
> -		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
> -				       GFP_KERNEL);
> -		if (!pf->vf_state) {
> -			pf->num_vfs = 0;
> -			return -ENOMEM;
> -		}
> -
> -		err = enetc_msg_psi_init(pf);
> -		if (err) {
> -			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
> -			goto err_msg_psi;
> -		}
> -
> -		err = pci_enable_sriov(pdev, num_vfs);
> -		if (err) {
> -			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
> -			goto err_en_sriov;
> -		}
> -	}
> -
> -	return num_vfs;
> -
> -err_en_sriov:
> -	enetc_msg_psi_free(pf);
> -err_msg_psi:
> -	kfree(pf->vf_state);
> -	pf->num_vfs = 0;
> -
> -	return err;
> -}
> -#else
> -#define enetc_sriov_configure(pdev, num_vfs)	(void)0
> -#endif
> -
>  static int enetc_pf_set_features(struct net_device *ndev,
>  				 netdev_features_t features)
>  {
> @@ -775,187 +673,6 @@ static const struct net_device_ops enetc_ndev_ops = {
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
> @@ -1101,47 +818,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
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
> @@ -1259,6 +935,13 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
>  	enetc_pci_remove(pdev);
>  }
>
> +static const struct enetc_pf_ops enetc_pf_ops = {
> +	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
> +	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
> +	.create_pcs = enetc_pf_create_pcs,
> +	.destroy_pcs = enetc_pf_destroy_pcs,
> +};
> +

I suppose this patch should just move functions to common.c. This involve
addition code logic change. It is not easy to follow up to make sure your
change is correct.

Frank

>  static int enetc_pf_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *ent)
>  {
> @@ -1286,6 +969,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	pf = enetc_si_priv(si);
>  	pf->si = si;
>  	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
> +	enetc_pf_ops_register(pf, &enetc_pf_ops);
>
>  	err = enetc_setup_mac_addresses(node, pf);
>  	if (err)
> @@ -1338,7 +1022,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	if (err)
>  		goto err_mdiobus_create;
>
> -	err = enetc_phylink_create(priv, node);
> +	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
>  	if (err)
>  		goto err_phylink_create;
>
> @@ -1422,9 +1106,7 @@ static struct pci_driver enetc_pf_driver = {
>  	.id_table = enetc_pf_id_table,
>  	.probe = enetc_pf_probe,
>  	.remove = enetc_pf_remove,
> -#ifdef CONFIG_PCI_IOV
>  	.sriov_configure = enetc_sriov_configure,
> -#endif
>  };
>  module_pci_driver(enetc_pf_driver);
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index c26bd66e4597..ad7dab0eb752 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -28,6 +28,15 @@ struct enetc_vf_state {
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
> +};
> +
>  struct enetc_pf {
>  	struct enetc_si *si;
>  	int num_vfs; /* number of active VFs, after sriov_init */
> @@ -50,6 +59,8 @@ struct enetc_pf {
>
>  	phy_interface_t if_mode;
>  	struct phylink_config phylink_config;
> +
> +	const struct enetc_pf_ops *ops;
>  };
>
>  #define phylink_to_enetc_pf(config) \
> @@ -58,3 +69,20 @@ struct enetc_pf {
>  int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
> +
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
> +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> +			   const struct net_device_ops *ndev_ops);
> +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
> +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *pl_mac_ops);
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> +int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +
> +static inline void enetc_pf_ops_register(struct enetc_pf *pf,
> +					 const struct enetc_pf_ops *ops)
> +{
> +	pf->ops = ops;
> +}
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> new file mode 100644
> index 000000000000..bbfb5c1ffd13
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/* Copyright 2024 NXP */
> +#include <linux/fsl/enetc_mdio.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +
> +#include "enetc_pf.h"
> +
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
> +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
> +	struct sockaddr *saddr = addr;
> +	int err;
> +
> +	if (!is_valid_ether_addr(saddr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
> +	if (err)
> +		return err;
> +
> +	eth_hw_addr_set(ndev, saddr->sa_data);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
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
> +	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
> +		pf->ops->get_si_primary_mac(hw, si, mac_addr);
> +
> +	/* (3) choose a random one */
> +	if (is_zero_ether_addr(mac_addr)) {
> +		eth_random_addr(mac_addr);
> +		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> +			 si, mac_addr);
> +	}
> +
> +	err = enetc_set_si_hw_addr(pf, si, mac_addr);
> +	if (err)
> +		return err;
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
> +EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
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
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
> +	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> +			 NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
> +	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
> +			      NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4;
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
> +EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
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
> +static bool enetc_port_has_pcs(struct enetc_pf *pf)
> +{
> +	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
> +		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
> +		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
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
> +	if (!pf->ops->create_pcs)
> +		return -EOPNOTSUPP;
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
> +	phylink_pcs = pf->ops->create_pcs(pf, bus);
> +	if (IS_ERR(phylink_pcs)) {
> +		err = PTR_ERR(phylink_pcs);
> +		dev_err(dev, "cannot create pcs (%d)\n", err);
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
> +	if (pf->pcs && pf->ops->destroy_pcs)
> +		pf->ops->destroy_pcs(pf->pcs);
> +
> +	if (pf->imdio) {
> +		mdiobus_unregister(pf->imdio);
> +		mdiobus_free(pf->imdio);
> +	}
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
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
> +
> +void enetc_mdiobus_destroy(struct enetc_pf *pf)
> +{
> +	enetc_mdio_remove(pf);
> +	enetc_imdio_remove(pf);
> +}
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
> +
> +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
> +			 const struct phylink_mac_ops *pl_mac_ops)
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
> +				 pf->if_mode, pl_mac_ops);
> +	if (IS_ERR(phylink)) {
> +		err = PTR_ERR(phylink);
> +		return err;
> +	}
> +
> +	priv->phylink = phylink;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(enetc_phylink_create);
> +
> +void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> +{
> +	phylink_destroy(priv->phylink);
> +}
> +EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
> +
> +int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct enetc_si *si = pci_get_drvdata(pdev);
> +	struct enetc_pf *pf = enetc_si_priv(si);
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_PCI_IOV))
> +		return 0;
> +
> +	if (!num_vfs) {
> +		pci_disable_sriov(pdev);
> +		enetc_msg_psi_free(pf);
> +		kfree(pf->vf_state);
> +		pf->num_vfs = 0;
> +	} else {
> +		pf->num_vfs = num_vfs;
> +
> +		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
> +				       GFP_KERNEL);
> +		if (!pf->vf_state) {
> +			pf->num_vfs = 0;
> +			return -ENOMEM;
> +		}
> +
> +		err = enetc_msg_psi_init(pf);
> +		if (err) {
> +			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
> +			goto err_msg_psi;
> +		}
> +
> +		err = pci_enable_sriov(pdev, num_vfs);
> +		if (err) {
> +			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
> +			goto err_en_sriov;
> +		}
> +	}
> +
> +	return num_vfs;
> +
> +err_en_sriov:
> +	enetc_msg_psi_free(pf);
> +err_msg_psi:
> +	kfree(pf->vf_state);
> +	pf->num_vfs = 0;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(enetc_sriov_configure);
> +
> +MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.34.1
>

