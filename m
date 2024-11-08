Return-Path: <linux-pci+bounces-16330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD69C1F68
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D9A1C22AF0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208031F5857;
	Fri,  8 Nov 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UdTNNBgb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D241EABA2;
	Fri,  8 Nov 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076571; cv=none; b=an3xWGH/JbDQjrHu+epiMZ/8k6TTHjPSpdkGrZml3RUcAZH/+ObkUVeBaMHSP18rNskD2Tu7RtQU1JVmAneLvdQd/G6QzK4U4tQi+NTCC6il8w4v8vHnMekJ0Vi5PtaMDbo4B7l8LVPfTSOT33fPRApSc1uT5Th+hkdU7YW48ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076571; c=relaxed/simple;
	bh=KbQcH2DUBO4XBFA/lTskG3ADO76dFxPNoXmfqDECx2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apkgkeU5zjNDtA1RYo279GjXSFfNZLmMpIFtkoOp/1FGGRnHIFDYKuFcnBM0uVaQOwU3RdlzxpNN/N9xRjCG3GpLHO00e9n0Vo7DmpYVljXcFO1od4VLDwubGtFy28hjo5S9z57v+TqFEdorQMTEns/2LzixojoHjcu7DIsmpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UdTNNBgb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id BA51F20002;
	Fri,  8 Nov 2024 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731076566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWUWbgIcwwkYpx2sGFB36arAHxZpqg+uUR07E7hW3jI=;
	b=UdTNNBgbzpcSv/Bb4gIeUvZkAIjcOcCmraY864z9PUzZCEy4upyj70UvLnqgj7eUkCaVq5
	0o1Uh0zPJo8QpvwUtFFhbKLDhCWtcMStFdPIIunkqOt8rQ5zBAUwA7uG76pNM1/VrrLEIb
	wzqxLr/fmWkVaOIbcCEdGg3uSTMlmxMW5VNtS73Y/fleR9NAfq6s/CmXti6FNK/6zQhC0+
	T8hgrlcluwiA4L9UUiCY9CL2GbehNIod7VWlpxS7f5C16XuQCZ5SM0ELpZ3OeivqX5GwyG
	Xu1vF6me6lPNLX3tOVu7nx4L3UWYn7Wnu0dvOYHS0XpqK3ur1Xn77NFkDZpJlA==
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
Subject: [PATCH v2 3/6] PCI: of_property: Add support for NULL pdev in of_pci_set_address()
Date: Fri,  8 Nov 2024 15:35:56 +0100
Message-ID: <20241108143600.756224-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241108143600.756224-1-herve.codina@bootlin.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
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
2.46.2


