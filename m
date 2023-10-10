Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8289B7C41D6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjJJUpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjJJUo6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E691;
        Tue, 10 Oct 2023 13:44:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82495C433C9;
        Tue, 10 Oct 2023 20:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970696;
        bh=BodAKgycQqatnIUaErDwVOgV6Git5gEM6dZfZCZVv2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI19XbgMGOQ+M22VcI+ceBZMTpByuDraBwQlqNEohS8JYb6ByTzkJu5h70vE1dnOq
         OphhMkGvgYUv/sfZQvywDWe0BH0sI8tHEkYzVH1pRcXDF5ox3kxOvw7CxgtAmgrPbB
         lpb5TgIReju6WnEwjORMUfknrZ7DyoyTMv6mUvohh/vPBVGPTzGRzsgiC75xOsX8O+
         ZBqWBl+1W9/YEtgVjZND38ScjTl4cUgN9gN7GTFBaF4aRpG0/tfRq73Fvy5K+mmeLM
         tzgcSMlVKyjOStcMBi8rVEcOrTnZLyVkX5M5DZ+Rp9kqNPzEQH0G7jwS/b0kD6a7ee
         zuEX5q1dAr6eg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
Date:   Tue, 10 Oct 2023 15:44:32 -0500
Message-Id: <20231010204436.1000644-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010204436.1000644-1-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependences on the field position, i.e., the
shift value.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/dpc.c        | 9 +++++----
 drivers/pci/quirks.c          | 2 +-
 include/uapi/linux/pci_regs.h | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..6e551f34ec63 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -8,6 +8,7 @@
 
 #define dev_fmt(fmt) "DPC: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
-	first_error = (dpc_status & 0x1f00) >> 8;
+	first_error = FIELD_GET(PCI_EXP_DPC_STATUS_FIRST_ERR, dpc_status);
 
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if ((status & ~mask) & (1 << i))
@@ -270,8 +271,8 @@ void dpc_process_error(struct pci_dev *pdev)
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
 		 status, source);
 
-	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
-	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
+	reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN, status);
+	ext_reason = FIELD_GET(PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT, status);
 	pci_warn(pdev, "%s detected\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
 		 (reason == 1) ? "ERR_NONFATAL" :
@@ -338,7 +339,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
 	if (!pdev->dpc_rp_log_size) {
 		pdev->dpc_rp_log_size =
-			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
 		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..a9fdc2e3f110 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6154,7 +6154,7 @@ static void dpc_log_size(struct pci_dev *dev)
 	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
 
-	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
+	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
 		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
 		dev->dpc_rp_log_size = 4;
 	}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 833e5fb40ea5..e97a06b50f95 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1046,6 +1046,7 @@
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
 #define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
 #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
+#define  PCI_EXP_DPC_STATUS_FIRST_ERR	    0x1f00 /* RP PIO First Error Ptr */
 
 #define PCI_EXP_DPC_SOURCE_ID		 0x0A	/* DPC Source Identifier */
 
-- 
2.34.1

