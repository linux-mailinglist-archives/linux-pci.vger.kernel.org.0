Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0598133880
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 02:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgAHBgM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 7 Jan 2020 20:36:12 -0500
Received: from mail-oln040092253098.outbound.protection.outlook.com ([40.92.253.98]:11536
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgAHBgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 20:36:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1i+5BDnktXXGgekSCoTiai1blyub9gNDpmh6JQXvXBSye1vuYR3Kcrt7oaOnZY01cORdjjrD0HYWMCvwX6XiEtZaDVF/lIIgbt8hVOJCLpOQB7MVPqVMmiAav85mn/EenHdXPgZC6ToHKQ+VqObvYN8cs9DCn5JHqlSV4mLDzU/yBSby5EhmlxmB199dZm75HqP8gJ4cehw2yHYuhtrLKBiEktNAReGO4sEcXbKefKMCBfIH9i6pGl0XIKBdL1ogW27xioXhtTs1HOcwzXxyjq+COqKrmjt43vTlPhD9E9nP1eD54J83HGwmXnrus5Dvp7COluxZ5l0PnFvd2gcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU9IA3ORmy1hN5eZVZnN9XnImhAgoK8TPlTKEACdVmo=;
 b=iCmlumefxhJRsOQLXtq4qyEio4Z9JmKApcPuA5oG/1fZkv++/P8qNuCLHFLxx7FrDVRV80S+sOwiauBHQt5LeV0ezeQfWOoPW/eJO1jQb0fU6MC/fk65ydAUbbQyjgtzxdGCmqayBCD6zCO9s2HirBDvQtrmoTfE8zOzw7pyFxSv0NKYg5kmMR+ERLf4ZVVEb7uKq9BjmhKysCrFoYtgHkyhb8WQfUlmaUr81gwqEF2zoMzYX5jXEn+3jCUYXDPJbf46lfggH33YsePkgFr1aXkahPn0j5pvu9d5ZQGfr7a6YtZ9zB8+kFc6R1y2fA3E5MxtEiMgJLhfaNixT2GlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT014.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT123.eop-APC01.prod.protection.outlook.com
 (10.152.249.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 8 Jan
 2020 01:36:04 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.55) by
 HK2APC01FT014.mail.protection.outlook.com (10.152.248.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 8 Jan 2020 01:36:04 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 01:36:04 +0000
Received: from nicholas-dell-linux (203.19.158.104) by MEAPR01CA0119.ausprd01.prod.outlook.com (2603:10c6:220:60::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 01:36:02 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Topic: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Thread-Index: AQHVxKivCsNYvp642Ua95PoPKOxpR6ffqm2AgABUMwA=
Date:   Wed, 8 Jan 2020 01:36:04 +0000
Message-ID: <PSXP216MB043869924730BFD3AA97B0A0803E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200107203435.GA137091@google.com>
In-Reply-To: <20200107203435.GA137091@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:220:60::35) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:8DA756BBDA81C4B187142AB5234E7FFF0B0DDF135BC41EF00A0E1C32C4F8836B;UpperCasedChecksum:38C3644AE5261448732578300B3A3F6F2BADB88CB7502784A63DDB28EAA7E0E4;SizeAsReceived:7939;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4fsT/JdvO6mfxSzpxQnmUOaxrC50RCSp]
x-microsoft-original-message-id: <20200108013556.GA1712@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6d4b8edd-37a9-4e0c-4df2-08d793db1fe6
x-ms-traffictypediagnostic: HK2APC01HT123:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Mi+Kqcax18bMbdpj20him1JHAOVZctE6SGLyHXFxsYRCa7IbGTjLowUWw8Y01MqQJl/rpkWzomzBqDSNc8gDqV3pYPRUkVFXfdYz3318gw7fwaNtpKuJVbA4DxoBtb2W1ePzJ1MoU/0TPX/XO3aJD/nutBglS3iTC21OABBu+chFgdac5Yc8u45rSC4w/Tz87inK/gG22SWKVmkb2gYf0lhouVfd7cxqAUSO7wIacE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A96258237306AE41B5C4C3E938420962@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b8edd-37a9-4e0c-4df2-08d793db1fe6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 01:36:04.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT123
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 07, 2020 at 02:34:35PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 06, 2020 at 03:48:06PM +0000, Nicholas Johnson wrote:
> > Remove checks for resource size in extend_bridge_window(). This is
> > necessary to allow the pci_bus_distribute_available_resources() to
> > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > allocate resources. Because the kernel parameter sets the size of all
> > hotplug bridges to be the same, there are problems when nested hotplug
> > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > and normal bridges with non-zero size Y into parent hotplug bridge with
> > size X is impossible, and hence the downstream hotplug bridge needs to
> > shrink to fit into its parent.
> 
> s/extend_bridge_window()/adjust_bridge_window()/ above
> s/to allow the/to allow/

Okay
> 
> If this patch allows pci_bus_distribute_available_resources() to
> function when pci=hpmemsize=nn is used, what happens *before* this
> patch?  The text implies that pci_bus_distribute_available_resources()
> doesn't function, but what happens?  Do we try to assign a downstream
> bridge requiring X+n inside an upstream window of size X and the
> assignment fails, leaving the downstream bridge unusable?

I could add something similar to this to the log:

The hpmemsize is applied to add_size of every hotplug bridge, even 
nested ones. Say we set hpmemsize=256M, the upstream hotplug bridge gets 
256M. Then when we hot-add a Thunderbolt device with daisy chaining, the 
new nested bridge also gets 256M and this will not fit because some 
further space has been consumed by the endpoints in the Thunderbolt 
device. Hence, we cannot extend.

It works for Mika because he is interested in the cases when the 
firmware assigns the resources, hence hpmemsize=2M (default) and it does 
not cause problems, unless we run out of space and need to go below 2M.
> 
> > Add check for if bridge is extended or shrunken and reflect that in the
> > call to pci_dbg().
> > 
> > Reset the resource if its new size is zero (if we have run out of a
> > bridge window resource) to prevent the PCI resource assignment code from
> > attempting to assign a zero-sized resource.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 0c51f4937..e7e57bf72 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1836,18 +1836,25 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  				 struct list_head *add_list,
> >  				 resource_size_t new_size)
> >  {
> > -	resource_size_t add_size;
> > +	resource_size_t add_size, size = resource_size(res);
> >  
> >  	if (res->parent)
> >  		return;
> >  
> > -	if (resource_size(res) >= new_size)
> > -		return;
> > +	if (new_size > size) {
> > +		add_size = new_size - size;
> > +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> > +			&add_size);
> > +	} else if (new_size < size) {
> > +		add_size = size - new_size;
> > +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> > +			&add_size);
> > +	}
> 
> Where's the patch that changes the caller so "new_size" may be smaller
> than "size"?  I guess it must be "[3/3] PCI: Consider alignment of
> hot-added bridges ..." because that's the only one that makes a
> non-trivial change, right?

