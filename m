Return-Path: <linux-pci+bounces-44731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E004AD1DF1B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3318E3075F16
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C14F350A22;
	Wed, 14 Jan 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS/TLG30"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1C38A280;
	Wed, 14 Jan 2026 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385783; cv=none; b=So2T5UmWLgIekR5PTmbG7I5BPzMBcYXKRSM3Rc4NsZlSXymeM07ZnqMEIH6s9uwz8ptoJfzn1CfvnsYI9xC7URJVaJ2lJ5Eox6lYakfeKvfI++nFbbqcy5BclXJMAIoUHNUT7vxbekVPHnxB/E8Mdu3P4MDkXAy4XUxJlSg5HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385783; c=relaxed/simple;
	bh=3JeX3kfiJkV+SDsaXDPJu5yP2rFh1vT9UghvnBJ0jmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrtYqGGnP5x/A/6hrVv7rE9sc7AQlAWrSzDXbo+gkd4h9KJ3zEEhimyRlvKdGvFz4FxtDkPUtBMUSO+I8yXLo+AaoYcfHoD20zSqvZCJXDLkOHc6dzdJKDJnIUQo15bk5TB/1aYam2X/wvIUULPOpv1VtL4fyKofc2PE2SfaxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS/TLG30; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385774; x=1799921774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JeX3kfiJkV+SDsaXDPJu5yP2rFh1vT9UghvnBJ0jmM=;
  b=lS/TLG30B77i8F7n6e6Kjc3thZ2UOqZMncW4om1A/JVe72uo8tqdBoAl
   5rhfNTNRtg19XTviyyNuJlpKaCuifx8PbkoizKjTh335PErjlbOl2DAE8
   XFcRtZaOHF1ZTSFYHMBOJYBzCS65d28p7tOlMHGx7mCD2M9dnFwDmCbT7
   Opx+hXxQwpmz+nOAoRZ9QzhxhrywrbsiGnRXPTET2YbiuH1d/WzSk2Gs1
   ykHxrdmbHm8uH4KnTRMUWiPajqoGD7yNR2cB4ku3gipz/euV/HjMBvpwT
   KhQRrz21ZLqpLeTjdvPxQjg5kMDota8kgx7X3Zu+uotzCJ8nwYKOXTKH8
   Q==;
X-CSE-ConnectionGUID: DPeb/s7nT9CXBg4wH6rexQ==
X-CSE-MsgGUID: QP0UyEDxSl29F0BQqI6RgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69765836"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69765836"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:14 -0800
X-CSE-ConnectionGUID: Wpgy8ZZWSSSt4c7WkpfkRQ==
X-CSE-MsgGUID: 5XnhheJpQyqsGJQ13GGE/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208792779"
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.167])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:08 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Rafael J Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 3/5 v9] acpi/ghes: Add helper for CPER CXL protocol errors checks
Date: Wed, 14 Jan 2026 11:14:23 +0100
Message-ID: <20260114101543.85926-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114101543.85926-1-fabio.m.de.francesco@linux.intel.com>
References: <20260114101543.85926-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the CPER CXL protocol errors validity check out of
cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
the serial number check only to CXL agents that are CXL devices (UEFI
v2.10, Appendix N.2.13).

Export the new symbol for reuse by ELOG.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/Makefile       |  1 +
 drivers/acpi/apei/ghes.c         | 18 +----------------
 drivers/acpi/apei/ghes_helpers.c | 33 ++++++++++++++++++++++++++++++++
 include/cxl/event.h              | 10 ++++++++++
 4 files changed, 45 insertions(+), 17 deletions(-)
 create mode 100644 drivers/acpi/apei/ghes_helpers.c

diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 2c474e6477e12..5db61dfb46915 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+obj-$(CONFIG_ACPI_APEI_PCIEAER)	+= ghes_helpers.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c6..cc4cc7ee8422d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -713,24 +713,8 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	struct cxl_cper_prot_err_work_data wd;
 	u8 *dvsec_start, *cap_start;
 
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
-		pr_err_ratelimited("CXL CPER invalid agent type\n");
+	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
-		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
-		return;
-	}
-
-	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
-		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
-				   prot_err->err_len);
-		return;
-	}
-
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
-		pr_warn(FW_WARN "CXL CPER no device serial number\n");
 
 	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
new file mode 100644
index 0000000000000..f3d162139a974
--- /dev/null
+++ b/drivers/acpi/apei/ghes_helpers.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2025 Intel Corporation. All rights reserved
+
+#include <linux/printk.h>
+#include <cxl/event.h>
+
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+{
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
+		pr_err_ratelimited("CXL CPER invalid agent type\n");
+		return -EINVAL;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
+		return -EINVAL;
+	}
+
+	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
+		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
+				   prot_err->err_len);
+		return -EINVAL;
+	}
+
+	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
+	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
+	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn_ratelimited(FW_WARN
+				    "CXL CPER no device serial number\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 6fd90f9cc2034..4d7d1036ea9cb 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -320,4 +320,14 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 }
 #endif
 
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
+#else
+static inline int
+cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.52.0


