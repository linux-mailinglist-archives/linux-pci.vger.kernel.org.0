Return-Path: <linux-pci+bounces-26969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB7AA9FEBD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 03:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB45216DFA2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C2154BE2;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNB4EUwl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAF4431;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888750; cv=none; b=ceBQgXWvFWp6xk1jyMMEpOvN+VhBDk452dfy+T9ZgjSU4pSdsf2wcCGn2Ni5aiL7v1JuJ/29RXq54+R++/g6zMwcCu2wC0j80QDpi6C/gnf+pwx3DFXT0Sc8JZZFe/9jn2UqIV87Tds/rU3ZNYUFRtxDPniZ8DVYv4J27WDq8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888750; c=relaxed/simple;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ypp6S4VautRhV2o4maUm5VDdrmVfkOirV+io9JubRLrIN7/2oZ+W2tYpzfYGjQl7braChudmElfRfOxiPBEajSE1NMfxKPPiey8jP57RrQXWJs6MGeIPtk5HBI27OQcfGLW3Lbrj6SIjbivpj3D9ylGHlR+Zu0J+X8Ar8IaC4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNB4EUwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35320C4CEEF;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745888750;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XNB4EUwlvoZU9v3dAlKKBTTnak+NHjgWWg1nSyP6NSzBrpkOQ2yZf0LLdRKZJho6L
	 1tUAYG7FAgGlzoD7hWJpRJwKwPsmy+E1epHEKwdxBeMKaulVxtjRNsrFAWbsddls2p
	 /Q7UpEpA6kJqlR5evRA7xP9hYsmeI15WDIzZm8r4RD7MfyZIKeEB5vC4y2zktLfQFt
	 1ih4oDca//8JxxalIBYiMpndBOg4hlpXNYivQublDbBF4XsVzQjxjvO4GqrijSRlcx
	 n0e/A/zcAOfwb9lVI/Esv3VwKXlGTO93HBkksuE/0jHBh6c4f/k1DE2tyyuW+Exnn7
	 0Y5OlcYgBSpHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296AFC369D9;
	Tue, 29 Apr 2025 01:05:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 28 Apr 2025 20:05:48 -0500
Subject: [PATCH v2 3/3] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pci-tegra-module-v2-3-c11a4b912446@gmail.com>
References: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
In-Reply-To: <20250428-pci-tegra-module-v2-0-c11a4b912446@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745888749; l=1592;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ediBwXdejZJpog3kftYSmvTQosQLVWrtV7PiuRz9nKw=;
 b=m9W78dnWcanFrYMp5fS7WOsXZuHtgrFt1gpLhdBIcQWzPtFoq+OeMKHchTx1OgwDTdZp1dsjd
 Lxn+9KzULRkDjR3Df+rurmKJ9s4X64G03RmlKl+ncjg3gow5juYZGy8
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
needs specifically disallowed.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/pci/controller/Kconfig     | 2 +-
 drivers/pci/controller/pci-tegra.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index b3cdbc5927de3742161310610dc5dcb836f5dd69..1539d172d708c11c3d085721ab9416be3dea6b12 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2802,4 +2802,7 @@ static struct platform_driver tegra_pcie_driver = {
 	.probe = tegra_pcie_probe,
 	.remove = tegra_pcie_remove,
 };
-module_platform_driver(tegra_pcie_driver);
+builtin_platform_driver(tegra_pcie_driver);
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1



