Return-Path: <linux-pci+bounces-10653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1993A18E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497AC1C223AF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE01514D6;
	Tue, 23 Jul 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RmTn9eda";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MHc7MTKL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCC152E0D;
	Tue, 23 Jul 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741538; cv=none; b=JSvYoQiorhWOXBN4vmRNPqLUkQsTsjWqVOrw9dNGPC8TmL+wYtq0OTGGNwgJSvIs9s5xMaBG9GjBDwefi4CDQa3ga4qMJhSgexT8wKNufTX+IuCRDFc6orEGlyiRquG5Mbe3BG60U3e1q2Ypm5Vqf59hDQna87VXJydjj/IgfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741538; c=relaxed/simple;
	bh=itfldeCV5E8PbLp3l95eB5U+jln7FFIctMAYHM/2s4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCF0l+IwQnBVmsmtP5dfF9Pb2ncOciRnRFDQJIziZggGClD7nPx/YDAUXz4K28nnpoE586MQ9ZyeS6eMRm94sa5Nmw4e96z8vH2hD7xjHKPuzsDPZYuB4D6WGxWfQqxAViNKUs+C4uhIRY7RNzWFs1z+J1vfCDLlbl1rDM/guyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RmTn9eda; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MHc7MTKL; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WSyk71Nm6z9spg;
	Tue, 23 Jul 2024 15:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgM4414BXkzkG7/YyYKWSiYAFiOZmUO66T1MzLWmSjA=;
	b=RmTn9edate3rhYmSZifp/dwGtAeb5LNq8e3eP6ZuvWsXZHLMLXU/FIuzRrtw5P+/BPFZ02
	+pvGza9+O2vzJf3u9YhFp2pKGfgRTdJZTN4m4Q0AUqufKQj/mwTs8hR5iKlWGcyLg+tJKI
	yOt71dK7WiUAsFJGRzCnGoLeHnfIADNYl6zyKO6uIWG8OXwUR6cyicCQRGeGtiGAp1ep4j
	OxmzyiI7e9+Ry7mJTCMKiOYYphtkCIhheGOf6tXeHE3fDi4z0xkgzcW7h22IVogatG3V1W
	WjH/H9gW+ZWHLvm/k3NCxf/2QR3A2ViJfGfiWl3IoMXaYGRQr4s+dYAHkyXzlw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgM4414BXkzkG7/YyYKWSiYAFiOZmUO66T1MzLWmSjA=;
	b=MHc7MTKL2oG5unIib99U2ueqFvhCaPQtdUQZYGrGo3VYqmB3aCXV3YkGz1nMwS61BVLe5/
	8ry1rFxjDM1y/bwdqCdnzKQaWUzeHcSJHOB9DE9i/q/E+pNrHxu4SuQuLMVQugXdcXcqjM
	XY+UFQ07gHtGDrHIT07+wABbGW7RK8TPi/YfS1GWaQJ9xS7PPbe+RoekwqlKYqRy/X6XpY
	CX+g/31G6knvpLYDPvkFfyeCCZ18l1sGwLV5nj/08iqmN0MSBQt+ZXPuSFN8yIP8u90paf
	0bY+YawIVWx/p9dFoocOjEEN2iwjQocnCQ9SoGKjhBK72DMjUHS3aI21oWti4A==
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
Subject: [PATCH v4 14/15] PCI: xilinx-xdma: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:14 +0200
Message-ID: <20240723132958.41320-15-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: 5ac88d2ff646a9d260e
X-MBO-RS-META: ng6qpsyimt39eabmedpzcda4197488ry

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
 drivers/pci/controller/pcie-xilinx-dma-pl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 5be5dfd8398f2..ca9044d694dad 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -355,8 +355,8 @@ static struct irq_chip xilinx_msi_irq_chip = {
 };
 
 static struct msi_domain_info xilinx_msi_domain_info = {
-	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI),
+	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		 MSI_FLAG_NO_AFFINITY | MSI_FLAG_MULTI_PCI_MSI,
 	.chip = &xilinx_msi_irq_chip,
 };
 
@@ -370,16 +370,9 @@ static void xilinx_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->data = data->hwirq;
 }
 
-static int xilinx_msi_set_affinity(struct irq_data *irq_data,
-				   const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static struct irq_chip xilinx_irq_chip = {
 	.name = "pl_dma:MSI",
 	.irq_compose_msi_msg = xilinx_compose_msi_msg,
-	.irq_set_affinity = xilinx_msi_set_affinity,
 };
 
 static int xilinx_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-- 
2.43.0


