Return-Path: <linux-pci+bounces-20905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F33A2C6E9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CFF7A6440
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038123FC62;
	Fri,  7 Feb 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OTIUAY90"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0661F7069;
	Fri,  7 Feb 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941852; cv=none; b=gDdfEvGRJwiYfMEotTf6q2iK78awF5oiMd/70bO+iK+UH2MqM5iLTXq5TqfveNWii6MLvZuc+1D8caGavlqQA1NmD4+VoNkJGW617xmjgZnbJoo7Xx11fWnS8kwKYvTPuUiDmQjRwaXdkGxd5ZGZbf5O4CpKjOB0HaBXFBnPrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941852; c=relaxed/simple;
	bh=L0mpe55eMmldTcY+TI4GJoQofUNmY83l2376LcHT7M8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJftgfbLd9PL4nUt8vWGIE2d9WMmfNRzmIGjJUTDoQWpGBYlLNNNNB/ug6i5w3NvckRt3y706YeKJAtES+aw3TDyUE2WITLSouXLPWDdsGo6JR7kWpn/5oKs0WX5q6kjzwjuYjBsm21wSyncPjtJr/BmjbKsjESeGAcj8PyKvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OTIUAY90; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D1450
	5eoFP/0xHq7p3qPv0wbvi5mxm7mCJIYN+BDc8k=; b=OTIUAY90DLyBjvAVzKodo
	dxCxwtWyJpZFyWNEBuo6XmogqRDXXqHcNRa2bhLhzNqTcnky4xuS0rgcPXbYl1f6
	ZMN6lsIVDdxV7Ks8QNXMM0WDrpTXFZSn05emJCa1eUtVf6KHHBzapSGauP1J5ZYl
	WL4gfdNR2xTvM0LYCZJhVo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnzyuAJaZngv75Bg--.43623S2;
	Fri, 07 Feb 2025 23:23:45 +0800 (CST)
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
Subject: [PATCH] PCI: cadence: Fix runtime atomic count underflow.
Date: Fri,  7 Feb 2025 23:23:43 +0800
Message-Id: <20250207152343.37448-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnzyuAJaZngv75Bg--.43623S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyfKF4kJryfuF4fZFyxXwb_yoWDWFc_u3
	ZYvF4IyFs0gr9Ikayay3WrXryDZa4jqw4jgan3tF43AF1xtw1DW3WkZF98ZF1kG3Z8JFyj
	yw1qv3ZrCF9rAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZNVkUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwDso2emHzxZYgABsY

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


