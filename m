Return-Path: <linux-pci+bounces-10644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA593A16C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424E11C21ED5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA9208A0;
	Tue, 23 Jul 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ctj/JtkX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X1wI0314"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66891527A9;
	Tue, 23 Jul 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741479; cv=none; b=S2W+hmXUi03OgAqGHn1yGTXN9hy+FA8kFgayVpi8tFUeZCI+c4Oxz64/ldQJyEh7heMZwCWQoI0Ylu5bj3spxirXBnNFbrqZQxrOYaO105oSISM3OOvB6RBLoWSkefCZzwOR0ZRgHXHu8XcPN8suf9jFON/Dd2ZFe0KZaZZVWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741479; c=relaxed/simple;
	bh=hYVW68IBGaUuBF7EXqfY6or9hGY1Vr0XH9E5DAFVt54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRGBZUxrEmEMhevlJedUIcxKrsoaiv70V1QuC7KBEsIHJDoR9Ki4L2PpUylfvclaWrboQ6tKaAiACbgQGADmB/9UUs7/d1CC7QCg0TmH+7NwaqfhTmvK5RNW+FakGi0fW886fhlGl/d4Cy4IHq1r1kswbl9Nu4UkG9Q3eijQG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ctj/JtkX; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X1wI0314; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WSyhy2z1Yz9sWC;
	Tue, 23 Jul 2024 15:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5SmIVjWJ5aRwpjgPLfLTbpDUhNxuwjwJx199NaZrkA=;
	b=Ctj/JtkXM6TOEcQy0rOqNUV82J1F0YuPG5IJBK+0+Xaye8omY7oIqnX+DAWZQsELd91Nvj
	RCyC2in9O5loQ+K84NuVizR7UoJtda6ArgCO/l8X+PYSIVftuPhFU6agnveEBBVhz+zdvA
	Jt5A+sS6SetZSkTcKy/k2Vo97P5uvIsQCAEHu4L3Pqhohd1sz6zXWXzDr3RtbuyZ5djCOY
	SCAzsL9B5gd7AaZXU1mj2ia+yzrDqDBFcB2F90F43HoqqXFYp04iDxvBjkEGKup1zRtRzj
	WFdAuUgjCQRXrWBeruE/wfrfX2qVBoNqzkmIx2SSWtrav5nOhMEw7279ilXMxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5SmIVjWJ5aRwpjgPLfLTbpDUhNxuwjwJx199NaZrkA=;
	b=X1wI0314yv1Qp/cvD9nMce9s8WSHsXbP0O9Go612qepuTbnbcIqsYyYLUbxx5vB6cv4a1K
	ZYpkK7ay8A91YL6hKS/TGwD3ZqID11r0CHcIppDMFiZAFUBRR61spbP+U9guYECBhqUkNI
	+TyOjQVu9ugOkxldUkdw/KvWeZki6tV5aaoJgOa4+70CM482fJemdO1nM+nbJk6ic+nuRm
	QMkZHPlD24w/DnlYBUSYOBEGkBDUfV57vGBvnPHdNOYj2y3HOo8UX8iYjaZ63C0E2q+rKi
	ND3ZhgEzzA+5cl6H2S0pTccSlxZ5zrmtaqYDuMiWHRDsuROfV4Hogn7Dq1BUlg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v4 05/15] PCI: dwc: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:05 +0200
Message-ID: <20240723132958.41320-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
References: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 888163b2c446ff680e4
X-MBO-RS-META: qa63b3rbiiyytyu5jopob41soabsroj7

Use newly introduced MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity unset
and allows migrate_one_irq() code in cpuhotplug.c to exit right away, without
printing "IRQ...: set affinity failed(-22)" warning.

Remove .irq_set_affinity implementation which only return -EINVAL from this
controller driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Jim Quinlan <jim2101024@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
---
V4: - New patch
---
 drivers/pci/controller/dwc/pci-keystone.c         |  7 -------
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 +++---------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 52c6420ae2003..ce9d9e0a52609 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -189,12 +189,6 @@ static void ks_pcie_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int ks_pcie_msi_set_affinity(struct irq_data *irq_data,
-				    const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void ks_pcie_msi_mask(struct irq_data *data)
 {
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(data);
@@ -247,7 +241,6 @@ static struct irq_chip ks_pcie_msi_irq_chip = {
 	.name = "KEYSTONE-PCI-MSI",
 	.irq_ack = ks_pcie_msi_irq_ack,
 	.irq_compose_msi_msg = ks_pcie_compose_msi_msg,
-	.irq_set_affinity = ks_pcie_msi_set_affinity,
 	.irq_mask = ks_pcie_msi_mask,
 	.irq_unmask = ks_pcie_msi_unmask,
 };
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a0822d5371bc5..3e41865c72904 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -48,8 +48,9 @@ static struct irq_chip dw_pcie_msi_irq_chip = {
 };
 
 static struct msi_domain_info dw_pcie_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MULTI_PCI_MSI,
 	.chip	= &dw_pcie_msi_irq_chip,
 };
 
@@ -116,12 +117,6 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
-static int dw_pci_msi_set_affinity(struct irq_data *d,
-				   const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
@@ -177,7 +172,6 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name = "DWPCI-MSI",
 	.irq_ack = dw_pci_bottom_ack,
 	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_set_affinity = dw_pci_msi_set_affinity,
 	.irq_mask = dw_pci_bottom_mask,
 	.irq_unmask = dw_pci_bottom_unmask,
 };
-- 
2.43.0


