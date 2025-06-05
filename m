Return-Path: <linux-pci+bounces-29016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D1ACEA95
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F141759C8
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251991F8BC6;
	Thu,  5 Jun 2025 07:00:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF91F3FE8;
	Thu,  5 Jun 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106800; cv=none; b=Vt5hH1voogN/xWbR9mmYThtF06Nl/FYOA9ppmMUVgXZudn1UZ14n0rFa/FqeR5PxTEqs31YJSKC4oUTHQPKg6koiu6lPoCGrtXFrQxKsaDb3BBYkIKUdkVoSs0FMl6P8/07OuYHnXSEw3yq9C7khMPi9DE+TKESHYKvTpV3YCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106800; c=relaxed/simple;
	bh=5azRthlIMduipu4bhlXqqDMNc7jlGc6VSUxKhy2xwXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8QbreuZIdXI++AVShiFoDRk5x1sX5biGLHVH1NDr79rJBo0x5kUN8vgTVYtI/ffpxTn/geq2Qr5eaH8JiRvgU+RAkmGM436heh+ohxqWj4aOKiK7FXQXYjGMM88OlhoGqhb5okP+RJJcl5sTJOa1+F6Qx9fS91TJ0+WCnUqR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.dBaQkh5_1749106768 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 14:59:35 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v6 2/2] PCI/ACPI: Add acpi_check_dsm() for PCI _DSM definitions
Date: Thu,  5 Jun 2025 06:58:14 +0000
Message-Id: <20250605065814.41298-3-zhoushengqing@ttyinfo.com>
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

Add acpi_check_dsm() for DSM_PCI_POWER_ON_RESET_DELAY and
DSM_PCI_DEVICE_READINESS_DURATIONS.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/pci-acpi.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c49abd03daf0..e3680448b6a1 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1240,6 +1240,7 @@ bool acpi_pci_need_resume(struct pci_dev *dev)
 
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
+	u64 rev;
 	union acpi_object *obj;
 	struct pci_host_bridge *bridge;
 
@@ -1256,7 +1257,12 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	if (!pci_is_root_bus(bus))
 		return;
 
-	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
+	rev = 3;
+	if (!acpi_check_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, rev,
+			BIT(DSM_PCI_POWER_ON_RESET_DELAY)))
+		return;
+
+	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, rev,
 				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
 	if (!obj)
 		return;
@@ -1412,12 +1418,18 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 	int value;
+	u64 rev;
 	union acpi_object *obj, *elements;
 
 	if (bridge->ignore_reset_delay)
 		pdev->d3cold_delay = 0;
 
-	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
+	rev = 3;
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, rev,
+				BIT(DSM_PCI_DEVICE_READINESS_DURATIONS)))
+		return;
+
+	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, rev,
 				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
 				      ACPI_TYPE_PACKAGE);
 	if (!obj)
-- 
2.39.2


