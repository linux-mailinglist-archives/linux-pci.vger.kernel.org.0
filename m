Return-Path: <linux-pci+bounces-42609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A82CA2A14
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4664D3061A42
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 07:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE67290D81;
	Thu,  4 Dec 2025 07:24:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139A1D5178;
	Thu,  4 Dec 2025 07:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764833059; cv=fail; b=h5OlhcZq3Tpf6WwYTLswkb/xa8ou0BG79nPBW3KaOOW2e1EU6I3fN4chtAm/IIV7plLuXpIoKilVqv+ea55Hem3DdU5W+CRLp/21l1lB1VmqLkxOrRdF8/4DlAeSUqeDxJKPChA7VqJ9Uqt6vPP2wo17anV82M26VDQ49hEQRJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764833059; c=relaxed/simple;
	bh=KMlYyyvjbdJt7z+5XjMbTWoAqmJSb1jizRw160hlUcE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=du4TlBefh5hDM4RwHbdCzoCMMtX7kTplUSNoLmU6pLrYH+1ISLFX7U+OIdQBGKBL0Ifk+SQFMCbjBHC02h+fLtYRq5f/MxJ2LqAlDBUdTFmPyKBW2VrDRYO6u2S3sCNa7WTDbigXqzfIhgklFgmyrcjzi8T3HRsBU2QjQNpEEtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1xVEDDiBXtUWhID6B5olwj0yZZxE8y9HxnDI7mYNvQduMG9JDb1LvUro7FziRcKD9zQ3Z5/dy/YwqwbIMoxOk1F9oTW34rT2TRboEj0xKsgFjn0XFt/k1PpkBXo4H/Xdzi6FCbr7TG1foIQSxdHcjbY4p7Dtbn/vCFiAiGnpE/sGf8rZVtdh1byQHr7lV/Qc0hYmuPpxUrgOWbEZhxhC8jDKVJTas5LPxrF5fjYyubw/WZzPLXe+80b4VlZvS0fCDVFVcT4UxDn8vIKbmPVMFFyI+1wmvd5QRdbwM+8TytoeaE2lDbZOiF67hitTemXbDyYjgCkY4cv+Y1GrqQrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrtQpqutb6dEmd3h6Mri5cv+6tXN5+VePqSXFXKxy7w=;
 b=IABO/EuFWhhpvUTxv5YRv/ZCr3I+21zn3cipQT1ShHskHJkASWEEWS1IktYoio3X3H/yt3FsTDMdM5V3E2jCgtlHoO5DsbKHqszMgskcLPs3ZSwbxMXCVbT2OjR1nbGeg4qgXyk0Bjt8ESqskTxo/Ml4e3Eq9cI8xm4R8hJhy5JINhdGlYzNz5jWUbHPGayPf5kHiwUbLeFGSIWxnvTR/WyrfdQVxSX8tjcOBbxOomTZS7C4Z6jhtmKZVitj84VY5u6DF3aZPLqX3p9SuUMGy3q1ppmFanFB+BBjDGhBF4y+YwOi0x07zIbMn5pCSAGkCMYlXr0TUNrsiDMNhkLbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1162.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 06:50:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 06:50:04 +0000
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
Subject: [PATCH v1] PCI: starfive: Use regulator APIs instead of GPIO APIs to control the 3V3 power supply of PCIe slots
Date: Thu,  4 Dec 2025 14:49:56 +0800
Message-ID: <20251204064956.118747-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1162:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f259c0-3c75-4723-b58e-08de33015a72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	MKadG4YDzjslP6dVyjcuQKolLnYNK8EGKjmAa8gzN6UWl5RjqhfgDN8ehFoeCGs3/XlfNRK7qc6zp9uw0mDsz84nWu4trPaNXxodFOaVvfGlpggHY/tpgDj2BvwmfxiSHkGHmE6qvsNU2ZajR85LAqk+GKOIQ4aorvMPWeekMhQSxKHkd8bNdg/jw7Triyd7t9cXCVoE8yW+LHAuhZqpzAlrxd0zlxCh8z0p/pW80hPG9IQu26BNT4nGVdfM+AaDdi8Cqd0Qhd2nnOuFtFNCdz7d8brGades2B7XomiKqHZ6rnMxACYG5SSFm3jAYsxNq23oZPQdpmB+iA0mIZQsj3RGo5rlcL9YiLAz0Vntd1BqxY34fAO5AHXGya9ldb7zWgysUYJpZxIFiG3aq7ffR6g1d5WCUZaSKyeduTU9dP5HGtUlOpc9fRCeFAG9IxUDG3mjGUd5Ux+rTnXCUr9lXCDE5mEXMoGs3ONnI0RUnUpJ4xb9u4DdnBzcLUiI5k+J6EDQMTSuuiAvQEB3ZfMwlKG4GEtxwgykVTGOkzY6tGpPFtow47RlJU8V4X2aS5T/U3BhW/l4yag/9ch7LJoQYBwtF1yV5U8X/S3Z6bh+rkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sRYfUSqNiwPRsHmi5e9oOkh68rXSXBopz4VEXbLs++jTFze5gtOWR4zIwgQ?=
 =?us-ascii?Q?58/DDDAkbedEvqRMHlWIAvDW5xd5TcbZIjJsDUrfAJuh6KtHrl72eqhbOk/T?=
 =?us-ascii?Q?4VaoXkR7k+G1ZWr4bk4bGVPPyNxHZjQeLi56unwNOM03EzzfisID4r7XxrfV?=
 =?us-ascii?Q?2Z97V6JaXo5a++XU0rMygZgnz/Q7vj+qUv5sXjxQLyqxQGFJehucc5+MQmaP?=
 =?us-ascii?Q?b2NTONI8clgFvpKVafeCk1zp2UunnwrrORuSKxXnDfJ5/WllsDquC3CXcOIh?=
 =?us-ascii?Q?6c2OCAkz30d2MU+u5D9QY0BKqqwG4TqSjVvT0DOFeb0d6YlbBMGGyHrxmEwL?=
 =?us-ascii?Q?iXuvixzk4z9uXnvmeqpPTonEp5+4nSzQXkF/wSCXIratpuDkwFzukrhM9SSz?=
 =?us-ascii?Q?TH/8il97KKTnP43J9lU+lm3q17sHh2jIXnB7OhiT61+SpVOhezV0to1M/Mjn?=
 =?us-ascii?Q?6q2IhzlGXcxAYuVR1Fo9P8sSHkqEH6V8G4wDOLgTfgUlyN+Jy2VEMYG6ScGy?=
 =?us-ascii?Q?jj4txBtfwpZXns1YRL0u8lhhivOuU9sHjbM6sOx+lgtg4SdmyGLMM2bRJsAK?=
 =?us-ascii?Q?bUAshUJU+vaBHkyZmRDwmK/wCxW9mfT2p0OO2X15s2EoER5a3Z/pxPgKE8y9?=
 =?us-ascii?Q?kCj65rcRAPgG3OQ4MUWC2GZQG+97iBdopBQtrwQPDpHJB4EGx9B7a0it1mgp?=
 =?us-ascii?Q?rM2i4cdyhxvyhekFJ4Q0/yAA/70ie32uAW93h/TRaoHarykRCunuXTNxGFtq?=
 =?us-ascii?Q?RbERIcKjB1pwkaR8ZWSH6Nw8Io0//YjYDq8imFefnnXwhjPWSql4wutGWQb4?=
 =?us-ascii?Q?U8MGt10qvnaDg3/ghOxhiH/nTJl618YuYIDjUeWO6wG1TSxwyokaWuuNDWNa?=
 =?us-ascii?Q?R/WV22TvufQWLtoJ12SWjv1RTaQ/bS+y3YzQ+9bNVN/Ns5cp0iic9t47OuHu?=
 =?us-ascii?Q?s437zboo6QqaYM76AonDiHxRzbtPmWViIPGLllVzEJn3n/l8Mv/05nKu/eI/?=
 =?us-ascii?Q?auYVLltS/mOMuIt9Qnhl3VQxCNTNFPE8PZ95Etc4o7v0Tn9d2l15JSL9Yw3k?=
 =?us-ascii?Q?Du3Mro+9o5nrGfSo2QLwav4HC9vU4Bk7BpCxcVp/DcBP3c0Fk6q5QjQhpPjD?=
 =?us-ascii?Q?BXEME3QD/qhaQ938mn7OpVCETyxIAhdeyHbXTkd1puP5B5b5dqa5FWsjYDIv?=
 =?us-ascii?Q?fGe/pauECVZJr8Zz3EAYVhDeKhL9tSz9zUU9gx92h/aRid8Z33s8kLV3w2S4?=
 =?us-ascii?Q?HECH5n6UygUv2p8PjRJf2ZkMS5Fm46KoZ/VUYXAydS/3Il/PM+c7g+oBBXS+?=
 =?us-ascii?Q?uPic0xwpL8x+j8TdCCF1nRoC5dprCLmn0XgFXNkQPhc+uljjNcnYfIRxt6lN?=
 =?us-ascii?Q?9g9JRWpXhkyNpC5+poPWwn42mHqoX/Skeiz85hmjIRboFomg59wadDytwtNf?=
 =?us-ascii?Q?S4GYh1C2d+X/UyrY8vlktMbnKn6BQ24m0TxNBlHyZQlJvfASzQoeuo60kYWe?=
 =?us-ascii?Q?quHFjJ+0MpWqpMyhiHj3ycQ30IjRyj9kNj+ZHQ7tyan9KAGISa4Dc4XhQJsc?=
 =?us-ascii?Q?WDyHVgWuZIyf/Hk47TY7nHMX28e9Nb9HEYfuZMD6/4JvEkKVsEwxO3EXOrft?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f259c0-3c75-4723-b58e-08de33015a72
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 06:50:04.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrxsVvLIv7kTm2fiGS/GM4VoeC6hx7bRwUZ/6E4Tqo+0ug/QjO7on70vcNk7dOhJG8819HULN9llmWDoOB0ZrxTM5CHAW9cMxx7hX34xrgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1162

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

base-commit: b2c27842ba853508b0da00187a7508eb3a96c8f7
-- 
2.43.2


