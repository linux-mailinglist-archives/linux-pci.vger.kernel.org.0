Return-Path: <linux-pci+bounces-27107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E53AA79B6
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1422B1C0583D
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C01EF372;
	Fri,  2 May 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm4rEMps"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F51AA1DB;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212445; cv=none; b=QzedvakBL9wQIjP49SjzLuJ8OUVfJKAmGjo469YrLJnAdUIztBYXlYDqb9InDdpIhzQZCAL0a/XkUV0KDpYIPIYZc3nSyCtitg2V1DAavZUxD7tX4z0E2eeP4qQ/roX+HEoQvRD8snrC+4nTmXPLcYCYfTDi3xfeh9csaTwMiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212445; c=relaxed/simple;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swEcHaR3Tyu+oTz4lj0X3Zbp6oQQGkTQB2jCCn6TcfvyZDsPt2/sQL3PQfUDB6E9YUgMbo0qZ1c8AQilFcW4LSMIQh8Umu35Ydv3Jbc7r3nVUL+tUkN9l2xLvTPXTfFO9JCdexPXryIOfbOfAwcYrci7rXuzFLNtOhrfrKicwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm4rEMps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEFB8C4CEEF;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212444;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rm4rEMpsdLZGkjUckftL5noeRRyE3cY6vhhIxPEIYMEGl6IM7G0WYyJyC15uLRezs
	 r1fPrZZ/eypIuyjeUbjM54YwwghgnxjaGlqiRkn0uGQf+hxTfF21RoMO6XrlLeJMrW
	 RaLJGlZIxGn6glFAA7/5y9vqgAVdLqHGLsKvGr9Uspko1+29pa+5hBhFCwoTQhQsWW
	 7GaKwa8l1nzGhgFR8qHvomuSfUSXS5QtkaGm2IHQo0HoOe3z1I1WXOcVmTIWwmq+lz
	 JhE2l19GJhqmMFVOSD2bNL86C27RyGGx/Hq1R3FIBaOi2HjVuVdorptHtVtd9BLHHO
	 4r3SgQQ/cKYRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C0C3ABB6;
	Fri,  2 May 2025 19:00:44 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 02 May 2025 14:00:31 -0500
Subject: [PATCH v3 3/4] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pci-tegra-module-v3-3-556a49732d70@gmail.com>
References: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
In-Reply-To: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746212443; l=1592;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ediBwXdejZJpog3kftYSmvTQosQLVWrtV7PiuRz9nKw=;
 b=fyglllN1LQYdTPKsWYdjPwSOuvVIV4KKD8qg16D+m+tf7wg1uxixsLEoVSt6kfqC6bVH7RkdF
 eJc4roXh56OA3OSFyYtJtmoQOpNwkVRFxpGPXAYe5fmMsQgBaDCXRUv
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



