Return-Path: <linux-pci+bounces-44730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F26D1DF0C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49AE4301B80C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D83559CB;
	Wed, 14 Jan 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/3+tmAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86F350A0E;
	Wed, 14 Jan 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385781; cv=none; b=HDmPPmDISjn4k2sMD7Pc0INNDnD+riPVfjrtRsYk/CzPWxPtFnuaYvlJ3z36+dHavbU6rkz8xyQqLxnIkljGnT1gxZFm1Gh8301+g+PtbrikCWMHOmH3SQ5GvGYrPBQ4FOJX27gORkhu/moSfpZhK7DbKnb9eA0YK9NiC8nCblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385781; c=relaxed/simple;
	bh=WAaB4x5EtZX1hdIYOdIBpo/Pu2iiyrIR3CaAw6L8S9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzbFa7h961zTkn9kOEHCQOspR16QPXViK/fTvmzJu/20LKpr3hnHmX+340a0aCWJFcmplFxmCP2AhFEhn3arEIdzcAr/N7xkhltctUAMdifQRyluVp1n1NlhWwm9M6yEytFMH9glEBnlnOpE0Hv6NFasJLCyfD47CbWt4soq6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/3+tmAy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385780; x=1799921780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAaB4x5EtZX1hdIYOdIBpo/Pu2iiyrIR3CaAw6L8S9w=;
  b=j/3+tmAyY4rNum04wH8t1aKGlfMTjO2bX8FSeXh34OBwFqCOvbm59czq
   6o+8+WqWZ8OOY4EiBfdkrQacAM4DhEHFQcjeQTyHy9mdBVrtUsh5xl2Aa
   aOizfZ2Jj9YdXPK0DQGV39cdz8GJ8lff0TDySamiOHQxmhw4W3IaJj7yY
   6Fe59iPhgbWpjhROzOyT2tJeE8r+y+XLjayg4XwX7cfC6bu05isgBhAau
   hz+otxJ4J8mLbN/ruuiq0S1tOZjUrx1jJBxMJnBczMKbJPL+8YCRR8PvI
   ESYKAhND5ilkKNUZ8uVXnlH9C5fFw7eld8e4DsKsdr13F0LIAPHXFfp4I
   A==;
X-CSE-ConnectionGUID: QPLrE1wfTvGDAUr7FDf2hA==
X-CSE-MsgGUID: 9gYsjOkVRLmCbDMeNrWCnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69765855"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69765855"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:19 -0800
X-CSE-ConnectionGUID: sSiC9NvLSqmZspQj6bk/5w==
X-CSE-MsgGUID: gVtrgyGhS/qZviZ5bbmSIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208792798"
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.167])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:14 -0800
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
Subject: [PATCH 4/5 v9] acpi/ghes: Add helper to copy CPER CXL protocol error info to work struct
Date: Wed, 14 Jan 2026 11:14:24 +0100
Message-ID: <20260114101543.85926-5-fabio.m.de.francesco@linux.intel.com>
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

Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
type and copy the CPER CXL protocol errors information to a work data
structure.

Export the new symbol for reuse by ELOG.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/ghes.c         | 22 +--------------------
 drivers/acpi/apei/ghes_helpers.c | 33 ++++++++++++++++++++++++++++++++
 include/cxl/event.h              | 10 ++++++++++
 3 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index cc4cc7ee8422d..79755587871fa 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -711,7 +711,6 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
-	u8 *dvsec_start, *cap_start;
 
 	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
@@ -721,27 +720,8 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	if (!cxl_cper_prot_err_work)
 		return;
 
-	switch (prot_err->agent_type) {
-	case RCD:
-	case DEVICE:
-	case LD:
-	case FMLD:
-	case RP:
-	case DSP:
-	case USP:
-		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
-
-		dvsec_start = (u8 *)(prot_err + 1);
-		cap_start = dvsec_start + prot_err->dvsec_len;
-
-		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
-		wd.severity = cper_severity_to_aer(severity);
-		break;
-	default:
-		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
-				   prot_err->agent_type);
+	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
 		return;
-	}
 
 	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
 		pr_err_ratelimited("CXL CPER kfifo overflow\n");
diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
index f3d162139a974..bc7111b740afb 100644
--- a/drivers/acpi/apei/ghes_helpers.c
+++ b/drivers/acpi/apei/ghes_helpers.c
@@ -2,6 +2,7 @@
 // Copyright(c) 2025 Intel Corporation. All rights reserved
 
 #include <linux/printk.h>
+#include <linux/aer.h>
 #include <cxl/event.h>
 
 int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
@@ -31,3 +32,35 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
+
+int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
+				      struct cxl_cper_sec_prot_err *prot_err,
+				      int severity)
+{
+	u8 *dvsec_start, *cap_start;
+
+	switch (prot_err->agent_type) {
+	case RCD:
+	case DEVICE:
+	case LD:
+	case FMLD:
+	case RP:
+	case DSP:
+	case USP:
+		memcpy(&wd->prot_err, prot_err, sizeof(wd->prot_err));
+
+		dvsec_start = (u8 *)(prot_err + 1);
+		cap_start = dvsec_start + prot_err->dvsec_len;
+
+		memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
+		wd->severity = cper_severity_to_aer(severity);
+		break;
+	default:
+		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
+				   prot_err->agent_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_cper_setup_prot_err_work_data);
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 4d7d1036ea9cb..94081aec597ae 100644
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
2.52.0


