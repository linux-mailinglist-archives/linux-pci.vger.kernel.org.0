Return-Path: <linux-pci+bounces-30533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0503AE6DDA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455B57AB58D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28F2D5C91;
	Tue, 24 Jun 2025 17:50:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC926CE01;
	Tue, 24 Jun 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787423; cv=none; b=VANz3EXffHF4RCAM+kED2jthkznKuykBNuEmFqImAjPIelOMbudRxwAelfOr5UbGtI2RHkax656vjH5IAqFkSZERA6sMMpkfyAe5LCUvfHKxIsnd2eEO/KMbdUILT8IJHZCuKzY2E+75shuLP4G00Se0kbZauQDq4sFRPz7lnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787423; c=relaxed/simple;
	bh=1cPt35KT7h8xbHwIRCooNcsIXVw5ckbfWqgtXPCCV+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkE4ztQUNnZ8QHxV8+GAGsGZ8IGYcr5zWJ4vaDwClOwDmLdjYfyGXcDPibC1jeFFbKh3i6taOv3Sk+lhVcqsixIJploi3VXmmIm4njrLv/DRdPIpR37kp1c/3pR/aosouOioknnvB3eaZnO2yEFpQtPpr37R3rb/ET8jkJKNeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32738C4CEE3;
	Tue, 24 Jun 2025 17:50:20 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Zyngier <maz@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: host-generic: Set driver_data before calling gen_pci_init()
Date: Tue, 24 Jun 2025 19:50:10 +0200
Message-ID: <774290708a6f0f683711914fda110742c18a7fb2.1750787223.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MicroChip MPFS Icicle:

    microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
    microchip-pcie 2000000000.pcie: Parsing ranges property...
    microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000368
    Current swapper/0 pgtable: 4K pagesize, 39-bit VAs, pgdp=0x00000000814f1000
    [0000000000000368] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
    Oops [#1]
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1-icicle-00003-gafc0a570bb61 #232 NONE
    Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
    [...]
    [<ffffffff803fb8a4>] plda_pcie_setup_iomems+0xe/0x78
    [<ffffffff803fc246>] mc_platform_init+0x80/0x1d2
    [<ffffffff803f9c88>] pci_ecam_create+0x104/0x1e2
    [<ffffffff8000adbe>] pci_host_common_init+0x120/0x228
    [<ffffffff8000af42>] pci_host_common_probe+0x7c/0x8a

The initialization of driver_data was moved after the call to
gen_pci_init(), while the pci_ecam_ops.init() callback
mc_platform_init() expects it has already been initialized.

Fix this by moving the initialization of driver_data up.

Fixes: afc0a570bb613871 ("PCI: host-generic: Extract an ECAM bridge creation helper from pci_host_common_probe()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Notes:
  1. Before, driver_data was initialized before calling
     of_pci_check_probe_only(), but the latter doesn't rely on that,
  2. drivers/pci/controller/plda/pcie-microchip-host.c seems to be the
     only driver relying on driver_data being set.
---
 drivers/pci/controller/pci-host-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index b0992325dd65f0da..b37052863847162d 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -64,13 +64,13 @@ int pci_host_common_init(struct platform_device *pdev,
 
 	of_pci_check_probe_only();
 
+	platform_set_drvdata(pdev, bridge);
+
 	/* Parse and map our Configuration Space windows */
 	cfg = gen_pci_init(dev, bridge, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	platform_set_drvdata(pdev, bridge);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->enable_device = ops->enable_device;
-- 
2.43.0


