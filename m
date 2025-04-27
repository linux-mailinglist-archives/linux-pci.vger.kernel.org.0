Return-Path: <linux-pci+bounces-26866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDC7A9E31A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC7F178A13
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD015530C;
	Sun, 27 Apr 2025 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GkMAxQVt"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD925B663;
	Sun, 27 Apr 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758447; cv=none; b=r8wZlGy966sCd6V9cuqX3OdWIThbwbJvdQsiRpvLdAZnK+FmZ4WspKJzze+fbQPyI4ykiTyC+beG3vxxoxFvLbNGwrKg8yJJ7NaBGlxcV0xUK87kSX4BoDl5Fm0KIXy6T0EFhOUtkEq4IFR90bqLyg9aWuBsuF5Cqp2POxLCBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758447; c=relaxed/simple;
	bh=gYcvX/PXpuk4GnaSRaqp4F5hAALgHopB4YB7n42oiRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IeERtDNzy3V4hlakhu8xjWVC51bJhXpqGFCLmpTz1eQdd48H6zuy0M1Vhtod7gHrjwZa2bmYJVGwqMI2myRJ3Z706hXDn0e1RYoBqGBBvfZUCWrvmgE5QYURx6wfm8OCkN/hCOarBlPgNM2hLmdaVZq1ko8Zu/56bfkMRVsZq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GkMAxQVt; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yGhe3
	4wuhzgGL+OCD/PQ8ajhqt0tg2mg9e8bu/roRYU=; b=GkMAxQVtHGRMHJD5rzImI
	v594EHwrXtKb+3VF/IJ4GQiPbHTccVjQ5GsuMBHGFqA27cKN6KtARQcNTcMOFKWC
	fE6tHoMunKcKHlFWNM89zfUvlieVY6TOV2twWrhEUuyneEZ0a2XXOaOvBc8Kumil
	SiB8vqIZbhiu66hnAZr6rM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3LwC9KA5oNqx8Cw--.63816S5;
	Sun, 27 Apr 2025 20:53:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 3/3] PCI: dw-rockchip: Unify link status checks with FIELD_GET
Date: Sun, 27 Apr 2025 20:53:16 +0800
Message-Id: <20250427125316.99627-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250427125316.99627-1-18255117159@163.com>
References: <20250427125316.99627-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3LwC9KA5oNqx8Cw--.63816S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF15Jw4kKw17AF4xtw4fZrb_yoW5tFy7pa
	98Aa4qkr48Gw429F1kCFZ8ZFWrtFnxuayUCrn7K3WxW3ZIyw1UG3WUWr9xtr4xJr4rCFy3
	Cw48Ja4xXr43ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOL0rUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxs8o2gOJHx0gwABsX

Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
leading to code duplication. Centralize the logic using FIELD_GET. This
removes redundancy and abstracts hardware-specific bit masking, ensuring
consistent link state handling.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index a778f4f61595..bfc47dab32e5 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -8,6 +8,7 @@
  * Author: Simon Xue <xxm@rock-chips.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/irqchip/chained_irq.h>
@@ -60,9 +61,8 @@
 
 /* LTSSM Status Register */
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define  PCIE_SMLH_LINKUP		BIT(16)
-#define  PCIE_RDLH_LINKUP		BIT(17)
-#define  PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
+#define  PCIE_LINKUP			0x3
+#define  PCIE_LINKUP_MASK		GENMASK(17, 16)
 #define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
@@ -188,10 +188,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 val = rockchip_pcie_get_ltssm(rockchip);
 
-	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
-		return 1;
-
-	return 0;
+	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
 
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
@@ -450,7 +447,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	struct dw_pcie *pci = &rockchip->pci;
 	struct dw_pcie_rp *pp = &pci->pp;
 	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -459,8 +456,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
 			/* Rescan the bus to enumerate endpoint devices */
 			pci_lock_rescan_remove();
@@ -477,7 +473,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	struct rockchip_pcie *rockchip = arg;
 	struct dw_pcie *pci = &rockchip->pci;
 	struct device *dev = pci->dev;
-	u32 reg, val;
+	u32 reg;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -491,8 +487,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	}
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		val = rockchip_pcie_get_ltssm(rockchip);
-		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+		if (rockchip_pcie_link_up(pci)) {
 			dev_dbg(dev, "link up\n");
 			dw_pcie_ep_linkup(&pci->ep);
 		}
-- 
2.25.1


