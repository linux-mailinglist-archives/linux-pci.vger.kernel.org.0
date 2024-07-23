Return-Path: <linux-pci+bounces-10645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FF93A170
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8FD282383
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895A208A0;
	Tue, 23 Jul 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O5PpebQ3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h6o/O+FV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713815219E;
	Tue, 23 Jul 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741486; cv=none; b=L+1T1TZyWCO0jj3p5pIRqxuKBKy2nUKaX1ISra6zFETYZGNyj49Z/68uE22LMxi/AMyHJz2uz5CCZ2yI7sWhBSKyT5tADcxchfsNyo1YuVF9b6jWBdxxqmgNfqli4mEkpP/AzhUKtsJ1lbFJkI55U+BP2PTeE1wPCYyYuIcbIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741486; c=relaxed/simple;
	bh=sWTnBGWRNkNBDbsS/HkSb6CYxrqespgnN6iC4Mq9deM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPDm15gJzCXLJscEKxXAwms0dTYuI8PRpYTK00lxQWx21POpyzLruEa5doMbv17qxapsTUwmfDSRYKwWtNcUkWdWaA77H7y0AkDA8D4ge4qk+5Gx1xLMfiksHD5V57fKmd+aZN4fe3eR6FPTHHuwtmdXcf/2XRioj39jk7j49RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=O5PpebQ3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=h6o/O+FV; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WSyj55Cv5z9spD;
	Tue, 23 Jul 2024 15:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlsaWuidAL5RI8AvyPYKTmmYV22DqYfexUouesKrmXY=;
	b=O5PpebQ3xkx5Lr1qrFV9TdUQf2+jgFWk5KNDz4PwmB7T+nsBD1Z+LKO1/V1f11y49VNgA4
	aShy9tQO97TcQKxqoK9w8B4Bs8ea2lThKP/yR+R3+AQIECxTUwwaDV9Cbx5Hg8tA6/1HFI
	D8T91CrXEgBYZFDm4hoLSyPH+CxUxa+0DRAn7V3f/3LXB98jjkDjts4ABNk05be5ik3ia8
	wtsOcM80lolfbs3MnpBu+0orQ7WOaAZEe96f2gYItM/kvzf1rZPhr6qCK0nF2A+x5Uw90A
	Y0BvCknpHyOwkuMHYcHP8Jd6FN6LPimsIuu7Cq9QvxOeCI+Bor8Bywnwp5wlqA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlsaWuidAL5RI8AvyPYKTmmYV22DqYfexUouesKrmXY=;
	b=h6o/O+FV9gt+lmpGWNmfFJu9RC4ih9kEinjtLPMrYN3UkugSqnNdF8LgJjLAG7c6wj04SZ
	532GVRfBOomu/loOtUZDVundBQESKsVEfHkoAoRbhh4Smd7/qG123ZqEMOsd+fIVpdjtOZ
	2ldIwSPapwAFg5JAvIOKgl5VVu6oujyy929YdBuQUIp7vAuAAAOWTDJT6N7qDqy+yyDcmn
	A9QhqGx57cH0TYGXOj5zRLZycBimBNvKrx/oYJ9uPcosq/IUs3QKU/Rte38Ihq/ZYfwvWs
	7EDNMDdwYdeuJg6odZcyXrDDmg9G0Sy9PMy4tXSqT8L6j8dRylI2L5fzszEMxQ==
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
Subject: [PATCH v4 06/15] PCI: mediatek-gen3: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:06 +0200
Message-ID: <20240723132958.41320-7-marek.vasut+renesas@mailbox.org>
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
X-MBO-RS-ID: d727ed4a519b83792ea
X-MBO-RS-META: 3984toaxbhuxegkxod1ibi51e6frj81f
X-Rspamd-Queue-Id: 4WSyj55Cv5z9spD

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
 drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b7e8e24f6a408..392b6ef3473f2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -424,12 +424,6 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	return 0;
 }
 
-static int mtk_pcie_set_affinity(struct irq_data *data,
-				 const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
 static void mtk_pcie_msi_irq_mask(struct irq_data *data)
 {
 	pci_msi_mask_irq(data);
@@ -450,8 +444,9 @@ static struct irq_chip mtk_msi_irq_chip = {
 };
 
 static struct msi_domain_info mtk_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MULTI_PCI_MSI,
 	.chip	= &mtk_msi_irq_chip,
 };
 
@@ -517,7 +512,6 @@ static struct irq_chip mtk_msi_bottom_irq_chip = {
 	.irq_mask		= mtk_msi_bottom_irq_mask,
 	.irq_unmask		= mtk_msi_bottom_irq_unmask,
 	.irq_compose_msi_msg	= mtk_compose_msi_msg,
-	.irq_set_affinity	= mtk_pcie_set_affinity,
 	.name			= "MSI",
 };
 
@@ -618,7 +612,6 @@ static struct irq_chip mtk_intx_irq_chip = {
 	.irq_mask		= mtk_intx_mask,
 	.irq_unmask		= mtk_intx_unmask,
 	.irq_eoi		= mtk_intx_eoi,
-	.irq_set_affinity	= mtk_pcie_set_affinity,
 	.name			= "INTx",
 };
 
-- 
2.43.0


