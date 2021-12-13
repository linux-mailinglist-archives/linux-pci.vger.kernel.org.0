Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7476847335A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbhLMR72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 12:59:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:21829 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237144AbhLMR70 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 12:59:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226067272"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="226067272"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 09:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="613915237"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2021 09:59:25 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.243.203])
        by linux.intel.com (Postfix) with ESMTP id D7F35580C34;
        Mon, 13 Dec 2021 09:59:24 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 1/6] PCI: Add #defines for accessing PCIe DVSEC fields
Date:   Mon, 13 Dec 2021 09:59:16 -0800
Message-Id: <20211213175921.1897860-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213175921.1897860-1-david.e.box@linux.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
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
V3
  - No changes
V2
  - No changes

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

