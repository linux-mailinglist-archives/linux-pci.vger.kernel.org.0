Return-Path: <linux-pci+bounces-27658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BBFAB5B3F
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA32467515
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39382BF97C;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIl9DgWx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FC2BF971;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157311; cv=none; b=nXU4Sdip5rAPArU4SOvoNTFSkpEpk/uLuKndS+HxKSa5Xjzrkrz25k3dbu1FNzeT6bnDAo5BUobMScyclCtaLvkuzN6ePj9CRMdN3Xnd0X2Z5OtrgOQLmOgDQRR/HRZbpw5v/eK8LJkYFsa9Ps5zDtym+UEUT9ANksNApELx0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157311; c=relaxed/simple;
	bh=SMrWTvCzP5hX69d4ob83aacON5i1XY6uV9HAynVUA+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/0jx4ImdGKDPbU8vbd2mHl129mhsaNpx8aHZBrkgkgz4DgljkUbLSBDPBTlrveGDkJhso4b1ApVBif+//Q7Pq8N/8jCcwN83vAGZ19zFcj79bXE7/gGZ2y2eW4Q6/Q9O6Q52bFQZwD9jr9G9ONpr/KkeIJOwlZYGDUSCtBIy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIl9DgWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C839C4CEEF;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157311;
	bh=SMrWTvCzP5hX69d4ob83aacON5i1XY6uV9HAynVUA+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIl9DgWxhqoyx4zy22bwHIu+fyKkwXUPcoD3/ueDPpW02GjXLl+CEnTv+1+Z//W/H
	 Bz/AzN9C5vRsoJtuxLjB7l1j7WLh/FnAH6yW1fUHEtgWVPIfUY2zL4gDRGe+Un28nR
	 fSf+ZNzW7nmvoKQMQctJQdkU2RdA9XYWPkhs4WoRHqB2Teyi8onOCkF60q8w06Dnp+
	 ndXxrlCO8U9TnEVRkJ3EbCQgcKMZY0/iFhC14BNPtBAFrgNW87LMyLN/cEhqW1Qw/c
	 0LExMNeKr5ku0VsjD01SvNyBIqqOBxZ3F8btDakxJzx6GuHXKjptYYU3KyIghgtCih
	 7jN0kQEsu+avg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQa-00EbRz-Vn;
	Tue, 13 May 2025 18:28:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 5/9] irqchip: Drop MSI_CHIP_FLAG_SET_ACK from unsuspecting MSI drivers
Date: Tue, 13 May 2025 18:28:15 +0100
Message-Id: <20250513172819.2216709-6-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Commit 1c000dcaad2be ("irqchip/irq-msi-lib: Optionally set default
irq_eoi()/irq_ack()") added blancket MSI_CHIP_FLAG_SET_ACK flags,
irrespective of whether the underlying irqchip required it or not.

Drop it from a number of drivers that do not require it.

Fixes: 1c000dcaad2be ("irqchip/irq-msi-lib: Optionally set default irq_eoi()/irq_ack()")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c               | 2 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 drivers/irqchip/irq-gic-v3-mbi.c            | 2 +-
 drivers/irqchip/irq-mvebu-gicp.c            | 2 +-
 drivers/irqchip/irq-mvebu-odmi.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 9050792e3242f..e30463a7bf1ea 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -252,7 +252,7 @@ static void __init gicv2m_teardown(void)
 static struct msi_parent_ops gicv2m_msi_parent_ops = {
 	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
 	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "GICv2m-",
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 51cc961bc3181..443e8fcf2fc16 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -211,7 +211,7 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "ITS-",
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 11fa5df9da8c7..a9142677c810c 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -197,7 +197,7 @@ static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
 	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
 	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
 	.prefix			= "MBI-",
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index c7c83f8923fcd..68764e7754ba6 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -161,7 +161,7 @@ static const struct irq_domain_ops gicp_domain_ops = {
 static const struct msi_parent_ops gicp_msi_parent_ops = {
 	.supported_flags	= GICP_MSI_FLAGS_SUPPORTED,
 	.required_flags		= GICP_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	= MATCH_PLATFORM_MSI,
 	.prefix			= "GICP-",
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index e6049f647a017..fe99888b8134d 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -157,7 +157,7 @@ static const struct irq_domain_ops odmi_domain_ops = {
 static const struct msi_parent_ops odmi_msi_parent_ops = {
 	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
-	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
 	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	= MATCH_PLATFORM_MSI,
 	.prefix			= "ODMI-",
-- 
2.39.2


