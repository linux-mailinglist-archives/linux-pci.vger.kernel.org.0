Return-Path: <linux-pci+bounces-15907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884449BAC64
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 07:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC5281E4D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 06:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAE14E2FD;
	Mon,  4 Nov 2024 06:14:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from out28-132.mail.aliyun.com (out28-132.mail.aliyun.com [115.124.28.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3C6FC5;
	Mon,  4 Nov 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700849; cv=none; b=tJlWeeJNcKgPRHaIPQkroSN9Km8dddb4P6wR20Lcp0MRbrcp3J6jV5NzvywlofaI71f/eDJgcSbxjPSbFpKcUqqywXrY7BTVanyqxEwdVdLSCeB0FycWYBm6Ij6G5Vwlymx5JL6lPD8hgFtVIRZIMs56YpPrdwOFv2L6aQsqrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700849; c=relaxed/simple;
	bh=kKoSkfa/4XTZf97rbXAnkznukgIQZI507PfDIYlcIuo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BtuM93HVO5WhvwPZksKbMDw1Hbkv3ggl9eSCK88qRVo1xbFk9Zq6YNBCvrpaNTaW5tysbzp1eI1jfWGiutisvwkz0vUWwd/+p0ZMCNxEcLMK2TX4chLFOX4gJp68d8SFDL+5r5YvUTebfJtF7W92AC1m87rZ+0M3G2zpXAlojLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com; spf=pass smtp.mailfrom=ttyinfo.com; arc=none smtp.client-ip=115.124.28.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ttyinfo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttyinfo.com
Received: from tzl..(mailfrom:zhoushengqing@ttyinfo.com fp:SMTPD_---.a.rFp-G_1730700835 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 14:13:55 +0800
From: Zhou Shengqing <zhoushengqing@ttyinfo.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhoushengqing@ttyinfo.com
Subject: [PATCH] PRESERVE_BOOT_CONFIG function rev id doesn't match with spec.
Date: Mon,  4 Nov 2024 06:13:42 +0000
Message-Id: <20241104061342.106865-1-zhoushengqing@ttyinfo.com>
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


