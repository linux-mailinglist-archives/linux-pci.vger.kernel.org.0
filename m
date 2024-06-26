Return-Path: <linux-pci+bounces-9339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9754891974F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BBB234C7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8115FA71;
	Wed, 26 Jun 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS0O+sQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F31922C1
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429216; cv=none; b=LdtrTVeF2Xc1VwS7ahAop5ExZhGq4n/pLXJKAnJJ+gsnSjDPAmQddN5CIe6eVYXtHlaDgJjoyRZiuv7wJOFphkrvmxqLRs7VKx2VztWtOFNDbLDXhhc9+LY9sexN5M5pY376yY1B1boH6MrLyYwLyq2nmgzOyZdex9rBccP7r88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429216; c=relaxed/simple;
	bh=4cwZQpYl/w0lLEjAGGtJKh0L+d5YHMgEB/H7F5a3aiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bX4kS/S7lNOHYOEt1vtHf9J52FKaxuZnEEEY2bI/JWjlg/13WGFHMwGutXPaeyEGHuphmqDeos+Qv3q0oszUtu0qKHrSQP4SptPhNi9oHptzcHTaUCmdS7UpT2Z0RoE8AZ1AIsYezlS1RGseh9dkV2M6qlEldPBe6tZPS1j1a0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS0O+sQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61006C4AF07;
	Wed, 26 Jun 2024 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719429216;
	bh=4cwZQpYl/w0lLEjAGGtJKh0L+d5YHMgEB/H7F5a3aiM=;
	h=From:To:Cc:Subject:Date:From;
	b=nS0O+sQjzOPAEsnHpoUyBuOh4v8kdBSlYqqT5ZctuwuUBN9qlfr3ZN37QBRM4g2TP
	 kgQKZRAb6xVQKJw8x01f4/5pfPylDlKfOkPoWjthcTREwFMADLi0PecsTNcxffTB8Z
	 SMkEOTxiofkA1D2A3d6Hwl5/VK2LG+BE2zE9hQkNf2aAEilMMjurAjLwsdJ/7vXR0J
	 NXRBxdVLzhTkgSNvjCxtr9XETEHjZB8Uzs6FiyF6fRg/gQ/3kCmRJZrjol/6MNZEAG
	 01i5rhNizTGwo+CR48kfvmhh/bNCJfcUSq6ARJAKi8ARE+Z7IiOrORs1DDOX6lCNNC
	 UipcaP0V6bAmA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dw-rockchip: Depend on PCI_ENDPOINT if building endpoint mode support
Date: Wed, 26 Jun 2024 21:13:25 +0200
Message-ID: <20240626191325.4074794-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=cassel@kernel.org; h=from:subject; bh=4cwZQpYl/w0lLEjAGGtJKh0L+d5YHMgEB/H7F5a3aiM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJqMkLv67zx16/lPWSbvatyKtOe2Tp57+we+LFLX0tbc PPwqc8aHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjILjFGhs29d6yq0g4tr53U HFbjWJc2MTn7UPid2AZR7QVte4M2vWD4p3zp8MX9W1apBE+cU1jb8Jz/ywxFDnNjdU2P6KbdW66 vZwYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

All DWC glue drivers that "select PCIE_DW_EP" also has a
"depends on PCI_ENDPOINT", except PCIE_ROCKCHIP_DW_EP.

Fix PCIE_ROCKCHIP_DW_EP so that it depends on PCI_ENDPOINT.

Fixes: 9b2ba393b3a6 ("PCI: dw-rockchip: Add endpoint mode support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406270250.k2esVVnL-lkp@intel.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 9c4fb8ba7573..4c38181acffa 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -329,6 +329,7 @@ config PCIE_ROCKCHIP_DW_EP
 	bool "Rockchip DesignWare PCIe controller (endpoint mode)"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
+	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_ROCKCHIP_DW
 	help
-- 
2.45.2


