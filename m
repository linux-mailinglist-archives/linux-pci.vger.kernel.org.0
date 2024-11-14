Return-Path: <linux-pci+bounces-16785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 783189C9130
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4E5B3E7E0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A43C196C7B;
	Thu, 14 Nov 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q3YIq7E6"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FA18CC17;
	Thu, 14 Nov 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603305; cv=none; b=OnA/Oh/g4IAzRJdkDyz8twNo7VGb5pusctLDu/VymTc1MVQEICOBfoyUa6nWwOcWIIvkD7+ugduu30FypLWvlyN+JRX51FprzwC6/wl8EALuZ/m9nogfikKanrpiPSFK9mE6l+lpUIYwVB6wfutNXB7HS8bk7N/lP7oFG/qgFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603305; c=relaxed/simple;
	bh=y7UfqEIoih8giw2/xvN6zrV6STbUrwOt/eHmznTRb6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TohHYxx1vzdn6SMwmKwB6XJLP2eLEUHqas1dV5glf3PtlKrOB8KWxeai4YifZHn+TOGJXY9Z6BI79VAj5s8A9L8zFO+6LCxxHMpwtY9hkLiK2sF6tndcLeQE/mFNYghqOZfcpDwpxV5qFA4Wmt/jYMXuf1l5vOjd5p6gk/8Y0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q3YIq7E6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A5E18E0008;
	Thu, 14 Nov 2024 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYnZpR2PVcDtwerz6jVB6zxz6ALZiGsj9xwvZUhzrrY=;
	b=Q3YIq7E64KHvZceCfFBivPi2zyq06HIa6Ju60ZhAFWA1NCG9l2hYl6Bmq8GqOLFHKRkpXE
	QAA2kENSr/0nSuY5oLTFPdSH8ZZnNivmDWbSLMXNe+ngUABr38TC61Sm5tpCUuqG+yguOZ
	cA88jzANa7oV0vygqq5MZBT3zAsMBM4j8ya1S887wQTblM4Dahagy6odcktkl/pXYOczAU
	6QTSPjeFIiNu4fKyS2PW0aOW83Bp7psp5mdv4Fggz/pCCKaoTkzxmC6F6qaZiYZzsCKE+I
	5NI5T4ZIyxhvfiFHo/5AivoI9Oqoq2naqPzIhcDXfTay/wVOsgwbLOtT778QYw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 3/6] PCI: of_property: Add support for NULL pdev in of_pci_set_address()
Date: Thu, 14 Nov 2024 17:54:39 +0100
Message-ID: <20241114165446.611458-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114165446.611458-1-herve.codina@bootlin.com>
References: <20241114165446.611458-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The pdev (pointer to a struct pci_dev) parameter of of_pci_set_address()
cannot be NULL.

In order to reuse of_pci_set_address() when creating the PCI root bus
node, this function needs to support a NULL pdev parameter. Indeed, in
the case of the PCI root bus node creation, no pdev are available and
of_pci_set_address() will be used with the bridge windows.

Allow to call of_pci_set_address() with a NULL pdev.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 5a0b98e69795..59cc5c851fc3 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -54,9 +54,13 @@ enum of_pci_prop_compatible {
 static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 			       u32 reg_num, u32 flags, bool reloc)
 {
-	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
-		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
-		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	if (pdev)
+		prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+			  FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+			  FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	else
+		prop[0] = 0;
+
 	prop[0] |= flags | reg_num;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
-- 
2.47.0


