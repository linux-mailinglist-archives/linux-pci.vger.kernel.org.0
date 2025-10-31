Return-Path: <linux-pci+bounces-39961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6909C26CCE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5174B352B49
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B53115A5;
	Fri, 31 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="foeJcwoh"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815E3081C2;
	Fri, 31 Oct 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939635; cv=fail; b=RJo61/c/CumjiVKkbKN3V0737tyUeHVztcs7aKmzRy7r13xOEIODox49LHPLnRZkKa5sSXQD6XE3ogNZI6Fzw6Nux0KSMWIvLfQmQbEO+I2FkYychhJnO1ddjilhp/PvzAFF5s0vGMmz+EPXEpx+Tt6vc2MOE5ylkgO6gaD93C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939635; c=relaxed/simple;
	bh=P1koRrUQSoT+wUv3Gz1iTWmQNDqCsCxLZ0FUx5Gjfn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqGMbiBXlPnUTkv+I5irpXmRBw9tj8L2bdueN4RLWIC9OxNiXvkPGCjv80iWu74bfSlRaORYSPNdfp0ovxNtfZACjSRMmPoXQSyZ/UG+MJkdlW78jfao4tpnaO1O/iURay9+UIn9YX7uwbsZiZSvyJ/4HRL4D/R3lCKGekqpjkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=foeJcwoh; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhqYBDeRDdVgxaXoOxvJZeJcc6sS4/6c8PzE+01Sni4PU5ccC/mCxBY5fC0szJBpILfUgnZK/AQM0BXhrUN7R63WGQzStwsacCqQuN8U43wSvMm9zK//eSBI43Nl6rdG+mr2RmyYlRlELiohHqm2bqQiRxNNLiEgHQOUW+gP+FGWrTDtsepInUKcepwAz9b2Ak8bhnMTCUPk52J1M+/TDLowHSkBvCR3C+XVonvCRy9mb6NpzL7lal7Zkix07bxb1RUbF6dYzN1MiQl49uRggGIvlJDr/4XVJbMC1LcIy1yf/aOlJ4jxnnq9kErrhxR2dwcbbQcZ7ISm8zenPi0j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/JvPJHKZ2z/oEYtZLzRKNqQrqDRZmx3AdTpXCuUD0M=;
 b=OVC23akowZRqaTsbay03AF2ZMgGM0xyFwxQ5cHNnwUDTKIB/NSyIaTIdf0NPXt08lufD+uznpB9xYg4KfwNZC83Pb0IafJ9dlWCvzOgwY0vI6NFSvHS/dNjZSN8GVc8m37XY+/ev8BDFdLPPs6WJ7sdSu+y7zu7tcTGW7nRg5O8edty2G01vivVRXQH/2NLBCbJk+Qsd03bqvRhTHticiMU860cl/DMwkRR//YxKEP/GZvnZLMGK723Ek23vdS78bWuj4lB8x0d5jbZXBwXU+v1iOs5jj5f4PA5iMWTDFtPt+xWwyXWdMvQM4gI1iyP6zV+gK50haB7OZA2eWhTlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/JvPJHKZ2z/oEYtZLzRKNqQrqDRZmx3AdTpXCuUD0M=;
 b=foeJcwoh4Gc6PsOJTPSgciqyDfbr7VyahcyuD1dKtuNSjMl0lwdgQAIS7laC1XwGxfnVA2DaUdtoBW6VwzWMt6zM32X+ns4LG4oJXWZwXViv4ZDU3MT1ufu3Ast0sdh4JEPWX+/1hDxSD9YLbjHzh2mbA4ZmZrbMSS0ld+939QSk9O9+moP7N3qfXHZmxj9mEtrgYP78XcB96fc+DRN8OZem+fDy303Twl0g6sLkKZeEtLh2LNE2BTtEpMNfuuvL2q5BIyw3qLBOh4HSgrs/YRT/WlPVtIFa52MdeCVzMx4lsGGaHZiuz+QGifn9uz/gI+SCdWBDNx9e9NNl4xVIzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9468.eurprd04.prod.outlook.com (2603:10a6:10:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 19:40:30 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:40:30 +0000
Date: Fri, 31 Oct 2025 15:40:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] arm64: dts: imx8qxp-mek: Add supports-clkreq
 property to PCIe M.2 port
