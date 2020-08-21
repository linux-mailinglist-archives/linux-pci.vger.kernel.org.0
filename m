Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D8D24E07F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 21:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHUTOO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 15:14:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D31DC061573
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 12:14:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so1297353plr.11
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZW8KhlX+gLf0/rf2sp3YxSoFxOMpb5isg+POvbKd/iI=;
        b=bGhcRP3XJIZ9J9UzpEqLsf4MoqsrKC0dOZBjbh8W5P1yKFlusMr8jzkTzxPCvPBCP9
         rIDLml24uWDNGKMetqaDXtCHGKlWziZiXTRksmo3MjwAHlYWuDihfLlOUX+aM2nsdBtP
         dHDL6mHaucm+3ubFFk6HPtbsYRAN+s2ykiuYT28tc8XofnK32daKQxmdKVqgBfs4QxtN
         kj+vqnplfCTjOAHE2kMvhH4um8/YS8xHGNfaF9jaE9c1y+EZ6L+NDdrZg8AlDSYixZ9j
         t+EFzlJ3NIp8A0ob8jzdsisidNIwavvv3W5UFTYGMLWdPvJb9QtOOLRppkPOhTtdsvh4
         WTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZW8KhlX+gLf0/rf2sp3YxSoFxOMpb5isg+POvbKd/iI=;
        b=T95km+cYSVQxn0MVglPbwpTocaqYaNZNi1y/bIuDddNHd3i+1wv06noH+APsk3fl+l
         NOfKaZM8xuvkSajsKHHR5BqYvkw1l85yP8aKVunJuw8l/Jf+0/RJ4G1sEOLroLj26dh5
         BDFEMomU/Yfwra4yQ0rqUwKh17zdhd6pF1e+eX4pdiNuLGnaiatIsBADKPvJdEMONm3a
         8Z/Ykwd+wUP93dav0lz410iW+NQXTMLp88GBLEz3tTCxadVWcDHFl1J8G3VQZH1p7lu9
         q/xXer7Y4XAmBHGVUZhzi950J9GHfri7LPexkhwllFa8MceCTIArA3g35m6iv5AeCDP/
         troA==
X-Gm-Message-State: AOAM5330InX0H62lmIiN5NRfhOS8sfTiwZCd5q4vvIAz52CNbBAUsWG2
        LL1Ma20wBEZ/ibl/sUiTHHs=
X-Google-Smtp-Source: ABdhPJyBUgh3FGkk+9vVN/BVmq53gQpTkRBknq8vo5yY0EVa+dG/Qk6Qh9hv/r7JMdwo8y720emb7g==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr3501015plk.102.1598037252356;
        Fri, 21 Aug 2020 12:14:12 -0700 (PDT)
Received: from localhost.localdomain ([124.253.196.72])
        by smtp.googlemail.com with ESMTPSA id q71sm2688663pjq.7.2020.08.21.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:14:11 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] PCI: Add support for LTR
Date:   Sat, 22 Aug 2020 00:43:56 +0530
Message-Id: <20200821191356.7669-1-puranjay12@gmail.com>
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
 drivers/pci/pci-acpi.c   | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci.c        | 26 ++++++++++++++++++++++++++
 drivers/pci/pci.h        |  5 +++++
 drivers/pci/probe.c      |  6 ++++++
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a8..c9151f96f3c9 100644
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
 static void pci_acpi_set_untrusted(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9338f914a0e..8aa71175ebea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2921,6 +2921,32 @@ void pci_pm_init(struct pci_dev *dev)
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
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
 {
 	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..f824dd977dd3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -109,6 +109,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
+void pci_ltr_init(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
@@ -673,11 +674,15 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
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
index 2f66988cea25..0bc9d7e6a0e9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2134,6 +2134,11 @@ static void pci_configure_ltr(struct pci_dev *dev)
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
@@ -2394,6 +2399,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
index 34c1c4f45288..e407c8cba2d3 100644
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

