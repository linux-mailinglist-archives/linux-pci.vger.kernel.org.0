Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4908210D8D6
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 18:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfK2RTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 12:19:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44134 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2RTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2019 12:19:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so10217027pfd.11
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2019 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PluLd8iVD+LLnEDvxxVn2n44IA0azS1nHZX7RCBx5eI=;
        b=Q6Td1VXNltrpwRpv76nKV38tc62evrFFzSGrUcrypWz1p/dZYd7Tvgm9kkwS5vYrW6
         2yo1d+vpi00Ccj6TOPCn+wYZJnXWyVHNmalLJJQXzihXO5D0eP6m1w2Sr0sk7can3QuP
         SpQelYK6CV6hs6qkENnbI0vvvLx1AwzVIN4MMAkXP8T4mUwjMDbk3q7F9g7A41LWJui2
         aQljwixEwE+If4dd3bR5r9ZqFRXJmHUQCxQ2lzr51QRcEivbOCXS6RUxPdE2V+ispsoa
         QR2Y9zxqMJ7umkhrOLxrf1Creueo1e7BKX3ynvTpOlt1jBqCRCcVIT9mW7eF81es4+9I
         9OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PluLd8iVD+LLnEDvxxVn2n44IA0azS1nHZX7RCBx5eI=;
        b=maFTMd4Ow49TJ8qK6+6DgQXV0nbrxhthNmjqvPaAUr9LdnlADbG50kvEWt/7X8zIZG
         Rb5Mwqvb4WzXsPeewOC6cBc0Z0cQM7+ELMoP5hNaTMMo/6w9ClyVreq9tI50iAQVWwhN
         WyxxrVcQwc2ktF/rXsjF5UMfimcoV6Vdb0kpShq3awlSBnKYFSLa7tWGvfV3LWXQfFrt
         sg9Ry9k0DrwDt90+1OmgUjScZxEFWKCSGicNUSJLDYWcN2DKnMAyDV0MckNxF6UGbxvX
         rEVoGWZYtZNy5APPL1XdPrnBC5Mv04a/1p63HYhxRBFuS/o0a73a0uOAf0nb7uDZ9808
         RWIg==
X-Gm-Message-State: APjAAAUHcZhcI8OavxaFvO3Jam0SPRytPU/cPoipW02sl7n3D6jrBP0a
        7zKHCo/d+KImBE7/aQmdO4BoIQ==
X-Google-Smtp-Source: APXvYqyumM5ZLIy9Nuo5UT+YMh25eg7v2oDAI8y12wtwJbV1TUFp0Kv4HPEdAHhSSgvMjjWjWSgzVg==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr3925340pfo.139.1575047988000;
        Fri, 29 Nov 2019 09:19:48 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q66sm25520301pfb.150.2019.11.29.09.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:19:47 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
