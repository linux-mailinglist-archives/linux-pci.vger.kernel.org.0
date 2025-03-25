Return-Path: <linux-pci+bounces-24649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E131A6EDA6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BC1189723D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73460256C85;
	Tue, 25 Mar 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCQ/8UOH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35706256C6D;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898397; cv=none; b=MsDKPyGpKO8y8paqLmdSzMLmqTHXdHzOhKSTo99BEk+ekKh1H6Z9OlUa2X3llgNDpPZAjwzd1n1K7izqp0JC/H1maDBxQN8p8dpnJ0Ct2s+SIul/ehlUrvKaknHBYPyVQa70ilNiY1rZ3y8zJ6+9/e68fdPVYpLU3jWfZ2XbqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898397; c=relaxed/simple;
	bh=FXNN5Scx+4h2r+tjfXFGM0L2JoQizw/qNxVtoO8WdrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V23VGmur4AopPQg+yXLrEuAvBZtLxEEMvMdxwcsyiSoVN0kkjEt8JzgOwgpLbUPojWTWWwM61fNjVOc7ujYZi0+Jgiy3xeK1XsjNbkN0oAigj+MJFZfCU3APRidYjxUCDRUBm6x4xjUcNruERySbvTcYSm1cMHN7VCA+UhAq1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCQ/8UOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED88C4AF0D;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898396;
	bh=FXNN5Scx+4h2r+tjfXFGM0L2JoQizw/qNxVtoO8WdrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCQ/8UOHxvpctHxRlsyZc+SCKLCZyJoX6yztcEZ5ouxY6WbK2sp+qPGxnWYaOed6B
	 wYud6CkXeaNzFKss0AT3ecy7yH+R7QxfOm9GfBIAZj9nqreQ6R8ppYSBO6AGwCBfiu
	 JagL7LzuJRSScxoakeQMVsyI9pOA2G3mDd6v2HwqhwiYfAPaaavnnRDwHeCZA9Unqm
	 +EN2cyHrJZvTCJupnT7QxYw7TYpzY0vz9vdQj7hNUk8YXJ6cFgCM7q5i/DhGzqI0sK
	 NijmmdHVXSQTYrLxdDwDBhtHzmUYtrf38wOrSLBEq6uIP4db1JkCi3gEGzNauqaqV2
	 z75xGeZoKkHAw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UQ-00GsRS-NQ;
	Tue, 25 Mar 2025 10:26:34 +0000
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
Subject: [PATCH v2 11/13] PCI: apple: Use gpiod_set_value_cansleep in probe flow
Date: Tue, 25 Mar 2025 10:26:08 +0000
Message-Id: <20250325102610.2073863-12-maz@kernel.org>
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

We're allowed to sleep here, so tell the GPIO core by using
gpiod_set_value_cansleep instead of gpiod_set_value.

Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index c00ec0781fabc..505adf64bd66d 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -562,7 +562,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
 
 	/* Assert PERST# before setting up the clock */
-	gpiod_set_value(reset, 1);
+	gpiod_set_value_cansleep(reset, 1);
 
 	ret = apple_pcie_setup_refclk(pcie, port);
 	if (ret < 0)
@@ -573,7 +573,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	/* Deassert PERST# */
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
-	gpiod_set_value(reset, 0);
+	gpiod_set_value_cansleep(reset, 0);
 
 	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
 	msleep(100);
-- 
2.39.2


