Return-Path: <linux-pci+bounces-25604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D475A83715
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 05:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96BE8A4DA8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3BB1EEA49;
	Thu, 10 Apr 2025 03:10:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0C1519B9;
	Thu, 10 Apr 2025 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254610; cv=none; b=aj+Xf31ZS/ed1RhyC+aBiZvH8NWqFWBak6SLPi68cW880NUa9fF2Iv9HHhbFOmS+Lt9HkOedZKKKtgXlSLW8Z5vkvwsq1QrILZRTxqFkzUEXXT+TiKoeWGaZuVpdbDA2iY6TCZfLcb3T7xYNpX6cykSVkPJgO0+JBeloKV5utsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254610; c=relaxed/simple;
	bh=utMjnAUYDwC4rLWZpE9SIK4ZIbnGRYa+OQLR9OXYOSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=INvEPXhz8C1l1Px7/xz/IN4FSz9l9xa9AnVzAvI+SlllXQkIkBOS8HXOu5AP3kqbIAH7vIefySGoH09NPvy7iV6jVRHJh9X55JocfyL3D5DmzKi40bDXrTN9bvRgNDkm5YtsPnvjo1US49EWQuGmDxDvDGuPLm4QcZmvkPGeHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZY4Tr66f6zHrGD;
	Thu, 10 Apr 2025 11:06:40 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 96A41180B51;
	Thu, 10 Apr 2025 11:10:04 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Apr
 2025 11:10:03 +0800
From: Xiangwei Li <liwei728@huawei.com>
To: <make24@iscas.ac.cn>, <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<liwei728@huawei.com>, <bobo.shaobowang@huawei.com>,
	<wangxiongfeng2@huawei.com>
Subject: [PATCH] Revert "PCI: Fix reference leak in pci_register_host_bridge()"
Date: Thu, 10 Apr 2025 11:28:42 +0800
Message-ID: <20250410032842.246396-1-liwei728@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200007.china.huawei.com (7.202.181.34)

This reverts commit 804443c1f27883926de94c849d91f5b7d7d696e9.

The newly added logic incorrectly sets bus_registered to true even when
device_register returns an error, this is incorrect.

When device_register fails, there is no need to release the reference count,
and there are no direct error-handling operations following its execution.

Therefore, this patch is meaningless and should be reverted.

Fixes: 804443c1f278 ("PCI: Fix reference leak in pci_register_host_bridge()")
Signed-off-by: Xiangwei Li <liwei728@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/probe.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..8595d41add09 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -957,7 +957,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
-	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -1021,7 +1020,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
-	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -1110,15 +1108,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
+
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
-	if (bus_registered)
-		put_device(&bus->dev);
-	else
-		kfree(bus);
-
+	kfree(bus);
 	return err;
 }
 
-- 
2.25.1


