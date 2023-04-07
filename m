Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D96DB64A
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDGWG7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 7 Apr 2023 18:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDGWG6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 18:06:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFF61BD
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 15:06:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-243-G0FjREPYMRu8FypquixOww-1; Fri, 07 Apr 2023 23:06:53 +0100
X-MC-Unique: G0FjREPYMRu8FypquixOww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 7 Apr
 2023 23:06:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 7 Apr 2023 23:06:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIe cycle sequence when updating the msi-x table
Thread-Topic: PCIe cycle sequence when updating the msi-x table
Thread-Index: AdlpadQ6VkkNAoyZRj6svqE6jQb3+QAGLhmAAAXinkA=
Date:   Fri, 7 Apr 2023 22:06:52 +0000
Message-ID: <ed0017284c324cf68f05a20ac86b7b35@AcuMS.aculab.com>
References: <b2d1bb86ea4642d2aa01ebd9d3d7a77e@AcuMS.aculab.com>
 <87edovtqki.ffs@tglx>
In-Reply-To: <87edovtqki.ffs@tglx>
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
> Sent: 07 April 2023 20:56
..
> > But there is a bigger problem.
> > As the comment says writing the address/data while an entry is
> > unmasked must be avoided (because a mixture of the old and new
> > values could easily by used for the PCIe write cycle).
> >
> > But it is also quite likely that that hardware checks the masked
> > bit before/after reading the address+data.
> >
> > So masking the interrupt immediately before the update and/or
> > unmasking immediately after could also cause issues.
> 
> No it does not, because the writes are strictly ordered.
> 
> So the devices gets:
> 
>    1) write to control register with MASKBIT set
>    2) write to LOWER_ADDRESS
>    3) write to UPPER_ADDRESS
>    4) write to ENTRY_DATA
>    5) write to control register with MASKBIT cleared
> 
> #1 disables the vector and the device is not allowed to use the msg data
> from the table entry until the mask bit is cleared again.
> 
> If the device gets that wrong then that's a bug in the device and not a
> kernel problem.

Maybe, but the kernel isn't making it easy for a device
state-engine that has to do four separate reads of an
internal 32-bit memory area.
Adding a short delay between #4 and #5 is likely to avoid
some very hard to debug issues if the hardware reads the
values 'mask last', if it reads them 'mask first' you need
a short delay between #1 and #2.

Anything fpga based is likely to be using a 32bit memory
block for the MSI-X data (possibly even 16bit).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

