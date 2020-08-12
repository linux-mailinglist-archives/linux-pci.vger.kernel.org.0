Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F57242D91
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLQrJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 12:47:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:33828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgHLQrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Aug 2020 12:47:08 -0400
IronPort-SDR: PkaV/d9bU5Pg7VW8qELaoiaL0yZQgM10zOxChMvPnQa0NXgL860tV1LrZfjN/szd1DKcIDbDwO
 a6ukUs1F4rwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133538389"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="133538389"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:07 -0700
IronPort-SDR: b8eOHR1NQzanN969njNyHEnzjMgpZlCLzkNOytP+y0XDTXVqBJC5puT4+W4bKt+RfK1WG0tqJ/
 /ulUp7ZNKvPA==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439442595"
Received: from ticede-or-099.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.58.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:05 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] PCI/RCEC: Add RCEC class code and extended capability
Date:   Wed, 12 Aug 2020 09:46:50 -0700
Message-Id: <20200812164659.1118946-2-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812164659.1118946-1-sean.v.kelley@intel.com>
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
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
index 0ad57693f392..de8dff1fb176 100644
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
2.28.0

