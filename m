Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C511E131838
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAFTEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:04:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54876 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgAFTDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:50 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0005mP-6u; Mon, 06 Jan 2020 12:03:49 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXfA-0000eY-1v; Mon, 06 Jan 2020 12:03:40 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:35 -0700
Message-Id: <20200106190337.2428-11-logang@deltatee.com>
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
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 10/12] PCI/switchtec: Add permission check for the GAS access MRPC commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kelvin Cao <kelvin.cao@microchip.com>

GEN4 hardware provides new MRPC commands to read and write from
directly from any address in the PCI BAR (which Microsemi refers to
as GAS). Seeing accessing BAR registers can be dangerous and break
the driver, we don't want unpriviliged users to have this ability.

Therefore, for the local and remote GAS access MRPC commands, the
requesting process should need CAP_SYS_ADMIN. Priviligded processes
will already have access to the bar through the sysfs resource file
so this doesn't give userspace any capabilities it didn't already have.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
[logang@deltatee.com: rework commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 6 ++++++
 include/linux/switchtec.h      | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 524cb4e4bbf7..990e0ee32f7b 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -478,6 +478,12 @@ static ssize_t switchtec_dev_write(struct file *filp, const char __user *data,
 		rc = -EFAULT;
 		goto out;
 	}
+	if (((MRPC_CMD_ID(stuser->cmd) == MRPC_GAS_WRITE) ||
+	     (MRPC_CMD_ID(stuser->cmd) == MRPC_GAS_READ)) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	data += sizeof(stuser->cmd);
 	rc = copy_from_user(&stuser->data, data, size - sizeof(stuser->cmd));
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index e85155244135..1c3e76b535a2 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -21,6 +21,11 @@
 #define SWITCHTEC_EVENT_FATAL    BIT(4)
 
 #define SWITCHTEC_DMA_MRPC_EN	BIT(0)
+
+#define MRPC_GAS_READ 0x29
+#define MRPC_GAS_WRITE 0x87
+#define MRPC_CMD_ID(x) ((x) & 0xffff)
+
 enum {
 	SWITCHTEC_GAS_MRPC_OFFSET       = 0x0000,
 	SWITCHTEC_GAS_TOP_CFG_OFFSET    = 0x1000,
-- 
2.20.1

