Return-Path: <linux-pci+bounces-1154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5E818159
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 07:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78658284207
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E726FAE;
	Tue, 19 Dec 2023 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l4sNEkA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85DBBE79
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FTIhr2VyFBU01FTIirj4Uz; Tue, 19 Dec 2023 07:09:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702966198;
	bh=KTpDymoJN4gJQumbzCdvVykjTutbaVEe/yWH87l7ENk=;
	h=From:To:Cc:Subject:Date;
	b=l4sNEkA+xYvOVabsBHk5M0V29A4uXKj/0Sg02aRcWKjiQPusnJVoVkEQnl31zJhC1
	 1kuD5X4u/bdZgbo3J/2l+b2n2FIV25CUYmI2Mg7gyf3MYVUWRz/nHOlXmh16IneGE1
	 woS7spuhSBnaRrQF1/L85iKji1QV6Ohsw//Mx3Y/TNE7s2ZCCYIEaAHmfbC4zVTBe/
	 MpyyG9ivIqPulDzIUiAR2cL0+/2wXqUrrOxUFnbaZa75PvGxsT71I5ZIdlfS1FT4rt
	 mXG9GWNvnUQQiX/3pmrjmTX7dItovt2Tfr95ZIKGflzxJlFEHNizqOX5BkTIuCKzlf
	 0gaHpwJ69r0uA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 07:09:58 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pci@vger.kernel.org
Subject: [PATCH] dw-xdata: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 07:09:54 +0100
Message-Id: <cc01721cec2d416d7bdf47086943b17ef44b7286.1702966181.git.christophe.jaillet@wanadoo.fr>
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
 drivers/misc/dw-xdata-pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
index 257c25da5199..efd0ca8cc925 100644
--- a/drivers/misc/dw-xdata-pcie.c
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -333,7 +333,7 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 
 	dw->pdev = pdev;
 
-	id = ida_simple_get(&xdata_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&xdata_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(dev, "xData: unable to get id\n");
 		return id;
@@ -377,7 +377,7 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 	kfree(dw->misc_dev.name);
 
 err_ida_remove:
-	ida_simple_remove(&xdata_ida, id);
+	ida_free(&xdata_ida, id);
 
 	return err;
 }
@@ -396,7 +396,7 @@ static void dw_xdata_pcie_remove(struct pci_dev *pdev)
 	dw_xdata_stop(dw);
 	misc_deregister(&dw->misc_dev);
 	kfree(dw->misc_dev.name);
-	ida_simple_remove(&xdata_ida, id);
+	ida_free(&xdata_ida, id);
 }
 
 static const struct pci_device_id dw_xdata_pcie_id_table[] = {
-- 
2.34.1


