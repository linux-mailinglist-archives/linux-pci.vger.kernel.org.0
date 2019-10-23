Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2621DE1555
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbfJWJIu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 05:08:50 -0400
Received: from mail-oln040092255027.outbound.protection.outlook.com ([40.92.255.27]:63059
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732361AbfJWJIu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKE/0iqub3Acs/0FVCdjPR+crx0xtp4dPZOcsjDUSNgwSllYcnH7sjHnew9lGeR6Zmxf7YRVXm+zjJRRTUKPEeKXHeeK/gq8yw2YMN8XP30OvmzUhGFtUmX6BOK1Z0LUoWb9TT3vy1CuuQP8B59uOXozJfYtblcdWx5IMEwVUjoogaXDqwSju77CK9lapU6tsM+gb2DfnbWo5NtV8oE+/OuaIMwuihSJPLqviktwpvfHQehLS918v1L4j6RoOnkvEUB229+3zK1LUqNrh/FnYTl6YT2flzl6lF5MebaU+niMxAe72I8JP6rdzk0sEE9eQ39KBna9qNTx7lAZLxtIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpU1UxbijEdqCK55TcAKobcCYrC//1Kf5pSiN89wgHQ=;
 b=Y8wniH5KugVr1U+VaFDvUyCvgsU8U4TRrI2QjJWX7/+AWpYuVwg2gr/tAxR499azHF7T/BY3nZ+lec06cSq0O3XYyVyeouyEH49bliNMCLv+VMs0E1M9QA9oW+Cb764y6+ZxLpuhHIaff4Wqcjt4wGTUN1+ZMGKRTWuVbVKyT9iRuYlztX4q6V0HA6LEi3E36kuKpcaHaJUPbK3wMecgq5rruvCp7+KO8bEZXcJiARasFvAN9tncBnTYFy3mP8IpRIdHho3x7u7bjPeMpTk/0P72gl+I+sAYDp8gkmmWGFzvkk2VHm9zHWFuncvDIBuPK04yjiOGDfYN7nWgJyPghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT021.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT040.eop-APC01.prod.protection.outlook.com
 (10.152.249.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 23 Oct
 2019 09:08:42 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT021.mail.protection.outlook.com (10.152.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 09:08:42 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266]) by PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266%5]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 09:08:42 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVQ7EZa70KBVuJtk2j2TFbHr0vZqdRElgAgBdpKYA=
Date:   Wed, 23 Oct 2019 09:08:42 +0000
Message-ID: <PSXP216MB0183D447FD3ADF6F82979439806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191008113812.GF2819@lahna.fi.intel.com>
In-Reply-To: <20191008113812.GF2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0042.ausprd01.prod.outlook.com (2603:10c6:201::30)
 To PSXP216MB0183.KORP216.PROD.OUTLOOK.COM (2603:1096:300:b::17)
x-incomingtopheadermarker: OriginalChecksum:3767FB093B39EE0D7DBC7971C5DE5599032C8107910F26B29995CA31F1F99837;UpperCasedChecksum:7C463FF3C0CE956847475B4A36E34A7DE2B96EEC0294814B02B0EBB910D0520D;SizeAsReceived:8023;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RLe/rMbyNuXpHuw2TGoXB8/WSNbInjqOgp+JIMQ7Zzk=]
x-microsoft-original-message-id: <20191023090833.GA4080@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: HK2APC01HT040:
x-ms-exchange-purlcount: 2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br5j7t69NQgrYnG4F8G0l2gssZ6mCfsDwHTC0fjl8XV09NKFn9+Ro9EtJq/N8/WzMq1JFPh6Grwstpz1XqetgvVksR+XgYG+LUdevjMyxcI9NvMmc3xu+4REeNNyEhUI13EFaNBgPzE2jts4oRIW6BVESTKZsMxy9C3ENXIFc9ZLUPPVeAaNIjV+x1ObhJPi+3/di19xUIZAjhWeFUXQ4jnXvLpN6W9rrgqVycXy9lE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54E8293FE1B95649A1277C7EF8B6058C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: deb7a137-ff85-4c10-09b0-08d757989991
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:08:42.4686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT040
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 02:38:12PM +0300, mika.westerberg@linux.intel.com wrote:
> Hi Nicholas,

