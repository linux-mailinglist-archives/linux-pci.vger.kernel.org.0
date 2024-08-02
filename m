Return-Path: <linux-pci+bounces-11208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0494647F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA23E1C20D6A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4C52F6F;
	Fri,  2 Aug 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEmHVZup"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE746B91;
	Fri,  2 Aug 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631234; cv=fail; b=fE+YNQjHkT/erLN1NPM31HwJ71yEfeVMIwDIaehsghjHv/XG3x3K3IVrWvAufs7omMZKTSsGO/o37Mg6C9ppIyc+1dkYZWN9BhcQN0EUXPh8rUpog2AjCY9tFDGRD9CafY40JQfOiCpbyE5WQmwDlAVtVL8+uSG4UM4yvugIyXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631234; c=relaxed/simple;
	bh=phZWrhyaIKOQooo13AdHiRXMNtXX5tvq3DiTIH1er58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aNj7p7j+bMK20Mi33UsELnWywW1Qhedj2b+mzVbPjBfs5ItPcoQ/Z1/BEUvu0KQvVzb0l2+pEgCE1G6zc9PalvwoJ9w22KBcx20w3cI4EqbPVmuB/9HhBHUK4d61SXUxI6DoKqotzo4kh2C920O1qolUdL5XgE/lOCuheWjT1Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEmHVZup; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUVYliy7rDRdfj5DTstl+86plpCaXn9CK7ILMNmIq+tH3n9aEKPKTrPQQ5f6kiRu3xmdPA2vaNDD1ImMXDtTWBxXKBn6dgA2zfI/gRtup7MG74RKqvMZ2TonAjRRS0uxFEFlwynZ6GRekO1gTnX/fKVTSrgWa+NcUFDRK72Wd4/qcAl/L3akbIpZljmmK6XM+1ObXcM4TNIoBh+7vey+2rFjU+biAHO6ZYH81j9f565+58cUqX32R3LGN+a9qwZAyKb5WymaOCVDDmKnyDtsYKkTZ2Mq5io6bZLey/TIgQ6VOuw8Tgoff5MgFTsp3HlHBg9M8OZ74pTYu/6qF9MEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q504bXHPriyeE8co2B5u4rQzqSpkC/JSh2slGltCEYA=;
 b=Vb3l35cCppVaF7+8XoU2q4pWo3ro9dEUOSkJPRC9Ks0FlDOP43tGdbEV8r2Cg3uT2QTheOe1qwR1jHqSSV4fDohtMoSS9GHtWQfcGG9q71E5I+Z73znct4DTz8FX6Vhl979ibeJjIsU3B8cyrm+49lJ3GVy7Bi/qzzkdfJQXUybN1lqbJ3nmCqxWdZKq/1yATZPZ2PMyLMF1xD8CjCo6V6UZbiMR4S6usTXB3VoKyMVQsJbkn8RjNN6uEdQY9UeXxkeH18qTqJDWj4Wkq1V3bliEqSwyPe3OaS3TDlh44L+IShGJMv6+Eq+2rEnp79oOLbLWNtVIE+N6iIxbsIXpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q504bXHPriyeE8co2B5u4rQzqSpkC/JSh2slGltCEYA=;
 b=iEmHVZupUYt+uDY/ot5ynIuefNKbkoqz1rYfDihK/j1gAxy02vQ+h4ZiklIxqBWRmHiFzO5Mx2VkmUQ/YfPqh6eh1h5somc+PebsFfXMbVoQyVkVaThZRzYx8l8ZiZcMiAt9ZjZxTKQDoLExE99h9xt2IKDS9eXckdkvWtzTibDpMmcdbPALpxS5xkoqrjAr0xcxw9DEOMlVam9QStZZy8zd8k/3qDduv8gIT7v6NRy7aVm4vlg8TD2Fnirrpetg5C7cxfBb04h87qikbHHA08HOf6WWZWour3QY9nGnbCx+ay/sAhfs4IP0VAjOnhX9I5SREqH/xzsCR3Lm/tOEzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:40:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:40:28 +0000
Date: Fri, 2 Aug 2024 16:40:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 2/5] ata: ahci_imx: Clean up code by using i.MX8Q HSIO
 PHY driver
