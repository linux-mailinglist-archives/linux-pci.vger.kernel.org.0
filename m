Return-Path: <linux-pci+bounces-24900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB0A742AD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6873BB180
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0820F077;
	Fri, 28 Mar 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZUI4ISac"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5820F060;
	Fri, 28 Mar 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131023; cv=fail; b=IVya+SfI4yWilrcM4DJ2EcuWgBvoSQRf4rjKA1wlnpa4J4tQp6GqrlMztc4s//VwZ/Vd/IHWd9RgOntwm+YkIBcwuc5rldnTjDbC20cMrRgQk/flSwqnz1ZFa7SKb/YUB2esiCP4LYcEIQW6qHzXitoFvM2Wohwf9lvH5d+ihvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131023; c=relaxed/simple;
	bh=HzLzvLWvII6nnnbBL/d5Acq7tPg6SZykZZN+YS0Aq3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnDL2o6RpkAcptJvpS38kuPd67IbAwP54ob4/0V0yl1oKxrNO5CuvDGPuWGv0Y2RCQ1ZVXbYUaUwoOl/Rgypfn/W3oAjDRlkzjB1AWDxi8QwRPgb65RPH+6CpXZ4q2fNKKNXEj9v5XD+Hn9E+hKPlW/9Exj6FRp3qh0GijbdHTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZUI4ISac; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuBCjF53NEyLaSIOTnrOk/vEom18Ibh+EvX209Ps9ESONH0rsyowahRTnPCabtDqskjwJ74Wf+EvuIjnZZzEcXwvHJmeqzDaCEtryjk4E+kkfZtjv5ttUwYoxusvJyep197KxT7cRGqGz5cVDDFf7LGltJWnI7da4Lc53W9WTTq7Y708riFMA1F0IhsAqww1PaqKMn1ME4v7rEqSxEHl6INowU0dpydeOk5F0NzK984MTsvC4KlYQMcw5HtyBuox7Cziljd0ZO0ZW4H4JX4puoHCP9RIk4n/WjIG3xSz5kld11EbrkGSyCwCmdGjc/61aMM5Od/fPbLHIvbis/hjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1HBKlc4akohXR2vCAAU8ZQjNpnESt0CqhEjTdNp8hE=;
 b=DRSI3QqSbIrxj1JLWKqM5uSbTXVUpo0LCGJYSnTfWAE2LVrOYlg2s2QaKugFfYnl7ZwwxCSnp8w+hfdsWW4TtozG1S9+tNVzZufZIl62Fyv90P3yhOao/pipFjdP6h7rMQm/nfuiSFT0zq5YF8COHNjJxHb4PP+DCTa7bS+cNHzO1x/CA6mOiSB075NcLREBYVQ2z1nmhAvsx2nW/hhng8Hv/l8U9ACvQW4g/ALn/K+rT8LZb0LX1tZvHyiREv6MKFAcoZ2LtArnBTiQkf8zy/qtEc+pOZhRE0xRS8bfd7XoKSzc7ZPYXXN1aSntLX/paXVWPmiU7JrMq0nQ9uQ3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1HBKlc4akohXR2vCAAU8ZQjNpnESt0CqhEjTdNp8hE=;
 b=ZUI4ISac+AiHoH3zl618++su/RLZ7t5iDpiTMdBjdD43ak+jLgxTIXmQRfVZglu6c6R1rfBIi96tf8aFBSzJ0WysoEYTy9e2089IAIz8urPiSl70m4OQm6Pg8FJsyxJnf9t+aSggKPG0mDdnmHnSNbcwUCkZHuDDWbuZK7I9t62h53wRgz2OktCOnFpTnREMJhtvHT7gVOgwIhHxPb/jQ7i6vd3NjdMw1V6KIq0+uox/zAEenja5oL8ntzzOvCQ6oTPkukgpX+aqYhRn4QLpr7P8QEn8Y+T5U4kQ95LCbxEP+4oSU7BFlaCGrgsHhpYyUHHy80Z5/QUwFki8PUQyAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:38 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Fri, 28 Mar 2025 11:02:09 +0800
