Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C044813B869
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOD46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:56:58 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43336 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgAOD46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:56:58 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001im-31; Tue, 14 Jan 2020 20:56:55 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnX-0000gb-AK; Tue, 14 Jan 2020 20:56:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:45 -0700
Message-Id: <20200115035648.2578-5-logang@deltatee.com>
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
Subject: [PATCH v2 4/7] PCI/switchtec: Separate out gen3 register structures into unionse
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the sys_info and flash_info registers differ significantly in
gen4 hardware, separate out the gen3 registers into their own structure
with a union in the main structure.

No functions changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 38 ++++++++++++++++++++++---------
 include/linux/switchtec.h      | 41 ++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index fe0b7d96c36a..3bdec509f948 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -317,8 +317,12 @@ static ssize_t field ## _show(struct device *dev, \
 	struct device_attribute *attr, char *buf) \
 { \
 	struct switchtec_dev *stdev = to_stdev(dev); \
-	return io_string_show(buf, &stdev->mmio_sys_info->field, \
-			    sizeof(stdev->mmio_sys_info->field)); \
+	struct sys_info_regs __iomem *si = stdev->mmio_sys_info; \
+	if (stdev->gen == SWITCHTEC_GEN3) \
+		return io_string_show(buf, &si->gen3.field, \
+				      sizeof(si->gen3.field)); \
+	else \
+		return -ENOTSUPP; \
 } \
 \
 static DEVICE_ATTR_RO(field)
@@ -337,8 +341,8 @@ static ssize_t component_vendor_show(struct device *dev,
 	if (stdev->gen != SWITCHTEC_GEN3)
 		return sprintf(buf, "none\n");
 
-	return io_string_show(buf, &si->component_vendor,
-			      sizeof(si->component_vendor));
+	return io_string_show(buf, &si->gen3.component_vendor,
+			      sizeof(si->gen3.component_vendor));
 }
 static DEVICE_ATTR_RO(component_vendor);
 
@@ -346,7 +350,7 @@ static ssize_t component_id_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
-	int id = ioread16(&stdev->mmio_sys_info->component_id);
+	int id = ioread16(&stdev->mmio_sys_info->gen3.component_id);
 
 	/* component_id field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
@@ -360,7 +364,7 @@ static ssize_t component_revision_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
-	int rev = ioread8(&stdev->mmio_sys_info->component_revision);
+	int rev = ioread8(&stdev->mmio_sys_info->gen3.component_revision);
 
 	/* component_revision field not supported after gen3 */
 	if (stdev->gen != SWITCHTEC_GEN3)
@@ -596,8 +600,12 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	struct switchtec_ioctl_flash_info info = {0};
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
 
-	info.flash_length = ioread32(&fi->flash_length);
-	info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
+	if (stdev->gen == SWITCHTEC_GEN3) {
+		info.flash_length = ioread32(&fi->gen3.flash_length);
+		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
+	} else {
+		return -ENOTSUPP;
+	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
@@ -615,8 +623,9 @@ static void set_fw_info_part(struct switchtec_ioctl_flash_part_info *info,
 static int flash_part_info_gen3(struct switchtec_dev *stdev,
 		struct switchtec_ioctl_flash_part_info *info)
 {
-	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
-	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
+	struct flash_info_regs_gen3 __iomem *fi =
+		&stdev->mmio_flash_info->gen3;
+	struct sys_info_regs_gen3 __iomem *si = &stdev->mmio_sys_info->gen3;
 	u32 active_addr = -1;
 
 	switch (info->flash_partition) {
@@ -1388,6 +1397,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	int rc;
 	void __iomem *map;
 	unsigned long res_start, res_len;
+	u32 __iomem *part_id;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -1422,7 +1432,13 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 	stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
 	stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
-	stdev->partition = ioread8(&stdev->mmio_sys_info->partition_id);
+
+	if (stdev->gen == SWITCHTEC_GEN3)
+		part_id = &stdev->mmio_sys_info->gen3.partition_id;
+	else
+		return -ENOTSUPP;
+
+	stdev->partition = ioread8(part_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
 	stdev->mmio_part_cfg_all = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET;
 	stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[stdev->partition];
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 5d985947bf82..73817d02db1e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -113,10 +113,7 @@ enum {
 	SWITCHTEC_GEN3_IMG1_RUNNING = 0x07,
 };
 
-struct sys_info_regs {
-	u32 device_id;
-	u32 device_version;
-	u32 firmware_version;
+struct sys_info_regs_gen3 {
 	u32 reserved1;
 	u32 vendor_table_revision;
 	u32 table_format_version;
@@ -133,26 +130,36 @@ struct sys_info_regs {
 	u8 component_revision;
 } __packed;
 
-struct flash_info_regs {
+struct sys_info_regs {
+	u32 device_id;
+	u32 device_version;
+	u32 firmware_version;
+	union {
+		struct sys_info_regs_gen3 gen3;
+	};
+} __packed;
+
+struct partition_info {
+	u32 address;
+	u32 length;
+};
+
+struct flash_info_regs_gen3 {
 	u32 flash_part_map_upd_idx;
 
-	struct active_partition_info {
+	struct active_partition_info_gen3 {
 		u32 address;
 		u32 build_version;
 		u32 build_string;
 	} active_img;
 
-	struct active_partition_info active_cfg;
-	struct active_partition_info inactive_img;
-	struct active_partition_info inactive_cfg;
+	struct active_partition_info_gen3 active_cfg;
+	struct active_partition_info_gen3 inactive_img;
+	struct active_partition_info_gen3 inactive_cfg;
 
 	u32 flash_length;
 
-	struct partition_info {
-		u32 address;
-		u32 length;
-	} cfg0;
-
+	struct partition_info cfg0;
 	struct partition_info cfg1;
 	struct partition_info img0;
 	struct partition_info img1;
@@ -160,6 +167,12 @@ struct flash_info_regs {
 	struct partition_info vendor[8];
 };
 
+struct flash_info_regs {
+	union {
+		struct flash_info_regs_gen3 gen3;
+	};
+};
+
 enum {
 	SWITCHTEC_NTB_REG_INFO_OFFSET   = 0x0000,
 	SWITCHTEC_NTB_REG_CTRL_OFFSET   = 0x4000,
-- 
2.20.1

