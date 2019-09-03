Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57B5A6717
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 13:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfICLKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 07:10:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICLKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:10:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so17031554wra.6;
        Tue, 03 Sep 2019 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OB/ebM0xFR6Mxp0KUgqKdXbK7ynlwFq+qhqH3UbFDaQ=;
        b=Y2K3p/BA1YyFIOkgHprG5ow2XJHpdyL658zymLfh0Lqa7ZjdWijf6bJRn9cip/EbY1
         1IU1AApMWmi1NGFPozhQlTdoO5CocqvxTDrEK7M81cGs2BYaG4OgjUvH2e1xw5yUkzSB
         JDgxL++TGopGx4bGJN2TcPXLX1fiuU5NXVN+TmGlIDh85vntnkHx69+s8kIXkIvSFPyu
         Jz4rBP0kCk4e8axOyrHxPbUDVWisZYd+gXZCMvzuQjEuQDO1Hqipzfo/9pro3cxh/uq7
         tT0o8qqxrpxToHWWnUNaSmcaEaEfxRI4ERNOQ2PudMt/QbPHiHBeoHINPTgMohtWxWzK
         0XWQ==
X-Gm-Message-State: APjAAAVfBxbuKJL07A1HQjvmdbsZwEYCkTmdQ2pLNSimZA2Y+xFtye15
        BEZl/GOD//nuBrXqHI9kb/w=
X-Google-Smtp-Source: APXvYqzMmBDG91dqagyUiTXYHlQfpPEzIBQ/B+F79d8p6nMHFbvuQBsxb3AWGs8szaAARXsRTJ8S9Q==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr24515859wrg.284.1567509030018;
        Tue, 03 Sep 2019 04:10:30 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id w12sm4363572wrg.47.2019.09.03.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:10:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
Date:   Tue,  3 Sep 2019 14:10:18 +0300
Message-Id: <20190903111021.1559-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903111021.1559-1-efremov@linux.com>
References: <20190903111021.1559-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pciehp_set_indicators() to set power and attention indicators with a
single register write. Thus, avoiding waiting twice for Command Complete.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     |  5 +++++
 drivers/pci/hotplug/pciehp_hpc.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04b8083..0214e09e91a4 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -167,6 +167,11 @@ int pciehp_power_on_slot(struct controller *ctrl);
 void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
+/* Special values for leaving indicators unchanged */
+#define PCI_EXP_SLTCTL_ATTN_IND_NONE -1 /* Attention Indicator noop */
+#define PCI_EXP_SLTCTL_PWR_IND_NONE  -1 /* Power Indicator noop */
+void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
+
 void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3371e3..4d0fe39ef049 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -443,6 +443,27 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
+void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
+{
+	u16 cmd = 0, mask = 0;
+
+	if (PWR_LED(ctrl) && pwr > 0) {
+		cmd |= pwr;
+		mask |= PCI_EXP_SLTCTL_PIC;
+	}
+
+	if (ATTN_LED(ctrl) && attn > 0) {
+		cmd |= attn;
+		mask |= PCI_EXP_SLTCTL_AIC;
+	}
+
+	if (cmd) {
+		pcie_write_cmd_nowait(ctrl, cmd, mask);
+		ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+			 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+	}
+}
+
 void pciehp_green_led_on(struct controller *ctrl)
 {
 	if (!PWR_LED(ctrl))
-- 
2.21.0

