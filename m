Return-Path: <linux-pci+bounces-33915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C1B23FCD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B1165EA7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D222BE034;
	Wed, 13 Aug 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQa6zLXh"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD7623D7FF;
	Wed, 13 Aug 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060352; cv=none; b=SGg6aaHpQYWq7AXMsWpbCNztVKJSiAYZ4MzJ4hLPFul5t5pQNL9FE/3P5hAJPq0KMXT5F1v/0k3JRE5ghqkwQaZhDQ6sXXCQ2ktqKh0qiBE8Fz7ICUHDhQLvdg1Ev8zVUIGw4a5vkxHJb2WWfmjH8/iFiDFm3mNhVEp/5Xj4HWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060352; c=relaxed/simple;
	bh=05XlbY/UQu42xpAJ30ZAd5vgZ/sIRKkwHCnOZ7Imj1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjKdr6L0owHgChneedjgHM+zS1joG+m4RqJuLM/yyeC98HeX8dEczyREHC95DRd7A9fMwx9w4kBI/k9YNIl5ArQpbzVqqNXB/26yq0PFuKTuhi3N9obqmiNkCFusd36/Pop+JMYcHWo87S3DXn7Xovv5ad+Vsq/axaKOJ93JntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQa6zLXh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hb
	y962xhyP4Qgrj7aPF+nhZQMZCQ5u6zcns9wRaSiWI=; b=XQa6zLXhl6RZ4KuYwD
	vfGQczDlnPp2X+ZerRzK46vtSVsLHhL6xrwpsyQOro+W1aRYd6RJVcaoUsoUd/1A
	BCY6CShVkim5MrMvqYAZ2R3aKQcb58ceN3v077mMuqm+qSB6PHXCp76h0/AYDS9u
	twXLiytG7uMzRcO4oJuB1G5S4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S7;
	Wed, 13 Aug 2025 12:45:38 +0800 (CST)
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
Subject: [PATCH v4 05/13] PCI: meson: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:23 +0800
Message-Id: <20250813044531.180411-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyDXFW7tr48XFyxJw1xAFb_yoW5CFWkpr
	ZxuF4FyF47Jr45uw4qva95uay3Jas3Cw17JFnxG34S9Fy2yr9rta4aya45uayxGrW0g34j
	9r98trW8Z3W5tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinNV9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWweoo2icD9vaDAAAsh

Meson PCIe driver implements payload size configuration through manual
register manipulation. The current code reads device control registers,
modifies specific bitfields for maximum payload and read request sizes,
then writes back the updated values. This pattern repeats twice with
similar logic but different bit masks.

Replace explicit bit manipulation with dw_pcie_clear_and_set_dword() for
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
index 787469d1b396..cd6280a8e619 100644
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
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_DEVCTL,
+				    PCI_EXP_DEVCTL_PAYLOAD, 0);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_DEVCTL, 0,
+				    PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size));
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
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_DEVCTL,
+				    PCI_EXP_DEVCTL_READRQ, 0);
 
-	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
-	val |= PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size);
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
+	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_DEVCTL, 0,
+				    PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size));
 }
 
 static int meson_pcie_start_link(struct dw_pcie *pci)
-- 
2.25.1


