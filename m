Return-Path: <linux-pci+bounces-36058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE83B557F6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671EA189034F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB12D6E4C;
	Fri, 12 Sep 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CfPJChGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6E7494;
	Fri, 12 Sep 2025 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710382; cv=fail; b=ZPiIwip0aYGpOJO6CyYTRKZbsHl9jkVGze0aoek7FoCLfeIRPXyqc6pzwRx34A8Qidm6MI8rYNqdeSSebvC2SXDaInfyK4uQOLpM5FeBhfOdBTGKf8MUtG4x2LxKmR6I70lF9owqsGt2plf0tUs6BQz5alyIOfoIAeYdzvQaz0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710382; c=relaxed/simple;
	bh=CbvfxRAs0k0WyJ2Ah6cRMZlzEXQ+wywkpdtTMdufta4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KORW0tSfkwIzlL+LW2kZ0fLajXasePnM9yIZJBT4eZNWBSF5Ul/WyFNnIYCKrOaPHD8D9vJCZzErlFBqr1/XoFrtQFVLpX/FBKeH5ol8Oc7VOvqeLARZpBqeV8oMTAZSv0Uo14gWrND7Bdxl+NGzal+9s+EmdQwYGqqs3EXdHTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CfPJChGK; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkwG+SIKPsPq0ohiSJhGI7ocHpjCcXIMVuhtcZYby4+/rke2eQseENJZYSKoYtiGIKKlOmCrehS0HLlvF4IsRnsbxOUVHON9rtEidlBQgJ5grOrM0hUmNKnec+VV/EwTiRmi8LTMxCNrDa97eMoC9jooLAvGx/zYFYdlGmrnaYbYR2O7y6ZQoqOtOS7ZZurKCylXXHvRyToyxXNPVdG8bQgpVEMo3xlqmPwZ8dWh8wfIyDm3TVs2GaJhwyaQsbsUKDH7RVZ7R8j8mf8qL1w5lWR2a0aav0531a3vxxuBu2NFblbzc7o36fAoCZzTOPxsxJYUqbDQp20QPK91chYz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH1mm2OHJvULbKqH0ldgCgvAGZXBGWpAIoxFYpQOGVE=;
 b=DpfIhwVppjVYkqO+u0/ORmhrqDD+4BWwOoudJ/sQQC0oyGgihv4GjawmUmmnmubbqgXQaz4K0fm9mY1o7zCaFtpjLZIhuSKsmuL7CM1NhW2COykFnpY/+giO6YTMyGZ94K5jZePLq6IVP1atNhQyZ0s/uxhU5dX1QOB/9fJGgCkJI5UoWueg69zqMQl+sIBk/We4CiKMKSePrdnkU4GlZc8A/H8Kv8PJySxC0o4q6RzvCfI6yOVnK1gAZhnx46ytBlmULUKkuvvSxLgZ6jZyCYzlMSVPIkchDCF2DDjfYyPGPCk75Ah0hfb0jGLd14T0JmtDkE2f/Dg+1XcSvtaGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH1mm2OHJvULbKqH0ldgCgvAGZXBGWpAIoxFYpQOGVE=;
 b=CfPJChGKLGPZTPiyU/ExPvGrVS/eXcriOpqbRraRb4qvCFPCaljLVUX0w76ke082r7lJG1Dyg6l1m/viBhHHJRBzCXBxaFra9FOXN9g6TGceOHtNcVCpU3fzhF28Zy7Ba+FQhAjJuLWLHnrKpbZWv8ERLxnUnRQ6WcSy33N2mIFECBpCzg1PW4WGLQRprsXSHIBEYk+kBQts5tz9PgZc5oinF2NcHMznFpjV9INekEHAYi4DJfOnPiXEBLkikvIGZRDuijAc4xkwL/TliJ6JyrGUzeF6wbXX0vxViSkSxTriPJxIYIH6I5C9YSZtjc3oijoPLoU1Tf+zioKKqnS9bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11566.eurprd04.prod.outlook.com (2603:10a6:150:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 20:52:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 20:52:57 +0000
Date: Fri, 12 Sep 2025 16:52:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Message-ID: <aMSIIFMSXj2cLddK@lizhi-Precision-Tower-5810>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-5-vincent.guittot@linaro.org>
X-ClientProxiedBy: PH8P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11566:EE_
X-MS-Office365-Filtering-Correlation-Id: ad996520-2dce-470b-b4bc-08ddf23e59f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CcHH21v6mEvNSEdfgB6PS2QZ0hTGQb9IRl51ViWICMNNO3UKouMyFHRO+msA?=
 =?us-ascii?Q?JYtm3DRjqqO2cZKMG3hJHPphnnj6FqMm2aoON5afyKmF6k2PTQWr6EWoTeju?=
 =?us-ascii?Q?r2odedOWSK5jriZks5wK6jk9D1IqPi5GyejdRR1U74JoeByBqv60RcPlMLT0?=
 =?us-ascii?Q?C7FhBUQ/nvGjcy+iLY/cEwaAGFgwS94aXS1uWRU971rLtGwvzXiqp3jmW5ck?=
 =?us-ascii?Q?fuM4m3HlX7ZIkFWTbFU9sU8jrtHO22cPmVgOnBQtkwznO8Q06o6LYs/DMbBN?=
 =?us-ascii?Q?vDRO4AgkGcXlFggEgy2zppsyAPbvZRRmbREalicYtz6s2r4StQhzxR9LG7kx?=
 =?us-ascii?Q?UY7gSXhIV9RfuhekvwenpYT6zya6IHOnwlWa0kHR5OyYnqnE4cyP+GsJICT1?=
 =?us-ascii?Q?OO2HfvWp6CFCWAT2B41yFTv1AZmQ7ArD1NRfbS2X95jYXil9emZbLQ0dJe3v?=
 =?us-ascii?Q?Zi0myZP5eIk2tWvO7IWqyGAkvWAE7WnxhqCFLDLKKV1R3ji4fozbzSWTYTKL?=
 =?us-ascii?Q?sZpL/Goj5N58h2/1t1gYNz/2R3UNhpkO58bSIZ4HQkBj7XoAB93wYkc6YQvE?=
 =?us-ascii?Q?iAoUh0AuiOrU4D7qrWiqDjwEJMOds6yRqDopa0ORsWjZsekQ6ab3Vux1f/44?=
 =?us-ascii?Q?/lUV2U7ZiXVKvkdPxw5oS89060pETZXs6bTLzm+boVsmKSZQ3oGhV0BHEAuc?=
 =?us-ascii?Q?uyqtmZmxW2h4scB2urWYnmXY42ZRzrr7V5zHVPGW0p9xMTJFTnnHbmYGX4st?=
 =?us-ascii?Q?C2KmsTi0Ur7Zo17ASRKBsUihFk0pVQTQsA/OGEfeIk8hm3ATpz28cPKM5DBd?=
 =?us-ascii?Q?NAFD/RZw+yOBSJnCR13FPh9knk4Fm7uFa01dOVFw4XhoG1/xEFq0MdRTg1A2?=
 =?us-ascii?Q?bcPrlXwpx9xkyaU5IZ51DEoMZMUMgP/v/qLfCGjkNOwB601S7Csk2aQr9w+H?=
 =?us-ascii?Q?09VQsiRcwnR9xEb0VzCBVxKB/eWR9mD62aYQeOgxxznfmfNdSLLc7Syfa2zb?=
 =?us-ascii?Q?gCEZJxtW7I2ROCAchmjcGgdzE3B1vX1EUXQgOi0JDO9MW8lFZyd7+IJATOPs?=
 =?us-ascii?Q?Rrq3v0gQtTuTg1QDq0CHFV/+rw5q3GG6fXSsFHDMnMLx1wrD4Zc5BGISu0Sg?=
 =?us-ascii?Q?hRoSfeRcIFRGiWF0TkVhZTL6K7C1MWOmuBiCuBNHazCUyOdDIFEpjiRDPWNh?=
 =?us-ascii?Q?vfVs69+paQknjyqD/nki9QqrfzIRiQMNQLb232p5XOJ0tCe0TN7EjWE5zQ9W?=
 =?us-ascii?Q?Wohys0uyehtf/0ZU4f5jfk6+DG1imoQUJfYd+UAYTpg48O32uik9eFvuL753?=
 =?us-ascii?Q?ujZWVXVHJ68X8Jg7S3iqRazqyVYzLMcQkudaV2aTaoHgq/luX3Afve4kkzlU?=
 =?us-ascii?Q?bTzJKjIvZ8rISzQo6ev5RV4t7s0WHWiSE9p1g/y3X9rjFM6nN8embpd1chpN?=
 =?us-ascii?Q?4Y2f+4jdEeQn/cfB2mmT2e5rHT2wxgLQh4dnpOoz5ggt0rytOMjV3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKkv6XULll5zcT9+RsVfFvRspJM0Dqf78O99qh50tRzwuj7aBKrFThmeIL4D?=
 =?us-ascii?Q?k84dUyOgLAbRSo+GiMQMXVZNONUPADk8G7+xVokVyXcaU/3Qm8Jq7eeDLjr4?=
 =?us-ascii?Q?JGKFvzSTPf5EkaSX5wauyL2peQlnP7WUndr86kFLbIsn8NhDhLukU4IJXc7q?=
 =?us-ascii?Q?owbM2WZoM8XF4WMiPOqUqKbg1oH1DqkDQApYYizsXAbd4bM/7mex44Hitonl?=
 =?us-ascii?Q?pRa6i/TmfbsrYnIqZeF2w2KfCqtwHllq3gYy+Vb7c60iohzp9E+dob8axgfG?=
 =?us-ascii?Q?mRhvHlZ9RZKTlvypatYJvOF3WMDqTHpaJ/tCoi/R7yheyPnQLM4mNV46jOXL?=
 =?us-ascii?Q?Rxid+mt1/4S53kLV/F5kEGo0WNLmQ0J2wGptevOYVTjZmIQcOsEmXp+fCFbV?=
 =?us-ascii?Q?s77hrA8CAPKc2inZZpVhvQip3c5MwSPRIP4noD29OoeAeERt4PDKv51IcC0i?=
 =?us-ascii?Q?J09nMeY7SeMrMFZ/kyjCW3K+djB9m860sbUFxU/XjH72LttPcwe7/6YtWIK+?=
 =?us-ascii?Q?MPGINS/IWwUCgtmy91Br61wIVpuvHaN57jeqc8IcBOHcGH+IStAaIV3/kp9j?=
 =?us-ascii?Q?urH0x9sG3V9knPwJ3bMtC5zy+WMJuDJY8iVv8FK17w3FGt3fJK9yCWsG7BF/?=
 =?us-ascii?Q?ER5FjJF19vdFKetUSSHOdvp2JiGVXUeZQDckcqwCXI6phIcIzUJqfNcwNlVK?=
 =?us-ascii?Q?1S1jSjqubKWvPU7Irym/cYRxhZiA4Q490fC5bfUabce6dVQFIj9YCL4a9MXQ?=
 =?us-ascii?Q?I6xwRdqDWqtwLTkYq/QYDBTSbKeFbX431A7PzGCEvqsjHWL4CB9bE2klssQb?=
 =?us-ascii?Q?EMFRij/NbP3whKN9seue13MvJqPbg5u7zDj+Q6P3pNtfmHAJNS+Xcr87y9Ev?=
 =?us-ascii?Q?YgoSW4Iyl1FWRvUjuLxKu3npBYILxWzmEtso/tpsOtV/RVc9ZaxSdcORcHXV?=
 =?us-ascii?Q?LX28clVO0kpjZQ8/10dFdYhpY98E8wxjOwvHox/ynr/F8uW+e4pqxuXlBAji?=
 =?us-ascii?Q?zg7psRoiY0S0j9TzbFGfmglztB2h+OWwiz4KE1kX8R0BSAcUH3tbZKfEqYVq?=
 =?us-ascii?Q?e1PGfq6YVAUQnxwX41RvLAeycqfOeiA1mzD2E5TfX+hzm0RY/ZMRL2YvIpAv?=
 =?us-ascii?Q?f73nvG6V63RQbdiAD3osDUL0jchSpRvAYOVsYOEGlWoSa01GANnSEa1pXMSu?=
 =?us-ascii?Q?guIp2rBi/sf6dzbwtK3RZFRaMo9bRQ1GX5eIoxw2TzDpZ1Hfpc/hUoOLwHSa?=
 =?us-ascii?Q?gJx3JbU2Devt+IEDBkTo/6DtBRkL+xWJOdozYog9mnCQRF33NoxRNcebmJIG?=
 =?us-ascii?Q?GkdgL1ekHbD6JxrraN4qbDX+858VN6zOZ3l7uLq+Up+W4lnk78wt9awDL+/d?=
 =?us-ascii?Q?ymCEa7vAYNJr7s3OKJF90cORdANFovXPlWd6HdhUXmbrdjPqV9+TPXANJZXF?=
 =?us-ascii?Q?xgP1mEyfOHxh1OFpyXQMSo3yGju5HgCfyENP5CsZOXaEictaa/BpZBnfi656?=
 =?us-ascii?Q?9YV12V0TnjgQTtxpjwRjlr5Li9KfgXAake0Do2NbieoUbNI+vzr6Zp4CPHsI?=
 =?us-ascii?Q?DvSsAf+gaxr/HNzxqx0rv8wqaXKFiI6Xuej4MH7c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad996520-2dce-470b-b4bc-08ddf23e59f3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 20:52:57.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDGfN1EFREd2zGYYH7jB7+ZgUlZ0PsYDZcMOPn/frqjMmCJvMfFUaC3OwtLpsCp2sgOj22zcHAR/RLrZxqCieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11566

On Fri, Sep 12, 2025 at 04:14:36PM +0200, Vincent Guittot wrote:
> Add the s32g PCIe driver under the ARM/NXP S32G ARCHITECTURE entry.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd7ff55b5d32..e93ab4202232 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3086,10 +3086,13 @@ R:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>  R:	NXP S32 Linux Team <s32@nxp.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
>  F:	Documentation/devicetree/bindings/rtc/nxp,s32g-rtc.yaml
>  F:	arch/arm64/boot/dts/freescale/s32g*.dts*
> +F:	drivers/pci/controller/dwc/pci-s32g*
>  F:	drivers/pinctrl/nxp/
>  F:	drivers/rtc/rtc-s32g.c
> +F:	include/linux/pcie/nxp-s32g-pcie-phy-submode.h

Please add L: imx@lists.linux.dev

Frank

>
>  ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
>  M:	Jan Petrous <jan.petrous@oss.nxp.com>
> --
> 2.43.0
>

