Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE31C4B8F
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgEEBcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 21:32:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:52077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgEEBck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 21:32:40 -0400
IronPort-SDR: xIEtsE+m9CAcakmqGcP+5s+rpQ041eFR2Qvpgl46aHGFgNPwd80/AxBczQQLzjwkbr0oeQDX99
 v+EaJ8tooq0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:32:40 -0700
IronPort-SDR: hHcKuDlrpepWuD8j8R8/g9YI9pBzTLbTh7UihT5c1jcZmfmhwmuuWM9V0uAGae6v67vQQ6dFvy
 aJ0HY1fVhfPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="338501940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 04 May 2020 18:32:40 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 51639580613;
        Mon,  4 May 2020 18:32:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, andy@infradead.org,
        alexander.h.duyck@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/3] pci: Add Designated Vendor Specific Capability
Date:   Mon,  4 May 2020 18:32:04 -0700
Message-Id: <20200505013206.11223-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505013206.11223-1-david.e.box@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie dvsec extended capability id along with helper macros to
retrieve information from the headers.

https://members.pcisig.com/wg/PCI-SIG/document/12335

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 include/uapi/linux/pci_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f9701410d3b5..c96f08d1e711 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -720,6 +720,7 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_DVSEC	0x23	/* Desinated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
@@ -1062,6 +1063,10 @@
 #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
 #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
 
+/* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
+#define PCI_DVSEC_HEADER1		0x4 /* Vendor-Specific Header1 */
+#define PCI_DVSEC_HEADER2		0x8 /* Vendor-Specific Header2 */
+
 /* Data Link Feature */
 #define PCI_DLF_CAP		0x04	/* Capabilities Register */
 #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
-- 
2.20.1

