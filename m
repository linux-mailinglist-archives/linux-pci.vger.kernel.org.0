Return-Path: <linux-pci+bounces-7374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E48C2FB5
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EFC1C20311
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89644C8F;
	Sat, 11 May 2024 05:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2163CF65
	for <linux-pci@vger.kernel.org>; Sat, 11 May 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715406178; cv=none; b=fZakamZdZ2UsUzuMUPp1aQ545hEl/a3zKhyK0oyMHlzegdtBJH/4hstMMMlaPBjzrQGn6KhLvsvfyZv1j+Y7ZyQp9bIGpC3N1lbV/tc3xlFVqNtrScW4dJaI6DJlV+DFc3rrAU793F9snp6170ChrQt7K/z7JRAj11OTJdHb5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715406178; c=relaxed/simple;
	bh=1o7ioJ8Y/BMDSiq6H389bvf2c/5X0KY3SpNtki0o8fk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv938cWofnOATnARy+M3pz3ZoMlY1wnLgXojp7BTuxahmsqXeFOHNkhSIgRGyu9skfPK1h4M8RVvgceFFzOO0lSZZdSdiYI8MoLyo7NoseDAnmKNXlijlxf8bhb4gJVQxfW+CeDqPin8u2sVui/pOP3A9iTWzh3ntGZWvtLFOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 4b7fdbe9-0f59-11ef-abf4-005056bdd08f;
	Sat, 11 May 2024 08:42:48 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 11 May 2024 08:42:46 +0300
To: Krishna Kumar <krishnak@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	brking@linux.vnet.ibm.com, gbatra@linux.ibm.com,
	aneesh.kumar@kernel.org, christophe.leroy@csgroup.eu,
	nathanl@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com,
	tpearson@raptorengineering.com, mahesh.salgaonkar@in.ibm.com
Subject: Re: [PATCH 2/2] arch/powerpc: hotplug driver bridge support
Message-ID: <Zj8FVva9G9_r6-cZ@surfacebook.localdomain>
References: <20240509120644.653577-1-krishnak@linux.ibm.com>
 <20240509120644.653577-3-krishnak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509120644.653577-3-krishnak@linux.ibm.com>

Thu, May 09, 2024 at 05:35:54PM +0530, Krishna Kumar kirjoitti:
> There is an issue with the hotplug operation when it's done on the
> bridge/switch slot. The bridge-port and devices behind the bridge, which
> become offline by hot-unplug operation, don't get hot-plugged/enabled by
> doing hot-plug operation on that slot. Only the first port of the bridge
> gets enabled and the remaining port/devices remain unplugged. The hot
> plug/unplug operation is done by the hotplug driver
> (drivers/pci/hotplug/pnv_php.c).
> 
> Root Cause Analysis: This behavior is due to missing code for the DPC
> switch/bridge. The existing driver depends on pci_hp_add_devices()
> function for device enablement. This function calls pci_scan_slot() on
> only one device-node/port of the bridge, not on all the siblings'
> device-node/port.
> 
> The missing code needs to be added which will find all the sibling
> device-nodes/bridge-ports and will run explicit pci_scan_slot() on
> those.  A new function has been added for this purpose which gets
> invoked from pci_hp_add_devices(). This new function
> pci_traverse_sibling_nodes_and_scan_slot() gets all the sibling
> bridge-ports by traversal and explicitly invokes pci_scan_slot on them.
> 
> 

One blank line is enough here.

> Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>

...

> +void *pci_traverse_sibling_nodes_and_scan_slot(struct device_node *start, struct pci_bus *bus)
> +{
> +	struct device_node *dn;
> +	struct device_node *parent;
> +	int slotno;
> +
> +	const __be32 *classp1;
> +	u32 class1 = 0;

> +	classp1 = of_get_property(start->child, "class-code", NULL);
> +	if (classp1)
> +		class1 = of_read_number(classp1, 1);

What's wrong with of_property_read_u32()?


> +	/* Call of pci_scan_slot for non-bridge/EP case */
> +	if (!((class1 >> 8) == PCI_CLASS_BRIDGE_PCI)) {
> +		slotno = PCI_SLOT(PCI_DN(start->child)->devfn);
> +		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +		return NULL;
> +	}
> +
> +	/* Iterate all siblings */
> +	parent = start;
> +	for_each_child_of_node(parent, dn) {
> +		const __be32 *classp;
> +		u32 class = 0;
> +
> +		classp = of_get_property(dn, "class-code", NULL);
> +		if (classp)
> +			class = of_read_number(classp, 1);

Ditto.

> +		/* Call of pci_scan_slot on each sibling-nodes/bridge-ports */
> +		if ((class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> +			slotno = PCI_SLOT(PCI_DN(dn)->devfn);
> +			pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
> +		}
> +	}
> +
> +	return NULL;
> +}

-- 
With Best Regards,
Andy Shevchenko