Message-ID: <aQUQptOOyCFZVxl1@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-8-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015030428.2980427-8-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH7P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b1f38e-d099-4d4e-1df6-08de18b55933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoOV8nbc3lnDRH+35t5KPnPt8cPNjRVN75UEFmnE5uYznaMtaLnW/Pl7jDY9?=
 =?us-ascii?Q?PCtuZ0s/E0smjGgui17oTLUnJH9MeS6Fa82i1+3vPi7a3fnwztUKQStQJQ8m?=
 =?us-ascii?Q?wJW02EsWeeZAWfXpx3Dm3eSbiE6PwR7WVQIyilXX4CSvMN0P8cil1mYcq6z7?=
 =?us-ascii?Q?2b+aZ0Rz+ZR+gIcuV6XRjkLfn/I1m0rkqguN3kgMW8k+2NNORB0eHJdPrOwm?=
 =?us-ascii?Q?zGwM2y0p1WWrP6VIskVAKqZKHxv69k2xWB6xJ7sr8Am4NlnNrQUvLPZYuuR3?=
 =?us-ascii?Q?KUced9gzVtVDP0En44Mh/aNlN2mnF+jXjZha7db0HvWK/CbuNW3qCLB9vGhb?=
 =?us-ascii?Q?MKIRMvV+gO5fgUWBcVt4cSZ2aNMlqnP0mZEmgMHEufpIzyah3Sw7eOFHyqt0?=
 =?us-ascii?Q?Gwx/JrYr4ao/SMsha8wdxbh5bVcqSXAta2vDBYPYRzeCXmmEJeNsfe793h2r?=
 =?us-ascii?Q?nsEWL0wI3rVcIBU6lPoeqOQvGrHhCfj/bio3HwwLsSs199tXOjF0aTjl/+RI?=
 =?us-ascii?Q?JsQO9iAwj7JX8ibuIv+HK7oUIn1AemNrP9Thes5Q8Nbv55ZCo4Y48uHekhqL?=
 =?us-ascii?Q?d6dMg8eVK59QWm+jhQjIp2TDdmvj8AjTB8LsWeD4lv8pA/OdxM7H2s3UW7/g?=
 =?us-ascii?Q?uDuSZ6NvaqyPIW9QaOmFAeknJRpfgGfbm/PIAU91uzxWs9VlQmLhxZxQctAJ?=
 =?us-ascii?Q?Gll22Dupf1ocFHGm/2XFbdfyXsJSz1e/xnsjY63bGYWM9PLG09gvhCEdCQA8?=
 =?us-ascii?Q?0ZbuN02KHy1EwXTooyt51eB78+UJPwTauhxQdoK+skK30Be92T9kdqqWoJxe?=
 =?us-ascii?Q?+E4eXd7Gnh3l5pn0QFK6nXS+6c5P4ZQjC0U7Uth5QFHuc7SE+qNVUtFxJJEf?=
 =?us-ascii?Q?OQg3rTog/Vp6U16yiOp00zKzrOOIldrHTvfz+VehXBGvimhwh/jQSzCWm2pA?=
 =?us-ascii?Q?VbiKqJz2ttakd8xfKMH3iQ9UmtnEHyOtPCsGgO/U90d4eB/UpkJdXN5c+nKM?=
 =?us-ascii?Q?s0n/RhqCeEPUyyNYGQsfvfQb4v+jVRXXyE3BwE1j+kiA2dbyX41uuqg3bqdh?=
 =?us-ascii?Q?OLF99oyd1KF5Uk/j+/hdVuLjo1nRgXOl/sooszTZk4CTIIhBWKw0ZrdjMQfH?=
 =?us-ascii?Q?npttQpQSjp8E/8afT2nVrn/MRrAmwcOC5co7+4nHyLkgPZiPAfT5CyMrCvYi?=
 =?us-ascii?Q?2fqphtuNvnOC3qCUSGnD+Org0cGgUoruzIIIhL0vPczjMJ4pWC/ytdqDuKDS?=
 =?us-ascii?Q?iHuyCMhxMSn7lzZvnEmV6dcx/G+9euUBMUFryk5TKG2zgMEwfs8m8alUsEsl?=
 =?us-ascii?Q?mi5Au6WbfsIao0d0Nsr8IdHad37jLH0j5Gi3vj6Kt3GDy8qkJ7Mm826s7ddH?=
 =?us-ascii?Q?y2KJ3DprRxI1IFIUW417ftkXA0jfWzBc/TOwlBrR9MJR90Hi4TAhsVBgLOkO?=
 =?us-ascii?Q?D73l3VgtbbBj0zELWyXhxmEWlP22XIv4KPVqPE5AZceff5p0MI2BjW7FCbHU?=
 =?us-ascii?Q?ORGZyJbCK4Kd6GDHHn3fRveimM8AUOrbEdXJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wswwNzitdjliJhqoq/p6mYaf6Z89VO9M/cJdfOihJMz2/p4QCUDHyu0XgTPb?=
 =?us-ascii?Q?49owxW2flMxKmoj1j16gVe3L5SVLXXCJRm04+NOCwrRny11HT7E3GSObsFis?=
 =?us-ascii?Q?72j0XBarOZiIoM20UtFtd7vlxUT1AqbxyvnAPP5S6M/uYMjnFgv+d+TkG0s3?=
 =?us-ascii?Q?DEDAV6oaAIpXphtvXfnkQ6yQusoPBbCVJav3yK2/Iea2Fv8ps3/2EbAosepH?=
 =?us-ascii?Q?SYE/0hdaYw451rS/G79kltdEQtuK7+EjZfqxwzExslVhDICXVjD0/Bi0L24d?=
 =?us-ascii?Q?jQ3guezUQwKivEjSuOUxiuEt5wHpgzxVuLd4UXyL16/ESod5ynNoBIbwDsk4?=
 =?us-ascii?Q?N9yi3gcfy2BCbs9rMV7QBPnZNB03LfbOuYwmL82IfZzd5tom5bFjUAetjufW?=
 =?us-ascii?Q?vYeLAkaUNW0ZL9NiMb++qrcsK94BPwq+AoiAkhZiBiYIlM03jLrmNM6L3LSM?=
 =?us-ascii?Q?iWmUoIIvN42dAe80LkcclJUDHJv3zM2mvzlJt7T9aBcTH1/T1uk1hOoFySr+?=
 =?us-ascii?Q?hRgur7ENZJNJ8X1qpzFcjfa2gv8FB6vDf5Xi2QrXIYz3Q4EGnn4p6/mbLZwZ?=
 =?us-ascii?Q?o/Tr7VyOElZgI4mk0Ck7xz8JcmqCBZg7l4eUFmPFWdOdDj65arvx+LtkVoFr?=
 =?us-ascii?Q?fxsHa+8r4aJivOv3RCWsy0OyUfQoSNL4TyYhsUymOW1DNapg08C2dSAZfyi9?=
 =?us-ascii?Q?XgWqzg8V35h7XqxDMelZEZ+OFqRf0w2lP4Z3EqC3pxEpABEGi2KumBu3uvNl?=
 =?us-ascii?Q?sPA7iZrKyW/sTFGD8V1fZt0omxH0RgRGL0jTjCdFOgguCp6vQXUE2CSU/7na?=
 =?us-ascii?Q?cL+gn0je22vhnltgAxB9PVDdrFwpEnxX+S19LecsyAMRIANBtkIruIngJFP9?=
 =?us-ascii?Q?Ycgd/iwj0lU/LvXCR9UA/mA4N90qlWzPVCi/ksnmcVDQKVeQkjN7I6zLZnim?=
 =?us-ascii?Q?w1fyDjw9hPc5xO7tR3j2Ebtk+kdg7wOojdsWq56V4NOhBGPBesTFboDFb6bl?=
 =?us-ascii?Q?M/uxmSupRvXlg/bSoEWvptUzT6HtoYOE0Vcp4FZgAErLTcvizvcE86cSL0sl?=
 =?us-ascii?Q?wRVd4qwb2syM470K5iKtHENXGOTVPbibykCuWaxSI4i0M/mPcZ+1yVFHEe3n?=
 =?us-ascii?Q?C28BrBmojikPX14RNy54NjZ3qZRGB1+L0G7cGdsRUvcldclNRhebVhCAC14X?=
 =?us-ascii?Q?ztiH/1ErC4uppzJNUHETDbFIScWNuCezujOOcroXdsuSls5FlehgUizgbqfe?=
 =?us-ascii?Q?W/1geU2Y+FglCauKLBh49F9k3ACH10zWZI6Nwt55E2ygpL4rJUKg/rfkBmj4?=
 =?us-ascii?Q?IyopunU1inXL3H0lq8O1EpSsvNA+4FoUHINJi4lwQ/WS0L2w0dj1f0WKfgJA?=
 =?us-ascii?Q?LceG2yVOkQeHQ3ksqlSNebXc4MFjHzJlxG6s2gEfiJYWW46/U4NA3/8T+pCL?=
 =?us-ascii?Q?vDhyoSCj0vUuXNj/Gi6nVR9JxjL2I1tJFF/GAGn8VLuz6LG9AKT/m8nFNCoW?=
 =?us-ascii?Q?abYam2UGpb8prp9DsMi66sQkweG9zAHRTDimRymiIKF7YDFIndGzK8gpVfu3?=
 =?us-ascii?Q?1mEMNQXgVAWSRFoHUz0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b1f38e-d099-4d4e-1df6-08de18b55933
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:40:30.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10nGXu0p7ILAlVKJUF6BVR2Os5VclIITnnzZh+B4aH0b5ertuavMOME4v7D2wXBgLmIQtzK8biB/HqG7l7uorQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9468

On Wed, Oct 15, 2025 at 11:04:24AM +0800, Richard Zhu wrote:
> According to PCIe r6.1, sec 5.5.1.
>
> The following rules define how the L1.1 and L1.2 substates are entered:
> Both the Upstream and Downstream Ports must monitor the logical state of
> the CLKREQ# signal.
>
> Typical implement is using open drain, which connect RC's clkreq# to
> EP's clkreq# together and pull up clkreq#.
>
> imx8qxp-mek matches this requirement, so add supports-clkreq to allow
> PCIe device enter ASPM L1 Sub-State.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

shawn: I posted it as richard at imx8qxp dts patches, you can pick this one
with other part together.

>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 7b03374455410..9c457c2236a61 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -631,6 +631,7 @@ &pcie0 {
>  	pinctrl-names = "default";
>  	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
>  	vpcie-supply = <&reg_pcieb>;
> +	supports-clkreq;
>  	status = "okay";
>  };
>
> --
> 2.37.1
>

