Return-Path: <linux-pci+bounces-45169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D3D3A413
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 887FE300294C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9ED2FB622;
	Mon, 19 Jan 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7mpD5R5"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7653357719;
	Mon, 19 Jan 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817066; cv=fail; b=W1wdUz1HFqa5/LToc5BTyeyQoOvyGIVA6KJR/TeQjhFiJ+wXEeRbfRxR9opUqyD7di2DZXqZfTvSZF8MieNVUDf5b97CnA+mp6kW4FU7fd1aCj8TBSBXlUgMIYwPSLD9jo1Xn2btgzoSML8L1B2DR1xzMX0wl/c5Vs+NVBgYHU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817066; c=relaxed/simple;
	bh=evijJI4Hpqd55Cj63kF6PlJ1o7VfS9qWn56hyBWteRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGknHcjqtDQfLlfwkulSBXeiYrZI2tiCYgqRfq2RZq4lh8eQB0VV0GhzQ/aOzPbakriDbDX5Ov0y7hfcyPqTNzVZ9HjBry3dFweKIl+4yx+tK23GDTVViPyiyOfRILByZGB49WQqmqvB5Xc7zFFMhuXm+q2Gq5EKiljxGSg1fEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7mpD5R5; arc=fail smtp.client-ip=40.107.130.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLyDxTF7yajIvR+zaMbOjNJoQhLAn7r4d0BcAhwkTjj4xmUuTAnSV5BbHTItFU2DfcrAE+equ6tBG3T4XythmkctsLlm13U8Y0LfrG2psPLpn14mdm4HIK6t4LhHPKlMqcTpQ1nGkIQDv0nznKE4QoxIOpM10exKyZF5G98wCIU8F8XG8PkuZhRJH+KPYzx9bh7eU8elX23GIJJJXdNWt/OmKqtuqizXRPk1dwqcaimgo9AW57GPR4IaR7wMxvSYQ/dk0H+Tt99lqeEVkZWvAmaQ88CQumvhr3rRNg9eC7yYLok260V/bcqdrIzkfMjrgRL6b9/m5lFWd23OItU9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+19OQiYoGnHPfzzA5/VIPhV6F1AAJoBGDh4uU2c0Go=;
 b=QLnntHxXIkREvPkjwXARO6lpPu6yyAOEkn5AQC1PSsluAYWTl0tMuz+2e/ydzbBEgrgTFP7sH+RKZeZ8VrzFh+bZi9MqY+53lqABekQYkvkGOQCaD1Kwb6W53o0Ff2GkI7Ax5chWLOWBL+qM5Ys5GUcPnJ5BQyrsLMQPsdJozbaplnRuRsCXtLCD2ytG+1nVpJryiq8x9D/q4DozW+BlIxGlVv0RKq+jTjQa990GpV5SLpzBPouraXeMSUsnI/wO07J/r1Q+suGdlDuDLlkQepUAvcynmZSS+4wXa1HxlE5M3YTj6PJUOMPzaf4U5eJWMNKvTaMAMnZ7MC5POzS2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+19OQiYoGnHPfzzA5/VIPhV6F1AAJoBGDh4uU2c0Go=;
 b=A7mpD5R5CtR7g9c+EsaWzQ/4RPtpzmkqa6nVZWOX/AhSITeSSvpz8yWlMNQ5cQgtLojt1l99UoqjN2LvdXECwivZuWidBrg8Ayl7Wxfg+J3ngnmWnws/GH5yzKRoeLX7R78Ba+M9G+8q/MDrHN5H2o1VbbTwN69LS2Xr/TVT77K1WkxguMyT+8GHOITemn09Uido9fQFK7Wk+4/dijNtxIiSkXGezbzDpI5XYqlqLPwXbKvwaFIHJopD/xqoPaTrKjodgfiDeIt6zCMf0FiSQ/dPGfNNTr1S+mvrfi2zCWj5wdiAL20X08tTwdiSdFhK++QD2c9oNclazgh81zAlwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8812.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 10:04:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:21 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] arm64: dts: imx8mp: Add Root Port node and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:32 +0800
