Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369243E8B79
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhHKIJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbhHKIHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:07:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B43C061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 01:06:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG6-0000zh-9A; Wed, 11 Aug 2021 10:06:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG5-0000OB-5K; Wed, 11 Aug 2021 10:06:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mDjG5-0002wh-4P; Wed, 11 Aug 2021 10:06:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>, Boris@pengutronix.de,
        Ostrovsky@pengutronix.de
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 3/8] xen/pci: Drop some checks that are always true
Date:   Wed, 11 Aug 2021 10:06:32 +0200
Message-Id: <20210811080637.2596434-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=7QOFRnoxyPrPqaGt2Yf8oJvx3xwgCvlMdm130sPrxr8=; m=x3vELWNXjEah0gYLjnvM6zhfaeO5LCDavCLWyKd6EK4=; p=Til3JjZD0R4gplASRUa5Gvns+JXDZlmvpK9q4VqFRVc=; g=9e481f95a51887868b05f8a86c3e5a9f8aff47c6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEThOAACgkQwfwUeK3K7AmWjAf+Msc bvqkjaf8mL2/M6ANSiLWNl8v7kI3XhMkjUB9i/z1yiAlF/pG8m42t+Y4ebuuazALef0bsgk42Fga5 Z7SW+ZUl5pjF4CFlPWdfXIIqUYasEZbKzpWWEUx5iHMKcyyBg/ZbhidiWnz5fOw6kXurdHKAQvHd+ 4azeh0eVATT8eiGZIoAc/t6NDam/1A5b3UhFowMvD9zNFsKPPSSygYxDz8+CuaAllPg0o+hNNEV1i i4Czfhn0CmLB3Ck2SSaIFIa2hlakS1TLlwgX80r+7PJ3CnsiTa4wTa6DexiKZfTWJyxVTFYti5eMf SCfWGE8OP5bqow5QdJB24RQWrTTbIQw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Cc: linux-pci@vger.kernel.org, kernel@pengutronix.de, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org

pcifront_common_process() has a check at the start that exits early if
pcidev or pdidev->driver are NULL. So simplify the following code by not
checking these two again.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/xen-pcifront.c | 57 +++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index b7a8f3a1921f..3c648e6cb8f8 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -591,7 +591,6 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	int devfn = pdev->sh_info->aer_op.devfn;
 	int domain = pdev->sh_info->aer_op.domain;
 	struct pci_dev *pcidev;
-	int flag = 0;
 
 	dev_dbg(&pdev->xdev->dev,
 		"pcifront AER process: cmd %x (bus:%x, devfn%x)",
@@ -606,40 +605,34 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	}
 	pdrv = pcidev->driver;
 
-	if (pdrv) {
-		if (pdrv->err_handler && pdrv->err_handler->error_detected) {
-			pci_dbg(pcidev, "trying to call AER service\n");
-			if (pcidev) {
-				flag = 1;
-				switch (cmd) {
-				case XEN_PCI_OP_aer_detected:
-					result = pdrv->err_handler->
-						 error_detected(pcidev, state);
-					break;
-				case XEN_PCI_OP_aer_mmio:
-					result = pdrv->err_handler->
-						 mmio_enabled(pcidev);
-					break;
-				case XEN_PCI_OP_aer_slotreset:
-					result = pdrv->err_handler->
-						 slot_reset(pcidev);
-					break;
-				case XEN_PCI_OP_aer_resume:
-					pdrv->err_handler->resume(pcidev);
-					break;
-				default:
-					dev_err(&pdev->xdev->dev,
-						"bad request in aer recovery "
-						"operation!\n");
-
-				}
-			}
+	if (pdrv->err_handler && pdrv->err_handler->error_detected) {
+		pci_dbg(pcidev, "trying to call AER service\n");
+		switch (cmd) {
+		case XEN_PCI_OP_aer_detected:
+			result = pdrv->err_handler->
+				 error_detected(pcidev, state);
+			break;
+		case XEN_PCI_OP_aer_mmio:
+			result = pdrv->err_handler->
+				 mmio_enabled(pcidev);
+			break;
+		case XEN_PCI_OP_aer_slotreset:
+			result = pdrv->err_handler->
+				 slot_reset(pcidev);
+			break;
+		case XEN_PCI_OP_aer_resume:
+			pdrv->err_handler->resume(pcidev);
+			break;
+		default:
+			dev_err(&pdev->xdev->dev,
+				"bad request in aer recovery "
+				"operation!\n");
 		}
+
+		return result;
 	}
-	if (!flag)
-		result = PCI_ERS_RESULT_NONE;
 
-	return result;
+	return PCI_ERS_RESULT_NONE;
 }
 
 
-- 
2.30.2

