Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7913183B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgAFTER (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:04:17 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54826 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgAFTDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:48 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0005mK-0y; Mon, 06 Jan 2020 12:03:46 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0000eS-Rh; Mon, 06 Jan 2020 12:03:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:33 -0700
Message-Id: <20200106190337.2428-9-logang@deltatee.com>
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
Subject: [PATCH 08/12] PCI/switchtec: Add gen4 support in struct sys_info_regs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a union with gen3 and gen4 sys_info structs. Ensure any use of the
gen3 struct is gaurded by an if statement on stdev->gen.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 41 +++++++++++++++++++++++++++---
 include/linux/switchtec.h      | 46 +++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 21d3dd6e74f9..90d9c00984a7 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -317,8 +317,14 @@ static ssize_t field ## _show(struct device *dev, \
 	struct device_attribute *attr, char *buf) \
 { \
 	struct switchtec_dev *stdev = to_stdev(dev); \
-	return io_string_show(buf, &stdev->mmio_sys_info->gen3.field, \
-			    sizeof(stdev->mmio_sys_info->gen3.field)); \
+	struct sys_info_regs __iomem *si = stdev->mmio_sys_info; \
+	\
+	if (stdev->gen == SWITCHTEC_GEN4) \
+		return io_string_show(buf, &si->gen4.field, \
+				      sizeof(si->gen4.field)); \
+	else \
+		return io_string_show(buf, &si->gen3.field, \
+				      sizeof(si->gen3.field)); \
 } \
 \
 static DEVICE_ATTR_RO(field)
@@ -326,7 +332,21 @@ static DEVICE_ATTR_RO(field)
 DEVICE_ATTR_SYS_INFO_STR(vendor_id);
 DEVICE_ATTR_SYS_INFO_STR(product_id);
 DEVICE_ATTR_SYS_INFO_STR(product_revision);
-DEVICE_ATTR_SYS_INFO_STR(component_vendor);
+
+static ssize_t component_vendor_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct switchtec_dev *stdev = to_stdev(dev);
+	struct sys_info_regs __iomem *si = stdev->mmio_sys_info;
+
+	/* component_vendor field not supported after gen4 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "none\n");
+
+	return io_string_show(buf, &si->gen3.component_vendor,
+			      sizeof(si->gen3.component_vendor));
+}
+static DEVICE_ATTR_RO(component_vendor);
 
 static ssize_t component_id_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
@@ -334,6 +354,10 @@ static ssize_t component_id_show(struct device *dev,
 	struct switchtec_dev *stdev = to_stdev(dev);
 	int id = ioread16(&stdev->mmio_sys_info->gen3.component_id);
 
+	/* component_id field not supported after gen4 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "none\n");
+
 	return sprintf(buf, "PM%04X\n", id);
 }
 static DEVICE_ATTR_RO(component_id);
@@ -344,6 +368,10 @@ static ssize_t component_revision_show(struct device *dev,
 	struct switchtec_dev *stdev = to_stdev(dev);
 	int rev = ioread8(&stdev->mmio_sys_info->gen3.component_revision);
 
+	/* component_revision field not supported after gen4 */
+	if (stdev->gen != SWITCHTEC_GEN3)
+		return sprintf(buf, "255\n");
+
 	return sprintf(buf, "%d\n", rev);
 }
 static DEVICE_ATTR_RO(component_revision);
@@ -1344,6 +1372,7 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	int rc;
 	void __iomem *map;
 	unsigned long res_start, res_len;
+	u32 __iomem *part_id;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -1378,7 +1407,11 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 	stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
 	stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
-	stdev->partition = ioread8(&stdev->mmio_sys_info->gen3.partition_id);
+	if (stdev->gen == SWITCHTEC_GEN4)
+		part_id = &stdev->mmio_sys_info->gen4.partition_id;
+	else
+		part_id = &stdev->mmio_sys_info->gen3.partition_id;
+	stdev->partition = ioread32(part_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
 	stdev->mmio_part_cfg_all = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET;
 	stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[stdev->partition];
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index d6ba4b5dbbed..0677581eacad 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -126,11 +126,55 @@ struct sys_info_regs_gen3 {
 	u8 component_revision;
 } __packed;
 
+struct sys_info_regs_gen4 {
+	u16 gas_layout_ver;
+	u8 evlist_ver;
+	u8 reserved1;
+	u16 mgmt_cmd_set_ver;
+	u16 fabric_cmd_set_ver;
+	u32 reserved2[2];
+	u8 mrpc_uart_ver;
+	u8 mrpc_twi_ver;
+	u8 mrpc_eth_ver;
+	u8 mrpc_inband_ver;
+	u32 reserved3[7];
+	u32 fw_update_tmo;
+	u32 xml_version_cfg;
+	u32 xml_version_img;
+	u32 partition_id;
+	u16 bl2_running;
+	u16 cfg_running;
+	u16 img_running;
+	u16 key_running;
+	u32 reserved4[43];
+	u32 vendor_seeprom_twi;
+	u32 vendor_table_revision;
+	u32 vendor_specific_info[2];
+	u16 p2p_vendor_id;
+	u16 p2p_device_id;
+	u8 p2p_revision_id;
+	u8 reserved5[3];
+	u32 p2p_class_id;
+	u16 subsystem_vendor_id;
+	u16 subsystem_id;
+	u32 p2p_serial_number[2];
+	u8 mac_addr[6];
+	u8 reserved6[2];
+	u32 reserved7[3];
+	char vendor_id[8];
+	char product_id[24];
+	char  product_revision[2];
+	u16 reserved8;
+} __packed;
+
 struct sys_info_regs {
 	u32 device_id;
 	u32 device_version;
 	u32 firmware_version;
-	struct sys_info_regs_gen3 gen3;
+	union {
+		struct sys_info_regs_gen3 gen3;
+		struct sys_info_regs_gen4 gen4;
+	};
 } __packed;
 
 struct flash_info_regs {
-- 
2.20.1