Message-Id: <20260119100235.1173839-8-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260119100235.1173839-1-sherry.sun@nxp.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b372f-fa10-48d8-6c03-08de57421dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?znXvtLmFg79U5QgeAPKqjUCUjvgrSr2xrOlioWCv7p4dqxImKXsdmzrQpksB?=
 =?us-ascii?Q?3gAcRWJHA+k23xazxAPvoMoU8yYTN8mbWNyp3qiaDCx1mqzTHGkP3VT40PSA?=
 =?us-ascii?Q?uMNVjSmCpMOY1L/9vKgJY4iWrxreqfuUNaadquRUK8cfnG20zq20PNY6ueS7?=
 =?us-ascii?Q?pnZvxdJA7mbn1B6g1fHBs1/3Sv+7c/J6iW06CoCetY4PQNN4PUXTb1QhNzbJ?=
 =?us-ascii?Q?CZAG5cMUQRwfU1uSAx85dY0BZwAudm2SYrVUgccz3Y6fazQbYTXR1Mu6dvK2?=
 =?us-ascii?Q?5UKNvUqeHDePvK5mMYR9Z7NS2Uv0kfN0fSgK5BK1WU+FzSC2ZRDPUr0Yfv/s?=
 =?us-ascii?Q?hHoucyPyxgds4k0UwGaEtRr2REz4Vx3zarclbpf6nbaa6GDpugyVz/c9If/G?=
 =?us-ascii?Q?B7Y6PniOvKpl3zKRn5EQkq+UmvcNS25qMl14WfY15rBeMzV2lPrdzsz3loiX?=
 =?us-ascii?Q?h7NQk8LlbgPeo0coOGPB0+yHmRtvyjg8yg57LpGQm0vARxJenYqhvz85VXGd?=
 =?us-ascii?Q?a0EJ0/Vy0nEiRseb6fSdLzBJ64iXbz5Aluy+zThiGcDyp8EKnzzQglFNGHZ6?=
 =?us-ascii?Q?eBBSh3vEdWUAaqPI3TUSKC5xcBAC/JerIwhb8ope9BX6WBgaugF8vMkCNfgT?=
 =?us-ascii?Q?z5x5QlRqElsAm4y8Atunl57s48HEYo+G60+qZkiWZPEKaZJUv+SDpC/NiVzT?=
 =?us-ascii?Q?8EOO3doKSg1PgEg4wdH658ItFmZiQUL5LrRDcSUw8AXN0Y3gc8va/8k6I8rs?=
 =?us-ascii?Q?XTCPyguOjxkQZ+6qYxiWMWBQ3nRPOwBvhpyXjj0zMSbvOqU0KSI92r02//3F?=
 =?us-ascii?Q?3NIzM1XD3mz2RglLfaJkfpaxcTYsL/EH3mSdHshC7dfH/AN14DXU0VTSNfDA?=
 =?us-ascii?Q?tpoERgtdt1GxkbdbnQb+3bPicoF/O5YCTknSor46B17HnarpoEaoqCcTD2bw?=
 =?us-ascii?Q?sDrzNYHwNJebevvNaTPYPUOvbqx185JtcsRRa1Y2iIGcqMrD1i3By34kVcsp?=
 =?us-ascii?Q?keS93nTaIc+UGJJT5e1ZaRQbiNAFO7i6a6ioPHcHi+J5VcwrRJrpTHQOX/Ih?=
 =?us-ascii?Q?ysIowJtYKfxcZXn1iVBrO00e9j3spgdullbCnRVJcM4IlPpPaQmZl4hC8317?=
 =?us-ascii?Q?AjArY4IZiJlXhsxJLIDhlNFMaMaYvncQ6bqtV8jCYm7jvRidzXyNkQHtCrVi?=
 =?us-ascii?Q?N6j8+9JzhzHaeX19TlX1XQI7XGl5UD66ptZBwDLWxXAVGg1dEq6MayKxbUm9?=
 =?us-ascii?Q?+zTcz6BtwfHr1UB4MUlDorFlFM3nYoNODBceQMMfrSXmT+uVbfOOH1SA1W7b?=
 =?us-ascii?Q?akr2brw+CjUDU+08i+AUfY7+hztf6UjPvr5K/VLfemZYNn2z1ThN8Fppa+Ip?=
 =?us-ascii?Q?+fEMM4O/ERkM02dXbBj8fXm9jW3nF17+fc5pV8PDfD11GWB8pvkQtThvQrrj?=
 =?us-ascii?Q?XsOBveUTDSeqKRtznF1+7/+5VgDXABIGUNOh/5SoSbNyCUQg0M/8cvvID/E2?=
 =?us-ascii?Q?GyK9g+61pwyhVprkIpyP8ntCoxC8AjPY010wEzb/8f8XPeCGg4UZ0qAjTMIB?=
 =?us-ascii?Q?WMQuZPqO7aH4yWOdbndi2LUTN0cxEHYOSUQgQ/l+A4yXUMKnSOg5sEAOnAMa?=
 =?us-ascii?Q?AuP2F10OK+syifevw/g6K8h5dMiHvHZAf9qYWR8wf2D4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjz5l8kuZk8NI3wr2IuHwGBEYwDMZZoX/1A35da72EkwO7v1D9UHATYoNOZ/?=
 =?us-ascii?Q?DZVHUjvI7yM064G/sGnlylGesrelWR9MrAhwlHzy9YN4Yy5giruL+myQDADo?=
 =?us-ascii?Q?fQW+iD54rlPB/qp5wTzwepibtmKxVA8SnKhSp9ISW5ntCDzqBkE3gD/jFp3Y?=
 =?us-ascii?Q?iR1HcNi47gRO2gCPWRoktDkyPqtIbxTG9Tfjtvf9/VX/brl6btprWdB5oEo/?=
 =?us-ascii?Q?ZUrF7HtTiUfd6U7Kd9mi0FbkYFpYSR10wr882RxnYlHGKTDXb6h0u2CK2/XE?=
 =?us-ascii?Q?2psmg2Qx90+1Ektxl12yV17VvY25QEQl78hQ2+DuEOEF3eIoib0tJ3HNAkgu?=
 =?us-ascii?Q?RN/Sbfu8pfvm+Gj5r2nH/nHzHgiV4gsZlKuAJSeOPkHtU4SFjULncwQDOFy7?=
 =?us-ascii?Q?c/lbQW47L223rRqBIW2dzM9ZtVTAERuunCBdoUPZvLHTWTU3jCyVH7MhZ3RO?=
 =?us-ascii?Q?a4cabI7n0XlotgV4+ZMiiwMU2xsObIxR/j7xXzAxgk4WlOZtPjvpdI06bvzX?=
 =?us-ascii?Q?CKg50UAx/KBDvy6K1k7otA30810zWGvAH3k/PAfYRtMimaoAgRcpvUf1NN95?=
 =?us-ascii?Q?4rSps7pNNBbOqBAOaMP4LaV+YgdVdDRj+kiXBRzbC4s0H1kKPshffCTXimbw?=
 =?us-ascii?Q?xW7FbL4zCQzi5Sdk9eHzZPhUF4TjT2lOfMlr31SWEv8+7qHROpu9eyPrhiG+?=
 =?us-ascii?Q?atzdDSVLb5A82PmYHfffJV/1OKPgvzTJO8Gfi50Y2O5N30rYKhIFhbXcc8X7?=
 =?us-ascii?Q?E5bqTG3nbb0iwaCRVJ0rkgsfS8McFGUpvAVeL0P2M2U2QsR8eM9dObxRp7Bb?=
 =?us-ascii?Q?elJyK3+P0ISMMXqQVLRARK5aoJjVnP5CnLDSm/G74XUG5HwJFCK0UClkyQcG?=
 =?us-ascii?Q?6/axCQ7F3tNxFpATRvPEXLUjy+PvXS1y/oNWUzOQ26y6rsMOk8W83j3JQYPz?=
 =?us-ascii?Q?ZK903vpYVvnyVqF/AYiGG1NMHzF4unqyxM8tOCqnRUP4lqv62a/OpSxFo50b?=
 =?us-ascii?Q?64uUAu5841BKs5ib113ElOHOQzDai7tQwvAcZy3g7dsmlCHEWI0Ch6aq2qti?=
 =?us-ascii?Q?g2te/RnsDWzdE0f84T4yQ52KCRlULl4vj3iwVRTe+SUBN30JeMoaxp7GpOpr?=
 =?us-ascii?Q?PZtqLgz02Z35zT9SMofFDnoTJDw7r+YvIvUwQHBJK4mjU/AUzWhLV65xgtjU?=
 =?us-ascii?Q?d2d4aYLxprjSrPIxBKFo+HF8NX7IxTRyA5U71i8V4BhK6hdRNUxfKVt5O4Ve?=
 =?us-ascii?Q?dStXQu6SBxir1jz2OSGHyYEKfu06zg3OF4fNBpFPs/LHR8GdAilBKiUoLOhK?=
 =?us-ascii?Q?V0QJcyg9Ovtjr435QyDt3Y71jAZWVg8VwXjpPEWBnSFWmlBR58kdR/rDhWYq?=
 =?us-ascii?Q?prdzVyR0VOChsOH7A2mMIFXV4+7LhFzX7lnSHqoUy/1XuobAWwB4MXUjqjZd?=
 =?us-ascii?Q?ralQ4H4AdNcwOD4d9RUa9FylQ6sxwgevJSZM8S/gFFZ7RaB4kWZwNGVHSkgI?=
 =?us-ascii?Q?S7BC4Bvk92cb+eR0XpKztbmphCTgbBSSy8siNHj+fNTXiKs3NmvH6bqV0PzR?=
 =?us-ascii?Q?2EX/VHxZm4isUBuQFAf0cqyK32GlR3amKe25269+SGr4L/PTjqzfKpbF56xg?=
 =?us-ascii?Q?EX43+ocAWjoNcYOoYj948JRMA9X/M8/hQWqhbLT51hYS8mLj7XnZpbsX/t9t?=
 =?us-ascii?Q?21oPPZHnpg84j+PmsQZexjqFNglaG9XkUIhGLDXHp92B7x2L67WTmC5htRi8?=
 =?us-ascii?Q?J7W2e4ugrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b372f-fa10-48d8-6c03-08de57421dc6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:21.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z3TLLuSEyOEhzbsIfStMy1751Txu2VKt8FoFScZ0i2kY/kRlM9qAJyQhE2d+vbKGKDoGJvpLkTG+DlgJUYbpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  5 ++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b256be710ea1..5d98cf27f1a0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -762,7 +762,6 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
@@ -775,6 +774,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b2b3a9bf9e8..f66667735a02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2266,6 +2266,17 @@ pcie0: pcie: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie_ep: pcie-ep@33800000 {
-- 
2.37.1


