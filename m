Return-Path: <linux-pci+bounces-34602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D025B3202D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74EFEAA8193
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D6277CAF;
	Fri, 22 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mqJneMlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2D2571B3;
	Fri, 22 Aug 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878590; cv=none; b=YPCeWhgu8j14WDfU5SlAy+zD7XO5JFgr/bwu9ubYXNb6lbY94wosvWX7CpgWTZR0YnLgiiy+HWSSomcCLqjNlpew3LpVsj0uyHSmkBv/lSzS7oZanNoKS+2pGX6pWIG9EZqJbEmyQR/2u5VmYz18igAvKGHOQ26A/EayQDHNhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878590; c=relaxed/simple;
	bh=00uQLzBvw81h9DsR6NvprDhEKBbI4K9VDv6ya1BQZS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKpM6MKzAm7xyrqowI6i2fsHtqnaLpxWldDaJKngVSu2R348I+RRJgzhi7u18DwiLMyjuDdRIFvb7qdpvDSVlKRmH/P8PaycLSGprPuwoDFzdriT0K4LfrVQktf3j4QJgxw7JMjIeQWz3GoUNBmDaWZ/MpwzfFco4s/lDQBMLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mqJneMlC; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nY
	wBe0Gw4IJJQHEad3MsWbZtPAjCQRM88MR9DM/lef8=; b=mqJneMlCQm3YYpfNJI
	ui5bE7BQ9AjAimDzdxm5TBWRp0rXeZT6cYDJDsKdwJi56ApSSh9379qPgKHpTRK+
	6d4DGF2qJu9sMnpjab96EVPW5xZPBpDrr/Y2I+C/SpYqVT318IA8fyLFheGGB3lo
	hDTKElD/CCRVJHWZt2JLd9joQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S7;
	Sat, 23 Aug 2025 00:02:53 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 5/7] PCI: rcar: Replace msleep(5) with usleep_range() for precise PHY ready checking
Date: Fri, 22 Aug 2025 23:59:06 +0800
Message-Id: <20250822155908.625553-6-18255117159@163.com>
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
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyfGw1rAr1xKr47Kw4xXrb_yoWkJFbE93
	WF9F17CrWDW34akF12yw4IqF9Yy3Wav3WUXa4FqryFyasxX348JryIvayUX395Gw4fGr13
	tr1DAr48Jry7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_73ktUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwKxo2iokINYxQACsf

The msleep(5) in rcar_pcie_wait_for_phyrdy() may sleep longer than
intended due to timer granularity, which can cause unnecessary delays
in PHY ready detection. Replace it with usleep_range() for a more precise
delay of approximately 5ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 7583699ef7b6..8d0f5a4a7fc0 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -11,6 +11,8 @@
 
 #include "pcie-rcar.h"
 
+#define PCIE_PHYRDY_CHECK_US	5000
+
 void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, unsigned int reg)
 {
 	writel(val, pcie->base + reg);
@@ -39,7 +41,7 @@ int rcar_pcie_wait_for_phyrdy(struct rcar_pcie *pcie)
 		if (rcar_pci_read_reg(pcie, PCIEPHYSR) & PHYRDY)
 			return 0;
 
-		msleep(5);
+		usleep_range(PCIE_PHYRDY_CHECK_US, PCIE_PHYRDY_CHECK_US + 100);
 	}
 
 	return -ETIMEDOUT;
-- 
2.25.1


