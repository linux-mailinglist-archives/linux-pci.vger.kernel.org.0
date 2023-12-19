Return-Path: <linux-pci+bounces-1155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164F818164
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D161F22362
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2F179D0;
	Tue, 19 Dec 2023 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sneycZ7o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA281172A
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FTOErgdxyaFNCFTOEr8Mcu; Tue, 19 Dec 2023 07:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702966540;
	bh=hZ/ES4F8KlXsJDilo3/jjs0U5UzZt61FLBeAEIKEj20=;
	h=From:To:Cc:Subject:Date;
	b=sneycZ7o9WnonV42dK78Ae0TmwxUy/D7s6X1rtjZ+xnrFB+Ei3pau/1gu/jJP+AnH
	 JVMzR5+8h7QjbyAq2pPvmINJBh23C16O/yJKVswCw6XwkjieZ9ePfDS4BnAhxYYXER
	 RGC69CTXnsGJWy4k7iBA2u9YoYbQc3StWoCklQ9fkAoiwrbIcDpDlnNWTxbNKKoFGK
	 E/ZikTPxjPpOtGih3G20VCmgYLiqrTnMr4csN1V3uptr8isdJ2kEkOFwtbKq7wp2Nl
	 DYMNxhmCRpHIdSegqcAJOsUNXJ/NDkzM9a7ToECEyPWZoofe4dE0WMIr8Qtj3Kp8GM
	 HLjuiP0vsk0zw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 07:15:40 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] misc: pci_endpoint_test: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 07:15:37 +0100
Message-Id: <47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr>
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
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index af519088732d..34124bdce68c 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -860,7 +860,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, test);
 
-	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
 	if (id < 0) {
 		err = id;
 		dev_err(dev, "Unable to get id\n");
@@ -907,7 +907,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	kfree(test->name);
 
 err_ida_remove:
-	ida_simple_remove(&pci_endpoint_test_ida, id);
+	ida_free(&pci_endpoint_test_ida, id);
 
 err_iounmap:
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
@@ -943,7 +943,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
-	ida_simple_remove(&pci_endpoint_test_ida, id);
+	ida_free(&pci_endpoint_test_ida, id);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
-- 
2.34.1