Message-ID: <Zq1ENJ+5A4aUEqhX@lizhi-Precision-Tower-5810>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722581213-15221-3-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0de50c-00d9-4243-d2f6-08dcb3335836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a4h3ZG2xCciN8/rSyQyVQMHtcB+JRGu8eejS121ys4ysHVN33JsR4cvVDez5?=
 =?us-ascii?Q?5EfQ7PYYjGLm1qlgmjCYLnRacHlfJ42kqZjPZntDOrsImbNDYN2nL66olHNO?=
 =?us-ascii?Q?8l/qzID5fIC0EwCQso1AjBirJou18EeOA00ZaPl99S74hrga8A4gkK+GU/jr?=
 =?us-ascii?Q?3xW91AvNWZSbPpw0W431TYTxB27U7BDiBHRwMomqd5ssRVNd69e6r6p0Nm9K?=
 =?us-ascii?Q?XPcNq/+jvgD4lGx1Hg+2Mc6ZYYyb8F9YN9AuygnFiIXFjGjrdvDa9kq2vSHO?=
 =?us-ascii?Q?4h/Ht2GFnrYw+UFnXZ7uo4QkIA8Td2EODu0yyoR5QIyqAH98Tnn2D0z++3jW?=
 =?us-ascii?Q?sjF5f7azo101Vd4o7l+KkBzTbtzSq5EsEzR1fuCiz1txKNfCOux3/A3w03jl?=
 =?us-ascii?Q?8Nq9P2+JIcAYZdqi9OL+KU8sQFjdazEMN3fJLPq4FH5SN89LVGF3+QEJ0S4L?=
 =?us-ascii?Q?4GthkNr8lUxBmYYtL5ZMGjPxA7HxZP7glGjjd5UdBJbnqg7MYfGkUHN+Q07l?=
 =?us-ascii?Q?a2UzsjxEH0JSk9sbZBRbu0FPwLEnbU5RVe8snirL280p9kN2Y8u7MjdJxldV?=
 =?us-ascii?Q?lKmrF5Kcyk2FUhg8DHfEBl99BN+lSuXLm9LcT8ZUpGXzqIr1EIWVYyVUIjPr?=
 =?us-ascii?Q?/bs83GqgSVaqFOscFCLrd06DuX2tcovAZTmsjRa/g+zSpLWohga+UwzNEZkU?=
 =?us-ascii?Q?eb+8D8QlilJSYZqbunMCWGNYlKQ1BQpi/ELkNc2EX3BLllTyjLu48s2Rien2?=
 =?us-ascii?Q?cY7Mn1vBX9/qQMWlw2+eNYWiGZ6ALqbiWA2z9iwtcmmesbGC29Ww38qsxKF8?=
 =?us-ascii?Q?arRSc1ZGoNUZhY1cz3ed5ElAZHjLod8bLaJmkR87PqKOyHrCVsehTRSiRCIt?=
 =?us-ascii?Q?Y+FwXtFTFXqL0e1/yNEmxhkmRXT2wJmzANo1LClqqq2y1lfw0Gez+IC5Hz9X?=
 =?us-ascii?Q?5tfM1o0564Af3T1b2vnEKHCY5PSFtHBrUbKXwzoPQxknx31Yu6+ZvoWL7vpk?=
 =?us-ascii?Q?Dybe7AMn7kf51OaRwY/NubncrOGRtALBO74tAXcxFkACYoX7CLYjYXGFTMDP?=
 =?us-ascii?Q?rkEyx5P0BsCdhi12Q7BRqbbGPdb908zC8WDuKm66rFDKL+S5XPzjjViggo53?=
 =?us-ascii?Q?AaMMk8oevMZMt+f6BrpwuZaUIbZbxK0pkv8X1lMCA+9HLbH2g5PycS7uae7T?=
 =?us-ascii?Q?sv4S7J5lvvOEQ29GmWTCN+uu1uJ6luyvvW96Br0hcTGZ+ZL9rhjRFCB/sIKS?=
 =?us-ascii?Q?Ahvo0hpi9/05PtIlA/kmjXGsoNPSHWfNTiF5YfUH7HsYRZEACzg7tBVmJXU9?=
 =?us-ascii?Q?C7MFLDKmkBmrM9UN9cI2vM2Asd1LCRetZ8aeTBDdSCpVC1CGAtPN71eiOM3B?=
 =?us-ascii?Q?huA7mENkTNCUGSyFOnzWwgH/5Mgx5B5yXZCpop4VlINgj3muJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+4lX+GHD0oEi8NCdOIJKPtYnfWqgE0iiwNb5m/PLnEuuo4uNXcESsvYuHVo?=
 =?us-ascii?Q?5wWVHcMVQ4wRQJsq/GHvvZJF2pCY+tXmFxf6DdPvM1O/WHvLtgwLp/fFcNhu?=
 =?us-ascii?Q?gxpOSz8UA2kKDRDSnX4YJmOhN0agmyM10TQPrL0sY4F9Z2daBLtY6PtsOnKl?=
 =?us-ascii?Q?tKX5/JJ8HUPw6lcRH3ibELW1IHq87nt0+98CnCVoVw76BJYr5mseDBAR11GT?=
 =?us-ascii?Q?NehKID85EySbGxCZL5jNkjXedUSyxYiUTK0nCzYcDQptuYffJaFJjUJYLy1x?=
 =?us-ascii?Q?5cD8hLCadAbfztZPAi4dpE19aviNbe2F+cdb1P1Pha6M/cvbrRY2tNYRUw59?=
 =?us-ascii?Q?7MOlUROGUTNacPVA5gv5eL5gVboqHu1LMbBSyJgDzkn4AyGm0u/Xb4fAh2it?=
 =?us-ascii?Q?MQH2jftMpfkrRF6JJvMFpVVCgB4bwI/EIibqtCbxuvywdkcG+i1x6AFtXQW/?=
 =?us-ascii?Q?wGEnoJ1VKDyC0+uMHfbRceismr7DwJ50E+3ARXZ8OPe0b07pkMTXwTQlqH8w?=
 =?us-ascii?Q?MVGA2TXkPE5sL5ftfcYdzJrjSqhRkVKgM2p2suTQIHL/PbihpZK4eoVV4zpb?=
 =?us-ascii?Q?Y2vA6KbNy02XV6dSw8Ga1RIK1dtypH8MBzjPSnj7xTCkgbjwsEQY/W13ev0d?=
 =?us-ascii?Q?qdI9Jr77KXk/diFfUd3WkS2iYtbCIE4oQEWKOGj1TlLqx99INhxq31RyUxSP?=
 =?us-ascii?Q?6pBWqWOVaqQ2/ayjnzzCTGd2oEdh62XSsKKgBwPecP/m7RYBmGT3OzxlGrQU?=
 =?us-ascii?Q?RxuTPafQRkeuotLOmTUK09XwZ9LuOwXoX/5tnE991q8ZC/dqQjuE5V1sEOui?=
 =?us-ascii?Q?bxzTumGpnD3zZ6w1QmTKq44i0y5/7jFKtrAr8FpE2Nu6jCix3p2Fbn0S6fD6?=
 =?us-ascii?Q?DReDyLthroomLFOkKC/oDiE7MZfD3vTqDzLfSCcuOX2qPJzNTRMsHjI76yj1?=
 =?us-ascii?Q?He3mDP1w8FEzPHa6inoaTzwBW7tL/ct80tvUAbLbpcU937vyY0b4TbwyPA12?=
 =?us-ascii?Q?x8RUajvqAUWvc3JHqS/+UhuXYJTGCP94EbLJolHGED3fVGRSLNPF3Kwq/Fmd?=
 =?us-ascii?Q?zwa/krS2BJwJw8E8NHO4qB0/jfcgRCHO+3ntBZ3H91kugcA4LzOyIPuXjVY/?=
 =?us-ascii?Q?gsCwJQ4gCejD4Tz/U67wBRpFWxdqzb6/5ngFzz87UDu0vJ6RtyJB9gFOiH3P?=
 =?us-ascii?Q?leqLR8f79z5S5gTCCukLIMcgr3gysbd0M16neAe8gN3nOVS5XlPufELotQg0?=
 =?us-ascii?Q?x7nmPZQ5/WshPi3UIZ8Y0KwiZVynyPnQazu6gUs21s0NIJ6gZJtxcbBGeQN7?=
 =?us-ascii?Q?yqUiF9Sm+b5Pt5NlmwV+CGvI6TqK/FVyVXLwofe2H6BcPw3qEf0QJdq1rVvM?=
 =?us-ascii?Q?pCO7oc+iUDWU2jPQp6xZcubVucpxK8xOQLcZQEoU8RHGueqjQNcn3dVwuYbh?=
 =?us-ascii?Q?pq6BRTYtOouzvjD1WH799khJI9FZJWWebVPvLO3VXXTox+JAAcc2/cGts1LG?=
 =?us-ascii?Q?Bpuns2l2lOhFYH78exLPS/rlZ8C3hSv6+7XL6piboR/nOJH7qWRjcgnJoZlN?=
 =?us-ascii?Q?Xcjot5dZg5MFW+Z0OnBUyV4G+5zHrb0wpRqlD8Cr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0de50c-00d9-4243-d2f6-08dcb3335836
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:40:28.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E46JzIhuCJ7oK8+j+2nJeI6FOESXj8XcHxpCkr2sIzFDphhY1M/LEolsEoEPmPPd0h7qpFCH8ctq4DYkXAjaNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801

