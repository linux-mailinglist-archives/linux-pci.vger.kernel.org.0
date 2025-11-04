Return-Path: <linux-pci+bounces-40273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380DFC32A3A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F4B421BCA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8C33E376;
	Tue,  4 Nov 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNxm05mg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBD335097;
	Tue,  4 Nov 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280721; cv=none; b=T30NxZFL6AOuhrgOmyqTvaWKWL2nAIM13yNvFBT6Ujaq3XMIQGJbxmaiyYx5nO90LRik+OP9j50f7LSqGUhiDPcfIpdsktHg/srvs/5yxrdXE9/MgpvudqU2uCJWary2ik/9JlqOzIxnCO8kCtcpd61ama3d5O3gegyTVjmIelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280721; c=relaxed/simple;
	bh=QnhXMP7wXOVrP174faH3L+NNwVmNt29iN5MSC3ZkiGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJqkMWrXLwaIy0RqLF8TkmGCNZ+/mUR+jX0Nc8YncklxfVLnVfQjFy7f7qqLambnSYRSMFDPU+FgzjFuI7uBZMhWDplBUfS8ZTS+E4eZD1VqvwC/UsRpfBmkL1UJSvzAoSV3RMzXkAPbw9Z3rbCjnJh6UXfC41th2z7GpRCOrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNxm05mg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280719; x=1793816719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnhXMP7wXOVrP174faH3L+NNwVmNt29iN5MSC3ZkiGw=;
  b=XNxm05mgOPpd8bjXHEnxAhNCXz7diOdlLrhrmqDHa5bJkl87tTdBw1qY
   B6Loag7iK3rE7sDrrqiFqNskLI7oe/VGvSRX7qFr6+Wk6Uabxae2aFM7u
   3QkeID4gakQq7DZS9ClcL8TUcZidGw97VnfRFU8xOHVeHEK0DfBQCO85y
   Op4AJtTXAvey0KD95B0Tvp3jm+7BHrmepkpOmpwLMG4KEmO9kA5JMskVm
   IqElIltxlb3q8B/QgcJ5VXfK8DRTeW2NDKquLZUOJYlDO9ZQSYNd2N7Zg
   rMBNeHVXPV4BTkJrdhvnBlFXEBjROSz0Cf2W5rI5g2axLjJo2WjvJl2nH
   Q==;
X-CSE-ConnectionGUID: x6O0u16QRfScNlWK5vGGHw==
X-CSE-MsgGUID: N+4yg0GeSumvjw9Q8VUJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64310728"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64310728"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:18 -0800
X-CSE-ConnectionGUID: TFUlblptQpmM9/IBwY0GSw==
X-CSE-MsgGUID: 5/n0eOw7TxOgKhGVuQFCFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191325308"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:25:13 -0800
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
Subject: [PATCH 3/6 v7] acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
Date: Tue,  4 Nov 2025 19:22:34 +0100
Message-ID: <20251104182446.863422-4-fabio.m.de.francesco@linux.intel.com>
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

GHES handles the PCI Express Error Section and also the Compute Express
Link (CXL) Protocol Error Section. Two of its functions depend on the
APEI PCIe AER logging/recovering support (ACPI_APEI_PCIEAER).

Make GHES select ACPI_APEI_PCIEAER and remove the conditional
compilation from the body of two static functions that handle the CPER
Error Sections mentioned above.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/apei/Kconfig | 2 ++
 drivers/acpi/apei/ghes.c  | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..cdf3cfa233b9 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -23,6 +23,8 @@ config ACPI_APEI_GHES
 	select ACPI_HED
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
+	select PCIEAER
+	select ACPI_APEI_PCIEAER
 	select ARM_SDE_INTERFACE if ARM64
 	help
 	  Generic Hardware Error Source provides a way to report
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..d6fe5f020e96 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -613,7 +613,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
  */
 static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 {
-#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
@@ -646,7 +645,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 				  (struct aer_capability_regs *)
 				  aer_info);
 	}
-#endif
 }
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
@@ -711,7 +709,6 @@ struct work_struct *cxl_cper_prot_err_work;
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 				   int severity)
 {
-#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 	u8 *dvsec_start, *cap_start;
 
@@ -767,7 +764,6 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	}
 
 	schedule_work(cxl_cper_prot_err_work);
-#endif
 }
 
 int cxl_cper_register_prot_err_work(struct work_struct *work)
-- 
2.51.1