Message-Id: <20250328030213.1650990-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eebecd4-fa0e-4389-1c9b-08dd6da52329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0SubXs93naHdAB4QgqlojtH5AeC5CQs5nb5dLWm1DHI2l/Q/g2irpWpUYCG?=
 =?us-ascii?Q?l+wmbR/K6aNaTYSL3HEJqqD8/OkYD2ay5ttjw5Kv7nSGZVB9rAcHjFjsmshW?=
 =?us-ascii?Q?Z+93fYRoF8pVMvp3IVL1RiIXZPS9DuFqGtBJ9bOp5TwXOQmVOigkzhnlKva9?=
 =?us-ascii?Q?D8hBDAh/gg0h4EsEQCJNRxvZyWvOjfDTvmWRfzEqlUOCLjqd+bg9MV88uOcX?=
 =?us-ascii?Q?E6ELxoty4X0nfpt8iYAU0LlnkDAC2MUlVwoxX/PtD0DRY0rGbfYAUvniYsFU?=
 =?us-ascii?Q?PvOb+ya8gywmQgC+EcHMV9TcBxg2XOp712NN5ytdY5m2NXkDRh53PpFsaPLs?=
 =?us-ascii?Q?Ws2F8jNl/TsFZWH7oWiiFe5Bwe1M+Lrv6aeCv+NWNmP2QbBflsa0c7l1EfKT?=
 =?us-ascii?Q?yX1W+jn2W6APCYGrBUmj4RqusZWsMpfnxSB0jXLh6tlEEseQHY3g/oTqtaI7?=
 =?us-ascii?Q?I3CDbnwotKy4sJ2N/r5kEG7Ieo7yHHQ8+0ByNmY1R8EOBDbENR7yvj0AJvwD?=
 =?us-ascii?Q?IK3fi6yMzUl/Sd5BmlWAhK0j3bzTByq/9shgdMrqY2uqVEVEgb2sY5dMVmAR?=
 =?us-ascii?Q?1XhAb47v7OOA2qjBwEyURise3BqWKt9FGMtis7EMAYXFduZsVlUk+XjYOY/l?=
 =?us-ascii?Q?WO8liFvsQHWdyd3nW+wxa8KbOCjKfaV12/QXE6lnhnYXrCifBDVwCp/9GR2j?=
 =?us-ascii?Q?kpxAtQI9uIP9lSOhcG4r0yVWrVv7XkW1WbBvQB/+fUA28cJnp47aPng7Jedf?=
 =?us-ascii?Q?5bF7FWxKXYtaSfhYkoiRr0LDooAIOZusYn1UJytmIVzc9uv/2KmD1Ijef/Y6?=
 =?us-ascii?Q?p0pyvBdclrfeNr8uUHcDiKxkgeXOAEm/oXhAEPGMOCpnwK6oZukmbUr2gbVZ?=
 =?us-ascii?Q?5U9bzm2TmjPF59nYgbIVeGRKmNELKTjKb28QAIKnd0+IgipxIOjoGYNL+XaO?=
 =?us-ascii?Q?UrjNNJ8ZaLRG44cYYNZ7mdMxbQuAacVb32Hynd1kumsSlcSbP+NUmYlmyG1k?=
 =?us-ascii?Q?Ux+0+qt+RrEkrhVKmlZVEBVI/B6YlR4F21SZS2v5p60Vmca1p8aICC21D6iD?=
 =?us-ascii?Q?LdA7OkYfxhlzolr3sviLnzDEPVOnERkbigxKdFKTT3phum2MhJFAJzemWG6C?=
 =?us-ascii?Q?3QbyI9lyqhQ1b7DDxTZiFv17M4PGnqxnUa9vw8XRYk73nvDySx8Xyf5V/K8F?=
 =?us-ascii?Q?guN1n7HLZp3IIbKE7Y1uW/goKENjnrz7EvRjn8laicEbW8kXchH+4YSUXHmE?=
 =?us-ascii?Q?WJK8v6+4St3RB8i+h3EL0JOmz+1FOCBpVyt6r9t0GGo0jeFuZ1UYRq5Xbjtn?=
 =?us-ascii?Q?M7ETEUI+Mduzb4m6NDAQLrtGwacJ9mixZm3TtTkFgL/dg9EvrVmTL1rhAZov?=
 =?us-ascii?Q?9bV/3AoDRC/U0epNzLR2f7g64pkd1+cIQRvDiPwFmaPQHcNzxPuYwf+dwXEs?=
 =?us-ascii?Q?BuTlv52qGoPIe2YqCQcZs3jVZLoPRHibglQ3ZEYGOgPougCQA4GSfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AWTKiivEjK2VdaxiFgBEU+ftLDxc6z1nZjETDW37q3qspB7Y3Jq6lWXtjWNN?=
 =?us-ascii?Q?JhPOA932hnQegEIJQChwO5ELh/+46vABmCrC2oRKIuc6rN7WONS2whZ7CODM?=
 =?us-ascii?Q?igY1s8rLGHAh0VNvh4Ljtp3ewRw1jVxTbZOeARm5dcGZeZUmeTnXovzWs5iz?=
 =?us-ascii?Q?ZzKbw3qnk5CMaGieMGigmqK+vos9IwMBw5qu3kj06KyZHLWZL1/fEvfl4rd8?=
 =?us-ascii?Q?g3Y3LdTJISBS+mT447Za+BvraZIsgAE5uYWTiTcU8pKmuGOcxKmI7yQ5i8GO?=
 =?us-ascii?Q?BxqDZ+rb3Ak7NcFKjx8dsmyXVPCMsSmknkS6Fp3bgyQbASfkryNxd4dDNLq7?=
 =?us-ascii?Q?3VN8yOMJNO+EwNQOdLooVCM2W8AFQ9ve8u5eYpQK+4Co2yeMKE5LrxL9uRt2?=
 =?us-ascii?Q?zM8qm7WvcBeD9EkKXHuWwZxwNJt8wcj2tdLjMlAAiwesDr0SVfQxfFGacqep?=
 =?us-ascii?Q?rel2RmCaOkyPcqWBHQqljauW0Xn0cwhrY3nIZ7upjiN7OWOMBgEQrVuCfD1i?=
 =?us-ascii?Q?z6I1Xh/qUQZ9+hoSoVx3BO6ZFTxE5yfsGywFan3OdPSF/jnIvAThnqGWr12u?=
 =?us-ascii?Q?4FhxKwZb6gg5KlWHB0fi9EslT9GDO5gdbXKCwf0RnebkwF/QGJ57nO87TUdf?=
 =?us-ascii?Q?n2U4NL7QD2XBMO9KSOM1ix/S+z6Xjwlhf3Ka6wPHv3b5BlKBGd74t5io9+nk?=
 =?us-ascii?Q?l4xsqyYxsaD2aCosHBFndMcWx7gjduZwVs7vnHIJ+pXY+0JmkdRYX1YepiHe?=
 =?us-ascii?Q?Ulfl3d1cW7+VmvDzZcXjr9g/Q1JRoWoCXFYGPAA86/s2SEjdGcdLCpHy7XGG?=
 =?us-ascii?Q?5A7bt9khrvzyZdn2OwRcX6u63h/T7mCCQUgDHj3mbJdmtpL+NwRWpwMx+yI2?=
 =?us-ascii?Q?EGsBETCFKC7QvK/dtGFhpm1LsOyjRmfudauDV/MuMNaGNS32wvZpJ+Or2Mmb?=
 =?us-ascii?Q?Ssw0YmjZGEDh1AT8ccgQd/SXR1IHwiwv/Em/NV/OXFaoxRSmyWube1V7boSe?=
 =?us-ascii?Q?/E7yAHmlM0fkp7b4VdMOC/vOcbyRuUhZpyWEMmO+oMm6aoRlIMO560kNi0N6?=
 =?us-ascii?Q?ARonBWxgzv7kcqXbC9sqpnvixtVR4Uclo101Q/5FomBDLdZ6CFDSb8wZREQ5?=
 =?us-ascii?Q?uqaC/5bPzT+O9vqF5U+MUrQcbSAy3H4sTVWlaje3pp3B7TlhJkm6S5kmVSNl?=
 =?us-ascii?Q?/xzYa2/HvS9JUrNFF+8h/9qy/xxsgm7MG8nX15WZOT5p4nSftCSA28jK7UBu?=
 =?us-ascii?Q?yOrWv/s3JFn63E/InkUxPVJy4i3OmCipTXi0LVJoKiSHKWzXI/McHMOR0imu?=
 =?us-ascii?Q?FGArpPZxpL5uc6A2rz15T8/lpFDgy9j6u4FOnOD8EsWJOWqVPiTgrjzJANjI?=
 =?us-ascii?Q?ecTBkcxNTGN7rvpTz8v8KfBbYQdYHY0bQrY9MkSuuPSVjG+cyLETBcF6RJ5l?=
 =?us-ascii?Q?W6ZfrJ0ONoBC6E9sfsAEEKb8V5YRBqPPolOrGdtUSlsbjj+Opw+Wed9juQGd?=
 =?us-ascii?Q?JR9JIojF0RMLcHbvNc7AHw6njzLs61R8hbvj6GfvIFfjQLGgpoD86cfkFQQE?=
 =?us-ascii?Q?OZ3lqY4QSI1mat4LotS/Xb9SewkZ3h5wBnXEaZZk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eebecd4-fa0e-4389-1c9b-08dd6da52329
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:38.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxzPK015uO+4Gc62B1zEeN9FUCnIWm1j0wRmm/6loNbs5MrYMNjhRbBePA5DEXKLtEZ7LAqacYN8eBoxREbysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 57aa777231ae..6051b3b5928f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				IMX95_PCIE_COLD_RST);
+		/*
+		 * To make sure delay enough time, do regmap_read_bypassed
+		 * before udelay(). Since udelay() might not use MMIO, and cause
+		 * delay time less than setting value.
+		 */
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST);
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1762,6 +1802,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1815,6 +1856,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


