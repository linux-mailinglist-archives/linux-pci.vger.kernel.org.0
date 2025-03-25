Return-Path: <linux-pci+bounces-24643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3666A6ED98
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3453B06D5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8325525A;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGeyb0Xl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05D254B19;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898396; cv=none; b=s9ULHHGfCUGPsWpZCYev0HVAWJrmBspuKfSsadvvPmIKp1stv34izFewuNa7xDs2jJRma6xONbBXNYpBvgpSLpSqojJZD3xhafS5BvHoliuTChl2q1+fmLVYqTCuhQPB4rDQRLLwXz3MLF9fjlCboWyJ7dKa8TlXy5zCkK+czKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898396; c=relaxed/simple;
	bh=Y0zJuYQOmgHCAOoviW43k+UcHUlPJoaO7lqdgF528qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfZVDuKCHjBH1TmdyWV3FBhSOSk83kavnIP68UUCUvRieT8EqnEvKNha9COYpCYTEcJtkvoG9dcF9KkudBc88uNlDpSEl9IgVRSLTlr1XZvKuHufw+0I8Y118flILk0klJXlWWHyHec3YRKRKqLFQ/KyJ7c+qiqqdvqkjruNwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGeyb0Xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA8BC4CEF7;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=Y0zJuYQOmgHCAOoviW43k+UcHUlPJoaO7lqdgF528qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGeyb0XlSnRJtUkEq+nMGV0nN6oX84LE3s1YApQKzhmZcyq/IjRZLrZGz0Di76j/S
	 0xPWOD9+o2AnJiLYE7HdXzc33gHptl0HNgDzBhxT15qJC43W4WuKhzjyynBHNC7tip
	 ql3IuVkofUvu/5w09/GLAC4rLdoCaBwIv1OxOj6Gi2xM/TK0fd4wGoT4TuI8xqZ8wD
	 QmIwUsCqGS2AvY3dZQg9A40MFcFqSbwU9eHGeU5wX6QgtqZMdwGGvPX1vRVwbLpik3
	 zUoxh0tbX6QdIKCDqwZKgv2QUHeBQWfEtrEn32u3g9OxrsOHjgOZ48WIo85uAnrhwb
	 lKDeZkTeg2AJg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UP-00GsRS-He;
	Tue, 25 Mar 2025 10:26:33 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 06/13] PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private interrupts
Date: Tue, 25 Mar 2025 10:26:03 +0000
Message-Id: <20250325102610.2073863-7-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

T602x seems to have dropped the rather useful SET/CLR accessors
to the masking register.

Instead, let's use the mask register directly, and wrap it with
a brand new spinlock. No, this isn't moving in the right direction.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 1f6c55e4b5d68..63ceb5e3debaf 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -142,6 +142,7 @@ struct apple_pcie {
 };
 
 struct apple_pcie_port {
+	raw_spinlock_t		lock;
 	struct apple_pcie	*pcie;
 	struct device_node	*np;
 	void __iomem		*base;
@@ -261,14 +262,16 @@ static void apple_port_irq_mask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
 
-	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
+	guard(raw_spinlock_irqsave)(&port->lock);
+	rmw_set(BIT(data->hwirq), port->base + PORT_INTMSK);
 }
 
 static void apple_port_irq_unmask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
 
-	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKCLR);
+	guard(raw_spinlock_irqsave)(&port->lock);
+	rmw_clear(BIT(data->hwirq), port->base + PORT_INTMSK);
 }
 
 static bool hwirq_is_intx(unsigned int hwirq)
@@ -387,7 +390,7 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 		return -ENOMEM;
 
 	/* Disable all interrupts */
-	writel_relaxed(~0, port->base + PORT_INTMSKSET);
+	writel_relaxed(~0, port->base + PORT_INTMSK);
 	writel_relaxed(~0, port->base + PORT_INTSTAT);
 
 	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
@@ -537,6 +540,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	port->pcie = pcie;
 	port->np = np;
 
+	raw_spin_lock_init(&port->lock);
+
 	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
-- 
2.39.2


