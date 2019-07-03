Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D675E8AA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCQWM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 3 Jul 2019 12:22:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26676 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfGCQWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 12:22:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-4-dcW7BxwpPYiTYuimYvjOZQ-1; Wed, 03 Jul 2019 17:22:08 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 3 Jul 2019 17:22:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Jul 2019 17:22:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fuqian Huang' <huangfq.daxian@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 17/30] pci: Use kmemdup rather than duplicating its
 implementation
Thread-Topic: [PATCH 17/30] pci: Use kmemdup rather than duplicating its
 implementation
Thread-Index: AQHVMaGVcqH5pEZk40qaY1F2K7RQ7Ka5E1TQ
Date:   Wed, 3 Jul 2019 16:22:07 +0000
Message-ID: <d185554023eb4de08c366184cceb681f@AcuMS.aculab.com>
References: <20190703131627.25455-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703131627.25455-1-huangfq.daxian@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dcW7BxwpPYiTYuimYvjOZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fuqian Huang
> Sent: 03 July 2019 14:16
> 
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/pci/hotplug/ibmphp_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index 17124254d897..0e340e105c3b 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -1261,19 +1261,18 @@ static int __init ibmphp_init(void)
> 
>  	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> 
> -	ibmphp_pci_bus = kmalloc(sizeof(*ibmphp_pci_bus), GFP_KERNEL);
> -	if (!ibmphp_pci_bus) {
> -		rc = -ENOMEM;
> -		goto exit;
> -	}
> -
>  	bus = pci_find_bus(0, 0);
>  	if (!bus) {
>  		err("Can't find the root pci bus, can not continue\n");
>  		rc = -ENODEV;
>  		goto error;
>  	}
> -	memcpy(ibmphp_pci_bus, bus, sizeof(*ibmphp_pci_bus));
> +
> +	ibmphp_pci_bus = kmemdup(bus, sizeof(*ibmphp_pci_bus), GFP_KERNEL);
> +	if (!ibmphp_pci_bus) {
> +		rc = -ENOMEM;
> +		goto exit;
> +	}

Not sure why I even looked as this...

But the error path if pci_find_bus() fails is now wrong.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