Date:   Fri, 29 Nov 2019 17:19:42 +0000
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
To:     Logan Gunthorpe <logang@deltatee.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On 29 Nov 2019, at 16:50, Logan Gunthorpe <logang@deltatee.com> wrote:
>=20
>=20
>=20
> On 2019-11-29 5:49 a.m., James Sewart wrote:
>> pci_add_dma_alias can now be used to create a dma alias for a range =
of
>> devfns.
>>=20
>> Signed-off-by: James Sewart <jamessewart@arista.com>
>> ---
>> drivers/pci/pci.c    | 23 ++++++++++++++++++-----
>> drivers/pci/quirks.c | 14 +++++++-------
>> include/linux/pci.h  |  2 +-
>> 3 files changed, 26 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index a97e2571a527..9b0e3481fe17 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool =
decode,
>> /**
>>  * pci_add_dma_alias - Add a DMA devfn alias for a device
>>  * @dev: the PCI device for which alias is added
>> - * @devfn: alias slot and function
>> + * @devfn_from: alias slot and function
>> + * @nr_devfns: Number of subsequent devfns to alias
>>  *
>>  * This helper encodes an 8-bit devfn as a bit number in =
dma_alias_mask
>>  * which is used to program permissible bus-devfn source addresses =
for DMA
>> @@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, =
bool decode,
>>  * cannot be left as a userspace activity).  DMA aliases should =
therefore
>>  * be configured via quirks, such as the PCI fixup header quirk.
>>  */
>> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns)
>> {
>> +	int devfn_to;
>> +
>> +	if (nr_devfns > U8_MAX+1)
>> +		nr_devfns =3D U8_MAX+1;
>=20
> Why +1? That doesn't seem right to me=E2=80=A6.

U8_MAX is the max number U8 can represent(255) but is one less than the =
number=20
of values it can represent(256). devfns can be 0.0 to 1f.7 inclusive(I =
think)=20
so the number of possible devfns is 256. Thinking about it, maybe the=20
zalloc should be U8_MAX+1 too?

I might be wrong though, what do you reckon?

>=20
>> +	devfn_to =3D devfn_from + nr_devfns - 1;
>> +
>> 	if (!dev->dma_alias_mask)
>> 		dev->dma_alias_mask =3D bitmap_zalloc(U8_MAX, =
GFP_KERNEL);
>> 	if (!dev->dma_alias_mask) {
>> @@ -5882,9 +5889,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 =
devfn)
>> 		return;
>> 	}
>>=20
>> -	set_bit(devfn, dev->dma_alias_mask);
>> -	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
>> -		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>> +	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
>> +
>> +	if (nr_devfns =3D=3D 1)
>> +		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
>> +				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from));
>> +	else if(nr_devfns > 1)
>> +		pci_info(dev, "Enabling fixed DMA alias for devfn range =
from %02x.%d to %02x.%d\n",
>> +				PCI_SLOT(devfn_from), =
PCI_FUNC(devfn_from),
>> +				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
>> }
>>=20
>> bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2)
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 320255e5e8f8..0f3f5afc73fd 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, =
int probe)
>> static void quirk_dma_func0_alias(struct pci_dev *dev)
>> {
>> 	if (PCI_FUNC(dev->devfn) !=3D 0)
>> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0));
>> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
0), 1);
>> }
>>=20
>> /*
>> @@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, =
0xe476, quirk_dma_func0_alias);
>> static void quirk_dma_func1_alias(struct pci_dev *dev)
>> {
>> 	if (PCI_FUNC(dev->devfn) !=3D 1)
>> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1));
>> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), =
1), 1);
>> }
>>=20
>> /*
>> @@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct =
pci_dev *dev)
>>=20
>> 	id =3D pci_match_id(fixed_dma_alias_tbl, dev);
>> 	if (id)
>> -		pci_add_dma_alias(dev, id->driver_data);
>> +		pci_add_dma_alias(dev, id->driver_data, 1);
>> }
>>=20
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, =
quirk_fixed_dma_alias);
>> @@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, =
quirk_use_pcie_bridge_dma_alias);
>>  */
>> static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
>> {
>> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
>> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
>> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
>> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
>> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
>> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
>> }
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, =
quirk_mic_x200_dma_alias);
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, =
quirk_mic_x200_dma_alias);
>> @@ -5273,7 +5273,7 @@ static void =
quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>> 			pci_dbg(pdev,
>> 				"Aliasing Partition %d Proxy ID =
%02x.%d\n",
>> 				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
>> -			pci_add_dma_alias(pdev, devfn);
>> +			pci_add_dma_alias(pdev, devfn, 1);
>> 		}
>> 	}
>>=20
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 1a6cf19eac2d..84a8d4c2b24e 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -2323,7 +2323,7 @@ static inline struct eeh_dev =
*pci_dev_to_eeh_dev(struct pci_dev *pdev)
>> }
>> #endif
>>=20
>> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
>> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned =
nr_devfns);
>> bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev =
*dev2);
>> int pci_for_each_dma_alias(struct pci_dev *pdev,
>> 			   int (*fn)(struct pci_dev *pdev,
>>=20

