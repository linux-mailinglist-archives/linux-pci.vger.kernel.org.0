Return-Path: <linux-pci+bounces-28869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C401AACCAB2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AF216EA2C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47C23C8AA;
	Tue,  3 Jun 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NseYRNT2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8B23BCFA;
	Tue,  3 Jun 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966157; cv=none; b=LfbXzhYoBvnaO+TsfG9S4nsJWZLxyLESKknJMKX/Sif14ADPA5UhERx/e/4k1Lgt8jnaF9bDT5rGWvDoMUv1VTs4ly9JYh4zlIVWe/t5oLOVjZ+sIO0wib41dS8Ngx2BAtVshnGLe7paNxVliZi2lITpWwLFFaiMP0zx82dLVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966157; c=relaxed/simple;
	bh=NYKZkS68/255/Qa6jdHtwiii8rQH5UhEATWNB/Ewplk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8WqHRbSJfwLDs+OXI9dieWtbm8/BtNRrSNZW0JOp9jIMbgD3JbV9MPv9AbTEVc7LP/ydirzxbYJyNHSBD6pX4St9YDelyqoXgKj6rTQLCMrRQe7YY/J3IrUewranY3mUa+LpkrUFLa/bgycFKkadQSuZXe5GAIfSS8rffKO9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NseYRNT2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748966156; x=1780502156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NYKZkS68/255/Qa6jdHtwiii8rQH5UhEATWNB/Ewplk=;
  b=NseYRNT2KUJo1lHgnXxrMt1KCSCFMKkM6G5Yg87kj96H+nv4Wn+fUhJj
   ak2YxiS1rGD0YcGH5LVTjvNL3GNlHB9xoFSdYGczazjLKRF6dBokA59rl
   s0dgunsjlQsHivSlmhgHqYVl9stpA2N76AOjHyIlwXpnJUT/6RCCNOGy2
   4K7ZKmu3FkPmzlmxQ/rLNjC+mXVTtDIGMBVdAQp82z0A8GJ2o6GFCyfFY
   5arOtNaLect3aA9penmM46+mdoJd2CmvTomIU6d4DK3Vq07vOCyWm9p1o
   Bn13i7h+hfb11UKhWqPtQ8cKpXWmE8kh4Hq5/W4TW2Y9DI+N5PcQ++KZe
   w==;
X-CSE-ConnectionGUID: LBZxZXFNSwaaP5ffbwUp4g==
X-CSE-MsgGUID: tsbpfGXiTMeEt3I5f77mDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62066974"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62066974"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:55:55 -0700
X-CSE-ConnectionGUID: V5GGI+JjTjWmKM6FV+wLKw==
X-CSE-MsgGUID: veCWw0FuT7Kiy1bRI8pvow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="175766102"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:55:48 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/4 v3] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Tue,  3 Jun 2025 17:54:36 +0200
Message-ID: <20250603155536.577493-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


