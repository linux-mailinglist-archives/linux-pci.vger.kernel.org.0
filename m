Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1F9496F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfHSQHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:07:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSQHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:07:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so44703wmj.5;
        Mon, 19 Aug 2019 09:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSCyhJxea4L6srfYRJAutvNS3KK4aXxYTi6Whyjb/cA=;
        b=KqTr1I1BCVPCgcdEJiaqEqMW17KiearG5zRgaUiwKMYyXjle+4bMPwhXY0/k6WKB7L
         aYABRnHsl4UZoe4YHVPyjbv6ryeFfKHUKHAKV1419c0ek/wO9eisXvxwDyq6pXWZzj4K
         /22gA8E7D/e7RCo5lAipTlICpELyx8eyTXUSoA0zUMJpilmziXozfveW/pldtKYRy0wW
         1QVolouTsU1Exj0LMa894yOmKOVODb5cfXD2e4Q9EU9e9VxVS1l4Ggbm6221mkPFuptC
         lgrXzM9XCUgrpJIZJV1oYHaA2esb3FqmaCCLaYuYkvtmomioVIMxJj5rTVoL3cTEiJ5i
         6isA==
X-Gm-Message-State: APjAAAX+583oVRUd7E7pKG21euBfZBzCOh8VR0E1qMPcP6fYWCpxCU2i
        Z31Ry0sieH5IPCYcYb4lZvoFj/fv
X-Google-Smtp-Source: APXvYqwakYtiUs+DhugY8neaGBWmUFfUS3kBIG+NTpyFcIiR+mp0sHOyMD0Y5+EDtRVekLwkKvNMIw==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr20888429wmb.108.1566230841870;
        Mon, 19 Aug 2019 09:07:21 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b136sm32442189wme.18.2019.08.19.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:07:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
Date:   Mon, 19 Aug 2019 19:06:40 +0300
Message-Id: <20190819160643.27998-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819160643.27998-1-efremov@linux.com>
References: <20190819160643.27998-1-efremov@linux.com>
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
 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h    |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04b8083..0e272bf3deb4 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -167,6 +167,7 @@ int pciehp_power_on_slot(struct controller *ctrl);
 void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
+void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3371e3..5474b9854a7f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -443,6 +443,35 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
+void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
+{
+	u16 cmd = 0, mask = 0;
+
+	if (PWR_LED(ctrl))
+		switch (pwr) {
+		case PCI_EXP_SLTCTL_PWR_IND_ON:
+		case PCI_EXP_SLTCTL_PWR_IND_BLINK:
+		case PCI_EXP_SLTCTL_PWR_IND_OFF:
+			cmd |= pwr;
+			mask |= PCI_EXP_SLTCTL_PIC;
+		}
+
+	if (ATTN_LED(ctrl))
+		switch (attn) {
+		case PCI_EXP_SLTCTL_ATTN_IND_ON:
+		case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
+		case PCI_EXP_SLTCTL_ATTN_IND_OFF:
+			cmd |= attn;
+			mask |= PCI_EXP_SLTCTL_AIC;
+		}
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
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..291788b58f3a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -591,10 +591,12 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_NONE  0x0    /* Attention Indicator noop */
 #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
 #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
 #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
 #define  PCI_EXP_SLTCTL_PIC	0x0300	/* Power Indicator Control */
+#define  PCI_EXP_SLTCTL_PWR_IND_NONE   0x0    /* Power Indicator noop */
 #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
 #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
 #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
-- 
2.21.0

