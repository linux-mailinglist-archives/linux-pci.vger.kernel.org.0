Return-Path: <linux-pci+bounces-14996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78ED9A9E92
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A94E1F2250C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98996198A2C;
	Tue, 22 Oct 2024 09:34:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D231990AE
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589646; cv=none; b=nuaXpilOo4x6H13PMRHmlT2PO6tLIHvp2Fh8PJaUEHMGoJfE062ONVn7iBYzh2n272z1mi/sO1n+FeZbSaJ3tk3U4Jpq6GZIb4dGBugrLlzc8zJWAoluiPwVHC/GSH5Xj6q+TZsPldHAELgkOKcS8XRv/xoKbXQe8Lyth7xKNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589646; c=relaxed/simple;
	bh=7AqTzBsJ6bw2+kz0jjggBOT4mjLvsxcbnYTDm5cpBQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWTeqkViK8304E7XLc4r4xMiHM7le/LcrIriJ2hPR09qPjv29kfORFRnPAagJpsFJsN45G4P74Tyq6y/Y4ktaXVDx6XhJw2+EjiVKsGT2OjkXYj//wuVyFioolmGDX3NjbwfubmdZRyf22rSFD07Liw6zq1c2Egv/5skMLoteBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXn4L5QSLzfdQ9
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 17:31:30 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A4761800A0
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 17:34:00 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 17:34:00 +0800
From: Yuan Can <yuancan@huawei.com>
To: <bhelgaas@google.com>, <gregkh@suse.de>, <linux-pci@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH] PCI: cpqphp: Fix error handling in cpqhpc_init()
Date: Tue, 22 Oct 2024 17:29:17 +0800
Message-ID: <20241022092917.120226-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)

The cpqhpc_init() returns without checking the retval from
pci_register_driver().
If the pci_register_driver() failed, the module failed to install,
leaving the cpqhp debugfs not unregistered.

Fixes: 9f3f4681291f ("[PATCH] PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 47a3ed16159a..933392fab8a3 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -1390,6 +1390,10 @@ static int __init cpqhpc_init(void)
 	cpqhp_initialize_debugfs();
 	result = pci_register_driver(&cpqhpc_driver);
 	dbg("pci_register_driver = %d\n", result);
+
+	if (result)
+		cpqhp_shutdown_debugfs();
+
 	return result;
 }
 
-- 
2.17.1


