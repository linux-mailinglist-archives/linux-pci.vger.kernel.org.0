Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2568C6DC6A6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDJMRE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 10 Apr 2023 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDJMRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 08:17:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2E2723
        for <linux-pci@vger.kernel.org>; Mon, 10 Apr 2023 05:17:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-h7sCt7k5Pi61YB9RdCydcg-1; Mon, 10 Apr 2023 13:16:58 +0100
X-MC-Unique: h7sCt7k5Pi61YB9RdCydcg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 10 Apr
 2023 13:16:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 10 Apr 2023 13:16:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe cycle sequence when updating the msi-x table
Thread-Topic: PCIe cycle sequence when updating the msi-x table
Thread-Index: AdlpadQ6VkkNAoyZRj6svqE6jQb3+QAGLhmAAAXinkAAdY+dAAAMVsrA
Date:   Mon, 10 Apr 2023 12:16:54 +0000
Message-ID: <e11d35073f2145b8a9d5e9f4f12c0bb6@AcuMS.aculab.com>
References: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
 <87edovtqki.ffs@tglx> <ed0017284c324cf68f05a20ac86b7b35@AcuMS.aculab.com>
 <875ya4temr.ffs@tglx>
In-Reply-To: <875ya4temr.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner
> Sent: 10 April 2023 07:50
...
> Whatever order this reads does not matter. The point is:
> 
>   "Mask Bit - When this bit is Set, the Function is prohibited from
>    sending a message using this MSI-X Table entry."
> 
> So you cannot make this read order dependent at all.
> 
> > Anything fpga based is likely to be using a 32bit memory
> > block for the MSI-X data (possibly even 16bit).
> 
> It's trivial enough to latch the message on unmask into a shadow
> register set and let the state engine work from there.

I could implement the memory block inside the MSI_X logic
and then detect writes.
Anything else uses a lot more fpga resource.

> And no, we are not adding random delays to that code just because.

I was mostly suggesting one be moved.
(Changing the address/data is hardly a hot path.)

Actually I'm trying to work out what the readbacks in the MSI-X
code are actually for (apart from adding a 'random delay').

If you are masking one of the PCI INTx lines, then a readback
delays the cpu until the physical line is de-asserted so that
the IRQ line into the interrupt controlled is de-asserted and
thus the IRQ to the cpu is also de-asserted.
Even if the cpu commits to the interrupt, the interrupt controller
reports 'no vector' (or vector 7 if it is the 8259).
So you can safely do a readback, enable interrupts and know
the interrupt won't happen.
(Although if you have a real 8259 you need to worry about
the cycle recovery time, even a 286 will break it!)

But MSI-X is different, it is very much edge sensitive.
The target MSI-X logic can decide to raise an interrupt
just before the mask bit it set.
It will then request the target's PCIe interface issue
the write TLP, this is probably a 'posted' write in the
internal logic. The PCIe interface could be busy generating
a long write TLP (or two) before actually issuing write for
the interrupt.
The readback will be pretty much back-to-back with the mask write
(as seen on the target).
So maybe the rad can get completed while the write is still
queued.
Now I can't remember whether the data TLP for reads is allowed
to overtake a posted write request, but it really doesn't matter.
Even if the IRQ write arrives at the root hub before the
read completion they then head off in different directions
through the 'cpu' logic - so the read could easily complete
well before the interrupt gets processed.

In fact an interrupt requested well before the mask bit is set
could be pending in the ioapic waiting for the cpu to enable
interrupts.

So I don't see any reason for those readbacks at all.

I've never looked at the cpu end of MSI-X, but I suspect that
stop using an interrupts you need to mask it there first,
then disable the hardware and later make sure you clear
any lurking pending request (probably before unmasking for
later use).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

