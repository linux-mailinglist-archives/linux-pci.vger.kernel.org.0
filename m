Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C4C251EC0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHYSBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgHYSBl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2020 14:01:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B3C061574
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2020 11:01:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so1174830pjq.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2020 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jWI3qK05PUmJpxCF8EqXjZE/s20KMCE2GTu112tpDU=;
        b=B8uVyg4wtrqGIhd9Yn4aHPpaqg5PVgShUm1IPyEQxQu8YO7sPteH4nSpNUQB8BcpW2
         Qw7PKnakP4P6WYzRvsjtHuJSDyWJHMsa8OB0kgjcj4z3bq+yC8WDFFt+YuKESgbTx81h
         t8CHuyOwBKB/AR1pC8sYaTgZk2DY1y6SOk2EONm9kc46dRh988kXvw1TsKkXC/T7xKrP
         TFLBrr2LfjlEeQ9Y5Uf8GR0KPZxuUBQg4nGlGs/n9kP8DAMZ1MmhsOu3nXjfrC+wjRCw
         rfEMQLBrwjCh7ckVGvtHFP3K9aDNNbX2g6prKJxUpF+6dYygvPYt0uU+gmmmRhBiKNAj
         7hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jWI3qK05PUmJpxCF8EqXjZE/s20KMCE2GTu112tpDU=;
        b=S4F2DSQQ5tkc0H1vfaQwbQsoeNyOKpD78PQUNqhYMSlH/6zyECN8LVm/tuuYZS+my4
         yRMPlpYSOZRlG+M9vmn1Whn3Jcxj38uKSLajKW009T7AqCuF4eUPtT7rGZSsojvPi4J0
         5SvjxSGoX+eUpXnrUq6c9KmeigGBzMlw3QI4G/2i9gmLedfqhOQQLbm9h7tLvQUpGKRx
         rh5O3R2FTtQO8zScJki2p61Ra4mAc/K+4MwEMs26psxOw6/a4tFmDZmjgB7kXJXcOuki
         UDeFv40JFHEMHJ/wCwkxCjNrpL5J70lCCE8Uc116Wexmnt9y+ySWi3hh0uo0xbZ3g3ey
         oQlQ==
X-Gm-Message-State: AOAM533TEC5msalduBUGS4EgMdCr8tMo3HsusfS2jZwVmmOUUUh6oGZd
        oAM4ztP/oqdZb7u2a9Dy/XE=
X-Google-Smtp-Source: ABdhPJzDSCYYD4OWRQoCsZkcmfHk328cG4M0/c4aUgdNBn4y7+4kvK51bN/kw+g+GH2YF4aaEjlfvw==
X-Received: by 2002:a17:90a:88:: with SMTP id a8mr2552108pja.196.1598378500743;
        Tue, 25 Aug 2020 11:01:40 -0700 (PDT)
Received: from localhost.localdomain ([124.253.196.181])
        by smtp.googlemail.com with ESMTPSA id s6sm3391720pjz.17.2020.08.25.11.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:01:39 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] PCI: Add support for LTR
Date:   Tue, 25 Aug 2020 23:31:31 +0530
Message-Id: <20200825180131.17672-1-puranjay12@gmail.com>
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
v2 - add an #ifdefin pci-acpi.c to fix the bug reported by test bot.
v1 - based the patch on v5.9-rc1 so it applies correctly.
---
 drivers/pci/pci-acpi.c   | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pci.c        | 27 +++++++++++++++++++++++++++
 drivers/pci/pci.h        |  5 +++++
 drivers/pci/probe.c      |  6 ++++++
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 71 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a03f748..af8297040c38 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,6 +1213,36 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/* pci_acpi_evaluate_ltr_latency
+ *
+ * @dev - the pci_dev to evaluate and save latencies
+ */
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIASPM
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
+#endif
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

