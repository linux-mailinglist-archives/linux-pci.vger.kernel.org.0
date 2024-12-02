Return-Path: <linux-pci+bounces-17526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45529E041F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB552B38510
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7A202F60;
	Mon,  2 Dec 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cqnB9xJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDD1FF5EF;
	Mon,  2 Dec 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145357; cv=none; b=YoQ5J636mDKJoH6ebQGKsDVvLTPb+3zu3BZL6JNuQD8TmexuqNvzUPaN7u6pDpdq56BNllSN8+VVT0TM2FS6dyWOnPCZx+ryv7/nzXlEndCVvdTSk/fjQhe90CFfIW+qiJ/s6jasQo3Cmrm/Cj3jOfYKIViNJp6ueqXCqGFxTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145357; c=relaxed/simple;
	bh=PloGdo8yWaAB0mEU1AiYQL4TycpKuip5XLuZ2Uy87RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNdfqHjrk3FyZ13XiM4g9xZnRZrEPRs8ICU/5uVUd8lnh5+DoaHYmZ7/jjZXEoBWeu/tdbQjXOESLJZc1pe19hzKAepPhL79OlMleRTH850y1ODeQ+v7FrHKQ6jqdK6huiv1j0EI6OV6+Jwo1P+BRA5o1a8ZAynLzuCq3UnC3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cqnB9xJK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8EF5BC0006;
	Mon,  2 Dec 2024 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733145347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU1Q5uwrUxslDSQGz6WRaqjWVuhawVTEJ7MmY7c/q20=;
	b=cqnB9xJKfCytEUibvgcliQS3DEHnBmfmtIxYGkLuFbIPNt4ShYzO70gzTdlfPqxrjFirV+
	PEllEyzZFX8vkxapC6Y/mOMccctqEtKV8kaoLFkzaCuGgnPAKpyXFFrT05BkyHsdWRHJ8I
	pOinkIKXUtFZh+VLeBKW0+1vieyhe8SIeByNOeLp03hOaOCpRbQdzhFe3vQVi+2PlTQBgJ
	3rJasvndZCBvvimlcdxrpiVI2C882I9Deu8NfXgmONQ9vhyNNq/yFQeJkiGpVYzmzFaJoE
	1KzNwMvVFL4bud3U6/L5djiugPRxdBgLrz4T4qxEkcGXWj634vUSRoxp77awQQ==
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
Subject: [PATCH v4 3/6] PCI: of_property: Add support for NULL pdev in of_pci_set_address()
Date: Mon,  2 Dec 2024 14:15:15 +0100
Message-ID: <20241202131522.142268-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202131522.142268-1-herve.codina@bootlin.com>
References: <20241202131522.142268-1-herve.codina@bootlin.com>
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
index 886c236e5de6..8aff9ca1f222 100644
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


