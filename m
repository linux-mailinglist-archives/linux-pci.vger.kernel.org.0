Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7813CB31
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAORl2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:41:28 -0500
Received: from mail-oln040092254098.outbound.protection.outlook.com ([40.92.254.98]:40992
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbgAORl1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:41:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHMYlEisu5bObXCP7VJZRFWUvYq/pm3WZRP3vyBOhjmwXjLnswUgS9AI9nStUr8jbK9ANc9oa5ezlZavPvcF6caXMox3zpDdY9SxLS/xrNJRWdB5vPdbvn4NA1ecDNe1Zeu3R+B3iCyicZFQ2+Ii02ieA2kcrxX8aQ5PVqXE7yiAL09H1UhHefqApUYd0gttlvksZOInYoWaMjD911keDmxpyZVwzK4KwQCFWp13vIa00xFaQWO7YMv48/nO9slDF/6X2aJ1WEMQn/L59xnRuKXhcIwx98JlZeyAo8lQaij2GGwrqdIuKpmsgG2ITi7AMJK0CdO/sMe61+8WmVVHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8BEnF5eE7oIezSTRFxpC2oUgcQ+ql6JGr6nvCiXoIk=;
 b=S3qgy92r784YZ0Yh+6UHDRwH6uWdKAX+zpxliwnnyf8lx+hVzyeXKcnDFxne8DzLwvZdqFzZqs0YtgEayLvL8KpMnQMksPV7YPbt8PEZ5/y0b7Gq1LgJXjZHjLmoOrICSle+bN0svXQchE2NJetG2CinDxHUsPHakOx81tSV07DHDMdewHU82p+o+gtW8G05p0qFrBdBfKXs5clUJZtez5fGVKtdw25IURzo9GcCkXFTtZT8ayQBbumx7HsmHnx5EgNqoM7A/54j3OihCG0TU/UJnRnp1+CZC//eEJ09AJdjr3CMVRT954nCsOw0o+PsCqDCY5d9+8bhLW78DFnlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT089.eop-APC01.prod.protection.outlook.com
 (10.152.251.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:41:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.54) by
 SG2APC01FT003.mail.protection.outlook.com (10.152.250.130) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 17:41:22 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:41:21 +0000
Received: from nicholas-dell-linux (61.69.138.108) by MEAPR01CA0080.ausprd01.prod.outlook.com (2603:10c6:220:35::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 17:41:19 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set resource
 size directly
Thread-Topic: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Thread-Index: AQHVxKijErSkuA6mHUWDAsVXSXsSf6feFN2AgA33yAA=
Date:   Wed, 15 Jan 2020 17:41:21 +0000
Message-ID: <PSXP216MB043820DCE0911B8DBFD29D5B80370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200106202301.GA137556@google.com>
In-Reply-To: <20200106202301.GA137556@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:220:35::20) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:2BDB3E64EF504330BBCE5EEB8A9496782DE4955C06C60AD743AFC3FF53197E0C;UpperCasedChecksum:2D3C5F16C527382329DDCF7CE08FBF3451AD9756C2F7F6A536A040AFE0D2300F;SizeAsReceived:7950;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [0vTLCpfi6ThKP/dKxfERdgIKXzMwZ9XV]
x-microsoft-original-message-id: <20200115174114.GA4225@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 231c77c1-9ce8-4317-b6ae-08d799e221fb
x-ms-traffictypediagnostic: SG2APC01HT089:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5nedS4Bkw5rJ7jukS2AGbqUcq7EeXv2uArxWWH2cdVmhQ/HCf1uZbI4DSH7Xd5jeiZGc4EV+KqjrnxMrGoWeXwQM+E7T0+fHpwoyIkRTnenY32UHuulHZbVY9zJTqaijzcxFjBaI7E4H7ZicTN5poPQ514GjUWS+2sGggDITsivZeIzxkccy/sDWwVsHv3l
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82DAE899746B6C49A7D97B375F11A421@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 231c77c1-9ce8-4317-b6ae-08d799e221fb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:41:21.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT089
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 02:23:01PM -0600, Bjorn Helgaas wrote:
> Thanks a lot for splitting these up.  It makes these dramatically
> easier to read.
> 
> On Mon, Jan 06, 2020 at 03:47:46PM +0000, Nicholas Johnson wrote:
> > Change extend_bridge_window() to set resource size directly instead of
> > using additional resource lists.
> > 
> > Because additional resource lists are optional resources, any algorithm
> > that requires guaranteed allocation that uses them cannot be guaranteed
> > to work.
> 
> There is never a guarantee that PCI resource assignment will work.
> It's always possible that we don't have enough resources to allow us
> to enable a device.  So I'm not sure what this is telling me, and it
> doesn't seem like a justification for setting the resource size
> directly here.
> 
> Prior to this patch, I think all the assignment and changes to
> dev->resource[] were in __assign_resources_sorted().  Maybe it's safe
> to do some here and some in __assign_resources_sorted(), but I don't
> understand it well enough to be confident.
> 
> > Remove the resource from add_list, as a zero-sized additional resource
> > is redundant.
> > 
> > Update comment in pci_bus_distribute_available_resources() to reflect
> > the above changes.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index de43815be..0c51f4937 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1836,7 +1836,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  				 struct list_head *add_list,
> >  				 resource_size_t new_size)
> >  {
> > -	struct pci_dev_resource *dev_res;
> > +	resource_size_t add_size;
> >  
> >  	if (res->parent)
> >  		return;
> > @@ -1844,17 +1844,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  	if (resource_size(res) >= new_size)
> >  		return;
> >  
> > -	dev_res = res_to_dev_res(add_list, res);
> > -	if (!dev_res)
> > -		return;
> > -
> > -	/* Is there room to extend the window? */
> > -	if (new_size - resource_size(res) <= dev_res->add_size)
> > -		return;
> > -
> > -	dev_res->add_size = new_size - resource_size(res);
> > -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> > -		&dev_res->add_size);
> > +	add_size = new_size - resource_size(res);
> > +	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
> > +	res->end = res->start + new_size - 1;
> 
> How do we know it's safe to extend this, i.e., how do we know there's
> nothing immediately after res?
Sorry, I do not remember answering this one before, must have missed it.

Because we return if assigned (res->parent not NULL), this resource has 
not been assigned. Hence, the desired alignment is .start and the 
desired size is set by setting the .end = .start + size - 1. The address 
is not yet absolute. If we make it bigger then the kernel will take that 
into account when handing out addresses.

Also, since this resource is not yet assigned, neither are the other 
ones around it. pci_bus_distribute_available_resources() is called on 
the native hotplug interrupt when a device (such as Thunderbolt 3) is 
added.

> 
> > +	remove_from_list(add_list, res);
> >  }
> >  
> >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > @@ -1889,11 +1882,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
> >  			mmio_pref.end + 1);
> >  
> > -	/*
> > -	 * Update additional resource list (add_list) to fill all the
> > -	 * extra resource space available for this port except the space
> > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > -	 * devices currently connected to the port and below.
> > +        /*
> > +	 * Now that we have adjusted for alignment, update the bridge window
> > +	 * resources to fill as much remaining resource space as possible.
> >  	 */
> >  	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
> >  	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> > -- 
> > 2.24.1
> > 
