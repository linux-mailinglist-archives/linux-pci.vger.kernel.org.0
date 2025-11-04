Return-Path: <linux-pci+bounces-40275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48122C32A4C
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F22E42525D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78133E35F;
	Tue,  4 Nov 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cyp5yDMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605433B970;
	Tue,  4 Nov 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280734; cv=none; b=aig8OZuoYbMFs5WiRQJ71ZyzxskREzEAfZ6MtnmN4Z0a2w32czc5HsQbLj++1CeaNkyGCLS9UQ+c7k5pmY8lxjk/AegRkl8VUU+/L60wU7RuY7rEffZSjt8E35VgBu/XTuTNx2juHnCqJJTrPKKb17L1A8LFMa/WZ2piFNZ3ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280734; c=relaxed/simple;
	bh=GBn/A1IbxV67Oj1kHdw3DMepECJGqqMVcqVRyVu6olg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb3UrAVmXXggjNqT0ZILx5lMHzmdiiG+7Z2+HopZssFjGNKZ4AdedEz3qeQbcMc83L0WHAvODQQa2+1Z8MYp1nqUehY/iu2YH/Kk7isyG1Dfv2ahjoHpEvbmIYDEulC0w87HreUKWZ2O4S6HMHjEgZwfswxMYEE3OMP8KFvGgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cyp5yDMx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280732; x=1793816732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GBn/A1IbxV67Oj1kHdw3DMepECJGqqMVcqVRyVu6olg=;
  b=Cyp5yDMxgbMRf407/yxvVSngDFQwQN5tY9UGC/MW4HCO1ExslqF6nufA
   C4Q62CYYQRmxT6ntgvwXgi8Ox5gYzbbh5pJ9f2+8b3E0glQh/BUhhu9IS
   rDgxPIMF+SifJFimIIA3wlCGrdPnglK+Ijz4+AGETMUI9zTcOxoQUnI/V
   mv9AgsOdhabMZfG2EARV33iN5cdykg3Dff2NH6soWmconwI0/0EQYRdZ8
   A7t8ZuHAnWbM6NiX1LyNpbLiUiIc+6yuu74tK0mYfkHSewWP3sYbXYYaQ
   bk78rMV4fC3kaK3+60ADXzNVFcqo4ZJgRXquDW91Aq/6RLMnJXYwFQqes
   w==;
X-CSE-ConnectionGUID: vbph9f0bSsS/ePHJqMflZg==
X-CSE-MsgGUID: INvR29V5Ss+UiC3/9n6Xfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67001218"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="67001218"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:32 -0800
X-CSE-ConnectionGUID: ZS0uiCCCQyON71XiTKHqiQ==
X-CSE-MsgGUID: 1qHsqwyZQgK1P5Ij5D3+EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191325356"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:26 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH 5/6 v7] acpi/ghes: Add helper to copy CXL protocol error info to work struct
Date: Tue,  4 Nov 2025 19:22:36 +0100
Message-ID: <20251104182446.863422-6-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
type and copy the CPER CXL protocol errors information to a work data
structure.

Export the new symbol for reuse by ELOG.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 42 ++++++++++++++++++++++++++--------------
 include/cxl/event.h      | 10 ++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e69ae864f43d..2f4632d9855a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -734,20 +734,12 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 }
 EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
 
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
+int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
+				      struct cxl_cper_sec_prot_err *prot_err,
+				      int severity)
 {
-	struct cxl_cper_prot_err_work_data wd;
 	u8 *dvsec_start, *cap_start;
 
-	if (cxl_cper_sec_prot_err_valid(prot_err))
-		return;
-
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
-
-	if (!cxl_cper_prot_err_work)
-		return;
-
 	switch (prot_err->agent_type) {
 	case RCD:
 	case DEVICE:
@@ -756,20 +748,40 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	case RP:
 	case DSP:
 	case USP:
-		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
+		memcpy(&wd->prot_err, prot_err, sizeof(wd->prot_err));
 
 		dvsec_start = (u8 *)(prot_err + 1);
 		cap_start = dvsec_start + prot_err->dvsec_len;
 
-		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
-		wd.severity = cper_severity_to_aer(severity);
+		memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
+		wd->severity = cper_severity_to_aer(severity);
 		break;
 	default:
 		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
 				   prot_err->agent_type);
-		return;
+		return -EINVAL;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_cper_setup_prot_err_work_data);
+
+static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+	struct cxl_cper_prot_err_work_data wd;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
+
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+
+	if (!cxl_cper_prot_err_work)
+		return;
+
+	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
+		return;
+
 	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
 		pr_err_ratelimited("CXL CPER kfifo overflow\n");
 		return;
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 4d7d1036ea9c..94081aec597a 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -322,12 +322,22 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
+int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
+				      struct cxl_cper_sec_prot_err *prot_err,
+				      int severity);
 #else
 static inline int
 cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
+				  struct cxl_cper_sec_prot_err *prot_err,
+				  int severity)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.51.1


