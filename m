Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385162A8B4C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbgKFAPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:15:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:23004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732706AbgKFAPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 19:15:09 -0500
IronPort-SDR: JcD2fCwCCzA2jtlJ2OLGBsivUmEOm4Go25Be0Cbl9BYyGVspTdJKeEip3ZjLLRC2YF1IO89OQh
 /YJYUfO5XvUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="148759527"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="148759527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:08 -0800
IronPort-SDR: v7JuM3NLVbKtILHEcJWmRAN5NBxzmYXcQeUWf9aKGNTjbL9NVv2HU6+JKJqQ/U46SDBQu6NYd4
 m3IaeQVBC90A==
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="529621693"
Received: from gabriels-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.37.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 16:15:07 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 02/16] PCI/RCEC: Add RCEC class code and extended capability
Date:   Thu,  5 Nov 2020 16:14:30 -0800
Message-Id: <20201106001444.667232-3-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201106001444.667232-1-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A PCIe Root Complex Event Collector (RCEC) has base class 0x08, sub-class
0x07, and programming interface 0x00.  Add the class code 0x0807 to
identify RCEC devices and add #defines for the RCEC Endpoint Association
Extended Capability.

See PCIe r5.0, sec 1.3.4 ("Root Complex Event Collector") and sec 7.9.10
("Root Complex Event Collector Endpoint Association Extended Capability").

Link: https://lore.kernel.org/r/20201002184735.1229220-2-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h       | 1 +
 include/uapi/linux/pci_regs.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1ab1e24bcbce..d8156a5dbee8 100644
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
index a95d55f9f257..bccd3e35cb65 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -831,6 +831,13 @@
 #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
 #define PCI_EXT_CAP_PWR_SIZEOF	16
 
+/* Root Complex Event Collector Endpoint Association  */
+#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
+#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
+#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least version with BUSN present */
+#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
+#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
+
 /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
 #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
 #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
-- 
2.29.2

