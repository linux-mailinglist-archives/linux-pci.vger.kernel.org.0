Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F119E4CB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfH0JuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 05:50:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfH0JuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 05:50:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so18133011wrt.4;
        Tue, 27 Aug 2019 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9OAwGBwoNjWHikis+gMw0Oi0fog8QmNv1hym0HD4Ts=;
        b=qts/GHwD3Qtv9+bEUCt7ddw4tGUYPAS04eMtUqDNvtU9E9zle5OlyR9dybfP7ohq2e
         jNoU75fmQ5FTn2Op+JF4D2/wXIv7L/of/CcopkmJJhrrCu05HLdREGhN5C4xxj9u/i3E
         gPRR5BHVXvb/fnoV3MIiCfgXXFmVpCQtZAbyqv0GQf9yMhE+n1JTzxs/hFdJDhlJMO+R
         JrRE4lsOWprVIUsZ3kJpSGk/9Kcp76B3KqHIP1pOUu8hTjBCKV62FMt/AgeA/3MB+JvE
         LB3tPtKPYg6KoL57Jt1qsHyzDeuI2tYFzENklQx/bRMJx/0e0ArfkFuNMg+d8CPEx9Ur
         63xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=B9OAwGBwoNjWHikis+gMw0Oi0fog8QmNv1hym0HD4Ts=;
        b=TnvBVsc/x55xx67j3K8SyCaZjdVaw5XSl+ScYSAHGbXZoEEStRMUWgIFtX0/QO9CMW
         E6X3U4PSNz4eCZaf61Cc54N5htfp9vbbPcr7pgiY93n75oUTT+t/Ramd3nCqE8Vt1/F6
         JKrTGhAcb4qOcyGRLCiN3IKuh34IJclnfkYTLrJNGIyj8LOeBDa3GFebPdmihtSP+4kD
         NSeFfqftl8/rCCFXkPWwHiAoDqQcqJWWN42kq9P7eA1l4GK1PJggQ3QJJtoZdEh+c6ms
         fw04739YE+M+u3XJpXpAqjat2BGkrfSlO6TFfLLJ+/vHx4nLZoX6a77y1Y3CcwqywFsu
         OlNA==
X-Gm-Message-State: APjAAAXIf/ljDvIHjpLArnNEmLvCNDliT6An01VhbBOuao/4txGMjQvB
        daKHIDrfcE0BqhikUrEai2E=
X-Google-Smtp-Source: APXvYqypJr5fZBPeobkRfqtw3e95pPNszzEwpDTtdd5AZOgBxt6gQuH2Z8sKVcSSCSe+S7WOGGKsYw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr27913720wrh.298.1566899397061;
        Tue, 27 Aug 2019 02:49:57 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id p10sm2450087wma.8.2019.08.27.02.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:49:55 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI/ACPI: Remove unnecessary struct hotplug_program_ops from pci-acpi.c
Date:   Tue, 27 Aug 2019 11:49:51 +0200
Message-Id: <20190827094951.10613-4-kw@linux.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190827094951.10613-1-kw@linux.com>
References: <20190827094951.10613-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the ACPI-specific structs hpx_type0, hpx_type1, hpx_type2 and
hpx_type3 to drivers/pci/pci-acpi.c as they are not used anywhere
else.  Then remove the struct hotplug_program_ops that has been
shared between drivers/pci/probe.c and drivers/pci/pci-acpi.c
from drivers/pci/pci.h as it is no longer needed.

The struct hotplug_program_ops was introduced in the commit 87fcf12e846a
("PCI/ACPI: Remove the need for 'struct hotplug_params'") and replaced
previously used struct hotplug_params enabling the support for the _HPX
Type 3 Setting Record that has been added in the commit f873c51a155a
("PCI/ACPI: Implement _HPX Type 3 Setting Record").

The new struct allowed for the static functions such program_hpx_type0(),
program_hpx_type1(), etc., from the drivers/pci/probe.c to be called from
the function pci_acpi_program_hp_params() in the drivers/pci/pci-acpi.c.

