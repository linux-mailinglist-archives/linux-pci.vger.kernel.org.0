Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18626F620
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIRGoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 02:44:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgIRGoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 02:44:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08I6i7V1128103;
        Fri, 18 Sep 2020 01:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600411447;
        bh=z3Tw9eXfcOK90ruy3aMeRyVdcSzDrEL/G+eXeTQ/vG0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qv1e0UXlV92eSW7FDQ+bjW5MX56j3HP8vlnKPUTiKW02+PvmspGbnD2iXfFAXrq95
         EB9rNSlk3piX7PVWOCC6PiD6o9I9Rzh1hT135B0YEMHo8KJsFEUlVoFZgVkZGkJNCR
         lBgMpHGuV6DkggkqW4xv/WjoM0DtQ385qLXpunS8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08I6i7B5110440
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 01:44:07 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 01:44:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 01:44:07 -0500
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08I6gUCR094595;
        Fri, 18 Sep 2020 01:44:01 -0500
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
Subject: [PATCH v5 07/17] PCI: endpoint: Add support in configfs to associate two EPCs with EPF
Date:   Fri, 18 Sep 2020 12:12:17 +0530
Message-ID: <20200918064227.1463-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918064227.1463-1-kishon@ti.com>
References: <20200918064227.1463-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that PCI endpoint core supports to add secondary endpoint
controller (EPC) with endpoint function (EPF), Add support in configfs
to associate two EPCs with EPF. This creates "primary" and "secondary"
directory inside the directory created by users for EPF device. Users
have to add a symlink of endpoint controller (pci_ep/controllers/) to
"primary" or "secondary" directory to bind EPF to primary and secondary
EPF interfaces respectively. Existing method of linking directory
representing EPF device to directory representing EPC device to
associate a single EPC device with a EPF device will continue to work.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../PCI/endpoint/pci-endpoint-cfs.rst         |  10 ++
 drivers/pci/endpoint/pci-ep-cfs.c             | 147 ++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
index 1bbd81ed06c8..696f8eeb4738 100644
--- a/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -68,6 +68,16 @@ created)
 				... subsys_vendor_id
 				... subsys_id
 				... interrupt_pin
+                                ... primary/
+			                ... <Symlink EPC Device1>/
+                                ... secondary/
+			                ... <Symlink EPC Device2>/
+
+If an EPF device has to be associated with 2 EPCs (like in the case of
+Non-transparent bridge), symlink of endpoint controller connected to primary
+interface should be added in 'primary' directory and symlink of endpoint
+controller connected to secondary interface should be added in 'secondary'
+directory.
 
 EPC Device
 ==========
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 6ca9e2f92460..8f750961d6ab 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -21,6 +21,9 @@ static struct config_group *controllers_group;
 
 struct pci_epf_group {
 	struct config_group group;
+	struct config_group primary_epc_group;
+	struct config_group secondary_epc_group;
+	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
 };
@@ -41,6 +44,127 @@ static inline struct pci_epc_group *to_pci_epc_group(struct config_item *item)
 	return container_of(to_config_group(item), struct pci_epc_group, group);
 }
 
+static int pci_secondary_epc_epf_link(struct config_item *epf_item,
+				      struct config_item *epc_item)
+{
+	int ret;
+	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
+	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
+	struct pci_epc *epc = epc_group->epc;
+	struct pci_epf *epf = epf_group->epf;
+
+	ret = pci_epc_add_epf(epc, epf, SECONDARY_INTERFACE);
+	if (ret)
+		return ret;
+
+	ret = pci_epf_bind(epf);
+	if (ret) {
+		pci_epc_remove_epf(epc, epf, SECONDARY_INTERFACE);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
+					 struct config_item *epf_item)
+{
+	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
+	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+
+	WARN_ON_ONCE(epc_group->start);
+
+	epc = epc_group->epc;
+	epf = epf_group->epf;
+	pci_epf_unbind(epf);
+	pci_epc_remove_epf(epc, epf, SECONDARY_INTERFACE);
+}
+
+static struct configfs_item_operations pci_secondary_epc_item_ops = {
+	.allow_link	= pci_secondary_epc_epf_link,
+	.drop_link	= pci_secondary_epc_epf_unlink,
+};
+
+static const struct config_item_type pci_secondary_epc_type = {
+	.ct_item_ops	= &pci_secondary_epc_item_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group
+*pci_ep_cfs_add_secondary_group(struct pci_epf_group *epf_group)
+{
+	struct config_group *secondary_epc_group;
+
+	secondary_epc_group = &epf_group->secondary_epc_group;
+	config_group_init_type_name(secondary_epc_group, "secondary",
+				    &pci_secondary_epc_type);
+	configfs_register_group(&epf_group->group, secondary_epc_group);
+
+	return secondary_epc_group;
+}
+
+static int pci_primary_epc_epf_link(struct config_item *epf_item,
+				    struct config_item *epc_item)
+{
+	int ret;
+	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
+	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
+	struct pci_epc *epc = epc_group->epc;
+	struct pci_epf *epf = epf_group->epf;
+
+	ret = pci_epc_add_epf(epc, epf, PRIMARY_INTERFACE);
+	if (ret)
+		return ret;
+
+	ret = pci_epf_bind(epf);
+	if (ret) {
+		pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
+				       struct config_item *epf_item)
+{
+	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
+	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+
+	WARN_ON_ONCE(epc_group->start);
+
+	epc = epc_group->epc;
+	epf = epf_group->epf;
+	pci_epf_unbind(epf);
+	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
+}
+
+static struct configfs_item_operations pci_primary_epc_item_ops = {
+	.allow_link	= pci_primary_epc_epf_link,
+	.drop_link	= pci_primary_epc_epf_unlink,
+};
+
+static const struct config_item_type pci_primary_epc_type = {
+	.ct_item_ops	= &pci_primary_epc_item_ops,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group
+*pci_ep_cfs_add_primary_group(struct pci_epf_group *epf_group)
+{
+	struct config_group *primary_epc_group = &epf_group->primary_epc_group;
+
+	config_group_init_type_name(primary_epc_group, "primary",
+				    &pci_primary_epc_type);
+	configfs_register_group(&epf_group->group, primary_epc_group);
+
+	return primary_epc_group;
+}
+
 static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 				   size_t len)
 {
@@ -372,6 +496,25 @@ static const struct config_item_type pci_epf_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void pci_epf_cfs_work(struct work_struct *work)
+{
+	struct pci_epf_group *epf_group;
+	struct config_group *group;
+
+	epf_group = container_of(work, struct pci_epf_group, cfs_work.work);
+	group = pci_ep_cfs_add_primary_group(epf_group);
+	if (IS_ERR(group)) {
+		pr_err("failed to create 'primary' EPC interface\n");
+		return;
+	}
+
+	group = pci_ep_cfs_add_secondary_group(epf_group);
+	if (IS_ERR(group)) {
+		pr_err("failed to create 'secondary' EPC interface\n");
+		return;
+	}
+}
+
 static struct config_group *pci_epf_make(struct config_group *group,
 					 const char *name)
 {
@@ -414,6 +557,10 @@ static struct config_group *pci_epf_make(struct config_group *group,
 
 	kfree(epf_name);
 
+	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
+	queue_delayed_work(system_wq, &epf_group->cfs_work,
+			   msecs_to_jiffies(1));
+
 	return &epf_group->group;
 
 free_name:
-- 
2.17.1

