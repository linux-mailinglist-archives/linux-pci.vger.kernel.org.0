Return-Path: <linux-pci+bounces-26321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB8A94B3C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 04:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119E616EE04
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3CF2571AA;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i674J8zC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698F2561B4;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204359; cv=none; b=vE3s9aJ5KvmAYzWuIOvo8t50GvnZEgop4EZ5FA6MpRkoUknadxBn2piZXxwcaYBslMvIq/eguzHS7/a6GksLhhP3uv8LM74zl7oIkZpc6rBMYI5wZIYES6chjbp/ZBDc4yc82f+PuZi9QixcRtYo7IAKQQkdKmCfDQx+q/NzTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204359; c=relaxed/simple;
	bh=IhphpY0o4i7Nl1j4CbYkOEF3b1+ONoH+eN1oOCIVXZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9XUivujYsqrVQd8iqNnnAi+HZU4VgkUfDoD6xwcdllFsarzYiwYvmJL4ZJwyg7tWD9Kyg4odwhVCy+RPLfqvCj9Trt2iNqbTkjdB60e6ngDm22uBEfH9W0+zqS3lS1M7Lw5CtGm2oENQSdWfxANl4he5hc0m0qz5xKBVTwr0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i674J8zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B26DC4CEEE;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745204359;
	bh=IhphpY0o4i7Nl1j4CbYkOEF3b1+ONoH+eN1oOCIVXZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i674J8zCxQDFYskdIciIt1zH0XL9L2wDequTMQyDFFq1a1ZU7jC0tTPq8xOdQIGQr
	 uDUoTmp7gxp1skM6zdbxOQ3GRCzgQSHTBK1TVHCYl+Ro+ZqxmDXAPJpgrgKK9FvZiz
	 bQEXdSISL1sJg9aPkQvONQ2mZwprJRrSD6Tj6oKV59G+bvnKBBiqWdOlb3pYnPwo8/
	 geAH8nEjEOxBXEfFC9iZm8ojCaZq8AdczoVMYGU1kPlChD+Ie8f7rz/QDsuqu5/eGS
	 QMRF+0Alvzn+b/58wO1dVLvBWEYh0GyKtMmEldevz3ukO+WWpTuxXFf47p7+amlai/
	 0hWAqvxsDEM+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA00C369D6;
	Mon, 21 Apr 2025 02:59:19 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Apr 2025 21:59:06 -0500
Subject: [PATCH 2/2] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com>
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
In-Reply-To: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745204358; l=1330;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=wWrPTvwS8jQlrXtSz5cnnPOard6fs6fh1GhK5NDgNmg=;
 b=8J8tPTGbIDW4YOXuDJAJ/wlyLdpEM1EeTtjZPwF65RK2+uyH0nkKpYQvXP6gbatkV/CONBrRA
 n9uf9hDTxFRBjxFEMCiBqcQbyS1MaVzFb2dT8x3MNUniublfOF/gMAi
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The driver works fine as a module, so allow building as such.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/pci/controller/Kconfig     | 2 +-
 drivers/pci/controller/pci-tegra.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index b3cdbc5927de3742161310610dc5dcb836f5dd69..c260842695f2e983ae48fd52b43f62dbb9fb5dd3 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2803,3 +2803,6 @@ static struct platform_driver tegra_pcie_driver = {
 	.remove = tegra_pcie_remove,
 };
 module_platform_driver(tegra_pcie_driver);
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA PCI host controller driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1



