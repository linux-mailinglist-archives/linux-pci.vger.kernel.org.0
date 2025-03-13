Return-Path: <linux-pci+bounces-23594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C664A5F046
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27CB3B8ACF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40EF264A7B;
	Thu, 13 Mar 2025 10:07:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC926562B;
	Thu, 13 Mar 2025 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860459; cv=none; b=TFR2h3juYBj1UgUkjXtDzfWxWmiGnQ3BRJroRtlcs/Q2/lyp4rEr7TU8nrvAqJKRzfvqXxIUYVVzAjjOjCzLriSSD5VXyX7OgRfMvDSCmbco3xUp32svHFkz3NRklN6GkBFAlYpngJD7BdLtSwANa0XJ0TZtaCWdx7b4wjqTYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860459; c=relaxed/simple;
	bh=rFOy1+Pmit0NR8mxZhaIt3FG7jfOXL965z3BZnrsP2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEdqsPB2jb0CJpB7DBYT4S/qq3F3NEH+6xahRnSyDflfBPnhfGH1piI2CpalP3PkYUHNtHJi1JcHXrxIPqd4WBAjPgr73eJ+OESKd2q0MkGQM9P7on0M2Y4+8syW7aWbHivz5Kx1oWVfYJ72c7r4wIowT5VbpU/FCH81In6sBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.bsXubLz_1741860439 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 18:07:27 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rafael@kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH v5 2/2] Add acpi_check_dsm() for PCI _DSM definitions
Date: Thu, 13 Mar 2025 10:06:56 +0000
Message-Id: <20250313100658.15805-2-zhoushengqing@ttyinfo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250313100658.15805-1-zhoushengqing@ttyinfo.com>
References: <20250313100658.15805-1-zhoushengqing@ttyinfo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add acpi_check_dsm() for DSM_PCI_POWER_ON_RESET_DELAY,
DSM_PCI_DEVICE_READINESS_DURATIONS.

Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
---
 drivers/pci/pci-acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 4f9e0548c96d..47caad28a133 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1257,6 +1257,10 @@ void acpi_pci_add_bus(struct pci_bus *bus)
 	if (!pci_is_root_bus(bus))
 		return;
 
+	if (!acpi_check_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
+				BIT(DSM_PCI_POWER_ON_RESET_DELAY)))
+		return;
+
 	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
 				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
 	if (!obj)
@@ -1418,6 +1422,10 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	if (bridge->ignore_reset_delay)
 		pdev->d3cold_delay = 0;
 
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 3,
+				BIT(DSM_PCI_DEVICE_READINESS_DURATIONS)))
+		return;
+
 	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
 				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
 				      ACPI_TYPE_PACKAGE);
-- 
2.39.2


