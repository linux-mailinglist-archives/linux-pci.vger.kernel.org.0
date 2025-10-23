Return-Path: <linux-pci+bounces-39147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57640C011DD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71A3335A60E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C32C17B6;
	Thu, 23 Oct 2025 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQD9KJCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E829BDA3;
	Thu, 23 Oct 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222424; cv=none; b=U1eWYFFGPDe4Pika+7zm3qXjWTHAE+b/d2r1siql7TC4DZCaKx6fPi1tsF5zzc87yivhxG9/qyf56DJPcEZa64drJ95tnra6AxEMN23tCh+HkqIaFzBxxNtXHgwbZrkuOE+c1MLDfL1mk/b4Wd/4QfaGBUb7gd92UlhSbDwPzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222424; c=relaxed/simple;
	bh=PbFADBLewu37LDKf0I/qUmCC86OvOzKhoSduxuMrrMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egBYIU07Mo93gY0+9QcfhSzsu10AZUSMpo9sFWaGPZndnGqqKd6HllCNAo1Fsg5LRm3F2N1YBAB/4nd3oSAWKyQpOOex8XMcBPwdr8hVQ0966jaO0qg+yOTlxUP3aqVdibNy5BLNb8wT3qpXNcuunLI7fXmKRF6/+CD3TA3fhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQD9KJCQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761222422; x=1792758422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbFADBLewu37LDKf0I/qUmCC86OvOzKhoSduxuMrrMw=;
  b=ZQD9KJCQQZXP4KEfo1G37daGsD34NQVuGuVjXaqP7ZXcDJN5fD0+SNdB
   DiWIX7Xq5eyKHbWABLRWzTDoDzL+2vYYiaF9OvLxACIlEOm0GVwPPG1LF
   vmSw8KEAhNZ1WxFbta82YAYb+pVC7AQRxQKQ988TOOd30f3MIh3kzV022
   d+YjS36SarvtSKTEfUbkf2Oip6csoKA4t8+knbPUrz1pKxWuIzji4lseH
   qPPT70S/V1PieTYvitad+fRus5PPiGw15r1OuOkw4SFX4/qitqLWrp5dE
   kV9gyhwmT0jnrjc9lvzmKV8IXzDBlzsgdjE49C6Z09lJMeOZBSHZjiW17
   g==;
X-CSE-ConnectionGUID: vLHWVVJeSQ+y/QMdJsRHOA==
X-CSE-MsgGUID: kSzDrub/R7Gj1is2KQL6/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86017268"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="86017268"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:27:00 -0700
X-CSE-ConnectionGUID: jCz3Ch1MR9+KUQDQFIQXOw==
X-CSE-MsgGUID: j+jCBTy1Tf2GHqB1muXCpA==
X-ExtLoop1: 1
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.160])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:26:49 -0700
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
Subject: [PATCH 3/6 v6] acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
Date: Thu, 23 Oct 2025 14:25:38 +0200
Message-ID: <20251023122612.1326748-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
References: <20251023122612.1326748-1-fabio.m.de.francesco@linux.intel.com>
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
 drivers/acpi/apei/Kconfig | 1 +
 drivers/acpi/apei/ghes.c  | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..c265b54d810d 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -23,6 +23,7 @@ config ACPI_APEI_GHES
 	select ACPI_HED
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
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
2.51.0


