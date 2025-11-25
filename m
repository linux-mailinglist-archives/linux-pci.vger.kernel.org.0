Return-Path: <linux-pci+bounces-42024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B765C847E0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 11:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9670E4EA1C9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DF2DCC1B;
	Tue, 25 Nov 2025 10:28:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2139.outbound.protection.partner.outlook.cn [139.219.146.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAD21FF2E;
	Tue, 25 Nov 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066536; cv=fail; b=Qwbl1DwbTtExNx545YCrCLLboTKwdHkKMHWir7ijiXI6lDAhzkqd3WVxzoC3+eV95MO7nNMekuJRBbyo94e0/77iShf3OkWXWTqlSYuwQ9FcEcqKc52rRyvCy3yYz2BFdj01ZUss7k9iav88LUBdm81TXreYjFdhf/a7LuYkxws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066536; c=relaxed/simple;
	bh=eKIKyEMdk1HhlOB3zcry9MkY2hmJ+GDzNKROEa730BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHrG11v9F26NBma0NbXVn2P6Pf7lNwR5d15IxuW6XFlbyFbtvtPXq54mAlrFWBxw8yXOrA5yJ+IFrOuFGPxp4SCHCL0I7x4vNEGNH+Qjlz+RyO6Aw2JmL4m2zh66E2OgioCDg/PImK8l/SbC9CiEhnZPeEusQhLDOYDILsxRXeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNG6lQYjK4+7My0Lh6c3rnGImMFJ8k5KFRhs4J4juF7iyKpQz0hOaODVD1NEyTZK6DCIGiZwcgbppJdLNk6Dq7e0oeG9zCihKcsrRYcC1qDIoG3m0YE7M4PmUUCcYeAbFrTxT226ezH3xhbaeijlMB6dFT3R/HbDPAaHbDWkMYgoMBuYpbuXFr2Q56FJ3puiter74PSHrcnwEQT6SdjmLdykGStUO3gV5uKLfYuhFplYoOgwfP8T3myag9ESWz0pZUMeI05g4R5XPmYnkHMaF7wGLFEyTW8FRb63zpIcipge74CITpGpoKEwLEOZQ7jcnXK9C/rmRaViPD3uCiuvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9eeqaHiWI3NRJEDeADCIVPG/hAcZNLH7BERolwoN70=;
 b=MsP93u9/NnzANIv9AxvU5eWDxLIIL0hSfvP7E38d9ZEoFbtttZnxte94POzTR+d5Q3WeCV90Xy6M/UnhEBFR+5TfwbUmtUj3ula3oW13zkdBEvk1aDXgJVFhd1m3XwYVtbDgDnZ29QX/d9P1VR0Uo6jB4scYFyKwv4gzKDIgknKRAeC983ac/fe6DJ0mGyX9l8abBWW3551pkIR4Bvo6sTlqW9OfWPPl/pLDc6q7i0FQrgQfFgNVspiHTFZ0QDqNga5A6frVr/lPM/177K1enXJjO0maHNmBZONz4b7cnpBkdQuhRmN/2NgP4XJRheX1dGt0Ty4XsFuQLLlEqTFXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:14 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] PCI: starfive: Use regulator APIs instead of GPIO APIs to enable the 3V3 power supply of PCIe slots
