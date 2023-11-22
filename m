Return-Path: <linux-pci+bounces-100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE627F3DE5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B986CB219F9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63865156E8;
	Wed, 22 Nov 2023 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STvmWSMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13F15ADD
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FC3C433C8;
	Wed, 22 Nov 2023 06:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633074;
	bh=Z1V4RF/JUwqjX5lRjgHOMEp6M6rCHCrH4pMcnwAbKI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STvmWSMTNZxQB9Yawjht4o3bXw753eNJ9fOo0Q3s/nbw6yuOu3ck62PueYiX+KCZQ
	 z0YFJhIX5XmmuHA4YvOPQG1tChRnD+2cTj7nkecXEed7APdWpWqP/rO3mga2A+L1dK
	 HnH9dLYcYYk0FCeFrGEszoDchv+RqNoAMAY6l9zjfSgwnM8g7BwHVB1wE6JDgNPtPc
	 yHt0ZbL036xEfuLjUlLcpLRhFXntU+2sBNhU9eQy5pfdkMnwH+JaC1I7qfFqZoLM78
	 0F6IdVdng3C1+Baps8T0HIZZWStlf5TwZYJgT7r/qu0WF+YI5PYnXATbmaW6nB00MI
	 ig6+LlHb6BoVw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 15/16] PCI: rockchip-host: Rename rockchip_pcie_legacy_int_handler()
Date: Wed, 22 Nov 2023 15:04:05 +0900
Message-ID: <20231122060406.14695-16-dlemoal@kernel.org>
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

Rename the function rockchip_pcie_legacy_int_handler() of the rockchip
host driver to rockchip_pcie_intx_handler() to match the PCI_IRQ_INTX
macro name used to control this function execution, and to match the
term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index afbbdccd195d..300b9dc85ecc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -505,7 +505,7 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
+static void rockchip_pcie_intx_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
@@ -553,7 +553,7 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 		return irq;
 
 	irq_set_chained_handler_and_data(irq,
-					 rockchip_pcie_legacy_int_handler,
+					 rockchip_pcie_intx_handler,
 					 rockchip);
 
 	irq = platform_get_irq_byname(pdev, "client");
-- 
2.42.0


