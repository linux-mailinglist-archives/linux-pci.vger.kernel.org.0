Return-Path: <linux-pci+bounces-16725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211139C814C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 04:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B8E283371
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9D1E6DDE;
	Thu, 14 Nov 2024 03:05:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40A91E4110;
	Thu, 14 Nov 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553506; cv=none; b=RLMpdJDed8P71SPYZHsq5yfQv1iVGyfdgYM1oF4MeVGQ7+MqmB+y1F8Pz2LEWkTcKpja0B/DMZuc4++a9SgCwcuRKUDSeNksNE1g+Hh6sjrmrVdbsohTAhjD9CuoYrSK8RVbplW+bN80HedeFxshJNkzlkEftMW64+0kqq7R6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553506; c=relaxed/simple;
	bh=qyF8KBB3Rasdxgemf6xrtpy+/qKD95OUmX31PeL52Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HA7RMy2APlAv4y1HgzaBTKQ4/iHq20Um9eTqNi2ahCjgLdPQ93AZP4lgdkf3ECpNsdF3oRZUku1bPRddRRovGMntKnCjgKhPVKbgtH+k8nkUeZtitj03AGA67t9Nc6dOEhrYCYu/Fq8qOg1g4v6jT+O5YR1ftRobAEMRe0qupBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.a9vl6Vz_1731553496 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 11:04:57 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCHv2] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev id doesn't match with spec.
Date: Thu, 14 Nov 2024 03:04:24 +0000
Message-Id: <20241114030424.45074-1-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
the code is 1.

v2:add Fixes tag.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
Origin fixes: a78cf9657ba5 ("PCI/ACPI: Evaluate PCI Boot Configuration _DSM")

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..7a4cad0c1f00 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 		 */
 		obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
 					      &pci_acpi_dsm_guid,
-					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
+					      2, DSM_PCI_PRESERVE_BOOT_CONFIG,
 					      NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
 			return true;
-- 
2.39.2


