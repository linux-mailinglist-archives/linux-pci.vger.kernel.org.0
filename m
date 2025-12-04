Return-Path: <linux-pci+bounces-42618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28CCA31E1
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 10:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9A3300FE27
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC92C0276;
	Thu,  4 Dec 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yypwfvrn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939B29E109;
	Thu,  4 Dec 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842136; cv=none; b=FvBvz+VNf7pnGDPM45VDeOlAZ/bJBDXNRvFThg5tqNG0Bv2Nkqdszh/mQiwwAkNB9En1wEWsEEI88bIS+VuDwg15gZDU3zdUhFTzbC1NxWOyQ86hyRTNSITDUssXpllQdKgVCo1Nrm2U95z/7+PoLZ446GClY3ptN8PyEoTYKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842136; c=relaxed/simple;
	bh=8bVoPiBLLlVfVVp6odOEmBBiLH9EfnincdlauA2ju/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvEEiAfk8ZIxP+CXnaa2fvLfdNdkNF+WtP2CSSPuMOj3t+F9uvspE+x/XzE4ucAEUchzJhCR++42lQa2Bgg9l3yYHKkOoydE5v49Stbm2R/m97UkANP19Tt5JM3d3EuouKCVFvF55DWHzyP+UWkoou6YeRsm51sW1s0EErf8Tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yypwfvrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF2AC4CEFB;
	Thu,  4 Dec 2025 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764842136;
	bh=8bVoPiBLLlVfVVp6odOEmBBiLH9EfnincdlauA2ju/0=;
	h=From:To:Cc:Subject:Date:From;
	b=Yypwfvrn6HZTJcbk/vSoSUJQvqI7E7j4/Y3kYYWAkoi8Rc7Ff6RffZShAhICz1z/b
	 juPWlKAFivsJQ/IU3wff/lj60tgsipp049NaUYNx+lVZVLzywqsKfMNqPls/7aL3eZ
	 vFU06O8bFGOlHA/BI72VZb3uWbtjkt5N6M+C6Vb+nH2Ku4hiLce3ytV1pB6J7F35Un
	 VZDvrckUAV6Odrjl2u2zvlbL5YynA38feWsK+5vn7K/YvIJqe/Ke+t8RHOQSGYdeGV
	 hxR9NYNNZTDf8tR1//SaO7TBbOqMfZJfXEH4/LckMLyN649KdAtimUEq8/PCJhQQT0
	 vtSO7MvYxX9BQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikandan K Pillai <mpillai@cadence.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: cadence: fix build-time dependencies
Date: Thu,  4 Dec 2025 10:55:22 +0100
Message-Id: <20251204095530.1033142-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The split of the the cadence pcie controller driver into three modules
does not match the Kconfig structure, as the common symbol tries to
call into the more specific ones. If one is built-in but the other is
a loadable module, we get one of these link errors:

arm-linux-gnueabi-ld: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
pcie-cadence-plat.c:(.text+0x33c): undefined reference to `cdns_pcie_host_setup'
arm-linux-gnueabi-ld: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
pcie-cadence-plat.c:(.text+0x264): undefined reference to `cdns_pcie_ep_setup'

Move the two parts back into a common module to ensure they can always
link, while keeping the optional parts out of possible.

Fixes: 611627a4e5e4 ("PCI: cadence: Add module support for platform controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
We had discussed this on the list earlier, but I independently ran into
the problem while build-testing. This was the version that actually ended
up passing randconfig testing for me.
---
 drivers/pci/controller/cadence/Kconfig  | 15 +++++++++------
 drivers/pci/controller/cadence/Makefile | 12 +++++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 9e651d545973..978ffe9a1da2 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -7,16 +7,14 @@ config PCIE_CADENCE
 	tristate
 
 config PCIE_CADENCE_HOST
-	tristate
+	bool
 	depends on OF
 	select IRQ_DOMAIN
-	select PCIE_CADENCE
 
 config PCIE_CADENCE_EP
-	tristate
+	bool
 	depends on OF
 	depends on PCI_ENDPOINT
-	select PCIE_CADENCE
 
 config PCIE_CADENCE_PLAT
 	tristate
@@ -24,6 +22,7 @@ config PCIE_CADENCE_PLAT
 config PCIE_CADENCE_PLAT_HOST
 	tristate "Cadence platform PCIe controller (host mode)"
 	depends on OF
+	select PCIE_CADENCE
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
 	help
@@ -35,6 +34,7 @@ config PCIE_CADENCE_PLAT_EP
 	tristate "Cadence platform PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
 	select PCIE_CADENCE_EP
 	select PCIE_CADENCE_PLAT
 	help
@@ -45,6 +45,7 @@ config PCIE_CADENCE_PLAT_EP
 config PCI_SKY1_HOST
 	tristate "CIX SKY1 PCIe controller (host mode)"
 	depends on OF && (ARCH_CIX || COMPILE_TEST)
+	select PCIE_CADENCE
 	select PCIE_CADENCE_HOST
 	select PCI_ECAM
 	help
@@ -60,6 +61,7 @@ config PCI_SKY1_HOST
 config PCIE_SG2042_HOST
 	tristate "Sophgo SG2042 PCIe controller (host mode)"
 	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
+	select PCIE_CADENCE
 	select PCIE_CADENCE_HOST
 	help
 	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
@@ -68,14 +70,14 @@ config PCIE_SG2042_HOST
 
 config PCI_J721E
 	tristate
-	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
-	select PCIE_CADENCE_EP if PCI_J721E_EP != n
+	select PCIE_CADENCE
 
 config PCI_J721E_HOST
 	tristate "TI J721E PCIe controller (host mode)"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	select PCI_J721E
+	select PCIE_CADENCE_HOST
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
@@ -87,6 +89,7 @@ config PCI_J721E_EP
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCI_J721E
+	select PCIE_CADENCE_EP
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
 	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index b8ec1cecfaa8..139ac0a0de6f 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -1,11 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 pcie-cadence-mod-y := pcie-cadence-hpa.o pcie-cadence.o
+obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
+
+ifdef CONFIG_PCIE_CADENCE_HOST
 pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-cadence-host-hpa.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-host-mod.o
+endif
+
+ifdef CONFIG_PCIE_CADENCE_EP
 pcie-cadence-ep-mod-y := pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-ep-mod.o
+endif
 
-obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
-obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
-obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
 obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
-- 
2.39.5


