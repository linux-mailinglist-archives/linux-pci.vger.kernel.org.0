Return-Path: <linux-pci+bounces-42023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8418C84795
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEED03438F4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A92FE56E;
	Tue, 25 Nov 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sygUi4Os"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626C2F9C37;
	Tue, 25 Nov 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066474; cv=none; b=qEr9Trgr7XTD7NIDq0g6djvLJkAqJ4lYK2dAY2m6zRXImz4LAlVUisz4OfJzeg0si9bijk/1WhmCFBjnpNfFQE28LvOpnw/flUrRTpYKQoBvtVnume/8yC63QWzruEf19zW6Aj5k0LFCpd9o1WtNLGkoj06DEvR36G/Q67VNAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066474; c=relaxed/simple;
	bh=hOlaNf5irREQeC5hqJ1JIn+4xJWmxsP/XfB0B/la+Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f96kNn5yWqyYjwmfY/jU0CVNuprRIpUiW7dQUYuQNGjDV+04iKaOjKLPWnkCxpIa/dlDMWdDYU8rNkt4oqhDuDJIWT97ujSf0JQGAAioJtFc16Jrj5e96sQm+4Z89bPXhCp8cQiM72pWgQmkbSdkcwdbfB7rNUdUL+45wR76/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sygUi4Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ADDC4CEF1;
	Tue, 25 Nov 2025 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764066473;
	bh=hOlaNf5irREQeC5hqJ1JIn+4xJWmxsP/XfB0B/la+Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=sygUi4OsPVIJo5N7R7GGXVq4YmxJCqdw4HGtyXMEfO1elbS7w294nfId/WFoZpzKx
	 0s2BlgwcGlrnLQnBm2XdKMEfbsGpqYdMwvUjECwIJivjifd4zoXsIgfRX7LmWhsnSS
	 u7Wi4R4l2VFuoYmd42zP6y1DDvp1juvwoHED1cBKTZ1NzV2CSp+99zEtA4vDH++xKR
	 nGKlMIiNXlnucDTupcKP0/+yZw2gcYJf67wQ+1+jJI7sh60/PvnDv3MRCUjaOiCgn2
	 BAq0K0mC1KygoWIaqYxCzN1ZZKYFpSFYSt918dV5EubdzHUXVd+tDm1vQIWiEaK8us
	 wmYsamamDTdxQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vNqH0-000000087dw-48ay;
	Tue, 25 Nov 2025 10:27:51 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Radu Rendec <rrendec@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v2] PCI: host-generic: Move bridge allocation outside of pci_host_common_init()
Date: Tue, 25 Nov 2025 10:27:26 +0000
Message-ID: <20251125102726.865617-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rrendec@redhat.com, bhelgaas@google.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, lpieralisi@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Having the host bridge allocation inside pci_host_common_init() results
in a lot of complexity in the pcie-apple driver (the only direct user
of this function outside of core PCI code).

It forces the allocation of driver-specific tracking structures outside
of the bridge allocation, which in turn requires it to use inefficient
data structures to match the bridge and the private structure as needed.

Instead, let the bridge structure be passed to pci_host_common_init(),
allowing the driver to allocate it together with the private data,
as it is usually intended. The driver can then retrieve the bridge
via the owning device attached to the PCI config window structure.
This allows the pcie-apple driver to be significantly simplified.

Both core and driver code are changed in one go to avoid going via
a transitional interface.

Reviewed-by: Radu Rendec <rrendec@redhat.com>
Link: https://lore.kernel.org/r/86jyzms036.wl-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
---

Notes:
    - Removed unused list_head from apple_pcie structure
    - Fixed numerous typos
    - Added Radu's RB

 drivers/pci/controller/pci-host-common.c | 13 +++----
 drivers/pci/controller/pci-host-common.h |  1 +
 drivers/pci/controller/pcie-apple.c      | 43 ++++--------------------
 3 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e9..c473e7c03baca 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -53,16 +53,12 @@ struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 EXPORT_SYMBOL_GPL(pci_host_common_ecam_create);
 
 int pci_host_common_init(struct platform_device *pdev,
+			 struct pci_host_bridge *bridge,
 			 const struct pci_ecam_ops *ops)
 {
 	struct device *dev = &pdev->dev;
-	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
-
 	of_pci_check_probe_only();
 
 	platform_set_drvdata(pdev, bridge);
@@ -85,12 +81,17 @@ EXPORT_SYMBOL_GPL(pci_host_common_init);
 int pci_host_common_probe(struct platform_device *pdev)
 {
 	const struct pci_ecam_ops *ops;
+	struct pci_host_bridge *bridge;
 
 	ops = of_device_get_match_data(&pdev->dev);
 	if (!ops)
 		return -ENODEV;
 
-	return pci_host_common_init(pdev, ops);
+	bridge = devm_pci_alloc_host_bridge(&pdev->dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
+	return pci_host_common_init(pdev, bridge, ops);
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 51c35ec0cf37d..b5075d4bd7eb3 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -14,6 +14,7 @@ struct pci_ecam_ops;
 
 int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_init(struct platform_device *pdev,
+			 struct pci_host_bridge *bridge,
 			 const struct pci_ecam_ops *ops);
 void pci_host_common_remove(struct platform_device *pdev);
 
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 0380d300adca6..2d92fc79f6ddf 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -187,7 +187,6 @@ struct apple_pcie {
 	const struct hw_info	*hw;
 	unsigned long		*bitmap;
 	struct list_head	ports;
-	struct list_head	entry;
 	struct completion	event;
 	struct irq_fwspec	fwspec;
 	u32			nvecs;
@@ -206,9 +205,6 @@ struct apple_pcie_port {
 	int			idx;
 };
 
-static LIST_HEAD(pcie_list);
-static DEFINE_MUTEX(pcie_list_lock);
-
 static void rmw_set(u32 set, void __iomem *addr)
 {
 	writel_relaxed(readl_relaxed(addr) | set, addr);
@@ -724,32 +720,9 @@ static int apple_msi_init(struct apple_pcie *pcie)
 	return 0;
 }
 
-static void apple_pcie_register(struct apple_pcie *pcie)
-{
-	guard(mutex)(&pcie_list_lock);
-
-	list_add_tail(&pcie->entry, &pcie_list);
-}
-
-static void apple_pcie_unregister(struct apple_pcie *pcie)
-{
-	guard(mutex)(&pcie_list_lock);
-
-	list_del(&pcie->entry);
-}
-
 static struct apple_pcie *apple_pcie_lookup(struct device *dev)
 {
-	struct apple_pcie *pcie;
-
-	guard(mutex)(&pcie_list_lock);
-
-	list_for_each_entry(pcie, &pcie_list, entry) {
-		if (pcie->dev == dev)
-			return pcie;
-	}
-
-	return NULL;
+	return pci_host_bridge_priv(dev_get_drvdata(dev));
 }
 
 static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
@@ -875,13 +848,15 @@ static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
 static int apple_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
 	struct apple_pcie *pcie;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
 		return -ENOMEM;
 
+	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = dev;
 	pcie->hw = of_device_get_match_data(dev);
 	if (!pcie->hw)
@@ -897,13 +872,7 @@ static int apple_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	apple_pcie_register(pcie);
-
-	ret = pci_host_common_init(pdev, &apple_pcie_cfg_ecam_ops);
-	if (ret)
-		apple_pcie_unregister(pcie);
-
-	return ret;
+	return pci_host_common_init(pdev, bridge, &apple_pcie_cfg_ecam_ops);
 }
 
 static const struct of_device_id apple_pcie_of_match[] = {
-- 
2.47.3


