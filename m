Return-Path: <linux-pci+bounces-43319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD4CCCE14
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63C0330132EB
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D921A5BB4;
	Thu, 18 Dec 2025 16:54:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F401F7098;
	Thu, 18 Dec 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076845; cv=fail; b=tqtHtAhBZLr6Ag6gY14aa5fFg/PGOT0tqJeeInJADauMPVWQD4oigZcj/0fZz96ZXZrqGw2zFRhP4dq5TZAwaBQEVUkXhUk8sbJwQrVy7SwqnB472p9lrI7rV1Mlz4GyFwGs2hV1pBLCTA1Bsph1TULql+WaB8mSDaHiV00Pt0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076845; c=relaxed/simple;
	bh=bquKVI52jcyDDraaeq9dCzNwpyn7m++am2ax6QSfsRU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j2nMf10OkPZLi1X895Ec8jgcVzVkr3FNi28ZMqCkJPmyqiaZ4kDhU23R2dM1cKEaWuKpskmK1mNcLUAD1BLNec3pDSUBXF85vkY1IQVN5BOmHcy0nIOle8sSJ8fgW1HVWMEz6QaXUK8fVEJ9HrZradnuQLTI4p3OrcLN5NKUnd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLpY8KVtlScKDkaF6fNrCASQGaVZFKtdO/4s7bHUxa4CTg95Bwk/VmT0fNWRYDl4mkx8l2F1AgjvhIF/F5bGeAMY6lKeWgtcNHWpeBZOJHO/CkruUtJvb8r/+eeVegzIUJEnm/zJ/Vp6jCE5X+kdlXfw3nulCJsiauQHxreSJv7nkzvv9ZtG20Jr0jkw9nzhDGxjmCGss3uppRGVFMj696UHdj8jC2HE8QUvLKwnq4Jr0qc7Hla/kWL9EPXc69siQxogxrNqb7AibWyipj+XYtvhempu1uXvwih8Tm0nsRY7il1v8eDUUruAfg85yvsDbWgle+/fV9ODJY0xomOeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr8zuAKsVG0bJXj4ZEETNo9lLoLwIaAQa+5LprdYlh4=;
 b=YtYR9hr7oUYmyjTfsMKYpDe++SU++hVxg8obAk/y7sAw2ded/j5+Vjvpcv7XHLY5abKyesvlqCFwmCQJexbSqJWtL5v6vJb6qxXgyX6uwsrei9OrIXMf8huKTjaCLvlRPjr09fvo4gEfrmr+4uw4zxtAvWFmFx5ilPH5z84u5onNAiFRutvVDlF9dfB8U3gQGgi5o+FqBO5J8FR9zPRs2AzjBzpenkiT70kQvZp4gaTcDATOdaOeGsiYkbdLQ9jwdgGvchHomsyL7HfIuPU8v5XPal8QuxRbB2aP+/0BiWw9VZgtzpt5GApneSL5+O8ANbLQ0wJjguLy2vNaO48Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:21:56 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:21:56 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v1] PCI: starfive: Use regulator APIs instead of GPIO APIs to control the 3V3 power supply of PCIe slots
