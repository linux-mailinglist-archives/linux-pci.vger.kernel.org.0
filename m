Return-Path: <linux-pci+bounces-39223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C2C04268
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E4B3B7F56
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF829260592;
	Fri, 24 Oct 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wrr5hGOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5173825F7A7;
	Fri, 24 Oct 2025 02:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273654; cv=fail; b=qEc/u+eFdYzp9dK343DGHh0E29zG+j3jM3MF/if1Np3PJHDF2shgHFPC/8uQBc9+Om7B1a5hczB3Sl8Y87vdj4aguD0dzV5p0oCL6TvFfed2edrNBVcwipTAQ/BNfmu6V4Cb+Ul6IF74zOZetFuAmoHMP0sUaMFZkO+/enNZ1RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273654; c=relaxed/simple;
	bh=zRf85VemMA6KSWsAbheqpJs8ZiqrDSV6T8hssEpyWQE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G5JDrXF70LyMdzR+KgZk0qd92mTifoZ+MG5x7MUPhePNc8F66y8nTW6ocZanb2F+BVo3b1CfmPCax1o3Ee7F2tuv4dd35+CKIy1ixX0e3DJchH/d7X5y3MRkp6eX+dNwgfwHxIL/zPxPkLgVoJHlSiQhT8/L/z8LV6lKgNZnpVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wrr5hGOw; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYVSPJu47eDZa3gsukgwRKFx20e2YZtkw8JdzjWUX+K3e4QUcDHbKLsFDDJ5gpwA7A3DOTB2cgQ+yylyZpusL72srsi3eI+TfmXl+dQe4vT1SftTQVIXlcagNCbSMxYiFISjx9SLsCF9q1bkp+HPR7P7Bh2c2w+F2duyBO3WpC6r7lzshaswwBbeAGcMaB3v0AHud/Dw7KMBTfDXhsCxyBNARyjV50E9Y8+9qN1164r/RacgP21D6l6/a8KfaV1izMUKID6Z759R8he2h2EO5l856K7gi5R/llTeQfBs8uF6UAnSJK115lp9k+WGtPiH+sJ7MO+Z+lt/Jn7XEuwbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqlun311Zg6fbAmzKK53ljythP4dGd6xJNvsj33m7WY=;
 b=ACKnL8PcS6D7DYRwMztIa48zyBIdGhVh101eRavkE6/WE7CMFb5Ic6g53ykVc8OiGbnBuQnCQwVojMNxgz0tRzAWgOvmtQ9ldWEHLKPBkoJ9ilfZDnNt0IqlOJnXL4YpP3W83tLRZwUdRP0TCYrO6LLZSBD8FgwRbkgvqiRIhUk6LTW1zz0wOO+4etOWwEFc6SESq3KV3TR7ddjjPtKx4g/8F7gOWnCDhOJr5h8SZloz6KzVYsfmkvmvThy6kYZ1CTBh6b8x3z+uVMOBJTCW3f061NQLW6MFF7VJpVgXK7boZDPAkgZ0sEFRier4E7gB1K5x8Qx7WrcYoFKX9paAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqlun311Zg6fbAmzKK53ljythP4dGd6xJNvsj33m7WY=;
 b=Wrr5hGOwSI69D23opy4lmwGhsjlV8JYEC/PymDCfI+z2aMfJcHlUlO16iikTuyeQmOSqdOiqGfzHcys2t4urNC6hWc4e2OtvbKJXUcisfrVsV4hOMVQ2sn62ZhEY3AwaBpLyZG72D5IaR+5tzTJoDZZqe2klnV7H/3KmX320I9GIaiufBuTwtR1Qt8pHL/ZCUGtfGHg2h7ERwgjM8IBUp1ufoeh42BF5beOJXCkNJ57iBZbtxws3U72YwPHri0IVMF0aVMpKFXhWjrjIg16EF9I5LGkA1q3nv0y9a7tushOgxdB6ZHpI2Lp3MVlSFzkXc9aHLNJcU8YboCWg7Wju8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10624.eurprd04.prod.outlook.com (2603:10a6:10:592::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:40:49 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:40:48 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] PCI: imx6: Add external reference clock mode support
