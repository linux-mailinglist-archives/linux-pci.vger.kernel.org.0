Return-Path: <linux-pci+bounces-23593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC06A5F041
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07815188BB58
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA26265605;
	Thu, 13 Mar 2025 10:07:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C561BC5C;
	Thu, 13 Mar 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860455; cv=none; b=jvrMS1eQ0xFM9m4VGSaTNCeO08ycVaQn3CIljgDairI3VI0DWGgc+xdfTMWLNH/k6QV/LRNmndf5ppbzf8CCei3PXvrEMIs25ecH+kNJucUH/d3mvT/CnABwItcykrjYezSsOxvdP8mgPd12v1taVZh/LMxIMVUHMo8EaHEh3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860455; c=relaxed/simple;
	bh=zvbPfCLNKc8V9LagADA8Bo6HWwITIiFmeG6g0Erq4Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9DYHCUCGC+pNO66HtqSPUABExO5co7SnoUkFNtlJ4cNRTXG0Tjr3l6+O3s63MSGTFfYOvylaGQTJyfqVieGlO1AF1pyUxbYxse7nokn9uQzqRB4vB6pX/Eyl2i1w42vg34H5Kgm6o9ip0cxc+xsBXuTVYl4rFeW12ASeSKbLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.bsXubKn_1741860439 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 18:07:19 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rafael@kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v5 1/2] Add rev 2 check for PRESERVE_BOOT_CONFIG function
Date: Thu, 13 Mar 2025 10:06:55 +0000
Message-Id: <20250313100658.15805-1-zhoushengqing@ttyinfo.com>
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

And add acpi_check_dsm() for DSM_PCI_PRESERVE_BOOT_CONFIG.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
v5:follow Bjorn advice, add acpi_check_dsm for PCI _DSM.
v4:Initialize *obj to NULL.
v3:try revision id 1 first, then try revision id 2.
v2:add Fixes tag.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_re")
---
 drivers/pci/pci-acpi.c | 43 ++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..4f9e0548c96d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -122,24 +122,43 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
-	if (ACPI_HANDLE(&host_bridge->dev)) {
-		union acpi_object *obj;
+	bool rc = false;
+	union acpi_object *obj;
 
-		/*
-		 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-		 * exists and returns 0, we must preserve any PCI resource
-		 * assignments made by firmware for this host bridge.
-		 */
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
+	if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
+				&pci_acpi_dsm_guid, 1, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG))) {
 		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
-					      &pci_acpi_dsm_guid,
-					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
-					      NULL, ACPI_TYPE_INTEGER);
+						&pci_acpi_dsm_guid,
+						1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
-			return true;
+			rc = true;
+		ACPI_FREE(obj);
+	} else if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
+					&pci_acpi_dsm_guid, 2, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG))) {
+		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
+						&pci_acpi_dsm_guid,
+						2, DSM_PCI_PRESERVE_BOOT_CONFIG,
+						NULL, ACPI_TYPE_INTEGER);
+		if (obj && obj->integer.value == 0)
+			rc = true;
 		ACPI_FREE(obj);
 	}
 
-	return false;
+	return rc;
 }
 
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
-- 
2.39.2


