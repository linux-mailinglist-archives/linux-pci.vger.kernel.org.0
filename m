Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D99D6E2E9D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 04:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDOCfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 22:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDOCfu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 22:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D318419B9
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 19:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 524A761752
        for <linux-pci@vger.kernel.org>; Sat, 15 Apr 2023 02:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55746C4339E;
        Sat, 15 Apr 2023 02:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681526148;
        bh=STEpOTUiWA9Er4cFutlf6WB7CTLqxWETo8V9g6vrMD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aiq9iL4xM6R2nfiXAIEXOxiiyr2xTSjaPYaF8/fPSjKLZfgogEaJP0v6F4B3IXcnr
         Zi89nnFjosO03WYPW4HmFbCyr3RLZ86MhXT+Uj0KpRpXJANeks6neK55z0N0KdrggZ
         JFCchE13e+td+4GK+B9bBLuH+/DO9p0dvMmPb9m5Hx/4qbnCaaaY8JoqY8trjjeJfz
         t3tNTBWaWQJfLelbNW+/o6dH9YjDaNtouwTtecjvW3PmeGOvLfiCdglwyRGOU0j6u5
         tgL4A4TqPgRwinzBCGIR2l78WheUPegESLNYFjIpK5lPbnLGuCdxNf8mA7kIVSvmmR
         zyxWHsLt46OZQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 02/17] PCI: endpoint: Move pci_epf_type_add_cfs() code
Date:   Sat, 15 Apr 2023 11:35:27 +0900
Message-Id: <20230415023542.77601-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230415023542.77601-1-dlemoal@kernel.org>
References: <20230415023542.77601-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export this
function and we can move its code from pci-epf-core.c to pci-ep-cfs.c
as a static function.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 20 ++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c | 32 -----------------------------
 include/linux/pci-epf.h             |  2 --
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index e255a8415bd5..0fb6c376166f 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -509,6 +509,26 @@ static const struct config_item_type pci_epf_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
+						 struct config_group *group)
+{
+	struct config_group *epf_type_group;
+
+	if (!epf->driver) {
+		dev_err(&epf->dev, "epf device not bound to driver\n");
+		return NULL;
+	}
+
+	if (!epf->driver->ops->add_cfs)
+		return NULL;
+
+	mutex_lock(&epf->lock);
+	epf_type_group = epf->driver->ops->add_cfs(epf, group);
+	mutex_unlock(&epf->lock);
+
+	return epf_type_group;
+}
+
 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 {
 	struct config_group *group;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2036e38be093..355a6f56fcea 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -20,38 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
 static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
 
-/**
- * pci_epf_type_add_cfs() - Help function drivers to expose function specific
- *                          attributes in configfs
- * @epf: the EPF device that has to be configured using configfs
- * @group: the parent configfs group (corresponding to entries in
- *         pci_epf_device_id)
- *
- * Invoke to expose function specific attributes in configfs. If the function
- * driver does not have anything to expose (attributes configured by user),
- * return NULL.
- */
-struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
-					  struct config_group *group)
-{
-	struct config_group *epf_type_group;
-
-	if (!epf->driver) {
-		dev_err(&epf->dev, "epf device not bound to driver\n");
-		return NULL;
-	}
-
-	if (!epf->driver->ops->add_cfs)
-		return NULL;
-
-	mutex_lock(&epf->lock);
-	epf_type_group = epf->driver->ops->add_cfs(epf, group);
-	mutex_unlock(&epf->lock);
-
-	return epf_type_group;
-}
-EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
-
 /**
  * pci_epf_unbind() - Notify the function driver that the binding between the
  *		      EPF device and EPC device has been lost
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index a215dc8ce693..b8441db2fa52 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -214,8 +214,6 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
-					  struct config_group *group);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 #endif /* __LINUX_PCI_EPF_H */
-- 
2.39.2

