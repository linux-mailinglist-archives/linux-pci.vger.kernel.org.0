Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D97621EB06
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 10:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgGNIKG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 14 Jul 2020 04:10:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:51957 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgGNIKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 04:10:05 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-47-quVXGfyEOkSmpSddwNFlhw-1; Tue, 14 Jul 2020 09:10:01 +0100
X-MC-Unique: quVXGfyEOkSmpSddwNFlhw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 14 Jul 2020 09:10:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Jul 2020 09:10:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Saheed Olayemi Bolarinwa' <refactormyself@gmail.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/14 v3] PCI/PM: Check return value of
 pcie_capability_read_*()
Thread-Topic: [PATCH 11/14 v3] PCI/PM: Check return value of
 pcie_capability_read_*()
Thread-Index: AQHWVwhf1JBBv8jM7kKvf2XRj4wYvqkGvVFg
Date:   Tue, 14 Jul 2020 08:10:00 +0000
Message-ID: <80c7a253134b43289ba28a320ba99f9c@AcuMS.aculab.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
 <20200710212026.27136-12-refactormyself@gmail.com>
In-Reply-To: <20200710212026.27136-12-refactormyself@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Saheed Olayemi Bolarinwa
> Sent: 10 July 2020 22:20
> To: helgaas@kernel.org
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> 
> On failure pcie_capability_read_dword() sets it's last parameter,
> val to 0.
> However, with Patch 14/14, it is possible that val is set to ~0 on
> failure. This would introduce a bug because (x & x) == (~0 & x).
> 
> This bug can be avoided if the return value of pcie_capability_read_dword
> is checked to confirm success.
> 
> Check the return value of pcie_capability_read_dword() to ensure success.
> 
> Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
> Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pci.c | 52 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce096272f52b..9f18ffbf7bd4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3207,6 +3207,7 @@ void pci_configure_ari(struct pci_dev *dev)
>  {
>  	u32 cap;
>  	struct pci_dev *bridge;
> +	int ret;
> 
>  	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
>  		return;
> @@ -3215,8 +3216,8 @@ void pci_configure_ari(struct pci_dev *dev)
>  	if (!bridge)
>  		return;
> 
> -	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> -	if (!(cap & PCI_EXP_DEVCAP2_ARI))
> +	ret = pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> +	if (ret || !(cap & PCI_EXP_DEVCAP2_ARI))
>  		return;

Why not make the function result 64bit?
Then you can return ~0ull on failure and the capability value on success.
Gets rid of the horrid error + return value pair.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

