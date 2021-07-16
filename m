Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978523CB9C1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhGPP1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:39 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:20289
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240913AbhGPP1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP1tH9CfPwTRZQYkhqa95uK6EgdViS3NeLidCdXyAxUWin+8WaA/TfTOw/WD8+1MNtQZUZ+ZsU6tP91LcR3o3KoGIzmCuI0HbJGEea4X8cuLyppiQVnWBsFd3nZ1VXSr6M6qkZEslOJaT8Jni8T3TvbYiDrgvIUQ0ecXGaXvf8AsIdYcxoas29g3OVaDhBfX60iaJOL9gzInxvzFavT+ZhgxDh+LDD6bJpbtBUMoEDOro9gaf7a8MUbmqcqem3uuT/BuskppWzYVXg6W1g5T+z+zK3onKosgCYqJq5LIEuBlv1LFN7KTntp94YpeGnEI7g2HLV2wNfA+qvl4gcgKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovzB+Qvsy37ejW46W9js0hCw+OSIiSu1ZGqRrn3/sv0=;
 b=GRkMAMYbwgiwPPavxumlueO7p0N+mzbCgy+MzQD3NLt7JrsBkgjlgOk11EOC0FRurLcOei2ZeXmUa70yLV/6/IM8oP+L4VPdLP/sQp9HI5UTczcbjEypOjRg8+7JADi6jL86+/MQG+EYTRpVptRSff1N9GUiHCoHbXKa7XEPDP1uEbc6zUwv0mhW0stIZ38fV44krXVrOaeJtxsAd2omT6tKvytlsKR2A00i4RXO+ly3VydX8T5QAyBpHObN/jHu2tf+YYbia+04is4V84MRhuDdQRpv55F2+uUofiXbXrt3r37g+mgy7pqNAtOOg9EsWQgGDMc1cIovIKuoc2ph0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovzB+Qvsy37ejW46W9js0hCw+OSIiSu1ZGqRrn3/sv0=;
 b=c6izm6JAKJEdCct8oS40OPIT1LYGPGABezo30kvgi+IFRcLY4//jL8kzAO5+dywyUVvFtS0VADvNWYcEyoMcFhKFFRttnoDvsNmvW37Y5Tb521P6cPpq2xcArxE7yH+v8sxzEghTGA6tOlQxmT67wBZTeldCMOZs8m8vEA+ljvMQz8kns1vvhdQrgxwChLOly3fkLYTQLz7xa9pc/X++ey/HXPgKuZ0Nfo1eZe2stuT8uPjXq25R1FNJUG7H39i+9KnYk3URGV/dYlgBWVxsgyoOMh1O4t2XcRWNczkUtmBivBql9DEFTmspLoFDagnlyD4cHtI0KQGD12L9ZoVtuw==
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by MWHPR12MB1389.namprd12.prod.outlook.com (2603:10b6:300:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 15:24:38 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::14) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:37 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:35 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 7/8] PCI: Add support for ACPI _RST reset method
Date:   Fri, 16 Jul 2021 10:19:45 -0500
Message-ID: <20210716151946.690-8-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
References: <20210716151946.690-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25bd0648-dc28-4eab-d3eb-08d9486dd330
X-MS-TrafficTypeDiagnostic: MWHPR12MB1389:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1389E084B4EDD8A535A2CF7FC7119@MWHPR12MB1389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfCmMGBlr732wJkhI1KeYGlNtQLocENOggKw6hdG0JxCOcvdDZq/LS2H7raIlcobIMSZe8PUKh+YTaTeAoePZYBudnk728uDEGKPxfEe4DfRidr7QXmNbCf0s4gama9Zfo73NVvSuWb+yvhLMFuDJjG2Zjm+UdebB252SrfLX1O1cm7DC09mJugS08Mcl2MAX7UOS9Frjr3EuvpWp5XhcL8lH/nTLinJzkFVXoeHiTWXPIwpXFjKvG5wSiDbU9s4EPK7P5QiGY4PbCbuOIEeq9wuwURfBuEQU8vta7l9QBWVyMqmdteRpxWDthjzt1LB0WPw9u0g3+prXZ8jYo6DwzAIJQlEJcM0QmyBsY5GMUlYnBtvsUWrYs01FLHzA83TA0DgQKbMI5rRa35+HH/Sr95IfGc+O5Y4/yvDZRwHu+8ku02S7ChoxaIOiJb82CM2++f2ylpWO+oHpaLUVKRMkYEudhHkpFB/G4VnZfuPTsdJeu0nQjJD38oIHbvR7T6eTPtxjmO+sRr5hxW533bbNZTrHI53OepYEk90l5FDPsXYg2o8sJ8zA1NLwl3JDFH/ckgfew1ZIi+dVWXpBATrWgOgvojaR/nLjvyWss6IfbkNyC7e4ko16LewQ2EeCB1xtEErDeKsWxPWypN2SDmS00c6/UEL8/Tfj/q+uxmqa3nV5geJ2lRA3M80FE/WE7DbPCXnUFqFxSZvtjvtNagp9alTV6zpJs6u8l8sAB5n8jo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(4326008)(107886003)(83380400001)(26005)(36860700001)(1076003)(316002)(186003)(36756003)(54906003)(6916009)(5660300002)(36906005)(16526019)(47076005)(34020700004)(8936002)(2906002)(7636003)(426003)(6666004)(70586007)(2616005)(7696005)(86362001)(82310400003)(336012)(508600001)(8676002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:37.9534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bd0648-dc28-4eab-d3eb-08d9486dd330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device. Implement a new reset function
pci_dev_acpi_reset() for probing RST method and execute if it is defined
in the firmware.

The default priority of the ACPI reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 23 +++++++++++++++++++++++
 drivers/pci/pci.c      |  1 +
 drivers/pci/pci.h      |  6 ++++++
 include/linux/pci.h    |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index dae021322b3fc..31f76746741f5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -941,6 +941,29 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 				   acpi_pci_find_companion(&dev->dev));
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "ACPI _RST failed\n");
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cc9f96effa546..8aab4097f80bc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5127,6 +5127,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pci_dev_acpi_reset, .name = "acpi" },
 	{ &pcie_reset_flr, .name = "flr" },
 	{ &pci_af_flr, .name = "af_flr" },
 	{ &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37381734fcc78..699d14243867a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -709,7 +709,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
+int pci_dev_acpi_reset(struct pci_dev *dev, int probe);
 #else
+static inline int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+	return -ENOTTY;
+}
+
 static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 58cc2e2b05051..698a668828f66 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -50,7 +50,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 6
+#define PCI_NUM_RESET_METHODS 7
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.25.1

