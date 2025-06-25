Return-Path: <linux-pci+bounces-30617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A517AE80C7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2293E3AF811
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852062882D4;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAC/31ew"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A325BF02;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850293; cv=none; b=m5JXoD7Q4xhe+956uFSv8WrMSCwTwAQ+OIakcPyHsNBmKYkq2DB01SK3N+PFFEjYYNIxBL+hMcRNVEYtYb00EujDuQE8CsTc8DZG/31QAJ9n6PD4PpVH1mz2AyxqDa//1RMsLErP0KQh1ypu0JjUA8LR8WADgelr6wF6f8trp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850293; c=relaxed/simple;
	bh=WsJdVrVj4ofp0/SbGBVzpnHuyNRsJKf/ry9C4XCbF/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek7up7bUvno5ki+CQcxHtZp6apmRv/aSsYLzTSaFvte5olP4iJFKz8JJoRJYLth47II9ndPWN88BcDFbxb6dSZzJznAvTN30zKMKP1SaMF/tbnIApOZkQMakspydKRjDQ5Bp6ruSAcVC980/vxibDUpvKdkb5orPCcmM/HTYxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAC/31ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0192BC4CEEE;
	Wed, 25 Jun 2025 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850293;
	bh=WsJdVrVj4ofp0/SbGBVzpnHuyNRsJKf/ry9C4XCbF/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAC/31ewbo3QRxuZFSw8EzTDwqv0ipowojGvEixFYHuMktkG6s2giUtNp0SuPPF0a
	 DrXI3ppULXIh3Q2V9TLEvSvxuf/ib4r7cQuxas3i2YkzYNoB2XWQd3J9Cnq6dURVtK
	 cqntZn7fgXL0HBGHU606I8Bm07dTzggoSFNrOg3/LAozktKiE68S9AC4DSS3D99C77
	 kSMn8Br/yMqbOr5JRsFgklnN3JldxafPjV4rvyahmGY98oALjhs+7mfi+PFNGGUhj0
	 M+w8s5qXide6KXAUU7grkP7XmQVBExYXUJ82YwxBehgTi+5rrAyTgTT4uSEm1L4wLy
	 Iaq7eMRlKAguQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uUO8o-009qM2-Us;
	Wed, 25 Jun 2025 12:18:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: host-generic: Set driver_data before calling gen_pci_init()
Date: Wed, 25 Jun 2025 12:18:04 +0100
Message-Id: <20250625111806.4153773-2-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250625111806.4153773-1-maz@kernel.org>
References: <20250625111806.4153773-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: bhelgaas@google.com, alyssa@rosenzweig.io, robh@kernel.org, mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, j@jannau.net, geert+renesas@glider.be, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
Link: https://lore.kernel.org/r/774290708a6f0f683711914fda110742c18a7fb2.1750787223.git.geert+renesas@glider.be
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-host-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index b0992325dd65f..b370528638471 100644
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
2.39.2


