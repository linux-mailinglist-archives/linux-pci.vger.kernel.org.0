Return-Path: <linux-pci+bounces-24645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A8A6EDA2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF753B1672
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F112561A2;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkyeH/HT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8E255249;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898396; cv=none; b=Ontt9pQ4OD0mg1pNkCZyDtnZNBZ4qmRzT381v7DO0voadKB5c+CJ3Z8Bnajv9j2uVBUgAVqLXaJLh7THjIcnMtlbKyozL4PvjljDLRyA5ch0FeuKtQLECYCgjXdlAyAIg/JKV9h9q1xlpJD5hHyqOBEqxMLyKtjWayd7ZULVCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898396; c=relaxed/simple;
	bh=Oh9hzrub7V3yA6gRUAWaXuxAVYkgTAMlh3xgo9/9ols=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLAzAuJPBCTtwTO2AV3ZExs1Rm5ATiZeSkdwraR2BJC5TGZpU4X4Rj77WRUWmvXXACcJ56HsxHK3h8tjO5FeuBiiQU/q0VG0KZqpqt2MV18m77T6R0eSx6ZSbj4/WUdj+l1SH6wN6VxfIJZFh1J90GQQVto1GlYa+qLzkXzs9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkyeH/HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBEAC4AF0B;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=Oh9hzrub7V3yA6gRUAWaXuxAVYkgTAMlh3xgo9/9ols=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SkyeH/HTmIBNAjo7Dx7nqIpBRB79DCVMvI1u2Su7let3jQAlYRaI68+tDB4KPdA6l
	 mz2Wv/ydl61gRRiKN5/MEOLl7ckni3Lcs8nOTYeUOW8IEnGRcwTB9nSVd1+7tZyca6
	 C1II+sfocYNKda4dr1+JC4lwYhRNLZPakozchoBPKivqOQTgWZhkgOIDv5Zkk2/kFb
	 7E+LCI6r7E5mjD+zu5o2nS/d3CTr3GMa/vQCBEvZB1iaBjeLCtpM198N0tqnm+j8qp
	 FFxyx3iuq2nm3JhGnXPl7vDgACZIP5DziqXBrRd5KmZoi1jNt17ix68m40ETZuzeaa
	 E0296fJI8B9sg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UQ-00GsRS-0l;
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 08/13] PCI: apple: Set only available ports up
Date: Tue, 25 Mar 2025 10:26:05 +0000
Message-Id: <20250325102610.2073863-9-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Janne Grunau <j@jannau.net>

Iterating over disabled ports results in of_irq_parse_raw() parsing
the wrong "interrupt-map" entries, as it takes the status of the node
into account.

Switching from for_each_child_of_node() to for_each_available_child_of_node()
solves this issue.

This became apparent after disabling unused PCIe ports in the Apple
Silicon device trees instead of deleting them.

Link: https://lore.kernel.org/asahi/20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net/
Link: https://lore.kernel.org/asahi/1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org/
Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 6271533f1b042..23d9f62bd2ad4 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -747,7 +747,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	struct device_node *of_port;
 	int ret;
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_available_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(dev, "Port %pOF setup fail: %d\n", of_port, ret);
-- 
2.39.2