Date: Thu, 18 Dec 2025 18:21:49 +0800
Message-ID: <20251218102149.28062-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::32) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f2335b-7934-4110-7fc8-08de3e1f45a3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	349P/rllG566kFMxbmpWrIAiX/FJz95loXDXU1Xl0UYbMHrkDEAOgdJa/YZwUBlyjz0NbAptdprk37MD/7Fn6oRGlArfJnv4YFqWB8/4UAnOKi2c1r2FP8trV4vaChrMd9lUt6GP8Gd0llNoONX5J3QxmW1NSq9GOGI61Xt6Y3pG1UldrLmT49xuwkL4gQzmDEfQkP1ZtiOqtqQsaC6CxLAbz9MJgogGYYMdZWOcEPRhdL+MtN0xYsIffD1I/Kpc3QWGpRb4KAKpMjwH1EBVUCS67lWqIkaZOpMQhS5tSJO2zWJzOWqmdFy7daI0SFb55xZk0hHVCLmkRocrxNSHW+1zP0bYcINgeHpuC/R9ajhCPvXL7UBbX4+pLMImmwvKeARGBC+y7T74X7CAVNE4Hd1673XdBsgEPMFJ++Enh3S/bxrTIIhJcP4K6auulsv8kEKtDS+o7GMCM+akiuk928FYA2SIHyyiLuemEthoFYPM0YVnzebY3d7UyHvGnQnr3K0BNxmI4xZnSLMNYma1jIQJ5DTVbcJtwfSkGdHoXnqRT53GuYXKAf8WQ3/SqYQs6EjyXv6qgCQ+7ArcKYu1jBUn0n51Mv32dUrbCjHg1Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9LhUJF0BWJLcCGcdTDIB6heJgX2VwJNq6CgeBStAXbWYaxQcb137o4Dgv5Q?=
 =?us-ascii?Q?twEBES5yy9ZIgWWJJh0x4Bm0ovJcV4SCeNnh3zvQltJkbw2vgLbJGeB/y9Jh?=
 =?us-ascii?Q?SQDWqi1t3bHl4/t6+PrqVBF4wVdTOWS7b8M1LQB7nR+CfeslrfPGgoLOZPib?=
 =?us-ascii?Q?6g5nIA+r+5D/gF922BUVA7OKYbw0UGZ84QjBhjjV/JaFodbY8MsC3kGhM1bz?=
 =?us-ascii?Q?s/UskeENsHOy0+i3aokdBS5AfxLTDeObnGjRx4pLTNSPdmTaeiMgDxo+J0zd?=
 =?us-ascii?Q?SZDk1o9W0BNe8qCGFddKCANUs8sOQ+wyTducda3fzcQoL4JsJUdAnY6aDr+G?=
 =?us-ascii?Q?cOlvCJFR6DRBoFNXGo8L4OBw9ebjs0zO+xaz7NhYiadyJpzUHhCFiwEdSk2h?=
 =?us-ascii?Q?014R1CrFkdhNun9PBMjzqusFFvoAPYIGbNgHj54VTe0PTBBdZLxZuX9bAS4L?=
 =?us-ascii?Q?vaMx0cOpC+zuau8ZgljlqsE8VfJHabYvSJKqPmGu+bWesfYNOHLTLA4RWzb0?=
 =?us-ascii?Q?FtlfwNCJX1JkJYUQS3o7O4fQn4JVeuHA5CJxo06ahaq9SW+DHzTcKeqwskvL?=
 =?us-ascii?Q?GRydZ3ck5iBO2eX+ueGbChfWTUJN6ziWy0fbJXJ7AINkYUGvmDqVec1qUJg6?=
 =?us-ascii?Q?s1vUffj6idYz3F4wv+hG58Zv0rTh1+Xg0csW09LHWNlSUbwKQkXmNAVbtaBx?=
 =?us-ascii?Q?lrRRw4acDkm1gI0s3ZQJUs5wqkLN03m/E30LcQVMZuudA07L6wV9StZ06Cxw?=
 =?us-ascii?Q?hlHwGJcKHH+Eg/7ANLF9ybzHc3nf3qgoVBWrf3jIHwdA/c7vdDTkyqQwsqz/?=
 =?us-ascii?Q?dlx9lqclll1UAxIqgMc4gQ6pCdRvM5+sIcZreqRnJ6CCIfbk2V7T057KZaZW?=
 =?us-ascii?Q?4+lP1iGeIZlqxSIiuASXSF/U4rEIIzEJulbW57eK5yN/ChqA2js8eRGs3g1m?=
 =?us-ascii?Q?FhGS2pO7TEN5IJE8/jAye244f3QN6VPMo5A/Ip+bT3kEw8ELiM27vzkg3EBd?=
 =?us-ascii?Q?vHcBkB9sBK81l0OC6HU1Lzm5qds3CfMrnfK78LBToum3yAROrFvMgKnPwnRY?=
 =?us-ascii?Q?rh3uWJbXe3A0y7CwuofTER6tAg7KC88GWVuait5wCxRD+ogNcx7dXK+Usgg1?=
 =?us-ascii?Q?UJC56MvQ92q5vtbKTRdjWjfFRy6KDbdHdxogcf6kjfg/WCkSkDIQqTUWRC0r?=
 =?us-ascii?Q?XHJ+/sKIEtRaVCD2rBB5uW71CSXgP+BV8a2f3TFisV4wDJM0Ykmle4aaq3+Y?=
 =?us-ascii?Q?QQPzV+rsl7x5fMiN+RFZ2y8wXqbim8P3bk23yYn1jWL4NmUUIRvS53M1K4mi?=
 =?us-ascii?Q?s67vl7G6KIXdsOSbqHlgIeSZ0ukaiI7HhUZmlDPCWDiE6Swk8jFCY9Xxu2Pj?=
 =?us-ascii?Q?64hEL0UcQfoHiG4GqSUNgEC3SabGQwb5PrN8Dn+31B3QbaDZ0uosTZNEteC7?=
 =?us-ascii?Q?U8Ja3Vc6oYY7j99KIJbgm48lpbF2NJPfrHY4hhWAE5s4AJfsPh5s6ITtLxYS?=
 =?us-ascii?Q?05sf6n92oJRA2t/PCmRIghIRFOe1/PMQeOfNbChEpf0KYTnb3TYE7QHOS2Lm?=
 =?us-ascii?Q?Q+W5psHbi+3XYGUwUJZAuVaU6uNrEFU7tSVky3CMhUxpLE3VpJ6qFCozrdju?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f2335b-7934-4110-7fc8-08de3e1f45a3
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:21:56.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YoIixrF6Gml41RA9Ic6DJlzM0q45GfeTIxtZ3wGx4A27MJBZUgers3/ijmdE4qeS0/2CsMpdfzCNrjm1o2s12TbMHjjpbZ50HILpOcOnsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323

