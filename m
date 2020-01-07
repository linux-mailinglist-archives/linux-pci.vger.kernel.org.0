Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D7131CF0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 02:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAGBCD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 20:02:03 -0500
Received: from mail-oln040092254097.outbound.protection.outlook.com ([40.92.254.97]:39258
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbgAGBCC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 20:02:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVaC6B80M3xFwQg/WbPz95zVWzqVpI1OmgOyFF7Noi9JI9MYRqKZ+mUs10eYUcNBpi6hIrvEu64KWnAzst15e7X+RGaGUjBof0E/MMMBvfwuz3E2owRuMatR1N7lOj5ltnWtyggC7fE2NWkCJDZDXnHUhaCjVJFvzGf31hFtO60V91tg+A+/40x/aFxkLfZIUk2Yd2hibNNcVspifM1WQXykXK3vQzxloVSEddeUZ7q3h0CwBbh8vdpt3SqBlhIw96BiDkqUwRUPPYgfks8nBRZQ8SQ1ewE44FFw1mvmtmMQQLBGapYdzYmf2rOOYDJAm1X4Ilm951+s/HM3vnyc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POO4/7aZ14iuiDgytt7dV3KksrO/VTt60qo/dqGxkaY=;
 b=klar2cE7h5ZxSRNb2THoGmcBmHA9Uo8HkYZ9ftORNvVASfDknXSN8cE3kRgADgzerv20I7lCxQ5ffCLnWWJwtHlJMTaIeLK9MYRiqLvbYnWuRDP6mpSGa2t45dyE8SV5Ub5/00rooqa+TlSWerb/8x6jWcOAU4ng5v5xPAVhyCIUGHVxvyTTSKx1UTVA8Iz0+WSdKzJLFSAArMFPdwWszlJ6vGQsvgTOrFJvPmVSTjoTHuc3pXcSwoOHla4pOoiwlb+vLj0QYdRCrBd0fBHmHvGGyvHg7bnQiZib31z46cWvJBE2ViyOVIR5Ew9nwIkYvtjKGIqHTQVSuWtbMLGm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.252.51) by PU1APC01HT034.eop-APC01.prod.protection.outlook.com
 (10.152.253.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Tue, 7 Jan
 2020 01:01:57 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT024.mail.protection.outlook.com (10.152.252.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 01:01:57 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 01:01:57 +0000
Received: from nicholas-dell-linux (203.19.158.104) by ME2PR01CA0188.ausprd01.prod.outlook.com (2603:10c6:220:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 01:01:51 +0000
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
Thread-Index: AQHVxKijErSkuA6mHUWDAsVXSXsSf6feFN2AgABN4gA=
Date:   Tue, 7 Jan 2020 01:01:56 +0000
Message-ID: <PSXP216MB0438C474DBFC13EA90EB9399803F0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200106202301.GA137556@google.com>
In-Reply-To: <20200106202301.GA137556@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0188.ausprd01.prod.outlook.com
 (2603:10c6:220:20::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:5D3BF23EE1607E5B0073B04FB55D85CF9BEAA76D604277C8619AC5C4A8E92ABD;UpperCasedChecksum:B67DB935AD7E7863D7EB3638F4D97BD464ADB7D2BE33F0CB4D7B4200C53A75EF;SizeAsReceived:7937;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [xM5Ro8Sa2rkA8eIJIurXiuMIR0BXAHAi]
x-microsoft-original-message-id: <20200107010146.GA1654@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6db5a901-b0f4-44f7-30f3-08d7930d2fdc
x-ms-traffictypediagnostic: PU1APC01HT034:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /K/FwytvZG7ur+0Eu1Q70pXre08msUZUgYT1e6hscCqKqJb8QLPH35sorb43JpMIoQVcuB9IJG1jS0LzA3VoFrqYQj2LWfrv7bdDeaK4twis0SiBrli2yn7LeAIV4co3t65mPDbLk4KX3upzcYNfkd9fb7kURbCrMnE5FhmonkMgrMTLD+2oBr7aBUWKRBkv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FB79B7EA60E334C9921EC428AC7C1F1@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db5a901-b0f4-44f7-30f3-08d7930d2fdc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 01:01:56.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT034
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
More reasons why:

I have had failure to assign when adding multiple daisy-chained 
Thunderbolt devices in one enumeration (single native hotplug interrupt) 
when using add_size, but way too obscure to describe and understand. All 
I know is it went away when setting size directly. I do not use this as 
the reason because I do not understand why the failure happens, and this 
makes it difficult to defend.

Also, does avoiding unnecessary complexity count as a reason?

The most compelling might be to say that it is preparation for the next 
commit which allows it to shrink. Suppose a resource has X actual size 
and Y add_size. What if we want to shrink below X size? The code will 
have to be much more complicated to handle the logic.

How do we word a commit that is in preparation for the next patch?

"In preparation for next patch in series, ...."?

> 
> Prior to this patch, I think all the assignment and changes to
> dev->resource[] were in __assign_resources_sorted().  Maybe it's safe
> to do some here and some in __assign_resources_sorted(), but I don't
> understand it well enough to be confident.
The resource assignment right now is a black box to me. I do not 
understand how the sorting happens and what it is trying to do. I would 
prefer reduce our reliance on add_size if possible. I believe you once 
agreed you dislike how we have to do it in multiple passes, that we do 
not have the confidence it will work the first time. Is this how you 
feel? If we do not have multiple passes, a lot of the complexity goes 
away.

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

Cheers.

Regards,
Nicholas
