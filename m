Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD09E4C9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfH0Jt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:49:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfH0Jt5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 05:49:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so18130214wrr.0;
        Tue, 27 Aug 2019 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vt9ycms1OmiP+WkbPIOPJFucArG1Vyq1aCL5T33dVb4=;
        b=GmzbK7MF+YYaa52TJ4+uRVZIFF9Xi8Z8h5RuBwqpbGY8hhE3q9uQBJugiYzUBq/Oq9
         bfcjcEnl++fMCafmICNRn+SGrvdoac9vbIr4R0KE7j/Jc6D9dDRvIkkjPklXs/TVwmEN
         fUtDbOFxq6nCZsfY4u4p9UcpohS1iBVGe4Sg1g2oi/UTBOOy1e1lVxBZiey91InezY9D
         5ICfXdnCX8K+HxeRcMaKgdCcPzHswgUb5Nb/C/eDvbEolRO7mupC/g52Ni8gvc7tDMsx
         Q348+RSwM8QSOEp2lKvAhiRgs6GemDDZAtMTT8jDfNxscydgfs5uQGkXDaC/NYzraYnZ
         K1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vt9ycms1OmiP+WkbPIOPJFucArG1Vyq1aCL5T33dVb4=;
        b=D/p87urAp4dGaf6dwBgoCtkbSyngdpj+uLUK655fr4wmSfePAlow+X+avOSzMc56DQ
         ElAbYoxZzJYN/ziFuaThCNK637ineM0Lg6o8ratvX6MmkFhvKpclyiIyzpFyBcEkeSRX
         KEf7OZw+tzV5aEyT5+ju3zyMYrEXf8DMUR6TFGnxYMD3QwcDp+dhFnIQpKc9G223qRwB
         My1/xzt2lK8q6dhfkPX9Bz/JL+LOG7i43neNPdTyTzIL7SY6lZ+u3F6IgFR35fGlwh0n
         d5DQwdDRansgGuA5yDQlaEEHWUodn7q/avVcO5KUD8XzSMsso8uGH8qSpGefWvU3e2Vl
         mD3g==
X-Gm-Message-State: APjAAAVvGOnz7Cz2oVTYvxbd8so8tNRi9u8ERcI7mUoG4S8+8J0aylbd
        qWL2AaFCniKm3hScYgmT8SXCBT3yniBPvQ==
X-Google-Smtp-Source: APXvYqxbJAAm9rtY1Q07f9rXi+gb8z6CWJztOc1dXgO4PD2bDFUVc2FsL4NwqOnPNh28GCy4ZX7fmg==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr26989257wrr.234.1566899394517;
        Tue, 27 Aug 2019 02:49:54 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id p10sm2450087wma.8.2019.08.27.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:49:53 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI/ACPI: Rename ACPI Hot Plug structs for Type 0, 1 and 2 from _HPP to _HPX
Date:   Tue, 27 Aug 2019 11:49:49 +0200
Message-Id: <20190827094951.10613-2-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190827094951.10613-1-kw@linux.com>
References: <20190827094951.10613-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The name of the following structs suggests that these are related to the
_HPP record type, whereas these are related to _HPX, not _HPP, that is
the structs hpp_type0, hpp_type1 and hpp_type2.

The struct hpp_type0 denotes an _HPX Type 0 setting record that supersedes
the _HPP setting record type, and has been used interchangeably for _HPP
as per the ACPI specification (see version 6.3, section 6.2.9.1) which
states that it should be applied to PCI, PCI-X and PCI Express devices,
with settings being ignored if they are not applicable.  There aren't any
Type 1 and Type 2 setting record types in _HPP, therefore structs hpp_type1
and hpp_type2 are renamed to reflect their relation to _HPX rather than
_HPP.

Any relevant variable names, structs and function names, etc., have been
updated to reflect the name change of the A CPI Hot Plug structs.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/pci-acpi.c      | 28 +++++++--------
 drivers/pci/probe.c         | 72 ++++++++++++++++++-------------------
 include/linux/pci_hotplug.h | 30 ++++++++--------
 3 files changed, 64 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 45049f558860..02addc47edae 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -119,7 +119,7 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 }
 
 static acpi_status decode_type0_hpx_record(union acpi_object *record,
-					   struct hpp_type0 *hpx0)
+					   struct hpx_type0 *hpx0)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -147,7 +147,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 }
 
 static acpi_status decode_type1_hpx_record(union acpi_object *record,
-					   struct hpp_type1 *hpx1)
+					   struct hpx_type1 *hpx1)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -174,7 +174,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 }
 
 static acpi_status decode_type2_hpx_record(union acpi_object *record,
-					   struct hpp_type2 *hpx2)
+					   struct hpx_type2 *hpx2)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -277,9 +277,9 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
 	acpi_status status;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *package, *record, *fields;
-	struct hpp_type0 hpx0;
-	struct hpp_type1 hpx1;
-	struct hpp_type2 hpx2;
+	struct hpx_type0 hpx0;
+	struct hpx_type1 hpx1;
+	struct hpx_type2 hpx2;
 	u32 type;
 	int i;
 
