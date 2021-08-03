Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0161F3DEA35
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 12:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhHCKCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhHCKCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 06:02:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FBC0613D5
        for <linux-pci@vger.kernel.org>; Tue,  3 Aug 2021 03:01:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArFF-0002yK-1Z; Tue, 03 Aug 2021 12:01:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArFB-0006FC-Q0; Tue, 03 Aug 2021 12:01:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mArFB-0002mx-P3; Tue, 03 Aug 2021 12:01:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 3/6] xen/pci: Drop some checks that are always true
Date:   Tue,  3 Aug 2021 12:01:47 +0200
Message-Id: <20210803100150.1543597-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803100150.1543597-1-u.kleine-koenig@pengutronix.de>
References: <20210803100150.1543597-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=7QOFRnoxyPrPqaGt2Yf8oJvx3xwgCvlMdm130sPrxr8=; m=ojqh7TeVkHwpwgO0APbKXx7TaW1tocUcc4q06uRihVU=; p=Til3JjZD0R4gplASRUa5Gvns+JXDZlmvpK9q4VqFRVc=; g=9e481f95a51887868b05f8a86c3e5a9f8aff47c6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEJE/4ACgkQwfwUeK3K7AmCWwgAj7/ c9kaXIx6z27810hsxjtVlPEhRfsu4sbg9ayL550B6MBEGBaCBGWgU5DWEuS2o904kSeiEhPX++yK1 1haqzK6dY6sn8vyszQRvBtq9CO8GUF6oZHjUOW2GnEAz1F7cbtIJCHypxfkUmcccbsa786DvxhKph lW0YxXeCEn0hb7bvwUi8yIWnjTXXnfEgoZ+3qF+8hFSdwIBZimeWLoc63O4TUGznfuSdbWMJi4Y0V lEGg9znKbGJO7kHuIevqk5V07oZOBlBWYh7OZqFPE8+l5Du12X6zR4e2VjK2NRNsvpniWfTRGWIU2 fUvCCg1pb/kU7QVIjQMOk4rFNEJRprQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcifront_common_process() has a check at the start that exits early if
pcidev or pdidev->driver are NULL. So simplify the following code by not
checking these two again.

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

