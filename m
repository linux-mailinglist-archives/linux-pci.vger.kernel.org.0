Return-Path: <linux-pci+bounces-29015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914DEACEA90
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 09:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB1189730B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 07:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833CF1FE44A;
	Thu,  5 Jun 2025 06:59:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E121C84D9;
	Thu,  5 Jun 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106782; cv=none; b=iZZXtAkdlADDqI7HA29lbpE8Z8KR5kWbTiW6XvRITlHRfsC1HJNNJPVFv92bQmFBUO+Ok9YE4/Jii2wPqQCUaagqY2B3Ms48KhJ6bXGI0O4F2wNOpoionugcoS4wz6yIDKFz5mSHxhssEGIiJaDuLw/xpNOyTPPbMqDYmWbhUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106782; c=relaxed/simple;
	bh=4hPtXI/lyb7DqoRkDNQNpa41b8fqt7lcwCiqE+1QotY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBO7jeTjEj0M4S1gLKA29rorxl3jxWLer8NNyXV/2wgS3Mvyd4c4/O5GPGPQ5Js1X2RCu9XIeqOeMMfme7Q6D+qitA+Yb9+Y01SUwrHHf9nKA+YmjuTLDLMIbxDMu4prCXFBydpCsorlu2qEeRVAZzq8MZ7a0Tc1FcYLQoxMmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.dBaQkKN_1749106759 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 14:59:28 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v6 1/2] PCI/ACPI: Add rev 2 check for PRESERVE_BOOT_CONFIG function
Date: Thu,  5 Jun 2025 06:58:13 +0000
Message-Id: <20250605065814.41298-2-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250605065814.41298-1-zhoushengqing@ttyinfo.com>
References: <20250605065814.41298-1-zhoushengqing@ttyinfo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2.

So add rev2 check and add acpi_check_dsm() for DSM_PCI_PRESERVE_BOOT_CONFIG.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
v6:follow Rafael advice, revise code style(use for-loop to check revision).
v5:follow Bjorn advice, add acpi_check_dsm for PCI _DSM.
v4:Initialize *obj to NULL.
v3:try revision id 1 first, then try revision id 2.
v2:add Fixes tag.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_re")
---
 drivers/pci/pci-acpi.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..c49abd03daf0 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -122,22 +122,40 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
-	if (ACPI_HANDLE(&host_bridge->dev)) {
-		union acpi_object *obj;
+	bool rc = false;
+	u64 rev;
+	union acpi_object *obj;
+
+	if (!ACPI_HANDLE(&host_bridge->dev))
+		return false;
+
+	/*
+	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
+	 * exists and returns 0, we must preserve any PCI resource
+	 * assignments made by firmware for this host bridge.
+	 *
+	 * Per PCI Firmware r3.2, released Jan 26, 2015,
+	 * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1. But PCI Firmware r3.3,
+	 * released Jan 20, 2021, changed sec 4.6.5 to say
+	 * "lowest valid Revision ID value: 2". So check rev 1 first, then rev 2.
+	 */
+	for (rev = 1; rev <= 2; rev++) {
+		if (!acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
+					&pci_acpi_dsm_guid, rev, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG)))
+			continue;
 
-		/*
-		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-		 * exists and returns 0, we must preserve any PCI resource
-		 * assignments made by firmware for this host bridge.
-		 */
 		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
-					      &pci_acpi_dsm_guid,
-					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
-					      NULL, ACPI_TYPE_INTEGER);
+						&pci_acpi_dsm_guid, rev,
+						DSM_PCI_PRESERVE_BOOT_CONFIG,
+						NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
-			return true;
+			rc = true;
+
 		ACPI_FREE(obj);
-	}
+
+		if (rc)
+			return true;
+ 	}
 
 	return false;
 }
-- 
2.39.2


