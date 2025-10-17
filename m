Return-Path: <linux-pci+bounces-38477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E818BE8EEC
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642BD1886137
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D083570C3;
	Fri, 17 Oct 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKtANcpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25830146585;
	Fri, 17 Oct 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708144; cv=none; b=VSu4QM3Z8uWPEbJKYCxQ5JKoUS+zRih1D+Cy01/c1vYiGdzUPt96hM2UN2Q3IP4jLzvmAAwTgsNhrn0wWcCiwtrY7CTOjzoAioaTo+NcRtZr39k6njKwh8HFC+tmUUOVTdOer5SzhCZat+jkl7RUJZ7sfsQa7WwaXZYYbqESPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708144; c=relaxed/simple;
	bh=wEV3YwZtRuTemBv1zQt7Cmx6AAG3aqi5wz2vKBh//nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsivKR8WB1MhXir8UimzP6VuM9JtxwRKr9/RPY8hG2x5YCH1Q4qhyIt8tDlAD+73JA/nMI3slWJkepYky3RVS4KFLoFBr618hthZOPuz22lev5HluE4zVokxVaeziRpnlMyXKvJu+1rEqfUPvlkyz4kjaQzg4DJtXYHWzvoxels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKtANcpD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760708143; x=1792244143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wEV3YwZtRuTemBv1zQt7Cmx6AAG3aqi5wz2vKBh//nc=;
  b=gKtANcpDLThIXUG1r3D65zBMRQNW61wRGeB11l6fbijSHc5rE1ojg404
   kYttqWXl+/jb415+dSqxoo3bA0SbN/TqZ5Ub0lOGiYkA4sie+OU9B1C1W
   GKRZlBefFsiQkk0PVj+4TRiWAQ47YAgVW+wFVfobWpBN5hqcrkpyv/SWl
   50NzoBSMpMwAcnwRED6CrgIT+U4dL7mzLn5F/nYZlQplW6CWJnJ4r/SJK
   b/+gjEpiuGl6JZT9pU3pO1Eo3veQARfEF9Qa6/ukjfnKpPUOjoP1LN7d7
   yUSjdigTmqU3D7mx5WB8cWFHeSub7QwG6pLaZ7sp5sKwA7t7QtsHSznPX
   w==;
X-CSE-ConnectionGUID: uffzYFOIRcyAtbBYAoh1WA==
X-CSE-MsgGUID: w3cRRXcVTd+DABQxf2pRXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63065029"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63065029"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:13 -0700
X-CSE-ConnectionGUID: K1JgY/+DS+66wNORjTzzJQ==
X-CSE-MsgGUID: Ts7J9p6SSUmrc+mIW1x4lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181925252"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.215])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:00 -0700
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Xin Li <xin@zytor.com>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Gavin Shan <gshan@redhat.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Li Ming <ming.li@zohomail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/6 v5] acpi/ghes: Add helper for CPER CXL protocol errors checks
Date: Fri, 17 Oct 2025 15:30:49 +0200
Message-ID: <20251017133357.1150982-5-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133357.1150982-1-fabio.m.de.francesco@linux.intel.com>
References: <20251017133357.1150982-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the CPER CXL protocol errors validity checks out of
cxl_cper_post_prot_err() to cxl_cper_sec_prot_err_valid() and check the
serial number only for CXL agents that are CXL devices (UEFI v2.10,
Appendix N.2.13).

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 32 ++++++++++++++++++++++----------
 include/cxl/event.h      | 10 ++++++++++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d6fe5f020e96e..e69ae864f43d3 100644
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
index 6fd90f9cc2034..e1deb66c2197e 100644
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
+	return -EINVAL;
+}
+#endif
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.51.0


