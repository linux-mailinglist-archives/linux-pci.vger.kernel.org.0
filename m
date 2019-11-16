Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9921FEA4E
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKPCyO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 15 Nov 2019 21:54:14 -0500
Received: from mail-oln040092253054.outbound.protection.outlook.com ([40.92.253.54]:50720
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfKPCyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Nov 2019 21:54:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUET1yondbMSqggZyz/rNQkYmH+6uo1txYZQd9MWeKx5m31HIzHBIcjh/qxP7cG/Jju5Zfzm+7SltGIPmfCZDOKO791i8As1GgAlignCeeuqNBMVQ1g8eTyi6fAsjohHgbJ7/09wOj1zk3wl8brM5lcjayDjL/ygpAdKSR81pXV9IUkQJr9ijbJbpjweZrOvEuvoMgxEs/3ygpAGGp9/a6dZHAVKKWJcRjRe6FKcG2c2JMsr3NtADDZXQMr/DQAQVlkYoBHVvudO2Wty59cH81umQfxW8Jw8ZP2QF5G0XcQFNcEaahJihflZG85XlV4cbJajB/4hKjxE1sOSTQogjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fjqsVIl3FtlxTT3o/fv4klQPNbSp7yqsuMqGfrAZac=;
 b=UawtrDd9Mo4zjtcQvmtR4QSQ0uqgDWlL/ehs4k3gwC3t8KgnFDorDtAonFbyv/GK2ZsO5Qmdw2Pn/Mxey/K1if/lAy7/rnYhMmtJX4p+gLHqk2O5oTw4wASRk7EfhQFjwjQb6AP4Dy1QMY2EgJy8iulO+xr/GUsR+PtqYafdyxbx6Rlpnt5BTkdy197qbYpUAJHYcRW6/I8/eHcsWUaUN23fET4dWMEeDhuOW+87FFCETPEwvAQK2BjWkceHTDyYiijY6U0k/bF5Knv0fdvu7/6HJzGp5Ml2iMgYR6vYLEAj1ct0VffgtFUqBZA34sRYrPbPajeYrKkN7Y9EDezM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT048.eop-APC01.prod.protection.outlook.com
 (10.152.248.58) by HK2APC01HT048.eop-APC01.prod.protection.outlook.com
 (10.152.249.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Sat, 16 Nov
 2019 02:54:07 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.248.56) by
 HK2APC01FT048.mail.protection.outlook.com (10.152.249.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Sat, 16 Nov 2019 02:54:07 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 02:54:07 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVmjaUpBZrOiNs+EaePGmphxD+QaeK5IeAgAI5PIA=
Date:   Sat, 16 Nov 2019 02:54:06 +0000
Message-ID: <PS2P216MB0755107EEBF97CBA382F3B9B80730@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191114165637.GA210407@google.com>
In-Reply-To: <20191114165637.GA210407@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0100.ausprd01.prod.outlook.com
 (2603:10c6:10:1::16) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:0438560C5855D668D7B754242FAF09CC6843683AC5E7BC394CC4AB871DD3DC8F;UpperCasedChecksum:9A34DB4269550FC64FDE8C49B13DD4CC9FAFA297C9D34FA9EC6852BA53DB829A;SizeAsReceived:7855;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [iq4FwKwKr7806eZjTYOF2wfQTe59vR60cXJYWcp/RCxfLun9d6+l7qf4LB95Z7iacxr4Kac0Jzc=]
x-microsoft-original-message-id: <20191116025359.GA34872@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6857698b-a669-4a11-e838-08d76a403ee0
x-ms-traffictypediagnostic: HK2APC01HT048:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XiHCQUo2vLEcsRMz0+MLce/OvFpq0+ezZxgGGKGBebTFiNT93hyalygYZ/KIud1pYX64NJ9K4AfLdsZUhHqUG8tOIMkh4cE2BG9ehHQUAXWB1fo/vWbQmtFNzOi/jPML/Ai29lDRoQqTMxfLNIyHpnRcpdrzKhyS6/2m/ZPsHDBxncOQfnJrempStWznwfY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DBDCB932479B0438A5463A4491EEAFD@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6857698b-a669-4a11-e838-08d76a403ee0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 02:54:06.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT048
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 14, 2019 at 10:56:37AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 13, 2019 at 03:25:28PM +0000, Nicholas Johnson wrote:
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
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied with reviewed-by from Mika and Logan to pci/resource for v5.5,
> thanks!

Awesome, thanks. Now where do we stand on my last four patches?
I hope there will be Linux 5.4-rc8, which will give us another week.

> 
> > ---
> >  drivers/pci/setup-bus.c | 38 +++++++++++++++++++++++++++-----------
> >  1 file changed, 27 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 6b64bf909..f382f449b 100644
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
> > +	struct resource *r, *r_assigned = NULL;
> >  	int i;
> > -	struct resource *r;
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
> > @@ -866,8 +874,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
> > @@ -875,6 +883,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >  	if (!b_res)
> >  		return;
> >  
> > +	/* If resource is already assigned, nothing more to do. */
> > +	if (b_res->parent)
> > +		return;
> > +
> >  	min_align = window_alignment(bus, IORESOURCE_IO);
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> >  		int i;
> > @@ -978,7 +990,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  	resource_size_t min_align, align, size, size0, size1;
> >  	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
> >  	int order, max_order;
> > -	struct resource *b_res = find_free_bus_resource(bus,
> > +	struct resource *b_res = find_bus_resource_of_type(bus,
> >  					mask | IORESOURCE_PREFETCH, type);
> >  	resource_size_t children_add_size = 0;
> >  	resource_size_t children_add_align = 0;
> > @@ -987,6 +999,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  	if (!b_res)
> >  		return -ENOSPC;
> >  
> > +	/* If resource is already assigned, nothing more to do. */
> > +	if (b_res->parent)
> > +		return 0;
> > +
> >  	memset(aligns, 0, sizeof(aligns));
> >  	max_order = 0;
> >  	size = 0;
> > -- 
> > 2.24.0
> > 
