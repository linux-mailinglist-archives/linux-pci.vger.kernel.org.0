Return-Path: <linux-pci+bounces-25054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0300A7778F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82FB3AC6BD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573D1F1818;
	Tue,  1 Apr 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNwxZOOO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D861F151E;
	Tue,  1 Apr 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499061; cv=none; b=ilAmWsbniK+LChjeQDq9pw4fLfw1brHR7lqzU388kOxQtChlHERDfG4m1M5AUSu9rE2BzUtgkDQMEaqA3cmIKF3gp+6wXIB0IsUGa6ZFfb2zttygxpgHhz8ETja/hOkuVifarhzBwanR/e9JnNBMc9S+1TLLmk0bMlQmPy9pUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499061; c=relaxed/simple;
	bh=AAuy9Z9m36xv9DXKX/wWD75Rj6BA4DlBWKDzkQ/fHC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XR02C3+nMjrdXoWL5NlIPKIGCvOH/C24oyoZoXcuzwbvxVV/tecEQT5mulyvDXxX2y8NrG8fbzheMiDL4du2IHw3F5B1vv3NhiCrT21fwb1bxhhanSe1hTsIDW63D+NZzYhZYBrD/JvqQWwahZjJ1wHFdFoBYNQe3OVriTs+vSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNwxZOOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DE8C4CEF6;
	Tue,  1 Apr 2025 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499059;
	bh=AAuy9Z9m36xv9DXKX/wWD75Rj6BA4DlBWKDzkQ/fHC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNwxZOOOxUH/Z6G48s3eQKbkAfqdTQ0zbxx+DrqbfS3wg/VcVz18dkgEe9RCc6QTv
	 owjyDYqbuf/hwwW1bKh/PhWxrFPKOkS/xUnRXLalvf0slJqt910tSG9JFAN1g2m2h5
	 v0JacZ+2+mTB50VUOHANmJU/WPEZ5aze+8wVDbww0bbrpNo4MvGOqqh3SZItXpuv+i
	 wOWg7tDPA7rfH3eCZFamQ9AbEygbhYIwSPk3Q6N5RXPuAay8l3YrhY5KdnHwV20wMB
	 zmEatSHvHbWzirIWAxygiYavQbz275epMogwa7/Yi/flbgYlBWfls6OsoGJKXCGFPq
	 9mXRQkBv7RRoQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkX-001GqU-Sa;
	Tue, 01 Apr 2025 10:17:37 +0100
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
Subject: [PATCH v3 13/13] PCI: apple: Add T602x PCIe support
Date: Tue,  1 Apr 2025 10:17:13 +0100
Message-Id: <20250401091713.2765724-14-maz@kernel.org>
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

From: Hector Martin <marcan@marcan.st>

This version of the hardware moved around a bunch of registers, so we
avoid the old compatible for these and introduce register offset
structures to handle the differences.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
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


