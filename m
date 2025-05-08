Return-Path: <linux-pci+bounces-27411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E89AAF192
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 05:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680864E28A8
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE606200127;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViGvOYdE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28411F6694;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674754; cv=none; b=m0FLHP9e+t1M8uYl32ib2Tt6yHLYmVLHyE/W9fJCaebrfOdIuKIZlTbhjYD5PevoQSbY+lqOKHMq82fv/oY06U924pmRHnv0ch5qd2NRUWptgk1HrnrA7gft+Ocx15z+VTSOn1JC61vM8b6YicYCWe48lF9+vyB001ZKIHBPjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674754; c=relaxed/simple;
	bh=GzDz9cR5SrtBbqbUWibsnN39s607NfNtC5D1DtPjxYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3sAYVCgnmSy4upc/7qIlZMVuO2SPRqdEg3SRkdEIZBgylGTH8GBdeJJw5d5AWxut8RpK+m2FOfh+9XDXeOOzi2bbCqb+5kR/VCAVrTBCsk9AVJmylXya1y9TdyeVYDYhBnEiG6KXp9o1FtZAKas72sE6xGPXVqeAtmZWUznIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViGvOYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EF48C4CEF1;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746674754;
	bh=GzDz9cR5SrtBbqbUWibsnN39s607NfNtC5D1DtPjxYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ViGvOYdEFcCG6ym5ojCHbV2tgVV3jjOdu76Bd65apWj0H5LfQh28N5JFMQY1BcFCb
	 UKZwITNt1Hh7njKcfvmqneHHErZnPLnBniyCL8UXvGbXnFNNaqvIE/X68FB8YUBCTB
	 DjnT6g8ki2nl92OJMA99fRYE3j8P0SqKovE8QTCHZQhiwwEjh1UqRANoZclYgCYxHj
	 LCPRh9eBpd1+ZGyLPloxFQPMFdsFqGbD/bTj8rc8TF/V9O6aoogcdRXseWTS9Bo6jI
	 eUzq+SzF8Y2+pw7ZzZBV8uA3hctVVHGoF48pBmSFZ8FBKDU4Wu5L4BUsXPRmz6N6kV
	 C5rEPNyQefmqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B0C3ABC6;
	Thu,  8 May 2025 03:25:54 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 07 May 2025 22:25:54 -0500
Subject: [PATCH v6 3/3] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pci-tegra-module-v6-3-5fe363eaa302@gmail.com>
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
In-Reply-To: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746674753; l=2980;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=tWH6XnYSJoKkGmqKp04RuLk3D4LqSklOTfArIboe1ug=;
 b=of4e30l6Q5p6L2vyQe1n44ANBVQOEv1tT4Zvbhb4bdV9bB16+KqpcfevsAoHq7s9Mm512MqkZ
 jZJ0dsZSmCSDZ6kKdTNI/ccqUKvlBXpZBgunztzBhuuC7RrwHmP/vGV
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
 drivers/pci/controller/pci-tegra.c | 35 ++++-------------------------------
 2 files changed, 5 insertions(+), 32 deletions(-)

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
index b3cdbc5927de3742161310610dc5dcb836f5dd69..b902c696f63310f8f70651976d0fa2d9337134a2 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2595,12 +2595,6 @@ static const struct seq_operations tegra_pcie_ports_sops = {
 
 DEFINE_SEQ_ATTRIBUTE(tegra_pcie_ports);
 
-static void tegra_pcie_debugfs_exit(struct tegra_pcie *pcie)
-{
-	debugfs_remove_recursive(pcie->debugfs);
-	pcie->debugfs = NULL;
-}
-
 static void tegra_pcie_debugfs_init(struct tegra_pcie *pcie)
 {
 	pcie->debugfs = debugfs_create_dir("pcie", NULL);
@@ -2674,29 +2668,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
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
@@ -2800,6 +2771,8 @@ static struct platform_driver tegra_pcie_driver = {
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



