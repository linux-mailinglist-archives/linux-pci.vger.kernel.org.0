Return-Path: <linux-pci+bounces-35019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047EDB39F89
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C9C188EBA3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669D1E51EA;
	Thu, 28 Aug 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hUXMrSR5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997913C8E8;
	Thu, 28 Aug 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389654; cv=none; b=ufyC8H7GmNaOWE0WzItxubSGko0xi0qdBH0CrKEr2UkUoQc1pKTWcSL7tKf7OQcdjMy9RQxAa81hv+atnrcQenRCegsKg8SKGc+8bta/h3rtQHBK7Ofo9nbYHMOeGjvwbuk/mLGh10M0RsSq7BWgOpDvi4gYRFePruyxMgdbaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389654; c=relaxed/simple;
	bh=y9d2KHvlrjfgk6HutaPWIhRGm5pIFypD8P4B2HynNu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKLe9N14Y93xj5OEhxxWg4p1mlEtsXJo0Z814QCUzR4Zv2WTgTwSEvUOIpWTMpwseMCzLmT/fv12y30H9wOJv03cEV19qaLzie6cizc3FhbN681kYch7q55PjhPM2LORK8OG6epNwZUKacRhCOOW4Zd+qWUHok6lilaa7vDG0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hUXMrSR5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aX
	Dj3C/swNcA3DFtbEATvHkrGBjYkf9tWCjRAQLgjpk=; b=hUXMrSR5jv0Zxag+xv
	+CHRsiAeMoU+02O6Sgpxc2nEbJUDPHHZRLwFsVQKs59KvyCIBBU5G+sHq8aSJ50S
	dkrZnL8kB2q28O+ILMcu/alglV1DNBu7OnlJbOR/aQy4FEMpU7HLZmaUILIo0LSt
	7xZ+5kplaCAO7azKoPvbcNpy8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S7;
	Thu, 28 Aug 2025 22:00:40 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 05/13] PCI: meson: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:43 +0800
Message-Id: <20250828135951.758100-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyDXFW7tr48XFyxJw1xAFb_yoW5Cryrpr
	ZxWF4FyF47Jr45uw4qva95uay3Jas3C3W7JFnxG34S9FW2yr9rta4aya45uayxGrW0g34q
	9rZ8trW8Z3W5tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinmR8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw63o2iwWlmkNwADsK

Meson PCIe driver implements payload size configuration through manual
register manipulation. The current code reads device control registers,
modifies specific bitfields for maximum payload and read request sizes,
then writes back the updated values. This pattern repeats twice with
similar logic but different bit masks.

Replace explicit bit manipulation with dw_pcie_*_dword() for
payload and read request size configuration. The helper consolidates
read-clear-set-write operations into a single call, eliminating redundant
register read operations and local variable usage.

This refactoring reduces code duplication in size configuration logic
and improves maintainability. By using the DesignWare helper, the driver
aligns with standard PCIe controller programming patterns and simplifies
future updates to device capability settings.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396..e9375cfa6c8f 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -264,33 +264,27 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
-	u32 val;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_payload_size = meson_size_to_payload(mp, size);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_clear_dword(pci, offset + PCI_EXP_DEVCTL,
+			    PCI_EXP_DEVCTL_PAYLOAD);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_set_dword(pci, offset + PCI_EXP_DEVCTL,
+			  PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size));
 }
 
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
 	struct dw_pcie *pci = &mp->pci;
-	u32 val;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_clear_dword(pci, offset + PCI_EXP_DEVCTL,
+			    PCI_EXP_DEVCTL_READRQ);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_set_dword(pci, offset + PCI_EXP_DEVCTL,
+			  PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size));
 }
 
 static int meson_pcie_start_link(struct dw_pcie *pci)
-- 
2.49.0


