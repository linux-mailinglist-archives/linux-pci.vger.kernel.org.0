Return-Path: <linux-pci+bounces-24948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967AA74D05
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB4216797D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275B1B4244;
	Fri, 28 Mar 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g99fjolP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436A14D70E;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172877; cv=none; b=rWu+XUvi5AHx1Ivk8kzBVxPFa+D6vP8KDxEW4VsccYfPll2ehyMNajlnnIHB7kvvYpbviSQ0/tqW+Y1/9BtawyBriPvWMEj0MaX26VLbhiMvU6JcBhVq1RETpXG5rOLk4ghaY93FxccoJmLQbSTV0vusqq/NvuuLSOb4ZpRA88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172877; c=relaxed/simple;
	bh=1g4EHN9FsFeL8KcNzWB9FjbN2ttqTUJJvv9E0VghsJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2Dn1uKXtg1ejDIBiUZ8OuTdWiVejFfPQQM2i9aiT2X2RGxjKMIFyT9tim/O4uM4RYRRCgfw90yDSPDCs+3W94cBWLyFA9YplF4hPEJvRpzv+x747PVWzrYkZwlb6Y4GsN0//heLY+cQOqCAjv9oPZXHBy5mjxmZF0RzjDIwOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g99fjolP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1CC4CEE5;
	Fri, 28 Mar 2025 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743172877;
	bh=1g4EHN9FsFeL8KcNzWB9FjbN2ttqTUJJvv9E0VghsJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g99fjolP1ynkbsDZq1bxszDEcMaRy32/d6dV9JXBzveXara9Rky+V+W/Z/rsuB+vf
	 cgLOKza/l5lSqxqewl4N18vNP6cjWNAiEauc1A3K6bJ/Nz3N77rPRfY49YFWSr3/+N
	 MeQH0RZSpMCgZXvqvxztGv3KH5QxTg264MSX5d/D5RFHD5ZHaIPeSQf2TEHQM0uU04
	 0NwohwgCfxYQv1ArN4GXUlntUzGhcux6XYIKzXq50EVCWuAgRBMNjX20CWFnzYhlhu
	 hB365hD3o8UxwChCVV1Ux4/bWMxboHdAH9J6QfxXtpulUr3eeUn7GhmgIW7okkz9Uf
	 gABQCL5CfAJWw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tyAte-000000007JI-42Hf;
	Fri, 28 Mar 2025 15:41:22 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/4] arm64: Kconfig: switch to HAVE_PWRCTRL
Date: Fri, 28 Mar 2025 15:36:44 +0100
Message-ID: <20250328143646.27678-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>
References: <20250328143646.27678-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HAVE_PWRCTRL symbol has been renamed to reflect the pwrctrl
framework name. Switch to the non-deprecated symbol.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 02f9248f7c84..cc94845e9bbf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -269,7 +269,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
-	select HAVE_PWRCTL if PCI
+	select HAVE_PWRCTRL if PCI
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
-- 
2.48.1


