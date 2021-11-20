Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6104580E7
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 00:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhKTXUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 18:20:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:12787 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237132AbhKTXUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 18:20:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="221836102"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="221836102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 15:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="737913076"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2021 15:17:06 -0800
Received: from debox1-desk4.intel.com (dseghete-mobl.amr.corp.intel.com [10.209.30.58])
        by linux.intel.com (Postfix) with ESMTP id 1FFA2580C1F;
        Sat, 20 Nov 2021 15:17:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI: Add #defines for accessing PCIe DVSEC fields
Date:   Sat, 20 Nov 2021 15:17:02 -0800
Message-Id: <20211120231705.189969-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120231705.189969-1-david.e.box@linux.intel.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
in the Designated Vendor Specific Extended Capability (DVSEC). Defined
in PCIe r5.0, sec 7.9.6.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/uapi/linux/pci_regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ff6ccbc6efe9..318f3f1f9e92 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1086,7 +1086,11 @@
 
 /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
 #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
+#define  PCI_DVSEC_HEADER1_VID(x)	((x) & 0xffff)
+#define  PCI_DVSEC_HEADER1_REV(x)	(((x) >> 16) & 0xf)
+#define  PCI_DVSEC_HEADER1_LEN(x)	(((x) >> 20) & 0xfff)
 #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
+#define  PCI_DVSEC_HEADER2_ID(x)		((x) & 0xffff)
 
 /* Data Link Feature */
 #define PCI_DLF_CAP		0x04	/* Capabilities Register */
-- 
2.25.1

