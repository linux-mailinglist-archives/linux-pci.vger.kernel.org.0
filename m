Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8108265D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 22:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfHEUwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 16:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbfHEUwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 16:52:36 -0400
Received: from localhost (unknown [64.22.228.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD742147A;
        Mon,  5 Aug 2019 20:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565038354;
        bh=T2zwYQd1i5+xUaRyhJB6l1Me10AQHd1mRdo1IIqiI0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGPiw0dg8FQ1jJXnV4mP33bGm7Kt8jFIrziPh4lnMaQbZY9pEeZyZXk9SqPJO9JJU
         jKTnCUZRLmInGmmrgt0o0baHWlRByWjVlfDwf5ozwA2wzLVQ6exCQlgBnY9V7s9540
         tjeWFAVG8XgaQjtfDJUi0DV8ELjARTEKg8Vu6ND4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/5] PCI / PM: Check for error when reading Power State
Date:   Mon,  5 Aug 2019 15:52:13 -0500
Message-Id: <20190805205214.194981-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805205214.194981-1-helgaas@kernel.org>
References: <20190805205214.194981-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The Power Management Status Register is in config space, and reads while
the device is in D3cold typically return ~0 data (PCI_ERROR_RESPONSE).  If
we just look at the PCI_PM_CTRL_STATE_MASK bits, that is 0x3, which looks
like D3hot, not D3cold.

Check the entire register for PCI_ERROR_RESPONSE so we can distinguish
D3cold from D3hot.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |  6 +++---
 include/linux/pci.h | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af6a97d7012b..d8686e3cd5eb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -894,7 +894,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	dev->current_state = pci_power_state(pmcsr);
 	if (dev->current_state != state && printk_ratelimit())
 		pci_info(dev, "Refused to change power state, currently in D%d\n",
 			 dev->current_state);
@@ -942,7 +942,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 		u16 pmcsr;
 
 		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+		dev->current_state = pci_power_state(pmcsr);
 	} else {
 		dev->current_state = state;
 	}
@@ -1677,7 +1677,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	if (dev->pm_cap) {
 		u16 pmcsr;
 		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+		dev->current_state = pci_power_state(pmcsr);
 	}
 
 	if (atomic_inc_return(&dev->enable_cnt) > 1)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d64fd3788061..fdfe990e9661 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -152,6 +152,19 @@ static inline const char *pci_power_name(pci_power_t state)
 	return pci_power_names[1 + (__force int) state];
 }
 
+/*
+ * Convert a Power Management Status Register value to a pci_power_t.
+ * Note that if we read the register while the device is in D3cold, we
+ * typically get PCI_ERROR_RESPONSE, which looks like D3hot (0x3) if we
+ * only look at the PCI_PM_CTRL_STATE_MASK bits.
+ */
+static inline pci_power_t pci_power_state(u16 pmcsr)
+{
+	if (pmcsr == (u16) PCI_ERROR_RESPONSE)
+		return PCI_D3cold;
+	return pmcsr & PCI_PM_CTRL_STATE_MASK;
+}
+
 #define PCI_PM_D2_DELAY		200
 #define PCI_PM_D3_WAIT		10
 #define PCI_PM_D3COLD_WAIT	100
-- 
2.22.0.770.g0f2c4a37fd-goog

