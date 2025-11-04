Return-Path: <linux-pci+bounces-40271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AADC32A28
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F923BFB39
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9AF33E37A;
	Tue,  4 Nov 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4AxEtc/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEE334363;
	Tue,  4 Nov 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280708; cv=none; b=o+vjDKy8fH1qxcqIXwVzbstQaJCkHihOnDGMB4ylRq7hWIZ7kyl5ax8gEEL9MFUKdHuJTa1rVy822sdhxoErF3FxKqSTtAMxG5J6+7DI+TadmI1LJp3iF6rdlPDgOGOGvaSq0HZ+jzB14Y8MOKQfhppQvosSEcjIyU55AobQj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280708; c=relaxed/simple;
	bh=JIu0H882zeEEwASgSxIs/RNeqglbdddbmIWfUmz8pZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaFnQROpOvrJDZ4hWfjzgdwVOT/imSihKQRVGHPprbQAHqpGIlufvwCcpaYm0zYmfDP3WJpGM6oCtejbcgjzEFuKWrHS/eyEwcI8fat1c4MSFMBcHBLyzQlCBe9m10iTNT+sslIqx70FLX3mRAccoafy/FDhhd0pE6Bx9UeZAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4AxEtc/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280706; x=1793816706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIu0H882zeEEwASgSxIs/RNeqglbdddbmIWfUmz8pZM=;
  b=Z4AxEtc/9K+JRvTrK0lxqY1lMKmkLRiEgsnc4OEEtLuaWO1smAZ8iPBV
   3yBEWkKi9zwrsR489kGAchL0uFcXMAM9ldLMIOZIoAGMiR5WKRKZ04k0K
   rFCj80swYopmZiC9y3CMdkF05R/S2Cv4Wh/dnB5630bUD4FQP6xGV0C7G
   MRuXVz42Hi5nqass+ivMQRvCPjJ8f4BQ19szAS8E6NYXzi22jWkud9Be+
   IncOLLNOeuvuUh4PeW7HtcrwQKSEuEW2/z7Ux5skRNwas625FZB4jQGVE
   KdCnV6sZ+SmuN6bh6fcpCFO4kLJkabeszc1wNTWDjLcrP3sxZTMGbq75V
   Q==;
X-CSE-ConnectionGUID: S7SuuvJ2QtG7vsCIVYxNUA==
X-CSE-MsgGUID: 7ENhNzuDTkmWmzbgMbqWMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64269551"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="64269551"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:05 -0800
X-CSE-ConnectionGUID: mTIV4eveQ4yH/f/YViQGWw==
X-CSE-MsgGUID: QFkgXDdGSxCVwDeZlZjtvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191325244"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:24:59 -0800
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 1/6 v7] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Tue,  4 Nov 2025 19:22:32 +0100
Message-ID: <20251104182446.863422-2-fabio.m.de.francesco@linux.intel.com>
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

ghes_do_proc() has a catch-all for unknown or unhandled CPER formats
(UEFI v2.11 Appendix N 2.3), extlog_print() does not. This gap was
noticed by a RAS test that injected CXL protocol errors which were
notified to extlog_print() via the IOMCA (I/O Machine Check
Architecture) mechanism. Bring parity to the extlog_print() path by
including a similar log_non_standard_event().

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f6b9562779de..47d11cb5c912 100644
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
 
-- 
2.51.1


