Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B55100190
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKRJnn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Nov 2019 04:43:43 -0500
Received: from mail-oln040092255101.outbound.protection.outlook.com ([40.92.255.101]:45728
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfKRJnm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 04:43:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5omv5Q9uPnc6K4zWFW/+UsWylKsx0JobOF6uxDJvukV34HNatO1x/S6eUhAnUcslmQVITkHHfjcpNAxShSP/uoKipy6O5gy7PfLqhe4TkGZjcUK6Cv4f8I3SxXQa6b3lzHoNFqKf/+UQE6YTMeYp/1bwAn19Yn8VEsgpe0H0mF8GWg3Vzc79ppK0LECsgsc2T8PPg6Mz6JE8Kb/8S3yT7PXPOVK2NprJmNVzpZLswclmHJPPvd+hNuzvF87r60vlThlrDm00KEyktI6lQEWHRWZRW9nsiPQs7XYH3Xq5C/c4ysbFBtYP/6AL60IR8AjYjxAaoZm+vBi/5spAvUuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SleVUWww7QXXw2oSxlUcLFqhfq7D4cO941aPp65lx7k=;
 b=B06HQeAmouiXYL3moBgTMqvZgN75XpN4uNZguRFm5zUjWotg/nLqpIF2zLkeMh3a7KRnv9v+el6pJwL5OhMszNkt05Iewoloh+MU9rAw6yJMn4VaeTM7Ka8b6SHUuCGtcRM+Ir9JJcVmJAhFE0IB7w9HUQoXmG4Pww9BpJAIVC3Aj2QToHCseyL7eyJDPiplTP4oPkRRdELyWamMdgqvAILM4CvdjwWACY/BQewIeqSfX7WHoR1EHmT+9DV84/gmwgJHoKngBrfyAH8XoakCIFeKAmqXqWdovE58BJSTJ1W1VJ24DxO9m9hLH/DO2TJpb9oM9lJYhLG7SdJw2EkT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT059.eop-APC01.prod.protection.outlook.com
 (10.152.251.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Mon, 18 Nov
 2019 09:43:34 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.57) by
 SG2APC01FT052.mail.protection.outlook.com (10.152.251.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 09:43:34 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:43:34 +0000
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
Thread-Index: AQHVmjaUpBZrOiNs+EaePGmphxD+QaeK5IeAgAXQSwA=
Date:   Mon, 18 Nov 2019 09:43:34 +0000
Message-ID: <PS2P216MB0755848993A4445324AC516E804D0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191114165637.GA210407@google.com>
In-Reply-To: <20191114165637.GA210407@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0112.ausprd01.prod.outlook.com
 (2603:10c6:10:1::28) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:7FB88D3606022236447AE83E1521C51EF602EF044E51F6FAF466BA32A82E88DC;UpperCasedChecksum:36BEE5EE6BB7962D344A753D4E325969A517CCCD25ACE6E585A17E54174484D7;SizeAsReceived:7829;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OqRBEytzFILu8M81jd58mPHbpfhyw1gHdSMytM3FbuJ7uBVwgqpXggf4zjRqnF+Hwl7G+Vp+Hb8=]
x-microsoft-original-message-id: <20191118094326.GA2194@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 45a23db3-a5e8-4fa6-fde4-08d76c0bc70b
x-ms-traffictypediagnostic: SG2APC01HT059:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDXEcv6bzn6imJE46d8zC31ck+Ev2hNPp5YhYGxu4QlmbhgzkOd3gbf76l0SR6YcTDLzqF6Zw5ie+/fXEXz5VNiHxNJrw4FoQZCtesRhu/644K7Bkp9EZKvzayvaLI+XdMfydAUFjVy6o4oIHNc0C/1Jt1lspgTFvvpgIHQS3N5wjrZRU1Nn4rg1Jy2FRYPy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9CD7DE8AB46E5438EE71FC979C4F82A@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a23db3-a5e8-4fa6-fde4-08d76c0bc70b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:43:34.5932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT059
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

We have v5.4-rc8, so there is one more week. Please let me know if you 
have any concerns about the other four patches so that I may address 
them ASAP. If you are worried about the first one, I can re-post the 
series with it at the end, so that the others can be taken first.

Thanks!

Regards,
Nicholas

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
