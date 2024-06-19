Return-Path: <linux-pci+bounces-8967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04590E821
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E48B223E5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5013211D;
	Wed, 19 Jun 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W5M4wPOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E875817;
	Wed, 19 Jun 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792137; cv=none; b=XMO/1xfHzNY8FaOudRP+xisGTdraYNtMaCoyFWYftD1atDOGl/DTMRTPXK8OEATS6Tg1grW5g51dBdJpSXbj7+5s0fTLu5uBjYvX2NXpAQhAEYyvA/L7A7IrHz88iQbndd45sXvtOBeEC+MF/v1TaQADcg0Lf0vkjSNGRl/+FYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792137; c=relaxed/simple;
	bh=D/mIw5PQXaVybV8q1M5tT5irn19bOqE7/C1r84b60EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8Nq9P1iNpbjrsfb8nVsDcv4yhLVByQCMF5LGsc9CzPx9FLEWHxYqJJwmHGI7b2NzNNoE7EzFCQ3UErrUBLlxDvdqbWsLtYzjG6ecH3q1ZIMTb20l8266y156gxUW57o1da6HNS6zEWJNL+0BArxUftgXVjod9JZzcxdQCgmO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W5M4wPOX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE3D0E000A;
	Wed, 19 Jun 2024 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAhWJDZy3Qxtd03byX/QomLU+QUbXtxsEhEbMTufqk0=;
	b=W5M4wPOXWxOTLOEwAxHu+CTCxE2tA8n6ghR599ny1MnK3w514SNIcnwA5EEbMN3NEEatTI
	EUbF9ciieffB7yv0dWv+Cw4bFRdMjU/VK2TVwGGEPiXGKTnbOuG1LY3fimmMiWICAGbaja
	I4onZNFEkyiIDafeOs//GLnKRjxxlWX8AgV6rOJ0ZRwSlnUxjbaSqlPv5BeiOCelKVlgcq
	6t0z7FIIjqXyILsZWfW8I91CbaC+rTGQUkoWM3NWrgeG49VoCV1eAj8D6TvKmcIx0BUuUt
	DIm7Hn05lP2AJG4vlJ+QW23u8Jdhbty0U3yhnbsP7p8c6ZCUpciNARdk/Itahg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 19 Jun 2024 12:15:12 +0200
Subject: [PATCH v7 4/7] PCI: j721e: Add reset GPIO to struct j721e_pcie
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240102-j7200-pcie-s2r-v7-4-a2f9156da6c3@bootlin.com>
References: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

From: Théo Lebrun <theo.lebrun@bootlin.com>

Add reset GPIO to struct j721e_pcie, so it can be used at suspend and
resume stages.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 98484f001562..9af4fd64c1f9 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -52,6 +52,7 @@ struct j721e_pcie {
 	u32			mode;
 	u32			num_lanes;
 	u32			max_lanes;
+	struct gpio_desc	*reset_gpio;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
@@ -508,6 +509,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			ret = dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
+		pcie->reset_gpio = gpiod;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
 		if (ret) {

-- 
2.39.2


