Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A413B86D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAOD5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:03 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43370 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbgAOD5D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:03 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001ik-3Q; Tue, 14 Jan 2020 20:57:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnW-0000gU-Tt; Tue, 14 Jan 2020 20:56:50 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:43 -0700
Message-Id: <20200115035648.2578-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115035648.2578-1-logang@deltatee.com>
References: <20200115035648.2578-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 2/7] PCI/switchtec: Introduce Generation Variable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a generation variable passed through the device id table and tests
for GEN3 specific registers.

This will allow us to add generation 4 and other devices after they are
functionally supported.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 90 ++++++++++++++++++++++------------
 include/linux/switchtec.h      |  6 +++
 2 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index c5c957ce8499..0abc8bc8b03e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -326,7 +326,21 @@ static DEVICE_ATTR_RO(field)
 DEVICE_ATTR_SYS_INFO_STR(vendor_id);
 DEVICE_ATTR_SYS_INFO_STR(product_id);
 DEVICE_ATTR_SYS_INFO_STR(product_revision);
-DEVICE_ATTR_SYS_INFO_STR(component_vendor);
+
+static ssize_t component_vendor_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
+
+	/* component_vendor field not supported after gen3 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "none\n");
+
+	return io_string_show(buf, &si->component_vendor,
+			      sizeof(si->component_vendor));
+}
+static DEVICE_ATTR_RO(component_vendor);
 
 static ssize_t component_id_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
@@ -334,6 +348,10 @@ static ssize_t component_id_show(struct device *dev,
 	struct switchtec_dev *stdev = to_stdev(dev);
 	int id = ioread16(&stdev->mmio_sys_info->component_id);
 
+	/* component_id field not supported after gen3 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "none\n");
+
 	return sprintf(buf, "PM%04X\n", id);
 }
 static DEVICE_ATTR_RO(component_id);
@@ -344,6 +362,10 @@ static ssize_t component_revision_show(struct device *dev,
 	struct switchtec_dev *stdev = to_stdev(dev);
 	int rev = ioread8(&stdev->mmio_sys_info->component_revision);
 
+	/* component_revision field not supported after gen3 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "255\n");
+
 	return sprintf(buf, "%d\n", rev);
 }
 static DEVICE_ATTR_RO(component_revision);
@@ -1426,6 +1448,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(stdev))
 		return PTR_ERR(stdev);
 
+	stdev->gen = id->driver_data;
+
 	rc = switchtec_init_pci(stdev, pdev);
 	if (rc)
 		goto err_put;
@@ -1473,7 +1497,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	put_device(&stdev->dev);
 }
 
-#define SWITCHTEC_PCI_DEVICE(device_id) \
+#define SWITCHTEC_PCI_DEVICE(device_id, gen) \
 	{ \
 		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
 		.device     = device_id, \
@@ -1481,6 +1505,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.subdevice  = PCI_ANY_ID, \
 		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
 		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
 	}, \
 	{ \
 		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
@@ -1489,39 +1514,40 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.subdevice  = PCI_ANY_ID, \
 		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
 		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
 	}
 
 static const struct pci_device_id switchtec_pci_tbl[] = {
-	SWITCHTEC_PCI_DEVICE(0x8531),  //PFX 24xG3
-	SWITCHTEC_PCI_DEVICE(0x8532),  //PFX 32xG3
-	SWITCHTEC_PCI_DEVICE(0x8533),  //PFX 48xG3
-	SWITCHTEC_PCI_DEVICE(0x8534),  //PFX 64xG3
-	SWITCHTEC_PCI_DEVICE(0x8535),  //PFX 80xG3
-	SWITCHTEC_PCI_DEVICE(0x8536),  //PFX 96xG3
-	SWITCHTEC_PCI_DEVICE(0x8541),  //PSX 24xG3
-	SWITCHTEC_PCI_DEVICE(0x8542),  //PSX 32xG3
-	SWITCHTEC_PCI_DEVICE(0x8543),  //PSX 48xG3
-	SWITCHTEC_PCI_DEVICE(0x8544),  //PSX 64xG3
-	SWITCHTEC_PCI_DEVICE(0x8545),  //PSX 80xG3
-	SWITCHTEC_PCI_DEVICE(0x8546),  //PSX 96xG3
-	SWITCHTEC_PCI_DEVICE(0x8551),  //PAX 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8552),  //PAX 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8553),  //PAX 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8554),  //PAX 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8555),  //PAX 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8556),  //PAX 96XG3
-	SWITCHTEC_PCI_DEVICE(0x8561),  //PFXL 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8562),  //PFXL 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8563),  //PFXL 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8564),  //PFXL 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8565),  //PFXL 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8566),  //PFXL 96XG3
-	SWITCHTEC_PCI_DEVICE(0x8571),  //PFXI 24XG3
-	SWITCHTEC_PCI_DEVICE(0x8572),  //PFXI 32XG3
-	SWITCHTEC_PCI_DEVICE(0x8573),  //PFXI 48XG3
-	SWITCHTEC_PCI_DEVICE(0x8574),  //PFXI 64XG3
-	SWITCHTEC_PCI_DEVICE(0x8575),  //PFXI 80XG3
-	SWITCHTEC_PCI_DEVICE(0x8576),  //PFXI 96XG3
+	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  //PFX 24xG3
+	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  //PFX 32xG3
+	SWITCHTEC_PCI_DEVICE(0x8533, SWITCHTEC_GEN3),  //PFX 48xG3
+	SWITCHTEC_PCI_DEVICE(0x8534, SWITCHTEC_GEN3),  //PFX 64xG3
+	SWITCHTEC_PCI_DEVICE(0x8535, SWITCHTEC_GEN3),  //PFX 80xG3
+	SWITCHTEC_PCI_DEVICE(0x8536, SWITCHTEC_GEN3),  //PFX 96xG3
+	SWITCHTEC_PCI_DEVICE(0x8541, SWITCHTEC_GEN3),  //PSX 24xG3
+	SWITCHTEC_PCI_DEVICE(0x8542, SWITCHTEC_GEN3),  //PSX 32xG3
+	SWITCHTEC_PCI_DEVICE(0x8543, SWITCHTEC_GEN3),  //PSX 48xG3
+	SWITCHTEC_PCI_DEVICE(0x8544, SWITCHTEC_GEN3),  //PSX 64xG3
+	SWITCHTEC_PCI_DEVICE(0x8545, SWITCHTEC_GEN3),  //PSX 80xG3
+	SWITCHTEC_PCI_DEVICE(0x8546, SWITCHTEC_GEN3),  //PSX 96xG3
+	SWITCHTEC_PCI_DEVICE(0x8551, SWITCHTEC_GEN3),  //PAX 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8552, SWITCHTEC_GEN3),  //PAX 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8553, SWITCHTEC_GEN3),  //PAX 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8554, SWITCHTEC_GEN3),  //PAX 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8555, SWITCHTEC_GEN3),  //PAX 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8556, SWITCHTEC_GEN3),  //PAX 96XG3
+	SWITCHTEC_PCI_DEVICE(0x8561, SWITCHTEC_GEN3),  //PFXL 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8562, SWITCHTEC_GEN3),  //PFXL 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8563, SWITCHTEC_GEN3),  //PFXL 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8564, SWITCHTEC_GEN3),  //PFXL 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8565, SWITCHTEC_GEN3),  //PFXL 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8566, SWITCHTEC_GEN3),  //PFXL 96XG3
+	SWITCHTEC_PCI_DEVICE(0x8571, SWITCHTEC_GEN3),  //PFXI 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8572, SWITCHTEC_GEN3),  //PFXI 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8573, SWITCHTEC_GEN3),  //PFXI 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8574, SWITCHTEC_GEN3),  //PFXI 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8575, SWITCHTEC_GEN3),  //PFXI 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8576, SWITCHTEC_GEN3),  //PFXI 96XG3
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 07b0ddabd48b..5d985947bf82 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -37,6 +37,10 @@ enum {
 	SWITCHTEC_GAS_PFF_CSR_OFFSET    = 0x134000,
 };
 
+enum switchtec_gen {
+	SWITCHTEC_GEN3,
+};
+
 struct mrpc_regs {
 	u8 input_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
 	u8 output_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
@@ -363,6 +367,8 @@ struct switchtec_dev {
 	struct device dev;
 	struct cdev cdev;
 
+	enum switchtec_gen gen;
+
 	int partition;
 	int partition_count;
 	int pff_csr_count;
-- 
2.20.1