Date: Fri, 24 Oct 2025 10:40:10 +0800
Message-Id: <20251024024013.775836-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: d20aa89b-baad-4c3d-e3e9-08de12a6baa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YaB6c2jYaagOFLikTndaDrD4jZnsn1Wcre6RwxTzhhKmXSoFmlgfdYb4pzuO?=
 =?us-ascii?Q?Eq/j+TDuMQ4SWxOsXyv7new0tUYEsI75QG8Xd8Wq5P02KtiJ8kUCKSCJkmPW?=
 =?us-ascii?Q?VOR443oFM7PcGKFS3FxqA66TyKkMmlAwJUVqHMmIVmIcHV5Pmx23tunW8lqW?=
 =?us-ascii?Q?iCA3lTtmWp5UmlcyAeF1c/Qh933z5AeFEcmi7uzGR4l/GXkmXtHCK0gQkN18?=
 =?us-ascii?Q?walOPIACgJG4L+q+CCDjx4HKMdKGKeH322B+AVzm9ag809IVMMrQ4xuIYuWJ?=
 =?us-ascii?Q?y6I9CG9hZ60HXrKOy/194tphtzjiGwJZss5ry6Wsr7298owQqbYxVdUmIIo6?=
 =?us-ascii?Q?QiDdnL7NG589WPrkQUdDy6Or0vUuahrYt42B/PL/guEszot4E95EYpA+Cvik?=
 =?us-ascii?Q?EJc9ZZZRH9/r1inEI9DwDJZzdNqVuvMawPDqhr5PpxJCTf1t7Tik7Qb4BKcL?=
 =?us-ascii?Q?mMmIs/NfLl07SZBpLijeGbwGAQUv+Zue/p3wYMbYACOD2wP60YdTCMVBcNuO?=
 =?us-ascii?Q?pyZsBcezVRDjivOP6DTOTvpT3ZiHsIXabfKdtPgJbZ3cUl3Z0/sVFgRkniPe?=
 =?us-ascii?Q?L3VbGwsfu3/SCgH8nFyXV6oB2IdH8VB5krX0+bGgx3rAKHhZDjYJezlpaiK5?=
 =?us-ascii?Q?XI4wRbnzGu9DytUhCkcq5514vUbcMxtFh2VjgEg4TkI8VIuoa+JWLf8dRWVN?=
 =?us-ascii?Q?r7JoTro4EUkqBnSm6Aq+gMBwqTmTX9v2oohHiUzaUwmBEm0e4VQI6tagj/T1?=
 =?us-ascii?Q?4sFvVpF/i2KVqbMh+poO8cyBx+lQEHRWoN7Z2XYuEVAP/lUfGmk6xuHbS3Qf?=
 =?us-ascii?Q?lQCuTL+T15Vtz95kk1afIMWlqlF5r0W62PnsM3IIiWd7NKo8Rd86ypTd1eL2?=
 =?us-ascii?Q?/3oNnNAJCQyOKscjuJgsuGz2trcu/DPTrUNnUrv6iW7tmB2ALmWQwPfxXLYS?=
 =?us-ascii?Q?FFY/74SsS7UAm/kQBmjny5fga+5R/3LO43GJOV+NExgY4VqKCUqJoBF4u1Z9?=
 =?us-ascii?Q?9nLvwRKfo2VURY2Xqr3mODBnoOkcplL2kt1yC8LovlD3JNGnobSUvWq45OC3?=
 =?us-ascii?Q?UgGpfw50WjM2ghfnuuWZKiLsSBsleHwzKu1RPhZ2SU/yCb3htPGuNaoeNByA?=
 =?us-ascii?Q?11JHaYd4CUCGtoQlZbHH6Xf2BXZAXwPOY173zL4drD0qo24GUxZRg4Tdswne?=
 =?us-ascii?Q?RI0ay+p4SEPa+vDxGMmXIHdmJnFaMk7RS0ftzaUkkIUiAtr8Ll6kow1XH6Gz?=
 =?us-ascii?Q?1+6MoL7am/uSD+8sFtDLJ5H1ZUXbTnIEdxi27kMYnJtWviJUXnf8OZkoluBt?=
 =?us-ascii?Q?+o0XbEEk5xjgqmgIUtvNMsQACYyYNFoclfr1oBp4pKzHO+RU74ZQ9uEjKHs8?=
 =?us-ascii?Q?cyalouyEx3Z5DvAOx9Zv4ObIn6lqLsBCSYXmZoSJyN8Y8MB/c9Fxm30BDQj7?=
 =?us-ascii?Q?w9MsNYyqAZDPVnmPMB+yPuBE4JG/f633TE7lQcG5zoHAaBMaKXrdVYNij3tf?=
 =?us-ascii?Q?FbEwurRUPsV2u3oU74k+7ycDM6PAB2uZi/yb4SP7WDOcDKl/779cd7dfHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f/HQsxiYAkLASxmC1/DeUc7aG8yehQKQsecR5n5F+WcW140OrYh+RdZd8uVE?=
 =?us-ascii?Q?2JlUV9u3tcIzNLZXgrMUDq9jf2lJaPjOFdeWLUiIvnoACZzgIJ8QMljqjUnh?=
 =?us-ascii?Q?M9msTp+GzNNBHZM2S8F7S7yBcNI2pnz+f+LhItrKSGxxaqxae5DnLknQfUgZ?=
 =?us-ascii?Q?WZR0jPsXUThYimT1t36JsTmaT5pGw08wnragx5wCXCYSiR5+grrmdr5VdXZk?=
 =?us-ascii?Q?zjt9N3rIQeslT3r5AffOhZ7BykWp5H3GaKOaXAruHdxU9lRQFfEeuF02lsRx?=
 =?us-ascii?Q?JnCMomHDDk/DUo5IAhfd83KHw5EUxZXpfhpzjKAWujOmUmvQqU1GW2wkpYIl?=
 =?us-ascii?Q?5OcfvyCrIyyYzzMCHZUZXOwkmXxIJWQaez/JEjbQFUzTjDGUrF4dGFQyZomU?=
 =?us-ascii?Q?5cMTt/RVuHmj9j1HjwE3ylIvbSvIbG/dPNuSu8D0sMuH70pruhBKdx2dtM4G?=
 =?us-ascii?Q?LNBHUJaVxF5a03xaL5tmYerca+udWJB+mEP2N+1ky9/2q8eGg2RVnZ1GfV7j?=
 =?us-ascii?Q?Ko5zTyHAO6DXTljnCLWPvNso04l/1erXODmf5rPfv/Ci34+uKp2BAayCtuhE?=
 =?us-ascii?Q?yCMz74nd+yX+5pDpiH0UqlrUTkKt9h4pFuGr+GwpmUlJkQ5gMnIpFjDcDoEJ?=
 =?us-ascii?Q?Bc+PZMzNvV9xBGeC0WIm/aLmCp/HxEGOhGAlRMzhOh+ZKS1k39JJlaImKJnD?=
 =?us-ascii?Q?zxRaFANYaCo5TLZG/5t4YKHHwV/8vtQ8TmN5zy4lVqlGuC6TG4wy+w2lqWI6?=
 =?us-ascii?Q?WPp1Gx+6BqV5kI/ZPyM7DDqp3Sp6uB94Wlc0BWPOcL4rhRfYGRSDPolvnkuK?=
 =?us-ascii?Q?INMaNRvcFQdqNxwPB1SKzRin5OvqzVp088aFd6aQgt+mLA/hDk5JusUb0VKO?=
 =?us-ascii?Q?Sh9z7ShNIkV4TjVMi0uDDrUFtJBlZCWWhb0XNyIFhS3MO4c1AdMGhOIJW4bW?=
 =?us-ascii?Q?yQgGKQ8XxJB1V+TlJelO/0rTjZHLqxn4QJH824ke/uefeJMkvww2jO82arOu?=
 =?us-ascii?Q?I9vxQH00hMib8AZPmIUByP5WjNKRBOnp2DyEwhHMgQvjCYYqJxkA+pbV1XoY?=
 =?us-ascii?Q?nYKEUz1Vi5cSkRe02ux1fjvmj41eP2aB+JgbIw7UdCP3j9oz14HRkz3WZVaN?=
 =?us-ascii?Q?3Wa3OvcqHBMk5y0lNVf+nepNIEY3MDLqeBl+TP30iVkoFyVRZv1uRu6m2AgT?=
 =?us-ascii?Q?6g0pLoWNt8VQLrm6juRAAqgwkKLOyvl2PkuiB/LYdsOlvAJHPe9kLqQlA58/?=
 =?us-ascii?Q?OHdP3PPmZFeddOi5IRqtHULPSzKSjf6tTO8GB15HK6h2ob7r72P+XgRjk63A?=
 =?us-ascii?Q?amiRS4vOddONm+FrbD3KXLZG66NLdaSLxBwGI6qola2xzaAkiqtmsmpVLxmK?=
 =?us-ascii?Q?YNnFdwR/4asmUt1qv3NVoRL46NNqS/JDr78aA5Edg0uuTUNolToT+semyuXQ?=
 =?us-ascii?Q?PZ9R7y2UJ7ngtuS/g+nIDeSk8U1WEAo5gICDuRt4tYQzUmQJ9I9jxVkJDbaD?=
 =?us-ascii?Q?UvRH0p7VhW288M9irpWf6CIrLi4XohC0eLVHWbyQLXS44wS+Daz26hbFRjkU?=
 =?us-ascii?Q?MzBhi5wtln7l9jZgd1YBS7XkgtZ8J0RacMOzREFO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20aa89b-baad-4c3d-e3e9-08de12a6baa7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:40:48.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGJfCDBJ2mAOB+0x44FTpjDPQ6dquZyRUboNUhTJkFO/ZtGZ8jG61RqmnMd3nwPlVUmH4lJGNOhXL7AEiOwxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10624

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Main change in v8:
- Rebase to v6.18-rc1.
- No need to initialize bool parameter to the deault value "false" refer
  to Mani' comments in v7