Date: Tue, 25 Nov 2025 15:55:59 +0800
Message-ID: <20251125075604.69370-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251125075604.69370-1-hal.feng@starfivetech.com>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
X-MS-Office365-Filtering-Correlation-Id: ac80b638-060d-46f3-6cbc-08de2bf81b02
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	2FWasuTxfwg2Nx6GbAPZupAQvnpWp4T2pvyb4YCioVNkVV2YTV5WHXZ+CKtwpQyt7q7PB5YB0khSzUbOi0+dsU1PRukPyZ3nUjCgO+atRSe/5/MD8lvy6FATav47f603L98gzQcZEZZX7uAxOb4+5eGJVq1nvCvVEC4aJ9C8pXt90uEgHMIGxEM11spx9P9BHraqMIMGrT77cfMRyMPqfbO2hOxGDKA1psoS8D+sHAM0vuBGanyHPv0STXh80ZlbEOsPVV0OegM5RNyJyJ3OE/t6oo3gitngHkyrpnFx0n8IxG3M0LlAuBQ3EzlBTkYXsc812bmLYVA4TqNEy3KWXeH28eXK8AMJ1scItNJGvODXOT24o8nAfr+vEluQDifvlD9ONubyrh2xyYGGx3KX5/hNh3bXu+x2XqSBjo/2CUBfRy5Pxc2A8gBPalj+ptsesp0pZCzG1UD85lpdF7EPSs5sXSENxWQpNUdMBIb6W94rj2ql9ALTFX2zkheviL7TnIravcxMOeg8wQaWAhoSyFrKHG3aYCSeWZ9rNuPwiC3WZo+oDEitYfiSvUiqSa29FJw2tmbw1mlNcJqtaj2Q7KBcizDAcVv8HigX8Ep2I/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EgSNI0H2EgtC3JMOQ4SwA65XXWNm20RsPbFg208Rfup03Gat8QXdTfDD+QwU?=
 =?us-ascii?Q?U5xGo5fn/yRwX4SELyTiVbH5CNLkavWYqCJ5ONX37RcnBRi9DYlP+HF2zcS1?=
 =?us-ascii?Q?Thhd2ygF2Q1pYNlaLdYnqWhNMgO6cn8NjsW9tS1LZXAbzpnzsFeB6Z857D9Y?=
 =?us-ascii?Q?9oTnDD1vsP8T0ONRhi+Blz+BY//0Oq6hrP8Mz6ORdNAn2H+h9zLeahQ2WcKU?=
 =?us-ascii?Q?pbexWVPd4MY7oubB7tQFAWNmAipY3jFSXqCK0tpxReTcOCdvO0F4lnPY1iIL?=
 =?us-ascii?Q?WwArmBnYoLAe40py7Fx8pRS8jA4Ac2mr6MfAY8G7PSX3hFm1+mE6OjVocuaJ?=
 =?us-ascii?Q?i7FY6TduKGvVr+qACxlbW5pElzIha9FE8AVwkkJPicH59slQTiyhClcvz75r?=
 =?us-ascii?Q?+hj2XMqFys7TwpTvlXExV3ebdGURt4w7eIVjz3HMFMrRpq2Ba4IPZdVkd7So?=
 =?us-ascii?Q?3BfMpMmTx/EHCc/wtoIHx4s4vMltPirqG0nw7l/gQyR8P2uesl7277Ak5EZR?=
 =?us-ascii?Q?vLVj6IOy5CN1CiS5Z/1+0bYq5PJxIy2J952GjXVsT4PV7UWmyuR2+6TSSOtY?=
 =?us-ascii?Q?JDioVZ0CrVwybNejuwjYEzDrt4emSnACeWcWnaH5v+/eee+hnlEu6gWaP264?=
 =?us-ascii?Q?0zlc3TmfUR/018YgB6ZoZTlsGwVlt5/A0noRcP6bi1yHJAVLcnWKFZyOcTx9?=
 =?us-ascii?Q?bXX0wGjLO6tQWoKlDMVoxk+DlOAfUj1o7CKU8lKQVmTJCRtKU4WKRoXsdZKr?=
 =?us-ascii?Q?yGiNYG1WFlCcLH31vn4vhUsXtDRb5IOsJwzbyR0uW0LytIq+GCCf3wpAEd3J?=
 =?us-ascii?Q?OzR8rOh2AcXx0hV89/OI2vknAoaSAmx30/g/0PQSFgvYyG7R8EZTlrTkfqmj?=
 =?us-ascii?Q?OWwsTleOxLF8/V0rFFuLWtm8hTl1P/KA0AqZjqvu57qjbR4++a+z7UuF5phL?=
 =?us-ascii?Q?+Xpo0WTCpkUR5wjRAddfuLur2uqEqw8z+dpoxpaNeJ+SBFzb1lajDyRelWfh?=
 =?us-ascii?Q?JP4yETDDlMFWHIhsqPvjnG9/RhiuyGKQ0okVI+FL8PKx2+xMrlaPzqwX+ZYo?=
 =?us-ascii?Q?SLhVi8kj5cKdXK0rx5c+zbF/CmCcr6CaUXbDklSFceT2l2HVVNHBnCeX8K0K?=
 =?us-ascii?Q?IDNfalK08cinIw94AvL+FeLEFa77m5MA4KZRwESj1ClNW79do64fWQgT6eph?=
 =?us-ascii?Q?4oMll/s7cQ/vfNDiOLYsTI44pa63eogVSI4r0AG2oaqdPsWeZAmDLLVwgxc1?=
 =?us-ascii?Q?aGoOiOYVVrXtPKatUkscxFDSfy+K5NrOsj5R3d6Ye1JySfO1TvPZObgAQDXs?=
 =?us-ascii?Q?8SwKF4cEcZiKh/JMfMLTbH9GhdNjs+s29geugweJ3osIjYHhInKWMKqjOSSs?=
 =?us-ascii?Q?+YihXmwAo6iq6APyr2F9F7E/296aODiqnH3t+ZUWvHZ7N/6o5Kt+tD4sypch?=
 =?us-ascii?Q?eTbrFUqmXjyw4BX+o36vY+yfCNrMlJo2u0WYC+AbNgapgNuEVkdVyiIPjyvv?=
 =?us-ascii?Q?XX/Ct//YM0Rb9J4SOSPqgnfexKBq6J2nsLp1jPg0l3G4U6KflZqC0noic/EJ?=
 =?us-ascii?Q?g4ReIZHkGOel4iAnf1U7VFz4WzAjnJEZ2Nymny3/yEHwbpnhGAwDPgBfv8GR?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac80b638-060d-46f3-6cbc-08de2bf81b02
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:13.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GEcVm7n6CZ0o5takKqC6BtWa3hS6A8Hq5ILkTu7kg5vM6JXP99Q0C3vk93VNEKoiI8rp0D9XQITcF3/vkQcryqrwBSx6bGtkmcyKiwHPIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

The "enable-gpio" property is not documented in the dt-bindings and
using GPIO APIs is not a standard method to enable or disable PCIe
slot power, so use regulator APIs to replace them.

Tested-by: Matthias Brugger <mbrugger@suse.com>
Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
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
-- 
2.43.2