Hi Mika,

I apologise for not responding quickly . I have switched off for a while 
- taking my time to post the patches based on Linux 5.4. Hence, I was 
not expecting any emails on this, and was not checking. Plus I was 
starting to lose motivation.

I have been taking the time to change how I approach this. I am going to 
post the patches to egpu.io forums to get a heap of people testing it 
and hopefully saying nice things about it. Originally I thought it would 
be quick to get the patches accepted so I was only going to announce 
this after being accepted.

I also realised my patch series should not be a series. None of this is 
specific to Thunderbolt and hence should not be a series. By separating 
parts of this series, it may be easier to sign off and accept.

> 
> On Fri, Jul 26, 2019 at 12:53:19PM +0000, Nicholas Johnson wrote:
> > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > with different resource alignment requirements. Pass more details
> > arguments recursively to track the resource start and end addresses
> > relative to the initial hotplug bridge. This is especially useful for
> > Thunderbolt with native PCI enumeration, enabling external graphics
> > cards and other devices with bridge alignment higher than 1MB.
> > 
> > Change extend_bridge_window to resize the actual resource, rather than
> > using add_list and dev_res->add_size. If an additional resource entry
> > exists for the given resource, zero out the add_size field to avoid it
> > interfering. Because add_size is considered optional when allocating,
> > using add_size could cause issues in some cases, because successful
> > resource distribution requires sizes to be guaranteed. Such cases
> > include hot-adding nested hotplug bridges in one enumeration, and
> > potentially others which are yet to be encountered.
> > 
> > Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> 
> Here better to use:
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> 
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> This solves the issue I reported so,
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
So this is adding "Tested-by" on top of "Reported-by" and not replacing 
one with the other?

> 
> There are a couple of comments below.
> 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
> >  1 file changed, 71 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 79b1fa651..6835fd64c 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1840,12 +1840,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  }
> >  
> >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > -					    struct list_head *add_list,
> > -					    resource_size_t available_io,
> > -					    resource_size_t available_mmio,
> > -					    resource_size_t available_mmio_pref)
> > +	struct list_head *add_list, struct resource io,
> > +	struct resource mmio, struct resource mmio_pref)
> 
> You pass a copy of each resource because you modify it inplace. I wonder
> if it makes more sense to explicitly take a copy here with comments?

I have no qualms with modifying parameters, and sometimes quite like 
doing it. I could do as you suggest but that means more lines of diff, 
and Bjorn seems to be sending me a strong message that the less lines of 
diff, the better.

I just noticed this: https://lkml.org/lkml/2019/10/4/337

Bjorn says I am touching critical and complicated code that he does not 
understand. This could explain his aversion to more lines of diff.

If Bjorn will trust you to sign this off and take your assurance that it 
is fine, then I can start taking your advice over his. I have been 
favouring his advice because I figured he would have the final say as 
the PCI subsystem maintainer.

