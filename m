Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E735115E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhDAI7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 1 Apr 2021 04:59:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58837 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233700AbhDAI7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 04:59:18 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-23-DwDWuciBMfWbUbYNbOM4gQ-1; Thu, 01 Apr 2021 09:59:13 +0100
X-MC-Unique: DwDWuciBMfWbUbYNbOM4gQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 1 Apr 2021 09:59:12 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 1 Apr 2021 09:59:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Helgaas' <helgaas@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Topic: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Index: AQHXJlJheusKxfb1K0qiX/864DlgraqfWwQw
Date:   Thu, 1 Apr 2021 08:59:12 +0000
Message-ID: <100f5a45dae14c77b341b7f1c5ea1db0@AcuMS.aculab.com>
References: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
 <20210331172210.GA1397554@bjorn-Precision-5520>
In-Reply-To: <20210331172210.GA1397554@bjorn-Precision-5520>
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

From: Bjorn Helgaas
> Sent: 31 March 2021 18:22
> 
> On Wed, Mar 31, 2021 at 11:55:08PM +0800, Zhang Rui wrote:
> > ...
> 
> > From e18c942855e2f51e814d057fff4dd951cd0d0907 Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Wed, 31 Mar 2021 20:34:13 +0800
> > Subject: [PATCH] ACPI: tables: FPDT: Fix 64bit alignment issue
> >
> > Some of the 64bit items in FPDT table may be 32bit aligned.
> > Using __attribute__((packed)) is not needed in this case, fixing it by
> > allowing 32bit alignment for these 64bit items.
> 
> 1) Can you please add a spec reference for this?  I think it's ACPI
>    v6.3, sec 5.2.23.5, or something close to that.
> 
> 2) The exact layout in memory is prescribed by the spec.  I think
>    that's basically what "packed" accomplishes.  I don't understand
>    why using "aligned" would be preferable.  Using "aligned" means
>    things can be at different offsets depending on the starting
>    address of the structure.  We always want the identical layout, no
>    matter what the starting address is.

Both 'packed' and 'aligned(4)' remove any structure alignment
padding before 64bit items that aren't on an 8 byte boundary.
(Because everything else in the structures is naturally aligned.)

The difference is significant on cpu that don't support misaligned
addresses.
Assuming that the structure is always on a 4n byte boundary
(which the ACPI spec probably requires) accesses to the 32-bit
fields are always ok.
It is only 64-bit fields that must be accessed as two 32-bit
memory cycles, not all the fields using multiple single byte
cycles.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

