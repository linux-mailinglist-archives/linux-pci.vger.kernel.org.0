Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D707C2506C1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgHXRnZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHXRnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 13:43:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FEC061573
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 10:43:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so4584505plr.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2020 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQnYboBSOiUFVbrpn6Up5SRW0z7sTQ+dpcpNXbiY/Jc=;
        b=WkEHSvIR2JlIcxvS6dwEy2wvHFGodjLNJEOSpCafmITNu/Tgp39VDFjRGFWb3HWyYo
         MA4ZrnSsK7cvKKSdU95mwuXyKBxpohYH6iGF9wZE5q0wOmv1uBBLJiihgCmcz9fLlg+w
         v2gcx/RVCX7TFaIqOGVPTglYHdNZj/0a/7h5aZZly6Vu1UF4nMTnW4WwgpXRxnUe0V1q
         hRCmw1uBl9RQOAI7WzXgwLQUq0JW/dWkEsJbA4lR+bxbJ/vVfEuUAu8fl27UZ2t3bMHS
         bq8l8h4cyKoLOcOHp/A2D1Jq8vZiuS5qZQodv8hrRwd28ny/2wdwgJHv6cCnGsuczdrA
         cSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQnYboBSOiUFVbrpn6Up5SRW0z7sTQ+dpcpNXbiY/Jc=;
        b=OVQCitwrqciHU6Dqli9LdSgioxkPFFZv06u13nL3yDMJ4KWYzf5XDdET8i2PcFs0Qs
         UB1s0+WxjOHqSYggjMPFQN3/PCJG0RKpATdjtCcSzntg1r7Bd2UBWKpmgh/QpVG+Bkdf
         G4W/aUSoJYEvE5E+m6EqtwoGEj9SHbtj+2YL61vV5z6aOLKNkIixxPU+wXfzd9lHG6QG
         g+hoUUiQLZJuI73Bzc0aZSD5h3S4BcH3iDV/xdSvrwSg/tXPsa7UQahItrrtTLWIo6OC
         CyOzoKwDb/dJaAoq1PfxKBzG6WxIScKK4R9Q34gU0Zf1AkSAXDuqpaTVtLCRseJv/Cd/
         kTtg==
X-Gm-Message-State: AOAM531m7VFH7gf45PG6am9P7IsU0Wc7jSCHa8xMPRbISZldco3Z++OS
        gzm0wshAVM7g3nj8okM5+jw=
X-Google-Smtp-Source: ABdhPJyQvYlpSCj+MsaZ74YiA5/vht/qHq2t/g0D9CbA5sS83ApEY+rOQsNlbDk61FI8Qf+qegYJHg==
X-Received: by 2002:a17:90b:3284:: with SMTP id ks4mr317818pjb.116.1598291004000;
        Mon, 24 Aug 2020 10:43:24 -0700 (PDT)
Received: from localhost.localdomain ([124.253.194.149])
        by smtp.googlemail.com with ESMTPSA id w187sm11939436pfd.87.2020.08.24.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:43:23 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] PCI: Add support for LTR
Date:   Mon, 24 Aug 2020 23:12:50 +0530
Message-Id: <20200824174250.5507-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new function pci_ltr_init() which will be called from
pci_init_capabilities() to initialize every PCIe device's LTR values.
Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
v1 - based the patch on v5.9-rc1 so it applies correctly
---
 drivers/pci/pci-acpi.c   | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci.c        | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h        |  5 +++++
 drivers/pci/probe.c      |  6 ++++++
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 69 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a03f748..c77e47b53751 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,6 +1213,34 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/* pci_acpi_evaluate_ltr_latency
+ *
+ * @dev - the pci_dev to evaluate and save latencies
+ */
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
+{
+	union acpi_object *obj, *elements;
+	struct acpi_device *handle;
+
+	handle = ACPI_HANDLE(&dev->dev);
+	if (!handle)
+		return;
+
+	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
+				DSM_PCI_LTR_MAX_LATENCY, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 4) {
+		elements = obj->package.elements;
+		dev->max_snoop_latency = (u16)elements[1].integer.value |
+				((u16)elements[0].integer.value << PCI_LTR_SCALE_SHIFT);
+		dev->max_nosnoop_latency = (u16)elements[3].integer.value |
+				((u16)elements[2].integer.value << PCI_LTR_SCALE_SHIFT);
+	}
+	ACPI_FREE(obj);
+}
+
 static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a458c46d7e39..b5531272b865 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3056,6 +3056,33 @@ void pci_pm_init(struct pci_dev *dev)
 		dev->imm_ready = 1;
 }
 
+/**
+ * pci_ltr_init - Initialize Latency Tolerance Information of given PCI device
+ * @dev: PCI device to handle.
+ */
+void pci_ltr_init(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIASPM
+	int ltr;
+	struct pci_dev *endpoint_dev = dev;
+	u16 max_snoop_sum = 0;
+	u16 max_nosnoop_sum = 0;
+
+	ltr = pci_find_ext_capability(endpoint_dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	dev = pci_upstream_bridge(dev);
+	while (dev) {
+		max_snoop_sum += dev->max_snoop_latency;
+		max_nosnoop_sum += dev->max_nosnoop_latency;
+		dev = pci_upstream_bridge(dev);
+	}
+	pci_write_config_word(endpoint_dev, ltr + PCI_LTR_MAX_SNOOP_LAT, max_snoop_sum);
+	pci_write_config_word(endpoint_dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, max_nosnoop_sum);
+#endif
+}
+
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
 {
 	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..ef3d22b82200 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -110,6 +110,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
+void pci_ltr_init(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
@@ -680,11 +681,15 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev);
 #else
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
+static inline void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
+{
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..0257aa615665 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2140,6 +2140,11 @@ static void pci_configure_ltr(struct pci_dev *dev)
 		dev->ltr_path = 1;
 	}
 #endif
+
+	/*
+	 * Read latency values from _DSM and save in pci_dev
+	 */
+	pci_acpi_evaluate_ltr_latency(dev);
 }
 
 static void pci_configure_eetlp_prefix(struct pci_dev *dev)
@@ -2400,6 +2405,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
+	pci_ltr_init(dev);		/* Latency Tolerance Reporting */
 
 	pcie_report_downtraining(dev);
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 5ba475ca9078..e23236a4ff66 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -110,6 +110,7 @@ extern const guid_t pci_acpi_dsm_guid;
 
 /* _DSM Definitions for PCI */
 #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
+#define DSM_PCI_LTR_MAX_LATENCY			0x06
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..9de6b290ed81 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -380,6 +380,8 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
+	u16 max_snoop_latency;		/* LTR Max Snoop latency */
+	u16 max_nosnoop_latency;	/* LTR Max No Snoop latency */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.27.0

