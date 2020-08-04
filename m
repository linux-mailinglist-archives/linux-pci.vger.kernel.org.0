Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0A23C02E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHDTlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 15:41:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:29261 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgHDTlE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 15:41:04 -0400
IronPort-SDR: iWOw+dNoMUMQGZS8UzErNg0cbEoLo3ThZqOO34UH5ubWwUH76P/eArjtMwwLWxc8QVpqOS0x2M
 6cXsj+evZXOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="139991089"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="139991089"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:04 -0700
IronPort-SDR: 0o+Z6doTjfr4NKPokwycz/HNBv3/ux+4RTqavSWoDWgGHwItObTrBxcy1FJ/SRslSqQWvaHfdN
 DMymbwFDMsNw==
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="467199220"
Received: from viveksh1-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.83.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 12:41:04 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH V2 1/9] pci_ids: Add class code and extended capability for RCEC
Date:   Tue,  4 Aug 2020 12:40:44 -0700
Message-Id: <20200804194052.193272-2-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200804194052.193272-1-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A PCIe Root Complex Event Collector(RCEC) has the base class 0x08,
sub-class 0x07, and programming interface 0x00. Add the class code
0x0807 to identify RCEC devices and add the defines for the RCEC
Endpoint Association Extended Capability.

See PCI Express Base Specification, version 5.0-1, section "1.3.4
Root Complex Event Collector" and section "7.9.10 Root Complex
Event Collector Endpoint Association Extended Capability"

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h       | 1 +
 include/uapi/linux/pci_regs.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5c709a1450b1..bc6d1a4ca02d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -81,6 +81,7 @@
 #define PCI_CLASS_SYSTEM_RTC		0x0803
 #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
 #define PCI_CLASS_SYSTEM_SDHCI		0x0805
+#define PCI_CLASS_SYSTEM_RCEC		0x0807
 #define PCI_CLASS_SYSTEM_OTHER		0x0880
 
 #define PCI_BASE_CLASS_INPUT		0x09
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f9701410d3b5..f335f65f65d6 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -828,6 +828,13 @@
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 #define PCI_EXT_CAP_PWR_SIZEOF	16
 
+/* Root Complex Event Collector Endpoint Association  */
+#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
+#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
+#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least capability version that BUSN present */
+#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
+#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
+
 /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
 #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
 #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
-- 
2.27.0

