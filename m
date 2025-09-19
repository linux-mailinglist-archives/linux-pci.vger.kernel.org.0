Return-Path: <linux-pci+bounces-36489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16DB89DFA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936863B1C2E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4E3148B6;
	Fri, 19 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKQVyFKg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A9313D77
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291763; cv=none; b=r0agGd5vjSukuQ3KQYrooIIP4vkcwUuhyMokLYI0dTkcy6YRrKkL1tuiktU1u/kXzlq1dCoKDDxUbtQUlr60KZzsUgNIdycbbHRQD+Hv2K4c8mJIUE2mnpRFb+6d19mDk6xg6dEmo5e9ZY6wmDKVNyH01j58/kMCgQBkvRvolt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291763; c=relaxed/simple;
	bh=xOewYnABRl34KfOsLldnTSEaY/HvcrvopC1+RQ7lCrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWdFYBnj27jVIOZNh5Lod2iyiUCxb3Z5z/Ay9mkERQJT2dVC3VyUu92/fljLjGDoBqAw0mHaCuj6IjNgYF7F6fA3w4QsJL0c1kiA1pZReE4ZbwQjgqrm/MInYdzvnGL/77oNVSsYwDnJJQs7btRqPiwlN2ON/TfTcTf7ofiQu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKQVyFKg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291762; x=1789827762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xOewYnABRl34KfOsLldnTSEaY/HvcrvopC1+RQ7lCrY=;
  b=OKQVyFKgzMhcklvMeQuwHy1MhbeLECA/UqP7Ivjt8eRTUwZu6Yofufeo
   5zzKajOnSjrhSqMvK3cwN4Ndid142IvhKxYhOnutaVOk8kW4+MuyfOn0m
   ssn03KB8LOFjGwsPkgqHknlsi+N7iaDxvFhSlqRWYhy2jdXx5J6C/v5dy
   5BdTgmfwQm4APLhalIDc4V3iVSFysciehjzZBQ9dcLYKEHrZ4RgkZVim4
   XoG7Yd2IJg8HJ2uZ4Ak3uJcqw/ycxkGREhCoKveHiVQmsz12a1wkGoshv
   l2QcA8sGSKQErtKRN6MrrbhnTEzQgT46Z6l0j6YEf0u6kx7Apuc79VWiS
   g==;
X-CSE-ConnectionGUID: B/N78Gx8SL6W6MjZrbWNeA==
X-CSE-MsgGUID: W0/ov00DTni2fEtoRS6IGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750528"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750528"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:38 -0700
X-CSE-ConnectionGUID: ad6ZtrOtQbmObl9/ila9Lg==
X-CSE-MsgGUID: qxXb4gIRQ0CbnBxmX5M0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655017"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 09/27] ACPICA: Add KEYP table definitions
Date: Fri, 19 Sep 2025 07:22:18 -0700
Message-ID: <20250919142237.418648-10-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919142237.418648-1-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Add KEYP ACPI table definition defined by [1].

Software uses this table to discover the base address of the Key
Configuration Unit (KCU) register block associated with each IDE capable
host bridge. TDX host only gets the max IDE streams supported from KCU,
it doesn't access other parts since host won't directly touch the host
side IDE configuration, TDX Module does.

[1]: Root Complex IDE Key Configuration Unit Software Programming Guide
     https://cdrdv2.intel.com/v1/dl/getContent/732838

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: do the proper ACPICA flow for this]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/acpi/actbl3.h | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 79d3aa5a4bad..807135e115d0 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -24,6 +24,7 @@
  * file. Useful because they make it more difficult to inadvertently type in
  * the wrong signature.
  */
+#define ACPI_SIG_KEYP           "KEYP"  /* Key Programming Interface for IDE */
 #define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SLIT           "SLIT"	/* System Locality Distance Information Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
@@ -794,6 +795,65 @@ struct acpi_table_xenv {
 	u8 event_flags;
 };
 
+/*******************************************************************************
+ *
+ * KEYP - Key Programming Interface for Root Complex Integrity and Data
+ *	  Encryption (IDE)
+ *        Version 1
+ *
+ * Conforms to "Key Programming Interface for Root Complex Integrity and Data
+ * Encryption (IDE)" document. See under ACPI-Related Documents.
+ *
+ ******************************************************************************/
+
+struct acpi_table_keyp {
+	struct acpi_table_header header;
+	u32 reserved;
+};
+
+/* KEYP common subtable header */
+
+struct acpi_keyp_common_header {
+	u8 type;
+	u8 reserved;
+	u16 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_keyp_type {
+	ACPI_KEYP_TYPE_CONFIG_UNIT = 0,
+};
+
+/* Root Port Information Structure */
+
+struct acpi_keyp_rp_info {
+	u16 segment;
+	u8 bus;
+	u8 devfn;
+};
+
+/* Key Configuration Unit Structure */
+
+struct acpi_keyp_config_unit {
+	struct acpi_keyp_common_header header;
+	u8 protocol_type;
+	u8 version;
+	u8 root_port_count;
+	u8 flags;
+	u64 register_base_address;
+	struct acpi_keyp_rp_info rp_info[];
+};
+
+enum acpi_keyp_protocol_type {
+	ACPI_KEYP_PROTO_TYPE_INVALID = 0,
+	ACPI_KEYP_PROTO_TYPE_PCIE,
+	ACPI_KEYP_PROTO_TYPE_CXL,
+	ACPI_KEYP_PROTO_TYPE_RESERVED
+};
+
+#define ACPI_KEYP_F_TVM_USABLE		(1)
+
 /* Reset to default packing */
 
 #pragma pack()
-- 
2.51.0


