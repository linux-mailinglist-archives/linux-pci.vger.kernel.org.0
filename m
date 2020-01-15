Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7013B86B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAOD5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:00 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43340 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbgAOD5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:00 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001io-8m; Tue, 14 Jan 2020 20:56:57 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnX-0000gh-Go; Tue, 14 Jan 2020 20:56:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:47 -0700
Message-Id: <20200115035648.2578-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115035648.2578-1-logang@deltatee.com>
References: <20200115035648.2578-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, Kelvin.Cao@microchip.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 6/7] PCI/switchtec: Add gen4 support for the flash information interface
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

Add the new flash_info registers struct and the implementation
of ioctl_flash_part_info() for the new gen4 hardware.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
[logang@deltatee.com: rewrote commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c       | 111 +++++++++++++++++++++++++++
 include/linux/switchtec.h            |  52 +++++++++++++
 include/uapi/linux/switchtec_ioctl.h |   8 ++
 3 files changed, 171 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0062225db50f..92b95e8067c0 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -606,6 +606,9 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	if (stdev->gen == SWITCHTEC_GEN3) {
 		info.flash_length = ioread32(&fi->gen3.flash_length);
 		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
+	} else if (stdev->gen == SWITCHTEC_GEN4) {
+		info.flash_length = ioread32(&fi->gen4.flash_length);
+		info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN4;
 	} else {
 		return -ENOTSUPP;
 	}
@@ -693,6 +696,110 @@ static int flash_part_info_gen3(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static int flash_part_info_gen4(struct switchtec_dev *stdev,
+		struct switchtec_ioctl_flash_part_info *info)
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
 static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		struct switchtec_ioctl_flash_part_info __user *uinfo)
 {
@@ -706,6 +813,10 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		ret = flash_part_info_gen3(stdev, &info);
 		if (ret)
 			return ret;
+	} else if (stdev->gen == SWITCHTEC_GEN4) {
+		ret = flash_part_info_gen4(stdev, &info);
+		if (ret)
+			return ret;
 	} else {
 		return -ENOTSUPP;
 	}
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index ea217af5260e..082f1d51957a 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -114,6 +114,30 @@ enum {
 	SWITCHTEC_GEN3_IMG1_RUNNING = 0x07,
 };
 
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
+};
+
 struct sys_info_regs_gen3 {
 	u32 reserved1;
 	u32 vendor_table_revision;
@@ -210,9 +234,37 @@ struct flash_info_regs_gen3 {
 	struct partition_info vendor[8];
 };
 
+struct flash_info_regs_gen4 {
+	u32 flash_address;
+	u32 flash_length;
+
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
+	struct partition_info cfg1;
+	struct partition_info img0;
+	struct partition_info img1;
+	struct partition_info nvlog;
+	struct partition_info vendor[8];
+};
+
 struct flash_info_regs {
 	union {
 		struct flash_info_regs_gen3 gen3;
+		struct flash_info_regs_gen4 gen4;
 	};
 };
 
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index 4d09cfa2e9e6..2c661a3557e5 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -32,7 +32,15 @@
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
 #define SWITCHTEC_NUM_PARTITIONS_GEN3	13
+#define SWITCHTEC_NUM_PARTITIONS_GEN4	19
 
 /* obsolete: for compatibility with old userspace software */
 #define SWITCHTEC_IOCTL_NUM_PARTITIONS	SWITCHTEC_NUM_PARTITIONS_GEN3
-- 
2.20.1

