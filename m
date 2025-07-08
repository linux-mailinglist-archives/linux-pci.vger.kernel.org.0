Return-Path: <linux-pci+bounces-31707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BC5AFD561
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB696165EDB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931852E5B21;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqsZbG6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14522126E;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996051; cv=none; b=XjKDuA++TGXphJZTTsh8ayWO2IPlSf1AYgW1Zg7EmY7eBy88UO7DuegNbZq8jGhRAeIzdmYDz770EYNzPCSnWcqVtKE+R4WdG3ETI28GlGnNVAFCuCNSEkc0djeES8nZuUHozwsjfNPNQICMkms5ug+Nd8aCpdk4cRRn6loPFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996051; c=relaxed/simple;
	bh=9TTQFkyY0M8aTj6Iv8cpYI5ilm3sw2M2ZI3G1K0Exkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qANJaxvx6/K43vrBAFU55qEL+TYupRZeq+rzngEabPkHE06Z3QuhuHKTQ8qYfTQmkZ+kZuS3tkmBHHUM5S0qAlIa41XXEGJGJHnnvIkm+orL0uJOWdZG8xUhIlK4aAzbd5ZAKomORNshhiTjMxNTvDs1kMCVyQO2Lr69zr+cftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqsZbG6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150EBC4CEFD;
	Tue,  8 Jul 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996051;
	bh=9TTQFkyY0M8aTj6Iv8cpYI5ilm3sw2M2ZI3G1K0Exkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqsZbG6u6KjiRwauw+wclsVudQEywuNtzdpxpn9C7bV2B/q34vHG1nRvzKPrOf7CO
	 tOPDOmb0riqbgd1/sb0Qcuko+/844q1IXjDGb5xKRW25oqg1XpLTNXM7M3SAXv/0lD
	 ZbMwN64WXLItvlpolw3jhC+rPTi+LFJWdqns9ftjFrCWk1scsd81YbWVvAxPvhw6J9
	 c/VSdHAukMex41O+ZBO545kPBfkxNddAQJdIGrMQMZrZ7Y73+CfLOCoZFy+UvJHyYn
	 EdvpxrE85zkkyb3TAXTXTYwcmSdjX4KlITmtZJ7vG1H7YU+ZGG4GMI1sjQ71Dx7qmO
	 PsGhljKqrlMrg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uZCCn-00Dqhw-0H;
	Tue, 08 Jul 2025 18:34:09 +0100
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
Subject: [PATCH v2 02/13] PCI: xgene: Defer probing if the MSI widget driver hasn't probed yet
Date: Tue,  8 Jul 2025 18:33:53 +0100
Message-Id: <20250708173404.1278635-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250708173404.1278635-1-maz@kernel.org>
References: <20250708173404.1278635-1-maz@kernel.org>
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


