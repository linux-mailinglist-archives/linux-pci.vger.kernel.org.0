Return-Path: <linux-pci+bounces-26561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B6A99511
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4818872B3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85090280A5A;
	Wed, 23 Apr 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdtHlFVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763F27C87C;
	Wed, 23 Apr 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425529; cv=none; b=MbDJVMRMW+fc39T9LTOoP3JDqMhL4atdYKP+2RkZpHL8oZ7wVU/R10AiJiCGBZj+kwP3yy0BG5V1ZgLJPN3/5AhCPhvxpCCLpRtKpjmmOF+ZJAGjzrKSJFN3RLZa3mXKhtBBWwbJmTFndBe4Tq58/bBXHkb1jPndX7J5N3FwA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425529; c=relaxed/simple;
	bh=03WXX9bI80F4RuR2COjFJcSHqoLClrUtwLqycde4R5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpmhl3UDGfh1Fa8l9S0BqthlChN03smq2CAfZ7z1UiAFA+PvjfKUO6tk2Mxpdnh0E2Egy27SuZ1XBO3dmW2CeHMjzwCMwCaAc5ceJ4bzBGBUW/crMPL/5gqAkyyrNWkLq+mOSXiQ/jpU0kjGTBobe2vaev3WJ3M/ExNVKjMZoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdtHlFVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4D2C4CEE2;
	Wed, 23 Apr 2025 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745425528;
	bh=03WXX9bI80F4RuR2COjFJcSHqoLClrUtwLqycde4R5o=;
	h=From:To:Cc:Subject:Date:From;
	b=KdtHlFVG+C2C3wnnQCGlOHOAd1wKtHZPuDrQpRmQqsuVUHE72k4FzU5qWE1J5rgR/
	 /ZsIDe6BB+Yiufu3qFAbjC6/+P6tEHWQWsgwekIt5GO4tVg9gLMElRV8Xc4N1NV8BJ
	 PTCC2Sq9JC+byFkU3fcrcOgH6m+0ahty6Ty/OfhIBWSUGTHu1Fx0TDWzk1zA4JfU+G
	 F3QMd7ijPr1RMiQ2XZoqhHkEGsF3cNdjR4lQEDhevqQL1e+7dRHrNYzUWWgV/BLJ9D
	 2fRRm/Sp9fBSmYrKrModt5KlcNdqrhkfiIoKCqgxu0ssRpjpOAwtffqvY0tDdrBhII
	 XCdfSjKgyS1Pw==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pci: j721e: fix host/endpoint dependencies
Date: Wed, 23 Apr 2025 18:25:16 +0200
Message-Id: <20250423162523.2060405-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The j721e driver has a single platform driver that can be built-in or
a loadable module, but it calls two separate backend drivers depending
on whether it is a host or endpoint.

If the two modes are not the same, we can end up with a situation where
the built-in pci-j721e driver tries to call the modular host or endpoint
driver, which causes a link failure:

ld.lld-21: error: undefined symbol: cdns_pcie_ep_setup
>>> referenced by pci-j721e.c
>>>               drivers/pci/controller/cadence/pci-j721e.o:(j721e_pcie_probe) in archive vmlinux.a

ld.lld-21: error: undefined symbol: cdns_pcie_host_setup
>>> referenced by pci-j721e.c
>>>               drivers/pci/controller/cadence/pci-j721e.o:(j721e_pcie_probe) in archive vmlinux.a

Rework the dependencies so that the 'select' is done by the common
Kconfig symbol, based on which of the two are enabled. Effectively
this means that having one built-in makes the other either built-in
or disabled, but all configurations will now build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/cadence/Kconfig     | 4 ++--
 drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 72d7d264d6c3..666e16b6367f 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -44,12 +44,13 @@ config PCIE_CADENCE_PLAT_EP
 
 config PCI_J721E
 	tristate
+	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
+	select PCIE_CADENCE_EP if PCI_J721E_EP != n
 
 config PCI_J721E_HOST
 	tristate "TI J721E PCIe controller (host mode)"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
-	select PCIE_CADENCE_HOST
 	select PCI_J721E
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
@@ -61,7 +62,6 @@ config PCI_J721E_EP
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	depends on PCI_ENDPOINT
-	select PCIE_CADENCE_EP
 	select PCI_J721E
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index b87bc26bbf06..f0051805f9e9 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -475,7 +475,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
+		if (!IS_ENABLED(CONFIG_PCI_J721E_HOST))
 			return -ENODEV;
 
 		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
@@ -494,7 +494,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		pcie->cdns_pcie = cdns_pcie;
 		break;
 	case PCI_MODE_EP:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
+		if (!IS_ENABLED(CONFIG_PCI_J721E_EP))
 			return -ENODEV;
 
 		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-- 
2.39.5


