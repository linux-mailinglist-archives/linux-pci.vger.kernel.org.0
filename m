Return-Path: <linux-pci+bounces-18135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA89ECDA6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21812815D3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8452226186;
	Wed, 11 Dec 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv5NfAL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4E381AA
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924945; cv=none; b=gJE67aJbECskZHp/rtmiIlFDVTJAyKUcj5tXokggmvsmrUPpwVBGv518Ota/TdYmtcW1wzfEVOH+JEKEASKjsEO5B900JwTBV+L4Y+vOqE4iwFOh/lj/iPXVPqybWBT3x2MqsX7vFnrirehrvtDf4z1OEnrB/QtcS9yIWly/2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924945; c=relaxed/simple;
	bh=XZglEAqwZn8iHmOkxITvWpVCe0lW7ip4VCDtuN3tGS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVdBZePXihOxO55ujb9YfX+J0hStB8h+CMBRiDEN5jnXTp+HRR4QnS9acxGwmQVZcFEoExeWhcCczyto1QlaTp8Rp6aFah1wqU4ZhjwViTe6y5mwo7iiEHhriyAtPJNuy32prp/MLCVQV92eRUGFeVvf5bTyaJlkitZcsbATCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv5NfAL/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733924944; x=1765460944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZglEAqwZn8iHmOkxITvWpVCe0lW7ip4VCDtuN3tGS8=;
  b=kv5NfAL/WoGmCn6wPTxuenOmGNY5mPzbxnkUHnN+sANL0uf0fYKoJqjf
   RLBGVbHh8VL+/Xx0jjJPlMKb32TBPy6A5mSfSG/U9gX56vlfhVAq1XweZ
   JZSO6DWCfiuCo1kOjtEp6qLY9iBN/ZGUO2nCqawnTAarUH9vQeqxRGumt
   T7K6WuOn4jv+CkHryteG8x+7NIOCTJLb/rrsskRck9sbT8JY7o64rwgNm
   isozsWYW2YZOGq+qyQK8JEZExoIDI6KMjQGO6MVSbtny2srZuDikwhGa1
   JZD/AIQBAiOAPHz+qp+Z/KZAYldUXRx0zqMrI+QVTm/mtTu3Fkk7FfH4G
   g==;
X-CSE-ConnectionGUID: GNDGxmsyT/SrsJAbNX17mg==
X-CSE-MsgGUID: m9lNbd8KR9ug/rSuFkXO8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37139078"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="37139078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:49:04 -0800
X-CSE-ConnectionGUID: Ccvtu0aNSUO8yJek/FHSHQ==
X-CSE-MsgGUID: PDu/Nb73RX+RG9mpv9Z85A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95514152"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 05:49:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] lspci: Add Dev3 Extended Capability
Date: Wed, 11 Dec 2024 15:48:40 +0200
Message-Id: <20241211134840.3375-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211134840.3375-1-ilpo.jarvinen@linux.intel.com>
References: <20241211134840.3375-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Dev3 Extended Capability (PCIe spec r6.1 sec 7.7.9).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 lib/header.h | 20 ++++++++++++++++++++
 ls-caps.c    |  4 +++-
 ls-ecaps.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
 lspci.h      |  2 +-
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index b188313ea033..bb36ea1deeea 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -256,6 +256,7 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_32GT	0x2a	/* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2e	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_DEV3	0x2f	/* Device 3 */
 #define PCI_EXT_CAP_ID_IDE	0x30	/* Integrity and Data Encryption */
 
 /*** Definitions of capabilities ***/
@@ -1501,6 +1502,25 @@
 /* IDE Address Association Register 2 is "Memory Limit Upper" */
 /* IDE Address Association Register 3 is "Memory Base Upper" */
 
+/* Device 3 Extended Capability */
+#define PCI_DEV3_DEVCAP3	0x4		/* Device Capabilities 3 Register */
+#define  PCI_DEV3_DEVCAP3_DMWR_REQ_ROUTING		0x1	/* DMWr Request Routing Support */
+#define  PCI_DEV3_DEVCAP3_14BIT_TAG_COMP		0x2	/* 14-Bit Tag Completer Support */
+#define  PCI_DEV3_DEVCAP3_14BIT_TAG_REQ			0x4	/* 14-Bit Tag Requester Support */
+#define  PCI_DEV3_DEVCAP3_L0P				0x8	/* L0p Support */
+#define  PCI_DEV3_DEVCAP3_PORT_L0P_EXIT			0x070	/* Port L0p Exit Latency */
+#define  PCI_DEV3_DEVCAP3_RETIMER_L0P_EXIT		0x380	/* Retimer L0p Exit Latency */
+#define PCI_DEV3_DEVCTL3	0x8		/* Device Control 3 Register */
+#define  PCI_DEV3_DEVCTL3_DMWR_REQ			0x1	/* DMWr Requester Enable */
+#define  PCI_DEV3_DEVCTL3_DMWR_EGRESS_BLOCK		0x2	/* DMWr Egress Blocking */
+#define  PCI_DEV3_DEVCTL3_14BIT_TAG_REQ			0x4	/* 14-Bit Tag Requester Enable */
+#define  PCI_DEV3_DEVCTL3_L0P				0x8	/* L0p Enable */
+#define  PCI_DEV3_DEVCTL3_TLW				0x70	/* Target Link Width */
+#define PCI_DEV3_DEVSTA3	0xC	/* Device Status 3 Register */
+#define  PCI_DEV3_DEVSTA3_ILW				0x7	/* Initial Link Width */
+#define  PCI_DEV3_DEVSTA3_SEG_CAPT			0x8	/* Segment Captured */
+#define  PCI_DEV3_DEVSTA3_REMOTE_L0P			0x10	/* Remote L0p Support */
+
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
diff --git a/ls-caps.c b/ls-caps.c
index 38a171a5fe4d..d9632b1d3a8e 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1798,6 +1798,7 @@ void
 show_caps(struct device *d, int where)
 {
   int can_have_ext_caps = 0;
+  u16 pci_exp_cap = 0;
   int type = -1;
 
   if (get_conf_word(d, PCI_STATUS) & PCI_STATUS_CAP_LIST)
@@ -1882,6 +1883,7 @@ show_caps(struct device *d, int where)
 	    case PCI_CAP_ID_EXP:
 	      type = cap_express(d, where, cap);
 	      can_have_ext_caps = 1;
+	      pci_exp_cap = cap;
 	      break;
 	    case PCI_CAP_ID_MSIX:
 	      cap_msix(d, where, cap);
@@ -1902,5 +1904,5 @@ show_caps(struct device *d, int where)
 	}
     }
   if (can_have_ext_caps)
