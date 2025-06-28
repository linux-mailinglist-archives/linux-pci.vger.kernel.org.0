Return-Path: <linux-pci+bounces-31008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DECAEC966
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0711189C476
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF191270555;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFR9aOOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0910264FB1;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751131828; cv=none; b=LE3ra0rh6ox6IjdzEjDC8XEdYZAW2PooCiTeLLCFmQ64r0IRPc+P5No9k9KmycI0W4n3xn/H418ZJtAqv5GU+V4u/zV9/gOjeSgyuNDOo4dTLk+hebDMhH+2H3r4OoD1v5k/Izb9Xlfm6cGsDbMIwEwpU4l2qfboGUYdQhgvlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751131828; c=relaxed/simple;
	bh=9TTQFkyY0M8aTj6Iv8cpYI5ilm3sw2M2ZI3G1K0Exkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkJvulbNAnLbSxQLf7RBLEhvmtxiO9w9cMXeqJFlQCpX8Xt4xKe/eTKZ56/dE6NE5uYVgYSRPYcMoYVRexjntvnROW1wg/QrY9R70ILI5scdT6Cj7QiPeKj9dCTXD957xW1RA2klhlclgWfgdzcmzcT1Gw6K218Ys2MARbs1DWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFR9aOOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45383C4CEED;
	Sat, 28 Jun 2025 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751131828;
	bh=9TTQFkyY0M8aTj6Iv8cpYI5ilm3sw2M2ZI3G1K0Exkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFR9aOOrkWMwCpnFCv0RgIjSMofAj1v6SNEV0R8UXHUPufnSFsyiPoF2aI5AIJIgL
	 +vEFn4DUaHD/d87N8hzkxecozlxl2UnWDlpjiJL4jYnSYw1Kq8v7Eyb4h100jEYXdC
	 +53idaD1n9dxEMF8VDTLKUcxccEqE3fccC7oPSadlMFDZtmr3yGp3fHZ0xGSrCxFFR
	 CYweTG4X3QncSk/0PUXtC6kT9FjslaQbIODfMtPVd+fYoNgFclyIBeJzJvnTEAY+7L
	 zikQTLcoQdMhzzqbiJwSdXpAtzRUUDM7AQNg1NW09i3pLMv3ipWUr4Cr1vjzYK4Rxx
	 XQIpwzuJJDhkg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uVZNi-00AqZC-13;
	Sat, 28 Jun 2025 18:30:26 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Toan Le <toan@os.amperecomputing.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 02/12] PCI: xgene: Defer probing if the MSI widget driver hasn't probed yet
Date: Sat, 28 Jun 2025 18:29:55 +0100
Message-Id: <20250628173005.445013-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628173005.445013-1-maz@kernel.org>
References: <20250628173005.445013-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, toan@os.amperecomputing.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

As a preparatory work to make the XGene MSI driver probe less of
a sorry hack, make the PCI driver check for the availability of
the MSI parent domain, and defer the probing otherwise.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pci-xgene.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 1e2ebbfa36d19..f26cb58f814ec 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/memblock.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -594,6 +595,24 @@ static struct pci_ops xgene_pcie_ops = {
 	.write = pci_generic_config_write32,
 };
 
+static bool xgene_check_pcie_msi_ready(void)
+{
+	struct device_node *np;
+	struct irq_domain *d;
+
+	if (!IS_ENABLED(CONFIG_PCI_XGENE_MSI))
+		return true;
+
+	np = of_find_compatible_node(NULL, NULL, "apm,xgene1-msi");
+	if (!np)
+		return true;
+
+	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	of_node_put(np);
+
+	return d && irq_domain_is_msi_parent(d);
+}
+
 static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -602,6 +621,10 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	int ret;
 
+	if (!xgene_check_pcie_msi_ready())
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				     "MSI driver not ready\n");
+
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.39.2


