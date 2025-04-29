Return-Path: <linux-pci+bounces-27015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9824AA155B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89999188A9DA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13E25333F;
	Tue, 29 Apr 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNsYLFZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16E21ADC7;
	Tue, 29 Apr 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947290; cv=none; b=XSeCjD3aeaEFQAM82iZ+YO6Lvx9fCxVXkumSEgQjaIJaFdeZXuRKMLI4YSlnO+/q/KRnMjAL4DmPYB5PGifo4kQRM1xN1h1hmY8D5zNPmvGRRRTbPhgLxC8WEoDzPhoLcQlehOCBw+UF6xfHW+DA0bO9cvV4c5XsgDJfT4dzEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947290; c=relaxed/simple;
	bh=jXYC4qe83QMGvpN4IuiBaOllJp2/Rn6mzBWJF/nv1hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emVuqTCYCId9bLr/CQwhSwi197C8PWnfQE4WO0AGq7yJuGtuNIN9xK81X01iozu9m0I1N6fPUtH0NlEJmcdnyCJRoYHU/0hmGfTWnTM3wQRmkutGQxOlvBNii1RiGBmV7W7S69c2qlZyNwvzx8WvDN+oao4PBFelrARDdQtV9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNsYLFZZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745947289; x=1777483289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXYC4qe83QMGvpN4IuiBaOllJp2/Rn6mzBWJF/nv1hc=;
  b=FNsYLFZZI27F8Dzbcl7Q3JHjtUcYEjs5oQc5dd0nayalysX46siQmfG5
   TafjOKJ4lsxIfy6TAE6JwlzAnTMbecyEoC9zYeIHEU5WFNH8N/vNa9Zc7
   J6XytXjNz1d4wVqYd50P/4cUtFx7ldm6MABev9yk7wokBJsYDa5wjK57T
   jenpz4HFz9preSXpzsQymnoVbPSKMxc6omSXOVQ+WNpEfU4H5Drlp30jU
   0u8uDYMZpf2cMbavoybLC8Fad3rulbNWmdRiXNay2pLz0tqPpXLrIkpB9
   xEDEBuiWBsDDZbljheNcQYC2o3ZtFvzy8TAGRxrXwHHMqf0Gd5hAFZINL
   A==;
X-CSE-ConnectionGUID: eZVVA5r6RJyUTGo3p+vlRw==
X-CSE-MsgGUID: 6teZHX2rQkyIaeenxXU42Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64996944"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64996944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:28 -0700
X-CSE-ConnectionGUID: zknYB+4jScW5iqrF3wMtuA==
X-CSE-MsgGUID: uop2XdxpR66xI/cEmlvLyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139073312"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:20 -0700
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
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v2] ACPI: extlog: Trace CPER Non-standard Section Body
Date: Tue, 29 Apr 2025 19:21:06 +0200
Message-ID: <20250429172109.3199192-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
References: <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
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
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 ++++++
 drivers/ras/ras.c          | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index f7fb7205028d..caca6ccd6e99 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -182,6 +182,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
index a6e4792a1b2e..ac0e132ccc3e 100644
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
2.48.1


