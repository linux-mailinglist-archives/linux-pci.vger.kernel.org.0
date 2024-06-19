Return-Path: <linux-pci+bounces-8969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25290E825
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DED1C21CF3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB413AA44;
	Wed, 19 Jun 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J1hAsWDF"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3A12FB34;
	Wed, 19 Jun 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792139; cv=none; b=THgLSvt1uAfLk7xaX8e+9brhJZwsmxNtOIxoBULPpiL1tIXHYQvyBJNxS95Spign6+A2oavxrhaqSWfMf1xXEA+4OugrShsiRvSJvYnZzI7/ozUTRgNrZhXCOeAOfOvJ5qMiChmJZzy8zHFvNcLtUsPpBKWFuDXjLA25lpk7if0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792139; c=relaxed/simple;
	bh=SKxnqxqQTOu0V80tOrHg0VWiV3r/5d05UFM/bBwvo2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwkJp0EzLBJAe/1g2OU6qGLFOD0dD+lrG6LHmcu8RiE2FJ/S85O7aYysQNTP3ivjwfnjs7VxvfAgxOzZJtreWjiy1fAMMI7VBbuklbfZk5pvaUQFocgMd/Wc7xusIDF3WGokpX0pNdEn2VRFZXaWJJTt32dpD2LP9CcpCHW2gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J1hAsWDF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B636E000F;
	Wed, 19 Jun 2024 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lu3hCWyQRXgdKfpiur37ixVeu1808uQZIfDP+sU8AMA=;
	b=J1hAsWDFqj+7ynRLDYFZGgLl95GcBS4OeQOfOs440ZlyXo/f6+U2u/VlmzOeQ9tEmCuIaH
	yfQjkSrlXtLQCHcyjZoSQSsfH8PJriPGjdubJSAEhrNdfLYZkzHiAJMjUMPCQ2BPSJWQWP
	MOX7rjPdlAOi+bO7Iiq7Z4jX9wrmq3pH8lwWzQmQXV07R8Bw9Ee7WRCJl1bCdzsUuQdevK
	SPaq2ZRtLTCyefjE4Aaoo1zWefU9zXwUcxS9RQCpR8pmDcfMlopoetZbYM1yaWYXrV6n7y
	JbKG9FmA7bCumiGCS+KdY0dcQHGFcCjFCx0cz/JN1t+lQLYIVxV6HLXnHfPnZQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 19 Jun 2024 12:15:14 +0200
Subject: [PATCH v7 6/7] PCI: j721e: Use T_PERST_CLK_US macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-j7200-pcie-s2r-v7-6-a2f9156da6c3@bootlin.com>
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

Use the T_PERST_CLK_US macro, and the fsleep() function instead of
usleep_range().

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 9af4fd64c1f9..967a5bf38e26 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -539,7 +539,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * after 100 us.
 		 */
 		if (gpiod) {
-			usleep_range(100, 200);
+			fsleep(PCIE_T_PERST_CLK_US);
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 

-- 
2.39.2


