Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343604BA72
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfFSNrI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 19 Jun 2019 09:47:08 -0400
Received: from mail-oln040092254085.outbound.protection.outlook.com ([40.92.254.85]:14083
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfFSNrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 09:47:08 -0400
Received: from SG2APC01FT024.eop-APC01.prod.protection.outlook.com
 (10.152.250.51) by SG2APC01HT223.eop-APC01.prod.protection.outlook.com
 (10.152.251.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 13:47:00 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.57) by
 SG2APC01FT024.mail.protection.outlook.com (10.152.250.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1987.11 via Frontend Transport; Wed, 19 Jun 2019 13:47:00 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e%3]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 13:47:00 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVEKrwZ8ZhpR4YvEesf8rGWnkYA6afvpeAgAPxFIA=
Date:   Wed, 19 Jun 2019 13:47:00 +0000
Message-ID: <SL2P216MB0187526E3B79F6251231F97380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190617093513.GN2640@lahna.fi.intel.com>
In-Reply-To: <20190617093513.GN2640@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0192.ausprd01.prod.outlook.com
 (2603:10c6:10:52::36) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:47992E5ED99851BD8F1622CCAF958E701B1190B5FC117CF456DCD4285C547944;UpperCasedChecksum:ED6AFFBD2A12D55F86A5900342CDCA73CB514F474295305DA8BAFFD557BA6FE4;SizeAsReceived:7924;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Uw0hYmXdcGRczyN3JoH5jaQuHkeYy9L8XMAr2z56HSFsuFsHF862yfJjMt4RSGOkybxzri5kwdA=]
x-microsoft-original-message-id: <20190619214649.GB12283@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT223;
x-ms-traffictypediagnostic: SG2APC01HT223:
x-microsoft-antispam-message-info: v++VkpRNbXw0MDUc4HezIaIMayNBpMvJjF7WvnVRcjeJi57Q6Exg1bgaQqZvDVmtnUUGQJlnTUUipSQEYFFbC1WgiFsUijzV+j/Qeco1We4GcrEn/sBFDW+Hs/wEW5OUm30BdTN6fQNwVeijRjMkW8GNFyn+amQUYbzZGMuj1FAwZAlUpy2tV/Q2OGHJjU2o
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2C64DD018C21B48A30BF26EC2056865@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f743e6-6a9a-46a6-751d-08d6f4bc9a4d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 13:47:00.2472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT223
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Again, I am re-sending my previous response with reply-all instead of 
plain reply. Mika, you can ignore this as you have already seen it. For 
everybody else, everything below the line should be exactly the same as 
I copied it over. 
_______________________________________________________________________________


On Mon, Jun 17, 2019 at 12:35:13PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, May 22, 2019 at 02:30:44PM +0000, Nicholas Johnson wrote:
> > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > with different resource alignment requirements. Pass more details
> > arguments recursively to track the resource start and end addresses
> > relative to the initial hotplug bridge. This is especially useful for
> > Thunderbolt with native PCI enumeration, enabling external graphics
> > cards and other devices with bridge alignment higher than 0x100000
>  
> Instead of 0x100000 you could say 1MB here.
My train of thought is 1MB is sometimes means base-10 but then again, 
that is probably outside of the kernel world. I can change it to 1MB.

