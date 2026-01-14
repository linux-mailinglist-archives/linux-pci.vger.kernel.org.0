Return-Path: <linux-pci+bounces-44728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04013D1DED7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 779E130213F9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A9318EE4;
	Wed, 14 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbjvDyCX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8533192B75;
	Wed, 14 Jan 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385765; cv=none; b=LYu336ZcT8ydufhqHbq/HATDCCNXwdXAOZiLH7c/ijMckbNKSgrpRVf0WLYQ4QTBUlDWBHNwa3XKLMf4E86MH5EDJpSjk308u0R5Fd2offLepfMgXLPJMeVbTuFl+VqiMm3xhjO6rZ4gyCDrvGzmiDmu7fwxwEV+9SK9V/45C2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385765; c=relaxed/simple;
	bh=0Jx7sgvnzmm4IhMz1DkIVr0T4vOsn+9/FVAb35DZKCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4wXICwZi8e/XetwcP6a9LhU4eBZCHvSY5oXHew3kEr/OdtwmY0m3oDy6ePM3lIYQao3/UclAUxVaIp+Y1E8ecYIR1Ph6gEdp43OlvToltc6yglPFbNbphDjD0Up3hVcW0g0oPoijUwTUg2BaOFMNDmC2P30wJ9lRYfE/AApOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbjvDyCX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385762; x=1799921762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Jx7sgvnzmm4IhMz1DkIVr0T4vOsn+9/FVAb35DZKCk=;
  b=AbjvDyCXcnZWC/cYIsZ4eEdzqgij6SE8V6RHEXRDbjJyhWePPk8lYy2P
   wlirayvUvj+5kCEO4QgLUTlexfORbSc3eQCptXBtR1egQK6P8OtB+cGx3
   D+oSKeCV2KCYHQhnJ68r7vnnXiYric+D4x3xmDgnc15wqhiHJWww1PYu2
   i58uQJr61NJaybwNAAHOSG9yBR7BtutB8NPYzn2VUHK1y12lGEwxVeOvo
   anEUI37k4Z0ytpvI0BZBj2IHo0cF1HBlhOEVjjt9peVZMj9Rr+ZOKtpgQ
   AH6KE3zAXL1IhSh+sRrYjBc35d6SAySL2EVYL/vZjsrPxDTUHuK4E5pK4
   w==;
X-CSE-ConnectionGUID: MKcLmI3gQJeZr7IdJCTkFQ==
X-CSE-MsgGUID: dX3anY07QI6NQUxJAdGl6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69765803"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69765803"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:02 -0800
X-CSE-ConnectionGUID: iYVtXrfTT3isZMTL8ZXelA==
X-CSE-MsgGUID: BKHDCLGeQqSvTScn1B0fXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208792751"
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.167])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:15:56 -0800
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 1/5 v9] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Wed, 14 Jan 2026 11:14:21 +0100
Message-ID: <20260114101543.85926-2-fabio.m.de.francesco@linux.intel.com>
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
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
 
-- 
2.52.0


