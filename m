Return-Path: <linux-pci+bounces-17660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D99E3D8B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C3280B40
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37320B1F6;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OneFgRhu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9320B1E0;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324511; cv=none; b=BQRHR7mgNXi7ti68iSvGmqcvx/gPfTlQOFmr8urs0N/6Xz1L44AFZjTg9LmWect6QrpYos/Zo4qEeMCc5Vt60GnmKKqF15VWGcPPc4fA4SesuJR9VL/uh9IdZ45S37SuPZYK/N0fG2I2E9LdTbI+P4M9mAF/AzzAr84YwgtoWI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324511; c=relaxed/simple;
	bh=QkFC1E8ORPu9Ne0GyjX1Po1qGhOZQ6JkT3lHao3IQsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwZBz/jPfSKy1jW6YtXnAwWRP88MDzkTuZgcA1cX7jI5BMxiWIesxGMg/233ANLSK26zXvOTlvCek9a04PEdnVVZ7F9DhCrR+SBj7koXIhB93v5vjeUtZUC5Qfos5k+6xjuJ79dqBuhvnP9Hltua0CCpIEawotbKVzCM7YdHPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OneFgRhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E289C4CEE1;
	Wed,  4 Dec 2024 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733324511;
	bh=QkFC1E8ORPu9Ne0GyjX1Po1qGhOZQ6JkT3lHao3IQsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OneFgRhuMZcpMXvXGH2sNjjiLoVbivUuxMbDW3R/a50ggHowA7AfijKDDI5X7o7dj
	 iO1FVN5v+iZQQkxWR00nZ6R3zGP1BqGtAx4Rs4QMlKvWdKLMsDUibKdPFYjDTrPRKW
	 LZ9pDziKKT5K5X+JM3DaFdz/gv9VnVk8Qvp/8XFm0TYSzKW8+iRCbWVeaX/CSpBXoY
	 iGsthjrLqxmPmYH27RDHNP3IAsIf8z7jC/g3Gzvot/q5UxNV6/aZ9npmIUsm+f5lu3
	 0ftY/dFdkkuJJVAUZsdCXrm/apPx8xVC+289embS0KGwxaz5YSssvCvj/UAiEukf1Y
	 82PjqvM9AHo2g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIqsv-000TvG-7v;
	Wed, 04 Dec 2024 15:01:49 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 2/2] PCI: apple: Convert to {en,dis}able_device() callbacks
Date: Wed,  4 Dec 2024 15:01:45 +0000
Message-Id: <20241204150145.800408-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204150145.800408-1-maz@kernel.org>
References: <20241204150145.800408-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, alyssa@rosenzweig.io, Frank.Li@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that the core host-bridge infrastructure is able to give
us a callback on each device being added or removed, convert
the bus-notifier hack to it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 75 ++++++-----------------------
 1 file changed, 15 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index fefab2758a064..a7e51bc1c2fe8 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -26,7 +26,6 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/msi.h>
-#include <linux/notifier.h>
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
 
@@ -667,12 +666,16 @@ static struct apple_pcie_port *apple_pcie_get_port(struct pci_dev *pdev)
 	return NULL;
 }
 
-static int apple_pcie_add_device(struct apple_pcie_port *port,
-				 struct pci_dev *pdev)
+static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
 {
 	u32 sid, rid = pci_dev_id(pdev);
+	struct apple_pcie_port *port;
 	int idx, err;
 
+	port = apple_pcie_get_port(pdev);
+	if (!port)
+		return 0;
+
 	dev_dbg(&pdev->dev, "added to bus %s, index %d\n",
 		pci_name(pdev->bus->self), port->idx);
 
@@ -698,12 +701,16 @@ static int apple_pcie_add_device(struct apple_pcie_port *port,
 	return idx >= 0 ? 0 : -ENOSPC;
 }
 
-static void apple_pcie_release_device(struct apple_pcie_port *port,
-				      struct pci_dev *pdev)
+static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
 {
+	struct apple_pcie_port *port;
 	u32 rid = pci_dev_id(pdev);
 	int idx;
 
+	port = apple_pcie_get_port(pdev);
+	if (!port)
+		return;
+
 	mutex_lock(&port->pcie->lock);
 
 	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
@@ -721,45 +728,6 @@ static void apple_pcie_release_device(struct apple_pcie_port *port,
 	mutex_unlock(&port->pcie->lock);
 }
 
-static int apple_pcie_bus_notifier(struct notifier_block *nb,
-				   unsigned long action,
-				   void *data)
-{
-	struct device *dev = data;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct apple_pcie_port *port;
-	int err;
-
-	/*
-	 * This is a bit ugly. We assume that if we get notified for
-	 * any PCI device, we must be in charge of it, and that there
-	 * is no other PCI controller in the whole system. It probably
-	 * holds for now, but who knows for how long?
-	 */
-	port = apple_pcie_get_port(pdev);
-	if (!port)
-		return NOTIFY_DONE;
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		err = apple_pcie_add_device(port, pdev);
-		if (err)
-			return notifier_from_errno(err);
-		break;
-	case BUS_NOTIFY_DEL_DEVICE:
-		apple_pcie_release_device(port, pdev);
-		break;
-	default:
-		return NOTIFY_DONE;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block apple_pcie_nb = {
-	.notifier_call = apple_pcie_bus_notifier,
-};
-
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -799,23 +767,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-static int apple_pcie_probe(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = bus_register_notifier(&pci_bus_type, &apple_pcie_nb);
-	if (ret)
-		return ret;
-
-	ret = pci_host_common_probe(pdev);
-	if (ret)
-		bus_unregister_notifier(&pci_bus_type, &apple_pcie_nb);
-
-	return ret;
-}
-
 static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
 	.init		= apple_pcie_init,
+	.enable_device	= apple_pcie_enable_device,
+	.disable_device	= apple_pcie_disable_device,
 	.pci_ops	= {
 		.map_bus	= pci_ecam_map_bus,
 		.read		= pci_generic_config_read,
@@ -830,7 +785,7 @@ static const struct of_device_id apple_pcie_of_match[] = {
 MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
 
 static struct platform_driver apple_pcie_driver = {
-	.probe	= apple_pcie_probe,
+	.probe	= pci_host_common_probe,
 	.driver	= {
 		.name			= "pcie-apple",
 		.of_match_table		= apple_pcie_of_match,
-- 
2.39.2


