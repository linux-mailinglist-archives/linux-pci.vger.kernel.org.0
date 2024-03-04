Return-Path: <linux-pci+bounces-4478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A1870B86
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14A5B2219E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545967BAFE;
	Mon,  4 Mar 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9G7VuBn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06D7BAF0;
	Mon,  4 Mar 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583949; cv=fail; b=kzVHpv/Nv07xkGMvatRl6g28BV4SeHNCbtmxhkr4vxE45XbAku5dkWhc8jsEhGgP6ed/O5yUH/HziDcuWP8vBqlebZ7eFGgGb2cgpJWHqni6o2vCR9y1QM1KpLW4yYCI8yKJmatUijCndxDjhq8VZPqMbU24yXBiVW9A9Bjrr2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583949; c=relaxed/simple;
	bh=1r2H1hqe2HsquQcW5xHXQOeJXeR6VzCgSFRI6Lw/PzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tfEGT7v149kZEFCxe43ymKy/9D5hLhqO4hpLAaSktGXWYJ5tCAs/XJEiQnffFCJWBx0Zlf/xw+5W1tdDf84fWqQorj/5NySmmJftcOYfE4+B4P2XgKEfoSqOC8ckw0nqxvvHepRMj7k4iRPQOlR6JiX2kXkqAmdNwFhzq1EQmKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K9G7VuBn; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0NaVPKsoaaYXfCW3hua0QZqeNf1dmI42XNUd1rnyXfJpLSIQMgpKb4rUVOnRRiiB6OOOMawxWGwl8hF75H+5Rqf9FqnGRvS2neIrYZDpxqYvKn2l0iahNTFzUhmEHyjgWNtpcMW/+U1nWxJUkXF/BhXm7Hh07Gf9ouasOHDnlKvIvMywfQSb5ifTXnjEeJcfAzfH8sJHmEcYcRuaHkrk8Xs+gVAtoSEWjSjyyaMeq/ePMixqgvaEc5GtFj7GXcoxObTIz3tPJEyLkivYmYqt3oOknXgrSvwOLvhnL0ESucFU7awB74BqDf/NSpYl8o/w8ZcLqHINZYobaFXtXbkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTPBXfAX1P6YHzKk8sQ6o3YDjVYk1m+DwbidtzQix0E=;
 b=gk8J4RHs6D/8agIdqbd60oLCAZzRiUGKLMxv4xmeBSN5bqUK38CFqR7/4RDpVI27naoFnjlEOTUTGx5gjWhCBTIJhoBCqoz0ZTDeLPIULQEp8kCuOlMoB6IC+a86UaiH/k+HcGOG+VWIQS4fQUFFGXl8BduPkNbV8CHuMYaNOXNLilnNWFRM/j9TN/WNHpxbV5QZzLxy9bUna0g2ofmVMUXyOhPV+z7fbJ7nD53E6DoDUKonuDhZwgTvu69BrLBk25kGjgHfJLyNTtP/TYhA9JhTZYkh6FEvcEXjRQsYtSe832hiw3E9Dgkkq+u+jg7HbZcsXCeej6xWVhJw/IK0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTPBXfAX1P6YHzKk8sQ6o3YDjVYk1m+DwbidtzQix0E=;
 b=K9G7VuBn4eyxDXdS52CjEhB9se1DCYAy/spN3wC59SaSp2mrOwK3ruSqzTGWcuICw+NDkxh9YQ8xxpJQLTAH76yygMr+YOewQ57sr1N/2/Wcyc6MDjdGRzX27Z3hkLDSNacMJ1qFaOT+Py0doNNXJVN4Y+WXHZTIwtjUcOyl6FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:07 -0500
