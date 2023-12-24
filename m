Return-Path: <linux-pci+bounces-1340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A955281DADA
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573AE1F2177F
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E2D15D0;
	Sun, 24 Dec 2023 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LK5l2y4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3A5663
	for <linux-pci@vger.kernel.org>; Sun, 24 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id HPUSr2aSJZnJmHPUSr5tZE; Sun, 24 Dec 2023 15:30:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703428207;
	bh=LCtL5kqOGRBMWH+JxDJBF0/eK646oThHjfyYVTS2Vzk=;
	h=From:To:Cc:Subject:Date;
	b=LK5l2y4U3Axg2/JMRLu9icqmznswmGIFSB4S0/gut7pJZcqDUZEi25IrWlcb2iMM8
	 hBR4amRZlOOHmQ1Pabna28V77wxnIr5UOKrWZ4X6mDblPKwMfkoHuzL1xdcy09n1Ge
	 yztFcOf8E/OebHBcKMDw1I+jKtftm1GBoRkgAxNNYAsKuIwpQzMCWywXTeXP6W31kN
	 1cD7I89jcZSt0kYulzu8+s6ocg5CQ2y1we9yEz7hNcdgbmO7xd9IY9iwSfjfXbcqpP
	 pR74S/khUj036xF4CXytondIlGjHxCQOozvV9YIB8K1cSEQORp+aJGUWOG7nMdUVEx
	 6TJU2gWI/WLVg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Dec 2023 15:30:07 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Daniel Stodden <dns@arista.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: switchtec: Fix an error handling path in switchtec_pci_probe()
Date: Sun, 24 Dec 2023 15:30:01 +0100
Message-Id: <01446d2ccb91a578239915812f2b7dfbeb2882af.1703428183.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in Fixes changed the logic on how resources are released and
introduced a new switchtec_exit_pci() that need to be called explicitly in
order to undo a corresponding switchtec_init_pci().

This was done in the remove function, but not in the probe.

Fix the probe now.

Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pci/switch/switchtec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 1804794d0e68..5a4adf6c04cf 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1672,7 +1672,7 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 	rc = switchtec_init_isr(stdev);
 	if (rc) {
 		dev_err(&stdev->dev, "failed to init isr.\n");
-		goto err_put;
+		goto err_exit_pci;
 	}
 
 	iowrite32(SWITCHTEC_EVENT_CLEAR |
@@ -1693,6 +1693,8 @@ static int switchtec_pci_probe(struct pci_dev *pdev,
 
 err_devadd:
 	stdev_kill(stdev);
+err_exit_pci:
+	switchtec_exit_pci(stdev);
 err_put:
 	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	put_device(&stdev->dev);
-- 
2.34.1


