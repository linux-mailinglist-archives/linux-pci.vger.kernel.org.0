Return-Path: <linux-pci+bounces-29471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58FAD5C34
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A54163971
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53720CCE5;
	Wed, 11 Jun 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B5T4tPFZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEEF202C5A;
	Wed, 11 Jun 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659528; cv=none; b=kqBcWFdQXlX3RZBzisWSx5Ug/bGOF2sEwwZNeDNAOafZ6yIRDeW5dDHQ0lhP/y6QDzyPHF8aeN7bXjcCJaJ2XMaD9hDnFBPDP3gOGx8w8H/cZwjbjztOr8rkqAeYQrQgriwYzzCRsPEV+si2BEHXI58ts/+j0KwYbWZJMDqy9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659528; c=relaxed/simple;
	bh=05XlbY/UQu42xpAJ30ZAd5vgZ/sIRKkwHCnOZ7Imj1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJ0MdZZ/rUrhlkRzW34DjrN6etDHMBDMJLtZwVINWSn20ss2ohj1vHR8jize/+1m97QBktGN6lFwCnaShYXlM3CiX8yflkiiGhNuN3+OXe+A168za3v6RX9E2ZY+EZsWdksiv5zCWE+9oNJHPSOYSo0RZ4A2e27wkJAj5CKBWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B5T4tPFZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hb
	y962xhyP4Qgrj7aPF+nhZQMZCQ5u6zcns9wRaSiWI=; b=B5T4tPFZV/vN3axNTn
	k0kYk4y5PMIb2B11ew1zwMgrTxlXgr5qc/OgGqO0jiDzZfD/pd4Njsr3K+rc6vfP
	+oMP9xUP3rUndg7xCVnR/rd/vNhSu8Dlq1qSMeyfwyC33mL+8BbvYucFc3VnluRi
	crtav5IVQtDchg+vE8Wxav5vc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3muNkr0loIQO9CA--.20563S2;
	Thu, 12 Jun 2025 00:31:33 +0800 (CST)
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
Subject: [PATCH 05/13] PCI: dwc: Refactor meson to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:31:31 +0800
Message-Id: <20250611163131.860729-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3muNkr0loIQO9CA--.20563S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyDXFW7tr48XFyxJw1xAFb_yoW5CFWkpr
	ZxuF4FyF47Jr45uw4qva95uay3Jas3Cw17JFnxG34S9Fy2yr9rta4aya45uayxGrW0g34j
	9r98trW8Z3W5tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pieWl9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxRpo2hJrMxDMQAAsi

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