> 
> > bytes.
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
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> 
> The logic makes sense to me but since you probably need to spin another
> revision anyway please find a couple of additional comments below.
> 
> > ---
> >  drivers/pci/setup-bus.c | 169 ++++++++++++++++++++--------------------
> >  1 file changed, 84 insertions(+), 85 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 0cdd5ff38..1b5b851ca 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1835,12 +1835,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  }
> >  
> >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > -					    struct list_head *add_list,
> > -					    resource_size_t available_io,
> > -					    resource_size_t available_mmio,
> > -					    resource_size_t available_mmio_pref)
> > +	struct list_head *add_list, struct resource io,
> > +	struct resource mmio, struct resource mmio_pref)
> >  {
> > -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> >  	struct pci_dev *dev, *bridge = bus->self;
> > @@ -1850,29 +1848,36 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> >  
> >  	/*
> > -	 * Update additional resource list (add_list) to fill all the
> > -	 * extra resource space available for this port except the space
> > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > -	 * devices currently connected to the port and below.
> > +	 * The alignment of this bridge is yet to be considered, hence it must
> > +	 * be done now before extending its bridge window. A single bridge
> > +	 * might not be able to occupy the whole parent region if the alignment
> > +	 * differs - for example, an external GPU at the end of a Thunderbolt
> > +	 * daisy chain.
> 
> As Bjorn also commented there is nothing Thunderbolt specific here so I
> would leave it out of the comment because it is kind of confusing.
Okay, I can remove "A single bridge.... daisy chain".
Please correct me if that is not what you meant.

> 
> >  	 */
> > -	extend_bridge_window(bridge, io_res, add_list, available_io);
> > -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> > -	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > -			     available_mmio_pref);
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
> >  
> >  	/*
> > -	 * Calculate the total amount of extra resource space we can
> > -	 * pass to bridges below this one.  This is basically the
> > -	 * extra space reduced by the minimal required space for the
> > -	 * non-hotplug bridges.
> > +	 * Update the resources to fill as much remaining resource space in the
> > +	 * parent bridge as possible, while considering alignment.
> >  	 */
> > -	remaining_io = available_io;
> > -	remaining_mmio = available_mmio;
> > -	remaining_mmio_pref = available_mmio_pref;
> > +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> > +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> > +	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > +		resource_size(&mmio_pref));
> 
> Please write it like it was originally (e.g align the second line to the
> opening bracket):
> 
> 	extend_bridge_window(bridge, mmio_pref_res, add_list, resource_size(&mmio_pref));
Can do. The style of handling line overflows is still throwing me.

> 
> >  
> >  	/*
> >  	 * Calculate how many hotplug bridges and normal bridges there
> > -	 * are on this bus.  We will distribute the additional available
> > +	 * are on this bus. We will distribute the additional available
> >  	 * resources between hotplug bridges.
> >  	 */
> >  	for_each_pci_bridge(dev, bus) {
> > @@ -1882,104 +1887,98 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			normal_bridges++;
> >  	}
> >  
> > +	/*
> > +	 * There is only one bridge on the bus so it gets all possible
> > +	 * resources which it can then distribute to the possible
> > +	 * hotplug bridges below.
> > +	 */
> > +	if (hotplug_bridges + normal_bridges == 1) {
> > +		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > +		if (dev->subordinate)
> > +			pci_bus_distribute_available_resources(dev->subordinate,
> > +				add_list, io, mmio, mmio_pref);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Reduce the available resource space by what the
> > +	 * bridge and devices below it occupy.
> > +	 */
> >  	for_each_pci_bridge(dev, bus) {
> > -		const struct resource *res;
> > +		struct resource *res;
> > +		resource_size_t used_size;
> 
> Here order these in "reverse christmas tree" like:
> 
> 		resource_size_t used_size;
> 		struct resource *res;
That seems reasonable.

> 
> >  
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
> > -	/*
> > -	 * There is only one bridge on the bus so it gets all available
> > -	 * resources which it can then distribute to the possible hotplug
> > -	 * bridges below.
> > -	 */
> > -	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate) {
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, available_io, available_mmio,
> > -				available_mmio_pref);
> > -		}
> > +	if (!hotplug_bridges)
> >  		return;
> > -	}
> >  
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
> 
> Here also write it like:
> 
> 	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> 				    hotplug_bridges);
Okay.

> 
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
> > -		 *
> > -		 * Here hotplug_bridges is always != 0.
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
> 
> Ditto.
Okay.

> 
> >  
> > -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> > -						       mmio_pref);
> > +		io.start = io.end + 1;
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
> > +	struct resource io_res, mmio_res, mmio_pref_res;
> >  
> >  	if (!bridge->is_hotplug_bridge)
> >  		return;
> >  
> > +	io_res = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> > +	mmio_res = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> > +	mmio_pref_res = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> > +
> >  	/* Take the initial extra resources from the hotplug port */
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> > -	available_io = resource_size(res);
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> > -	available_mmio = resource_size(res);
> > -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> > -	available_mmio_pref = resource_size(res);
> >  
> >  	pci_bus_distribute_available_resources(bridge->subordinate,
> > -					       add_list, available_io,
> > -					       available_mmio,
> > -					       available_mmio_pref);
> > +		add_list, io_res, mmio_res, mmio_pref_res);
> >  }
> >  
> >  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> > -- 
> > 2.20.1
> > 
