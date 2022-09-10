Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5735B4679
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiIJNXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJNXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 09:23:53 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C83ECDA;
        Sat, 10 Sep 2022 06:23:51 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 5ccbad0bd51352a6; Sat, 10 Sep 2022 15:23:48 +0200
Received: from kreacher.localnet (unknown [213.134.169.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7D02166D4A0;
        Sat, 10 Sep 2022 15:23:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] ACPI: PCI: Rework acpi_get_pci_dev()
Date:   Sat, 10 Sep 2022 15:23:46 +0200
Message-ID: <2661914.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.62
X-CLIENT-HOSTNAME: 213.134.169.62
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtjedgieehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppedvudefrddufeegrdduieelrdeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdeivddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PCI device returned by acpi_get_pci_dev() needs to be registered,
so if it corresponds to an ACPI device object, the struct acpi_device
representing that object must be registered too and, moreover, it
should be the ACPI companion of the given PCI device.  Thus it should
be sufficient to look for it in the ACPI device object's list of
physical nodes associated with it.

Modify the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c |   81 ++++++++----------------------------------------
 1 file changed, 15 insertions(+), 66 deletions(-)

Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -312,76 +312,25 @@ struct acpi_handle_node {
  */
 struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 {
-	int dev, fn;
-	unsigned long long adr;
-	acpi_status status;
-	acpi_handle phandle;
-	struct pci_bus *pbus;
-	struct pci_dev *pdev = NULL;
-	struct acpi_handle_node *node, *tmp;
-	struct acpi_pci_root *root;
-	LIST_HEAD(device_list);
-
-	/*
-	 * Walk up the ACPI CA namespace until we reach a PCI root bridge.
-	 */
-	phandle = handle;
-	while (!acpi_is_root_bridge(phandle)) {
-		node = kzalloc(sizeof(struct acpi_handle_node), GFP_KERNEL);
-		if (!node)
-			goto out;
-
-		INIT_LIST_HEAD(&node->node);
-		node->handle = phandle;
-		list_add(&node->node, &device_list);
-
-		status = acpi_get_parent(phandle, &phandle);
-		if (ACPI_FAILURE(status))
-			goto out;
-	}
-
-	root = acpi_pci_find_root(phandle);
-	if (!root)
-		goto out;
-
-	pbus = root->bus;
-
-	/*
-	 * Now, walk back down the PCI device tree until we return to our
-	 * original handle. Assumes that everything between the PCI root
-	 * bridge and the device we're looking for must be a P2P bridge.
-	 */
-	list_for_each_entry(node, &device_list, node) {
-		acpi_handle hnd = node->handle;
-		status = acpi_evaluate_integer(hnd, "_ADR", NULL, &adr);
-		if (ACPI_FAILURE(status))
-			goto out;
-		dev = (adr >> 16) & 0xffff;
-		fn  = adr & 0xffff;
-
-		pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
-		if (!pdev || hnd == handle)
-			break;
-
-		pbus = pdev->subordinate;
-		pci_dev_put(pdev);
-
-		/*
-		 * This function may be called for a non-PCI device that has a
-		 * PCI parent (eg. a disk under a PCI SATA controller).  In that
-		 * case pdev->subordinate will be NULL for the parent.
-		 */
-		if (!pbus) {
-			dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
-			pdev = NULL;
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	struct acpi_device_physical_node *pn;
+	struct pci_dev *pci_dev = NULL;
+
+	if (!adev)
+		return NULL;
+
+	mutex_lock(&adev->physical_node_lock);
+
+	list_for_each_entry(pn, &adev->physical_node_list, node) {
+		if (dev_is_pci(pn->dev)) {
+			pci_dev = to_pci_dev(pn->dev);
 			break;
 		}
 	}
-out:
-	list_for_each_entry_safe(node, tmp, &device_list, node)
-		kfree(node);
 
-	return pdev;
+	mutex_unlock(&adev->physical_node_lock);
+
+	return pci_dev;
 }
 EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 



