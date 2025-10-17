Return-Path: <linux-pci+bounces-38478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66556BE8EF3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1873B0089
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A98393DC0;
	Fri, 17 Oct 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzAim2Ft"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADC33033E;
	Fri, 17 Oct 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708146; cv=none; b=D1E6Vq4HLkWm8Jj7f6cfSWGqCebPudooIujLVExliluH4IC2J06LhCAvrjwAaUJW/uvRC6QJ2TbYSlEaEZOLZjXmcbgf850MC11+rh7soHWd5GvodkmGrihsc2O0GqR4LseqfHl5WD8URhtU+A5Lq1StGITXvEQdeUjWtGNXwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708146; c=relaxed/simple;
	bh=6cWsfVK2uywEugF7lxsG4Yh9ydRfGMntJrHORzhDVkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9ECZOoIaA/5j50M5G58tNn21NByqboWCH7VfPZ2Mg5Gk0zyX5kqYOlEqcDUWL9R0FhQVhJCRx1i9DP9fnGdr3UKdxlW3WNa0oLtBtpstNJwX8tcY23KGXsNWWwJxfcWrPh36Hbi4cpYZnqEzV1Eupdf7RCVRJRIj02XdEk1QaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzAim2Ft; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760708144; x=1792244144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6cWsfVK2uywEugF7lxsG4Yh9ydRfGMntJrHORzhDVkE=;
  b=WzAim2FtNaK35efn8dhpJJP5Y84aGIm5BoHU/qwmF7ewIiAzJCE7bSAK
   HXtJunTOs+qQj6ciZYLZwV9vf3efzdG2KhU0698aTxyEkpjNUq/Wp/TOo
   hr0Nw86998s2k6Q3waJklW/eIfzSRmosh3BFOsY4ErirOTnhzUDtVE7mT
   DkY/woI5P4l5DLO8jngxZcet0A94bsKCXThlf6182P7dmyuDGEEf9/gKX
   FmXNAr1JfBYXsa5R+r3lzDORr1JcKiKG7lYlN9eENQyRERblnXoSMBd9O
   2BKXslX+ytDQx4J7Eps7SiM0Mc9zAb1YxOJbWWnrCfTFkMi9dZIy96rJ7
   A==;
X-CSE-ConnectionGUID: IqKjX1TWQYuRN+7JDWKy0Q==
X-CSE-MsgGUID: WjNz5PaSQR2pcgQxwGderw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63065069"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63065069"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:27 -0700
X-CSE-ConnectionGUID: gKeP+cXbT6ax9cP8SQcYig==
X-CSE-MsgGUID: H6mglz3GRx+7F8DG4fPbXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181925286"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.215])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:14 -0700
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
Subject: [PATCH 5/6 v5] acpi/ghes: Add helper to copy CXL protocol error info to work struct
Date: Fri, 17 Oct 2025 15:30:50 +0200
Message-ID: <20251017133357.1150982-6-fabio.m.de.francesco@linux.intel.com>
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

Make a helper out of cxl_cper_post_prot_err() that checks the CXL agent
type and copy the CPER CXL protocol errors information to a work data
structure.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 42 ++++++++++++++++++++++++++--------------
 include/cxl/event.h      | 10 ++++++++++
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e69ae864f43d3..e0f8b8ed2b7c4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -734,20 +734,12 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 }
 EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_valid);
 
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
+int cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
+				     struct cxl_cper_sec_prot_err *prot_err,
+				     int severity)
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
+		memcpy(wd->prot_err, prot_err, sizeof(wd->prot_err));
 
 		dvsec_start = (u8 *)(prot_err + 1);
 		cap_start = dvsec_start + prot_err->dvsec_len;
 
-		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
-		wd.severity = cper_severity_to_aer(severity);
+		memcpy(wd->ras_cap, cap_start, sizeof(wd->ras_cap));
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
+EXPORT_SYMBOL_GPL(cxl_cper_sec_prot_err_copy_to_wd);
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
+	if (cxl_cper_sec_prot_err_copy_to_wd(&wd, prot_err, severity))
+		return;
+
 	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
 		pr_err_ratelimited("CXL CPER kfifo overflow\n");
 		return;
diff --git a/include/cxl/event.h b/include/cxl/event.h
index e1deb66c2197e..5f06cea5d6005 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -322,12 +322,22 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
+int cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
+				     struct cxl_cper_sec_prot_err *prot_err,
+				     int severity);
 #else
 static inline int
 cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 {
 	return -EINVAL;
 }
+static inline int
+cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
+				 struct cxl_cper_sec_prot_err *prot_err,
+				 int severity)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.51.0


