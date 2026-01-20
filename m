Return-Path: <linux-pci+bounces-45280-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNRJOiHHb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45280-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:19:13 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD7749517
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 731BA803814
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E7326926;
	Tue, 20 Jan 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdcaY16e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC793254A0;
	Tue, 20 Jan 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923623; cv=none; b=aj+3VDbedCseC3iuMTXqewfWFuJp7CBupq10f5zQokmegR933GpAMTRW4t1jTB8FUtydQlxrko0z+9asgfruXz9U9pcs/vYB3KT8ZL/P9vHJ6Hy1j+BDxJbg++KAYscjp+bIydF0U9JfgcO4YNw8KXOoIHI6baKI+uVLYFk9sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923623; c=relaxed/simple;
	bh=JDDqSwYFPFdNPo+wfJrfkyuC39HEgDEVEXAsS2iGrgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjhUpBuurOTXLeWblwqLDVM6X56NthBhKhjya/om5qowseXIrkwxC5ATU58WrIcXHU49etGb2ou6yCtthmgHkCRLWwRLiv4+Krq9/9wl3lWiyCFmG+f9Bj6FfKVKIRW9SC9jGyNZPXDZDPOwU4FKFlQLgXJ2yxLEcfCohMnZrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdcaY16e; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768923622; x=1800459622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JDDqSwYFPFdNPo+wfJrfkyuC39HEgDEVEXAsS2iGrgA=;
  b=GdcaY16eHU7NX/jqnjYLlDRmryQQw7rWGp36jA6EKvmlVcloHt7SBXBi
   Mckx5WcvY7UNrczeQC9wmFsdgmH8ma8wP8G1zVo1reFK6VzmsYHC3hDAA
   cLxjc9Jf4EK+ztUJUGjXv9bmwHv9N3A6+MVxWyBJohQ2UEe3wZcMUs6/J
   CxMZveB14E/ZCvYj2txBcEZNpdQQlRdl7AUmIK3hs/rDcuI7EBB0xG0QA
   k6wSAvah2Xg2lrtYy0U45RwzZhuQSoh8IV6KQqqJFt/Yehdus372z+HQ1
   5gg3rNvJJhxPnjj7QQiFl0l1COkQyK4BC6Ef8WXiTK+t0XheAJPKsH0kD
   A==;
X-CSE-ConnectionGUID: BjZropz9Q4iXRdTaBqwRRA==
X-CSE-MsgGUID: yKwLFdLcSPi86/rQ7hpVFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74003571"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="74003571"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:40:21 -0800
X-CSE-ConnectionGUID: dPmelVMISu2HqsQy/FSosg==
X-CSE-MsgGUID: aWIltVHTQt+32AFN/1ZsPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="237410797"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jan 2026 07:40:18 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 13B3498; Tue, 20 Jan 2026 16:40:18 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
Date: Tue, 20 Jan 2026 16:40:15 +0100
Message-ID: <20260120154015.1764021-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-45280-lists,linux-pci=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Queue-Id: ACD7749517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now we have a helper so there's no need to open-code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pci_slot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 741bcc9d6d6a..1053ab4a9681 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -42,8 +42,9 @@ static int
 check_slot(acpi_handle handle, unsigned long long *sun)
 {
 	int device = -1;
-	unsigned long long adr, sta;
+	unsigned long long sta;
 	acpi_status status;
+	u64 adr;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
@@ -56,10 +57,9 @@ check_slot(acpi_handle handle, unsigned long long *sun)
 			goto out;
 	}
 
-	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-	if (ACPI_FAILURE(status)) {
-		pr_debug("_ADR returned %d on %s\n",
-			 status, (char *)buffer.pointer);
+	if (acpi_get_local_u64_address(handle, &adr))
+		pr_debug("_ADR returned with failure on %s\n",
+			 (char *)buffer.pointer);
 		goto out;
 	}
 
-- 
2.50.1