Currently, a programming of _HPX Type 0 would be as follows:

drivers/pci/probe.c:

  program_hpx_type0()
  ...
  pci_configure_device()
    hp_ops = {
      .program_type0 = program_hpx_type0,
      ...
    }
    pci_acpi_program_hp_params(&hp_ops)

drivers/pci/pci-acpi.c:

  pci_acpi_program_hp_params(&hp_ops)
    acpi_run_hpx(hp_ops)
      decode_type0_hpx_record()
        hp_ops->program_type0 # program_hpx_type0() called via hp_ops

After the ACPI-specific functions, structs, enums, etc., have been
moved to drivers/pci/pci-acpi.c there will be no need to keep using
the struct hotplug_program_ops as all of the _HPX Type 0, 1, 2 and 3
would be directly accessible.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/pci-acpi.c | 96 ++++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h      | 74 +-------------------------------
 drivers/pci/probe.c    |  9 +---
 3 files changed, 77 insertions(+), 102 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0bfabb3f9931..c476b9ed009e 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -118,6 +118,15 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 	return (phys_addr_t)mcfg_addr;
 }
 
+/* _HPX PCI Setting Record (Type 0) */
+struct hpx_type0 {
+	u32 revision; /* Not present in _HPP */
+	u8  cache_line_size; /* Not applicable to PCI Express */
+	u8  latency_timer;   /* Not applicable to PCI Express */
+	u8  enable_serr;
+	u8  enable_perr;
+};
+
 static struct hpx_type0 pci_default_type0 = {
 	.revision = 1,
 	.cache_line_size = 8,
@@ -126,7 +135,7 @@ static struct hpx_type0 pci_default_type0 = {
 	.enable_perr = 0,
 };
 
-void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
+static void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx)
 {
 	u16 pci_cmd, pci_bctl;
 
@@ -187,7 +196,15 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx)
+/* _HPX PCI-X Setting Record (Type 1) */
+struct hpx_type1 {
+	u32 revision;
+	u8  max_mem_read;
+	u8  avg_max_split;
+	u16 tot_max_split;
+};
+
+static void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx)
 {
 	int pos;
 
@@ -243,7 +260,28 @@ static bool pcie_root_rcb_set(struct pci_dev *dev)
 	return false;
 }
 
