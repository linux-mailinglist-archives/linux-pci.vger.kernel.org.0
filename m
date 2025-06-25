Return-Path: <linux-pci+bounces-30618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F00AE80C9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 13:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98321780D5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219C2BEC25;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLqOBvfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4132BCF72;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850293; cv=none; b=ELWauIj9NKj5sNKeM+CBD1BnG8JquOBEiAGzTrrsVElwmGNIYY1hOPt/F5MUfES5BXShbc5vLrcmJBAUWH9ceq/a8BTYVZCzHJA1yUwSBI5NIv+ioOfbHsJ42tMrbFJD6w8IFhfzNP9wfPH27pJqxkcoFn4Y3hiupqggnOpvjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850293; c=relaxed/simple;
	bh=gLYaNgAZuxDXE2XrENbyIyyl/VKE48uI7zW50LW8qC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR1RGAwzaK6Th/+IdIBSib2QxGyQV2gjOWQzb5m/ddH9M3XB/yNUTLYh0I1zypgQfGRDRtzOEZIGZ+vX0xcMrudVT4izf29YJw9Mpo4M2jP0G9uFBPqMsOa+GkVmMOxcg7KDUt6r7He/4Y0RmMEWfZQkN5tKFyMjNq8ey8lwtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLqOBvfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED69C4CEF7;
	Wed, 25 Jun 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850293;
	bh=gLYaNgAZuxDXE2XrENbyIyyl/VKE48uI7zW50LW8qC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLqOBvfB6N8p+vlU3KWt7GkA1uZ/xntkHNvXFi1CcNfZbGlt3QyP2K8GtBpq7CJQs
	 K+McshF92vdpZpsGfqOP4/yijvY1yYrannvex/UVQrfN78IEgQ5vJeItz5RK2z7ISp
	 Cg35w/yDANBYSFYgCK5iw1Dx7dttT3M83D+FudDcz8Pw423ZmJcRzsMLvAJ9TaWD3+
	 Nt4G5/vyXahOzmmWKA+9AahEnAVDtNrrQ17Q1BpBFM0Jy0Qp/pMNToLU9MrYQP3Ytu
	 5TfGiRWnjC9CefbmRntnzbuwmr5bkV9wkh0+2UVeBZi+/KYe/LJ5DSAz3dizGpJv36
	 /NcNHB92reeCQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uUO8p-009qM2-64;
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
Subject: [PATCH 2/3] PCI: apple: Add tracking of probed root ports
Date: Wed, 25 Jun 2025 12:18:05 +0100
Message-Id: <20250625111806.4153773-3-maz@kernel.org>
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

The apple driver relies on being able to directly find the matching
root port structure from the platform device that represents this
port.

A previous hack stashed a pointer to the root port structure in
the config window private pointer, but that ended up relying on
assumptions that break other drivers.

Instead, bite the bullet and track the association as part of the
driver itself as a list of probed root ports.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 53 ++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 77fe739766548..0380d300adca6 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -187,6 +187,7 @@ struct apple_pcie {
 	const struct hw_info	*hw;
 	unsigned long		*bitmap;
 	struct list_head	ports;
+	struct list_head	entry;
 	struct completion	event;
 	struct irq_fwspec	fwspec;
 	u32			nvecs;
@@ -205,6 +206,9 @@ struct apple_pcie_port {
 	int			idx;
 };
 
+static LIST_HEAD(pcie_list);
+static DEFINE_MUTEX(pcie_list_lock);
+
 static void rmw_set(u32 set, void __iomem *addr)
 {
 	writel_relaxed(readl_relaxed(addr) | set, addr);
@@ -720,13 +724,45 @@ static int apple_msi_init(struct apple_pcie *pcie)
 	return 0;
 }
 
+static void apple_pcie_register(struct apple_pcie *pcie)
+{
+	guard(mutex)(&pcie_list_lock);
+
+	list_add_tail(&pcie->entry, &pcie_list);
+}
+
+static void apple_pcie_unregister(struct apple_pcie *pcie)
+{
+	guard(mutex)(&pcie_list_lock);
+
+	list_del(&pcie->entry);
+}
+
+static struct apple_pcie *apple_pcie_lookup(struct device *dev)
+{
+	struct apple_pcie *pcie;
+
+	guard(mutex)(&pcie_list_lock);
+
+	list_for_each_entry(pcie, &pcie_list, entry) {
+		if (pcie->dev == dev)
+			return pcie;
+	}
+
+	return NULL;
+}
+
 static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
 {
 	struct pci_config_window *cfg = pdev->sysdata;
-	struct apple_pcie *pcie = cfg->priv;
+	struct apple_pcie *pcie;
 	struct pci_dev *port_pdev;
 	struct apple_pcie_port *port;
 
+	pcie = apple_pcie_lookup(cfg->parent);
+	if (WARN_ON(!pcie))
+		return NULL;
+
 	/* Find the root port this device is on */
 	port_pdev = pcie_find_root_port(pdev);
 
@@ -806,10 +842,14 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
 
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
-	struct apple_pcie *pcie = cfg->priv;
 	struct device *dev = cfg->parent;
+	struct apple_pcie *pcie;
 	int ret;
 
+	pcie = apple_pcie_lookup(dev);
+	if (WARN_ON(!pcie))
+		return -ENOENT;
+
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -852,13 +892,18 @@ static int apple_pcie_probe(struct platform_device *pdev)
 
 	mutex_init(&pcie->lock);
 	INIT_LIST_HEAD(&pcie->ports);
-	dev_set_drvdata(dev, pcie);
 
 	ret = apple_msi_init(pcie);
 	if (ret)
 		return ret;
 
-	return pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
+	apple_pcie_register(pcie);
+
+	ret = pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
+	if (ret)
+		apple_pcie_unregister(pcie);
+
+	return ret;
 }
 
 static const struct of_device_id apple_pcie_of_match[] = {
-- 
2.39.2


