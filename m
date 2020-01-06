Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7613182C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAFTDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:48 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54840 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgAFTDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:48 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m9-Qp; Mon, 06 Jan 2020 12:03:47 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eM-LP; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:31 -0700
Message-Id: <20200106190337.2428-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH 06/12] PCI/switchtec: Introduce Generation Variable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a generation variable passed through the device id table.

This will allow us to add generation 4 and other devices after they are
functionally supported.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 66 ++++++++++++++++++----------------
 include/linux/switchtec.h      |  7 ++++
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 05d4cb49219b..674c57c9ae4c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1420,6 +1420,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(stdev))
 		return PTR_ERR(stdev);
 
+	stdev->gen = id->driver_data;
+
 	rc = switchtec_init_pci(stdev, pdev);
 	if (rc)
 		goto err_put;
@@ -1467,7 +1469,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	put_device(&stdev->dev);
 }
 
-#define SWITCHTEC_PCI_DEVICE(device_id) \
+#define SWITCHTEC_PCI_DEVICE(device_id, gen) \
 	{ \
 		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
 		.device     = device_id, \
@@ -1475,6 +1477,7 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 		.subdevice  = PCI_ANY_ID, \
 		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
 		.class_mask = 0xFFFFFFFF, \
+		.driver_data = gen, \
 	}, \
 	{ \
 		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
@@ -1483,39 +1486,40 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
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
index b4ba3a38f30f..0963912c679d 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -32,6 +32,11 @@ enum {
 	SWITCHTEC_GAS_PFF_CSR_OFFSET    = 0x134000,
 };
 
+enum switchtec_gen {
+	SWITCHTEC_GEN3,
+	SWITCHTEC_GEN4,
+};
+
 struct mrpc_regs {
 	u8 input_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
 	u8 output_data[SWITCHTEC_MRPC_PAYLOAD_SIZE];
@@ -358,6 +363,8 @@ struct switchtec_dev {
 	struct device dev;
 	struct cdev cdev;
 
+	enum switchtec_gen gen;
+
 	int partition;
 	int partition_count;
 	int pff_csr_count;
-- 
2.20.1