As above, there was always a possibility of the new_size being smaller. 
For some reason, 1M is assigned to bridges, even if nothing is below 
them (for example, unused non hotplug bridges in a Thunderbolt dock). It 
may be an edge case if we are low on space, but theoretically it can 
happen.

Also, when writing this, Mika was not interested in using hpmemsize, 
which, when used, will cause new_size to be smaller than the current 
size (actual size and add_size combined).

So it does not need a patch to cause "new_size" to be smaller than 
"size" - just a change in user behaviour to use pci=hpmemsize.
> 
> > -	add_size = new_size - resource_size(res);
> > -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
> >  	res->end = res->start + new_size - 1;
> >  	remove_from_list(add_list, res);
> > +	if (!new_size)
> > +		reset_resource(res);
> 
> I consider reset_resource() to be deprecated because it throws away
> res->flags, which tells us what kind of resource it is
> (mem/io/32-bit/64-bit/prefetchable).  We learn this during
> enumeration, and we shouldn't forget the information until we remove
> the device.

I will look at this, but I distinctly remember doing this because of IO 
BARs which would run out and cause the device not to be enabled.

Can you please comment on IORESOURCE_UNSET and what effect that would 
have if applied to the flags. Also, can you suggest any other solution 
other than making it handle zero-sized resources better? I agree, that 
would be ideal to make it handle zero-sized resources, but given the 
state of drivers/pci/setup-bus.c, I feel like it will just recursively 
open up more cans of worms until we metaphorically stack overflow. And I 
am happy to go down that path. But at some point I feel we will have to 
make some compromises / stop-gap measures to apply some patches and make 
progress, before going down that road. Would you agree?
> 
> If the resource assignment code doesn't do the right thing with a
> zero-sized resource, I think we should fix that code.  Clearing the
> resource struct does nothing with the hardware BAR or window
> registers, so the BAR/window remains enabled unless we do something
> more.  If we don't need a window and we want to disable it, we can do
> that, but it requires writing special values to the hardware
> registers.
> 
> Bjorn

https://lkml.org/lkml/2020/1/7/1544

You describe this as "black magic code", what appears to be the 
assignment code which handles lists of resources. And I agree. I believe 
it is in both our interests to avoid using add_size because nobody 
understands how these are handled. There may be bugs, and there is 
definitely lots of complexity involved. I believe simplicity is key. 
Hence why these changes in this series:

- Change resource size directly instead of using add_size

- Aside from the currently known cases of needing to shrink the 
resource, we cannot know that there will not be more cases of this in 
the future. There is no need for preventing it from shrinking - we have 
an available size for the bridge window, and if that happens to be 
smaller than the bridge window, we have no choice but to shrink. I 
believe this makes the check unnecessary and warrants removal.

Regards,
Nicholas
