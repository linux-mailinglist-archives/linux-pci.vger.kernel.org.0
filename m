Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7027D14A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgI2OfH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Sep 2020 10:35:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33844 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729299AbgI2OfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 10:35:07 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 10:35:05 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-61-ZaxFTzRNPfG963eBr-HtoA-2; Tue, 29 Sep 2020 15:28:46 +0100
X-MC-Unique: ZaxFTzRNPfG963eBr-HtoA-2
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 29 Sep 2020 15:28:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 29 Sep 2020 15:28:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sherry Sun' <sherry.sun@nxp.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWljzyKmM/fdkzH06RNY+P7PsXKql/aOeAgAAnh9CAABtZEA==
Date:   Tue, 29 Sep 2020 14:28:43 +0000
Message-ID: <a8a0e23c6d1044b795aa3559542d80ac@AcuMS.aculab.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-3-sherry.sun@nxp.com>
 <20200929102419.GB7784@infradead.org>
 <VI1PR04MB4960404C6A13953B137AD39B92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4960404C6A13953B137AD39B92320@VI1PR04MB4960.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sherry Sun
> Sent: 29 September 2020 14:02
> 
> Hi Christoph,
> 
> > > diff --git a/include/uapi/linux/mic_common.h
> > > b/include/uapi/linux/mic_common.h index 504e523f702c..e680fe27af69
> > > 100644
> > > --- a/include/uapi/linux/mic_common.h
> > > +++ b/include/uapi/linux/mic_common.h
> > > @@ -56,8 +56,6 @@ struct mic_device_desc {
> > >   * @vdev_reset: Set to 1 by guest to indicate virtio device has been reset.
> > >   * @guest_ack: Set to 1 by guest to ack a command.
> > >   * @host_ack: Set to 1 by host to ack a command.
> > > - * @used_address_updated: Set to 1 by guest when the used address
> > > should be
> > > - * updated.
> > >   * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
> > >   * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
> > >   */
> > > @@ -67,7 +65,6 @@ struct mic_device_ctrl {
> > >  	__u8 vdev_reset;
> > >  	__u8 guest_ack;
> > >  	__u8 host_ack;
> > > -	__u8 used_address_updated;
> > >  	__s8 c2h_vdev_db;
> > >  	__s8 h2c_vdev_db;
> > >  } __attribute__ ((aligned(8)));
> >
> > This is an ABI change.
> 
> Yes, it is. But I noticed that this structure is only used by the vop driver.
> And until now I haven't seen any user tools use it, including the user tool
> mpssd which is corresponding to the vop driver.

Just rename it as 'must_be_zero'.

I've just looked at the header.
WTF is all the __attribute__ ((aligned(8))); about?
Someone is really trying to make it slow on anything other than x86.
It would have been much better to ensure the structure members
are all 'naturally aligned'.

I'm not sure of the usage of the mic_device_ctrl structure.
But you really don't want to share a structure that has
adjacent bytes written by two different entities.
Even with coherent memory you probably should have
separated the data by cache line.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

