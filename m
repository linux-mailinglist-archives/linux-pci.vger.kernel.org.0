Return-Path: <linux-pci+bounces-18476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABD9F29AE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE9316494A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE521C4A13;
	Mon, 16 Dec 2024 05:44:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-30.us.a.mail.aliyun.com (out198-30.us.a.mail.aliyun.com [47.90.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C661C3F0E;
	Mon, 16 Dec 2024 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734327891; cv=none; b=sISV9Ig/Ecp5tnyhLM2uppX5eTyJ3zPHmNfCR7ZRnerqyAULod2drJoemf80AG43IJijrSPii4cmTfFTJFDJJxjT5D+E4/IpRKcGW+amWd3MmtjiioewDdxHGkhXqQ0U/JDAKu1Rj3gK0Agr9FBhV7+i5CnkuLvxwVjsDAxT9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734327891; c=relaxed/simple;
	bh=UtKh4sB1l2ldgp0NS7+RDHY00TkS6doOQ6Ouia1deeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muGJCQUf7jRh8N17ardh4Vc/LIl8azwZcBIfNeKnDT/mdPfIF/eSYsVyJkRfIPe7EsBvxTMX4d/b6FxvO11I6jw6NM7ObSnRcI9HGuCuSsNgXfQx0i6lcpcH+40e6wC/O1kXFh4bqSPAUq5Fij/0mbNaaMbDoKqDopYBtT8Ij1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.af4.atQ_1734326929 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 13:28:50 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCHv4] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id doesn't match with spec
Date: Mon, 16 Dec 2024 05:27:51 +0000
Message-Id: <20241216052751.5460-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2.
But the code remains unchanged, still 1.

v4:Initialize *obj to NULL.
v3:try revision id 1 first, then try revision id 2.
v2:add Fixes tag.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/pci-acpi.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..f805cd134019 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -123,19 +123,41 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
 	if (ACPI_HANDLE(&host_bridge->dev)) {
-		union acpi_object *obj;
+		union acpi_object *obj = NULL;
 
 		/*
-		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-		 * exists and returns 0, we must preserve any PCI resource
-		 * assignments made by firmware for this host bridge.
+		 * Per PCI Firmware r3.2, released Jan 26, 2015,
+		 * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1.
+		 * But PCI Firmware r3.3, released Jan 20, 2021,
+		 * changed sec 4.6.5 to say
+		 * "lowest valid Revision ID value: 2". So try revision 1
+		 * first for old platform, then try revision 2.
 		 */
-		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
-					      &pci_acpi_dsm_guid,
-					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
-					      NULL, ACPI_TYPE_INTEGER);
-		if (obj && obj->integer.value == 0)
-			return true;
+		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 1,
+				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
+			/*
+			 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+			 * exists and returns 0, we must preserve any PCI resource
+			 * assignments made by firmware for this host bridge.
+			 */
+			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+						      &pci_acpi_dsm_guid,
+						      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						      NULL, ACPI_TYPE_INTEGER);
+			if (obj && obj->integer.value == 0)
+				return true;
+		}
+
+		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 2,
+				   1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
+			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+						      &pci_acpi_dsm_guid,
+						      2, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						      NULL, ACPI_TYPE_INTEGER);
+			if (obj && obj->integer.value == 0)
+				return true;
+		}
+
 		ACPI_FREE(obj);
 	}
 
-- 
2.39.2


