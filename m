Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3A11B6CE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 17:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfLKQDM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 11:03:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbfLKPNE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA222467C;
        Wed, 11 Dec 2019 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077183;
        bh=fnyJKczM5o9gX2QSlRYeZOJCIgFxy+pPik7ScKtRtIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcl2GcZbTd3QEpBitP2LPaSNmXOw/8tutUlJ2qOV63R3S2hr2AhgipR/aOqeC0ajx
         tk5W+ZLomVy2WLXlnslD0sSld2lhbnhea/V8WVnOU7AO26ZcpS2Smwx+NCK2ggDcbG
         riR5MnJuxqse1XjlmjSmKiLkmXq+u51jFtZik9tE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 067/134] PCI: rpaphp: Annotate and correctly byte swap DRC properties
Date:   Wed, 11 Dec 2019 10:10:43 -0500
Message-Id: <20191211151150.19073-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.ibm.com>

[ Upstream commit 0737686778c6dbe0908d684dd5b9c05b127526ba ]

The device tree is in big endian format and any properties directly
retrieved using OF helpers that don't explicitly byte swap should
be annotated. In particular there are several places where we grab
the opaque property value for the old ibm,drc-* properties and the
ibm,my-drc-index property.

Fix this for better static checking by annotating values we know to
explicitly big endian, and byte swap where appropriate.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/1573449697-5448-9-git-send-email-tyreld@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/rpaphp_core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index e18e9a0e959c8..abb10b3c0b70f 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -154,11 +154,11 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
 	return speed;
 }
 
-static int get_children_props(struct device_node *dn, const int **drc_indexes,
-		const int **drc_names, const int **drc_types,
-		const int **drc_power_domains)
+static int get_children_props(struct device_node *dn, const __be32 **drc_indexes,
+			      const __be32 **drc_names, const __be32 **drc_types,
+			      const __be32 **drc_power_domains)
 {
-	const int *indexes, *names, *types, *domains;
+	const __be32 *indexes, *names, *types, *domains;
 
 	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
 	names = of_get_property(dn, "ibm,drc-names", NULL);
@@ -194,8 +194,8 @@ static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
 				char *drc_type, unsigned int my_index)
 {
 	char *name_tmp, *type_tmp;
-	const int *indexes, *names;
-	const int *types, *domains;
+	const __be32 *indexes, *names;
+	const __be32 *types, *domains;
 	int i, rc;
 
 	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
@@ -208,7 +208,7 @@ static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
 
 	/* Iterate through parent properties, looking for my-drc-index */
 	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-		if ((unsigned int) indexes[i + 1] == my_index)
+		if (be32_to_cpu(indexes[i + 1]) == my_index)
 			break;
 
 		name_tmp += (strlen(name_tmp) + 1);
@@ -267,7 +267,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
 			char *drc_type)
 {
-	const unsigned int *my_index;
+	const __be32 *my_index;
 
 	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
 	if (!my_index) {
@@ -277,10 +277,10 @@ int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
 
 	if (of_find_property(dn->parent, "ibm,drc-info", NULL))
 		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
-						*my_index);
+						be32_to_cpu(*my_index));
 	else
 		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
-						*my_index);
+						be32_to_cpu(*my_index));
 }
 EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
 
@@ -311,10 +311,11 @@ static int is_php_type(char *drc_type)
  * for built-in pci slots (even when the built-in slots are
  * dlparable.)
  */
-static int is_php_dn(struct device_node *dn, const int **indexes,
-		const int **names, const int **types, const int **power_domains)
+static int is_php_dn(struct device_node *dn, const __be32 **indexes,
+		     const __be32 **names, const __be32 **types,
+		     const __be32 **power_domains)
 {
-	const int *drc_types;
+	const __be32 *drc_types;
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
@@ -349,7 +350,7 @@ int rpaphp_add_slot(struct device_node *dn)
 	struct slot *slot;
 	int retval = 0;
 	int i;
-	const int *indexes, *names, *types, *power_domains;
+	const __be32 *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
 	if (!dn->name || strcmp(dn->name, "pci"))
-- 
2.20.1

