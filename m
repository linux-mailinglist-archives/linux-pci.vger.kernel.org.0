Return-Path: <linux-pci+bounces-24644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A3A6ED9D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCB93AFB2D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228ED255E2E;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egNIEUmH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1024254B1A;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898396; cv=none; b=KDZb1NP1teymVoSzj7RR4Fba/Dzox5yDhWgnhFO/QCWtnZJ1jpcgsvPNROuhU9bhioUBV/vdxcGyY958Hv6hi80qrfOcbyHQCKgdVWY96k6g5oA8cMzMerG96jguWyd/gYrKg8AsoFYmVz1BJ8au5xx+po9WDpwnJ7ndcMFZrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898396; c=relaxed/simple;
	bh=deykT+fK/heCGjU9D2cdIQGrZpoQPM8vhfLPU4LVQ/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWGLYrfvjhaJZyRG3AXIitMKEvQAh0eFSzs1wSZU/eUAHR4/XOjMGCi4SRurAqXvGUJXK2Zi+AF2hwCfuuTJS8/klWU87nrIsp1icp3sL17OjudYddWYI3IxR1fp/4qeKnj42e+ogklP0q/MozGlitXmrR/vMTja1T38BURFeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egNIEUmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B939FC4CEF5;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=deykT+fK/heCGjU9D2cdIQGrZpoQPM8vhfLPU4LVQ/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egNIEUmH36TMSiDDM0AzxmqrYCvi8w6a48gKuaX6f5j1XpGhNEqtvIRDHeJFB0/bP
	 y77QEcJCxC41buXFCp4qsdQO08uqtVorj4eGOSauLAoMYjiwBNxrrgh41HqePAHHyk
	 Zsout6G3OIVLGdi7+7V0otOq2x+9lTkp9oIjfGjQQKaRxfU+hikepODj7xEwNIXnrM
	 mS0N/j0SAhSRlAMI+/F1jcMen+slb27DBb/+q/W1ik3D/baV0kRuzL0f9JMyl1XgV8
	 gP0HPR44lY9+X7CyEC2mfCQsqvSlRRQGlsYyzvLi5od3k0OEoaYdOKn04Xwtra8C2X
	 Ke+DjVjpelHyg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UP-00GsRS-P4;
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
Subject: [PATCH v2 07/13] PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
Date: Tue, 25 Mar 2025 10:26:04 +0000
Message-Id: <20250325102610.2073863-8-maz@kernel.org>
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

In the success path, we hang onto a reference to the node, so make sure
to grab one. The caller iterator puts our borrowed reference when we
return.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 63ceb5e3debaf..6271533f1b042 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -593,6 +593,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
+	/* In the success path, we keep a reference to np around */
+	of_node_get(np);
+
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 
-- 
2.39.2


