Return-Path: <linux-pci+bounces-24650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACCA6EDB2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573BD3AD9D8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80D2571A1;
	Tue, 25 Mar 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYiVoL9N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5E256C8B;
	Tue, 25 Mar 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898397; cv=none; b=E4ZJ1zYVqjdPgbFjDTg8RmcSqOR0+icmi6J9CRT7mrDqPFVs+uuryTC0aUxVcfx6x47PmFaCXIyW3r9LALmlpiPmd9XfSS1LZUlUeynqS1laB2Phr83KPGU7M8CFZEYldQGp1x/zAxBgDG21Ys5n0utsFjUE98cG0FTWdUzRmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898397; c=relaxed/simple;
	bh=uOXbXDjMKyukh5xpECmZxtWE5UOD4R8xzv4YEkmSeyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOg4FFIsWeqLBxZK2fO5qpHKB3DG54mb/rqzzdctOOzZrlU6Wy6MWWkPQE3FwKkrh+2tK0oRxqrdLQeWhZfbLqZVyerUt+sV+EelMDFVGek7bkwvB4rE+5iJQtjAMTue8oPRIU4MYTI4WWwxKfzZkEofVlE3hh+heQaoKkTP8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYiVoL9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37D0C4CEF5;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898397;
	bh=uOXbXDjMKyukh5xpECmZxtWE5UOD4R8xzv4YEkmSeyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYiVoL9N357+qEbb9IOxWsE5qB9BDIPBoqI0767t9oxS3ib8dOoFPbHS/YqDaFWvn
	 sE/+SIkMW/YnqCplkEkBsipBCx7DK8pnzaMWDqOSTK4b157DMAN12MtHcJGUwdy3oA
	 35h10LDGxN11zlkuA1jAp8JXPzUYpOCnwbs3aLYoihstPDqrbTzgf8GaJAELyVjswf
	 eV3koRwB6XdSbDsADtJKtMnrMEk8MhtqVj2eCcCzVvnwErBjGukO3fPLNDbPY/PHqD
	 RriQ0+hOezOMPiWzhbuhhgAC9yyhglS5A6FWoV+VoAhZPEAzlgHm20Goivm8McZZ81
	 eVAnEnkn97RAA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UR-00GsRS-7G;
	Tue, 25 Mar 2025 10:26:35 +0000
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
Subject: [PATCH v2 13/13] PCI: apple: Add T602x PCIe support
Date: Tue, 25 Mar 2025 10:26:10 +0000
Message-Id: <20250325102610.2073863-14-maz@kernel.org>
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

From: Hector Martin <marcan@marcan.st>

This version of the hardware moved around a bunch of registers, so we
avoid the old compatible for these and introduce register offset
structures to handle the differences.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 847cba753d28d..5b85d9497070c 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -124,6 +124,13 @@
 #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
 #define PORT_PREFMEM_ENABLE		0x00994
 
+/* T602x (M2-pro and co) */
+#define PORT_T602X_MSIADDR	0x016c
+#define PORT_T602X_MSIADDR_HI	0x0170
+#define PORT_T602X_PERST	0x082c
+#define PORT_T602X_RID2SID	0x3000
+#define PORT_T602X_MSIMAP	0x3800
+
 #define PORT_MSIMAP_ENABLE	BIT(31)
 #define PORT_MSIMAP_TARGET	GENMASK(7, 0)
 
@@ -158,6 +165,18 @@ static const struct hw_info t8103_hw = {
 	.max_rid2sid		= 64,
 };
 
+static const struct hw_info t602x_hw = {
+	.phy_lane_ctl		= 0,
+	.port_msiaddr		= PORT_T602X_MSIADDR,
+	.port_msiaddr_hi	= PORT_T602X_MSIADDR_HI,
+	.port_refclk		= 0,
+	.port_perst		= PORT_T602X_PERST,
+	.port_rid2sid		= PORT_T602X_RID2SID,
+	.port_msimap		= PORT_T602X_MSIMAP,
+	/* 16 on t602x, guess for autodetect on future HW */
+	.max_rid2sid		= 512,
+};
+
 struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
@@ -425,6 +444,7 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 	/* Disable all interrupts */
 	writel_relaxed(~0, port->base + PORT_INTMSK);
 	writel_relaxed(~0, port->base + PORT_INTSTAT);
+	writel_relaxed(~0, port->base + PORT_LINKCMDSTS);
 
 	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
 
@@ -865,6 +885,7 @@ static int apple_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id apple_pcie_of_match[] = {
+	{ .compatible = "apple,t6020-pcie",	.data = &t602x_hw },
 	{ .compatible = "apple,pcie",		.data = &t8103_hw },
 	{ }
 };
-- 
2.39.2


