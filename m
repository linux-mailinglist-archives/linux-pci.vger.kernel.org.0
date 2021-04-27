Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260B936C816
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbhD0O4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 10:56:37 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:38496
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236173AbhD0O4g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 10:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN4AyQa9k+8ZrBbcdjZ38QQVVPf0gRbih4FXPFlBxfeAM0mQ6kq24e0Q46f5iq5A+ydGamU8m8Y7uzCfer8Xn3tGs395Qfh0mLnbjCD/yoEtUzTiI95POTXucKt/tnO4DSDyTbsxKlJwizcOImpZN+Zobqzy/ExaHWKjiZnPeH1j4tEUytOh02ONWPOW67JR4WpEz8piRvs4jdrflMAhjOQ2c58Asm5MjWSKJCj2dVFfF7ucya/5hqbBu4GmcKDuqSBQRVWxQt9/EeHHTaXpZukayQjRUOF6TPNoQk7lsjDNwPoh6Rb/Dt02ApZn1VnG7rSueNL5rwi53HkeORmYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm2yugh45ZDctOa6WgoSy543SDn0vGE8d0CvSAbFwRQ=;
 b=LH13K33sAeV5ux1TbTTn3HjA4MNEnMXkCzN0/8n0yMCQ4caqNzMSK+WH1kJ16yWw8jRsLojpFaNoZSS1vqp2Tkev4SqFUifoLOBGFcvA8EFB23DFM8a+YrwrKtMlWi9+TNTY9P3/jFS2cPfFDDDd1o1il1Fb+J4GdLfhvR5GoEI4hwRuKmMMyXcBdPnr1b640uHjp1qAtJPkCEry+ZD25CH6B54tsvXN+Kp369sH8geF3HG/TUyykvANDP15FNkdu3R9ptJ6sOrY6dHHLir24x/LXJV2kIj+J0W/AS+MnatWPE35evzjdwUbBA18eTc/wHE5g1fu7lJ7e5pr86BGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm2yugh45ZDctOa6WgoSy543SDn0vGE8d0CvSAbFwRQ=;
 b=fwvdIQsOz1UnRQ0bjCEk9+aFj5tCQJLnSLiSdnankkwFou9rGy5AnUQFC6g5tqn1MgLQl3n+54c5NBR0TScFsbvhIT3Ue/o3FOfpotx0Q5jBajX+nF9no5bOf7UVhYY+JSp+G9u0x+HwABi+QyWZUo0Y6sm5CJCJ5qfNOtBIqKfWFld1heJLZ7xegqSMRgypb9Wb9suTJ7u6qvkc2yBUJ2ifCZQuD4PNBFkSu1OUben+DOnqm45J55RTuuRU2HZ2RlbFyZV6NAMSnhZIZm8Wx0cKA7nSKVtt3Ki5OvLDvIoq76YSSm3Fe9iM5RcPRw6Eo6MEHqW+YhCMP+DlmXYlvA==
Received: from MW4PR03CA0034.namprd03.prod.outlook.com (2603:10b6:303:8e::9)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 14:55:51 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::e) by MW4PR03CA0034.outlook.office365.com
 (2603:10b6:303:8e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 14:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 14:55:51 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 14:55:50 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v3 1/2] PCI: Add support for a function level reset based on _RST method
Date:   Tue, 27 Apr 2021 09:55:34 -0500
Message-ID: <20210427145535.4034-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b25a730c-3252-4d85-0802-08d9098c8d12
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913E822D5D204ABF7CA75ECC7419@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RepwdBzjkrl0wu3fuMt/t9BHGrH4uSy7qgO7SBGsebbx2pdd/tT/Dq1htyzzqKh/AqItGKiG85P0kCqotKFx2hj0JgVX0Duvudt3uTmU9nO5f9EfVAHFP9N9GRWHu7ubeUGUDGNjOXadzOCcr51Uc9lNMf1nyK3C52oilAhnOCgXPwMKbFv4A9ILdZXLO6WQTQa7fDGkYnTD1WAUTw+O/1m9TPRj7cSLewbgcbluYPHT9qb1sNlnE82vMrp28cNiGSc3BqLDuPZZx71nypOc3O149seRi+59H+tqP0RrBHZsD5MhHhg782WL4FEr5iXLW6CzJp30XidBn1SPqJ65pEcjKMe+ve18IRL+2T37KODqLYWKA92YyJa/P4ZZVwi73JuebYCTo4kmLEgs2LRHpvoeBWj7ucFzcCodvaNK8yhEPVwbGab7SextMcL9dwJKAP8rzGsMPbdxpHVWu3D7GLEkzN8nTYzEPugFCwSq3b2yQShFhZ4WJI5idBLFSscormgvMF4HVlRfig2jbj68k0f70ApNSNHEspLirDbiuk+uH5+yLqeSnfJaTkSDlBOwU1YmPeDHNo5tQAulxWYU3ozjp//X6ZcXGufm3VoPjGBMdmqWW+T1Ut0kx1KbuQqQaZW0xW5X5m/4hVxs+qwEhwZ4DmA+4MfuDkOvN9/3CDo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(2906002)(36756003)(83380400001)(478600001)(426003)(336012)(6916009)(70586007)(6666004)(8676002)(54906003)(4326008)(26005)(16526019)(2616005)(8936002)(36906005)(107886003)(316002)(186003)(36860700001)(1076003)(7636003)(70206006)(82740400003)(82310400003)(47076005)(7696005)(356005)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:55:51.5327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b25a730c-3252-4d85-0802-08d9098c8d12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware.

The ACPI based reset is called after the device-specific reset and
before standard PCI hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 - Fix typo in the commit text

 drivers/pci/pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..6dadb19848c2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5054,6 +5054,35 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	/* Return -ENOTTY if _RST method is not included in the dev context */
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	/* Return 0 for probe phase indicating that we can reset this device */
+	if (probe)
+		return 0;
+
+	/* Invoke _RST() method to perform a function level reset */
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "Failed to reset the device\n");
+		return -EINVAL;
+	}
+	return 0;
+#else
+	return -ENOTTY;
+#endif
+}
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
@@ -5089,6 +5118,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * reset mechanisms might be broken on the device.
 	 */
 	rc = pci_dev_specific_reset(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_acpi_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
@@ -5127,6 +5159,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	might_sleep();
 
 	rc = pci_dev_specific_reset(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_acpi_reset(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev))
-- 
2.17.1

