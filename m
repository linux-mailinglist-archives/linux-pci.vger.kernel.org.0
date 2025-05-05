Return-Path: <linux-pci+bounces-27238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2949AAACEF
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0116E1A866E0
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14983A80F5;
	Mon,  5 May 2025 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4UsxWWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7722F5F81;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487043; cv=none; b=dLH8XIIr9Bh4AU0UvNytDUyqBE71ZBnspP+5kmJnKKx+lYsOirusCkRkejca/EPTJYKVqojj0Jg5FwYaDRrpYJx1TCcU7c9bFzicg0JnkIWfAtFGzUjkyp1nDHPMvJaXYWNrpl8CMFjDzpNMgc6JXaRKjYzugrSpA1+JUs35nQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487043; c=relaxed/simple;
	bh=CxzDOEhPeAMdFnioim5gogV4IBxuwBb0TfkNgH4trfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7Dx9pNMl1rVB7cN++wrx0rjftAWVc97hDn/K79sTctH63Ax4pqrI9LGqYHzKJ59rc+8Yo/kjZnNOMphxJHFr5F5PjJfb6+N462it+Hw3I9Ys2Z+MLDLtj/4nSG8iUF8P8CdZOi7LDbid+AzqJXDjlYMmZSXOoZA0SbZAwjKZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4UsxWWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA52C4CEF4;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487041;
	bh=CxzDOEhPeAMdFnioim5gogV4IBxuwBb0TfkNgH4trfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S4UsxWWaIuXb/2+SApec3EF5Hpe3veh5fMyMgqyPRRmsQPVgpZfY8zhMuISOkQLdp
	 PokFIuoFCO/Y9N8ArOGvawKsu7LZjiVY1xsvcZDvYBCpOVte9eV4EdXtLJA/FiYHfq
	 o0zK125bpb+eV0bWvVs1kQKVmf3fIGGUD+eDbAHLzBKsSCnaa4iJfEgcIBubkXLQXk
	 wsoNX9UREjnmMO0Nu6g99wxcAMScB7pU+xgFKC6l0yxLaT4o8oz2hO8Jdc2JylOzVM
	 Euj9moflKtnk58x3UEpjuhTxM03Di6B49xdeFg/Ro2onWgfvOYWYn8rgJqFj/wl4Vu
	 LT4WV1Z4Pc6zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECFC3ABC3;
	Mon,  5 May 2025 23:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 18:17:22 -0500
Subject: [PATCH v5 3/3] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v5-3-827aaac998ba@gmail.com>
References: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
In-Reply-To: <20250505-pci-tegra-module-v5-0-827aaac998ba@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746487040; l=2578;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=HNeyxqklHxYO1Z7cAeod50HxFJLbvD8WnX339dtMaiA=;
 b=fo9TtaSwgnvyZQgGNVox7gBbbZWS5P86hTXhr9PHEDbnBO0nSk1f8JZRc8ZwDeCXX1jrsBORI
 FOCgV6oimC2AAeHSEiboaqMaI+z8Y0mbfnKQSpAIzD3iAmgfdCdhCMD
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This changes the module macro back to builtin, which does not define an
exit function. This will prevent the module from being unloaded. There
are concerns with modules not cleaning up IRQs on unload, thus this
needs specifically disallowed. The remove callback is also dropped as it
is unused.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-tegra.c | 29 ++++-------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b768105402d6dd1ba4b134c2ec23da6e4201..a9164dd2eccaead5ae9348c24a5ad75fcb40f507 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -224,7 +224,7 @@ config PCI_HYPERV_INTERFACE
 	  driver.
 
 config PCI_TEGRA
-	bool "NVIDIA Tegra PCIe controller"
+	tristate "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
 	help
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b3cdbc5927de3742161310610dc5dcb836f5dd69..e2d976c126817808933ca936cf650088157283be 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2674,29 +2674,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static void tegra_pcie_remove(struct platform_device *pdev)
-{
-	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
-	struct tegra_pcie_port *port, *tmp;
-
-	if (IS_ENABLED(CONFIG_DEBUG_FS))
-		tegra_pcie_debugfs_exit(pcie);
-
-	pci_stop_root_bus(host->bus);
-	pci_remove_root_bus(host->bus);
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		tegra_pcie_msi_teardown(pcie);
-
-	tegra_pcie_put_resources(pcie);
-
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		tegra_pcie_port_free(port);
-}
-
 static int tegra_pcie_pm_suspend(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
@@ -2800,6 +2777,8 @@ static struct platform_driver tegra_pcie_driver = {
 		.pm = &tegra_pcie_pm_ops,
 	},
 	.probe = tegra_pcie_probe,
-	.remove = tegra_pcie_remove,
 };
-module_platform_driver(tegra_pcie_driver);
+builtin_platform_driver(tegra_pcie_driver);
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1