> 
> >  {
> > -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> >  	struct pci_dev *dev, *bridge = bus->self;
> > @@ -1855,15 +1853,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> >  
> >  	/*
> > -	 * Update additional resource list (add_list) to fill all the
> > -	 * extra resource space available for this port except the space
> > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > -	 * devices currently connected to the port and below.
> > +	 * The alignment of this bridge is yet to be considered, hence it must
> > +	 * be done now before extending its bridge window.
> >  	 */
> > -	extend_bridge_window(bridge, io_res, add_list, available_io);
> > -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> > +	align = pci_resource_alignment(bridge, io_res);
> > +	if (!io_res->parent && align)
> > +		io.start = ALIGN(io.start, align);
> > +
> > +	align = pci_resource_alignment(bridge, mmio_res);
> > +	if (!mmio_res->parent && align)
> > +		mmio.start = ALIGN(mmio.start, align);
> > +
> > +	align = pci_resource_alignment(bridge, mmio_pref_res);
> > +	if (!mmio_pref_res->parent && align)
> > +		mmio_pref.start = ALIGN(mmio_pref.start, align);
> > +
> > +	/*
> > +	 * Update the resources to fill as much remaining resource space in the
> > +	 * parent bridge as possible, while considering alignment.
> > +	 */
> > +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> > +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> >  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > -			     available_mmio_pref);
> > +		resource_size(&mmio_pref));
> 
> I think this should be aligned like:
> 
>  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> 			     resource_size(&mmio_pref));
Me too, I do not know how that one slipped past me.