@@ -353,10 +353,10 @@ static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package, *fields;
-	struct hpp_type0 hpp0;
+	struct hpx_type0 hpx0;
 	int i;
 
-	memset(&hpp0, 0, sizeof(hpp0));
+	memset(&hpx0, 0, sizeof(hpx0));
 
 	status = acpi_evaluate_object(handle, "_HPP", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -377,13 +377,13 @@ static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
 		}
 	}
 
-	hpp0.revision        = 1;
-	hpp0.cache_line_size = fields[0].integer.value;
-	hpp0.latency_timer   = fields[1].integer.value;
-	hpp0.enable_serr     = fields[2].integer.value;
-	hpp0.enable_perr     = fields[3].integer.value;
+	hpx0.revision        = 1;
+	hpx0.cache_line_size = fields[0].integer.value;
+	hpx0.latency_timer   = fields[1].integer.value;
+	hpx0.enable_serr     = fields[2].integer.value;
+	hpx0.enable_perr     = fields[3].integer.value;
 
-	hp_ops->program_type0(dev, &hpp0);
+	hp_ops->program_type0(dev, &hpx0);
 
 exit:
 	kfree(buffer.pointer);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dbeeb385fb9f..33dae8f5e73e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1915,7 +1915,7 @@ static void pci_configure_mps(struct pci_dev *dev)
 		 p_mps, mps, mpss);
 }
 
-static struct hpp_type0 pci_default_type0 = {
+static struct hpx_type0 pci_default_type0 = {
 	.revision = 1,
 	.cache_line_size = 8,
 	.latency_timer = 0x40,
@@ -1923,44 +1923,44 @@ static struct hpp_type0 pci_default_type0 = {
 	.enable_perr = 0,
 };
 
-static void program_hpp_type0(struct pci_dev *dev, struct hpp_type0 *hpp)
+static void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
 {
 	u16 pci_cmd, pci_bctl;
 
-	if (!hpp)
-		hpp = &pci_default_type0;
+	if (!hpx)
+		hpx = &pci_default_type0;
 
-	if (hpp->revision > 1) {
+	if (hpx->revision > 1) {
 		pci_warn(dev, "PCI settings rev %d not supported; using defaults\n",
-			 hpp->revision);
-		hpp = &pci_default_type0;
+			 hpx->revision);
+		hpx = &pci_default_type0;
 	}
 
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpp->cache_line_size);
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpp->latency_timer);
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, hpx->cache_line_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, hpx->latency_timer);
 	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
-	if (hpp->enable_serr)
+	if (hpx->enable_serr)
 		pci_cmd |= PCI_COMMAND_SERR;
-	if (hpp->enable_perr)
+	if (hpx->enable_perr)
 		pci_cmd |= PCI_COMMAND_PARITY;
 	pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
 
 	/* Program bridge control value */
 	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
-				      hpp->latency_timer);
+				      hpx->latency_timer);
 		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
-		if (hpp->enable_perr)
+		if (hpx->enable_perr)
 			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
 		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
 	}
 }
 
-static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
+static void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx)
 {
 	int pos;
 
-	if (!hpp)
+	if (!hpx)
 		return;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
@@ -1985,20 +1985,20 @@ static bool pcie_root_rcb_set(struct pci_dev *dev)
 	return false;
 }
 
-static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
+static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 {
 	int pos;
 	u32 reg32;
 
-	if (!hpp)
+	if (!hpx)
 		return;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	if (hpp->revision > 1) {
+	if (hpx->revision > 1) {
 		pci_warn(dev, "PCIe settings rev %d not supported\n",
-			 hpp->revision);
+			 hpx->revision);
 		return;
 	}
 
@@ -2007,14 +2007,14 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 * those to make sure they're consistent with the rest of the
 	 * platform.
 	 */
-	hpp->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
+	hpx->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
 				    PCI_EXP_DEVCTL_READRQ;
-	hpp->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
+	hpx->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
 				    PCI_EXP_DEVCTL_READRQ);
 
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
-			~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or);
+			~hpx->pci_exp_devctl_and, hpx->pci_exp_devctl_or);
 
 	/* Initialize Link Control Register */
 	if (pcie_cap_has_lnkctl(dev)) {
@@ -2023,13 +2023,13 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 		 * If the Root Port supports Read Completion Boundary of
 		 * 128, set RCB to 128.  Otherwise, clear it.
 		 */
-		hpp->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
-		hpp->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
+		hpx->pci_exp_lnkctl_and |= PCI_EXP_LNKCTL_RCB;
+		hpx->pci_exp_lnkctl_or &= ~PCI_EXP_LNKCTL_RCB;
 		if (pcie_root_rcb_set(dev))
-			hpp->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
+			hpx->pci_exp_lnkctl_or |= PCI_EXP_LNKCTL_RCB;
 
 		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpp->pci_exp_lnkctl_and, hpp->pci_exp_lnkctl_or);
