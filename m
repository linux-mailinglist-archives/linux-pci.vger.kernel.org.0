Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE31A13B876
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAOD5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43392 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgAOD5T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:19 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001il-34; Tue, 14 Jan 2020 20:57:16 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnX-0000gY-2G; Tue, 14 Jan 2020 20:56:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Kelvin Cao <kelvin.cao@microchip.com>
Date:   Tue, 14 Jan 2020 20:56:44 -0700
Message-Id: <20200115035648.2578-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200115035648.2578-1-logang@deltatee.com>
References: <20200115035648.2578-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com, Kelvin.Cao@microchip.com, kelvin.cao@microchip.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v2 3/7] PCI/switchtec: Refactor ioctl_flash_part_info()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refactor ioctl_flash_part_info() into a gen3 specific function seeing the
registers for flash partition information have changed significantly
in Gen4 and will require a completely different implementation.

No functional changes intended.

Co-developed-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 68 +++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0abc8bc8b03e..fe0b7d96c36a 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -612,75 +612,91 @@ static void set_fw_info_part(struct switchtec_ioctl_flash_part_info *info,
 	info->length = ioread32(&pi->length);
 }
 
-static int ioctl_flash_part_info(struct switchtec_dev *stdev,
-	struct switchtec_ioctl_flash_part_info __user *uinfo)
+static int flash_part_info_gen3(struct switchtec_dev *stdev,
+		struct switchtec_ioctl_flash_part_info *info)
 {
-	struct switchtec_ioctl_flash_part_info info = {0};
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
 	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
 	u32 active_addr = -1;
 
-	if (copy_from_user(&info, uinfo, sizeof(info)))
-		return -EFAULT;
-
-	switch (info.flash_partition) {
+	switch (info->flash_partition) {
 	case SWITCHTEC_IOCTL_PART_CFG0:
 		active_addr = ioread32(&fi->active_cfg);
-		set_fw_info_part(&info, &fi->cfg0);
+		set_fw_info_part(info, &fi->cfg0);
 		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG0_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_CFG1:
 		active_addr = ioread32(&fi->active_cfg);
-		set_fw_info_part(&info, &fi->cfg1);
+		set_fw_info_part(info, &fi->cfg1);
 		if (ioread16(&si->cfg_running) == SWITCHTEC_GEN3_CFG1_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG0:
 		active_addr = ioread32(&fi->active_img);
-		set_fw_info_part(&info, &fi->img0);
+		set_fw_info_part(info, &fi->img0);
 		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG0_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
+			info->active |= SWITCHTEC_IOCTL_PART_RUNNING;
 		break;
 	case SWITCHTEC_IOCTL_PART_IMG1:
 		active_addr = ioread32(&fi->active_img);
-		set_fw_info_part(&info, &fi->img1);
+		set_fw_info_part(info, &fi->img1);
 		if (ioread16(&si->img_running) == SWITCHTEC_GEN3_IMG1_RUNNING)
-			info.active |= SWITCHTEC_IOCTL_PART_RUNNING;
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
+static int ioctl_flash_part_info(struct switchtec_dev *stdev,
+		struct switchtec_ioctl_flash_part_info __user *uinfo)
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
+	} else {
+		return -ENOTSUPP;
+	}
 
 	if (copy_to_user(uinfo, &info, sizeof(info)))
 		return -EFAULT;
-- 
2.20.1

