Return-Path: <linux-pci+bounces-734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6580BC73
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B31B1C2042F
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD619BB6;
	Sun, 10 Dec 2023 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="s2eZNshY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D3FA
	for <linux-pci@vger.kernel.org>; Sun, 10 Dec 2023 09:50:11 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id CNwNr4gNwWblTCNwNrbUKc; Sun, 10 Dec 2023 18:50:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702230610;
	bh=HzZTGQuA0kr0qzhf9S/gzmjguN57sJaWf26PktWi9U4=;
	h=From:To:Cc:Subject:Date;
	b=s2eZNshYTi2b1eXXjtC1TXyhFurVyBUyFnpASCghE6xZzdQkacTO0gSetG+bHAMwD
	 GmbWPPMyGUzSOl98YCRa6qF3nOMDLpgz+TRyWu2SGI8v4UGoMbvAfxR76+62pXOPtM
	 PUvKS7UcyX1kdIUeNMk33quvsuptSz5xrX/YDOyD7apbb6wFtbN8o5faCStcgpj7mX
	 p+P9DxWPO+NGkbJRXHVmWc5DHX3QJrJcBRHzsxDTlPhhd03WlITdC6n4c/UJsxCJF/
	 pRieHQaY2FJblcUFaY+2gjI3twk9LYvFJRcVs8tvVa6lNPfrQJt/IoulMAxIZkKnDY
	 NG84iK8KS0gaQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:50:10 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 10 Dec 2023 18:50:03 +0100
Message-Id: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/controller/vmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94ba61fe1c44..00a4264711f1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -984,7 +984,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	vmd->dev = dev;
-	vmd->instance = ida_simple_get(&vmd_instance_ida, 0, 0, GFP_KERNEL);
+	vmd->instance = ida_alloc(&vmd_instance_ida, GFP_KERNEL);
 	if (vmd->instance < 0)
 		return vmd->instance;
 
@@ -1026,7 +1026,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 
  out_release_instance:
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 	return err;
 }
 
@@ -1048,7 +1048,7 @@ static void vmd_remove(struct pci_dev *dev)
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-	ida_simple_remove(&vmd_instance_ida, vmd->instance);
+	ida_free(&vmd_instance_ida, vmd->instance);
 }
 
 static void vmd_shutdown(struct pci_dev *dev)
-- 
2.34.1


