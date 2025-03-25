Return-Path: <linux-pci+bounces-24642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C087A6ED96
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A19188F3B9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318D254B09;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGKbOGoe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F6254879;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898395; cv=none; b=q98B1GAlN8BIJsNKJPX3ssM54YTtlAxw+vZEefh4jI5QY+7D5sJxNkodxU0llJB2WQhiQsndSvJeVYCZ5tWLXLDwvegC51W/59s0Ulv7lsR1Yelt+MxLRJ2nIIaojVw5fUi1XgrW6xNRqZgOY77wQ7zgZlesh2Xi36yQ3vz5RZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898395; c=relaxed/simple;
	bh=VSfhlj5RX9Q0sFL8fHCdCaINpj+NsUZXrHHgkzj/h48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbNG6Qp993KxNkMpcWctL0J+mQpU9e7gBE4RluOQB5RTw1YkDpO2Bdz1ZqXPL9X4DDjFrGDxArjCmj3KumwLy4YIuo75lPdSB7bf5Q9WWKwJe2Ck7VbsJ5GO3+SbmKGTVoaSldeRrTdg22EuZgoAhANJZ/uw3erjgiBWRx6w55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGKbOGoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9FC4CEEF;
	Tue, 25 Mar 2025 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898395;
	bh=VSfhlj5RX9Q0sFL8fHCdCaINpj+NsUZXrHHgkzj/h48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGKbOGoeIMFSz4zITg4ScePrgJqXqHIWQs0ttHPfQ/1q96gwO/fQ0pTbdYLzxrNSG
	 AREng6rzN5ApUkvlwATUwA0AG1tPAOBh8Pk2HeU29t2pnfNPYSSyASzkXTcG6m67KP
	 LzdauePc5hAhkZZxVNZ/pdqfBZUVHE5xVdRJbt+tJOA1Z/qkkG0hpAp3pkfNQuzBDT
	 HNg64fX0usc3k1AaNHM71S1Q0PNKG4w87KJWT/Qx7YhNHa2z1/+DiOGIOilQOaQBkz
	 rTbaDHpyWz9DivAfYdObQOhvtCI+zmWTNsQ7+I7fr5STpt+gdOv2yaTkHd1R+MhNV5
	 i+Dgo1WggT/Jg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UP-00GsRS-AY;
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
Subject: [PATCH v2 05/13] PCI: apple: Dynamically allocate RID-to_SID bitmap
Date: Tue, 25 Mar 2025 10:26:02 +0000
Message-Id: <20250325102610.2073863-6-maz@kernel.org>
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

As we move towards supporting SoCs with varying RID-to-SID mapping
capabilities, turn the static SID tracking bitmap into a dynamically
allocated one. The current allocation size is still the same, but
that's about to change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 9c3103d0d1174..1f6c55e4b5d68 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -147,7 +147,7 @@ struct apple_pcie_port {
 	void __iomem		*base;
 	struct irq_domain	*domain;
 	struct list_head	entry;
-	DECLARE_BITMAP(sid_map, MAX_RID2SID);
+	unsigned long		*sid_map;
 	int			sid_map_sz;
 	int			idx;
 };
@@ -524,6 +524,10 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (!port)
 		return -ENOMEM;
 
+	port->sid_map = devm_bitmap_zalloc(pcie->dev, MAX_RID2SID, GFP_KERNEL);
+	if (!port->sid_map)
+		return -ENOMEM;
+
 	ret = of_property_read_u32_index(np, "reg", 0, &idx);
 	if (ret)
 		return ret;
-- 
2.39.2


