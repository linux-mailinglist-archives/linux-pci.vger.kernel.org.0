Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE413B875
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAOD5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43346 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgAOD5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:00 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001ii-8S; Tue, 14 Jan 2020 20:56:58 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnW-0000gS-OQ; Tue, 14 Jan 2020 20:56:50 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:42 -0700
Message-Id: <20200115035648.2578-2-logang@deltatee.com>
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
Subject: [PATCH v2 1/7] PCI/switchtec: Rename generation specific constants
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Gen4 hardware will have different values for the SWITCHTEC_X_RUNNING
and SWITCHTEC_IOCTL_NUM_PARTITIONS, so rename them with GEN3 in their
name.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c       | 10 +++++-----
 include/linux/switchtec.h            |  8 ++++----
 include/uapi/linux/switchtec_ioctl.h |  5 ++++-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 11f83caf6576..c5c957ce8499 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -575,7 +575,7 @@ static int ioctl_flash_info(struct switchtec_dev *stdev,
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
 
 	info.flash_length = ioread32(&fi->flash_length);
-	info.num_partitions = SWITCHTEC_IOCTL_NUM_PARTITIONS;
+	info.num_partitions = SWITCHTEC_NUM_PARTITIONS_GEN3;
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
@@ -605,25 +605,25 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 	case SWITCHTEC_IOCTL_PART_CFG0:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg0);
-		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG0_RUNNING)
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG0_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_CFG1:
 		active_addr = ioread32(&fi->active_cfg);
 		set_fw_info_part(&info, &fi->cfg1);
-		if (ioread16(&si->cfg_running) == SWITCHTEC_CFG1_RUNNING)
+		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG1_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG0:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img0);
-		if (ioread16(&si->img_running) == SWITCHTEC_IMG0_RUNNING)
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG0_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG1:
 		active_addr = ioread32(&fi->active_img);
 		set_fw_info_part(&info, &fi->img1);
-		if (ioread16(&si->img_running) == SWITCHTEC_IMG1_RUNNING)
+		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG1_RUNNING)
 			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_NVLOG:
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 8ec992c88a34..07b0ddabd48b 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -103,10 +103,10 @@ struct sw_event_regs {
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
 };
 
 struct sys_info_regs {
diff --git a/include/uapi/linux/switchtec_ioctl.h b/include/uapi/linux/switchtec_ioctl.h
index e8db938985ca..4d09cfa2e9e6 100644
--- a/include/uapi/linux/switchtec_ioctl.h
+++ b/include/uapi/linux/switchtec_ioctl.h
@@ -32,7 +32,10 @@
 #define SWITCHTEC_IOCTL_PART_VENDOR5	10
 #define SWITCHTEC_IOCTL_PART_VENDOR6	11
 #define SWITCHTEC_IOCTL_PART_VENDOR7	12
-#define SWITCHTEC_IOCTL_NUM_PARTITIONS	13
+#define SWITCHTEC_NUM_PARTITIONS_GEN3	13
+
+/* obsolete: for compatibility with old userspace software */
+#define SWITCHTEC_IOCTL_NUM_PARTITIONS	SWITCHTEC_NUM_PARTITIONS_GEN3
 
 struct switchtec_ioctl_flash_info {
 	__u64 flash_length;
-- 
2.20.1

