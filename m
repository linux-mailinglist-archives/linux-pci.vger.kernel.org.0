Return-Path: <linux-pci+bounces-42044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC821C855AC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5523B40F4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE631C57B;
	Tue, 25 Nov 2025 14:17:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E231B805;
	Tue, 25 Nov 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080259; cv=none; b=Ncuaj8wM3EyrTpT1gFYYvLmzkpg8anDS5tdgqO7joTM2GmcxZkkwza3bQfy9ZvZ1gxERMQbaDZgNQhVtNZy909MQSdn/sSmt3+Do5GwkYOfWJNETjBT0110Rr/UbrmSFuERpxGQV18BbA2AoibGFI/Ai1m68xwswfr7LzcXlzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080259; c=relaxed/simple;
	bh=lzvVGM0JJoDCwPcfZI8LXFZ2zDfE6Ty1vKe4lE+z2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY7WpbsDCYKfvO5ZRpu+Y6ezlJl+aMJrY5VLGKuE0cXQL+0AQyX1hRDsXoMnMGSTCAyLflk+7aOyc8ILImaDJU2CtE39KvMLmGbryjO1/U/df2UbPi1XLakBgeiXyp02Hm1e1S3SKId0ltpWlgSGy2kjlMCcHJEo9/LJD4Uc8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF2C4CEF1;
	Tue, 25 Nov 2025 14:17:37 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Hans Zhang <hans.zhang@cixtech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: PCI_SKY1_HOST should depend on ARCH_CIX
Date: Tue, 25 Nov 2025 15:17:34 +0100
Message-ID: <6617e95d9e71e04e2e0944819cab32adf585f7c4.1764080169.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CIX SKY1 PCIe controller is only present on Cixtech SKY1 SoCs.
Hence add a dependency on ARCH_CIX, to prevent asking the user about
this driver when configuring a kernel without Cixtech SoC family
support.

Fixes: 25b3feb70d640158 ("PCI: sky1: Add PCIe host support for CIX Sky1")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/controller/cadence/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index ceff65934e5fabd1..9fa527bad5b7dfc1 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -54,6 +54,7 @@ config PCIE_SG2042_HOST
 config PCI_SKY1_HOST
 	tristate "CIX SKY1 PCIe controller (host mode)"
 	depends on OF
+	depends on ARCH_CIX || COMPILE_TEST
 	select PCIE_CADENCE_HOST
 	select PCI_ECAM
 	help
-- 
2.43.0


