Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2A1984D7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 21:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgC3TtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 15:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgC3TtW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 15:49:22 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B3320771;
        Mon, 30 Mar 2020 19:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597761;
        bh=qtmjNmCqVumWAr5MCk+RbBzlG+Q045NpFUoEc3hNlz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZyDYYtTrr15nUKxlLh6rN33ijOvQLL+jJ7O71P+/HoQDCDXYNtea2Wi6p0vtVCYN0
         C1y3l+Ox8HNcJ9N99XzP4ZWJlripD9hJqvzLkYciQpyRUdpdbxbrCvYcCNaWzntzdM
         +I2Y0Tl1X7+PovodAdWTEC9xfzxebZheXx/cZ5VU=
Date:   Mon, 30 Mar 2020 14:49:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200330194917.GA72191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1pFFEw+FdAyC6=yxkk5cXMJkVxxkxMiHrB6sH7pwGMkFQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 29, 2020 at 11:11:28PM +0100, Luís Mendes wrote:
> Hi Nicholas, Bjorn,
> 
> I was able to make the apex driver work on a X86_64 system with the
> Coral Edge TPU PCIe device.
> So, now the PCI enumeration problem is now clearly an ARM and ARM64
> platform issue. What are the recommended steps for debugging this? I
> hava a JTAG interface and openOCD supported configuration for it.

Thanks for the work of testing on X86_64.  I don't have any magic
ideas other than instrumenting the code and slogging through the
output.  Can you try the patch below and collect the dmesg?  This will
probably take a few iterations.


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
index f2461bf9243d..649aa90b8b29 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -280,8 +280,10 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
+		pci_info(dev_res->dev, "%s BAR%d %pR\n", __func__, idx, res);
 		if (resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
+			pci_info(dev_res->dev, "%s (failed)\n", __func__);
 			if (fail_head) {
 				/*
 				 * If the failed resource is a ROM BAR and
@@ -996,6 +998,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
 
+	pci_info(bus, "%s: mask %#lx type %#lx %#lx %#lx min %#llx add %#llx b_res %pR parent %pR\n",
+		__func__, mask, type, type2, type3,
+		(unsigned long long) min_size,
+		(unsigned long long) add_size,
+		b_res, b_res ? b_res->parent : NULL);
+
 	if (!b_res)
 		return -ENOSPC;
 
@@ -1199,6 +1207,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct resource *b_res;
 	int ret;
 
+	pci_info(bus, "%s\n", __func__);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
 		if (!b)
@@ -1311,6 +1321,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 void pci_bus_size_bridges(struct pci_bus *bus)
 {
+	pci_info(bus, "%s\n", __func__);
 	__pci_bus_size_bridges(bus, NULL);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
@@ -1394,6 +1405,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 
 void pci_bus_assign_resources(const struct pci_bus *bus)
 {
+	pci_info(bus, "%s\n", __func__);
 	__pci_bus_assign_resources(bus, NULL, NULL);
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);
@@ -1408,6 +1420,7 @@ static void pci_claim_device_resources(struct pci_dev *dev)
 		if (!r->flags || r->parent)
 			continue;
 
+		pci_info(dev, "%s BAR%d %pR\n", __func__, i, r);
 		pci_claim_resource(dev, i);
 	}
 }
@@ -1422,6 +1435,7 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
 		if (!r->flags || r->parent)
 			continue;
 
+		pci_info(dev, "%s BAR%d %pR\n", __func__, i, r);
 		pci_claim_bridge_resource(dev, i);
 	}
 }
@@ -1460,6 +1474,7 @@ static void pci_bus_allocate_resources(struct pci_bus *b)
 
 void pci_bus_claim_resources(struct pci_bus *b)
 {
+	pci_info(bus, "%s\n", __func__);
 	pci_bus_allocate_resources(b);
 	pci_bus_allocate_dev_resources(b);
 }
