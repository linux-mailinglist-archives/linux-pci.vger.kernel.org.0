Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247EF3CAE91
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhGOVfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:08 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:21472
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231347AbhGOVe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLlfKkmKpYdhfP29WyIFe5BiVVcf4VhPB9w6fSrDvxgMqqX5kWftsDTH0mVeUqJTpeqrLowMi4+ke2yAVJ+ZG2SPX4KAMGdqL4khYdxOcvIJOyAucSo3IkordwjwbhLuBoXNdQG5Gi09eFVtqwVN1lj594n28vEmDaoAzJCqkRNUjsdWalwtXzGK4Y27p27UGfYWS1spIFLfMjpcJ6syny7Gu5fzDfBZXohoALkYO+JchLDiwaHHIQaq+2DJ72xw9LxMz1nYo1g1XQjvFHEIU6vkjXSgPDpnW6Hh8CGGlzLIiED2vNZzvXAtVnMjiNhwL3fqJIsfYkYv0WYCBk5/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cziv2NW0lWnsmfgx12k0Ck9NVtSNjKT67wiQkKh+vzw=;
 b=IM1Zhpf1x2fEv//e5xeW6TFhcdojFAaBMGgePehZUFY+WH/Q2WDPjUJ4EZ6IMP5fNPmlmSwxjJlMvd+yGNQK93AklkDhzvLC+NUDReo9dolxNRyNNa/g9CKGuRm5dkYSN8PLY4SlnbH7NIZfOWrjVif9uLk/O5vVE0TC7bumpzfVlsOrWBnYK7EVvAHYTW3/D/gIFL3rB9GqxjgPVHnbTonkNzITcWLgMpzFI2JLIRODVSe4iM3Lc61+jjG82Rw7TI2gZ86ypUf3txQRArLgh/jFXZhjGeuq2jOUP7L5OGEjCygOjAeNcb26ETxZdNc0eoqPO7eIXASy5uq2waXAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cziv2NW0lWnsmfgx12k0Ck9NVtSNjKT67wiQkKh+vzw=;
 b=MfO4mwwlVxMFBX2umtmodyvI0strhugeIbUoyqqnMrBXZdj92i12icjU8AU2VUuE8OUkV5wCTt28BgW9pvfMFJjMAtfhJKRFCcKEDXROZ3VkzDf1jO9VcEKeywDlWOo60RZRvSG+DQGqFojyuFsixUbYxnZPhy7AiIJdiCKZeGXdHLs5O+1EmXF7c3P/buOpGAwQJ5d3N+wfKRaoHmuLVKQBh86qF+8jVvyO4qG4vdwMagwYDwbDXR5h522+ui8/lSZHdTsmYLFdcNiTxhK34p1g/CoqK7wZDMn62KWUlT/JfvZzI1CPy+OB4rwDlCW3BSLQTVpgFDRN2RuXMaTM3Q==
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 21:32:01 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::e0) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:00 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:31:58 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 2/8] PCI: Add new array for keeping track of ordering of reset methods
Date:   Thu, 15 Jul 2021 16:30:54 -0500
Message-ID: <20210715213100.11539-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b62462d-0680-42bc-9bf2-08d947d7fb53
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2540D6F56F639F56618F95B4C7129@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3zsP4Iy9+E70BnKhB6+eQfEFQypvSyjdwfOI/QU8/FeT1stp6vN+DwPNyT2s9Cnf4HfxA23VoU8bBHuHe7IjhsuZNDKpfIw3ZhzTyv4jqnaRriw3r1BgX21YqzXNQkiNFgMvzjOFoLexg3xtSxGH63hhdcvf1Vq9w7lZ+YSFeex4ZYINso6UGrfM9zBMouxq9HtoXQ5Ub7tswvRz6PpsOAccGTlxp74qjyyMkvUrBXi80jcMYi7xjsSsQ3CN0oTnaa5tQKBI5fwvn4swOcgMyHkrlFZwHHbAFIo/PAPaidn5HDgyHgVSokkXQaF18Z9dAnWNKMPTcyV1auQCfL1wzmDd+c2M6Tfmb4XGxujyRJ2pht0c9BlgI8o4wVzGB/Pu8T5cmA+VMex9/mHslP6Vh80AdQYye74eEZStJ7hRKf08VgX/EvVoj40I1Rz48SFhVW0a+tdcjabwyqQMAvNC/QqtzhGOg/ri+XYFW5pDQBToabh/NR8f6kWcPu6ggTsCZsoaQx8bjwoD3opSobAyjKfoUD8SHenBqOAFy9lczaxv96oq+/5VBLXz5tJstbQFXA6yWoO9G8/M1P8aIzMC4jv03eWXbWJmPHras714+1gdXJyWvTDu6hyqPqcldH8fDGkDTg3Y1gugFhgkhxX7mT87D51jJPxSgQuA3/PVCM1cUZNFThvVnIh3KsxS441953Z97deWw3ZDBlQCLeAvSA4+PZG5S4oP92+fUawh9E=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(8936002)(82310400003)(54906003)(7636003)(86362001)(2616005)(36906005)(34020700004)(316002)(1076003)(107886003)(8676002)(36860700001)(36756003)(2906002)(478600001)(6666004)(186003)(16526019)(47076005)(5660300002)(26005)(82740400003)(356005)(6916009)(7696005)(336012)(4326008)(83380400001)(426003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:00.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b62462d-0680-42bc-9bf2-08d947d7fb53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Introduce a new array reset_methods in struct pci_dev to keep track of
reset mechanisms supported by the device and their ordering.

Also refactor probing and reset functions to take advantage of calling
convention of reset functions.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/pci/pci.c   | 92 ++++++++++++++++++++++++++-------------------
 drivers/pci/pci.h   |  9 ++++-
 drivers/pci/probe.c |  5 +--
 include/linux/pci.h |  7 ++++
 4 files changed, 70 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16870e4d7863a..4d5618b232363 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 		msleep(delay);
 }
 
