Return-Path: <linux-pci+bounces-25048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38FA77774
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB5316A5E8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076551EF394;
	Tue,  1 Apr 2025 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Lu4yvj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B31EF378;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499058; cv=none; b=IeXsSdPX9uH7/tlu5DqImTPYSExFQjmedTubfpNcldsKg2TJNKRkIGUSgXLBmMFRB06lurUxodyskRErMDTz6nV6gkLHFla18Wryt0pQunS9yK4S4tEZjYYsEgWztntQpTX4DJ0VFP/+VwJ0QkBhNj1keIgwFcxmpxGeWh+WxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499058; c=relaxed/simple;
	bh=AxgUPpe7veMz43oEYyqKVd2CX9jpZjZQhL1wqg2ys4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Heuu453lq2BN5wBRtep4JJpdgTElJJ76JtgPgqcQJR2AE2AUf/PrU1hNopZAKXiiUzsZYskbH7fV2kttoWomkrx0cv709oIU67AqaebUnP8QjNjYqEqoMdSBpxvKhflJJeXJ6p1kQNhrjwOQ9ftu3DAtnWjhO/QpTxXR34OoojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Lu4yvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD5EC4CEFA;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499058;
	bh=AxgUPpe7veMz43oEYyqKVd2CX9jpZjZQhL1wqg2ys4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2Lu4yvjmBvDOFtlxJkxvjaYq0Hj9ZzcE60GMXnxdKlhfGXG/S0wYU5MnkVXhNT9G
	 RkJ9jupOJE5FqGVhfqZ6KrXxBcgcFn+eo2H7KPGBEtvXMEiWiEwYmcJiCJh8v6DiX7
	 xb2hpGPaaiqAqDJN0O2w56cLclzRoaCJI8QVgD/D4EEKnFa7XqbmrsLoRpIuOJpZ9S
	 D0V5KJUcOb93HL6m6C6/p8UoFTS1KfIzVIbEzTSmbtgUJiiYMIiIm/z+ntyolCokWk
	 oI8UzETL74D8ghCcIicA1coopW2K2LNadYKwNuooEPqBth57IWKlUeYowkOY2B8i4X
	 VHCLvKyKsQApA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkW-001GqU-DE;
	Tue, 01 Apr 2025 10:17:36 +0100
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: [PATCH v3 07/13] PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private interrupts
Date: Tue,  1 Apr 2025 10:17:07 +0100
Message-Id: <20250401091713.2765724-8-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250401091713.2765724-1-maz@kernel.org>
References: <20250401091713.2765724-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, mark.kettenis@xs4all.nl
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

T602x seems to have dropped the rather useful SET/CLR accessors
to the masking register.

Instead, let's use the mask register directly, and wrap it with
a brand new spinlock. No, this isn't moving in the right direction.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 6d3aa186d9c5f..6b04bf0b41dcc 100644
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


