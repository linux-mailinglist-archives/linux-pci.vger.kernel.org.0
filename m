Return-Path: <linux-pci+bounces-42932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6778CB4EC7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 07:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4987830024BB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD42BCF46;
	Thu, 11 Dec 2025 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OsFlXEoT"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA761299928;
	Thu, 11 Dec 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435757; cv=fail; b=aEu9/+tmk6/KMXSp5sXwwpPDGWc8Za6n0aNyUxGohBLxrmZbJGd6sNgRJPlcsfTuwvg5QLSPoKa6BYKXAS0B/nEvgR3x7OmYXPGZ5aSWLr5ZOEKrfbygmyq9mBAtM2TFpQan2W18wR+x73//g76A5fvR5lx6o9moL6G19GAQtaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435757; c=relaxed/simple;
	bh=tH3Al9/IOLOBZtwdhFd422qIFvIRx6zzICWuPwP0jdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsRZGmev/A4VyCghX2xv+oRM2YCCWhAzetpl6bkm/GerpRqa+v6NysygYj6IohktOju/t2gLEKzqVbfPZH7bdDEnepnWStPLcc46L6/hVV279S5z3EH37LIuAOlyOYrPzNpwre+AbU2xATZGKXHpwI/B/pyk4mNLY/kTXZUXR6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OsFlXEoT; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyITs7q0m/BPTUwlXY6ifL7Dzqv2UMNbm26z+aqRE59v5TsgVpfeRb2tG8zXcu/xHVhW5gKjId98dfuWuU8l1h9RSg9v+kQkm5iY2FqLAtQq7ngQzk5wrYwHVLOziATF1KAmNziVSkDTN1cd4XEDNFxTEbtO1zhJOPghVWRVVS3uukLdv4JjwJe0sOf5Nved6TtJUxKDwcI1hT7NWASEMZQv6l8myPgrQJKgZcKCSaoOKHGEWEWQxqOcCwB0IULqRqBK1ywG3J4F0irN2r9H9c+ZA1wURRRhQMypjhFvTNN9LfE9b3wgbSYXvyBqdHylLxEioNOSB8nQEvIaiypLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=robuUl+mGKvRzyoGqL+GFSrJQj8W2hLuMNY/A+9ZIcqVW93FxSAI4EXDkjCDVSt9ic/W/fmM6IqIYjln0dWH7rk09UYmeIiZvgwzrUCHwUL8FUA9QTnov5Iq6XFFbyQ+Ssg6DmtYm7T9IOMmmsG3z8WLWj54c745r+NzYqU9+1EjopXAuoVmK1qhNGqz8NTCtqH5v+AzoRuYwzGGJegA668wI/emdxSI3UepbuIe/H6xMPsLI0ZWS/J/pjhB4nmMm5XZvdUOgz+cjteRmiwtfLBx3HQHcYeAHDYUrrlKy6ty6dqkqcrA69Mlcn+Llm//fmZ5aNZhxAoIw9qyfOV6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=OsFlXEoT6Q+VrMd6dobVmvAk23VDuU7jyKnOmsmIHdZf1r2mtl21e7Rry3btc5n1fmGnorT/3oRme2/4OYhzEOR0DUQq2zKpTgwFIrrSNC8Te6mqp4+ZTQcOp6XWpQTuqYIEUfNYZKQ+sYi0t4UAc8MCdEgdFLwn/7oabegoFv7jAu7Dc3LsVGXnupf5dHcFJQxb6LxI5EFghFX6Yt6A3NiSU2/3r1hdVOUjZMFLIM3BK4xiE4WKsmP/U+7LS2ud2Qs8AkIHMBgQ6IrNPZrL28QqRCrEbTG9MYetXBwwXRNeHx9Hv9gPvQG2s9qOmr53Cp0MVrQUWnLq2RgyHF4B0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:49:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:49:12 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 3/4] PCI: imx6: Add external reference clock input mode support
