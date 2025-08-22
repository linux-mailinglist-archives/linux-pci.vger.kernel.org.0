Return-Path: <linux-pci+bounces-34605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E2B32032
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084D0AE0100
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250A305044;
	Fri, 22 Aug 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ik5VAvqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C62F066B;
	Fri, 22 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878593; cv=none; b=de1Ej5mPRC9/OU1Zc57PPXLXuV6b8G/fC8qKtYE3NBUV/JgO1uU3IUg6XPZX0TE9nIBClqhzd8QzIxNf7+bZ7uTAr//P4UDWcvS5+BnDxETds6daJeBwEzOYEC04/ufOPO+roRKZF7rCTQaLenRkKKaWQmm8FWRBmhon7S61E7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878593; c=relaxed/simple;
	bh=mSTZiv3w+AC7BonVwRiL1fK3888hGsM8Hv345BhmTIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPluxLyhr+OuEG9H5qD0r+g4YrLiVGiOBorEnnYDUsQDErYHBpy29qa6d6e1V4NQReDHB/D5OHzHC/kkWucyLkJHJ3obwOWfVb3yp8szNsKQ/R7xBYRDMR5LDgUsWMRyyOuSljrjq7d5fUuuTZVpJbLbJ3kUmvXB45QDAp5O2w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ik5VAvqF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XK
	nBHPk3wclolPjnrkVycWfU4auAlCcr0wGUwYIwssI=; b=ik5VAvqFRxeWaWR6sG
	+Fvkq4TtWIFiGsaYDt4BgEuj/GvE3pvem4exxYvKkNmQ9Xu9QjPmrdtwnwSK6CGZ
	rqxxVDw4hLEIQs5++IpTF60YlXo68Pujkx7W77SgP08xTLKKTLdcvBKTrb2TyZij
	CJs2tznMT4m1WBUKrU4uPCt4I=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S5;
	Sat, 23 Aug 2025 00:02:52 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 3/7] PCI: rcar-host: Replace msleep(1) with fsleep() for precise speed change monitoring
Date: Fri, 22 Aug 2025 23:59:04 +0800
Message-Id: <20250822155908.625553-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822155908.625553-1-18255117159@163.com>
References: <20250822155908.625553-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7tr4xKF1DWr18Gw17Jrb_yoWDZwc_ur
	yakF17CrWDC34akF12kw43tF9Yka4jqrnIva4Fq3W3AFW3X34kJrn29ryDXr1rCay5J3WS
	yw1DKr10kr47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUxnY3UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxOxo2iokINYxAAAsN

The msleep(1) in rcar_pcie_force_speedup() may sleep longer than intended
due to timer granularity, which can cause unnecessary delays in PCIe speed
change detection. Replace it with fsleep() for a more precise delay of
exactly 1ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fe288fd770c4..5651285f1fb2 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -34,6 +34,8 @@
 
 #include "pcie-rcar.h"
 
+#define RCAR_SPEED_CHANGE_CHECK_US	1000
+
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
@@ -339,7 +341,7 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
 			goto done;
 		}
 
-		msleep(1);
+		fsleep(RCAR_SPEED_CHANGE_CHECK_US);
 	}
 
 	dev_err(dev, "Speed change timed out\n");
-- 
2.25.1


