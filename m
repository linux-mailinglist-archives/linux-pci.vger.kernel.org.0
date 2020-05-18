Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8D1D7E9F
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERQfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:35:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:16277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgERQf2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:35:28 -0400
IronPort-SDR: 40IqoeyLkjNPmSyUXc2WpRGsjJEgbxjpsWZqE3IaJM5hsjZsKMyZiL+f67mfJfXKJTYYoOcMBp
 Rd2sBipclFvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:28 -0700
IronPort-SDR: hLkPHdOVkwJQtdW+AOL0Q0hvbkJ2pRPqMvCpZ085tL1yBYifxSSSJXxQsB4G+4QIy8YR6N45K7
 GFjNsftEGtmA==
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="264014288"
Received: from kharjox-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.180.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:35:27 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH V2 1/3] pci: Add Designated Vendor Specific Capability
Date:   Mon, 18 May 2020 09:35:21 -0700
Message-Id: <20200518163523.1225643-2-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
References: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

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
2.26.2