Date: Thu, 11 Dec 2025 14:48:20 +0800
Message-Id: <20251211064821.2707001-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df0f1b5-4f7c-4576-9a2b-08de388164c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZMoUHt7HkIOcerJMiX8djIa0ij736VykqQ9dLGZNbdp5BNETP06SXo10Iyt?=
 =?us-ascii?Q?5NjcGzEEZ/Pw5CKkgKqcq7G5pnHLogj9bYO7Pa1o2MuNKyUKgbSZ8YTEKNNi?=
 =?us-ascii?Q?vVnhb4RB0c95QrIuypQPo051ShZJXbn41Co5vKyCfIS2rrXOsgpDPh22zs6T?=
 =?us-ascii?Q?p7Yz7o6BtPGitnE3j/9HzgyKKQKmadFm+oe+/BhLu1IxNATX20WwIpgtvTNj?=
 =?us-ascii?Q?2IBy5vGU/nbR5wPVhR/eDN3343dMzLXrHtbrxqxvcvCubWVQZtDJ0fSHYYAv?=
 =?us-ascii?Q?6OaKot0RFscRufWtGVjl2DDWC1LqBlpQc9la+wgyYLhdVygHJKia9FJ2OeaO?=
 =?us-ascii?Q?v1R8PR3G5hhnxzr7KsJtsnRKidow9hZniQFyRTls/Fv5ruRHmgp0jfbnPbDw?=
 =?us-ascii?Q?v4/ZyKZIwCHbj6fxCku8h7NoCkhIAiQDQuQ/XrYnPWOsZJavyGKFtH04QnWM?=
 =?us-ascii?Q?euTZi6XY0iX65ktfXF4pKgrQledvhwGpkzwKrJRUcLqKm+eMf9IvaC29b0K9?=
 =?us-ascii?Q?AnsRbKzkylD7HdD80jiYpttIZlo4/9oDyU1yw6L0R/p1MCDcbo0d36v0U0Mo?=
 =?us-ascii?Q?kev6AIx8bV0d+HmwJAKLWBnF//HTyvdRWU813M+ZGQ4gPrQhWJkp+4Vo8Jk1?=
 =?us-ascii?Q?JH+2Z+wX5XxsSBVdUXjw9pguQkDMnUJ9NAGcQYPwlt31z6UZMLpeIr6kmxSH?=
 =?us-ascii?Q?HiulEkjb/pZtsF0AYfV+XNNAKoyeHu7y/Qal/V8OuvROnwlfleePEm01w5fM?=
 =?us-ascii?Q?q0HKFbbUe5Zd4aRO5IeyrLw37nDKyrfcYrU5WLikJOqMNkenYKZ9QeDQ2PfD?=
 =?us-ascii?Q?VFMbd1QKmnIdWG+3qM76RtAvFuNyhbLHpQxXfnGgrRbeKmfqKEi46Fpbi2Ot?=
 =?us-ascii?Q?KxspJqnLbn2rb1+cbqkZLUSLN9vQIXxjELo3QjcrPQrQ7W7ZwNAuudLJKlue?=
 =?us-ascii?Q?zOQ1nOWy7zG51KXtkVt8yPjgn0y6DpaFU34ztko3oxQDokxs3arOr9T+2wcP?=
 =?us-ascii?Q?uxHy4VkV6bFJUJiIXt7mWcRhRRvLv4IGg2vzj//XU02EgCuCsDXsiw530v0J?=
 =?us-ascii?Q?5GOWPkep7iJDJLd/u41l33Ka+yQHFIZyuG7ztvkFpLHvt78hTOV/toC8U9B9?=
 =?us-ascii?Q?KYncZfeiy9Lviz80CbqAlOHqcUvUXw8f33GV0g/EW4A2XMjtm5zLheuQYoQs?=
 =?us-ascii?Q?6iU03IJ0Wyl30zlSAMmRDyo6QPG3F60+2PiyX9uEJswVFNVcLyDM5Wnu0t4m?=
 =?us-ascii?Q?JOP9QNp1iJoPBad1/xYoXgmdZJemHwDFKt07BHtZ8YyAi+guZrkwSf2x1MQ8?=
 =?us-ascii?Q?ZHd2TzeoGbJ6EwTKu6CI4xlgYmDXrNBNbluY5Cf2Ia2ouId8QjBQ3fy5B0cz?=
 =?us-ascii?Q?35ta6tJDvqbinTCyuoG4wNUUw6RyTIrhPDR3TsmD22L0Ip3+HVXg6Nniaxwz?=
 =?us-ascii?Q?QhkeYOoQDJUx/ga10G7tXtobJPl/OBjoDlu+mwn0nS0oxyZfP0ZfYdPd84KM?=
 =?us-ascii?Q?UzqkYp+/H9v128JyUazEjA2HznJzcLnFDAylQmkT1L0mwbUqWmOhxl6sjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvvbFR/GdouUe+oUuZQXZcA9ZE204Vp9U/dFwsm6MZL64FSilReoL4EpwitU?=
 =?us-ascii?Q?pPbAYxjAiM1hsMxNGUsllPzzADuXwZVPA9fwiciZWziXQ0gK9rxRBz3i4+cR?=
 =?us-ascii?Q?3Bk1A6rI8TucPgHqKjMoQgnsQObG2ULIy3tnF0aQCYMJef2cQBCm2E/5cmC+?=
 =?us-ascii?Q?r2YCatnFTkSp8JYv4LHs4qTLgvJecL+0bDFlXpKQd9Y/Nq/PFiMwIl++p/vE?=
 =?us-ascii?Q?hL6ZRdhkHb4xybhOb5Am45n7bdPb94lmfdUtXHWHh0iPK6zXlCRbZKUw8a5B?=
 =?us-ascii?Q?/DLMKYtj9n3DCtYh9ewK7k6a2HD52jUjcY24O3W7zViWbAR91c4q7ivODQXn?=
 =?us-ascii?Q?HcfYj02SoisGgQikGl/zQ5BxfZ+L52fBHcx7YeXYBOknM/c7993E+er3vOVw?=
 =?us-ascii?Q?JNWLL/3umUp4WDgkmoVuj01SJvF5jURvtHu2lPTbacXjj+aT8VkpJHk9JTPI?=
 =?us-ascii?Q?Xtst5siVUF6uWbuFgcUj5kn9EgFQ8tsg+8i+so9bgDpN/7xb20YjNi9Ma7/7?=
 =?us-ascii?Q?9tC9GBKBCrKkj3MHcgoQ5gT4bUnNYoDqB4lhDiZ+Occ8jL79llr5cnm5axpR?=
 =?us-ascii?Q?l9nNqjhxx3g8SH9VrnxGQItVicMIbhXyfkFAJsA2iOfntplJ3pm6EQ+ZCVnc?=
 =?us-ascii?Q?nAn4CXK6Ct5TNG/XM0+IMHxFnH6w/ozA5GEiqk+TxuRrvfyXuNfU8eAWNpyH?=
 =?us-ascii?Q?gUBpCRiNZc2HpRofV+o+xqcmCVjjH4ejfB0VqI0o2WwvoRaKrzGxdwgxRxc3?=
 =?us-ascii?Q?+5hbvyyN4fW3ZeOCJ3AVKCt/zzMG6iKbxue7E0JAN0mnzThZwi2KLdh+Eqs4?=
 =?us-ascii?Q?qTpfE/1Kx+LGRok86wJUcHRg8FzCeFFdARaCS1igA2rTYptFCxRcgf1v0zGg?=
 =?us-ascii?Q?nYdPF3tra05HqUeYB9x8u4pSLZW6/P3bHi9bOerFOfPmJsT9Q24fwf71r5m8?=
 =?us-ascii?Q?kbcPhV8ycmPpb/8QfbE64QbzFekBEr8tN7yg3bBp1KJH9XbEi2nkFQWWqNjw?=
 =?us-ascii?Q?c9vJwR2IBre/8LnPXx1H82lrlWWX95gbRO5GLiRKxAToKxLYrfZXeuPzjA06?=
 =?us-ascii?Q?1zHrsChYjXssww17d4YuDr1Ltw1ufc1cYrc4dPVj7Ec2pnHJuj+H07ZSQ4Ne?=
 =?us-ascii?Q?BDSgDufKPCnABioI2A+02zcTKyIVfTJrD5KLD7wPHvBKUMhC9NDbyEkPIGzk?=
 =?us-ascii?Q?ybt/KL2KfVSVk+2Us4AngydD7t19I3deBp2/52vUQc9+b0351rINLUtYPfWj?=
 =?us-ascii?Q?hTggXHZVzHR5mblwtIBl7W40VoxRseCRmFTmytBUCGX2659cuYtQP+umOa5a?=
 =?us-ascii?Q?Ce4BKT1Z92mCq2CFm2FIy8JSMSYf84xgwjVuFoNguvLkWqgbkv2sd8BskV+P?=
 =?us-ascii?Q?1d63NUpNNFBIB6IjWl6swzIBIEwm8IxvtBaRaONTnhRzrUFkunpkfmlbNQq4?=
 =?us-ascii?Q?cc+1D0m5sRkWyQCLLLnm9k3MdqiVpLuYh3O6XdCIriStYWBwmIfopozpNKm0?=
 =?us-ascii?Q?S35jV0u8URbpfb7N3wAiTZDC9PFIMeqpYy+ugherkvxV3QlTkYnqeX+eXQ68?=
 =?us-ascii?Q?ZQvXB7pgFinTlACXDvqigVh/RczYiuzM95cmrX2t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df0f1b5-4f7c-4576-9a2b-08de388164c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:49:12.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUZrgjqcpMPmTqjuPs4CBhR4cWBHo2T95Z9t0jXf1G1g8FzNKWjmqNw614c+DWbYSiGcKGNQ21+xLk16KpDrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bff..a6db1f0f73c36 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -149,6 +149,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
+			   IMX95_PCIE_REF_USE_PAD);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
@@ -1602,7 +1604,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1653,6 +1655,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


