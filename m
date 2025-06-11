Return-Path: <linux-pci+bounces-29466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD552AD5C25
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6233A6F80
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198F1A3154;
	Wed, 11 Jun 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GR2/k51G"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0BE2E610A;
	Wed, 11 Jun 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659498; cv=none; b=pJnSkZbSvOodOv0eYUsAb78Ej0JkltnOj3MvBLr3+Ag+Kvlc95N8djWpkM1jV8wg2QRPkBqyQIoJoyf0Fqnzkcmjg2uIJiBqI35C9phHuEHrX6Gl22N9ZE4or0UE+Am91ql370ttNb86fwqlVBHsd9UlQTBRJCUoqDUgH43IdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659498; c=relaxed/simple;
	bh=Aval5zk1VgFJgPoCb1Z+VYhn5vHXyVwG2wThqQn9Cg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwZ/Jpz5AJnZmebmpNfqn8M+aT7SQ9Wg11pOW+jPqmoqZkDyaF+GUqRkCb0poOtwFR6wpoaeM845l4seYVAt764GNjjvNXCU4cf/jpP/MaRgL4R9BjuzOXBLrWb16OAMjG8ltYgn3GY/6hSqmyNICKYbfGJeDlqmWUkdw8d2gjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GR2/k51G; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6W
	NamUFnScGmcGW4V2poSQwnw1TE8eT2FVftvMi/L8E=; b=GR2/k51GgUtZ1XE3Yh
	nuXvWl5U1+TMURsM0pfgVOTANtkHLlIHdv++AJRwx4QbY4hZZHQqQgXMv4PB/wuI
	BSGaOvMcuWanygDB/j4tBlFQLHl11s0pLWTsx8WvFYxkrUIglspX2uCi5qwOAyas
	WH0Eig8UjIx5OvCCmAmOGA+xQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHugBUr0loWN_WAQ--.64347S2;
	Thu, 12 Jun 2025 00:31:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 03/13] PCI: dwc: Refactor dra7xx to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:31:13 +0800
Message-Id: <20250611163113.860528-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHugBUr0loWN_WAQ--.64347S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkGrWkKr1xuFyrXF13Jwb_yoW8uw4xp3
	y3CFZIk3W7Jan5X3Wqv3Wku3WSvasavr4Utan7Kw1fZF9Fyr9rtrWFyry8tF4fuFWj9r12
	ka15t347Xw4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE3xhJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhVpo2hJr1AAlQAAsu

The dra7xx PCIe driver implements suspend/resume handling through
direct register manipulation. The current approach uses explicit
read-modify-write sequences to control the MEMORY enable bit in the
PCI_COMMAND register, declaring local variables for temporary storage.

Replace manual bit manipulation with dw_pcie_clear_and_set_dword()
during suspend and resume operations. This eliminates redundant variable
declarations and simplifies the power management flow by handling bit
operations within a single function call.

Using the centralized helper improves code readability and aligns the
driver with standard DesignWare register access patterns. The change also
reduces the risk of bit manipulation errors in future modifications to the
power management logic.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index f97f5266d196..9cbba1b28882 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -867,15 +867,12 @@ static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
-	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* clear MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
-	val &= ~PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
 
 	return 0;
 }
@@ -884,15 +881,12 @@ static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
 	struct dw_pcie *pci = dra7xx->pci;
-	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
 	/* set MSE */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
-	val |= PCI_COMMAND_MEMORY;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, 0, PCI_COMMAND_MEMORY);
 
 	return 0;
 }
-- 
2.25.1


