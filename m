Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6AF91D3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfKLOTW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 Nov 2019 09:19:22 -0500
Received: from mail-oln040092254027.outbound.protection.outlook.com ([40.92.254.27]:59520
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfKLOTW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 09:19:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erbSlozWtCwKmFmm78c3iu7LXIgtuOvJRJWekwePB+duBYkhhGcNWxDV/Q3hYdljbpBQptKl4Y99zwjKaL9pUXzoNEHIW+3e4v+ZBTbmUuqnIOlyhTWXyH4mPICFCl9rXxP7VTrgoTG4s9yzUpdP4cYmEqn5Q0RMwvL1P7l4szTDVeiFBV3zzYYCX309Q8BDDb6mAnWJPn/6cdHh71FtEKL2VVHb/YMuSM3ytwn5S4aTX+RjiBESVXGt5m61QpTbRGAukI9FU32oKOw5ppLl1lY+W47vygw+q6LemFGlPlAY+pZVPDNGRPl8ewzMZitBpF7vwCxLd1l1Mhtqw/VZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvSVUDXIaWTd+CYVf7hzpSG6QN2oEtPF7OfABB61r2I=;
 b=CIXzOtY27JvBvs5tAhH40bqyx7G0Y0z2RLaak2zNprc2t6ukZMvi8CX4XlYHQj1swT7XQocNcohL30+YrU2gPqNkfB5XTF37oy0oNoEoCqGKKANC6FObW2hZICbt3aNKQfQbwVuacJvZ+ThMgaKivVqVSgffQb1d6IsncdkAPDu0FXtm7ICc35VBC4vAd+FulrkwC3wwNHDBfrq+5e1m6Cjs5cFtuF/rnVDCYNO884DmYbQ0Wjm4EgnWF4nfMXaQDPi/XD5ZqBp3T1bXnbPeMslsDjw/eBYN/CzWUJksnwLBjbkxoDRrXqF39k2HYy51W665BH2XBCR/OOPZT3/4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT031.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT049.eop-APC01.prod.protection.outlook.com
 (10.152.249.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Tue, 12 Nov
 2019 14:17:35 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT031.mail.protection.outlook.com (10.152.248.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Tue, 12 Nov 2019 14:17:35 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 14:17:35 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVlXJhu/GZEUU1TEqW4eFw21Odo6eHT2CAgABNjYA=
Date:   Tue, 12 Nov 2019 14:17:35 +0000
Message-ID: <PS2P216MB0755753A471700A4418008C880770@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB07554FF63C34AFBCE04BD55D80780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191112093953.GD2644@lahna.fi.intel.com>
In-Reply-To: <20191112093953.GD2644@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0185.ausprd01.prod.outlook.com
 (2603:10c6:10:52::29) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:979C0AE1EAC8437CBF786E2472A474E13FF4780DC59A035324E38B465D85E11A;UpperCasedChecksum:D86A366196B88BFF427BD9EC97251EF07498588FD79EF066411A06045BC5BB22;SizeAsReceived:7855;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lGicZRlt+YxNQzeMBfi+BtAO1uGZI1E83lZBIbRjZhOFdoSLCWxdHkkJevmmGRv5kfh7MmtrAx8=]
x-microsoft-original-message-id: <20191112141727.GA1515@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 143abaca-3534-4f7b-2399-08d7677b1077
x-ms-traffictypediagnostic: HK2APC01HT049:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJJoRt1xw/krp1pN22DcZRz1Tw89aJAwnd9MNOM/4NxMapBsbbxP5aMse/Cz9nN0Zn7VrObmVVVLTL/7DnAs9b3xWXvJj71UeswPxgk8jenQwowOcSm9dGLvfsB4bJGM7Knev5mlaUYJqdTkJb2AkrSmEIqcF7J1WSmm0ENhsQnGZIUJosSFgLVv9Fyletfv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <124377BAA364FF4B9E8600F420FBA4CB@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 143abaca-3534-4f7b-2399-08d7677b1077
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:17:35.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT049
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 11:39:53AM +0200, mika.westerberg@linux.intel.com wrote:
> On Thu, Nov 07, 2019 at 01:50:57PM +0000, Nicholas Johnson wrote:
> > Currently, the kernel can sometimes assign the MMIO_PREF window
> > additional size into the MMIO window, resulting in extra MMIO additional
> > size, despite the MMIO_PREF additional size being assigned successfully
> > into the MMIO_PREF window.
> > 
> > This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> > fails. In the next pass, because MMIO_PREF is already assigned, the
> > attempt to assign MMIO_PREF returns an error code instead of success
> > (nothing more to do, already allocated). Hence, the size which is
> > actually allocated, but thought to have failed, is placed in the MMIO
> > window.
> > 
> > Example of problem (more context can be found in the bug report URL):
> > 
> > Mainline kernel:
> > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> > pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> > 
> > Patched kernel:
> > pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> > pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> > 
> > This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> > with the same configuration, with a Ubuntu mainline kernel and a kernel
> > patched with this patch.
> > 
> > The bug results in the MMIO_PREF being added to the MMIO window, which
> > means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
> > the MMIO window will likely fail to be assigned altogether due to lack
> > of 32-bit address space.
> > 
> > Change find_free_bus_resource() to do the following:
> > - Return first unassigned resource of the correct type.
> > - If none of the above, return first assigned resource of the correct type.
> > - If none of the above, return NULL.
> > 
> > Returning an assigned resource of the correct type allows the caller to
> > distinguish between already assigned and no resource of the correct type.
> > 
> > Rename find_free_bus_resource to find_bus_resource_of_type().
> > 
> > Add checks in pbus_size_io() and pbus_size_mem() to return success if
> > resource returned from find_free_bus_resource() is already allocated.
> > 
> > This avoids pbus_size_io() and pbus_size_mem() returning error code to
> > __pci_bus_size_bridges() when a resource has been successfully assigned
> > in a previous pass. This fixes the existing behaviour where space for a
> > resource could be reserved multiple times in different parent bridge
> > windows.
> > 
> > Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243
> > 
> > Reported-by: Kit Chow <kchow@gigaio.com>
> > Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for reviewing.
> 
> Minor nits below.
> 
> > ---
> >  drivers/pci/setup-bus.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index e7dbe2170..f97c36a1e 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -752,24 +752,32 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
> >  }
> >  
> >  /*
> > - * Helper function for sizing routines: find first available bus resource
> > - * of a given type.  Note: we intentionally skip the bus resources which
> > - * have already been assigned (that is, have non-NULL parent resource).
> > + * Helper function for sizing routines.
> > + * Assigned resources have non-NULL parent resource.
> > + *
> > + * Return first unassigned resource of the correct type.
> > + * If none of the above, return first assigned resource of the correct type.
> > + * If none of the above, return NULL.
> > + *
> > + * Returning an assigned resource of the correct type allows the caller to
> > + * distinguish between already assigned and no resource of the correct type.
> >   */
> > -static struct resource *find_free_bus_resource(struct pci_bus *bus,
> > -					       unsigned long type_mask,
> > -					       unsigned long type)
> > +static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
> > +						  unsigned long type_mask,
> > +						  unsigned long type)
> >  {
> >  	int i;
> > -	struct resource *r;
> > +	struct resource *r, *r_assigned = NULL;
> 
> Maybe order them
> 
> 	struct resource *r, *r_assigned = NULL;
>  	int i;
Well, technically "r" is used before "i", although "r_assigned" is after 
"i", so I could change it, but it was not in reverse tree order, and I tend 
to leave things as they are. I will consider it.

> 
> >  
> >  	pci_bus_for_each_resource(bus, r, i) {
> >  		if (r == &ioport_resource || r == &iomem_resource)
> >  			continue;
> >  		if (r && (r->flags & type_mask) == type && !r->parent)
> >  			return r;
> > +		if (r && (r->flags & type_mask) == type && !r_assigned)
> > +			r_assigned = r;
> >  	}
> > -	return NULL;
> > +	return r_assigned;
> >  }
> >  
> >  static resource_size_t calculate_iosize(resource_size_t size,
> > @@ -866,14 +874,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >  			 struct list_head *realloc_head)
> >  {
> >  	struct pci_dev *dev;
> > -	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> > -							IORESOURCE_IO);
> > +	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
> > +								IORESOURCE_IO);
> >  	resource_size_t size = 0, size0 = 0, size1 = 0;
> >  	resource_size_t children_add_size = 0;
> >  	resource_size_t min_align, align;
> >  
> >  	if (!b_res)
> >  		return;
> 
> I think it may be good to comment here that skip the resources that are
> assigned (->parent != NULL).

Something like

/* If resource is already assigned, nothing more to do. */

OR

/* If resource is already assigned (->parent != NULL), nothing more to do */

OR something else?

> 
> > +	if (b_res->parent)
> > +		return;
> >  
> >  	min_align = window_alignment(bus, IORESOURCE_IO);
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> > @@ -978,7 +988,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  	resource_size_t min_align, align, size, size0, size1;
> >  	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
> >  	int order, max_order;
> > -	struct resource *b_res = find_free_bus_resource(bus,
> > +	struct resource *b_res = find_bus_resource_of_type(bus,
> >  					mask | IORESOURCE_PREFETCH, type);
> >  	resource_size_t children_add_size = 0;
> >  	resource_size_t children_add_align = 0;
> > @@ -986,6 +996,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  
> >  	if (!b_res)
> >  		return -ENOSPC;
> 
> Ditto.

Same as above, will use the same comment if I do one.

> 
> > +	if (b_res->parent)
> > +		return 0;
> >  
> >  	memset(aligns, 0, sizeof(aligns));
> >  	max_order = 0;
> > -- 
> > 2.23.0

Thanks,

Kind regards,
Nicholas