+			~hpx->pci_exp_lnkctl_and, hpx->pci_exp_lnkctl_or);
 	}
 
 	/* Find Advanced Error Reporting Enhanced Capability */
@@ -2039,22 +2039,22 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 
 	/* Initialize Uncorrectable Error Mask Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &reg32);
-	reg32 = (reg32 & hpp->unc_err_mask_and) | hpp->unc_err_mask_or;
+	reg32 = (reg32 & hpx->unc_err_mask_and) | hpx->unc_err_mask_or;
 	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, reg32);
 
 	/* Initialize Uncorrectable Error Severity Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &reg32);
-	reg32 = (reg32 & hpp->unc_err_sever_and) | hpp->unc_err_sever_or;
+	reg32 = (reg32 & hpx->unc_err_sever_and) | hpx->unc_err_sever_or;
 	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, reg32);
 
 	/* Initialize Correctable Error Mask Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &reg32);
-	reg32 = (reg32 & hpp->cor_err_mask_and) | hpp->cor_err_mask_or;
+	reg32 = (reg32 & hpx->cor_err_mask_and) | hpx->cor_err_mask_or;
 	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, reg32);
 
 	/* Initialize Advanced Error Capabilities and Control Register */
 	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
-	reg32 = (reg32 & hpp->adv_err_cap_and) | hpp->adv_err_cap_or;
+	reg32 = (reg32 & hpx->adv_err_cap_and) | hpx->adv_err_cap_or;
 
 	/* Don't enable ECRC generation or checking if unsupported */
 	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
@@ -2173,15 +2173,15 @@ static void program_hpx_type3_register(struct pci_dev *dev,
 		pos, orig_value, write_reg);
 }
 
-static void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx3)
+static void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx)
 {
-	if (!hpx3)
+	if (!hpx)
 		return;
 
 	if (!pci_is_pcie(dev))
 		return;
 
-	program_hpx_type3_register(dev, hpx3);
+	program_hpx_type3_register(dev, hpx);
 }
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
@@ -2365,9 +2365,9 @@ static void pci_configure_serr(struct pci_dev *dev)
 static void pci_configure_device(struct pci_dev *dev)
 {
 	static const struct hotplug_program_ops hp_ops = {
-		.program_type0 = program_hpp_type0,
-		.program_type1 = program_hpp_type1,
-		.program_type2 = program_hpp_type2,
+		.program_type0 = program_hpx_type0,
+		.program_type1 = program_hpx_type1,
+		.program_type2 = program_hpx_type2,
 		.program_type3 = program_hpx_type3,
 	};
 
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index f694eb2ca978..18fc6c7c3249 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -86,25 +86,25 @@ void pci_hp_deregister(struct hotplug_slot *slot);
 #define pci_hp_initialize(slot, bus, nr, name) \
 	__pci_hp_initialize(slot, bus, nr, name, THIS_MODULE, KBUILD_MODNAME)
 
-/* PCI Setting Record (Type 0) */
-struct hpp_type0 {
-	u32 revision;
-	u8  cache_line_size;
-	u8  latency_timer;
+/* _HPX PCI Setting Record (Type 0) */
+struct hpx_type0 {
+	u32 revision; /* Not present in _HPP */
+	u8  cache_line_size; /* Not applicable to PCI Express */
+	u8  latency_timer;   /* Not applicable to PCI Express */
 	u8  enable_serr;
 	u8  enable_perr;
 };
 
-/* PCI-X Setting Record (Type 1) */
-struct hpp_type1 {
+/* _HPX PCI-X Setting Record (Type 1) */
+struct hpx_type1 {
 	u32 revision;
 	u8  max_mem_read;
 	u8  avg_max_split;
 	u16 tot_max_split;
 };
 
-/* PCI Express Setting Record (Type 2) */
-struct hpp_type2 {
+/* _HPX PCI Express Setting Record (Type 2) */
+struct hpx_type2 {
 	u32 revision;
 	u32 unc_err_mask_and;
 	u32 unc_err_mask_or;
@@ -124,9 +124,7 @@ struct hpp_type2 {
 	u32 sec_unc_err_mask_or;
 };
 
-/*
- * _HPX PCI Express Setting Record (Type 3)
- */
+/* _HPX PCI Express Setting Record (Type 3) */
 struct hpx_type3 {
 	u16 device_type;
 	u16 function_type;
@@ -145,10 +143,10 @@ struct hpx_type3 {
 };
 
 struct hotplug_program_ops {
-	void (*program_type0)(struct pci_dev *dev, struct hpp_type0 *hpp);
-	void (*program_type1)(struct pci_dev *dev, struct hpp_type1 *hpp);
-	void (*program_type2)(struct pci_dev *dev, struct hpp_type2 *hpp);
-	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpp);
+	void (*program_type0)(struct pci_dev *dev, struct hpx_type0 *hpx);
+	void (*program_type1)(struct pci_dev *dev, struct hpx_type1 *hpx);
+	void (*program_type2)(struct pci_dev *dev, struct hpx_type2 *hpx);
+	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpx);
 };
 
 enum hpx_type3_dev_type {
-- 
2.22.1

