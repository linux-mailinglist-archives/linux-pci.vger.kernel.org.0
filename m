Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77C23ABE71
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhFQV5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:57:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:16700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhFQV5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:57:50 -0400
IronPort-SDR: OafdZrKb+fyKfhj7KUiWvgP/sPornXN6Zq8xeSXILFjNaqDC7z+kOQENE85PfXu7oGRUU6VfnW
 e/T9CGP6CmYw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270304154"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270304154"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:55:41 -0700
IronPort-SDR: d1uXucnokJUrcuWABapY2QjkyjrWrPwJ7s8SmCO4bblp/x7EeVu6OcS7cbn6ZRBkXNSqAh5w1n
 ZBe8YX7oYxGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="488810896"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2021 14:55:40 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id B0DFF5801A3;
        Thu, 17 Jun 2021 14:55:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI: Add #defines for accessing PCIE DVSEC fields
Date:   Thu, 17 Jun 2021 14:54:05 -0700
Message-Id: <20210617215408.1412409-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617215408.1412409-1-david.e.box@linux.intel.com>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
in the Designated Vendor Specific Extended Capability (DVSEC). Defined
in PCIe r5.0, sec 7.9.6.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 include/uapi/linux/pci_regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8235e7..57ee51f19283 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1080,7 +1080,11 @@
 
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

