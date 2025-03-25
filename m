Return-Path: <linux-pci+bounces-24647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E75A6ED9F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE4516D568
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB582566D9;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUDBtS4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC01EBFE2;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898396; cv=none; b=poJhZgh8oBDFUOcTE7hqHjD6e/2pggxL7UIrTPTHjdUcod9AmI7pR81boPwH8zH0MwIGiwtMrF5aXcz2v17UF0niCQFvOAIiXkixzJTJgiCEbuSh8vnm4t3gjW2WtZ3Yb6EB2MTgSUIFPXBNSZ+2l7ZYDSdvjDKGOyfZvqIMwBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898396; c=relaxed/simple;
	bh=1vQPJifRV9s/zzFihe691RAxq/RpVicRgI4tNMPv98s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5Mr4E8lGkiW8w4dP1aAetHjMii6RcIJBTdxzUqHJ5Ewvr5PQbAZe/1ilecYIJ5y9hDdLzYN3LJfxRBkZlgnnwSrlK92rjRfQ/0+/Agq6+wKhfa1G7ICLYhZeWPjRgcL93L6fJVNvVPvpj+iwLCPuX5jI4h6D7JQJoM8AHWJUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUDBtS4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D8CC4AF0B;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898396;
	bh=1vQPJifRV9s/zzFihe691RAxq/RpVicRgI4tNMPv98s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUDBtS4PqAalbD9NTxNEjtGTz1mgJn+UuJYeXEjupg774VvxT5qJXUDprUqGBD6sD
	 2CtC/2jFQTOSj71Nxdg0iv7wlyddSk7pwbtmxJ/3N0JD8p4Fkp93D9g1kRV4aDXCeq
	 3kAzUzOXRE1bSdGl6e4DLEkQcmCudnsJms0YVGntHTAtYmwRa+iJDixrMNzLpT7FyB
	 Zs/PWjsUyWOnQvdgLqIItz0Z+iPuOEEjLKkqi7DY5Tsp0RoZa133Pv+e3o4W7EdfBK
	 1dbjqC3zsVh0e1BHl+HU40klcnR3liAdrJbHRNgMDmmL0YdjlUrYtFgthaxWIGvoUe
	 cd8JNab55Hjgw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UQ-00GsRS-G8;
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
Subject: [PATCH v2 10/13] PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
Date: Tue, 25 Mar 2025 10:26:07 +0000
Message-Id: <20250325102610.2073863-11-maz@kernel.org>
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

This is checking a core refclk in per-port setup which doesn't make a
lot of sense, and the bootloader needs to have gone through this anyway.

It doesn't work on T602x, so just drop it across the board.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 94c49611b74df..c00ec0781fabc 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -475,12 +475,6 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	u32 stat;
 	int res;
 
-	res = readl_relaxed_poll_timeout(pcie->base + CORE_RC_PHYIF_STAT, stat,
-					 stat & CORE_RC_PHYIF_STAT_REFCLK,
-					 100, 50000);
-	if (res < 0)
-		return res;
-
 	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
 	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
 
-- 
2.39.2


