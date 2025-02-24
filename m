Return-Path: <linux-pci+bounces-22247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE4A42A80
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82931897AB6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A5264FA1;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkLK5+Sv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AC264A85;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419821; cv=none; b=kh5mF8rXwXY9JGAowmBjS53eDU6q+8JIIjWx/U0EW2pw976GrZpB3nz9HYjmZYXwostCght2uu98cW7VDHqq0CZJ1pEMZoLDRmcp/9q8eBxu+1Y9K7s56pGdQDd+0UU0QQiSOkWggxrEbNgAu75q417OUFYlUv36OghgaRhNsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419821; c=relaxed/simple;
	bh=LsInl6C5Ll+asf1Orv5FJIOgIGtwKiaM1xC0RW/LLB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRb+QYN1XIeEYi7fsY+t/aYQKByssEh9hWK+ifxQm1PRkjJnP4NpntAvekTkMJ3GUws8zViA8MZCEo9ilyzZLIraGFHliDa7ortsNijjXU21IF2IIt/3HXvra/FTjZIvuFjSD3udwOqzDY1mZtHoUY8v7fbD/kN5i46k2moUUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkLK5+Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 108D5C4CEDD;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740419821;
	bh=LsInl6C5Ll+asf1Orv5FJIOgIGtwKiaM1xC0RW/LLB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UkLK5+SvBHWRRi0/ATnyleB/7Ym/PGBi+K59jaKwQmOVM+GHizAilfkvfi2QEooyM
	 WA6GREk/maNot9iP5ziPLmU+R2dhItZBok61VTSYmY3B/MVltcsZDFjsqmcea0Zx73
	 a/mWXcENCJcZtWmu0EpUnLBN9r7dzwOXAoSnfeOY35L5GuOEGLHjMnyDq6KgphuXeK
	 C1DrF/uOsPvP2sGpGIVbqQb5LBqTmQ9bucLUXIv8wmrKhHh/SPODZmtI+MmN0QUu2c
	 0JkGqS4CZDqej4e6/OJZF/yAQ6EFsNAFANnLJXoQIht2551Ser67kw2YHFDiTZ7Zs1
	 B/ga4QFlq1dng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B93C021BE;
	Mon, 24 Feb 2025 17:57:00 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 24 Feb 2025 11:55:34 -0600
Subject: [PATCH 2/2] PCI: tegra194: Allow building for Tegra234
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-build-tegra234-v1-2-39e4e912f968@gmail.com>
References: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
In-Reply-To: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740419820; l=1308;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=RQMU1OruosUtu/kFiSKZkJtzqv30gwNTIdbY5d1PAWo=;
 b=NxyKmg4DpPG0QjYEYE1fUUbABtXtfAfAuXjENVceq5qPHCOTBW6ZoKPEXAUHTmcZvanTswfNQ
 qfYzOvdtqvOC80CStXD4sT2/EtEcz2GI2kFShXidYVcvlTfR8arSKp5
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Support was added for Tegra234 in the referenced commit, but the Kconfig
was not updated to allow building for the arch.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698b2ab22ef69f6c8d8cd5619ede41f..6dd232cf80642583482827d80c6321dd8e8156da 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -205,7 +205,7 @@ config PCIE_TEGRA194
 
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
@@ -220,7 +220,7 @@ config PCIE_TEGRA194_HOST
 
 config PCIE_TEGRA194_EP
 	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
-	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PHY_TEGRA194_P2U

-- 
2.48.1