The "enable-gpio" property is obtained to control the 3V3 power supply
of PCIe slots but it is not documented in the dt-bindings and using
GPIO APIs is not a standard method to control PCIe slot power, so
use "vpcie3v3-supply" property and regulator APIs to replace them.

This change will break the DTs which add "enable-gpio" or "enable-gpios"
property under the node with compatible "starfive,jh7110-pcie".
Fortunately, there are no such DTs in the upstream mainline, so this
change has no impact on the upstream mainline.
If you have used "enable-gpio" or "enable-gpios" property in your
downstream DTs, please update it with "vpcie3v3-supply" after applying
this commit.

Acked-by: Kevin Xie <kevin.xie@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

This patch is derived from the reply of Manivannan [1].
And the previous version is [2].

Changes since [2]:
- Improve the commit messages. Add description to explain the impact of
  this patch.
- Remove the Fixes tag and the Tested-by tag.

[1] https://lore.kernel.org/all/xxswzi4v6gpuqbe3cczj2yjmprhvln26fl5ligsp5vkiogrnwk@hpifxivaps6j/
[2] https://lore.kernel.org/all/20251125075604.69370-2-hal.feng@starfivetech.com/

---
 drivers/pci/controller/plda/pcie-starfive.c | 25 ++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 3caf53c6c082..298036c3e7f9 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -55,7 +55,7 @@ struct starfive_jh7110_pcie {
 	struct reset_control *resets;
 	struct clk_bulk_data *clks;
 	struct regmap *reg_syscon;
-	struct gpio_desc *power_gpio;
+	struct regulator *vpcie3v3;
 	struct gpio_desc *reset_gpio;
 	struct phy *phy;
 
@@ -153,11 +153,13 @@ static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
 		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
 				     "failed to get perst-gpio\n");
 
-	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
-						   GPIOD_OUT_LOW);
-	if (IS_ERR(pcie->power_gpio))
-		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
-				     "failed to get power-gpio\n");
+	pcie->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
+	if (IS_ERR(pcie->vpcie3v3)) {
+		if (PTR_ERR(pcie->vpcie3v3) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(pcie->vpcie3v3),
+					     "failed to get vpcie3v3 regulator\n");
+		pcie->vpcie3v3 = NULL;
+	}
 
 	return 0;
 }
@@ -270,8 +272,8 @@ static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
 		container_of(plda, struct starfive_jh7110_pcie, plda);
 
 	starfive_pcie_clk_rst_deinit(pcie);
-	if (pcie->power_gpio)
-		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	if (pcie->vpcie3v3)
+		regulator_disable(pcie->vpcie3v3);
 	starfive_pcie_disable_phy(pcie);
 }
 
@@ -304,8 +306,11 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	if (ret)
 		return ret;
 
-	if (pcie->power_gpio)
-		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+	if (pcie->vpcie3v3) {
+		ret = regulator_enable(pcie->vpcie3v3);
+		if (ret)
+			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+	}
 
 	if (pcie->reset_gpio)
 		gpiod_set_value_cansleep(pcie->reset_gpio, 1);

base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
-- 
2.43.2


