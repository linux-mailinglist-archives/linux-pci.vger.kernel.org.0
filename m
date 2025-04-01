Return-Path: <linux-pci+bounces-25046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFCA77777
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E71F7A37A5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C01EEA5F;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaGNuz7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC11EEA31;
	Tue,  1 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499058; cv=none; b=ssa+MVOLTfWTu559uCb13IlPHKX1ZWMURfOt15Jn/Lh3Bqdex1Rwrfr+5ygM8QiUc+zn+h7BqJeaxPMzr4wm64LpVhhYvZZtB/Yw7NWaSN3vJuF4WzYGihYMh6iWJ3cyFlORFR8S8amHqFQYPJl0hGR0bZsa+FJKtH11DuXF6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499058; c=relaxed/simple;
	bh=1hPsF6LzL9OEaMMQAXlo5EkJ4jLQYjnYIgkfLxP1je8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DublpJSrz5ZUfGGrTsyIaNGhmcg+nPBeKXnb+6uZINmxZCBIqmovXvOprPznvoigbXzAZ0ca/86aKtpkxOEj5PglqKdOi9c47L1OUuUswypWHQhoXiC2F6gl2zWoDZqSvtR8qgXLYOeuhxBvXLWBOCnANlkROJi8K4CsKpUFmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaGNuz7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB218C4CEF3;
	Tue,  1 Apr 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743499058;
	bh=1hPsF6LzL9OEaMMQAXlo5EkJ4jLQYjnYIgkfLxP1je8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaGNuz7NTJx6hyndjZ4CWsw8+8TdZTvmkBjHvLWw0Ib7qWY/svdRIYeIRIJBvh2L4
	 LwMmDxudUB7Nj3jrnsiVjbcs+cB/lTrzyUEdNOGi6jk8Aw3T8XIOkNEVPYDneiPk0b
	 OdQib5VUFflGWPDjBqam2YLyG9Z1aA/SsX2qB9WWB6m17dMzIZemvidm0moxKIyFHF
	 /KbO2vBTd30GtMsCwMa6K7HjG9aHkop6rliP1obg00b9M4OT/3p6ut02vSqn6NAA1z
	 iquc8bxGgW9RHmTaLQukV7u8qXoEoQuF3E7KOQnHLIB9ZFzcQRa/dMm6sIPVUAoAZN
	 qB4Q7v9h76/CQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tzXkW-001GqU-5w;
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
Subject: [PATCH v3 06/13] PCI: apple: Dynamically allocate RID-to_SID bitmap
Date: Tue,  1 Apr 2025 10:17:06 +0100
Message-Id: <20250401091713.2765724-7-maz@kernel.org>
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

As we move towards supporting SoCs with varying RID-to-SID mapping
capabilities, turn the static SID tracking bitmap into a dynamically
allocated one. The current allocation size is still the same, but
that's about to change.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index d07e488051290..6d3aa186d9c5f 100644
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