Main change in v7:
- Refine the subjects and commit message refer to Bjorn's comments.
https://lore.kernel.org/imx/20250918032555.3987157-1-hongxing.zhu@nxp.com/

Main change in v6:
- Refer to Krzysztof's comments, let i.MX95 PCIes has the "ref" clock
  since it is wired actually, and add one more optional "extref" clock
  for i.MX95 PCIes.
https://lore.kernel.org/imx/20250917045238.1048484-1-hongxing.zhu@nxp.com/

Main change in v5:
- Update the commit message of first patch refer to Bjorn's comments.
- Correct the typo error and update the description of property in the
  first patch.
https://lore.kernel.org/imx/20250915035348.3252353-1-hongxing.zhu@nxp.com/

Main change in v4:
- Add one more reference clock "extref" to be onhalf the reference clock
  that comes from external crystal oscillator.
https://lore.kernel.org/imx/20250626073804.3113757-1-hongxing.zhu@nxp.com/

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in the driver codes.
https://lore.kernel.org/imx/20250620031350.674442-1-hongxing.zhu@nxp.com/

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.
https://lore.kernel.org/imx/20250619091004.338419-1-hongxing.zhu@nxp.com/

[PATCH v8 1/3] dt-bindings: PCI: dwc: Add external reference clock
[PATCH v8 2/3] dt-bindings: PCI: pci-imx6: Add external reference
[PATCH v8 3/3] PCI: imx6: Add external reference clock input mode

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  3 +++
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 19 ++++++++++++-------
3 files changed, 21 insertions(+), 7 deletions(-)


