Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B02811B2B6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfLKPhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 10:37:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33832 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbfLKPhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 10:37:37 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so7951116pjs.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2019 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mZyjjAAc7yNANmoebBsT963AofjY/s84X8vsLTIrpD4=;
        b=K30i6dN5IfT1gG+6PGpefroyqGIpo4g4XmXSr85BsjYcaE88tQFwI33Ovorlgz2ABC
         FZMpdjij1HpLqDarqrAR48u/z2XVLxf68TnO6laeWh58YG9jR16KBBpjlflEUeuPmVOs
         MMiE4Z69y4R+Ow5o1jQM/OGtDXgnQZG+oH6Ni96mfqqoRoipYsqyaMoSpAY+9hLDWDIz
         ug1/Jl1bdYElBVegTmWiGgTmdmpYkmhUDFVMAJVlv94FS4Mo4/tWB9yvbW04RB6zj5S5
         0aPsdhA1ysrLqUJmjegxg1Twxm1vDhc1dC3kl6hZuZ4GIa55Rrk8kQ151DpmSYFbDhKJ
         WFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mZyjjAAc7yNANmoebBsT963AofjY/s84X8vsLTIrpD4=;
        b=QSGxWu/RUjeSm7g8jzhqo9ppvBV8qLQ+3M+5jpoJnXC5Z5PGw7qsJwe02opQ3EIjlI
         7ytEYI/O+o1ZpTn5Jpp8YqxEC90wA9yFjUnYZs+9LxCQL8eG2n1rTUM6UENS+/BtGlk1
         BGuhhq4QUvaJ9PnYPHCWlV1+umhvg7gANmGpDq2WvD/IMxr2e56PZXC+mMEfsyuLkRj/
         emsZdktOvHxE8O86DPzn4LhEEPoIIYvRK/1Fo3i1LpmtBmhcpKoE5INA35f0hILQIAq4
         IWIsRLqTuKr2UqMZ1t98YzkxGK4wF4MuVg927Hc7OsmhonM9ghUfM/cUdgFpHZihQXdS
         6QqQ==
X-Gm-Message-State: APjAAAUlp5hlD8tweTKqg6KeG+6mI++JUVXNYNb4qpL7GdE82FienP2s
        T2fcpivy5/2Touww2gq3vgd0tA==
X-Google-Smtp-Source: APXvYqyfHdj5Wju5tHjYhtBozUgo+eKxaW7VtMGL10rLo9NwZ5f8ANm6rWjTtpKXW6rwsYnvY5BNVg==
X-Received: by 2002:a17:902:b18e:: with SMTP id s14mr4008320plr.261.1576078656416;
        Wed, 11 Dec 2019 07:37:36 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w11sm3150883pgs.60.2019.12.11.07.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:37:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <20191210223745.GA167002@google.com>
Date:   Wed, 11 Dec 2019 15:37:30 +0000
Cc:     linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <826A0459-FA8D-4BDB-A342-CE46974466DF@arista.com>
References: <20191210223745.GA167002@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On 10 Dec 2019, at 22:37, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> [+cc Joerg]
>=20
> On Tue, Dec 03, 2019 at 03:43:53PM +0000, James Sewart wrote:
>> pci_add_dma_alias can now be used to create a dma alias for a range =
of
>> devfns.
>>=20
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> Signed-off-by: James Sewart <jamessewart@arista.com>
>> ---
>> drivers/pci/pci.c    | 22 +++++++++++++++++-----
>> drivers/pci/quirks.c | 14 +++++++-------
>> include/linux/pci.h  |  2 +-
>> 3 files changed, 25 insertions(+), 13 deletions(-)
>=20
> Heads up Joerg: I also updated drivers/iommu/amd_iommu.c (this is the
> one reported by the kbuild test robot) and removed the printk there
> that prints the same thing as the one in pci_add_dma_alias(), and I
> updated a PCI quirk that was merged after this patch was posted.
>=20
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d3c83248f3ce..dbb01aceafda 100644
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
>> @@ -5873,8 +5874,13 @@ int pci_set_vga_state(struct pci_dev *dev, =
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
>> +	nr_devfns =3D min(nr_devfns, (unsigned)MAX_NR_DEVFNS);
>> +	devfn_to =3D devfn_from + nr_devfns - 1;
>=20
> I made this look like:
>=20
> +       devfn_to =3D min(devfn_from + nr_devfns - 1,
> +                      (unsigned) MAX_NR_DEVFNS - 1);
>=20
> so devfn_from=3D0xf0, nr_devfns=3D0x20 doesn't cause devfn_to to wrap
> around.
>=20
> I did keep Logan's reviewed-by, so let me know if I broke something.

I think nr_devfns still needs updating as it is used for bitmap_set.=20
Although thinking about it now we should limit the number to alias to be=20=

maximum (MAX_NR_DEVFNS - devfn_from), so that we don=E2=80=99t set past =
the end of=20
the bitmap:

 nr_devfns =3D min(nr_devfns, (unsigned) MAX_NR_DEVFNS - devfn_from);

I think with this change we wont need to clip devfn_to.

>=20
>> 	if (!dev->dma_alias_mask)
>> 		dev->dma_alias_mask =3D bitmap_zalloc(MAX_NR_DEVFNS, =
GFP_KERNEL);
>> 	if (!dev->dma_alias_mask) {
>> @@ -5882,9 +5888,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 =
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

