Return-Path: <linux-pci+bounces-12158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91095DD52
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 12:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776551C210AB
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46039154C0B;
	Sat, 24 Aug 2024 10:06:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CC8488;
	Sat, 24 Aug 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493999; cv=none; b=ccQHIj2W6McMxu8UwwJxIvERpkaeNuZkaAaIb4s2MuDCuZ7LNhJckZA/9VSigHJuhVXLSkEFfTEBvjvzqCyLkDzTkfeiez9WolOEdNxHpED4R06Xr+cqq8EK4SeijYsQQZ+Cig3DprtN2CjR5w05Uy1bcF7LQuC9HMy71jiZvg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493999; c=relaxed/simple;
	bh=RCov97JT1kt1nd/F/eN30neXS9WFhiNc4AJ3r3+s8go=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uun04jvG0R/SpQbtHSk/H++vB8agwIA+WTlY7KlCptOoHBGchNM7s41vlPJiF7H5dpGmFp1D4peJMFM9sNnoYlDiLGVDEmITEGaWushz33t/TN8fKyIrlkREeydz/UG9WdPXsvrrYYZCfQD/Lrg1iJyYQdFtQkt6ESrpNBxCNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrXZH06xLz1HH4q;
	Sat, 24 Aug 2024 18:03:19 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 589C31A0188;
	Sat, 24 Aug 2024 18:06:34 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 18:06:33 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 -next] PCI: Remove two unused declarations
Date: Sat, 24 Aug 2024 18:03:31 +0800
Message-ID: <20240824100331.586036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit b67ea76172d4 ("PCI / ACPI / PM: Platform support for PCI PME
wake-up") declared but never implemented __pci_pme_wakeup().
Commit fd00faa375fb ("PCI/VPD: Embed struct pci_vpd in struct pci_dev")
removed pci_vpd_release() but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: Add pci_vpd_release() history
---
 drivers/pci/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e9b1c7b94a5..4c284c55a0c5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -124,7 +124,6 @@ void pcie_clear_device_status(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
-int __pci_pme_wakeup(struct pci_dev *dev, void *ign);
 void pci_pme_restore(struct pci_dev *dev);
 bool pci_dev_need_resume(struct pci_dev *dev);
 void pci_dev_adjust_pme(struct pci_dev *dev);
@@ -169,7 +168,6 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
 }
 
 void pci_vpd_init(struct pci_dev *dev);
-void pci_vpd_release(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_vpd_attr_group;
 
 /* PCI Virtual Channel */
-- 
2.34.1


