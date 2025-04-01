Return-Path: <linux-pci+bounces-25042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D61AA77767
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D709F16A531
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C042E1EDA2C;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7uIOk1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6C1EDA09;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499057; cv=none; b=KdVU6QBUy5HREVG24Z3HEmZ/tRRStP2SH5Yi8iK/RmlhYUQc/H3a7Mpg9TR7P53BUSUbWJPDkfClfrgAph7fayEf/R5XFt0oEhHsM9RcMEBEn00OxjWArr05//xhoSlDEIySflHYch3di7b6CL2MthKo8IylOxq1SgoK54ixVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499057; c=relaxed/simple;
	bh=xS1nUNg7xfA1crBoOsh68GgY9HijVyxfaNBF6+vlanQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjfRDY7A0REwjJT64kYE1OA1eojqvo3imh3L7RY9ebulA34CKvmX//BCnBs1iiIYi5XjISAJ/PpnJQFRJTSQ1qJFtdLpV9r4juCx4g1LrLr2I0SS1aGspB6dS6LHHtZV6fiW/c1oRTyeeWwRv23DGvoX11mzAgKMTcdlRjVeNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7uIOk1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5AFC4CEEE;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499057;
	bh=xS1nUNg7xfA1crBoOsh68GgY9HijVyxfaNBF6+vlanQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7uIOk1uxTmqkd1LZXt6QvkK6njwrR6Dq9BFcm0MnVDIe+i2Ka2BAvumdXOdUWky+
	 tBvuId4px10UBbXUN58IYBgjY6sQPjfZiSaAyVeIYn+vTM/ZhhvOoQerRCCeCeIG2l
	 H8BhS3y0UwRdy+CqVQmF3IPQ9os4pBRQTxEqik7nVptnLwyPgELfbnw32vnheKExD6
	 a1UyAHCsFQvAYNddfhhx04/J+qH26zq4YQxrWfpmNt0nVp2ZOE/EADSxiopzL+NJw/
	 J+KlTeEYOn4jBsuhb3KaSgWfdjsIfZow8/pNSxyTEryzPhMQfQKszMXwdqxYRxGZ10
	 /Lpc/L0lgsGcQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkU-001GqU-Vi;
	Tue, 01 Apr 2025 10:17:35 +0100
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
Subject: [PATCH v3 01/13] PCI: apple: Set only available ports up
Date: Tue,  1 Apr 2025 10:17:01 +0100
Message-Id: <20250401091713.2765724-2-maz@kernel.org>
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

From: Janne Grunau <j@jannau.net>

Iterating over disabled ports results in of_irq_parse_raw() parsing
the wrong "interrupt-map" entries, as it takes the status of the node
into account.

This became apparent after disabling unused PCIe ports in the Apple
Silicon device trees instead of deleting them.

Switching from for_each_child_of_node() to for_each_available_child_of_node()
solves this issue.

Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Fixes: a0189fdfb73d ("arm64: dts: apple: t8103: Disable unused PCIe ports")
Cc: stable@vger.kernel.org
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a7e51bc1c2fe8..842f8cee7c868 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -755,7 +755,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_available_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
-- 
2.39.2


