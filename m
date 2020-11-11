Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD902AF508
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKKPhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 10:37:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59198 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgKKPhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 10:37:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ABFbdGw125202;
        Wed, 11 Nov 2020 09:37:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605109059;
        bh=6+pEZ2sU4Okxi+WU1gPDCbDCdtKwOEBqEUtnhiZE5hw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uKSkeQ+tcMz2voE+uDRhcCNtide1wNYyVmDTXC9vWPaMWTS+fsS9PM34DFbBeydR6
         z+sxvN2RJHdzlVZBSaUXBvXUROxoKC9EC5hAPrnJeSJBS0EeWtQGHcwNM+jKXADt4h
         5X4fcHIr1K10iOSJN2/8IJW8+uab4bGzg6D0vYHE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ABFbdNM124453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 09:37:39 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 09:37:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 09:37:38 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ABFa041042109;
        Wed, 11 Nov 2020 09:37:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
Subject: [PATCH v8 10/18] PCI: endpoint: Allow user to create sub-directory of 'EPF Device' directory
Date:   Wed, 11 Nov 2020 21:05:51 +0530
Message-ID: <20201111153559.19050-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111153559.19050-1-kishon@ti.com>
References: <20201111153559.19050-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Documentation/PCI/endpoint/pci-endpoint-cfs.rst explains how a user
has to create a directory in-order to create a 'EPF Device' that
can be configured/probed by 'EPF Driver'.

Allow user to create a sub-directory of 'EPF Device' directory for
any function specific attributes that has to be exposed to the user.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 23 +++++++++++++++++++++++
 include/linux/pci-epf.h           |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 8f750961d6ab..f3a8b833b479 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -490,7 +490,29 @@ static struct configfs_item_operations pci_epf_ops = {
 	.release		= pci_epf_release,
 };
 
+static struct config_group *pci_epf_type_make(struct config_group *group,
+					      const char *name)
+{
+	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
+	struct config_group *epf_type_group;
+
+	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
+	return epf_type_group;
+}
+
+static void pci_epf_type_drop(struct config_group *group,
+			      struct config_item *item)
+{
+	config_item_put(item);
+}
+
+static struct configfs_group_operations pci_epf_type_group_ops = {
+	.make_group     = &pci_epf_type_make,
+	.drop_item      = &pci_epf_type_drop,
+};
+
 static const struct config_item_type pci_epf_type = {
+	.ct_group_ops	= &pci_epf_type_group_ops,
 	.ct_item_ops	= &pci_epf_ops,
 	.ct_attrs	= pci_epf_attrs,
 	.ct_owner	= THIS_MODULE,
@@ -553,6 +575,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 		goto free_name;
 	}
 
+	epf->group = &epf_group->group;
 	epf_group->epf = epf;
 
 	kfree(epf_name);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index b241e7dd171f..6833e2160ef1 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -9,6 +9,7 @@
 #ifndef __LINUX_PCI_EPF_H
 #define __LINUX_PCI_EPF_H
 
+#include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
@@ -128,6 +129,7 @@ struct pci_epf_bar {
  *   EPC device
  * @sec_epc_bar: represents the BAR of EPF device associated with secondary EPC
  * @sec_epc_func_no: unique (physical) function number within the secondary EPC
+ * @group: configfs group associated with the EPF device
  */
 struct pci_epf {
 	struct device		dev;
@@ -150,6 +152,7 @@ struct pci_epf {
 	struct list_head	sec_epc_list;
 	struct pci_epf_bar	sec_epc_bar[6];
 	u8			sec_epc_func_no;
+	struct config_group	*group;
 };
 
 /**
-- 
2.17.1

