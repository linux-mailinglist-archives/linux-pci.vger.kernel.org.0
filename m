Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA06B0243
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCHJEY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCHJES (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:18 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E3B3729
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266216; x=1709802216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=83skHeTyuuHUEsf609nh/HewU5bhrZRbY23BMMXBCaI=;
  b=iBiCFl36iPoI1LSkXjM2oBIDVoRJkMQzNLPuUy7Ui3GiMuqvaKUylFGf
   Bl08GLoVRxV1pQg+7o8PqElEPln4nCxknvqe8Gm6ghXEohKdw4bCisb8Z
   p72kBg/TYvpwjaRSEPg01ucHfYGW0jMG0+ff2Hokw4b1YN0l9FAXCMvFJ
   oH9Qjv0ZYdkoHWvWvBbmmZrzAo2AHs/u0BwLfrrXSv6d/FySZzSDZ0GTZ
   kgEDTYj90XiSXDYl+GPtnaBlFaiA8fhalwtYAUd5VIxMzF49QsbhXmCqC
   D8ET1seuMTWV/KIxi7ES+Jt/7dyRoC2kxM0IYqocsKQutSPKDL//7OJ+Z
   g==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880540"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:21 +0800
IronPort-SDR: 7qSSh5MhhCZxxtW+INF+/N4HSe6/r7AYZv8DCPtXK6WBhzmKmpSgxl4UYtRS7k7kKCHeMw+l70
 220QKnHVTDR6xt7n3UXAnx4wvoP7/NdYJ/7EPEYd6n2X/q8OaHUMdoSYwuBmfUWjwgHEVqxtY0
 tfdBi9bndwd6+mzHK0X7/2/sRKz76Q8fxb8z09mWEMRa2rAeYUvqgPbzqbWlDoMNgkNZNnq8ZV
 ZrDBbw5zL79KDa7xYbyJPWKP6sZDI4YnNV2w40g59EJojeS22NINvgK6EXr0uK43fuXp+ju4d8
 7Rk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:18 -0800
IronPort-SDR: qznXmorHrEcYnq9G/u4YAS1f0TUfwOXxGLoFzBAEut0to1qbA6BWcRfLbFyV4c8W2N10VmEUHc
 MVnKw5E0LFeh7bgoiZ7vX/J65vDX/MUYvANiO/kpVba+rpQKkb/fir9uO08mNMeQtvqwjqxLiQ
 nsZQeEJyr3o6FzIRNyIc8nP0+r8jKjSHfONvXXai6Kw33QsqFFypdcgna2eaa1/BZfKScaG5Xa
 gxKaHXhaJtPgqhS/h1ryT5Jzkr6VDcDSRT0VHODBiEq7CqVe1avWxrG/EpAaQV4PHReuY30c0N
 zbo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmZ10z5tz1Rwrq
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1678266200; x=1680858201; bh=83skHeTyuuHUEsf609
        nh/HewU5bhrZRbY23BMMXBCaI=; b=ZkPhC2UAiigjAK5HUKy8KAmVYpCG6S8rYU
        rVvfW9mEOA9ZwiPVUWJLUQkP2PAM9T7Xpl2CVhH9/tmyoj/k/AY17JcbHL3wnvRS
        wU4rlauF7NzpKZPwMXIj1oLCmRPA9zwep2KQ1XyJW9IIP2BDMkVOBXEtFaveyDs/
        /Q28gxFymCPSMxp+35eF/YkQKmRUoGypNPl4FJRy2+HigD5kDxcZUobRAOWC1m4h
        OjzaGaBFpGJ/A7VKmo4iKb0qS1jO56YHOTFmKx63rO8EefYPPTAQ6HJeEn1baWDU
        U+e/emI4L+zXijJOWmZ3QsZ6mRqtLYH6bvz86zfp/R1JOSCxlbVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id REhxR2V6Wj7U for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:20 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmYy4ZLjz1RvLy;
        Wed,  8 Mar 2023 01:03:18 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 02/16] PCI: endpoint: Move pci_epf_type_add_cfs() code
Date:   Wed,  8 Mar 2023 18:02:59 +0900
Message-Id: <20230308090313.1653-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export this
function and we can move its code from pci-epf-core.c to pci-ep-cfs.c
as a static function.

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

