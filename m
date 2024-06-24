Return-Path: <linux-pci+bounces-9209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957839157C3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 22:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E421F214A1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F171A01DC;
	Mon, 24 Jun 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ifJ4WqkA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF51CFBC;
	Mon, 24 Jun 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260314; cv=none; b=J5M8RiiJG+mJYD6CpNug0ie2CD1ycj66jhJVyPAT+86aZ+D4PPkh6ZBisVaktmq0QIeMbyQF4PhKIrUXSsO/eU9MAl9yZY0M75Zt8tDTtgklit/VKlMQ/DOjiplS+Mz8Dps6bWppAGy6iOIHUgA1FyU1FlkuWYvqF/ltedbgYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260314; c=relaxed/simple;
	bh=jAF20gD7kIYUViHBMXcExfj8B25lKFFEaqEeRRIJKmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8mv3sC5JNE4L3Ypt9uTYOV0wM9eMdE3vHmGQwxvJDp34dhEShO6067IqnmB0nNyKBOeDHZdBaYCe3cJIBg2zXFhE/Svx9sMNvACMZOj7WuH6Z/VAZRz7GHHdUU1L4DWVGpoOpon1Yd799LR2nYOXjVcYgNdheQilFqdv+UIQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ifJ4WqkA; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Lq8tsVsCWs2bgLq8tsSHG0; Mon, 24 Jun 2024 22:18:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719260304;
	bh=elAOlOG1WOr8pdRvT+PF6Vndcsz+yUNDpa4N3XRDGSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ifJ4WqkAbLBGSWvEokziSvQHFJTuyUYl/RfhR/1tlyof7+bpgmvEoRQALwZQNtaEn
	 ga/u/N2xFXPHx0IYqqC6E3XAA72bCLVsxYk9+kDwCOiJUDYjIoqweDdNS+fGhBL9wS
	 0HsLTaOrs9xRyy3gLNIF52BViT1qdbJoy7I3/y4ZbAHQhPPJsAnLSJLq4/g/zgmsla
	 Rx2jwVrPHyW2yy7201CyyB98m0BqJPPq6KlUw4V1BkLXsX34uOdAqAsTh3In7HNmGr
	 IPHApck+2r0VajUHdKn+UdYXhIT0Aoi8B5yYS3sLmTBSil34Mx472NKw3t00kEEzR0
	 gSBk/gLU7Qazw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jun 2024 22:18:24 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: ls-gen4: Constify struct mobiveil_rp_ops
Date: Mon, 24 Jun 2024 22:18:20 +0200
Message-ID: <189fd881cc8fd80220e74e91820e12cf3a5be114.1719260294.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mobiveil_rp_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4446	    336	     32	   4814	   12ce	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4454	    328	     32	   4814	   12ce	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index d7b7350f02dd..5af22bee913b 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -190,7 +190,7 @@ static void ls_g4_pcie_reset(struct work_struct *work)
 	ls_g4_pcie_enable_interrupt(pcie);
 }
 
-static struct mobiveil_rp_ops ls_g4_pcie_rp_ops = {
+static const struct mobiveil_rp_ops ls_g4_pcie_rp_ops = {
 	.interrupt_init = ls_g4_pcie_interrupt_init,
 };
 
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 6082b8afbc31..e63abb887ee3 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -151,7 +151,7 @@ struct mobiveil_rp_ops {
 struct mobiveil_root_port {
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	struct resource *ob_io_res;
-	struct mobiveil_rp_ops *ops;
+	const struct mobiveil_rp_ops *ops;
 	int irq;
 	raw_spinlock_t intx_mask_lock;
 	struct irq_domain *intx_domain;
-- 
2.45.2


