Return-Path: <linux-pci+bounces-36492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C263B89E06
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F353B421A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3B313D68;
	Fri, 19 Sep 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Up272hRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5413148C3
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291765; cv=none; b=LSXjQuWPoJeDqAW+wp6+b+WtVfgqnKxGXmj9wpZBQeq3rEBsVOQHywAMLr5KzBszQroAeaMkwjAcrxa7ZJclLAU7eSPzneO95j1EvkCyjCgJtEfdPR1f9Ctz/633q1KthT8uVnNWl3mCoPT+wIP/waNNRRrKrJxqq4hqtunvXF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291765; c=relaxed/simple;
	bh=E3dL3oxWta3xgRIz6vny2WQW9mMupe7mYbnmMlKiju8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGhUB+K7vpcMjCkjD/KW9GcEh7/r2msDBlyjLcPriIUkwLiCfpYEld54rAuPFfsCkxUbmKnYn8GYgSw4eiGi4yekCNPiRMfStwi33Dj8CCQH/MMGKQ7PtXOP3xecSx3ag2Pdo4B2sgiF+6kUZ/P3sYkPKIOiObygKIQ+oTZ+ODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up272hRm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758291764; x=1789827764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3dL3oxWta3xgRIz6vny2WQW9mMupe7mYbnmMlKiju8=;
  b=Up272hRmrZS8ncDSwSXWt0rD3iSrproGpCr4gI3MZ9uWkbYw9/71ouOa
   Je68J1br3o+kP1dBdSwv8q/dzKyW4cKsYiD6HGE4ezklp544I4JiEH0I5
   DI/dKCGqA6bfJcNLzeay+hgAX7Mvmy5z7nzCXvhm0jy9UWzG8sTIcByXJ
   TTie3BWTq0uYWngcJnXn5uzj++xsmUBupc1RKoCWKIx1e/OhuBR/q6WHL
   JPUHWzFsLgSCbJ+2rg5fXyOAbW5sBlFCsEWxd2Jo7+md9AyrguyYrVJGJ
   4Y9fkVCmgRE+deuwpoh+enWq5kSt5VmNO7CysS4Ym6bF6YH1PfD87EFiT
   A==;
X-CSE-ConnectionGUID: g+OIINz6Q62QwT2HxQrXHg==
X-CSE-MsgGUID: oDmY8WROQJ+x9An1wrbVYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60750531"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60750531"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 07:22:38 -0700
X-CSE-ConnectionGUID: LcTRxD12Rnmx9JdqreaWtw==
X-CSE-MsgGUID: Gjq/GFE+TKKnbqRk4KqkLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176655020"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 07:22:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: xin@zytor.com,
	chao.gao@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [RFC PATCH 10/27] acpi: Add KEYP support to fw_table parsing
Date: Fri, 19 Sep 2025 07:22:19 -0700
Message-ID: <20250919142237.418648-11-dan.j.williams@intel.com>
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

KEYP ACPI table can be parsed using the common fw_table handlers. Add
additional support to detect and parse the table.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
[djbw: todo: drop config symbol for this]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig     | 12 ++++++++++++
 drivers/acpi/tables.c    | 14 +++++++++++++-
 include/linux/acpi.h     | 13 +++++++++++++
 include/linux/fw_table.h |  1 +
 lib/fw_table.c           |  9 +++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b594780a57d7..e9af80d69e02 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -600,6 +600,18 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ACPI_KEYP
+	bool "ACPI KEYP Table Support for Integrity and Data Encryption (IDE)"
+	depends on X86_64
+	default y
+	help
+	  Platform KEYP table holds the KEY Configuration Unit (KCU) structures
+	  and the base address of the KCU register block associated with each
+	  IDE capable host bridge. Host parses this table to gets the max IDE
+	  streams supported by each host bridge.
+
+	  Say Y to enable KEYP table parsing for IDE stream creation.
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fa9bb8c8ce95..37c72d31eac8 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -299,6 +299,18 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 }
 EXPORT_SYMBOL_ACPI_LIB(acpi_table_parse_cedt);
 
+#ifdef CONFIG_ACPI_KEYP
+int __init_or_acpilib
+acpi_table_parse_keyp(enum acpi_keyp_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg)
+{
+	return __acpi_table_parse_entries(ACPI_SIG_KEYP,
+					  sizeof(struct acpi_table_keyp), id,
+					  NULL, handler_arg, arg, 0);
+}
+EXPORT_SYMBOL_ACPI_LIB(acpi_table_parse_keyp);
+#endif
+
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
@@ -408,7 +420,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __nonstring_array __initconst
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
 	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
-	ACPI_SIG_NBFT };
+	ACPI_SIG_NBFT, ACPI_SIG_KEYP };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1c5bb1e887cd..36662c1c7de4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -235,6 +235,19 @@ int __init_or_acpilib
 acpi_table_parse_cedt(enum acpi_cedt_type id,
 		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
 
+#ifdef CONFIG_ACPI_KEYP
+int __init_or_acpilib
+acpi_table_parse_keyp(enum acpi_keyp_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
+#else
+static inline int acpi_table_parse_keyp(enum acpi_keyp_type id,
+					acpi_tbl_entry_handler_arg handler_arg,
+					void *arg)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index 9bd605b87c4c..293252cb0b7e 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -36,6 +36,7 @@ union acpi_subtable_headers {
 	struct acpi_prmt_module_header prmt;
 	struct acpi_cedt_header cedt;
 	struct acpi_cdat_header cdat;
+	struct acpi_keyp_common_header keyp;
 };
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
diff --git a/lib/fw_table.c b/lib/fw_table.c
index 16291814450e..147e3895e94c 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -20,6 +20,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
 	CDAT_SUBTABLE,
+	ACPI_SUBTABLE_KEYP,
 };
 
 struct acpi_subtable_entry {
@@ -41,6 +42,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return entry->hdr->cedt.type;
 	case CDAT_SUBTABLE:
 		return entry->hdr->cdat.type;
+	case ACPI_SUBTABLE_KEYP:
+		return entry->hdr->keyp.type;
 	}
 	return 0;
 }
@@ -61,6 +64,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		__le16 length = (__force __le16)entry->hdr->cdat.length;
 
 		return le16_to_cpu(length);
+	case ACPI_SUBTABLE_KEYP:
+		return entry->hdr->keyp.length;
 	}
 	}
 	return 0;
@@ -80,6 +85,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->cedt);
 	case CDAT_SUBTABLE:
 		return sizeof(entry->hdr->cdat);
+	case ACPI_SUBTABLE_KEYP:
+		return sizeof(entry->hdr->keyp);
 	}
 	return 0;
 }
@@ -95,6 +102,8 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_CEDT;
 	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
 		return CDAT_SUBTABLE;
+	if (strncmp(id, ACPI_SIG_KEYP, 4) == 0)
+		return ACPI_SUBTABLE_KEYP;
 	return ACPI_SUBTABLE_COMMON;
 }
 
-- 
2.51.0