> 
> 
> >  
> >  	/*
> >  	 * Calculate how many hotplug bridges and normal bridges there
> > @@ -1884,108 +1896,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	 */
> >  	if (hotplug_bridges + normal_bridges == 1) {
> >  		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate) {
> > +		if (dev->subordinate)
> >  			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, available_io, available_mmio,
> > -				available_mmio_pref);
> > -		}
> > +				add_list, io, mmio, mmio_pref);
> >  		return;
> >  	}
> >  
> > -	if (hotplug_bridges == 0)
> > -		return;
> > -
> >  	/*
> > -	 * Calculate the total amount of extra resource space we can
> > -	 * pass to bridges below this one.  This is basically the
> > -	 * extra space reduced by the minimal required space for the
> > -	 * non-hotplug bridges.
> > +	 * Reduce the available resource space by what the
> > +	 * bridge and devices below it occupy.
> 
> This can be widen:
I avoided changing comments because Bjorn said it creates distracting 
noise. But I am considering changing tactics because what I have been 
doing has not been working.

> 
> 
> 	/*
> 	 * Reduce the available resource space by what the bridge and
> 	 * devices below it occupy.
> 	 */
> 
> 
> >  	 */
> > -	remaining_io = available_io;
> > -	remaining_mmio = available_mmio;
> > -	remaining_mmio_pref = available_mmio_pref;
> > -
> >  	for_each_pci_bridge(dev, bus) {
> > -		const struct resource *res;
> > +		struct resource *res;
> > +		resource_size_t used_size;
> 
> Some people like "reverse christmas tree" format better:
We had this discussion a while ago, and Bjorn piped in and said it is 
not enforced. However, I will give it a go this time.

> 
> 		resource_size_t used_size;
> 		struct resource *res;
> 
> Can it be const, BTW?
I will admit that despite loving the C language, const has always 
escaped me. As far as I can tell, it is there for the programmer and 
compiler optimisations, with no functional changes. I will see what 
happens.

> 
> >  		if (dev->is_hotplug_bridge)
> >  			continue;
> >  
> > -		/*
> > -		 * Reduce the available resource space by what the
> > -		 * bridge and devices below it occupy.
> > -		 */
> >  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
> > -		if (!res->parent && available_io > resource_size(res))
> > -			remaining_io -= resource_size(res);
> > +		align = pci_resource_alignment(dev, res);
> > +		align = align ? ALIGN(io.start, align) - io.start : 0;
> > +		used_size = align + resource_size(res);
> > +		if (!res->parent && used_size <= resource_size(&io))
> > +			io.start += used_size;
> >  
> >  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
> > -		if (!res->parent && available_mmio > resource_size(res))
> > -			remaining_mmio -= resource_size(res);
> > +		align = pci_resource_alignment(dev, res);
> > +		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> > +		used_size = align + resource_size(res);
> > +		if (!res->parent && used_size <= resource_size(&mmio))
> > +			mmio.start += used_size;
> >  
> >  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
> > -		if (!res->parent && available_mmio_pref > resource_size(res))
> > -			remaining_mmio_pref -= resource_size(res);
> > +		align = pci_resource_alignment(dev, res);
> > +		align = align ? ALIGN(mmio_pref.start, align) -
> > +				mmio_pref.start : 0;
> > +		used_size = align + resource_size(res);
> > +		if (!res->parent && used_size <= resource_size(&mmio_pref))
> > +			mmio_pref.start += used_size;
> >  	}
> >  
> > +	if (!hotplug_bridges)
> > +		return;
> > +
> >  	/*
> > -	 * Go over devices on this bus and distribute the remaining
> > -	 * resource space between hotplug bridges.
> > +	 * Distribute any remaining resources equally between
> > +	 * the hotplug-capable downstream ports.
> >  	 */
> > -	for_each_pci_bridge(dev, bus) {
> > -		resource_size_t align, io, mmio, mmio_pref;
> > -		struct pci_bus *b;
> > +	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> > +	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> > +	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> > +		hotplug_bridges);
> >  
> > -		b = dev->subordinate;
> > -		if (!b || !dev->is_hotplug_bridge)
> > +	for_each_pci_bridge(dev, bus) {
> > +		if (!dev->subordinate || !dev->is_hotplug_bridge)
> >  			continue;
> >  
> > -		/*
> > -		 * Distribute available extra resources equally between
> > -		 * hotplug-capable downstream ports taking alignment into
> > -		 * account.
> > -		 */
> > -		align = pci_resource_alignment(bridge, io_res);
> > -		io = div64_ul(available_io, hotplug_bridges);
> > -		io = min(ALIGN(io, align), remaining_io);
> > -		remaining_io -= io;
> > -
> > -		align = pci_resource_alignment(bridge, mmio_res);
> > -		mmio = div64_ul(available_mmio, hotplug_bridges);
> > -		mmio = min(ALIGN(mmio, align), remaining_mmio);
> > -		remaining_mmio -= mmio;
> > +		io.end = io.start + io_per_hp - 1;
> > +		mmio.end = mmio.start + mmio_per_hp - 1;
> > +		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
> >  
> > -		align = pci_resource_alignment(bridge, mmio_pref_res);
> > -		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
> > -		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
> > -		remaining_mmio_pref -= mmio_pref;
> > +		pci_bus_distribute_available_resources(dev->subordinate,
> > +			add_list, io, mmio, mmio_pref);
> >  
> > -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> > -						       mmio_pref);
> > +		io.start = io.end + 1;
> 
> I think you can also write it like:
> 
> 		io.start += io_per_hp;
You are possibly correct - and it is impressive that you saw that. I 
never did. The way that I have written it fits in with the thought 
patterns I used to create it ("set the start of the next window to be 
just after the end of the last"). I will take this suggestion as you 
wanting it written that way (provided testing goes fine).

> 
> > +		mmio.start = mmio.end + 1;
> > +		mmio_pref.start = mmio_pref.end + 1;
> >  	}
> >  }
> >  
> >  static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
> >  						     struct list_head *add_list)
> >  {
> > -	resource_size_t available_io, available_mmio, available_mmio_pref;
> > -	const struct resource *res;
> > +	struct resource io, mmio, mmio_pref;
> >  
> >  	if (!bridge->is_hotplug_bridge)
> >  		return;
> >  
> >  	/* Take the initial extra resources from the hotplug port */
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> > -	available_io = resource_size(res);
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> > -	available_mmio = resource_size(res);
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> > -	available_mmio_pref = resource_size(res);
> > +	io = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> > +	mmio = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> > +	mmio_pref = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> >  
> > -	pci_bus_distribute_available_resources(bridge->subordinate,
> > -					       add_list, available_io,
> > -					       available_mmio,
> > -					       available_mmio_pref);
> > +	pci_bus_distribute_available_resources(bridge->subordinate, add_list,
> > +					       io, mmio, mmio_pref);
> >  }
> >  
> >  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> > -- 
> > 2.22.0

Thanks for reviewing.

Regards,
Nicholas