Subject: [PATCH v2 2/6] PCI: imx6: Rename pci-imx6.c to pcie-imx.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-2-ad07c5eb6d67@nxp.com>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583933; l=1420;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1r2H1hqe2HsquQcW5xHXQOeJXeR6VzCgSFRI6Lw/PzM=;
 b=1rYsnrMpwBTgURMdc1OsHoxLP7WF22aLHJH9UQyGqvvPuiAVvdNtJssV4o+lQkYXIsTNbhdej
 QOWhT12HNaBC3v6mwWJWHY+LFe/UhXpMKqcYSUTiLdxlrjg62638Z0y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 859e3365-af77-4b9c-94aa-08dc3c89439f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kfZ/D0CHQF8vfCsoJoWulhgtUWXb+eVzoIGV5LSZVDoueBcBrANQ/FaUZz2fXj9COmaoCFvQNrj861vGWH7iwRkFco80VSnuGywm9968eYcM9Z/PpKfy9+5CraPOswySZpe8TGUBVBEeQ5SKm0rsQRN+EsR0mLQSuLbamutzpAd1p2KgeQRV3OxUOLN1hG8ly//RbszFG4EA43U/pyl8gMyWyWZm5TJwG2+kjYr3eo5bbr+9zCNfYsLPCdODK+KtIN/9m5ZihRnMqbMNeCHh4JU/g4Z7wo7VuWhFcc5OiyMrKN/KBMMB6Kz5j+76p8Nyaj+Ze/w3bEDyspcknEmK8hVRHxnoIhiNC0ZOTKoaXag26cgJSmxF7etlhjVGhzF7TmXbNpM7kCZ5oBjki2LjEfqcFB7zzorOz+epmXvokYe/lkjzhFnRvBvNYxZAa5mKuo/pnop/0ApE+4JwTqfWpnVaVMLZPPkkIZowqnFDnaZdZ6vF1TxwwyKYzl7oGNezKIYBKKceSbLr+FWuO/cLiHbeRusL7e4EuCgKrIxLTwEIwi7uCdKGLUgPR5+97ndUfsfWd6wZgZt4Nh4CuyWGTtXA1GtoyEN8UMSmhedJ6XGrbJ30ZYs15ErYhgvQPFM0SD+Fn0d9bZ9EniYbHMdntL5bNbH4ULrJGzLlnrcx7FeVicWYYm1OdzS2t4jwiiExKA8cBsHNxClPyapJTXtLQcQUbM+ClgzoMxBR6kQVcI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVhZMFA0TEp3NE1Cc1hwdjRHT0xya3ZNUmhQUWNyY3h6UEEvd3dxNzhYci9Q?=
 =?utf-8?B?M3ZMRkorZFUvK0t2MWJUNXFsODlJRStBZW8rN3BnKzZybXlUd0YvQU4xam5v?=
 =?utf-8?B?QlBpWXlHWVQ0ZTE1QStlVHRqaEpCRyttNkdEVFUxN1NpNERvNVpHc0M4NGlM?=
 =?utf-8?B?dVlRdis4WEFkYUZHRFlYdEgvWFVkcm9KdXBUeTBaOTJFSkhSQy9tSmZGQXN2?=
 =?utf-8?B?MC9WLzJoSWNiVGdNVzlPVmI4cTdBRGxOb2QxOFdYZTJ3L3NwaEVoK2xsbHpQ?=
 =?utf-8?B?b2FvaXM5UENTeS83dWh0K3R5NHpKYUlpWCt4RmQxRWQ3V3B3L3lTOHo2UkNi?=
 =?utf-8?B?UjlITzMrU2NKbEsyU25kcUhCeDVvMzNhWDM5Z3dDUmVqTjZ1Rnl0c2d2bE1N?=
 =?utf-8?B?RGxyWVFMMTdLa0puOG1OTUlOZ0swekRJNlF2ZlBmcVV2UU42MkFGN2x6Ly9X?=
 =?utf-8?B?UnlQdVhjdDAzSWJTUGZsK3R2SW0ybDN0ck5zMk1xcHdPcE0vUUtzbldWc2ww?=
 =?utf-8?B?TW91UjdWTkZBbm9OUGR1OGVtTE5SY1FnYzZCaEZKbHllWklqNVhVSjZLZDZx?=
 =?utf-8?B?L0ZyNDFyajMydFpaY2JzaTNqa2E2Q1hpRFdDQXdBTU9iWkRMRk9qeE1rcFBG?=
 =?utf-8?B?ZzhseVB2OUNkSlZmOGxKR21HcG9PUVo3Syt1eWJTVUhvN0Z2dmZKeEVrSEcz?=
 =?utf-8?B?WkUxY1ZHSzd4cG5SQmQ4QnlZNm1JNjJBSlhHTTBmUGNGNkozR3I4cFU2Wk9I?=
 =?utf-8?B?Q3YyRThiU1BHejUzOFdGT2FHZFUwbnp6WFV0Qm5ScXYvZmhPTEFGSXh3Rkx1?=
 =?utf-8?B?eWgram9KRHJqQTFHMlpXVTdBZjN0RUhvNXBGWUFBcjhaSFp1elF0WjlLSFJa?=
 =?utf-8?B?YjVHMVpjUTJ1clVxV0dCZUpyeGplRUZaRnZvWXZDS0xHSVI5bHhqZDNsczNN?=
 =?utf-8?B?Tm92eU96Z0ZzM1BnZ0tvc21BR1NxNTl2eDUrK3lobENLT1RSZ0lBbFUrdVAw?=
 =?utf-8?B?NkoyVEtsd08wRDhhbzdNZjhuRmZCNytKeTVveVR4SzVET3duVVJxUnVxMHAz?=
 =?utf-8?B?bTl0c0llajdGdGN3bm9RRktGcGJrUDdiK3lLajcxU21KQTFjVXF5WjVobGsv?=
 =?utf-8?B?bmlFQXY0SVpFeHBJdnVpdnBPZ01SM2Q4a3RNTXRURzZlcHBIOGJwOEM2Zy9V?=
 =?utf-8?B?QVRLUzQwN3dualhoRWIwc1h6dTJOR0hhTVhMWW1Na1Z2OEI5aVVaU0JjanVi?=
 =?utf-8?B?VWJiOFpNU1JBMituelRCVDNoRGFCQlZjUERtK09uemRuWTVCWUZPUG5Hc1VW?=
 =?utf-8?B?RnZpZWl6NGoxYnVwc21VNnZJaWo4eVhiT2tzSE5BRXpFQXVVa2hQVi8xeDBa?=
 =?utf-8?B?cXViNThScGlCSktoSmlXZjZFQkFTSm5SUmVpdEVaY2FsYm9PR2pVSmdSaUNv?=
 =?utf-8?B?QUdvelpXUzJnYjdYZVY2eHpCVGtOQS9XYktJS2VDYS9INFZKN3ZWUldVYjFE?=
 =?utf-8?B?UjR1SGUvOWw4eE1pUCtZVWwvZDBBQkI2b1drUW0yTDk1TlhTVjVDZEFFVWtY?=
 =?utf-8?B?UmhsSVN3blFkazZIN0UwK3IrQkdWVmMweWRZTVNrNzFZZHZLeW0zajdVekZU?=
 =?utf-8?B?U3ZXZENlZjBNZTU5eU1GYVJGWlpydXVLNzRmU3owTUFOeXV5Mm93eGwrTlpF?=
 =?utf-8?B?eXA2WmtQNDQ1Q1BuT2RTUG1LN25iaGxSb080SDBHblNWSzhUSnY3RG5uSWtS?=
 =?utf-8?B?OVlpSUdGMklTSHVpMU9EUEVyN053SHVEb3J6a0JSOW0vSXJlNWQ2eFBYaWd6?=
 =?utf-8?B?U1hyb3d4RlIyZjFsY2NPVTlvdGNvWkxMUmdBMWhSUm9JcDdMUDJQQlVla1ZE?=
 =?utf-8?B?aC9KNjRmM1drQXFpeXdNQWlYaWNLYmJlMDQzdTZ0cEpJYTdKNlptanM1TnNC?=
 =?utf-8?B?WHFSbmNVY3pCUGY0bnlmTkl1NDl6SUFBR1h3T2FMOHdZZGZBM01mM2hmSkxj?=
 =?utf-8?B?dG5qY090T00veGFYMzhOdFFRY1gvak9nNWhRV3BCVWJ6UUhieHlVbE5VY0lS?=
 =?utf-8?B?QlNQSlE2cm03cjlPLy9CRTYwOUxzSEdhRHFXNFdCWTFscVpBZk4zNFpTb0Ev?=
 =?utf-8?Q?TMrb0l42AyS3T7AQ42sqP84r9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859e3365-af77-4b9c-94aa-08dc3c89439f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:42.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/s1FyvFhYRW3PNVKzpSuhTvzCSF48i0o7W06iG4UEKyMuH8GdyQgzxxwGzeHUJmA1XW5uDm9P6+gV3EmdMYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

Update the filename from 'pci-imx6.c' to 'pcie-imx.c' to accurately reflect
its applicability to all i.MX chips (i.MX6x, i.MX7x, i.MX8x, i.MX9x).
Eliminate the '6' to prevent confusion. Additionally, correct the prefix
from 'pci-' to 'pcie-'.

Retain the previous configuration CONFIG_PCI_IMX6 unchanged to maintain
compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/Makefile                   | 2 +-
 drivers/pci/controller/dwc/{pci-imx6.c => pcie-imx.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bac103faa5237..eaea7abbabc2c 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
-obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
+obj-$(CONFIG_PCI_IMX6) += pcie-imx.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pcie-imx.c
similarity index 100%
rename from drivers/pci/controller/dwc/pci-imx6.c
rename to drivers/pci/controller/dwc/pcie-imx.c

-- 
2.34.1