-void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
+/* _HPX PCI Express Setting Record (Type 2) */
+struct hpx_type2 {
+	u32 revision;
+	u32 unc_err_mask_and;
+	u32 unc_err_mask_or;
+	u32 unc_err_sever_and;
+	u32 unc_err_sever_or;
+	u32 cor_err_mask_and;
+	u32 cor_err_mask_or;
+	u32 adv_err_cap_and;
+	u32 adv_err_cap_or;
+	u16 pci_exp_devctl_and;
+	u16 pci_exp_devctl_or;
+	u16 pci_exp_lnkctl_and;
+	u16 pci_exp_lnkctl_or;
+	u32 sec_unc_err_sever_and;
+	u32 sec_unc_err_sever_or;
+	u32 sec_unc_err_mask_and;
+	u32 sec_unc_err_mask_or;
+};
+
+static void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx)
 {
 	int pos;
 	u32 reg32;
@@ -369,6 +407,24 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+/* _HPX PCI Express Setting Record (Type 3) */
+struct hpx_type3 {
+	u16 device_type;
+	u16 function_type;
+	u16 config_space_location;
+	u16 pci_exp_cap_id;
+	u16 pci_exp_cap_ver;
+	u16 pci_exp_vendor_id;
+	u16 dvsec_id;
+	u16 dvsec_rev;
+	u16 match_offset;
+	u32 match_mask_and;
+	u32 match_value;
+	u16 reg_offset;
+	u32 reg_mask_and;
+	u32 reg_mask_or;
+};
+
 enum hpx_type3_dev_type {
 	HPX_TYPE_ENDPOINT	= BIT(0),
 	HPX_TYPE_LEG_END	= BIT(1),
@@ -498,7 +554,7 @@ static void program_hpx_type3_register(struct pci_dev *dev,
 		pos, orig_value, write_reg);
 }
 
-void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx)
+static void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx)
 {
 	if (!hpx)
 		return;
@@ -529,8 +585,7 @@ static void parse_hpx3_register(struct hpx_type3 *hpx3_reg,
 }
 
 static acpi_status program_type3_hpx_record(struct pci_dev *dev,
-					   union acpi_object *record,
-					   const struct hotplug_program_ops *hp_ops)
+					   union acpi_object *record)
 {
 	union acpi_object *fields = record->package.elements;
 	u32 desc_count, expected_length, revision;
@@ -554,7 +609,7 @@ static acpi_status program_type3_hpx_record(struct pci_dev *dev,
 		for (i = 0; i < desc_count; i++) {
 			reg_fields = fields + 3 + i * 14;
 			parse_hpx3_register(&hpx3, reg_fields);
-			hp_ops->program_type3(dev, &hpx3);
+			program_hpx_type3(dev, &hpx3);
 		}
 
 		break;
@@ -567,8 +622,7 @@ static acpi_status program_type3_hpx_record(struct pci_dev *dev,
 	return AE_OK;
 }
 
-static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
-				const struct hotplug_program_ops *hp_ops)
+static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -610,24 +664,24 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
 			status = decode_type0_hpx_record(record, &hpx0);
 			if (ACPI_FAILURE(status))
 				goto exit;
-			hp_ops->program_type0(dev, &hpx0);
+			program_hpx_type0(dev, &hpx0);
 			break;
 		case 1:
 			memset(&hpx1, 0, sizeof(hpx1));
 			status = decode_type1_hpx_record(record, &hpx1);
 			if (ACPI_FAILURE(status))
 				goto exit;
-			hp_ops->program_type1(dev, &hpx1);
+			program_hpx_type1(dev, &hpx1);
 			break;
 		case 2:
 			memset(&hpx2, 0, sizeof(hpx2));
 			status = decode_type2_hpx_record(record, &hpx2);
 			if (ACPI_FAILURE(status))
 				goto exit;
-			hp_ops->program_type2(dev, &hpx2);
+			program_hpx_type2(dev, &hpx2);
 			break;
 		case 3:
-			status = program_type3_hpx_record(dev, record, hp_ops);
+			status = program_type3_hpx_record(dev, record);
 			if (ACPI_FAILURE(status))
 				goto exit;
 			break;
@@ -643,8 +697,7 @@ static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
 	return status;
 }
 
-static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
-				const struct hotplug_program_ops *hp_ops)
+static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -679,20 +732,18 @@ static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
 	hpx0.enable_serr     = fields[2].integer.value;
 	hpx0.enable_perr     = fields[3].integer.value;
 
-	hp_ops->program_type0(dev, &hpx0);
+	program_hpx_type0(dev, &hpx0);
 
 exit:
 	kfree(buffer.pointer);
 	return status;
 }
 
-/* pci_get_hp_params
+/* pci_acpi_program_hp_params
  *
  * @dev - the pci_dev for which we want parameters
- * @hpp - allocated by the caller
  */
-int pci_acpi_program_hp_params(struct pci_dev *dev,
-			       const struct hotplug_program_ops *hp_ops)
+int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	acpi_status status;
 	acpi_handle handle, phandle;