+int pci_reset_supported(struct pci_dev *dev)
+{
+	u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	return memcmp(null_reset_methods,
+		      dev->reset_methods, sizeof(null_reset_methods));
+}
+
 #ifdef CONFIG_PCI_DOMAINS
 int pci_domains_supported = 1;
 #endif
@@ -5116,6 +5124,15 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+const struct pci_reset_fn_method pci_reset_fn_methods[] = {
+	{ },
+	{ &pci_dev_specific_reset, .name = "device_specific" },
+	{ &pcie_reset_flr, .name = "flr" },
+	{ &pci_af_flr, .name = "af_flr" },
+	{ &pci_pm_reset, .name = "pm" },
+	{ &pci_reset_bus_function, .name = "bus" },
+};
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
@@ -5138,65 +5155,62 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
+	int i, m, rc = -ENOTTY;
 
 	might_sleep();
 
 	/*
-	 * A reset method returns -ENOTTY if it doesn't support this device
-	 * and we should try the next method.
+	 * A reset method returns -ENOTTY if it doesn't support this device and
+	 * we should try the next method.
 	 *
-	 * If it returns 0 (success), we're finished.  If it returns any
-	 * other error, we're also finished: this indicates that further
-	 * reset mechanisms might be broken on the device.
+	 * If it returns 0 (success), we're finished.  If it returns any other
+	 * error, we're also finished: this indicates that further reset
+	 * mechanisms might be broken on the device.
 	 */
-	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pcie_reset_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_reset_bus_function(dev, 0);
+	for (i = 0; i <  PCI_NUM_RESET_METHODS && (m = dev->reset_methods[i]); i++) {
+		rc = pci_reset_fn_methods[m].reset_fn(dev, 0);
+		if (!rc)
+			return 0;
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return -ENOTTY;
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
 /**
- * pci_probe_reset_function - check whether the device can be safely reset
- * @dev: PCI device to reset
+ * pci_init_reset_methods - check whether device can be safely reset
+ * and store supported reset mechanisms.
+ * @dev: PCI device to check for reset mechanisms
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
+ * to reads and writes to its PCI config space in order to use this function.
  *
- * Returns 0 if the device function can be reset or negative if the
- * device doesn't support resetting a single function.
+ * Stores reset mechanisms supported by device in reset_methods byte array
+ * which is a member of struct pci_dev.
  */
-int pci_probe_reset_function(struct pci_dev *dev)
+void pci_init_reset_methods(struct pci_dev *dev)
 {
-	int rc;
+	int i, n, rc;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	n = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(pci_reset_fn_methods) != PCI_NUM_RESET_METHODS);
 
 	might_sleep();
 
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pcie_reset_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
+	for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
+		rc = pci_reset_fn_methods[i].reset_fn(dev, 1);
+		if (!rc)
+			reset_methods[n++] = i;
+		else if (rc != -ENOTTY)
+			break;
+	}
 
-	return pci_reset_bus_function(dev, 1);
+	memcpy(dev->reset_methods, reset_methods, sizeof(reset_methods));
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93dcdd4310726..482d26cff7912 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,7 +33,8 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_reset_supported(struct pci_dev *dev);
+void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
@@ -610,6 +611,12 @@ struct pci_dev_reset_methods {
 	int (*reset)(struct pci_dev *dev, int probe);
 };
 
+struct pci_reset_fn_method {
+	int (*reset_fn)(struct pci_dev *pdev, int probe);
+	char *name;
+};
+
+extern const struct pci_reset_fn_method pci_reset_fn_methods[];
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_reset(struct pci_dev *dev, int probe);
 #else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d99ef232169e2..4ce7979d703eb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2430,9 +2430,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
-
-	if (pci_probe_reset_function(dev) == 0)
-		dev->reset_fn = 1;
+	pci_init_reset_methods(dev);
+	dev->reset_fn = pci_reset_supported(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5652214fe3a58..8c2d3a357eedb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,6 +49,9 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
+/* Number of reset methods used in pci_reset_fn_methods array in pci.c */
+#define PCI_NUM_RESET_METHODS 6
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -506,6 +509,10 @@ struct pci_dev {
 	char		*driver_override; /* Driver name to force a match */
 
 	unsigned long	priv_flags;	/* Private flags for the PCI driver */
+	/*
+	 * See pci_reset_fn_methods array in pci.c for ordering.
+	 */
+	u8 reset_methods[PCI_NUM_RESET_METHODS];	/* Reset methods ordered by priority */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.25.1

