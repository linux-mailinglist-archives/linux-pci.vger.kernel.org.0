Return-Path: <linux-pci+bounces-40274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26701C32A46
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C25342399D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3333E345;
	Tue,  4 Nov 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNO8xnsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C453335097;
	Tue,  4 Nov 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280727; cv=none; b=VwuS0FXreh4aCHua415W/h4jxfjfZNPYu8Lbf9Pw8CmwCEAm1Xvhd/y/Dny3R0jJodh7gR9IfT8Zfy3TSHzLcshaYhhkVxKR8uUc8nqR09t87fU/03ayptuT3Kylcfh1ZYwpqmIla6GBCvA0hb0yVGz1AGYzVsU7yJRvmi8T8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280727; c=relaxed/simple;
	bh=juJtXgSRiOYqNUeFtIDyt8rosY/EPjrWHvZ2ju4d47g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlRmqYKHGG62vGUOZtaByHpJWpcG9eZARFzqsZG6Cf+/otf5dV+wy6wyu3E6ZPhbrATJBAzd70QSa4Gn3m8rvb2USMFbHDjSrmZZ0tLMKGrFn/4LmiG6c80nZ9IQxddlpyrhmxFaPg049sffcbgXd/GQja5Uc2EdAlDERWK1xZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNO8xnsA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280726; x=1793816726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=juJtXgSRiOYqNUeFtIDyt8rosY/EPjrWHvZ2ju4d47g=;
  b=WNO8xnsAxpj182AmrZxWdDHmU4S/CNGhsFJywxFtbhtWhC40OnK0Ls1p
   qCSp0zER7kxlRKnDzn5UTlhnI0MFzuczRN+eU4sTakSc4SvSsYr0iTJwJ
   zoL9kzohkKAPryHQu7AU0HFT2xx2T8NuuxdS3tliG08yu0hNHY4yX93pR
   SfHLJCZHn94cpeEltj3GiJfJh9MXsg5gphnXV/d7maPuvjeR/zQXM0u+a
   B1gym1tQbWm7+ejHW0Ffv2O3OAqEjymu/fNc+3LmAhXVjfQeCNFjx3GAv
   tPNWCTK6RrkbRk09C9QV3B3gONKWcHX0xrKEUDkfF6//kEaGqOwUzQRyD
   A==;
X-CSE-ConnectionGUID: cWEziSosR2256WCeala49w==
X-CSE-MsgGUID: hxUFiOLFRhOh7kw3XZNjtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63394796"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="63394796"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:25 -0800
X-CSE-ConnectionGUID: 8m5SSZNuSw+bS+yaYbMORg==
X-CSE-MsgGUID: HMQrkF8GQnGkdgOGnzhoCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191325327"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:19 -0800
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
Subject: [PATCH 4/6 v7] acpi/ghes: Add helper for CXL protocol errors checks
Date: Tue,  4 Nov 2025 19:22:35 +0100
Message-ID: <20251104182446.863422-5-fabio.m.de.francesco@linux.intel.com>
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

Move the CPER CXL protocol errors validity check out of
cxl_cper_post_prot_err() to new cxl_cper_sec_prot_err_valid() and limit
the serial number check only to CXL agents that are CXL devices (UEFI
v2.10, Appendix N.2.13).

Export the new symbol for reuse by ELOG.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
 include/cxl/event.h      | 10 ++++++++++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d6fe5f020e96..e69ae864f43d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -706,30 +706,42 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 {
-	struct cxl_cper_prot_err_work_data wd;
-	u8 *dvsec_start, *cap_start;
-
 	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
 		pr_err_ratelimited("CXL CPER invalid agent type\n");
-		return;
+		return -EINVAL;
 	}
 
 	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
 		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
-		return;
+		return -EINVAL;
 	}
 
 	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
 		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
 				   prot_err->err_len);
-		return;
+		return -EINVAL;
 	}
 
-	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
-		pr_warn(FW_WARN "CXL CPER no device serial number\n");
+	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
+	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
+	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn_ratelimited(FW_WARN
+				    "CXL CPER no device serial number\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
+
+static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				   int severity)
+{
+	struct cxl_cper_prot_err_work_data wd;
+	u8 *dvsec_start, *cap_start;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
 
 	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 6fd90f9cc203..4d7d1036ea9c 100644
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
2.51.1