@@ -715,10 +766,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev,
 	 * this pci dev.
 	 */
 	while (handle) {
-		status = acpi_run_hpx(dev, handle, hp_ops);
+		status = acpi_run_hpx(dev, handle);
 		if (ACPI_SUCCESS(status))
 			return 0;
-		status = acpi_run_hpp(dev, handle, hp_ops);
+		status = acpi_run_hpp(dev, handle);
 		if (ACPI_SUCCESS(status))
 			return 0;
 		if (acpi_is_root_bridge(handle))
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -649,80 +649,10 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
 #endif
 
-/* _HPX PCI Setting Record (Type 0) */
-struct hpx_type0 {
-	u32 revision; /* Not present in _HPP */
-	u8  cache_line_size; /* Not applicable to PCI Express */
-	u8  latency_timer;   /* Not applicable to PCI Express */
-	u8  enable_serr;
-	u8  enable_perr;
-};
-
-/* _HPX PCI-X Setting Record (Type 1) */
-struct hpx_type1 {
-	u32 revision;
-	u8  max_mem_read;
-	u8  avg_max_split;
-	u16 tot_max_split;
-};
-
-/* _HPX PCI Express Setting Record (Type 2) */
-struct hpx_type2 {
-	u32 revision;
-	u32 unc_err_mask_and;
-	u32 unc_err_mask_or;
-	u32 unc_err_sever_and;
-	u32 unc_err_sever_or;
-	u32 cor_err_mask_and;
-	u32 cor_err_mask_or;
-	u32 adv_err_cap_and;
-	u32 adv_err_cap_or;
-	u16 pci_exp_devctl_and;
-	u16 pci_exp_devctl_or;
-	u16 pci_exp_lnkctl_and;
-	u16 pci_exp_lnkctl_or;
-	u32 sec_unc_err_sever_and;
-	u32 sec_unc_err_sever_or;
-	u32 sec_unc_err_mask_and;
-	u32 sec_unc_err_mask_or;
-};
-
-/* _HPX PCI Express Setting Record (Type 3) */
-struct hpx_type3 {
-	u16 device_type;
-	u16 function_type;
-	u16 config_space_location;
-	u16 pci_exp_cap_id;
-	u16 pci_exp_cap_ver;
-	u16 pci_exp_vendor_id;
-	u16 dvsec_id;
-	u16 dvsec_rev;
-	u16 match_offset;
-	u32 match_mask_and;
-	u32 match_value;
-	u16 reg_offset;
-	u32 reg_mask_and;
-	u32 reg_mask_or;
-};
-
-void program_hpx_type0(struct pci_dev *dev, struct hpx_type0 *hpx);
-void program_hpx_type1(struct pci_dev *dev, struct hpx_type1 *hpx);
-void program_hpx_type2(struct pci_dev *dev, struct hpx_type2 *hpx);
-void program_hpx_type3(struct pci_dev *dev, struct hpx_type3 *hpx);
-
-struct hotplug_program_ops {
-	void (*program_type0)(struct pci_dev *dev, struct hpx_type0 *hpx);
-	void (*program_type1)(struct pci_dev *dev, struct hpx_type1 *hpx);
-	void (*program_type2)(struct pci_dev *dev, struct hpx_type2 *hpx);
-	void (*program_type3)(struct pci_dev *dev, struct hpx_type3 *hpx);
-};
-
 #ifdef CONFIG_ACPI
-int pci_acpi_program_hp_params(struct pci_dev *dev,
-			       const struct hotplug_program_ops *hp_ops);
+int pci_acpi_program_hp_params(struct pci_dev *dev);
 #else
-static inline int pci_acpi_program_hp_params(struct pci_dev *dev,
-				    const struct hotplug_program_ops *hp_ops)
+static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2095,13 +2095,6 @@ static void pci_configure_serr(struct pci_dev *dev)
 
 static void pci_configure_device(struct pci_dev *dev)
 {
-	static const struct hotplug_program_ops hp_ops = {
-		.program_type0 = program_hpx_type0,
-		.program_type1 = program_hpx_type1,
-		.program_type2 = program_hpx_type2,
-		.program_type3 = program_hpx_type3,
-	};
-
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
@@ -2109,7 +2102,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
 
-	pci_acpi_program_hp_params(dev, &hp_ops);
+	pci_acpi_program_hp_params(dev);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
-- 
2.22.1

