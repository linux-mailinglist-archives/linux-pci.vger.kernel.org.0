Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286CE6C8BF9
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjCYHCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCYHCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC591517B
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727754; x=1711263754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8/FKltNGowk82a8oQeUA1AG8yskCDoRScDUWbaQaEo=;
  b=Ycfy1rKaDs4kZ06CgQ5AlZs2Hv5Q3v6vGZHBTsHrdJnjVodQVhV4PqLa
   pxBWG8EkyvUL1JXNx5u20MXaSiWdVkhzKVu+V9syEO/NjA3X02daAxXf4
   BGOR+RDZ0Mj7WFrQP7kX7nD2QuPT38RvXHvaFFHdBv9fshQEm5QS5+zp6
   nkqgg9M3Gj/05JVTWlOScbRMIt34LX0QGH9tIR/y4jbQ2CJ9KbOVgazJl
   pTeVAOZl30cl+gXWhN0s7sG/il6AMjLuDpINHk2UKuJEDFEluf2ClXh/Z
   snCzw/R6TtMw7JaY788xzN4MzF+VsfEHujILvCXirk/OiAkExNxos4VCK
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756684"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:34 +0800
IronPort-SDR: fWxO0y98z2Ae93PZ/Lw9G+ESoGFMCDN/KH8G7Ioo4Nn2NybXLghkdhPGlP1mcUw76jZq6v2L3n
 eNxxmUU8CaRfb/zGNFl3vnxOd0cXTxygEy7dxkflMBmCCp/H8++js6i5yBx0mQRS1hhPhRXyq4
 bScL1BBofKzb6ZrYQFL/CzkiP+juKakPJC54raAn3UFXOoHRHpuyNTeQMQAwg0zq96bLBKuM1p
 PSmG4OzAEFtPENBwo5/M1vOuIvgGm/c7xbwa5c2iVj3f68UbGBm04EzwbVrx+JiO9HMmPZNsGt
 Y1g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:49 -0700
IronPort-SDR: MDHx7M06iZXo0qqp6908vV/KLik+iTDgtSfqEWTr4XyhQOehxAwCwoLHdp5IRBEU5FxE37cKZ9
 uYf5TM2mciP+Qj/noSqEAN/tQak0bCnFb7PIhxBDXV44deKcgUsZabbbO10qM3l2Fq/bPgCUw9
 N798FMM4l1+n2Kv1r341Chj9oC1h1VHu/kO4G56OPJBWvbROVCf7G8+FjuWr9bGXoVjduOAA8j
 XsO0DXoiv1jh2VkbV2x0C67FUAFdZKB/KMK64WldEL3t1uz4XNUu+YQl9BRmOJecfxZ8JsulFp
 k8E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94p3dqyz1RtW0
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679727753; x=1682319754; bh=t8/FKltNGowk82a8oQ
        eUA1AG8yskCDoRScDUWbaQaEo=; b=TM7myIhv9ZDWbEVA0HP56mwOKR1mKC7KMn
        2z22cdZkSR24IvUWnoUHPXA6QeQi7TEN6+7IJvqPpLiLjlKtxmSBXjPqgULHH1zT
        JHIYCjvLkzHHHkGNkq5y3yht10nlPcvw7VZ6SA15LPtKwVxeGy0bl3vsJsGXym60
        ddL0iO0O8iTq3Esm+ewH/Lj6d9GPEC+rTgNUgdmPiRKRfWNIAWbGTFvJA90qwn48
        bGCMpD0HVI6bjV+14RHzSwKltfFBcWoEA5n63OONMBnzTry2lHTzBq+UEGkF9mg0
        /HbkpWl3XHje++PaXhec7x7FRvN30rylA68/JpMu0+neLP6NZirQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uYiYi_yGn3Q5 for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:33 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94l4nq5z1RtVm;
        Sat, 25 Mar 2023 00:02:31 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 02/16] PCI: endpoint: Move pci_epf_type_add_cfs() code
Date:   Sat, 25 Mar 2023 16:02:12 +0900
Message-Id: <20230325070226.511323-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
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

