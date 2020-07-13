Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4590021D6FF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgGMNWt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgGMNWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F6AC061755;
        Mon, 13 Jul 2020 06:22:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so17106412ejd.13;
        Mon, 13 Jul 2020 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FetVZrPlJUPVzjvl/d8u42tnB5KKMfZUCULLNeuM/VI=;
        b=pi84S25E/LjOX6WfnqtNMuVL7qs5eO1E4EewALCcA9YMwfyw8CnRiXzijZVG26Bw2j
         0xNBGXVpPw+j+e8RC7bx5v3vk4LyCNCZ7gb0ZvzSAAMHGlCtUkuj0sxXdepUae2OnJ43
         JERDq32hpusL01gB+UL/JL/wwZF4MzoCs6+qLiWOdFnOUHcMZRmgEfT280w8JasvRaE9
         CSY24PlKTHaERxPN0+m6mwuMwLEiai9Jgle5PeObDaPQHBLIzXiR44qH/cpp3+uvpbIO
         +hLR3AvXmAhlJlfJ5IsGwsQDycGe642PI7IF4CmBXU5f3/sqaqNBEafxVaMIODqkBGcD
         tMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FetVZrPlJUPVzjvl/d8u42tnB5KKMfZUCULLNeuM/VI=;
        b=TxMNJPoMdyKAQSQnx8KGA1DsAujnQwwRZsRWg/mdwFNvhbkCzMLdzCttiQYgfBx8JP
         G8suSevUyjd4VXOfIM16iAa5sIpiadm73oM94hP4N7vMoAtxuhhQrDfOkWWWtAbdXPVE
         mn7qbSzKnhb4xHuIhKBr1vd1uQvU/8i55BheimBuJYB8w/Ss3BrCzxEW4A/hBxkiPmXm
         53Pc7bdf+X4cs2kOWpB+Pmr9S5357GUtRAQpZsFLICgvbpKyE5Y/wyB7uUFfgXBJXBEu
         eL0T/f9Hchc8njl8B0k5ihB07k7AwXu1EUT/UA5LUAhkpEAkxgosgXEgHwj6UTZpXfss
         E80w==
X-Gm-Message-State: AOAM5320IYBz+yfVyUUoWBnYJ4MSlMzLJZQePwcITkWHtwek+FyUQOZD
        5dSI/IYwrIsuWt0ilcOTHaQ=
X-Google-Smtp-Source: ABdhPJzp2M4i/xmpJ7GKgnOIHqRMg1MAl8Qp4E8T8kCfwxBHg6LBO9oYn/AU6tHj6VuJkN61Uk+q6g==
X-Received: by 2002:a17:906:7c8:: with SMTP id m8mr73049398ejc.527.1594646567104;
        Mon, 13 Jul 2020 06:22:47 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:46 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/35] PCI: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:19 +0200
Message-Id: <20200713122247.10985-8-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/pci/access.c               | 14 +++++++-------
 drivers/pci/pci-bridge-emul.c      | 14 +++++++-------
 drivers/pci/pci.c                  |  8 ++++----
 drivers/pci/pcie/bw_notification.c |  4 ++--
 drivers/pci/probe.c                |  4 ++--
 drivers/pci/quirks.c               |  2 +-
 drivers/pci/syscall.c              |  8 ++++----
 drivers/pci/xen-pcifront.c         |  2 +-
 8 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..b907abe38679 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -92,7 +92,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 	else
 		*val = readl(addr);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_generic_config_read);
 
@@ -112,7 +112,7 @@ int pci_generic_config_write(struct pci_bus *bus, unsigned int devfn,
 	else
 		writel(val, addr);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_generic_config_write);
 
@@ -132,7 +132,7 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 	if (size <= 2)
 		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_generic_config_read32);
 
