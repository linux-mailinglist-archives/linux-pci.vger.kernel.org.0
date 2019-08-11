Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA27891D4
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHKNaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 09:30:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKNaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 09:30:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so5586043wrq.9;
        Sun, 11 Aug 2019 06:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cps42fyqj86V0Z/vrM+UXoEo+pmBq/RuWxL57/l8xY=;
        b=f6eM9ZFrzd6hlHJxicOHI0mu4gknZhtCAtgMzwPNzSVzdfVmLWq3O3THttkUre3QXo
         DDByCVZr9ADN6gPC01DM3KqvHcoOgwiKTrXeeoTLgmphbQAUciroT6YPcWKoUiO9NINz
         ikDz942Kg24AXB3ov6HSRLk+iWRNQuwY3MG4N9Vwuq77PaifjPyD83s3jqs4BfAIr/fX
         GJMDYTNDbgeHV/rtB+AAuLO7L1a6SIXExunA8Ev7mZUe9L8Tx4GVXbvpD06l2vevHStd
         7SagmJFdciH7naG6WcOk8E+NkllyrkeKxDmKyxhgV7Xezg+fmJpMN9adaZG2aZ0od+33
         X+YA==
X-Gm-Message-State: APjAAAXw8qGlXzty2c0p9Fu1pixr5fT72x7Wf9eN8mB2ef0TbNJzADtm
        skpXEmSUF8Z2bdTuovf5Yxs=
X-Google-Smtp-Source: APXvYqwASs9RyHUvT0Z72M67MgnzvJ5pqL0s2YV7utBq6LBBAbQD9u8qOUshNtKE0hmt5F0/TfwHjA==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr10255007wrq.208.1565530198922;
        Sun, 11 Aug 2019 06:29:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o16sm13781463wrp.23.2019.08.11.06.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:29:58 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
Date:   Sun, 11 Aug 2019 16:29:42 +0300
Message-Id: <20190811132945.12426-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811132945.12426-1-efremov@linux.com>
References: <20190811132945.12426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds pciehp_set_indicators() to set power and attention
indicators with a single register write. enum pciehp_indicator
introduced to switch between the indicators statuses. Attention
indicator statuses are explicitly set with values in the enum to
transparently comply with pciehp_set_attention_status() from
pciehp_hpc.c and set_attention_status() from pciehp_core.c

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     | 15 ++++++++++
 drivers/pci/hotplug/pciehp_hpc.c | 49 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04b8083..92ff65132711 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -150,6 +150,18 @@ struct controller {
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
+enum pciehp_indicator {
+	// Explicit values to match set_attention_status interface
+	ATTN_NONE = -1,
+	ATTN_OFF = 0,
+	ATTN_ON = 1,
+	ATTN_BLINK = 2,
+	PWR_NONE,
+	PWR_OFF,
+	PWR_ON,
+	PWR_BLINK
+};
+
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
@@ -167,6 +179,9 @@ int pciehp_power_on_slot(struct controller *ctrl);
 void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
+void pciehp_set_indicators(struct controller *ctrl,
+			   enum pciehp_indicator pwr,
+			   enum pciehp_indicator attn);
 void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3371e3..027e3864f632 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -443,6 +443,55 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
+void pciehp_set_indicators(struct controller *ctrl,
+			   enum pciehp_indicator pwr,
+			   enum pciehp_indicator attn)
+{
+	u16 cmd = 0;
+	bool pwr_none = (pwr == PWR_NONE);
+	bool attn_none = (attn == ATTN_NONE);
+	bool pwr_led = PWR_LED(ctrl);
+	bool attn_led = ATTN_LED(ctrl);
+
+	if ((!pwr_led && !attn_led) || (pwr_none && attn_none) ||
+	    (!attn_led && pwr_none) || (!pwr_led && attn_none))
+		return;
+
+	switch (pwr) {
+	case PWR_OFF:
+		cmd = PCI_EXP_SLTCTL_PWR_IND_OFF;
+		break;
+	case PWR_ON:
+		cmd = PCI_EXP_SLTCTL_PWR_IND_ON;
+		break;
+	case PWR_BLINK:
+		cmd = PCI_EXP_SLTCTL_PWR_IND_BLINK;
+		break;
+	default:
+		break;
+	}
+
+	switch (attn) {
+	case ATTN_OFF:
+		cmd |= PCI_EXP_SLTCTL_ATTN_IND_OFF;
+		break;
+	case ATTN_ON:
+		cmd |= PCI_EXP_SLTCTL_ATTN_IND_ON;
+		break;
+	case ATTN_BLINK:
+		cmd |= PCI_EXP_SLTCTL_ATTN_IND_BLINK;
+		break;
+	default:
+		break;
+	}
+
+	pcie_write_cmd_nowait(ctrl, cmd,
+			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 cmd);
+}
+
 void pciehp_green_led_on(struct controller *ctrl)
 {
 	if (!PWR_LED(ctrl))
-- 
2.21.0

