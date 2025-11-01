Return-Path: <linux-pci+bounces-40032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FDCC28212
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB24EBD3A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EC25E44D;
	Sat,  1 Nov 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XUFeZZ7w"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B21DB15F;
	Sat,  1 Nov 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013166; cv=none; b=uCRswh3D64T8H/godcNBxP38MCrVgGJHjs5IwZaJUh/m0QlmMm65HkrYhvrnyBtIojZzWXlucm821k9yAEGuluYrAZSrcz457mwqIdzrI3oXryY122j8Fi2Elg9pUHk7pZSsPGB5890lYcStr8JGTrAh7K7ZU6shQZrq+rW6u+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013166; c=relaxed/simple;
	bh=oySVf4RfPa2vXHPErjAr0CU4P6G5QgDj6kyzEyfWp7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exqjYOGDaUISdcHHkxbIv7BcTWveVQJlOYIZrjGXABbI+1CzwlecvvM5+X5trSVnszf+V0LsJzVwwbPQkqLnhUmfPL5RmtO0b8hzVgBSyDYb4dDb+YQbrdZGIP2LTsDO+T3HKkKrK8zC/Tsvb1JDaByM9j9VAhdyersfqQ8uYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XUFeZZ7w; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nq
	kIChBp/koBb9FvVZulRsypHQj7vJiGKJ2pQmxhvOQ=; b=XUFeZZ7wr9v/hCYM5N
	Jtq77obhK/piFtTg0b3MJI4WryoPGg1/9AbtB9ShNujz4L1/BPberIszb0eop7k3
	ilHqjrSkiNvkFISyu7m0WLWVHNp4s7O2jf1O1O9oaXWd8RbHf52QcpY4U5OPhd6e
	IaFUhhDFPcMvsecoCDcruBNu4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXL4nTLwZp3qOtAw--.844S4;
	Sun, 02 Nov 2025 00:05:41 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 2/4] PCI: Add macro for link status check delay
Date: Sun,  2 Nov 2025 00:05:36 +0800
Message-Id: <20251101160538.10055-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101160538.10055-1-18255117159@163.com>
References: <20251101160538.10055-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL4nTLwZp3qOtAw--.844S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UKw1xur1fAFWkKw17ZFb_yoWDJrX_u3
	42vFWxWrW0kF9xA3y2kr1fZrZ293ZxWF4xuFn3tFySyFy7Gry5uryqvrn8Ja13WayrJF1q
	q3srKF4Fkwn2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREmiiDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxXcgGkGL9Xu6AAA3Z

Add PCIE_LINK_STATUS_CHECK_MS macro for link status check delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 86449f2d627b..b57d8e4c3a48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -77,6 +77,8 @@ struct pci_pme_device {
  */
 #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
 
+#define PCIE_LINK_STATUS_CHECK_MS 1
+
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
 	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
@@ -4632,7 +4634,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		msleep(PCIE_LINK_STATUS_CHECK_MS);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
-- 
2.34.1


