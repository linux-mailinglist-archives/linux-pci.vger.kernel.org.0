Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14B3891D9
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHKNaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 09:30:06 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34796 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfHKNaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 09:30:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id 31so102336680wrm.1;
        Sun, 11 Aug 2019 06:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XuxfIYYRk8+4ocDr9gT6eQtT+jsWzzCKFgtnUKmWXA=;
        b=UHwIe2eSav6BqbGz/rgeTHVAUpo5nT5l0P9MP/hsMlhL9jRjs7c1shkmMLCZtntPfK
         bLgUN/utCdqDAsjTNNUet1vXRYDU+DuoxEYHHHuuL9upJWUI2+TZ9Pi9KvV1lRE9E2LF
         d36V2pmOZrR0LRV1qboLPrKjW9Yv9/8RWXH29KtFkTjmG8zTJ5dtAR+6tQbSEP+e0xMl
         2ioJ5D6B3ks4zIX7dQebKfXfMSxPThmDE0KbOzsROmYMYqp6vSST22Le42WExPJHxJ06
         MeuKKLUkjf+ZpYl0Y2lqpM++EwhP2oFxwLGq8NPv+gW9KGHKWM+Kh3UWO6yvxa+mFYIW
         Xamw==
X-Gm-Message-State: APjAAAWCHte/8nQTBC9eIyjgbT/JccDVkMReeZ3FosGSGAjp2DsKHgkI
        gixuPvM18RQ6iEPF0+lR/7BXPIiB
X-Google-Smtp-Source: APXvYqyQ965PEU2rGCBj15vWf9pWNWK9eQx9RHLYC8WrqSWvJATRWUBnTF315C0nQa0us0jgiBsB7A==
X-Received: by 2002:adf:f404:: with SMTP id g4mr8001499wro.290.1565530203502;
        Sun, 11 Aug 2019 06:30:03 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o16sm13781463wrp.23.2019.08.11.06.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:30:03 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 3/4] PCI: pciehp: Replace pciehp_set_attention_status()
Date:   Sun, 11 Aug 2019 16:29:44 +0300
Message-Id: <20190811132945.12426-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811132945.12426-1-efremov@linux.com>
References: <20190811132945.12426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces pciehp_set_attention_status() with
pciehp_set_indicators().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     |  4 +++-
 drivers/pci/hotplug/pciehp_hpc.c | 25 -------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 92ff65132711..01ea095aa533 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -182,7 +182,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator pwr,
 			   enum pciehp_indicator attn);
-void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
 void pciehp_green_led_on(struct controller *ctrl);
@@ -201,6 +200,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
+#define pciehp_set_attention_status(crtl, status) \
+	pciehp_set_indicators(ctrl, PWR_NONE, status)
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e90cb2152e8f..beff1120afef 100644
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
 void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator pwr,
 			   enum pciehp_indicator attn)
-- 
2.21.0

