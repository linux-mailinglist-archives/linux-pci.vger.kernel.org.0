Return-Path: <linux-pci+bounces-36958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E208B9FA9E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621AA7A4316
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB92848B3;
	Thu, 25 Sep 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bAAaVkeg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZbzmUISU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35323D287;
	Thu, 25 Sep 2025 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808238; cv=none; b=rDzTfm/uNa/EU+2jIwfnExCDMceHhUsE0SP1mSmT8S6uIVe1fxGxmB/ndL/ztlvT9vksmOJzieb/jAfDqGzCAGWnEV/WjPu/0qnSeNEnWq03twQbplYgAFIPnJPghUYpQy95funTy0dlN7nBVzuH81YF78nmXN4gjzJPjgC6UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808238; c=relaxed/simple;
	bh=5VZtnlz8SLZh1hJUOEN8X4K2QYuKaXR8uZPnfTSelpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kd2vg1mj29TKfSTy3tEdIHsxICtcEw3/O/nNzuR3NlKKiacDVLPRqPl+6I8VmSuQUbkOES0HaWGDIn4Rfw34oBiTadhJQbhMWLiGXpz8PmVRhqUxoLjBFoIgyU5wNVVkS/y4YQQcOwEnA+nF1IU+nG9KQlmLrC5C0Z9wgHoQ7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bAAaVkeg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZbzmUISU; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cXZqG19Nyz9tSd;
	Thu, 25 Sep 2025 15:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758808234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sa813ro74wVcAWbPynO8r+wVmbDbagBCRzrt3WOCBcE=;
	b=bAAaVkeg3qkXwX4rxpXeQjO8w10KWFZmVYNUDH7FNzbMijDNrep6/AKissmRy9wjMpwrzz
	T4THZTRE54LcehdU0EbyAT4X1bDXrrwydEHw9nAanK8WXC1lYRey98BjpLmEl5cWIrJurf
	3BEFs/ZWNZv/LYiW2thKb8W3L+KYEWesRiFQB/1fRubC+KxbEHDy0Nm8Zb9qhAbhnbO2sd
	Zg56IGGbo5DuIJ+8h6od+r/nP9Gf7Wqdy4RW8UVnk6hjGfaBdsZtqsWGCzGbFxe11B9XS3
	jtNNRWLmqYtdNfVInSeVa0q3TzIrhiLaUk0QgXIflOn2WWDEVtu2wSB0lvR+WA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZbzmUISU;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758808232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sa813ro74wVcAWbPynO8r+wVmbDbagBCRzrt3WOCBcE=;
	b=ZbzmUISU3AA94pt7HWxwPSTM7AvtX6UBi+I5ZnfPym7FYxSHMJGwr5gPIhNGsQG/k75DY/
	tWQSgjxuNJXdNaaKAT/C0EOlQBmTdABiqjk6MFYq5WWANbVAT8f0CskqtKWwcHEv5/EV4h
	kHoZJIvJ0tZ8jy3aCZPpOfEUaL+AaGl8TY3x0mXB0oBN6MEw3nC0DHHrlbBXqPqSGyaMH9
	ui+gT7pT0g9oXKBfJRuUtOY590loBkng5cjtO+u/D89AKWHCfRWOUUDwIZKmRvzkpexuhb
	TXKaiq/UVk9ii11Id9x1uSMJjbShuk23ZC5IcVO7rFYEsBdqhAqcxi4tRVwydA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Mayank Rana <mayank.rana@oss.qualcomm.com>,
	Nam Cao <namcao@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: controller: Mark controllers which cannot do lockless config access with !PCI_LOCKLESS_CONFIG
Date: Thu, 25 Sep 2025 15:49:45 +0200
Message-ID: <20250925135014.66865-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9387870ca75cff30f0d
X-MBO-RS-META: askstgdrzeiry8fg1788yjagpq6u8187
X-Rspamd-Queue-Id: 4cXZqG19Nyz9tSd

Add 'depends on !PCI_LOCKLESS_CONFIG' to controllers which cannot do config
access without PCI subsystem level spinlock. If PCI_LOCKLESS_CONFIG is ever
enabled, those controllers would have to be updated accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Bruel <christian.bruel@foss.st.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
NOTE: I hope I got them all
---
 drivers/pci/controller/Kconfig      | 6 ++++++
 drivers/pci/controller/dwc/Kconfig  | 5 +++++
 drivers/pci/controller/plda/Kconfig | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b933..1a6e937cca929 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -12,6 +12,7 @@ config PCI_AARDVARK
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCI_BRIDGE_EMUL
 	select IRQ_MSI_LIB
 	help
@@ -205,6 +206,7 @@ config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select IRQ_MSI_LIB
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
@@ -244,6 +246,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
@@ -332,6 +335,7 @@ config PCIE_XILINX_DMA_PL
 	bool "Xilinx DMA PL PCIe host bridge support"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCI_HOST_COMMON
 	select IRQ_MSI_LIB
 	help
@@ -344,6 +348,7 @@ config PCIE_XILINX_NWL
 	bool "Xilinx NWL PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select IRQ_MSI_LIB
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
@@ -354,6 +359,7 @@ config PCIE_XILINX_NWL
 config PCIE_XILINX_CPM
 	bool "Xilinx Versal CPM PCI controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCI_HOST_COMMON
 	help
 	  Say 'Y' here if you want kernel support for the
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 34abc859c1071..8eab27775195f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -2,6 +2,7 @@
 
 menu "DesignWare-based PCIe controllers"
 	depends on PCI
+	depends on !PCI_LOCKLESS_CONFIG
 
 config PCIE_DW
 	bool
@@ -322,6 +323,7 @@ config PCIE_RCAR_GEN4_HOST
 	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCIE_DW_HOST
 	select PCIE_RCAR_GEN4
 	help
@@ -390,6 +392,7 @@ config PCIE_UNIPHIER
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe host controller support on UniPhier SoCs.
@@ -410,6 +413,7 @@ config PCIE_SOPHGO_DW
 	depends on ARCH_SOPHGO || COMPILE_TEST
 	depends on PCI_MSI
 	depends on OF
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe host controller support on
@@ -488,6 +492,7 @@ config PCI_KEYSTONE_HOST
 	bool "TI Keystone PCIe controller (host mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
 	help
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index 62120101139cb..2a400678312eb 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -10,6 +10,7 @@ config PCIE_PLDA_HOST
 config PCIE_MICROCHIP_HOST
 	tristate "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
+	depends on !PCI_LOCKLESS_CONFIG
 	select PCI_HOST_COMMON
 	select PCIE_PLDA_HOST
 	help
-- 
2.51.0


