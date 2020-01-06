Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64B513183A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgAFTEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:04:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54828 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgAFTDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:48 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0005mM-3y; Mon, 06 Jan 2020 12:03:46 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eV-VJ; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:34 -0700
Message-Id: <20200106190337.2428-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106190337.2428-1-logang@deltatee.com>
References: <20200106190337.2428-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, Kelvin.Cao@microchip.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH 09/12] PCI/switchtec: Add gen4 support in struct flash_info_regs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Add a union with gen3 and gen4 flash_info structs.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c       | 200 ++++++++++++++++++++++-----
 include/linux/switchtec.h            |  85 ++++++++++--
 include/uapi/linux/switchtec_ioctl.h |   9 ++
 3 files changed, 247 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 90d9c00984a7..524cb4e4bbf7 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -596,8 +596,15 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	struct switchtec_ioctl_flash_info info = {0};
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
 
-	info.flash_length = ioread32(&fi->flash_length);
-	info.num_partitions = SWITCHTEC_IOCTL_NUM_PARTITIONS;
+	if (stdev->gen == SWITCHTEC_GEN3) {
+		info.flash_length = ioread32(&fi->gen3.flash_length);
+		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
+	} else if (stdev->gen == SWITCHTEC_GEN4) {
+		info.flash_length = ioread32(&fi->gen4.flash_length);
+		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
+	} else {
+		return -ENOTSUPP;
+	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
@@ -612,75 +619,200 @@ static void set_fw_info_part(struct switchtec_ioctl_flash_part_info *info,
 	info->length = ioread32(&pi->length);
 }
 
-static int ioctl_flash_part_info(struct switchtec_dev *stdev,
-	struct switchtec_ioctl_flash_part_info __user *uinfo)
+static int flash_part_info_gen3(struct switchtec_dev *stdev,
+	struct switchtec_ioctl_flash_part_info *info)
 {
-	struct switchtec_ioctl_flash_part_info info = {0};
-	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
-	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
+	struct flash_info_regs_gen3 __iomem *fi = &stdev->mmio_flash_info->gen3;
+	struct sys_info_regs_gen3 __iomem *si = &stdev->mmio_sys_info->gen3;
 	u32 active_addr = -1;
 
-	if (copy_from_user(&info, uinfo, sizeof(info)))
-		return -EFAULT;
-
-	switch (info.flash_partition) {
+	switch (info->flash_partition) {
 	case SWITCHTEC_IOCTL_PART_CFG0:
 		active_addr = ioread32(&fi->active_cfg);
-		set_fw_info_part(&info, &fi->cfg0);
-		if (ioread16(&si->gen3.cfg_running) == SWITCHTEC_CFG0_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		set_fw_info_part(info, &fi->cfg0);
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_CFG1:
 		active_addr = ioread32(&fi->active_cfg);
-		set_fw_info_part(&info, &fi->cfg1);
-		if (ioread16(&si->gen3.cfg_running) == SWITCHTEC_CFG1_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		set_fw_info_part(info, &fi->cfg1);
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG0:
 		active_addr = ioread32(&fi->active_img);
-		set_fw_info_part(&info, &fi->img0);
-		if (ioread16(&si->gen3.img_running) == SWITCHTEC_IMG0_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		set_fw_info_part(info, &fi->img0);
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG1:
 		active_addr = ioread32(&fi->active_img);
-		set_fw_info_part(&info, &fi->img1);
-		if (ioread16(&si->gen3.img_running) == SWITCHTEC_IMG1_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		set_fw_info_part(info, &fi->img1);
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_NVLOG:
-		set_fw_info_part(&info, &fi->nvlog);
+		set_fw_info_part(info, &fi->nvlog);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR0:
-		set_fw_info_part(&info, &fi->vendor[0]);
+		set_fw_info_part(info, &fi->vendor[0]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR1:
-		set_fw_info_part(&info, &fi->vendor[1]);
+		set_fw_info_part(info, &fi->vendor[1]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR2:
-		set_fw_info_part(&info, &fi->vendor[2]);
+		set_fw_info_part(info, &fi->vendor[2]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR3:
-		set_fw_info_part(&info, &fi->vendor[3]);
+		set_fw_info_part(info, &fi->vendor[3]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR4:
-		set_fw_info_part(&info, &fi->vendor[4]);
+		set_fw_info_part(info, &fi->vendor[4]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR5:
-		set_fw_info_part(&info, &fi->vendor[5]);
+		set_fw_info_part(info, &fi->vendor[5]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR6:
-		set_fw_info_part(&info, &fi->vendor[6]);
+		set_fw_info_part(info, &fi->vendor[6]);
 		break;
 	case SWITCHTEC_IOCTL_PART_VENDOR7:
-		set_fw_info_part(&info, &fi->vendor[7]);
+		set_fw_info_part(info, &fi->vendor[7]);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (info.address == active_addr)
-		info.active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+	if (info->address == active_addr)
+		info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+
+	return 0;
+}
+
+static int flash_part_info_gen4(struct switchtec_dev *stdev,
+	struct switchtec_ioctl_flash_part_info *info)
+{
+	struct flash_info_regs_gen4 __iomem *fi = &stdev->mmio_flash_info->gen4;
+	struct sys_info_regs_gen4 __iomem *si = &stdev->mmio_sys_info->gen4;
+	struct active_partition_info_gen4 __iomem *af = &fi->active_flag;
+
+	switch (info->flash_partition) {
+	case SWITCHTEC_IOCTL_PART_MAP_0:
+		set_fw_info_part(info, &fi->map0);
+		break;
+	case SWITCHTEC_IOCTL_PART_MAP_1:
+		set_fw_info_part(info, &fi->map1);
+		break;
+	case SWITCHTEC_IOCTL_PART_KEY_0:
+		set_fw_info_part(info, &fi->key0);
+		if (ioread8(&af->key) == SWITCHTEC_GEN4_KEY0_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->key_running) == SWITCHTEC_GEN4_KEY0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_KEY_1:
+		set_fw_info_part(info, &fi->key1);
+		if (ioread8(&af->key) == SWITCHTEC_GEN4_KEY1_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->key_running) == SWITCHTEC_GEN4_KEY1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_BL2_0:
+		set_fw_info_part(info, &fi->bl2_0);
+		if (ioread8(&af->bl2) == SWITCHTEC_GEN4_BL2_0_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->bl2_running) == SWITCHTEC_GEN4_BL2_0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_BL2_1:
+		set_fw_info_part(info, &fi->bl2_1);
+		if (ioread8(&af->bl2) == SWITCHTEC_GEN4_BL2_1_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->bl2_running) == SWITCHTEC_GEN4_BL2_1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_CFG0:
+		set_fw_info_part(info, &fi->cfg0);
+		if (ioread8(&af->cfg) == SWITCHTEC_GEN4_CFG0_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN4_CFG0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_CFG1:
+		set_fw_info_part(info, &fi->cfg1);
+		if (ioread8(&af->cfg) == SWITCHTEC_GEN4_CFG1_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN4_CFG1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_IMG0:
+		set_fw_info_part(info, &fi->img0);
+		if (ioread8(&af->img) == SWITCHTEC_GEN4_IMG0_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN4_IMG0_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_IMG1:
+		set_fw_info_part(info, &fi->img1);
+		if (ioread8(&af->img) == SWITCHTEC_GEN4_IMG1_ACTIVE)
+			info->active |= SWITCHTEC_IOCTL_PART_ACTIVE;
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN4_IMG1_RUNNING)
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
+		break;
+	case SWITCHTEC_IOCTL_PART_NVLOG:
+		set_fw_info_part(info, &fi->nvlog);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR0:
+		set_fw_info_part(info, &fi->vendor[0]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR1:
+		set_fw_info_part(info, &fi->vendor[1]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR2:
+		set_fw_info_part(info, &fi->vendor[2]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR3:
+		set_fw_info_part(info, &fi->vendor[3]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR4:
+		set_fw_info_part(info, &fi->vendor[4]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR5:
+		set_fw_info_part(info, &fi->vendor[5]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR6:
+		set_fw_info_part(info, &fi->vendor[6]);
+		break;
+	case SWITCHTEC_IOCTL_PART_VENDOR7:
+		set_fw_info_part(info, &fi->vendor[7]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ioctl_flash_part_info(struct switchtec_dev *stdev,
+	struct switchtec_ioctl_flash_part_info __user *uinfo)
+{
+	int ret;
+	struct switchtec_ioctl_flash_part_info info = {0};
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (stdev->gen == SWITCHTEC_GEN3) {
+		ret = flash_part_info_gen3(stdev, &info);
+		if (ret)
+			return ret;
+	} else if (stdev->gen == SWITCHTEC_GEN4) {
+		ret = flash_part_info_gen4(stdev, &info);
+		if (ret)
+			return ret;
+	} else {
+		return -ENOTSUPP;
+	}
+
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 0677581eacad..e85155244135 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -103,10 +103,34 @@ struct sw_event_regs {
 } __packed;
 
 enum {
-	SWITCHTEC_CFG0_RUNNING = 0x04,
-	SWITCHTEC_CFG1_RUNNING = 0x05,
-	SWITCHTEC_IMG0_RUNNING = 0x03,
-	SWITCHTEC_IMG1_RUNNING = 0x07,
+	SWITCHTEC_GEN3_CFG0_RUNNING = 0x04,
+	SWITCHTEC_GEN3_CFG1_RUNNING = 0x05,
+	SWITCHTEC_GEN3_IMG0_RUNNING = 0x03,
+	SWITCHTEC_GEN3_IMG1_RUNNING = 0x07,
+};
+
+enum {
+	SWITCHTEC_GEN4_MAP0_RUNNING = 0x00,
+	SWITCHTEC_GEN4_MAP1_RUNNING = 0x01,
+	SWITCHTEC_GEN4_KEY0_RUNNING = 0x02,
+	SWITCHTEC_GEN4_KEY1_RUNNING = 0x03,
+	SWITCHTEC_GEN4_BL2_0_RUNNING = 0x04,
+	SWITCHTEC_GEN4_BL2_1_RUNNING = 0x05,
+	SWITCHTEC_GEN4_CFG0_RUNNING = 0x06,
+	SWITCHTEC_GEN4_CFG1_RUNNING = 0x07,
+	SWITCHTEC_GEN4_IMG0_RUNNING = 0x08,
+	SWITCHTEC_GEN4_IMG1_RUNNING = 0x09,
+};
+
+enum {
+	SWITCHTEC_GEN4_KEY0_ACTIVE = 0,
+	SWITCHTEC_GEN4_KEY1_ACTIVE = 1,
+	SWITCHTEC_GEN4_BL2_0_ACTIVE = 0,
+	SWITCHTEC_GEN4_BL2_1_ACTIVE = 1,
+	SWITCHTEC_GEN4_CFG0_ACTIVE = 0,
+	SWITCHTEC_GEN4_CFG1_ACTIVE = 1,
+	SWITCHTEC_GEN4_IMG0_ACTIVE = 0,
+	SWITCHTEC_GEN4_IMG1_ACTIVE = 1,
 };
 
 struct sys_info_regs_gen3 {
@@ -177,26 +201,54 @@ struct sys_info_regs {
 	};
 } __packed;
 
-struct flash_info_regs {
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
+	struct partition_info cfg0;
+	struct partition_info cfg1;
+	struct partition_info img0;
+	struct partition_info img1;
+	struct partition_info nvlog;
+	struct partition_info vendor[8];
+};
+
+struct flash_info_regs_gen4 {
+	u32 flash_address;
+	u32 flash_length;
 
+	struct active_partition_info_gen4 {
+		unsigned char bl2;
+		unsigned char cfg;
+		unsigned char img;
+		unsigned char key;
+	} active_flag;
+
+	u32 reserved[3];
+
+	struct partition_info map0;
+	struct partition_info map1;
+	struct partition_info key0;
+	struct partition_info key1;
+	struct partition_info bl2_0;
+	struct partition_info bl2_1;
+	struct partition_info cfg0;
 	struct partition_info cfg1;
 	struct partition_info img0;
 	struct partition_info img1;
@@ -204,6 +256,13 @@ struct flash_info_regs {
 	struct partition_info vendor[8];
 };
 
+struct flash_info_regs {
+	union {
+		struct flash_info_regs_gen3 gen3;
+		struct flash_info_regs_gen4 gen4;
+	};
+};
+
 enum {
 	SWITCHTEC_NTB_REG_INFO_OFFSET   = 0x0000,
 	SWITCHTEC_NTB_REG_CTRL_OFFSET   = 0x4000,
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index e8db938985ca..0d28f4a3dd0a 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -32,7 +32,16 @@
 #define SWITCHTEC_IOCTL_PART_VENDOR5	10
 #define SWITCHTEC_IOCTL_PART_VENDOR6	11
 #define SWITCHTEC_IOCTL_PART_VENDOR7	12
+#define SWITCHTEC_IOCTL_PART_BL2_0	13
+#define SWITCHTEC_IOCTL_PART_BL2_1	14
+#define SWITCHTEC_IOCTL_PART_MAP_0	15
+#define SWITCHTEC_IOCTL_PART_MAP_1	16
+#define SWITCHTEC_IOCTL_PART_KEY_0	17
+#define SWITCHTEC_IOCTL_PART_KEY_1	18
+
 #define SWITCHTEC_IOCTL_NUM_PARTITIONS	13
+#define SWITCHTEC_NUM_PARTITIONS_GEN3	13
+#define SWITCHTEC_NUM_PARTITIONS_GEN4	19
 
 struct switchtec_ioctl_flash_info {
 	__u64 flash_length;
-- 
2.20.1