On Fri, Aug 02, 2024 at 02:46:50PM +0800, Richard Zhu wrote:
> Clean up code by using PHY interface provided by the PHY driver under
> PHY subsystem(drivers/phy/freescale/phy-fsl-imx8qm-hsio.c).
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 365 +++++++++--------------------------------
>  1 file changed, 80 insertions(+), 285 deletions(-)
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index cb768f66f0a70..75258ed42d2ee 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -19,6 +19,7 @@
>  #include <linux/libata.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> +#include <linux/phy/phy.h>
>  #include <linux/thermal.h>
>  #include "ahci.h"
>
> @@ -44,42 +45,6 @@ enum {
>  	/* Clock Reset Register */
>  	IMX_CLOCK_RESET				= 0x7f3f,
>  	IMX_CLOCK_RESET_RESET			= 1 << 0,
> -	/* IMX8QM HSIO AHCI definitions */
> -	IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET	= 0x03,
> -	IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET	= 0x09,
> -	IMX8QM_SATA_PHY_IMPED_RATIO_85OHM	= 0x6c,
> -	IMX8QM_LPCG_PHYX2_OFFSET		= 0x00000,
> -	IMX8QM_CSR_PHYX2_OFFSET			= 0x90000,
> -	IMX8QM_CSR_PHYX1_OFFSET			= 0xa0000,
> -	IMX8QM_CSR_PHYX_STTS0_OFFSET		= 0x4,
> -	IMX8QM_CSR_PCIEA_OFFSET			= 0xb0000,
> -	IMX8QM_CSR_PCIEB_OFFSET			= 0xc0000,
> -	IMX8QM_CSR_SATA_OFFSET			= 0xd0000,
> -	IMX8QM_CSR_PCIE_CTRL2_OFFSET		= 0x8,
> -	IMX8QM_CSR_MISC_OFFSET			= 0xe0000,
> -
> -	IMX8QM_LPCG_PHYX2_PCLK0_MASK		= (0x3 << 16),
> -	IMX8QM_LPCG_PHYX2_PCLK1_MASK		= (0x3 << 20),
> -	IMX8QM_PHY_APB_RSTN_0			= BIT(0),
> -	IMX8QM_PHY_MODE_SATA			= BIT(19),
> -	IMX8QM_PHY_MODE_MASK			= (0xf << 17),
> -	IMX8QM_PHY_PIPE_RSTN_0			= BIT(24),
> -	IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0		= BIT(25),
> -	IMX8QM_PHY_PIPE_RSTN_1			= BIT(26),
> -	IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1		= BIT(27),
> -	IMX8QM_STTS0_LANE0_TX_PLL_LOCK		= BIT(4),
> -	IMX8QM_MISC_IOB_RXENA			= BIT(0),
> -	IMX8QM_MISC_IOB_TXENA			= BIT(1),
> -	IMX8QM_MISC_PHYX1_EPCS_SEL		= BIT(12),
> -	IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1	= BIT(24),
> -	IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0	= BIT(25),
> -	IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1	= BIT(28),
> -	IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0	= BIT(29),
> -	IMX8QM_SATA_CTRL_RESET_N		= BIT(12),
> -	IMX8QM_SATA_CTRL_EPCS_PHYRESET_N	= BIT(7),
> -	IMX8QM_CTRL_BUTTON_RST_N		= BIT(21),
> -	IMX8QM_CTRL_POWER_UP_RST_N		= BIT(23),
> -	IMX8QM_CTRL_LTSSM_ENABLE		= BIT(4),
>  };
>
>  enum ahci_imx_type {
> @@ -95,14 +60,10 @@ struct imx_ahci_priv {
>  	struct clk *sata_clk;
>  	struct clk *sata_ref_clk;
>  	struct clk *ahb_clk;
> -	struct clk *epcs_tx_clk;
> -	struct clk *epcs_rx_clk;
> -	struct clk *phy_apbclk;
> -	struct clk *phy_pclk0;
> -	struct clk *phy_pclk1;
> -	void __iomem *phy_base;
> -	struct gpio_desc *clkreq_gpiod;
>  	struct regmap *gpr;
> +	struct phy *sata_phy;
> +	struct phy *cali_phy0;
> +	struct phy *cali_phy1;
>  	bool no_device;
>  	bool first_time;
>  	u32 phy_params;
> @@ -450,201 +411,73 @@ ATTRIBUTE_GROUPS(fsl_sata_ahci);
>
>  static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  {
> -	u32 val, reg;
> -	int i, ret;
> +	u32 val;
> +	int ret;
>  	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
>  	struct device *dev = &imxpriv->ahci_pdev->dev;
>
> -	/* configure the hsio for sata */
> -	ret = clk_prepare_enable(imxpriv->phy_pclk0);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_pclk0.\n");
> +	/*
> +	 * Since "REXT" pin is only present for first lane of i.MX8QM
> +	 * PHY, its calibration results will be stored, passed through
> +	 * to the second lane PHY, and shared with all three lane PHYs.
> +	 *
> +	 * Initialize the first two lane PHYs here, although only the
> +	 * third lane PHY is used by SATA.
> +	 */
> +	ret = phy_init(imxpriv->cali_phy0);
> +	if (ret) {
> +		dev_err(dev, "cali PHY init failed\n");
>  		return ret;
>  	}
> -	ret = clk_prepare_enable(imxpriv->phy_pclk1);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_pclk1.\n");
> -		goto disable_phy_pclk0;
> +	ret = phy_power_on(imxpriv->cali_phy0);
> +	if (ret) {
> +		dev_err(dev, "cali PHY power on failed\n");
> +		goto err_cali_phy0_exit;
>  	}
> -	ret = clk_prepare_enable(imxpriv->epcs_tx_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable epcs_tx_clk.\n");
> -		goto disable_phy_pclk1;
> +	ret = phy_init(imxpriv->cali_phy1);
> +	if (ret) {
> +		dev_err(dev, "cali PHY1 init failed\n");
> +		goto err_cali_phy0_off;
>  	}
> -	ret = clk_prepare_enable(imxpriv->epcs_rx_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable epcs_rx_clk.\n");
> -		goto disable_epcs_tx_clk;
> +	ret = phy_power_on(imxpriv->cali_phy1);
> +	if (ret) {
> +		dev_err(dev, "cali PHY1 power on failed\n");
> +		goto err_cali_phy1_exit;
>  	}
> -	ret = clk_prepare_enable(imxpriv->phy_apbclk);
> -	if (ret < 0) {
> -		dev_err(dev, "can't enable phy_apbclk.\n");
> -		goto disable_epcs_rx_clk;
> +	ret = phy_init(imxpriv->sata_phy);
> +	if (ret) {
> +		dev_err(dev, "sata PHY init failed\n");
> +		goto err_cali_phy1_off;
>  	}
> -	/* Configure PHYx2 PIPE_RSTN */
> -	regmap_read(imxpriv->gpr, IMX8QM_CSR_PCIEA_OFFSET +
> -			IMX8QM_CSR_PCIE_CTRL2_OFFSET, &val);
> -	if ((val & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
> -		/* The link of the PCIEA of HSIO is down */
> -		regmap_update_bits(imxpriv->gpr,
> -				IMX8QM_CSR_PHYX2_OFFSET,
> -				IMX8QM_PHY_PIPE_RSTN_0 |
> -				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0,
> -				IMX8QM_PHY_PIPE_RSTN_0 |
> -				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0);
> +	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
> +	if (ret) {
> +		dev_err(dev, "unable to set SATA PHY mode\n");
> +		goto err_sata_phy_exit;
>  	}
> -	regmap_read(imxpriv->gpr, IMX8QM_CSR_PCIEB_OFFSET +
> -			IMX8QM_CSR_PCIE_CTRL2_OFFSET, &reg);
> -	if ((reg & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
> -		/* The link of the PCIEB of HSIO is down */
> -		regmap_update_bits(imxpriv->gpr,
> -				IMX8QM_CSR_PHYX2_OFFSET,
> -				IMX8QM_PHY_PIPE_RSTN_1 |
> -				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1,
> -				IMX8QM_PHY_PIPE_RSTN_1 |
> -				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1);
> -	}
> -	if (((reg | val) & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
> -		/* The links of both PCIA and PCIEB of HSIO are down */
> -		regmap_update_bits(imxpriv->gpr,
> -				IMX8QM_LPCG_PHYX2_OFFSET,
> -				IMX8QM_LPCG_PHYX2_PCLK0_MASK |
> -				IMX8QM_LPCG_PHYX2_PCLK1_MASK,
> -				0);
> +	ret = phy_power_on(imxpriv->sata_phy);
> +	if (ret) {
> +		dev_err(dev, "sata PHY power up failed\n");
> +		goto err_sata_phy_exit;
>  	}
>
> -	/* set PWR_RST and BT_RST of csr_pciea */
> -	val = IMX8QM_CSR_PCIEA_OFFSET + IMX8QM_CSR_PCIE_CTRL2_OFFSET;
> -	regmap_update_bits(imxpriv->gpr,
> -			val,
> -			IMX8QM_CTRL_BUTTON_RST_N,
> -			IMX8QM_CTRL_BUTTON_RST_N);
> -	regmap_update_bits(imxpriv->gpr,
> -			val,
> -			IMX8QM_CTRL_POWER_UP_RST_N,
> -			IMX8QM_CTRL_POWER_UP_RST_N);
> -
> -	/* PHYX1_MODE to SATA */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_PHYX1_OFFSET,
> -			IMX8QM_PHY_MODE_MASK,
> -			IMX8QM_PHY_MODE_SATA);
> +	/* The cali_phy# can be turned off after SATA PHY is initialized. */
> +	phy_power_off(imxpriv->cali_phy1);
> +	phy_exit(imxpriv->cali_phy1);
> +	phy_power_off(imxpriv->cali_phy0);
> +	phy_exit(imxpriv->cali_phy0);
>
> -	/*
> -	 * BIT0 RXENA 1, BIT1 TXENA 0
> -	 * BIT12 PHY_X1_EPCS_SEL 1.
> -	 */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_MISC_OFFSET,
> -			IMX8QM_MISC_IOB_RXENA,
> -			IMX8QM_MISC_IOB_RXENA);
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_MISC_OFFSET,
> -			IMX8QM_MISC_IOB_TXENA,
> -			0);
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_MISC_OFFSET,
> -			IMX8QM_MISC_PHYX1_EPCS_SEL,
> -			IMX8QM_MISC_PHYX1_EPCS_SEL);
> -	/*
> -	 * It is possible, for PCIe and SATA are sharing
> -	 * the same clock source, HPLL or external oscillator.
> -	 * When PCIe is in low power modes (L1.X or L2 etc),
> -	 * the clock source can be turned off. In this case,
> -	 * if this clock source is required to be toggling by
> -	 * SATA, then SATA functions will be abnormal.
> -	 * Set the override here to avoid it.
> -	 */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_MISC_OFFSET,
> -			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1 |
> -			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0 |
> -			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1 |
> -			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0,
> -			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1 |
> -			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0 |
> -			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1 |
> -			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0);
> -
> -	/* clear PHY RST, then set it */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_SATA_OFFSET,
> -			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N,
> -			0);
> -
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_SATA_OFFSET,
> -			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N,
> -			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N);
> -
> -	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_SATA_OFFSET,
> -			IMX8QM_SATA_CTRL_RESET_N,
> -			IMX8QM_SATA_CTRL_RESET_N);
> -	udelay(1);
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_SATA_OFFSET,
> -			IMX8QM_SATA_CTRL_RESET_N,
> -			0);
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_SATA_OFFSET,
> -			IMX8QM_SATA_CTRL_RESET_N,
> -			IMX8QM_SATA_CTRL_RESET_N);
> -
> -	/* APB reset */
> -	regmap_update_bits(imxpriv->gpr,
> -			IMX8QM_CSR_PHYX1_OFFSET,
> -			IMX8QM_PHY_APB_RSTN_0,
> -			IMX8QM_PHY_APB_RSTN_0);
> -
> -	for (i = 0; i < 100; i++) {
> -		reg = IMX8QM_CSR_PHYX1_OFFSET +
> -			IMX8QM_CSR_PHYX_STTS0_OFFSET;
> -		regmap_read(imxpriv->gpr, reg, &val);
> -		val &= IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
> -		if (val == IMX8QM_STTS0_LANE0_TX_PLL_LOCK)
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (val != IMX8QM_STTS0_LANE0_TX_PLL_LOCK) {
> -		dev_err(dev, "TX PLL of the PHY is not locked\n");
> -		ret = -ENODEV;
> -	} else {
> -		writeb(imxpriv->imped_ratio, imxpriv->phy_base +
> -				IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET);
> -		writeb(imxpriv->imped_ratio, imxpriv->phy_base +
> -				IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET);
> -		reg = readb(imxpriv->phy_base +
> -				IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET);
> -		if (unlikely(reg != imxpriv->imped_ratio))
> -			dev_info(dev, "Can't set PHY RX impedance ratio.\n");
> -		reg = readb(imxpriv->phy_base +
> -				IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET);
> -		if (unlikely(reg != imxpriv->imped_ratio))
> -			dev_info(dev, "Can't set PHY TX impedance ratio.\n");
> -		usleep_range(50, 100);
> -
> -		/*
> -		 * To reduce the power consumption, gate off
> -		 * the PHY clks
> -		 */
> -		clk_disable_unprepare(imxpriv->phy_apbclk);
> -		clk_disable_unprepare(imxpriv->phy_pclk1);
> -		clk_disable_unprepare(imxpriv->phy_pclk0);
> -		return ret;
> -	}
> +	return 0;
>
> -	clk_disable_unprepare(imxpriv->phy_apbclk);
> -disable_epcs_rx_clk:
> -	clk_disable_unprepare(imxpriv->epcs_rx_clk);
> -disable_epcs_tx_clk:
> -	clk_disable_unprepare(imxpriv->epcs_tx_clk);
> -disable_phy_pclk1:
> -	clk_disable_unprepare(imxpriv->phy_pclk1);
> -disable_phy_pclk0:
> -	clk_disable_unprepare(imxpriv->phy_pclk0);
> +err_sata_phy_exit:
> +	phy_exit(imxpriv->sata_phy);
> +err_cali_phy1_off:
> +	phy_power_off(imxpriv->cali_phy1);
> +err_cali_phy1_exit:
> +	phy_exit(imxpriv->cali_phy1);
> +err_cali_phy0_off:
> +	phy_power_off(imxpriv->cali_phy0);
> +err_cali_phy0_exit:
> +	phy_exit(imxpriv->cali_phy0);
>
>  	return ret;
>  }
> @@ -698,6 +531,9 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
>  		}
>  	} else if (imxpriv->type == AHCI_IMX8QM) {
>  		ret = imx8_sata_enable(hpriv);
> +		if (ret)
> +			goto disable_clk;
> +
>  	}
>
>  	usleep_range(1000, 2000);
> @@ -736,8 +572,10 @@ static void imx_sata_disable(struct ahci_host_priv *hpriv)
>  		break;
>
>  	case AHCI_IMX8QM:
> -		clk_disable_unprepare(imxpriv->epcs_rx_clk);
> -		clk_disable_unprepare(imxpriv->epcs_tx_clk);
> +		if (imxpriv->sata_phy) {
> +			phy_power_off(imxpriv->sata_phy);
> +			phy_exit(imxpriv->sata_phy);
> +		}
>  		break;
>
>  	default:
> @@ -760,6 +598,9 @@ static void ahci_imx_error_handler(struct ata_port *ap)
>
>  	ahci_error_handler(ap);
>
> +	if (imxpriv->type == AHCI_IMX8QM)
> +		return;
> +
>  	if (!(imxpriv->first_time) || ahci_imx_hotplug)
>  		return;
>
> @@ -986,65 +827,19 @@ static const struct scsi_host_template ahci_platform_sht = {
>
>  static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
>  {
> -	struct resource *phy_res;
> -	struct platform_device *pdev = imxpriv->ahci_pdev;
> -	struct device_node *np = dev->of_node;
> -
> -	if (of_property_read_u32(np, "fsl,phy-imp", &imxpriv->imped_ratio))
> -		imxpriv->imped_ratio = IMX8QM_SATA_PHY_IMPED_RATIO_85OHM;
> -	phy_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	if (phy_res) {
> -		imxpriv->phy_base = devm_ioremap(dev, phy_res->start,
> -					resource_size(phy_res));
> -		if (!imxpriv->phy_base) {
> -			dev_err(dev, "error with ioremap\n");
> -			return -ENOMEM;
> -		}
> -	} else {
> -		dev_err(dev, "missing *phy* reg region.\n");
> -		return -ENOMEM;
> -	}
> -	imxpriv->gpr =
> -		 syscon_regmap_lookup_by_phandle(np, "hsio");
> -	if (IS_ERR(imxpriv->gpr)) {
> -		dev_err(dev, "unable to find gpr registers\n");
> -		return PTR_ERR(imxpriv->gpr);
> -	}
> -
> -	imxpriv->epcs_tx_clk = devm_clk_get(dev, "epcs_tx");
> -	if (IS_ERR(imxpriv->epcs_tx_clk)) {
> -		dev_err(dev, "can't get epcs_tx_clk clock.\n");
> -		return PTR_ERR(imxpriv->epcs_tx_clk);
> -	}
> -	imxpriv->epcs_rx_clk = devm_clk_get(dev, "epcs_rx");
> -	if (IS_ERR(imxpriv->epcs_rx_clk)) {
> -		dev_err(dev, "can't get epcs_rx_clk clock.\n");
> -		return PTR_ERR(imxpriv->epcs_rx_clk);
> -	}
> -	imxpriv->phy_pclk0 = devm_clk_get(dev, "phy_pclk0");
> -	if (IS_ERR(imxpriv->phy_pclk0)) {
> -		dev_err(dev, "can't get phy_pclk0 clock.\n");
> -		return PTR_ERR(imxpriv->phy_pclk0);
> -	}
> -	imxpriv->phy_pclk1 = devm_clk_get(dev, "phy_pclk1");
> -	if (IS_ERR(imxpriv->phy_pclk1)) {
> -		dev_err(dev, "can't get phy_pclk1 clock.\n");
> -		return PTR_ERR(imxpriv->phy_pclk1);
> -	}
> -	imxpriv->phy_apbclk = devm_clk_get(dev, "phy_apbclk");
> -	if (IS_ERR(imxpriv->phy_apbclk)) {
> -		dev_err(dev, "can't get phy_apbclk clock.\n");
> -		return PTR_ERR(imxpriv->phy_apbclk);
> -	}
> -
> -	/* Fetch GPIO, then enable the external OSC */
> -	imxpriv->clkreq_gpiod = devm_gpiod_get_optional(dev, "clkreq",
> -				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> -	if (IS_ERR(imxpriv->clkreq_gpiod))
> -		return PTR_ERR(imxpriv->clkreq_gpiod);
> -	if (imxpriv->clkreq_gpiod)
> -		gpiod_set_consumer_name(imxpriv->clkreq_gpiod, "SATA CLKREQ");
> -
> +	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
> +	if (IS_ERR(imxpriv->sata_phy))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
> +				     "Failed to get sata_phy\n");
> +
> +	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
> +	if (IS_ERR(imxpriv->cali_phy0))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
> +				     "Failed to get cali_phy0\n");
> +	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
> +	if (IS_ERR(imxpriv->cali_phy1))
> +		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
> +				     "Failed to get cali_phy1\n");
>  	return 0;
>  }
>
> --
> 2.37.1
>

