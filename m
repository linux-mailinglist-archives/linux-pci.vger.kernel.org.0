Return-Path: <linux-pci+bounces-27162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EBAA96BB
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D730162FA5
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B4A25CC41;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWTVDQ7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EFC24DFFE;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457142; cv=none; b=GE0uytJgwBr/EQcFRVzs8uVuDokBEwn/X+kqSdHKjhxVUw/zuu0E7tbCj3Se3q93yMewPfkKemhznuoqXyJ0AtS9ad2oDkYl+61A3PtmrKzZoQOlXksp6pP/6PLcy65meVFeTZODfYEGnI/aSYGaj+mCQjDq1w7fNVQhnal7y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457142; c=relaxed/simple;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBcdct+TVj4VI5wpqNijcf+xD4RJ4xmz7YmD4d8zGDlmragJPyYLJ2+NuFsChvQV4SZAludk3zdnjcWFpBU+ycUN0XaMrevfnIjJUNA1vb2RustMCqxaL4HCMQhYX63OaLBwlFCR6OpvAsbXGgvRJetdcqbYs/Uf/goTxaxDyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWTVDQ7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60152C4CEF2;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746457142;
	bh=0kd70aDRShcJ+DgP88hGfkolBgZTKMYLZwsSsPfBMro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JWTVDQ7ORzgyknRu9Q7elTqoHqfv+6pKJrM5LwesV3cyXApx2IKYbk0Cw1Qlo5S3j
	 bkZ1N264qYjjZ5512Km7evJQqaqSz1lfkzbY3Wa/M1ttcMg0s5KS3iKPO/xwOSXKFP
	 XWs5hUjIEiv+xqKubKJmyPGia6q9Nx8DaCg5CSvvVMFHCIti1+1SYOVGtGjGBVRkDI
	 L6D+R3/JcxdOo19+xyVCILBemDiFsmN69njO8/S+M9D+CPb9RNo/JrcnV6HyhM1ks3
	 TBYqKMa+cAs/2EZpTdjqt4nmlF8NFpGroiiPq274go1Noyd0BpUC+EjyXtVYEecULE
	 hKznsgoRd+RKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51863C3ABBE;
	Mon,  5 May 2025 14:59:02 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 05 May 2025 09:59:00 -0500
Subject: [PATCH v4 3/4] PCI: tegra: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-tegra-module-v4-3-088b552c4b1a@gmail.com>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
In-Reply-To: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746457141; l=1592;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ediBwXdejZJpog3kftYSmvTQosQLVWrtV7PiuRz9nKw=;
 b=hY5rX2sfjD3MflESwb0mTHRWUKQfyxhEagWtQYgxOdmOetlVeaOKAwp7PFKF65GgWLb8QbS9Q
 P3tz3BadTpwDq+6qG79BHsorUXKtU8WTl6tzUI+c75oXNtmlfLy5k9Y
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



