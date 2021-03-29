Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80EC34CDA8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhC2KJf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 29 Mar 2021 06:09:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:50937 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232466AbhC2KJZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 06:09:25 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-88-4yJ4TLFFOSu6qY5lPx_EXg-1; Mon, 29 Mar 2021 11:09:14 +0100
X-MC-Unique: 4yJ4TLFFOSu6qY5lPx_EXg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 29 Mar 2021 11:09:13 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Mon, 29 Mar 2021 11:09:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xiaofei Tan' <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Topic: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Index: AQHXIt3reusKxfb1K0qiX/864DlgraqavWWQ
Date:   Mon, 29 Mar 2021 10:09:13 +0000
Message-ID: <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
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

From: Xiaofei Tan
> Sent: 27 March 2021 07:46
> 
> Replace __attribute__((packed)) by __packed following the
> advice of checkpatch.pl.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/acpi_fpdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a89a806..690a88a 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -53,7 +53,7 @@ struct resume_performance_record {
>  	u32 resume_count;
>  	u64 resume_prev;
>  	u64 resume_avg;
> -} __attribute__((packed));
> +} __packed;
> 
>  struct boot_performance_record {
>  	struct fpdt_record_header header;
> @@ -63,13 +63,13 @@ struct boot_performance_record {
>  	u64 bootloader_launch;
>  	u64 exitbootservice_start;
>  	u64 exitbootservice_end;
> -} __attribute__((packed));
> +} __packed;
> 
>  struct suspend_performance_record {
>  	struct fpdt_record_header header;
>  	u64 suspend_start;
>  	u64 suspend_end;
> -} __attribute__((packed));
> +} __packed;

My standard question about 'packed' is whether it is actually needed.
It should only be used if the structures might be misaligned in memory.
If the only problem is that a 64bit item needs to be 32bit aligned
then a suitable type should be used for those specific fields.

Those all look very dubious - the standard header isn't packed
so everything must eb assumed to be at least 32bit aligned.

There are also other sub-structures that contain 64bit values.
These don't contain padding - but that requires 64bit alignement.

The only problematic structure is the last one - which would have
a 32bit pad after the header.
Is this even right given than there are explicit alignment pads
in some of the other structures.

If 64bit alignment isn't guaranteed then a '64bit aligned to 32bit'
type should be used for the u64 fields.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

