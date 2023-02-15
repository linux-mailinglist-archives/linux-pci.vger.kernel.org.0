Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71336974D0
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBODWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjBODWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:05 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95032E6D
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431323; x=1707967323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tIhg+9TmISWM6CNSYvtDKqRKlDI0RorvIeEG5cf809A=;
  b=dK+0Lls973nm8PV7JmHwsqafY9zUNYOmopPk6QyYiXVN4Xm/8FUxEGa+
   JNmuEPO2A+64Rd0AYst2WhWeSLPmD0q7p9zIVIkVyN5YA0mlKFhwV3H0H
   x4rs6Ya8IPVd5w5GqfJWhsb7aXc5+EB8nPI/mG6h30LVFHqB+PK/14Kv0
   W46WrwceH8O5TMpzPKMy6rwruMGkJam7Np+Yg4vRFdotXo8MRbcFb0PAm
   AWo6CTFwkUKGD0DiNPkdQkmT0Lwj9vHEW6mO1DndLGUGnS9aPa1B6NzHf
   +srzujDI8yu38haJtlMQK5EBO4PW7S42TgGAw58iagXLuBoHvKiKmkXlg
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351449"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:22:03 +0800
IronPort-SDR: iuiDCmGlQn+OC+Dr3DIFM/Tf1hpqmQtW0saiFpNB6gCsgQQNRAtJugUjElqC1HAg2cjlqZ+e1s
 P2rIyh/D9++kTEXDQGYMQ0JOuz4mM1VqIgi8V4eBuSc6MX1F3zs4OTH+Go9HB3JFBhpnPXuwAI
 LO4u6S53TEGobclyVy016Yc28EF/t6zkWpq3G7XT4enXuzO+l8qx+4tWdkZyC/ZKxhIcRVufx1
 Iu3K13GOV7TnB7fc3rkZVwU29Ga1kV7ETTWtX0MNEBOG9MuHaAa14Afim71pnbglii37shS6xD
 hIU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:26 -0800
IronPort-SDR: 7c7MiDWGXmYqh6BWfZEtvcBtUkoHMujV+zekkmn59G62UpmrEQZxRc0iXSvUhv7wPH039F9pJk
 vEfnAPTGNnVZG4+bzg5FRfkxyIfqcfS8PyZJRC5S9Z8LKFnDqjCmnfn46olJNsqCVI6W6w1y++
 t1wPmuSOgjUue1gbsbd6cEhr5jMt/xqWq/Y5mRnrEmeHmVGBgoYefe08dK7lEDxuZYLRQ1TyA5
 cpGIMJXJPGUzBrghUgbavF2NcUAeXiECgJrwTtJyh6ifUdt23dAeH9B8t1nFLGHFne0ogNlZl2
 qz4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:22:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGjzt6yX8z1Rwrq
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1676431322; x=1679023323; bh=tIhg+9TmISWM6CNSYv
        tDKqRKlDI0RorvIeEG5cf809A=; b=sMvF/L4b7G6NqMN6Nb9s/NqtHgOhbTKJhT
        yHw3BqtT49RAkSQiX510mdPvOgIEI0wURsXq9MiDzsaDHAQv4fw0Y44MNim4ZC2i
        qriYf72pygDZ3UR12WTynDx+lRYKDbA6oWl3hFWl5lBSv9+tJ7cCiJHyNvZQPgY+
        08pv2cog71beIe06anQKAdkKkv8FaArS0aPw2YKctevm9eEEIlD2/CoTZW5Kt7cb
        okVSIP1Vgi8uB4a0BqI4k5h1TJUmm229cs8BtdD/34V/Gsb0rZfaRgSUGtPZptUg
        vjp6EEljTJNgiH+XDA7P1Hk8Ua4lajh9Sdy3xZRy9cw5Q/pTnPlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CE5k9rfupvgH for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:22:02 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzr4WVjz1RvLy;
        Tue, 14 Feb 2023 19:22:00 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/12] pci: endpoint: do not export pci_epf_type_add_cfs()
Date:   Wed, 15 Feb 2023 12:21:45 +0900
Message-Id: <20230215032155.74993-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export it
and function drivers should not call this function directly.

Remove the export for this function and move its declaration to the
internal header file drivers/pci/endpoint/pci-epf.h.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c   |  3 ++-
 drivers/pci/endpoint/pci-epf-core.c | 12 +++++-------
 drivers/pci/endpoint/pci-epf.h      | 14 ++++++++++++++
 include/linux/pci-epf.h             |  2 --
 4 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/endpoint/pci-epf.h

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci=
-ep-cfs.c
index 1fb31f07199f..62b3b9e306fa 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -11,9 +11,10 @@
 #include <linux/slab.h>
=20
 #include <linux/pci-epc.h>
-#include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
=20
+#include "pci-epf.h"
+
 static DEFINE_IDR(functions_idr);
 static DEFINE_MUTEX(functions_mutex);
 static struct config_group *functions_group;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/p=
ci-epf-core.c
index 9ed556936f48..db121a58a586 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -12,24 +12,23 @@
 #include <linux/module.h>
=20
 #include <linux/pci-epc.h>
-#include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
=20
+#include "pci-epf.h"
+
 static DEFINE_MUTEX(pci_epf_mutex);
=20
 static struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
=20
 /**
- * pci_epf_type_add_cfs() - Help function drivers to expose function spe=
cific
- *                          attributes in configfs
+ * pci_epf_type_add_cfs() - Get a function driver specific attribute gro=
up.
  * @epf: the EPF device that has to be configured using configfs
  * @group: the parent configfs group (corresponding to entries in
  *         pci_epf_device_id)
  *
- * Invoke to expose function specific attributes in configfs. If the fun=
ction
- * driver does not have anything to expose (attributes configured by use=
r),
- * return NULL.
+ * Called from pci_ep_cfs_add_type_group() when the function is created.
+ * If the function driver does not have anything to expose, return NULL.
  */
 struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
 					  struct config_group *group)
@@ -50,7 +49,6 @@ struct config_group *pci_epf_type_add_cfs(struct pci_ep=
f *epf,
=20
 	return epf_type_group;
 }
-EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
=20
 /**
  * pci_epf_unbind() - Notify the function driver that the binding betwee=
n the
diff --git a/drivers/pci/endpoint/pci-epf.h b/drivers/pci/endpoint/pci-ep=
f.h
new file mode 100644
index 000000000000..b2f351afd623
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* (EPF) internal header file
+ */
+
+#ifndef PCI_EPF_H
+#define PCI_EPF_H
+
+#include <linux/pci-epf.h>
+
+struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
+					  struct config_group *group);
+
+#endif /* PCI_EPF_H */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 009a07147c61..b89cd8515073 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -209,8 +209,6 @@ void pci_epf_free_space(struct pci_epf *epf, void *ad=
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
2.39.1