-    show_ext_caps(d, type);
+    show_ext_caps(d, type, pci_exp_cap);
 }
diff --git a/ls-ecaps.c b/ls-ecaps.c
index e817180889c2..d2aa3c5efd92 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -1704,8 +1704,44 @@ cap_ide(struct device *d, int where)
       }
 }
 
+static void
+cap_dev3(struct device *d, int where, u16 pci_exp_cap)
+{
+  const char *tlw[] = { "x1", "x2", "x4", "x8", "x16", "unknown", "unknown", "dynamic" };
+  u32 cap3, ctrl3, sta3;
+  u32 sta3_width;
+  printf("Device 3\n");
+  if (verbose < 2)
+    return;
+
+  if (!config_fetch(d, where + PCI_DEV3_DEVCAP3, 12))
+    return;
+
+  cap3 = get_conf_word(d, where + PCI_DEV3_DEVCAP3);
+  printf("\t\tDevCap3: DMWrReqRouting%c 14BitTagReq%c 14BitTagComp%c L0p%c\n",
+      FLAG(cap3, PCI_DEV3_DEVCAP3_DMWR_REQ_ROUTING),
+      FLAG(cap3, PCI_DEV3_DEVCAP3_14BIT_TAG_COMP),
+      FLAG(cap3, PCI_DEV3_DEVCAP3_14BIT_TAG_REQ),
+      FLAG(cap3, PCI_DEV3_DEVCAP3_L0P));
+  ctrl3 = get_conf_word(d, where + PCI_DEV3_DEVCTL3);
+  printf("\t\tDevCtl3: DMWrReqEn%c DMWrEgressBlck%c 14BitTagReqEn%c L0pEn%c\n",
+      FLAG(ctrl3, PCI_DEV3_DEVCTL3_DMWR_REQ),
+      FLAG(ctrl3, PCI_DEV3_DEVCTL3_DMWR_EGRESS_BLOCK),
+      FLAG(ctrl3, PCI_DEV3_DEVCTL3_14BIT_TAG_REQ),
+      FLAG(ctrl3, PCI_DEV3_DEVCTL3_L0P));
+  if (pci_exp_cap & PCI_EXP_FLAGS_FLIT)
+    printf("\t\t\t Target Link Width: %s\n",
+	   tlw[(ctrl3 & PCI_DEV3_DEVCTL3_TLW) >> 4]);
+  sta3 = get_conf_word(d, where + PCI_DEV3_DEVSTA3);
+  sta3_width = 1 << (sta3 & PCI_DEV3_DEVSTA3_ILW);
+  printf("\t\tDevSta3: Initial Link Width: x%u, SegCapture%c RemoteL0p%c\n",
+      sta3_width,
+      FLAG(sta3, PCI_DEV3_DEVSTA3_SEG_CAPT),
+      FLAG(sta3, PCI_DEV3_DEVSTA3_REMOTE_L0P));
+}
+
 void
-show_ext_caps(struct device *d, int type)
+show_ext_caps(struct device *d, int type, u16 pci_exp_cap)
 {
   int where = 0x100;
   char been_there[0x1000];
@@ -1860,6 +1896,9 @@ show_ext_caps(struct device *d, int type)
 	  case PCI_EXT_CAP_ID_IDE:
 	    cap_ide(d, where);
 	    break;
+	  case PCI_EXT_CAP_ID_DEV3:
+	    cap_dev3(d, where, pci_exp_cap);
+	    break;
 	  default:
 	    printf("Extended Capability ID %#02x\n", id);
 	    break;
diff --git a/lspci.h b/lspci.h
index 4d711a555d65..96f46722b2ef 100644
--- a/lspci.h
+++ b/lspci.h
@@ -68,7 +68,7 @@ void show_caps(struct device *d, int where);
 
 /* ls-ecaps.c */
 
-void show_ext_caps(struct device *d, int type);
+void show_ext_caps(struct device *d, int type, u16 pci_exp_cap);
 
 /* ls-caps-vendor.c */
 
-- 
2.39.5


