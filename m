Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973CA1A1921
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 02:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDHAKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Apr 2020 20:10:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:8224 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgDHAKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 20:10:09 -0400
IronPort-SDR: cDTWFH5AK4+FODzogG5JQkdWUVRqdZt946vmKPzc+8bcA2pvgW2chYRvEMEFTrY6nwc2tg1OLm
 2b9UmUINhxFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:10:06 -0700
IronPort-SDR: gUcFTAgL9qLX+4pxAX7P0v+v2/iV1tkUDiCE83PSkn6BuMgORIiY5Fpx+o3lVDN3yJDLvLBtw6
 3iH8KNEuyAbA==
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="251425637"
Received: from vkippes-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.134.96.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:10:04 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [RFC Patch 1/1] lspci: Add basic decode support for Compute eXpress Link
Date:   Tue,  7 Apr 2020 17:09:59 -0700
Message-Id: <20200408000959.230780-2-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408000959.230780-1-sean.v.kelley@linux.intel.com>
References: <20200408000959.230780-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compute eXpress Link[1] is a new CPU interconnected created with
workload accelerators in mind. The interconnect relies on PCIe Electrial
and Physical interconnect for communication.

Moreover, CXL bus hierarchy appear, to the OS, as an ACPI-described PCIe
Root Bridge with Integrated Endpoint.

This patch introduces basic support for lspci decode for DVSEC CXL
extended capability.

[1] https://www.computeexpresslink.org/

Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 lib/header.h        | 25 +++++++++++++++++++++++++
 ls-ecaps.c          | 29 ++++++++++++++++++++++++++++-
 tests/cap-cxl-dvsec |  8 ++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-cxl-dvsec

diff --git a/lib/header.h b/lib/header.h
index bfdcc80..421612d 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1042,6 +1042,27 @@
 #define PCI_EVNDR_HEADER	4	/* Vendor-Specific Header */
 #define PCI_EVNDR_REGISTERS	8	/* Vendor-Specific Registers */
 
+/* PCIe CXL Vendor-Specific Capabilities, Control, Status */
+#define PCI_EVNDR_CXL_ID	0
+
+#define PCI_CXL_CAP		0x0a
+#define  PCI_CXL_CAP_CACHE	0x0001
+#define  PCI_CXL_CAP_IO		0x0002
+#define  PCI_CXL_CAP_MEM	0x0004
+#define  PCI_CXL_CAP_MEM_HWINIT	0x0008
+#define  PCI_CXL_CAP_HDM_CNT(x)	(((x) & (3 << 4)) >> 4)
+#define  PCI_CXL_CAP_VIRAL	0x4000
+#define PCI_CXL_CTRL		0x0c
+#define  PCI_CXL_CTRL_CACHE	0x0001
+#define  PCI_CXL_CTRL_IO	0x0002
+#define  PCI_CXL_CTRL_MEM	0x0004
+#define  PCI_CXL_CTRL_CACHE_SF_COV(x)	(((x) & (0x1f << 3)) >> 3)
+#define  PCI_CXL_CTRL_CACHE_SF_GRAN(x)	(((x) & (0x7 << 8)) >> 8)
+#define  PCI_CXL_CTRL_CACHE_CLN	0x0800
+#define  PCI_CXL_CTRL_VIRAL	0x4000
+#define PCI_CXL_STATUS		0x0e
+#define  PCI_CXL_STATUS_VIRAL	0x4000
+
 /* Access Control Services */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
 #define PCI_ACS_CAP_VALID	0x0001	/* ACS Source Validation */
@@ -1348,6 +1369,10 @@
 #define PCI_CLASS_SIGNAL_SYNCHRONIZER	0x1110
 #define PCI_CLASS_SIGNAL_OTHER		0x1180
 
+#define PCI_CLASS_CXL			0x14
+#define PCI_CLASS_CXL_RCIEP		0x1400
+#define PCI_CLASS_CXL_OTHER		0x1480
+
 #define PCI_CLASS_OTHERS		0xff
 
 /* Several ID's we need in the library */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 0021734..8c09517 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -207,6 +207,33 @@ cap_aer(struct device *d, int where, int type)
     }
 }
 
+static void
+cap_cxl(struct device *d, int where)
+{
+  u16 l;
+
+  printf("PCIe DVSEC for CXL Device\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_CXL_CAP, 12))
+    return;
+
+  l = get_conf_word(d, where + PCI_CXL_CAP);
+  printf("\t\tCXLCap:\tCache%c IO%c Mem%c Mem HW Init%c HDMCount %d Viral%c\n",
+    FLAG(l, PCI_CXL_CAP_CACHE), FLAG(l, PCI_CXL_CAP_IO), FLAG(l, PCI_CXL_CAP_MEM),
+    FLAG(l, PCI_CXL_CAP_MEM_HWINIT), PCI_CXL_CAP_HDM_CNT(l), FLAG(l, PCI_CXL_CAP_VIRAL));
+
+  l = get_conf_word(d, where + PCI_CXL_CTRL);
+  printf("\t\tCXLCtl:\tCache%c IO%c Mem%c Cache SF Cov %d Cache SF Gran %d Cache Clean%c Viral%c\n",
+    FLAG(l, PCI_CXL_CTRL_CACHE), FLAG(l, PCI_CXL_CTRL_IO), FLAG(l, PCI_CXL_CTRL_MEM),
+    PCI_CXL_CTRL_CACHE_SF_COV(l), PCI_CXL_CTRL_CACHE_SF_GRAN(l), FLAG(l, PCI_CXL_CTRL_CACHE_CLN),
+    FLAG(l, PCI_CXL_CTRL_VIRAL));
+
+  l = get_conf_word(d, where + PCI_CXL_STATUS);
+  printf("\t\tCXLSta:\tViral%c\n", FLAG(l, PCI_CXL_STATUS_VIRAL));
+}
+
 static void cap_dpc(struct device *d, int where)
 {
   u16 l;
@@ -924,7 +951,7 @@ show_ext_caps(struct device *d, int type)
 	    printf("Readiness Time Reporting <?>\n");
 	    break;
 	  case PCI_EXT_CAP_ID_DVSEC:
-	    printf("Designated Vendor-Specific <?>\n");
+	    cap_cxl(d, where);
 	    break;
 	  case PCI_EXT_CAP_ID_VF_REBAR:
 	    printf("VF Resizable BAR <?>\n");
diff --git a/tests/cap-cxl-dvsec b/tests/cap-cxl-dvsec
new file mode 100644
index 0000000..14e1022
--- /dev/null
+++ b/tests/cap-cxl-dvsec
@@ -0,0 +1,8 @@
+Simple diff of lspci -vvxxxx
+
+<       Capabilities: [e00 v1] Designated Vendor-Specific <?>
+---
+>       Capabilities: [e00 v1] PCIe DVSEC for CXL Device
+>               CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
+>               CXLCtl: Cache- IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
+>               CXLSta: Viral-
-- 
2.26.0

