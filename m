Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC41E629096
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 04:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiKODMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 22:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiKODLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 22:11:53 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D539F014
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 19:11:50 -0800 (PST)
X-ASG-Debug-ID: 1668481908-1eb14e7e6289900001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id QaNre0bD6YF8PyiC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 15 Nov 2022 11:11:48 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 15 Nov
 2022 11:11:48 +0800
Received: from localhost.localdomain (10.32.64.1) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 15 Nov
 2022 11:11:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
CC:     <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <ErosZhang@zhaoxin.com>, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH v2 1/5] ACPI/APEI: Add apei_hest_parse_aer()
Date:   Tue, 15 Nov 2022 11:11:43 +0800
X-ASG-Orig-Subj: [PATCH v2 1/5] ACPI/APEI: Add apei_hest_parse_aer()
Message-ID: <20221115031143.1666653-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1668481908
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7893
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0025 1.0000 -2.0046
X-Barracuda-Spam-Score: -2.00
X-Barracuda-Spam-Status: No, SCORE=-2.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.102147
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

apei_hest_parse_aer() is used to parse and extract register values
from HEST PCIe AER structures.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 115 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h    |  69 +++++++++++++++++++++++
 include/acpi/apei.h      |   7 +++
 3 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..ab1ffe6923ce 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -25,7 +25,7 @@
 #include <linux/platform_device.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
-
+#include <linux/pci.h>
 #include "apei-internal.h"
 
 #define HEST_PFX "HEST: "
@@ -86,7 +86,50 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 	return len;
 };
 
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
+{
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool hest_match_type(struct acpi_hest_header *hest_hdr,
+				struct pci_dev *dev)
+{
+	u16 hest_type = hest_hdr->type;
+	u8 pcie_type = pci_pcie_type(dev);
+
+	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
+		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
+		(hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
+		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
+		(hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
+		(pcie_type == PCI_EXP_TYPE_PCI_BRIDGE || pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE)))
+		return true;
+	return false;
+}
+
+static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
+		struct pci_dev *pci)
+{
+	return	ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
+			ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
+			p->device                 == PCI_SLOT(pci->devfn) &&
+			p->function               == PCI_FUNC(pci->devfn);
+}
+
+static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
+		struct acpi_hest_aer_common *p, struct pci_dev *pci)
+{
+	if (hest_match_type(hest_hdr, pci))
+		return hest_match_pci_devfn(p, pci);
+	return false;
+}
 
 static int apei_hest_parse(apei_hest_func_t func, void *data)
 {
@@ -124,6 +167,74 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 	return 0;
 }
 
+/*
+ * apei_hest_parse_aer - Find the AER structure in the HEST and
+ * match it with the PCIe device.
+ *
+ * @hest_hdr: To save the ACPI AER error source in HEST
+ *
+ * Return 1 if the PCIe dev matched with the ACPI AER error source in
+ * HEST, else return 0.
+ */
+int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct acpi_hest_parse_aer_info *info = data;
+	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint = NULL;
+	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port = NULL;
+	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge = NULL;
+
+	if (!hest_source_is_pcie_aer(hest_hdr))
+		return 0;
+
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		acpi_hest_aer_root_port = (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
+		if (acpi_hest_aer_root_port->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_root_port,
+					info->pci_dev)) {
+			info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
+			info->hest_matched_with_dev = 1;
+		}
+		break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		acpi_hest_aer_endpoint = (struct acpi_hest_aer_endpoint *)(hest_hdr + 1);
+		if (acpi_hest_aer_endpoint->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_endpoint,
+					info->pci_dev)) {
+			info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
+			info->hest_matched_with_dev = 1;
+		}
+		break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		acpi_hest_aer_for_bridge = (struct acpi_hest_aer_for_bridge *)(hest_hdr + 1);
+		if (acpi_hest_aer_for_bridge->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_for_bridge,
+					info->pci_dev)) {
+			info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
+			info->hest_matched_with_dev = 1;
+		}
+		break;
+	default:
+		break;
+	}
+	return info->hest_matched_with_dev;
+}
+
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
  * along with a set of MC banks which work in FF mode.
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15c78678c5d3..a3540133ddce 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1385,6 +1385,75 @@ struct acpi_hest_aer_bridge {
 	u32 advanced_capabilities2;
 };
 
+struct acpi_hest_parse_aer_info {
+	struct pci_dev *pci_dev;
+	int hest_matched_with_dev;
+	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint;
+	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port;
+	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge;
+};
+
+/* HEST Sub-structure for PCIe Root Port Structure (6) */
+
+struct acpi_hest_aer_root_port {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 root_error_command;
+};
+
+/* HEST Sub-structure for PCIe Endpoint Structure (7) */
+
+struct acpi_hest_aer_endpoint {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+};
+
+/* HEST Sub-structure for PCIe/PCI-X Bridge Structure (8) */
+
+struct acpi_hest_aer_for_bridge {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 uncorrectable_mask2;
+	u32 uncorrectable_severity2;
+	u32 advanced_capabilities2;
+};
+
 /* 9: Generic Hardware Error Source */
 
 struct acpi_hest_generic {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..8a0b2b9edbaf 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -33,10 +33,17 @@ void __init acpi_ghes_init(void);
 static inline void acpi_ghes_init(void) { }
 #endif
 
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	return -EINVAL;
+}
 #endif
 
 int erst_write(const struct cper_record_header *record);
-- 
2.20.1

