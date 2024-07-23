Return-Path: <linux-pci+bounces-10640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7893A160
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 15:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D7F1F22CAF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD7152199;
	Tue, 23 Jul 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y2AWuERV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PLmOVbuC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48213481AB;
	Tue, 23 Jul 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741453; cv=none; b=rzIpLyTuekPFFx80w46A+XH6owTRbwy1iFuHvTvwXiiSkz/YN0Pf8/CxF+UnXjO5n0TTLl4zPtRr50Vwu26RR50fNz6SH/6OvsQtVqBdqWwYAboT6AM3QnatjjRwD87uNcfF9n/BEtBGKmELmrPMwL/15WH5OK+MAg86Nl+Ncr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741453; c=relaxed/simple;
	bh=rWPTjngTc60gvinmaTVa3YHZr1tPjjrUKWHzz7oCCcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UljMSQwKm/Ye21eJNmZmgopQmv7tPkDXBcOu3lYPY2AT6l7JRwR0i5Wmp7mZ5nF8ogXS0fK2Tq3wBdMEDbJ7qoG7hnNyHPJ7/C1WRS48TpiTtgdqpuB6elwD3N9uPQJhY61lRgGJow+nDMKDjFC9bvHwusjL261RvhFG2D2J8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y2AWuERV; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PLmOVbuC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WSyhK2Yh8z9t1n;
	Tue, 23 Jul 2024 15:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WJ8/yjG0WAqafZH4QnFUXuIlg0fGGpm7eTD57+1xNB0=;
	b=Y2AWuERVyPuw/GTZNMVtyONT95Qxumb32NOxzmHcLNu7eGdbSYQ6DczalHND0QoOMXmD8t
	6gW6hcdE83i2NsNBn2SnTPUt9Zv32knky+0BJb5uV4NoleS1X5gihaDj7OahzJXqQxCk6z
	yxkYlDd1gf8xlzJPHsJLmu/chdkjqz280BKTR0i0PKSZPpv0ntOzVgn4j7OcKlEnQFx+6u
	a5adpEVLiO06NOOQSjCTAroaBjS+A3X4UcyFljrhD028N9W6ww2TJyEfw+9li4Mp6R/SHL
	SjHtirS9qTgPiq6gN8O4ZoZG+xG1rX3C1JZrTLkfY766bJ5MqHRdC5KYabvghQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721741438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WJ8/yjG0WAqafZH4QnFUXuIlg0fGGpm7eTD57+1xNB0=;
	b=PLmOVbuC7j5gXqf7qT3AovYU/pGlBsypJW8jnkV1SOru4ZB8uTTc6yV6nR+9Mvv/RBme0u
	QTNXN3XalBgpD2CQS9sBuTjNMT3FvXEHnJmCrf7sjRBKd1426BYzynwdEBT0X+xajUTOWZ
	WHibepjww8tHrfv4h1P/MQMHaiTAlQMxrUGYw5xkwQy3nOH9by2SrA4QIYYCOqxQOP2sOF
	C/Hm3cPFMyZxl8juQzyQp6Rb+03fHHkuGQPTZhSynWR7GwwMeWAuWpDcspsql0w/NeYz1c
	plp09d0ApXfdMWSmOpPDSonTkebE+KqC9te83Lcu1rIgMqvUxDB+0rzCz+XhEg==
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
Subject: [PATCH v4 00/15] genirq/msi: Silence set affinity failed warning
Date: Tue, 23 Jul 2024 15:27:00 +0200
Message-ID: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 24178387527e202062d
X-MBO-RS-META: sw67y9k81nzs14pncsmk9zd98aj8jr41

Various PCIe controllers that mux MSIs onto single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. Remove the
.irq_set_affinity callbacks and make sure they are NULL in all affected
controllers, so this warning in kernel/irq/msi.c is not triggered.

This has been compile-tested only on all but the R-Car PCI controller.

The clean ups are done per-driver so they can be easily reverted in case
they break something.

Marek Vasut (15):
  genirq/msi: Silence set affinity failed warning
  PCI: aardvark: Silence set affinity failed warning
  PCI: altera-msi: Silence set affinity failed warning
  PCI: brcmstb: Silence set affinity failed warning
  PCI: dwc: Silence set affinity failed warning
  PCI: mediatek-gen3: Silence set affinity failed warning
  PCI: mediatek: Silence set affinity failed warning
  PCI: mobiveil: Silence set affinity failed warning
  PCI: plda: Silence set affinity failed warning
  PCI: rcar-host: Silence set affinity failed warning
  PCI: tegra: Silence set affinity failed warning
  PCI: vmd: Silence set affinity failed warning
  PCI: xilinx-nwl: Silence set affinity failed warning
  PCI: xilinx-xdma: Silence set affinity failed warning
  PCI: xilinx: Silence set affinity failed warning

 drivers/pci/controller/dwc/pci-keystone.c           |  7 -------
 drivers/pci/controller/dwc/pcie-designware-host.c   | 12 +++---------
 .../pci/controller/mobiveil/pcie-mobiveil-host.c    | 11 ++---------
 drivers/pci/controller/pci-aardvark.c               | 10 ++--------
 drivers/pci/controller/pci-tegra.c                  | 10 ++--------
 drivers/pci/controller/pcie-altera-msi.c            | 11 ++---------
 drivers/pci/controller/pcie-brcmstb.c               | 11 ++---------
 drivers/pci/controller/pcie-mediatek-gen3.c         | 13 +++----------
 drivers/pci/controller/pcie-mediatek.c              | 11 ++---------
 drivers/pci/controller/pcie-rcar-host.c             | 10 ++--------
 drivers/pci/controller/pcie-xilinx-dma-pl.c         | 11 ++---------
 drivers/pci/controller/pcie-xilinx-nwl.c            | 11 ++---------
 drivers/pci/controller/pcie-xilinx.c                |  9 ++-------
 drivers/pci/controller/plda/pcie-plda-host.c        | 11 ++---------
 drivers/pci/controller/vmd.c                        | 13 +------------
 include/linux/msi.h                                 |  2 ++
 kernel/irq/msi.c                                    |  2 +-
 17 files changed, 32 insertions(+), 133 deletions(-)

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

-- 
2.43.0


