Return-Path: <linux-pci+bounces-30404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37126AE478D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9917A2E94
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06F426B2D2;
	Mon, 23 Jun 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjMJxOfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50D26C3AD;
	Mon, 23 Jun 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690527; cv=none; b=eaxZI2CmUZYep+GRh+iPRx4mhY2Kh/TCo4fvafBVfIsC5ul/GrxIOsi44m27ShV5PTi2rQJZ4bPymKP1jhHLHRCa6ggE+aLy6VmE19412Pn8wDtGgcJ7wphmlFeK0rFcM4XSgGQjzlcJ7k6eGkzXvLceQjZ8DJEgo9CI2syHnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690527; c=relaxed/simple;
	bh=2Djwh9R6hBccpGx1AQ8wwl8i3I/wzz5QSLqhQ76JIXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSt+xwY42MYzZtXBDeHPylnMvWCUEbIZZBw35uCo2D7C86Q4EnLnQTdYPCedW9rdoSlAT34GUQxH4YgyUHEEIb6z5YXxi/2LRsOd87oHsE2ww6maD1DHwAnnIounL6iC5lCy1N+Uwq9xtY7qqnHz8z4dZvhUYoV22GKiN8Yq8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjMJxOfZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750690526; x=1782226526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Djwh9R6hBccpGx1AQ8wwl8i3I/wzz5QSLqhQ76JIXU=;
  b=OjMJxOfZWG+oxPoypbs+YINAxQj724BJc6OhBFWVqVJxVt7kJepCtnlb
   kpAHgVw56ocHDTqJUSrTEuqEyf/nQHQ8NC4xgVyoz9J/JtuewtEyDF+MG
   hgBdCyzq9Jz7hQ/lvs0v5phc0UUx3IostFQihMclSh28+/dYV6j3ZqWGe
   reV84FQooA0VVujLRAZopnfNF9P72VYXebN5GcQh6WIMEVtFjAcrKhPV0
   8/AfsVYx3/uZaitO68zmm/1mGQ3+98uURLUS7wM2Hyb93bOkUiZsfJdUg
   neZPp/OwQhwyRqBbJUaJcZ/Ozl5t3O9d8K58yX86ZYhPocinqSHqPfCC5
   w==;
X-CSE-ConnectionGUID: P27U970EQlOMu4NWQalK7A==
X-CSE-MsgGUID: Cr5srPa7Sy+xUmOZHTxtfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53042674"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53042674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:55:17 -0700
X-CSE-ConnectionGUID: JUZBZciTSkCmzXGLOVTvvA==
X-CSE-MsgGUID: g2Qa8/oDRMuN0zRUtIDi7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155997395"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.11])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:55:09 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
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
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-edac@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 1/3 v4] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Mon, 23 Jun 2025 16:54:18 +0200
Message-ID: <20250623145453.1046660-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623145453.1046660-1-fabio.m.de.francesco@linux.intel.com>
References: <20250623145453.1046660-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ghes_do_proc() has a catch-all for unknown or unhandled CPER formats
(UEFI v2.10 Appendix N 2.3), extlog_print() does not. This gap was
noticed by a RAS test that injected CXL protocol errors which were
notified to extlog_print() via the IOMCA (I/O Machine Check
Architecture) mechanism. Bring parity to the extlog_print() path by
including a similar log_non_standard_event().

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 drivers/ras/ras.c          | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f6b9562779de0..47d11cb5c9120 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -183,6 +183,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			log_non_standard_event(sec_type, fru_id, fru_text,
+					       gdata->error_severity, err,
+					       gdata->error_data_length);
 		}
 	}
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e9..ac0e132ccc3eb 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 {
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
+EXPORT_SYMBOL_GPL(log_non_standard_event);
 
 void log_arm_hw_error(struct cper_sec_proc_arm *err)
 {
-- 
2.49.0


