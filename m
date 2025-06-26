Return-Path: <linux-pci+bounces-30785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1600AEA1F1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6306A40DC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF62FE322;
	Thu, 26 Jun 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TmhjWitk"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B1B2FD892;
	Thu, 26 Jun 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949546; cv=none; b=aZlEFa3V+CAV9NLcA7kqie1EMLqkGy1x+fflKmGmdPUSHYj0b+fRRaT/HlcIGtnWL90CEWPPUbQH13l0A90nyyY7XBeplgeWcdq4i2reie4rRTG/ZnLg1BBmz16fZKN3/0qxpRY1FprTVANcjBtDMwLl+ZMmM+v7p1EVcDUQ0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949546; c=relaxed/simple;
	bh=05XlbY/UQu42xpAJ30ZAd5vgZ/sIRKkwHCnOZ7Imj1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZBa2VoFs0l2Tsjzu+Bo+2Q97Aqqksf93H6Wzj6cr1ES8ywv33ICtgUFou9nIYudbIooReYjl6qEzxGo90o7uR1NAKCns786kgiiz9hqV/74e8NH9T6HIk5PmNGsV1nlepmYiiF+F89J2vucxdspbyJtPu9Jg4YG/qvtRjlGCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TmhjWitk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hb
	y962xhyP4Qgrj7aPF+nhZQMZCQ5u6zcns9wRaSiWI=; b=TmhjWitknqaFKyRHAt
	fJ+fAf/xKeB1HxmvdfHawiGdm6q1Ln3oi5TlmiNDvTuuSVubpYhVr6Zu/RxoU1KC
	0AQE1tjhN0haU0Ow0yY3qc45jtnDqjFmd83IB/22vfZYaP8DKuefx0SuTihTf+9z
	DhsTcfv90YSjFKWgVbmAhI9AA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB3nPiWXl1o6RnqAg--.56622S2;
	Thu, 26 Jun 2025 22:52:07 +0800 (CST)
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
Subject: [PATCH v3 05/13] PCI: meson: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Thu, 26 Jun 2025 22:50:32 +0800
Message-Id: <20250626145040.14180-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250626145040.14180-1-18255117159@163.com>
References: <20250626145040.14180-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3nPiWXl1o6RnqAg--.56622S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyDXFW7tr48XFyxJw1xAFb_yoW5CFWkpr
	ZxuF4FyF47Jr45uw4qva95uay3Jas3Cw17JFnxG34S9Fy2yr9rta4aya45uayxGrW0g34j
	9r98trW8Z3W5tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHGQsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxp4o2hdWY1vkgAHsB

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


