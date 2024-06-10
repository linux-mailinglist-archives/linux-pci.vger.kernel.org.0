Return-Path: <linux-pci+bounces-8510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACE901CD0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 10:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE933B2479E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DCE61FDD;
	Mon, 10 Jun 2024 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pj7IFzhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8B5FBB1;
	Mon, 10 Jun 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007617; cv=none; b=gP9HgN1bgb0b48mqP8pIIWDwejTU1DgK0wf64XEXC9IaHvyansvdKHgUE1wPocFH1QXn9Z6Xd+l5abfjt2cd1RIEaw//sI60tOq71SnfnEuezghIHfwphkQz/6wcHpL7PLUTuHkYqP2T4F/5HAQYvFkr8BZYhp0BvltqqxEFoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007617; c=relaxed/simple;
	bh=5VmHzrPdC/CIGGKylU0d9hH6o72bK54XNQDQJIirotE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JVXLVyqbafXeH23AI5DRkILi67Tn1m0YTSF/Nvq9zHtzopnXtaouwx1iQFHyUXxh06NGolEsJjt/WabNurHGBogyT7lrdIgmAl2DBXissFxv48ngcALk10Kolye2zxEr0POrVj/YHe7NGrLP6j7cvkfQvoK4VYcCeGFRz4akkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pj7IFzhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1DAC2BBFC;
	Mon, 10 Jun 2024 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718007616;
	bh=5VmHzrPdC/CIGGKylU0d9hH6o72bK54XNQDQJIirotE=;
	h=From:To:Cc:Subject:Date:From;
	b=pj7IFzhJOdf4S5BJSMuPtAAJdqLMuLQ4mVKIBMBOMlsyZwnKzF20RX97zqRiGxWAF
	 qBNVSCWgN8d+nei52/EI/LCCZJTexkJfSdXphhuhFd0h9EOGYhg5EKa6ekC699urnM
	 CwOTYFlBZOrVn33Kfap1yd1xJ9H4Cu5CGtSTnnr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: make pci_epc_class constant
Date: Mon, 10 Jun 2024 10:20:12 +0200
Message-ID: <2024061011-citable-herbicide-1095@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 74
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=5VmHzrPdC/CIGGKylU0d9hH6o72bK54XNQDQJIirotE=; b=owGbwMvMwCRo6H6F97bub03G02pJDGlp2633nuvS1ktzDV3P/1xjbfihlLY9OqH+cyPLrq2p5 z/66OObjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIN36GBVMM+/O8X/jduvG6 aGEE15IOzbRNDxkWbC6dGXn0oGizK9NmFYVmA8+SusQvAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 47d27ec7439d..ed038dd77f83 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -14,7 +14,9 @@
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
 
-static struct class *pci_epc_class;
+static const struct class pci_epc_class = {
+	.name = "pci_epc",
+};
 
 static void devm_pci_epc_release(struct device *dev, void *res)
 {
@@ -60,7 +62,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	struct device *dev;
 	struct class_dev_iter iter;
 
-	class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
+	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
 		if (strcmp(epc_name, dev_name(dev)))
 			continue;
@@ -867,7 +869,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	INIT_LIST_HEAD(&epc->pci_epf);
 
 	device_initialize(&epc->dev);
-	epc->dev.class = pci_epc_class;
+	epc->dev.class = &pci_epc_class;
 	epc->dev.parent = dev;
 	epc->dev.release = pci_epc_release;
 	epc->ops = ops;
@@ -927,20 +929,13 @@ EXPORT_SYMBOL_GPL(__devm_pci_epc_create);
 
 static int __init pci_epc_init(void)
 {
-	pci_epc_class = class_create("pci_epc");
-	if (IS_ERR(pci_epc_class)) {
-		pr_err("failed to create pci epc class --> %ld\n",
-		       PTR_ERR(pci_epc_class));
-		return PTR_ERR(pci_epc_class);
-	}
-
-	return 0;
+	return class_register(&pci_epc_class);
 }
 module_init(pci_epc_init);
 
 static void __exit pci_epc_exit(void)
 {
-	class_destroy(pci_epc_class);
+	class_unregister(&pci_epc_class);
 }
 module_exit(pci_epc_exit);
 
-- 
2.45.2


