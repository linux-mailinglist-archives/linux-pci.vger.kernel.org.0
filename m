Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42653C1D4E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3Ioh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 30 Sep 2019 04:44:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:40767 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfI3Ioh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 04:44:37 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-183-j4N9f3qOMMSLrCtcdRHqUA-1; Mon, 30 Sep 2019 09:44:33 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Sep 2019 09:44:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Sep 2019 09:44:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Helgaas' <helgaas@kernel.org>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
CC:     Sam Bobroff <sbobroff@linux.ibm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v5 03/23] PCI: hotplug: Add a flag for the movable BARs
 feature
Thread-Topic: [PATCH v5 03/23] PCI: hotplug: Add a flag for the movable BARs
 feature
Thread-Index: AQHVdX/SDCNoZo9XCkSW2ss2y9eB6qdD51Gg
Date:   Mon, 30 Sep 2019 08:44:33 +0000
Message-ID: <16a86a9e4b464897acee0aeba34d9346@AcuMS.aculab.com>
References: <20190816165101.911-4-s.miroshnichenko@yadro.com>
 <20190927220219.GA57201@google.com>
In-Reply-To: <20190927220219.GA57201@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: j4N9f3qOMMSLrCtcdRHqUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas
> Sent: 27 September 2019 23:02
> On Fri, Aug 16, 2019 at 07:50:41PM +0300, Sergey Miroshnichenko wrote:
> > When hot-adding a device, the bridge may have windows not big enough (or
> > fragmented too much) for newly requested BARs to fit in. And expanding
> > these bridge windows may be impossible because blocked by "neighboring"
> > BARs and bridge windows.
> >
> > Still, it may be possible to allocate a memory region for new BARs with the
> > following procedure:
> >
> > 1) notify all the drivers which support movable BARs to pause and release
> >    the BARs; the rest of the drivers are guaranteed that their devices will
> >    not get BARs moved;
> >
> > 2) release all the bridge windows except of root bridges;
> >
> > 3) try to recalculate new bridge windows that will fit all the BAR types:
> >    - fixed;
> >    - immovable;
> >    - movable;
> >    - newly requested by hot-added devices;
> >
> > 4) if the previous step fails, disable BARs for one of the hot-added
> >    devices and retry from step 3;
> >
> > 5) notify the drivers, so they remap BARs and resume.
> 
> You don't do the actual recalculation in *this* patch, but since you
> mention the procedure here, are we confident that we never make things
> worse?
> 
> It's possible that a hot-add will trigger this attempt to move things
> around, and it's possible that we won't find space for the new device
> even if we move things around.  But are we certain that every device
> that worked *before* the hot-add will still work *afterwards*?
> 
> Much of the assignment was probably done by the BIOS using different
> algorithms than Linux has, so I think there's some chance that the
> BIOS did a better job and if we lose that BIOS assignment, we might
> not be able to recreate it.

Yep, removing everything and starting again is probably OTT and most of the churn won't help.

I think you need to work out what can be moved in order to make the required resources available
to each bus and then make the required changes.

In the simplest case you are trying to add resource below a bridge so need to 'shuffle'
everything allocated after that bridge to later addresses (etc).

Many devices that support address reassignment might not need to be moved - so there is
no point remmapping them.

There is also the case when a device that is present but not currently is use could be taken
through a remove+insert sequence in order to change its resources.
Much easier to implement than 'remap while active'.
This would require a call into the driver (than can sleep) to request whether it is idle.
(and probably one at the end if the remove wasn't done).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

