Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28CC94972
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfHSQH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:07:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSQH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:07:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so9314512wrn.1;
        Mon, 19 Aug 2019 09:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlCirgQ1m4IWeI3/PKcAVhZrtcd45ruBHRKNo3AHfnA=;
        b=G10vzs1fyM6aNKHJIw/JDXmnIK9p6ta+UnEGJIM3fZ7my4jflkjknKXq/cd08J5aem
         ZMN5RqqQWb09yoXilsiq2XaKpFkBt0Bn4Ai55IVaT+YbsgcHsXOg06wJMIKMlWsOD5Kg
         juliDpxtHQGzawP+oqE+VCZhBIlrfwO1EPPPM9ZOS/tuU3B1cgWvFxq9QVT1GW9YNZoQ
         3527D4qAIAJOpNu8cLFrrkK6vI12EmHrdaoJY4w1vnYIO1Bl1jaXYlU8b2Y5KpWDA7hi
         WvBa4g7RiEfmIMzg/IDCnjBmQt/j1igF0FN+HIa+w1IVC3OaiWBaoeH1FWffSYmCcD08
         q+EQ==
X-Gm-Message-State: APjAAAUIeEaCVat5bRPouUMj5XkE8/RgndLzybW69Mu0E3+brwwCkUor
        bbuHAk+6axW8aOOuBPxyT4Y=
X-Google-Smtp-Source: APXvYqyOHvccCAKuQaXP7eVoQtEHRq3+NRtFn3BtfUF64z+8jI95pQ2clcquWi6umwMkzDIoR3LlOg==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr27971559wrn.54.1566230845737;
        Mon, 19 Aug 2019 09:07:25 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b136sm32442189wme.18.2019.08.19.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:07:25 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] PCI: pciehp: Remove pciehp_set_attention_status()
Date:   Mon, 19 Aug 2019 19:06:42 +0300
Message-Id: <20190819160643.27998-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819160643.27998-1-efremov@linux.com>
References: <20190819160643.27998-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove pciehp_set_attention_status() and use pciehp_set_indicators()
instead, since the code is mostly the same.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_core.c |  7 ++++++-
 drivers/pci/hotplug/pciehp_hpc.c  | 25 -------------------------
 include/uapi/linux/pci_regs.h     |  1 +
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 0e272bf3deb4..acda513f37d7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -168,7 +168,6 @@ void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
-void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
 void pciehp_green_led_on(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6ad0d86762cb..7a86ea90ed94 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -102,8 +102,13 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
+	if (status)
+		status <<= PCI_EXP_SLTCTL_ATTN_IND_SHIFT;
+	else
+		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
+
 	pci_config_pm_runtime_get(pdev);
-	pciehp_set_attention_status(ctrl, status);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_NONE, status);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index aa4252d11be2..8f894fd5cd27 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -418,31 +418,6 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
-void pciehp_set_attention_status(struct controller *ctrl, u8 value)
-{
-	u16 slot_cmd;
-
-	if (!ATTN_LED(ctrl))
-		return;
-
-	switch (value) {
-	case 0:		/* turn off */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_OFF;
-		break;
-	case 1:		/* turn on */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_ON;
-		break;
-	case 2:		/* turn blink */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_BLINK;
-		break;
-	default:
-		return;
-	}
-	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
-}
-
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
 {
 	u16 cmd = 0, mask = 0;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 291788b58f3a..27d9f5bc1812 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -591,6 +591,7 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_SHIFT 6      /* Attention Indicator shift */
 #define  PCI_EXP_SLTCTL_ATTN_IND_NONE  0x0    /* Attention Indicator noop */
 #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
 #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
-- 
2.21.0

