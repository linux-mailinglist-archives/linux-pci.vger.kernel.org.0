Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B40E1688
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbfJWJrJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 05:47:09 -0400
Received: from mail-oln040092254106.outbound.protection.outlook.com ([40.92.254.106]:2560
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403909AbfJWJrJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSUAI2Uxp+5iqX0ooxCaK6d9UclWky4ERQbSXeG8UwXllkNKmEAEhV34Sh9PbO9xzJN41YI4Iw9a85IoCeNe+XhCdQIId12vpPK1IpEuNn06E6qhEMrPPNe3cVyWL1Eh6bdjfo9pO2kvIGLjI2wBBtY43Lxo+zIPmZX+PIYPbK3zwUbRGF5iPGRLavIEbsf2/4nr7Ho49/s7oIfr66n1vwVtoNsi5gee5BLHLF8pGePerwHINqKi58RZB6WcssxG7vEbH135s4BKoe2I7tZNex1LRBYStMqmz5klN/ByRl1paQycbopzSIHIryTRJFZDObSyhD2saZG10sVbNPNhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFST4M7NLTPP0Y66dKe3OYuUoTlNSMdlcYjpSUrB0PQ=;
 b=kB/PEqOhmKiDTeuuhySzgm/+95D5YILrEWGkzn0lT5VzEUSqiC39aptdbUuBHWWMvSkiVXlh7hGJeyMQKp9UbxkQcScLVypMWkTzU2LPMT3fx84E1G2Nz+mUZ3Z2sQQAb852tuhmqVj5rnsMYhILzT3De4EmerVHvI3jjU2uTIHGMYA6zVKAQOwH1/0ZP8WooqUtspy85A+3dakgoO6pSp7VD7LKDVA1DJYicJAlk/YPHTETdjJejU24Xj8XlM1w9dGIrA3/MtjwaaTsnaJ7HKUB/HP1cm/iuEABe5inSveRJNPIc30r0ns+MVM7PyfWzsHG0AkChV3DXdSnJ7xxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT051.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT216.eop-APC01.prod.protection.outlook.com
 (10.152.249.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Wed, 23 Oct
 2019 09:47:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT051.mail.protection.outlook.com (10.152.248.224) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 09:47:01 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 09:47:00 +0000
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
Thread-Index: AQHVQ7EZa70KBVuJtk2j2TFbHr0vZqdRElgAgBdpKYCAAAczgIAAA4EA
Date:   Wed, 23 Oct 2019 09:47:00 +0000
Message-ID: <SL2P216MB0187DFA5572CD4FAA3275AA0806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191008113812.GF2819@lahna.fi.intel.com>
 <PSXP216MB0183D447FD3ADF6F82979439806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
 <20191023093419.GR2819@lahna.fi.intel.com>
In-Reply-To: <20191023093419.GR2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0171.ausprd01.prod.outlook.com
 (2603:10c6:220:20::15) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:B9100ACEE3301E91BB421CC86680213BF13BA6502148B0D51B8E0C0DDE5FBC94;UpperCasedChecksum:DBD93652A9EC9B8A9D877755D434B3315B3C639A0CAE0A7DF2BCC7CD97E09554;SizeAsReceived:7865;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Wpei4/Jvl4exgV6cxpDx8rQ63C9t1SBxDGxYwbQQ3aA=]
x-microsoft-original-message-id: <20191023094652.GA4742@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: HK2APC01HT216:
x-ms-exchange-purlcount: 2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNGrXJ4sbZ0Ay5Nm67KYtOGX60dGlvahznEvl7yxEJ6kaFdh6Lx3lB7EjOmmrFAK/of1pJGN/J3Sa9AThyJg2vHHkdsGvPZ4nRx25xdtecZEopqZfS0vSdnHM1HFWycAJLCwN+jBosCcJeSbx0y/xlthRYUtKnDPJPDxc5/IV4Ru9fXhLhEHiiNIj8ZOfy8qYYkhrWJ+Dx4w/CeUdAHoYmkFh8qtuVxkyfhfutcVMkE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33D03E8B7D970243880B47B1A5086340@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a6045e-c622-4b45-3526-08d7579df399
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:47:00.9048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT216
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:34:19PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 23, 2019 at 09:08:42AM +0000, Nicholas Johnson wrote:
> > On Tue, Oct 08, 2019 at 02:38:12PM +0300, mika.westerberg@linux.intel.com wrote:
> > > Hi Nicholas,
> > 
> > Hi Mika,
> > 
> > I apologise for not responding quickly . I have switched off for a while 
> > - taking my time to post the patches based on Linux 5.4. Hence, I was 
> > not expecting any emails on this, and was not checking. Plus I was 
> > starting to lose motivation.
> > 
> > I have been taking the time to change how I approach this. I am going to 
> > post the patches to egpu.io forums to get a heap of people testing it 
> > and hopefully saying nice things about it. Originally I thought it would 
> > be quick to get the patches accepted so I was only going to announce 
> > this after being accepted.
> > 
> > I also realised my patch series should not be a series. None of this is 
> > specific to Thunderbolt and hence should not be a series. By separating 
> > parts of this series, it may be easier to sign off and accept.
> > 
> > > 
> > > On Fri, Jul 26, 2019 at 12:53:19PM +0000, Nicholas Johnson wrote:
> > > > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > > > with different resource alignment requirements. Pass more details
> > > > arguments recursively to track the resource start and end addresses
> > > > relative to the initial hotplug bridge. This is especially useful for
> > > > Thunderbolt with native PCI enumeration, enabling external graphics
> > > > cards and other devices with bridge alignment higher than 1MB.
> > > > 
> > > > Change extend_bridge_window to resize the actual resource, rather than
> > > > using add_list and dev_res->add_size. If an additional resource entry
> > > > exists for the given resource, zero out the add_size field to avoid it
> > > > interfering. Because add_size is considered optional when allocating,
> > > > using add_size could cause issues in some cases, because successful
> > > > resource distribution requires sizes to be guaranteed. Such cases
> > > > include hot-adding nested hotplug bridges in one enumeration, and
> > > > potentially others which are yet to be encountered.
> > > > 
> > > > Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> > > 
> > > Here better to use:
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> > > 
> > > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > 
> > > This solves the issue I reported so,
> > > 
> > > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > So this is adding "Tested-by" on top of "Reported-by" and not replacing 
> > one with the other?
> 
> Yes.
> 
> > > 
> > > There are a couple of comments below.
> > > 
> > > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > ---
> > > >  drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
> > > >  1 file changed, 71 insertions(+), 77 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > > index 79b1fa651..6835fd64c 100644
> > > > --- a/drivers/pci/setup-bus.c
> > > > +++ b/drivers/pci/setup-bus.c
> > > > @@ -1840,12 +1840,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> > > >  }
> > > >  
> > > >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > > > -					    struct list_head *add_list,
> > > > -					    resource_size_t available_io,
> > > > -					    resource_size_t available_mmio,
> > > > -					    resource_size_t available_mmio_pref)
> > > > +	struct list_head *add_list, struct resource io,
> > > > +	struct resource mmio, struct resource mmio_pref)
> > > 
> > > You pass a copy of each resource because you modify it inplace. I wonder
> > > if it makes more sense to explicitly take a copy here with comments?
> > 
> > I have no qualms with modifying parameters, and sometimes quite like 
> > doing it. I could do as you suggest but that means more lines of diff, 
> > and Bjorn seems to be sending me a strong message that the less lines of 
> > diff, the better.
> > 
> > I just noticed this: https://lkml.org/lkml/2019/10/4/337
> > 
> > Bjorn says I am touching critical and complicated code that he does not 
> > understand. This could explain his aversion to more lines of diff.
> > 
> > If Bjorn will trust you to sign this off and take your assurance that it 
> > is fine, then I can start taking your advice over his. I have been 
> > favouring his advice because I figured he would have the final say as 
> > the PCI subsystem maintainer.
> 
> Yes, if Bjorn says something you should listen to him and not me ;-)
> 
> I'm just trying to help him to review this because I think this is
> important stuff.
> 
> This indeed touches the resource allocation code which is rather old and
> not too well understood but then again it should not prevent us to
> extend and make it better to support more configurations.

