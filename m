Return-Path: <linux-pci+bounces-22701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07598A4AAFE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C85189814A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072881DEFF9;
	Sat,  1 Mar 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UPUrbH4Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745323F372;
	Sat,  1 Mar 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740833102; cv=none; b=i76szmMfo/AC3HzzsLYWbVccp3mtR/3u6JjQ+j9hGIcS3m1ItBBUas599I9I/q8uQ9Q8CvNUte7SJOHhznfV8nET0uEm2h1qQs61Wa7V2mPr8wL7pCCCgWK8qdRpWOGQZfaX0nc03PPlm5QvlAxLGtDrkq3tqslL0HFNNtD8OkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740833102; c=relaxed/simple;
	bh=L0mpe55eMmldTcY+TI4GJoQofUNmY83l2376LcHT7M8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mi9mhq7ZbQZ1hmP6OTT4m39MF7omj17ZDiyUoUleBC1FzWlZKoeQFRbTuvRDsrZEO1ZOksF1ogdT1D9m3nBUPuN1qFWFUat6+DoRg1PNG20hK59JdWTs696/ks2oFl3osU1n4PQBzdZdUhJvi0mxu/Sx49yhXKJCz/hXE2FPDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UPUrbH4Z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D1450
	5eoFP/0xHq7p3qPv0wbvi5mxm7mCJIYN+BDc8k=; b=UPUrbH4Zthn4+DjdRvzse
	ssMCpzDyYbK6N8TkwONaCcgAD8LvxjkrvnmDubHzZmUerSOrsfnSNlZoltr0ys88
	0Itp7a1gMMZxNuhcWc5vobDb3bo+ROiBB7GFTCvrII6TYypZFcoTq3XFei2bN49p
	4LhoEVFty2XeWBX+OFPrI4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnbz4qAcNntfNcPg--.2910S2;
	Sat, 01 Mar 2025 20:44:27 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	"Hans Zhang" <18255117159@163.com>
Subject: [RESEND] PCI: cadence: Fix runtime atomic count underflow.
Date: Sat,  1 Mar 2025 20:44:18 +0800
Message-Id: <20250301124418.291980-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnbz4qAcNntfNcPg--.2910S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyfKF4kJryfuF4fZFyxXwb_yoWDWFc_u3
	ZYvF4IyFs0gr9Ikayay3WrXryDZa4jqw4jgan3tF43AF1xtw1DW3WkZF98ZF1kG3Z8JFyj
	yw1qv3ZrCF9rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRWHqcUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxIDo2fC+rxaxQAAsV

From: "Hans Zhang" <18255117159@163.com>

If the pci_host_probe fails to be executed and run one time
pm_runtime_put_sync. Run pm_runtime_put_sync or pm_runtime_put again in
cdns_plat_pcie_probe or j721e_pcie_probe. Finally, it will print log
"runtime PM usage count underflow!".

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..fe0b8d76005e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -576,8 +576,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	return 0;
 
- err_init:
-	pm_runtime_put_sync(dev);
-
+err_init:
 	return ret;
 }

base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.47.1


