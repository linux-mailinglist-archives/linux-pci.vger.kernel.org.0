Return-Path: <linux-pci+bounces-18441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91D9F1E18
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34603165CC1
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B1185B5F;
	Sat, 14 Dec 2024 10:41:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF458EBE;
	Sat, 14 Dec 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734172908; cv=none; b=EVjdhsCWz70LOwQdYHhS12IaMoO04j8X8N9ZcF9x7z9uZ4hUJ/tlUJmhyKKlz4iwLm5ndOn7l0eWfsperQSF1VdGI0y7vrZZGXxh8fw2Qgj+8WOTB8JzkXJ3XMbHD5TkcQZmRg6TQRT0rq/Cb6YmwOg3CmIZkHp3iqRlpjg1Wq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734172908; c=relaxed/simple;
	bh=FPKtc4NpB2sSauZLf74YBA7lW2hOS1Ex1fVKWh3Huwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h0nljNbY/Vp5n4l4XCDv1EKfCqQ7r+tCtTUDlGKTgYar8MWlzIh2mmoooout5pzzFUbMyhQ8CS/Mi2itSzX/6C0SML2Lw05Vx93i1A2j0csOcFkZeuNE7EJSMmbg9THGopVKVKr7ioZ36cNTO+VFRaO6/KGHxlb6gpuSL3wfk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.ae1gHDB_1734172881 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 14 Dec 2024 18:41:22 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCHv3] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id doesn't match with spec
Date: Sat, 14 Dec 2024 10:41:17 +0000
Message-Id: <20241214104117.17973-1-zhoushengqing@ttyinfo.com>
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

v3:try revision id 1 first, then try revision id 2.
v2:add Fixes tag.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/pci-acpi.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..ae3b315d708c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -126,16 +126,38 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 		union acpi_object *obj;
 
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
+			    1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
+			/*
+			 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+			 * exists and returns 0, we must preserve any PCI resource
+			 * assignments made by firmware for this host bridge.
+			 */
+			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+							  &pci_acpi_dsm_guid,
+						  1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						  NULL, ACPI_TYPE_INTEGER);
+			if (obj && obj->integer.value == 0)
+				return true;
+		}
+
+		if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev), &pci_acpi_dsm_guid, 2,
+			    1ULL << DSM_PCI_PRESERVE_BOOT_CONFIG)) {
+			obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+							  &pci_acpi_dsm_guid,
+						  2, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						  NULL, ACPI_TYPE_INTEGER);
+			if (obj && obj->integer.value == 0)
+				return true;
+		}
+
 		ACPI_FREE(obj);
 	}
 
-- 
2.39.2


