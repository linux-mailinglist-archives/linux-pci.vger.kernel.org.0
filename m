Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3F27D2E9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgI2PjI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Sep 2020 11:39:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34342 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgI2PjI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 11:39:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-d_J_rhScNZCl3nkQi2pUWw-1;
 Tue, 29 Sep 2020 16:39:04 +0100
X-MC-Unique: d_J_rhScNZCl3nkQi2pUWw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 29 Sep 2020 16:39:03 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 29 Sep 2020 16:39:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@infradead.org>,
        Sherry Sun <sherry.sun@nxp.com>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: RE: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Topic: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as
 noncached
Thread-Index: AQHWlktQ7pIMmph8j02KaWKexsD6oKl/u5wQ
Date:   Tue, 29 Sep 2020 15:39:03 +0000
Message-ID: <38d86b352ed6452ea225aa45e81af390@AcuMS.aculab.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-5-sherry.sun@nxp.com>
 <20200929102833.GD7784@infradead.org>
In-Reply-To: <20200929102833.GD7784@infradead.org>
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

From: Christoph Hellwig
> Sent: 29 September 2020 11:29
...
> You can't call remap_pfn_range on memory returned from
> dma_alloc_coherent (which btw is not marked uncached on many platforms).
> 
> You need to use the dma_mmap_coherent helper instead.

Hmmmm. I've a driver that does that.
Fortunately it only has to work on x86 where it doesn't matter.
However I can't easily convert it.
The 'problem' is that the mmap() request can cover multiple
dma buffers and need not start at the beginning of one.

Basically we have a PCIe card that has an inbuilt iommu
to convert internal 32bit addresses to 64bit PCIe ones.
This has 512 16kB pages.
So we do a number of dma_alloc_coherent() for 16k blocks.
The user process then does an mmap() for part of the buffer.
This request is 4k aligned so we do multiple remap_pfn_range()
calls to map the disjoint physical (and kernel virtual)
buffers into contiguous user memory.

So both ends see contiguous addresses even though the physical
addresses are non-contiguous.

I guess I could modify the vm_start address and then restore
it at the end.

I found this big discussion:
https://lore.kernel.org/patchwork/patch/351245/
about these functions.

The bit about VIPT caches is problematic.
I don't think you can change the kernel address during mmap.
What you need to do is defer allocating the user address until
you know the kernel address.
Otherwise you get into problems is you try to mmap the
same memory into two processes.
This is a general problem even for mmap() of files.
ISTR SYSV on some sparc systems having to use uncached maps.

If you might want to mmap two kernel buffers (dma or not)
into adjacent user addresses then you need some way of
allocating the second buffer to follow the first one
in the VIVT cache.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

