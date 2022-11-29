Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2620F63C6D6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiK2Rya (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiK2Ry1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:54:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776BC55AAC;
        Tue, 29 Nov 2022 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744467; x=1701280467;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQgWOX9ZfxQw9UW7pkN6vNLkhB00kWGAEIs2Xk6274o=;
  b=CkOybpLB38ncQrWVq5MqlQSPfx5k9GBadBbZTZ0kt2fSx7E2WiNwUHRA
   AiHxtgo1AeYsfaHCg/RmrKfWRO+tR5c0aKQFhkNzTSulDNtnCO3XpehmE
   qeht1f8Yn+n78S5m1iNAo7vmn9eRl0kZz7sT+lIt8B+wiT3cLhConEiw0
   Xkheb44qaQp/LMZCXD99ssRV6RQtCGkhPSK4ehhkO+VzT5UWUkIdVLGnf
   Z1Zuhuui5LCOXytDHFaurh1O86q6DPK/C2UM1V/hsxw0v3mgsNKlg4DF+
   +Ix+hDOr02JOViYwy9qkkhAOoWffLCvtsg/3yRQ0IDy40lbB1SR4yLcn/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317038164"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317038164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749957222"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="749957222"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:54 -0800
Subject: [PATCH v4 08/11] cxl/pci: add tracepoint events for CXL RAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:53 -0700
Message-ID: <166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add tracepoint events for recording the CXL uncorrectable and correctable
errors. For uncorrectable errors, there is additional data of 512B from
the header log register (CXL spec rev3 8.2.4.16.7). The trace event will
intake a dynamic array that will dump the entire Header Log data. If
multiple errors are set in the status register, then the
'first error' field (CXL spec rev3 v8.2.4.16.6) is read from the Error
Capabilities and Control Register in order to determine the error.

This implementation does not include CXL IDE Error details.

Cc: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c          |    2 +
 include/trace/events/cxl.h |  112 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 include/trace/events/cxl.h

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9428f3e0d99b..0f36a5861a7b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -13,6 +13,8 @@
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/cxl.h>
 
 /**
  * DOC: cxl pci
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
new file mode 100644
index 000000000000..72c3e2870a9e
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_EVENTS_H
+
+#include <linux/tracepoint.h>
+
+#define CXL_HEADERLOG_SIZE		SZ_512
+#define CXL_HEADERLOG_SIZE_U32		SZ_512 / sizeof(u32)
+
+#define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
+#define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
+#define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
+#define CXL_RAS_UC_CACHE_DATA_ECC	BIT(3)
+#define CXL_RAS_UC_MEM_DATA_PARITY	BIT(4)
+#define CXL_RAS_UC_MEM_ADDR_PARITY	BIT(5)
+#define CXL_RAS_UC_MEM_BE_PARITY	BIT(6)
+#define CXL_RAS_UC_MEM_DATA_ECC		BIT(7)
+#define CXL_RAS_UC_REINIT_THRESH	BIT(8)
+#define CXL_RAS_UC_RSVD_ENCODE		BIT(9)
+#define CXL_RAS_UC_POISON		BIT(10)
+#define CXL_RAS_UC_RECV_OVERFLOW	BIT(11)
+#define CXL_RAS_UC_INTERNAL_ERR		BIT(14)
+#define CXL_RAS_UC_IDE_TX_ERR		BIT(15)
+#define CXL_RAS_UC_IDE_RX_ERR		BIT(16)
+
+#define show_uc_errs(status)	__print_flags(status, " | ",		  \
+	{ CXL_RAS_UC_CACHE_DATA_PARITY, "Cache Data Parity Error" },	  \
+	{ CXL_RAS_UC_CACHE_ADDR_PARITY, "Cache Address Parity Error" },	  \
+	{ CXL_RAS_UC_CACHE_BE_PARITY, "Cache Byte Enable Parity Error" }, \
+	{ CXL_RAS_UC_CACHE_DATA_ECC, "Cache Data ECC Error" },		  \
+	{ CXL_RAS_UC_MEM_DATA_PARITY, "Memory Data Parity Error" },	  \
+	{ CXL_RAS_UC_MEM_ADDR_PARITY, "Memory Address Parity Error" },	  \
+	{ CXL_RAS_UC_MEM_BE_PARITY, "Memory Byte Enable Parity Error" },  \
+	{ CXL_RAS_UC_MEM_DATA_ECC, "Memory Data ECC Error" },		  \
+	{ CXL_RAS_UC_REINIT_THRESH, "REINIT Threshold Hit" },		  \
+	{ CXL_RAS_UC_RSVD_ENCODE, "Received Unrecognized Encoding" },	  \
+	{ CXL_RAS_UC_POISON, "Received Poison From Peer" },		  \
+	{ CXL_RAS_UC_RECV_OVERFLOW, "Receiver Overflow" },		  \
+	{ CXL_RAS_UC_INTERNAL_ERR, "Component Specific Error" },	  \
+	{ CXL_RAS_UC_IDE_TX_ERR, "IDE Tx Error" },			  \
+	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
+)
+
+TRACE_EVENT(cxl_aer_uncorrectable_error,
+	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
+	TP_ARGS(dev_name, status, fe, hl),
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(u32, status)
+		__field(u32, first_error)
+		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
+	),
+	TP_printk("%s: status: '%s' first_error: '%s'",
+		  __get_str(dev_name),
+		  show_uc_errs(__entry->status),
+		  show_uc_errs(__entry->first_error)
+	)
+);
+
+#define CXL_RAS_CE_CACHE_DATA_ECC	BIT(0)
+#define CXL_RAS_CE_MEM_DATA_ECC		BIT(1)
+#define CXL_RAS_CE_CRC_THRESH		BIT(2)
+#define CLX_RAS_CE_RETRY_THRESH		BIT(3)
+#define CXL_RAS_CE_CACHE_POISON		BIT(4)
+#define CXL_RAS_CE_MEM_POISON		BIT(5)
+#define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(6)
+
+#define show_ce_errs(status)	__print_flags(status, " | ",			\
+	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
+	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data ECC Error" },			\
+	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
+	{ CLX_RAS_CE_RETRY_THRESH, "Retry Threshold" },				\
+	{ CXL_RAS_CE_CACHE_POISON, "Received Cache Poison From Peer" },		\
+	{ CXL_RAS_CE_MEM_POISON, "Received Memory Poison From Peer" },		\
+	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
+)
+
+TRACE_EVENT(cxl_aer_correctable_error,
+	TP_PROTO(const char *dev_name, u32 status),
+	TP_ARGS(dev_name, status),
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__field(u32, status)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status = status;
+	),
+	TP_printk("%s: status: '%s'",
+		  __get_str(dev_name), show_ce_errs(__entry->status)
+	)
+);
+
+#endif /* _CXL_EVENTS_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl
+#include <trace/define_trace.h>


