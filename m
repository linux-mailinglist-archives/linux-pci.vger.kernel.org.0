Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3088919B538
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbgDASQh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 14:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgDASQh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 14:16:37 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E671E2063A;
        Wed,  1 Apr 2020 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585764996;
        bh=k2BgNXhsf/3H4tF9ZBGujMXMf1TCaLXmIhvjhPFF4+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xcr2DO6OshRZMyC6kvUFfL4+w9Zn39vGzXot1ad5HMxiO+SEVXT/Lmw/en8s1AVqC
         mPh40+i04WaWDDhTiUY1GSkbSWBmUClMuqUbuV8YnXmip0ZEwmZU6n8r9Mp6qhnhf9
         cYOWjW/hXIpw/7JZtTE+ArrnMLNvhfGxph6KHCd0=
Date:   Wed, 1 Apr 2020 13:16:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200401181632.GA96762@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1q1ufa1GoL_ZXdqothu_Dub4SAV1KZ_JFcpuF-p0f2Z4w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 31, 2020 at 10:28:51PM +0100, Luís Mendes wrote:
> I've removed all other PCIe devices to make the analysis easier.
> The dmesg with the traces can be found at:
> https://paste.ubuntu.com/p/W3m2VQCYqg/
> 
> Didn't find anything new related to BAR0 or BAR2, in the dmesg,
> though. Anyway I'm no expert in this, maybe it can give you some
> useful information, still.

It looks like we assigned the right amount of space to the bridge, but
for some reason didn't assign it to the device *below* the bridge.

I added a few more messages in this patch.  Can you remove the first
one and replace it with this?  This is still based on v5.6-rc1.


diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77..2cdb705752de 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -166,6 +166,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 	resource_size_t max;
 
 	type_mask |= IORESOURCE_TYPE_BITS;
+	pci_info(bus, "%s: %pR type_mask %#lx\n", __func__, res, type_mask);
 
 	pci_bus_for_each_resource(bus, r, i) {
 		resource_size_t min_used = min;
@@ -173,6 +174,9 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		if (!r)
 			continue;
 
+		pci_info(bus, "%s: from %pR res %#lx r %#lx\n", __func__,
+			r, res->flags, r->flags);
+
 		/* type_mask must match */
 		if ((res->flags ^ r->flags) & type_mask)
 			continue;
@@ -203,6 +207,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		if (ret == 0)
 			return 0;
 	}
+	pci_info(bus, "%s: failed\n", __func__);
 	return -ENOMEM;
 }
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f2461bf9243d..b42f1bcab25f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -177,6 +177,7 @@ static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
 	u16 class = dev->class >> 8;
 
+	pci_info(dev, "%s\n", __func__);
 	/* Don't touch classless devices or host bridges or IOAPICs */
 	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
 		return;
@@ -280,8 +281,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
+		pci_info(dev_res->dev, "%s: BAR%d %pR\n", __func__, idx, res);
 		if (resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
+			pci_info(dev_res->dev, "%s: failed\n", __func__);
 			if (fail_head) {
 				/*
 				 * If the failed resource is a ROM BAR and
@@ -372,6 +375,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
+	pr_info("%s\n", __func__);
 	/* Check if optional add_size is there */
 	if (!realloc_head || list_empty(realloc_head))
 		goto requested_and_reassign;
@@ -386,6 +390,7 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Update res in head list with add_size in realloc_head list */
 	list_for_each_entry_safe(dev_res, tmp_res, head, list) {
+		pci_info(dev_res->dev, "%s: %pR\n", __func__, dev_res->res);
 		dev_res->res->end += get_res_add_size(realloc_head,
 							dev_res->res);
 
@@ -436,6 +441,7 @@ static void __assign_resources_sorted(struct list_head *head,
 			remove_from_list(realloc_head, dev_res->res);
 		free_list(&save_head);
 		free_list(head);
+		pr_info("%s: success\n", __func__);
 		return;
 	}
 
@@ -483,6 +489,7 @@ static void pdev_assign_resources_sorted(struct pci_dev *dev,
 {
 	LIST_HEAD(head);
 
+	pci_info(dev, "%s\n", __func__);
 	__dev_sort_resources(dev, &head);
 	__assign_resources_sorted(&head, add_head, fail_head);
 
@@ -495,6 +502,7 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	struct pci_dev *dev;
 	LIST_HEAD(head);
 
+	pci_info(bus, "%s\n", __func__);
 	list_for_each_entry(dev, &bus->devices, bus_list)
 		__dev_sort_resources(dev, &head);
 
@@ -996,6 +1004,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
 
+	pci_info(bus, "%s: mask %#04lx type %#04lx %#04lx %#04lx min %#llx add %#llx b_res %pR parent %pR\n",
+		__func__, mask, type, type2, type3,
+		(unsigned long long) min_size,
+		(unsigned long long) add_size,
+		b_res, b_res ? b_res->parent : NULL);
+
 	if (!b_res)
 		return -ENOSPC;
 
@@ -1089,6 +1103,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			   (unsigned long long) (size1 - size0),
 			   (unsigned long long) add_align);
 	}
+	pci_info(bus->self, "%s: %pR\n", __func__, b_res);
 	return 0;
 }
 
@@ -1199,6 +1214,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct resource *b_res;
 	int ret;
 
+	pci_info(bus, "%s\n", __func__);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
 		if (!b)
@@ -1311,6 +1328,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	pci_info(bus, "%s\n", __func__);
 	__pci_bus_size_bridges(bus, NULL);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
@@ -1340,6 +1358,7 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 {
 	int i;
 
+	pci_info(dev, "%s\n", __func__);
 	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
 		struct pci_bus *b;
 		struct resource *r = &dev->resource[i];
@@ -1363,9 +1382,11 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	struct pci_bus *b;
 	struct pci_dev *dev;
 
+	pci_info(bus, "%s\n", __func__);
 	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_info(dev, "%s\n", __func__);
 		pdev_assign_fixed_resources(dev);
 
 		b = dev->subordinate;
@@ -1394,6 +1415,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	pci_info(bus, "%s\n", __func__);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
@@ -1408,6 +1430,7 @@ static void pci_claim_device_resources(struct pci_dev *dev)
 		if (!r->flags || r->parent)
 			continue;
 
+		pci_info(dev, "%s: BAR%d %pR\n", __func__, i, r);
 		pci_claim_resource(dev, i);
 	}
 }
@@ -1422,6 +1445,7 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
 		if (!r->flags || r->parent)
 			continue;
 
+		pci_info(dev, "%s: BAR%d %pR\n", __func__, i, r);
 		pci_claim_bridge_resource(dev, i);
 	}
 }
@@ -1432,6 +1456,7 @@ static void pci_bus_allocate_dev_resources(struct pci_bus *b)
 	struct pci_bus *child;
 
 	list_for_each_entry(dev, &b->devices, bus_list) {
+		pci_info(dev, "%s\n", __func__);
 		pci_claim_device_resources(dev);
 
 		child = dev->subordinate;
@@ -1460,6 +1485,7 @@ static void pci_bus_allocate_resources(struct pci_bus *b)
 
 void pci_bus_claim_resources(struct pci_bus *b)
 {
+	pci_info(bus, "%s\n", __func__);
 	pci_bus_allocate_resources(b);
 	pci_bus_allocate_dev_resources(b);
 }
@@ -1471,6 +1497,7 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 {
 	struct pci_bus *b;
 
+	pci_info(dev, "%s\n", __func__);
 	pdev_assign_resources_sorted((struct pci_dev *)bridge,
 					 add_head, fail_head);
 
