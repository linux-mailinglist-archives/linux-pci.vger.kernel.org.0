Return-Path: <linux-pci+bounces-20683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C9A26CA0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74D4166A09
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE62066C4;
	Tue,  4 Feb 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jndpBWda"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F7204C1D;
	Tue,  4 Feb 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654519; cv=none; b=u5P+medRJ+tIokSmRYU7IxyD5R0qX9gOR8I/zPNgvJ9E92nDU/DDiyVynfoM+7mXwJoftl7kTwtIAcovzNdKMZ6X3FlhOoUOpvuy2sJ4bhQagoc7vSuzOgp7L4pYJDNpyLGaKr30Y0zfAMLkTbt4qoxgHUDHLLrmfzYLk8SLpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654519; c=relaxed/simple;
	bh=2M503OvHvoRmWCpank1mJVuBmwGQs429DHHS9kKURYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obZZBMk/WBpLUPa3Vmb0v+MQl/09o6NlJWn/PsnG2iaGeC06N4y/FxARirZu6c1TE1AOjRYGpQ8ibN9qdwvcjWGSciKFIC1XtI9UVdLcXzA6DlhYLnBAtqLbkTWosxgjlgVJXV3VVkI5fkfKAefnffZIMJsrckil8fEjL+k107s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jndpBWda; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7344A44402;
	Tue,  4 Feb 2025 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738654514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiD8UramHvEcUARfSgVu7SkVw5gcFuebpD/DDan/ap8=;
	b=jndpBWdasbdVCWWTfVXW/szfj7rzjQLn0kzL8T4SsTmN+JWSTBxnAdAhRUfs+j/X9NV+fY
	DcbS3JU5QMNrORc2U8iwzPP9Imxj3n34vjpdO7TsdRBCdCPOzr280O8eaOB+ucbDTAmakJ
	IcDLQ7eZp8x1J7bVKbcIjJt1eOa+FLHgfEUAhyUUnWRYSEsI03Fd6l6LRrv2EuphsDsSJC
	aIAp3n0cApOIyyQrv4z+7R77YJSMRWTkhaGShpbAoihbHBooEZsLkxt3yRj16LpezXMdaS
	cuAm4DZXns+TaBILwNDf4LNh91Am3LdFqmSNQ9JrFVa6q/rsXUVlxqNGS7gNFw==
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
Subject: [PATCH v7 2/5] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Tue,  4 Feb 2025 08:34:57 +0100
Message-ID: <20250204073501.278248-3-herve.codina@bootlin.com>
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

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices. The newly created of_node is attached
to an existing device. This is done setting directly pdev->dev.of_node
in the code.

Even if pdev->dev.of_node cannot be previously set, this doesn't handle
the fwnode field of the struct device. Indeed, this field needs to be
set if it hasn't already been set.

device_{add,remove}_of_node() have been introduced to handle this case.

Use them instead of the direct setting.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d20..fb5e6da1ead0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -653,8 +653,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
-	pdev->dev.of_node = NULL;
 
+	device_remove_of_node(&pdev->dev);
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
 	of_node_put(np);
@@ -711,11 +711,18 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 		goto out_free_node;
 
 	np->data = cset;
-	pdev->dev.of_node = np;
+
+	ret = device_add_of_node(&pdev->dev, np);
+	if (ret)
+		goto out_revert_cset;
+
 	kfree(name);
 
 	return;
 
+out_revert_cset:
+	np->data = NULL;
+	of_changeset_revert(cset);
 out_free_node:
 	of_node_put(np);
 out_destroy_cset:
-- 
2.47.1


