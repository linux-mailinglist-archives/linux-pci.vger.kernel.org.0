Return-Path: <linux-pci+bounces-96-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE847F3DE1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE2B217A1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46828154B0;
	Wed, 22 Nov 2023 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwBaS0CK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605415AE3
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E72C433CD;
	Wed, 22 Nov 2023 06:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633068;
	bh=vLKniB7pmXsD0MDHFe8N5T7V8n7++oSIsHdTVRMJkB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwBaS0CKeQVfNthUwlNEXL2qxPNoaG+pB7XiQdNb9qwDiGik7mmubKT7y8rgfjjda
	 HxThCESplS3O18Fl9p+PAlBgueBhY5zgU0JrRkUPe41fIpBKGxZujHSOmsM9g6HCPw
	 a2kvBApGolM/DigpO0obZcXJxChNQuZyGbONMqQTqAgU2AnOq+yv27MjmesCM1WuB0
	 8gKMrjZL1jq3zE6wAWxDLL0wvSXVd6Y3QkYCFoSoKVWVfJzIf+V8s40NWj8nTEyBRk
	 +DjC65GiteqxwovLNatbXRpRL2KJEqf3QDczm8qFgW10eLhdMyGpLyzwsizon4Lhpi
	 Rot8yb8dhxhZA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 11/16] PCI: dw-rockchip: Rename rockchip_pcie_legacy_int_handler()
Date: Wed, 22 Nov 2023 15:04:01 +0900
Message-ID: <20231122060406.14695-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function rockchip_pcie_legacy_int_handler() to
rockchip_pcie_intx_handler() to match the code managing INTX interrupts
(e.g. intx_domain_ops) and the term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 2fe42c70097f..2b3923c52827 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -72,7 +72,7 @@ static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
 	writel_relaxed(val, rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
+static void rockchip_pcie_intx_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
@@ -202,7 +202,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret < 0)
 		dev_err(dev, "failed to init irq domain\n");
 
-	irq_set_chained_handler_and_data(irq, rockchip_pcie_legacy_int_handler,
+	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
 	/* LTSSM enable control mode */
-- 
2.42.0


