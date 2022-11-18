Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF062FB31
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiKRRJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRRJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2508C79A;
        Fri, 18 Nov 2022 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791381; x=1700327381;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ofcwy72bIi6K0sCA4eGxm9D6XJ1G03G0CRCkHa0BQro=;
  b=jFgYDO8wGePvezr6i9hDBSgYymUDeBGnNhnuEU3FC6LasOcV2hcK5ytb
   drtJo6t/G4WwQEqGr+fpwWUjXINCNYDwjrHo/7aIWaqdeS2gDBandIrHK
   z6/eAw8ukH5iUgEaERM0pdtAJ5Q0Vk4Z0ukoNRBXPDAZFdAUUQsFVnQ6B
   RQeH0R7K9VRe2q90EXq07uCm7noqnsHxKczHg7KYSFO+dBPSM0w7JkpRk
   2xisVelhITJOnD6CnOajJVYNW+b5Cp21xjAQ4HsVmnXwUxVEbgSgvA9X/
   lAUFwy4fv9nONNZ/CHpQp879eNUNNb5jc2lr1kSs0tubEqOYIFhyvgOwS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="315002519"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="315002519"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765224129"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="765224129"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:50 -0800
Subject: [PATCH v3 08/11] cxl/pci: add tracepoint events for CXL RAS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:49 -0700
Message-ID: <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c          |    2 +
 include/trace/events/cxl.h |  110 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
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
index 000000000000..f8e95d977133
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,110 @@
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
+		__dynamic_array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
+	),
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status = status;
+		__entry->first_error = fe;
+		/*
+		 * Embed the 512B headerlog data for user app retrieval and
+		 * parsing, but no need to print this in the trace buffer.
+		 */
+		memcpy(__get_dynamic_array(header_log), hl, CXL_HEADERLOG_SIZE);
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
+#define CXL_RAS_CE_CACHE_POISON		BIT(3)
+#define CXL_RAS_CE_MEM_POISON		BIT(4)
+#define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(5)
+
+#define show_ce_errs(status)	__print_flags(status, " | ",			\
+	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
+	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data Ecc Error" },			\
+	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
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


