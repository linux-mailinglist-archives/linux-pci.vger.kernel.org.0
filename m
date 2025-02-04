Return-Path: <linux-pci+bounces-20685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066ABA26CA4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C604166AED
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68451206F0D;
	Tue,  4 Feb 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cxmzxd1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A562063D8;
	Tue,  4 Feb 2025 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654520; cv=none; b=hcNBXCVOsertZMY8W2RBzLz5CkuILxkuvkkPUCEIEGFQXn5CkgjK1yeifB+w43LPua5rLmWID/Cc9ogKDdmk+s9s6uxP4JrQNzQEudPAmOGlUZjQrPevFxckXzEdX9FUkRiFLvj92R/OwwyZXgp4OlKiW66XTAfVWZ+0+MPPxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654520; c=relaxed/simple;
	bh=aQTmqsYg4zzaDJRji9aqlWjSXghEmXNU3CBY2xcegJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuzBfIVvpcBj02Lf4iKIoQdy3uKCOvJ9sovk/aeW87cLFpPoi07eYJJf6B1BVU6rT8fpi4oS2Hn72MbDGl1YjiHkUOxmaCKrg+tjabIgmDrjNoYVbAZnqxOWpid015Z7gN7hgMxa53tj1zpXkzawr8PB8hEuV1j3+nrL3RS09IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cxmzxd1y; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3D38F4440A;
	Tue,  4 Feb 2025 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738654514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI9aiHv/12/f3NIcFxYC4k1Bz6f0d7w4zpDQLTo4OHo=;
	b=Cxmzxd1yT2r9H1X2hEFyQ9s5t+JDu26mDP9tfHu2DiDpW2Z8Nc/iGtUMWNzYvgWhrtz+Rs
	09rv5lg3HbvzNWox9Bag9UruXopbr8jTZQnq7MHlgnBt7zYw7cToGIGOjdgrXdJ9nXTm2s
	ytSGYPqNo53FXWk1Gi2oThlAgqvvqteM1o+gEMomlwRH1vormfvZCeUxLuN49MCbYSDiYd
	w9R4SC4HtCUnvcmDb6AsBE2KwvTTfCn9dkPsp76ZAmHtVERhGEWpAdYewK9NrqGl9sd7lA
	zLJtpkvGfKYgkLxpLBSj5TI7pUq9ryAMuSM2B6GrJq+7wJmnyzTp205nT9qveA==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Subject: [PATCH v7 3/5] PCI: of_property: Add support for NULL pdev in of_pci_set_address()
Date: Tue,  4 Feb 2025 08:34:58 +0100
Message-ID: <20250204073501.278248-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204073501.278248-1-herve.codina@bootlin.com>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffeigfejueelueeuffelueefgfelhfejhfehieegudekteeiledttdfhffekffenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
index 58fbafac7c6a..962d2e8cc095 100644
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
2.47.1


