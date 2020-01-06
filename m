Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D56513182D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAFTDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:48 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54832 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgAFTDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:47 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005mI-Th; Mon, 06 Jan 2020 12:03:46 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eP-Oe; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:32 -0700
Message-Id: <20200106190337.2428-8-logang@deltatee.com>
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
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH 07/12] PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs structure
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since gen4 system info region in GAS is diverged from gen3, separate
oute the gen3 specific stuff in preparation for adding a gen4 variant.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 18 +++++++++---------
 include/linux/switchtec.h      | 12 ++++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 674c57c9ae4c..21d3dd6e74f9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -317,8 +317,8 @@ static ssize_t field ## _show(struct device *dev, \
 	struct device_attribute *attr, char *buf) \
 { \
 	struct switchtec_dev *stdev = to_stdev(dev); \
-	return io_string_show(buf, &stdev->mmio_sys_info->field, \
-			    sizeof(stdev->mmio_sys_info->field)); \
+	return io_string_show(buf, &stdev->mmio_sys_info->gen3.field, \
+			    sizeof(stdev->mmio_sys_info->gen3.field)); \
 } \
 \
 static DEVICE_ATTR_RO(field)
@@ -332,7 +332,7 @@ static ssize_t component_id_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
-	int id = ioread16(&stdev->mmio_sys_info->component_id);
+	int id = ioread16(&stdev->mmio_sys_info->gen3.component_id);
 
 	return sprintf(buf, "PM%04X\n", id);
 }
@@ -342,7 +342,7 @@ static ssize_t component_revision_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
-	int rev = ioread8(&stdev->mmio_sys_info->component_revision);
+	int rev = ioread8(&stdev->mmio_sys_info->gen3.component_revision);
 
 	return sprintf(buf, "%d\n", rev);
 }
@@ -599,25 +599,25 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 	case SWITCHTEC_IOCTL_PART_CFG0:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg0);
-		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG0_RUNNING)
+		if (ioread16(&si->gen3.cfg_running) == SWITCHTEC_CFG0_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_CFG1:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg1);
-		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG1_RUNNING)
+		if (ioread16(&si->gen3.cfg_running) == SWITCHTEC_CFG1_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG0:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img0);
-		if (ioread16(&si->img_running) == SWITCHTEC_IMG0_RUNNING)
+		if (ioread16(&si->gen3.img_running) == SWITCHTEC_IMG0_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG1:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img1);
-		if (ioread16(&si->img_running) == SWITCHTEC_IMG1_RUNNING)
+		if (ioread16(&si->gen3.img_running) == SWITCHTEC_IMG1_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_NVLOG:
@@ -1378,7 +1378,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 	stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
 	stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
-	stdev->partition = ioread8(&stdev->mmio_sys_info->partition_id);
+	stdev->partition = ioread8(&stdev->mmio_sys_info->gen3.partition_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
 	stdev->mmio_part_cfg_all = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET;
 	stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[stdev->partition];
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 0963912c679d..d6ba4b5dbbed 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -109,10 +109,7 @@ enum {
 	SWITCHTEC_IMG1_RUNNING = 0x07,
 };
 
-struct sys_info_regs {
-	u32 device_id;
-	u32 device_version;
-	u32 firmware_version;
+struct sys_info_regs_gen3 {
 	u32 reserved1;
 	u32 vendor_table_revision;
 	u32 table_format_version;
@@ -129,6 +126,13 @@ struct sys_info_regs {
 	u8 component_revision;
 } __packed;
 
+struct sys_info_regs {
+	u32 device_id;
+	u32 device_version;
+	u32 firmware_version;
+	struct sys_info_regs_gen3 gen3;
+} __packed;
+
 struct flash_info_regs {
 	u32 flash_part_map_upd_idx;
 
-- 
2.20.1

