Return-Path: <linux-pci+bounces-33259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D47B1789E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328E73AD03B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591426A095;
	Thu, 31 Jul 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5JHR1ll"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B9246BD7;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999170; cv=none; b=i/53LWbaHibAemDA1jl5bvHhMWd9FpxtPGNvdzZRGDfF77pf+ZM87LMunhiSwrIhz4LaHwANf1ktwnywIa1lEmWoYMa0cvforDAHxN9Qf5MYsbjKWEbXYu/+CAJRV5TG2tSPiAnf9i7y/tjYIFyHNiuAjTVJmEng92l+n0ictxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999170; c=relaxed/simple;
	bh=PbT0lVg7+nffEx9KE6DhWbXKwrEe1ngsB9+NqasUVCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwnzhA6GOe7I1cK8BY5Z53OMhK+gLho958dXa1pB9XdzNvsUSYm34jxQMiq4E8EaYGttY2RBMsDhOSyYVQC3w062jt8xJoVYPfx4nJwPoV674CVOjNOiqveTmNyt4HEPmF4UR+yTDhRmLI5rmrIdXNTAjuWA9dWjJhJHfzk74Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5JHR1ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F3CC4CEFA;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999169;
	bh=PbT0lVg7+nffEx9KE6DhWbXKwrEe1ngsB9+NqasUVCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e5JHR1ll6MptrfN85F0zITDx2mvvwyYiLJ6s8RlS2Zn9tvUcP08g4+JNjY44DHt3H
	 vx3U1rHgFGKSkGg7/vskamVihPJm7lT54v+81ufdOZqtE6jCUy+ENCDJcZonRzFuYm
	 8IoB8UjA5lPYhUvzS+faB4xgp/0V+EiABiJ8vtU9tP+69U6218lq+IjLsGmCVanWIw
	 iHm1cOHTkk/vgP9zdz22RVQu3lBNKSVkmmozkxt4yFw70/xQgI0ucSkqV+zNJPW3Cn
	 L00Gf2RD9Z6X3oBJtHVbq7mRq1jQ7G4k1gF2BhvRw860lZYQQ0+z9UMDM1l0tMYcGk
	 DSIn+ApDnF0Dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF713C87FD2;
	Thu, 31 Jul 2025 21:59:29 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 31 Jul 2025 16:59:26 -0500
Subject: [PATCH v7 3/3] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-pci-tegra-module-v7-3-cad4b088b8fb@gmail.com>
References: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
In-Reply-To: <20250731-pci-tegra-module-v7-0-cad4b088b8fb@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753999168; l=2994;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=NwL1zgJJcNaVJMzJ4xbw0cEqWe0gRrA6/IT+IAjXFD0=;
 b=Hx8LT+bsI6wEqRQWtMV1xj/rCHIxQHr0EGrVFgqMOAZ06cbWwoRRXKHoXQuYwJimkhWxRNDBq
 zBC82thbtqnBHEyBd9EIgxwJqnKoUfNVULsJGILBhNI5JvNIZQr8JGJ
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
index 886f6f43a895f8f56ce3bcabbea382b6cd3b15c2..abdc17ff7b8f54c6b1cd3ee6556753f68ae546e9 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -225,7 +225,7 @@ config PCI_HYPERV_INTERFACE
 	  driver.
 
 config PCI_TEGRA
-	bool "NVIDIA Tegra PCIe controller"
+	tristate "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 467ddc701adce28c5edeb6d1b423ce56068f069a..c020822bdf0b72c4cc56817a9e689256b964e9cd 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2546,12 +2546,6 @@ static const struct seq_operations tegra_pcie_ports_sops = {
 
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
@@ -2625,29 +2619,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
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
@@ -2751,6 +2722,8 @@ static struct platform_driver tegra_pcie_driver = {
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
2.50.1