@@ -148,7 +148,7 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 
 	if (size == 4) {
 		writel(val, addr);
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	/*
@@ -169,7 +169,7 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 	tmp |= val << ((where & 0x3) * 8);
 	writel(tmp, addr);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_generic_config_write32);
 
@@ -222,7 +222,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 int pci_user_read_config_##size						\
 	(struct pci_dev *dev, int pos, type *val)			\
 {									\
-	int ret = PCIBIOS_SUCCESSFUL;					\
+	int ret = 0;					\
 	u32 data = -1;							\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
@@ -242,7 +242,7 @@ EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
 int pci_user_write_config_##size					\
 	(struct pci_dev *dev, int pos, type val)			\
 {									\
-	int ret = PCIBIOS_SUCCESSFUL;					\
+	int ret = 0;					\
 	if (PCI_##size##_BAD)						\
 		return -EINVAL;						\
 	raw_spin_lock_irq(&pci_lock);				\
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index ccf26d12ec61..9695c453e197 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -323,12 +323,12 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END) {
 		*value = 0;
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END) {
 		*value = 0;
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	}
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
@@ -364,7 +364,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	else if (size != 4)
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 /*
@@ -383,10 +383,10 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	const struct pci_bridge_reg_behavior *behavior;
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	shift = (where & 0x3) * 8;
 
@@ -400,7 +400,7 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	ret = pci_bridge_emul_conf_read(bridge, reg, 4, &old);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return ret;
 
 	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
@@ -428,5 +428,5 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 	if (write_op)
 		write_op(bridge, reg, old, new, mask);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b..a74547861d5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -185,7 +185,7 @@ int pci_status_get_and_clear_errors(struct pci_dev *pdev)
 	int ret;
 
 	ret = pci_read_config_word(pdev, PCI_STATUS, &status);
-	if (ret != PCIBIOS_SUCCESSFUL)
+	if (ret != 0)
 		return -EIO;
 
 	status &= PCI_STATUS_ERROR_BITS;
@@ -534,7 +534,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 	if (start)
 		pos = start;
 
-	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
+	if (pci_read_config_dword(dev, pos, &header) != 0)
 		return 0;
 
 	/*
@@ -552,7 +552,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
 		if (pos < PCI_CFG_SPACE_SIZE)
 			break;
 
-		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
+		if (pci_read_config_dword(dev, pos, &header) != 0)
 			break;
 	}
 
@@ -628,7 +628,7 @@ static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
 				      PCI_CAP_ID_HT, &ttl);
 	while (pos) {
 		rc = pci_read_config_byte(dev, pos + 3, &cap);
-		if (rc != PCIBIOS_SUCCESSFUL)
+		if (rc != 0)
 			return 0;
 
 		if ((cap & mask) == ht_cap)
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index 77e685771487..c7201d886026 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -23,7 +23,7 @@ static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
 	u32 lnk_cap;
 
 	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
-	return (ret == PCIBIOS_SUCCESSFUL) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
+	return (ret == 0) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
 }
 
 static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
@@ -56,7 +56,7 @@ static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
 	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
 	events = link_status & PCI_EXP_LNKSTA_LBMS;
 
-	if (ret != PCIBIOS_SUCCESSFUL || !events)
+	if (ret != 0 || !events)
 		return IRQ_NONE;
 
 	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988cea25..ab7e19882b30 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1582,7 +1582,7 @@ static bool pci_ext_cfg_is_aliased(struct pci_dev *dev)
 
 	for (pos = PCI_CFG_SPACE_SIZE;
 	     pos < PCI_CFG_SPACE_EXP_SIZE; pos += PCI_CFG_SPACE_SIZE) {
-		if (pci_read_config_dword(dev, pos, &tmp) != PCIBIOS_SUCCESSFUL
+		if (pci_read_config_dword(dev, pos, &tmp) != 0
 		    || header != tmp)
 			return false;
 	}
@@ -1609,7 +1609,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	u32 status;
 	int pos = PCI_CFG_SPACE_SIZE;
 
-	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
+	if (pci_read_config_dword(dev, pos, &status) != 0)
 		return PCI_CFG_SPACE_SIZE;
 	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
 		return PCI_CFG_SPACE_SIZE;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 812bfc32ecb8..e60ef8abd698 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5117,7 +5117,7 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 
 		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
 		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
-		    PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
+		    0 || (status == 0xffffffff))
 			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
 
 		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
diff --git a/drivers/pci/syscall.c b/drivers/pci/syscall.c
index 31e39558d49d..7d45b58beacd 100644
--- a/drivers/pci/syscall.c
+++ b/drivers/pci/syscall.c
@@ -46,7 +46,7 @@ SYSCALL_DEFINE5(pciconfig_read, unsigned long, bus, unsigned long, dfn,
 	}
 
 	err = -EIO;
-	if (cfg_ret != PCIBIOS_SUCCESSFUL)
+	if (cfg_ret != 0)
 		goto error;
 
 	switch (len) {
@@ -105,7 +105,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_byte(dev, off, byte);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err != 0)
 			err = -EIO;
 		break;
 
@@ -114,7 +114,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_word(dev, off, word);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err != 0)
 			err = -EIO;
 		break;
 
@@ -123,7 +123,7 @@ SYSCALL_DEFINE5(pciconfig_write, unsigned long, bus, unsigned long, dfn,
 		if (err)
 			break;
 		err = pci_user_write_config_dword(dev, off, dword);
-		if (err != PCIBIOS_SUCCESSFUL)
+		if (err != 0)
 			err = -EIO;
 		break;
 
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index fab267e359e7..f63623b683ad 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -81,7 +81,7 @@ static int errno_to_pcibios_err(int errno)
 {
 	switch (errno) {
 	case XEN_PCI_ERR_success:
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	case XEN_PCI_ERR_dev_not_found:
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
2.18.2

