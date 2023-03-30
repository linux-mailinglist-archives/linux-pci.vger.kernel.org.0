Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8226CFF2F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3IyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjC3IyH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741265AC
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166445; x=1711702445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8/FKltNGowk82a8oQeUA1AG8yskCDoRScDUWbaQaEo=;
  b=pWzN2hHy1YjBwBjAM8zH10dOnvEbnD790FbtpQJ5dLJplUxBrlC6kinv
   YUsaRV01Sd+exQZLK31IZGYmMBN12FXKUZrN4KfE0NIWhtbACt6qQvKNJ
   o8Rhi3BFlp6jsE3m4jlzHXolK8Kr1ZabbD8dVzqRQFDbwu8kX1DJ/gARE
   pT29ESJHzvZVT/iDBDVVBFdzCED4vhDr68CAH0D+qqyCPpzvLCxXRJFq7
   n5BlU6hAX+yKT7dP5I1qcuoLEOWhqfeoPOaQhb8vVYbwWn3Y76/0YVzrC
   9oMq2KbMZ/UW7Q5uATRiKzrmxtohUTlxojyWZCPZpd/VaBfSQGhzeUoVu
   g==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:05 +0800
IronPort-SDR: NGwivpLgyiolLa2GuIH7p69skUQBTJVxTvelanxukG9hnXA/AgTTolMa91H38jPP1U9AUwGtRb
 NvO1DAXmox0vKv+b7l0kgSLOB+XdFL9ZfM0hwcyUEasvm1n3z6rs7Woov9x/HJ+JSISCQrlEcg
 7MmVooeLAzbNrwfV1jSORkJn+FoH1TPMjyQ9JffVotBUUJYO7ViZo9+PmSZAL38GX4xZa6Otp6
 xwyvCiWAufDnxiqwAuuzDpBuKcrjpPP3nnHiW6ZlQmMmr1jlTZ017EVzR3My7S5wBRHfM9UOSb
 2QI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:13 -0700
IronPort-SDR: YO8ts3LNpVZRMrn+pqoqECl5lWsiCRVbQ5SSbFISiJh9adsJ1ZuknCZXF+qODFGcIPr0f27FAl
 BkIYa7VGfUZRpRiagxGAjlQf8y84KEFhYIkhfnRqv7jd1fGHIf02HNpDxbSUQGmRBCWFD17XIc
 5xYs5W4HOWDF6FChkSlKO0iBrAXoLl0Azg+Qh/rmWIGOvo/lRebx8cXyAP52MgWkQaYF9adG16
 fGFd/SpdfeBWts7PiJbHKUZVqkqhwB+lhYyluw5GgBTjvpJfqgmdlXn/sOB/b2Mvzw8DEt9Xpi
 exo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHK90Gnlz1RtVq
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1680166444; x=1682758445; bh=t8/FKltNGowk82a8oQ
        eUA1AG8yskCDoRScDUWbaQaEo=; b=MRJfVo4vQsSE2YLem8E5k1RL/TBwCjOkAX
        OCdIMbuay9mt7rPW525Rhqn6B/AWLIpM/9EojxhGr4JwzwyN8AwcvisUWdTrdBoW
        hK++7J/FA3ryahAuzlpQIz4EyK5dt7wRXIESvYUVeOEe4vZM0OZWW6LNNuFOR3m7
        qjH75zonjgF6xz4ow3hpwWT6vrBHTjQMorsaoDOMYDUdVcRh5FkpaLCTHUAdAddw
        DMupUd3Sj0zjO54DL4esJPcgwZqRVAQus+DsKPWPbl08DA9tcr1P1o6ZfWnZBiLZ
        59SwQibNsdtNY9FCYggSe7ZDRYKEDAejxineZYsJc/9/cynjzjaw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id frXFfXjLAx7B for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:04 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHK62hRFz1RtVm;
        Thu, 30 Mar 2023 01:54:02 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 02/17] PCI: endpoint: Move pci_epf_type_add_cfs() code
Date:   Thu, 30 Mar 2023 17:53:42 +0900
Message-Id: <20230330085357.2653599-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c   | 20 ++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c | 32 -----------------------------
 include/linux/pci-epf.h             |  2 --
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci=
-ep-cfs.c
index b16fc6093c20..3a05e9b5a4e9 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -509,6 +509,26 @@ static const struct config_item_type pci_epf_type =3D=
 {
 	.ct_owner	=3D THIS_MODULE,
 };
=20
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
+	epf_type_group =3D epf->driver->ops->add_cfs(epf, group);
+	mutex_unlock(&epf->lock);
+
+	return epf_type_group;
+}
+
 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 {
 	struct config_group *group;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/p=
ci-epf-core.c
index 2036e38be093..355a6f56fcea 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -20,38 +20,6 @@ static DEFINE_MUTEX(pci_epf_mutex);
 static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
=20
-/**
- * pci_epf_type_add_cfs() - Help function drivers to expose function spe=
cific
- *                          attributes in configfs
- * @epf: the EPF device that has to be configured using configfs
- * @group: the parent configfs group (corresponding to entries in
- *         pci_epf_device_id)
- *
- * Invoke to expose function specific attributes in configfs. If the fun=
ction
- * driver does not have anything to expose (attributes configured by use=
r),
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
-	epf_type_group =3D epf->driver->ops->add_cfs(epf, group);
-	mutex_unlock(&epf->lock);
-
-	return epf_type_group;
-}
-EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
-
 /**
  * pci_epf_unbind() - Notify the function driver that the binding betwee=
n the
  *		      EPF device and EPC device has been lost
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index a215dc8ce693..b8441db2fa52 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -214,8 +214,6 @@ void pci_epf_free_space(struct pci_epf *epf, void *ad=
dr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
-struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
-					  struct config_group *group);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
 void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)=
;
 #endif /* __LINUX_PCI_EPF_H */
--=20
2.39.2