There is one file that I understand better than any other in Linux - 
that is drivers/pci/setup-bus.c

I understand it well enough that I was able to do a fairly big rewrite 
for my own purposes some time ago. It was mostly educational. What I 
learned is how broken everything is. A lot of problems stem from the 
fact that we are trying to support BIOS allocation and native at the 
same time. The two need to be mutually exclusive. X86 seems to be the 
biggest block from going to native. The amount of stuff in the X86 arch 
folder is crazy - and then you have riscv/ with almost nothing - which 
is how it should be, in my opinion.

In other words, we are stuck in an unpleasant situation with no way out.

> 
> > > > -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > > > +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> > > >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> > > >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> > > >  	struct pci_dev *dev, *bridge = bus->self;
> > > > @@ -1855,15 +1853,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > > >  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> > > >  
> > > >  	/*
> > > > -	 * Update additional resource list (add_list) to fill all the
> > > > -	 * extra resource space available for this port except the space
> > > > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > > > -	 * devices currently connected to the port and below.
> > > > +	 * The alignment of this bridge is yet to be considered, hence it must
> > > > +	 * be done now before extending its bridge window.
> > > >  	 */
> > > > -	extend_bridge_window(bridge, io_res, add_list, available_io);
> > > > -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> > > > +	align = pci_resource_alignment(bridge, io_res);
> > > > +	if (!io_res->parent && align)
> > > > +		io.start = ALIGN(io.start, align);
> > > > +
> > > > +	align = pci_resource_alignment(bridge, mmio_res);
> > > > +	if (!mmio_res->parent && align)
> > > > +		mmio.start = ALIGN(mmio.start, align);
> > > > +
> > > > +	align = pci_resource_alignment(bridge, mmio_pref_res);
> > > > +	if (!mmio_pref_res->parent && align)
> > > > +		mmio_pref.start = ALIGN(mmio_pref.start, align);
> > > > +
> > > > +	/*
> > > > +	 * Update the resources to fill as much remaining resource space in the
> > > > +	 * parent bridge as possible, while considering alignment.
> > > > +	 */
> > > > +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> > > > +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> > > >  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > > > -			     available_mmio_pref);
> > > > +		resource_size(&mmio_pref));
> > > 
> > > I think this should be aligned like:
> > > 
> > >  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > > 			     resource_size(&mmio_pref));
> > Me too, I do not know how that one slipped past me.
> > 
> > > 
> > > 
> > > >  
> > > >  	/*
> > > >  	 * Calculate how many hotplug bridges and normal bridges there
> > > > @@ -1884,108 +1896,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > > >  	 */
> > > >  	if (hotplug_bridges + normal_bridges == 1) {
> > > >  		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > > -		if (dev->subordinate) {
> > > > +		if (dev->subordinate)
> > > >  			pci_bus_distribute_available_resources(dev->subordinate,
> > > > -				add_list, available_io, available_mmio,
> > > > -				available_mmio_pref);
> > > > -		}
> > > > +				add_list, io, mmio, mmio_pref);
> > > >  		return;
> > > >  	}
> > > >  
> > > > -	if (hotplug_bridges == 0)
> > > > -		return;
> > > > -
> > > >  	/*
> > > > -	 * Calculate the total amount of extra resource space we can
> > > > -	 * pass to bridges below this one.  This is basically the
> > > > -	 * extra space reduced by the minimal required space for the
> > > > -	 * non-hotplug bridges.
> > > > +	 * Reduce the available resource space by what the
> > > > +	 * bridge and devices below it occupy.
> > > 
> > > This can be widen:
> > I avoided changing comments because Bjorn said it creates distracting 
> > noise. But I am considering changing tactics because what I have been 
> > doing has not been working.
> 
> If Bjorn says so then you can just ignore my comment :)
