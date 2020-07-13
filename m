Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6839D21D701
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgGMNZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgGMNWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BCC061755;
        Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so17148285ejb.2;
        Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxkhZKsVa3z0BZ63RYkimychYt6uFQAMZoAlbu2p1Uc=;
        b=uC7eUgOb2feCtchst56uIJDoHC7Zp0WbIbUpDeyGVdCSd48ogNAOs+i/m80OEKDeCs
         ADgZl3lhhpSNHIWQnegJlNV99b/4+TGh/P7sM64Y/Ecfz6rqENwBHiqMykLoTfMaRpr+
         SHEuVinXAErkPrzitCk/MmluTDwDhO+LJSKvrg1WNDYN9CwIWl8FGkSBBLIEM8fX3aFM
         D/s10PtX/fX7fack2CoJXPcHsIk7veCSbpQBCVkoJv2/L8SK2+hdR0j2/BT0FtlqFF/U
         KqkW/Um6gUJU5OT5KTc6/r6IEe4MYQeg4BlQ2Zy1Cytx/D5/oTvzdvWNHEk0hAqLZtvn
         oZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JxkhZKsVa3z0BZ63RYkimychYt6uFQAMZoAlbu2p1Uc=;
        b=IFUT5W/XlBsMD70rGBGhhF+O4QeOuIcHjBlwmQt9XB0zFWvhjBjYPNaAUV2Ot9U7/C
         t8bbGYC1TV40QramJQZViLArWYMbo5/+jlADyJV8PkoGaLsU6Vlsf37RK0wsIH/EHLNe
         DsT8PpjKt8CaIxCXScEgtLjMBx/CO9/oqJYZ28AGKFHVT4fzi5ucds2hpMUuK4jPQDBl
         8lkUjYe3stQTx0m6JltLnQSecp+xy3hC1M1gvv8ovw7t5RioKnJLxQ6Sxlts1bplpGZs
         rDXw/OdyOc3cfUanjQGoJS1wKe0jCWoyP7RVqhpzLMWZjJ0HoEBqThd1txvnvm1AuDoj
         AtHg==
X-Gm-Message-State: AOAM5332ZC5/McJk5yw5CIj09EEliIPmQss9QRUK0ANfNBE7WsDB0LFs
        uNQXzEHjF/npZLSHqIq7F//PYr5LRJ8Fvg==
X-Google-Smtp-Source: ABdhPJyvEFGOBAm5twEHyZqvV5SIe2iQDHFq46CgDrJch/0w7R2T3iioA0rmv9hum6shYaVHNjLYpw==
X-Received: by 2002:a17:906:fa9a:: with SMTP id lt26mr63653165ejb.502.1594646568296;
        Mon, 13 Jul 2020 06:22:48 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:47 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/35] PCI: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:20 +0200
Message-Id: <20200713122247.10985-9-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 07/35

 drivers/pci/pci-bridge-emul.c      | 2 +-
 drivers/pci/pci.c                  | 8 ++++----
 drivers/pci/pcie/bw_notification.c | 4 ++--
 drivers/pci/probe.c                | 4 ++--
 drivers/pci/quirks.c               | 4 ++--
 drivers/pci/syscall.c              | 8 ++++----
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 9695c453e197..c270c18d5cf5 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -400,7 +400,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	ret = pci_bridge_emul_conf_read(bridge, reg, 4, &old);
-	if (ret != 0)
+	if (ret)
 		return ret;
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a74547861d5e..4b2a348576cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -185,7 +185,7 @@ int pci_status_get_and_clear_errors(struct pci_dev *pdev)
 	int ret;
 
 	ret = pci_read_config_word(pdev, PCI_STATUS, &status);
-	if (ret != 0)
+	if (ret)
 		return -EIO;
 
 	status &= PCI_STATUS_ERROR_BITS;
@@ -534,7 +534,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 	if (start)
 		pos = start;
 
-	if (pci_read_config_dword(dev, pos, &header) != 0)
+	if (pci_read_config_dword(dev, pos, &header))
 		return 0;
 
 	/*
@@ -552,7 +552,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 		if (pos < PCI_CFG_SPACE_SIZE)
 			break;
 
-		if (pci_read_config_dword(dev, pos, &header) != 0)
+		if (pci_read_config_dword(dev, pos, &header))
 			break;
 	}
 
@@ -628,7 +628,7 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
 				      PCI_CAP_ID_HT, &ttl);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
-		if (rc != 0)
+		if (rc)
 			return 0;
 
 		if ((cap & mask) == ht_cap)
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index c7201d886026..f62c19ffedfc 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -23,7 +23,7 @@ static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
 	u32 lnk_cap;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
-	return (ret == 0) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
+	return (!ret) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
 }
 
 static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
@@ -56,7 +56,7 @@ static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
 	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
 	events = link_status & PCI_EXP_LNKSTA_LBMS;
 
-	if (ret != 0 || !events)
+	if (ret || !events)
 		return IRQ_NONE;
 
 	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab7e19882b30..60ecebbc7dcf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1582,7 +1582,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev *dev)
 
 	for (pos = PCI_CFG_SPACE_SIZE;
 	     pos < PCI_CFG_SPACE_EXP_SIZE; pos += PCI_CFG_SPACE_SIZE) {
-		if (pci_read_config_dword(dev, pos, &tmp) != 0
+		if (pci_read_config_dword(dev, pos, &tmp)
 		    || header != tmp)
 			return false;
 	}
@@ -1609,7 +1609,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	u32 status;
 	int pos = PCI_CFG_SPACE_SIZE;
 
-	if (pci_read_config_dword(dev, pos, &status) != 0)
+	if (pci_read_config_dword(dev, pos, &status))
 		return PCI_CFG_SPACE_SIZE;
 	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
 		return PCI_CFG_SPACE_SIZE;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e60ef8abd698..8b69d6ebb619 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5116,8 +5116,8 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 		pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
 
 		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
-		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
-		    0 || (status == 0xffffffff))
+		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status)
+		     || (status == 0xffffffff))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
 
 		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 7d45b58beacd..a208700000ea 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -46,7 +46,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	}
 
 	err = -EIO;
-	if (cfg_ret != 0)
+	if (cfg_ret)
 		goto error;
 
 	switch (len) {
@@ -105,7 +105,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_byte(dev, off, byte);
-		if (err != 0)
+		if (err)
 			err = -EIO;
 		break;
 
@@ -114,7 +114,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_word(dev, off, word);
-		if (err != 0)
+		if (err)
 			err = -EIO;
 		break;
 
@@ -123,7 +123,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_dword(dev, off, dword);
-		if (err != 0)
+		if (err)
 			err = -EIO;
 		break;
 
-- 
2.18.2

