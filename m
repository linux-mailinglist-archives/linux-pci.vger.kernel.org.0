Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10D13B873
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 04:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAOD5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 22:57:14 -0500
Received: from ale.deltatee.com ([207.54.116.67]:43342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgAOD5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 22:57:00 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZna-0001in-3M; Tue, 14 Jan 2020 20:56:57 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1irZnX-0000ge-DX; Tue, 14 Jan 2020 20:56:51 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 14 Jan 2020 20:56:46 -0700
Message-Id: <20200115035648.2578-6-logang@deltatee.com>
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
Subject: [PATCH v2 5/7] PCI/switchtec: Add gen4 support for the system info registers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the gen4 specific system info registers and ensure their usage is
guarded by a check on the device's generation.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c |  5 ++++
 include/linux/switchtec.h      | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 3bdec509f948..0062225db50f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -321,6 +321,9 @@ static ssize_t field ## _show(struct device *dev, \
 	if (stdev->gen == SWITCHTEC_GEN3) \
 		return io_string_show(buf, &si->gen3.field, \
 				      sizeof(si->gen3.field)); \
+	else if (stdev->gen == SWITCHTEC_GEN4) \
+		return io_string_show(buf, &si->gen4.field, \
+				      sizeof(si->gen4.field)); \
 	else \
 		return -ENOTSUPP; \
 } \
@@ -1435,6 +1438,8 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 
 	if (stdev->gen == SWITCHTEC_GEN3)
 		part_id = &stdev->mmio_sys_info->gen3.partition_id;
+	else if (stdev->gen == SWITCHTEC_GEN4)
+		part_id = &stdev->mmio_sys_info->gen4.partition_id;
 	else
 		return -ENOTSUPP;
 
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 73817d02db1e..ea217af5260e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -39,6 +39,7 @@ enum {
 
 enum switchtec_gen {
 	SWITCHTEC_GEN3,
+	SWITCHTEC_GEN4,
 };
 
 struct mrpc_regs {
@@ -130,12 +131,54 @@ struct sys_info_regs_gen3 {
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
 	union {
 		struct sys_info_regs_gen3 gen3;
+		struct sys_info_regs_gen4 gen4;
 	};
 } __packed;
 
-- 
2.20.1

