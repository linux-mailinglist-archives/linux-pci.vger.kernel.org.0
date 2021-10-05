Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC642228D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhJEJos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 05:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 05:44:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC64C061745
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 02:42:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXgyJ-0005om-RZ; Tue, 05 Oct 2021 11:42:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXgyH-0002N7-SZ; Tue, 05 Oct 2021 11:42:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mXgyH-0005Tq-Ra; Tue, 05 Oct 2021 11:42:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Drop redundant driver member from struct pci_epf
Date:   Tue,  5 Oct 2021 11:42:43 +0200
Message-Id: <20211005094243.2335788-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=+i0CHBFk9kJKBpDE2cwaBEnMi2EEXZ+BzHb2Kba5SlU=; m=tfXR0B3dkdz8u5ElvImtkK9qyWIH6Vz5MIAy6S/e8YQ=; p=nmChWLZhx/Kt8NycFU/7wVcNOOm2iVuXDFoN0v03CHI=; g=1d5d56f36602d4f429b013044a4c3967baffcc81
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFcHgsACgkQwfwUeK3K7AneIggAnkG e3ypEerleJ3hV4HF5B8OLvS8xHXjM2DGArMcTpWlj3Xxh8IExmcz8CPcTZUL3/xSdCkczoqjGRnEE u69oFkX9JuFOl1imxtJGmIq2lvSIYYgoDNINHcfk/REGXxEE/3ypHB14mlJQl9sMy7zetUyqK6E9N Zj8m6Pw0AGw2vUgDEWjmsnl61w2EXGIvJg5NAWzB2EA66UYA/dNE/t2V4rhb4kE1Haf+Q9kit6ehl kX1H0U8TU36CLVLOWv0npGigTaKseXx/F661WO7wwPZsSfuaf9JPJS+1P8F4g7y2MPM7U435kqBKI pM1D+0r2IiQ9PyY+qjMNyyiW7oTnYgg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

driver tracks (apart from a constant offset) the same data as dev.driver.
So drop the member and replace all users accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

 drivers/pci/endpoint/pci-epf-core.c | 37 +++++++++++++++++------------
 include/linux/pci-epf.h             |  1 -
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8aea16380870..b0d746479564 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -35,17 +35,19 @@ struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 					  struct config_group *group)
 {
 	struct config_group *epf_type_group;
+	struct pci_epf_driver *epf_driver;
 
-	if (!epf->driver) {
+	if (!epf->dev.driver) {
 		dev_err(&epf->dev, "epf device not bound to driver\n");
 		return NULL;
 	}
 
-	if (!epf->driver->ops->add_cfs)
+	epf_driver = to_pci_epf_driver(epf->dev.driver);
+	if (!epf_driver->ops->add_cfs)
 		return NULL;
 
 	mutex_lock(&epf->lock);
-	epf_type_group = epf->driver->ops->add_cfs(epf, group);
+	epf_type_group = epf_driver->ops->add_cfs(epf, group);
 	mutex_unlock(&epf->lock);
 
 	return epf_type_group;
@@ -63,21 +65,25 @@ EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
 void pci_epf_unbind(struct pci_epf *epf)
 {
 	struct pci_epf *epf_vf;
+	struct pci_epf_driver *epf_driver;
 
-	if (!epf->driver) {
+	if (!epf->dev.driver) {
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
 		return;
 	}
 
 	mutex_lock(&epf->lock);
 	list_for_each_entry(epf_vf, &epf->pci_vepf, list) {
-		if (epf_vf->is_bound)
-			epf_vf->driver->ops->unbind(epf_vf);
+		if (epf_vf->is_bound) {
+			epf_driver = to_pci_epf_driver(epf_vf->dev.driver);
+			epf_driver->ops->unbind(epf_vf);
+		}
 	}
+	epf_driver = to_pci_epf_driver(epf->dev.driver);
 	if (epf->is_bound)
-		epf->driver->ops->unbind(epf);
+		epf_driver->ops->unbind(epf);
 	mutex_unlock(&epf->lock);
-	module_put(epf->driver->owner);
+	module_put(epf_driver->owner);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unbind);
 
@@ -94,18 +100,21 @@ int pci_epf_bind(struct pci_epf *epf)
 	struct pci_epf *epf_vf;
 	u8 func_no, vfunc_no;
 	struct pci_epc *epc;
+	struct pci_epf_driver *epf_driver;
 	int ret;
 
-	if (!epf->driver) {
+	if (!epf->dev.driver) {
 		dev_WARN(dev, "epf device not bound to driver\n");
 		return -EINVAL;
 	}
 
-	if (!try_module_get(epf->driver->owner))
+	epf_driver = to_pci_epf_driver(epf->dev.driver);
+	if (!try_module_get(epf_driver->owner))
 		return -EAGAIN;
 
 	mutex_lock(&epf->lock);
 	list_for_each_entry(epf_vf, &epf->pci_vepf, list) {
+		struct pci_epf_driver *epf_vf_driver;
 		vfunc_no = epf_vf->vfunc_no;
 
 		if (vfunc_no < 1) {
@@ -152,13 +161,14 @@ int pci_epf_bind(struct pci_epf *epf)
 		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
 		epf_vf->epc = epf->epc;
 		epf_vf->sec_epc = epf->sec_epc;
-		ret = epf_vf->driver->ops->bind(epf_vf);
+		epf_vf_driver = to_pci_epf_driver(epf_vf->dev.driver);
+		ret = epf_vf_driver->ops->bind(epf_vf);
 		if (ret)
 			goto ret;
 		epf_vf->is_bound = true;
 	}
 
-	ret = epf->driver->ops->bind(epf);
+	ret = epf_driver->ops->bind(epf);
 	if (ret)
 		goto ret;
 	epf->is_bound = true;
@@ -524,8 +534,6 @@ static int pci_epf_device_probe(struct device *dev)
 	if (!driver->probe)
 		return -ENODEV;
 
-	epf->driver = driver;
-
 	return driver->probe(epf);
 }
 
@@ -536,7 +544,6 @@ static void pci_epf_device_remove(struct device *dev)
 
 	if (driver->remove)
 		driver->remove(epf);
-	epf->driver = NULL;
 }
 
 static struct bus_type pci_epf_bus_type = {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 009a07147c61..bcd6b34d2321 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,7 +152,6 @@ struct pci_epf {
 
 	struct pci_epc		*epc;
 	struct pci_epf		*epf_pf;
-	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
 	/* mutex to protect against concurrent access of pci_epf_ops */
-- 
2.30.2

