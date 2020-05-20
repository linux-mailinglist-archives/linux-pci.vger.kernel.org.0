Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918521DB150
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETLRX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETLRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 07:17:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD53C061A0E;
        Wed, 20 May 2020 04:17:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g9so2673939edr.8;
        Wed, 20 May 2020 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fznr8YKSw5EsgmJSzEUboYxavDTpPHDc5z8WMGGxO9c=;
        b=ReUsnM81SRQYlgOMWEj0WKTvLJLHCKMf8HznDi7j9yY3mzyc5RrfQ6KZwD1LBMQC5V
         arrmAojM6hm9SLDnsgkv+TWwUnNDvI5Sa1ycUq5cQJHZ9YTES4ypz9wf47refDqECC8a
         Aq21ol4/5k6aA7EmpidjknvimRUhQ2td9HrFOHrot0OFk5oPgs1+MptplHxNXC6s/u+q
         BKZHK79j868Y8z4+K3EIjS+e2+gqiQAmmIHI8rL7FyCkNv+CfPOn0IBRKjZgWrUJz82m
         qaEY1AXMeIFa2p75KHI2pmcwxYf05nWy9MN0XZbgoGrp5wSzzZi2nI8bawcsG6mrSRQC
         Aw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fznr8YKSw5EsgmJSzEUboYxavDTpPHDc5z8WMGGxO9c=;
        b=d3hT+wP3mwuYhnEUGZ5MkehFvva4Hb64mzSxwHOquO2jL2mrsQFZDDyCW5fyth4YKe
         R38Hz1gQWBPlbixoGiTKnrpHxhh/trOYZ/Ht4ynHOwEwuZlbNogxKM04sMZvwGitoq2K
         fwghM/PX2XgeIK/BsizQI56567MHM1Ip5EUakzfbw60BwA9+nkR8fS9d0KFMm0PHBXqk
         MWglr0knpYSyS4/NED6Ksiz1xRF/NxPrGrUim7z0ILU5PKtX3cDiD8c57Ky/d1msOn+g
         xud64ComVwqZnfs6cdulFhhPeG2+h6lR1AKQT1VvV/FennyYn9olDVVCnpnKjv3qhryW
         OiLg==
X-Gm-Message-State: AOAM533r+5Mb0Zzqt4/dBBvJBWb79fbmvh038Z0S3GzsifORu5shN0mt
        NlHUeuZ1Ot/D9dJeOIXK274=
X-Google-Smtp-Source: ABdhPJwdo+Z/Jmz0cYRNQafz+lRqspmOePEfutF9rB4j2wxxQAGj6BXTvTnIs69FX7Fzp6tql3PKaA==
X-Received: by 2002:a50:da06:: with SMTP id z6mr2800642edj.372.1589973439719;
        Wed, 20 May 2020 04:17:19 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id h8sm1689202edk.72.2020.05.20.04.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 04:17:18 -0700 (PDT)
Date:   Wed, 20 May 2020 13:17:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Alan Mikhak <alan.mikhak@sifive.com>
Subject: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Message-ID: <20200520111717.GB2141681@ulmo>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
> On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi=20
> <lorenzo.pieralisi@arm.com> wrote:
>=20
> > On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> > >=20
> > >=20
> > > On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > > > External email: Use caution opening links or attachments
> > > >=20
> > > >=20
> > > > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
> > > > > [+cc Alan; please cc authors of relevant commits,
> > > > > updated Andrew's email address]
> > > > >=20
> > > > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> > > > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exce=
eds max for
> > > > > > 32-bits") enables warning for MEM resources of size >4GB but pr=
efetchable
> > > > > >   memory resources also come under this category where sizes ca=
n go beyond
> > > > > > 4GB. Avoid logging a warning for prefetchable memory resources.
> > > > > >=20
> > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > ---
> > > > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c =
b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > > >                      pp->mem =3D win->res;
> > > > > >                      pp->mem->name =3D "MEM";
> > > > > >                      mem_size =3D resource_size(pp->mem);
> > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > +                       !(win->res->flags & IORESOURCE_PREFETCH=
))
> > > > > >                              dev_warn(dev, "MEM resource size e=
xceeds max for 32 bits\n");
> > > > > >                      pp->mem_size =3D mem_size;
> > > > > >                      pp->mem_bus_addr =3D pp->mem->start - win-=
>offset;
> > > >=20
> > > > That warning was added for a reason - why should not we log legitim=
ate
> > > > warnings ? AFAIU having resources larger than 4GB can lead to undef=
ined
> > > > behaviour given the current ATU programming API.
> > > Yeah. I'm all for a warning if the size is larger than 4GB in case of
> > > non-prefetchable window as one of the ATU outbound translation
> > > channels is being used,
> >=20
> > Is it true for all DWC host controllers ? Or there may be another
> > exception whereby we would be forced to disable this warning altogether
> > ?
> >=20
> > > but, we are not employing any ATU outbound translation channel for
> >=20
> > What does this mean ? "we are not employing any ATU outbound...", is
> > this the tegra driver ? And what guarantees that this warning is not
> > legitimate on DWC host controllers that do use the ATU outbound
> > translation for prefetchable windows ?
> >=20
> > Can DWC maintainers chime in and clarify please ?
>=20
> Before this code section, there is the following function call=20
> pci_parse_request_of_pci_ranges(), which performs a simple validation for=
=20
> the IORESOURCE_MEM resource type.
> This validation checks if the resource is marked as prefetchable, if so,=
=20
> an error message "non-prefetchable memory resource required" is given and=
=20
> a return code with the -EINVAL value.

That's not what the code is doing. pci_parse_request_of_pci_range() will
traverse over the whole list of resources that it can find for the given
host controller and checks whether one of the resources defines prefetch
memory (note the res_valid |=3D ...). The error will only be returned if
no prefetchable memory region was found.

dw_pcie_host_init() will then again traverse the list of resources and
it will typically encounter two resource of type IORESOURCE_MEM, one for
non-prefetchable memory and another for prefetchable memory.

Vidya's patch is to differentiate between these two resources and allow
prefetchable memory regions to exceed sizes of 4 GiB.

That said, I wonder if there isn't a bigger problem at hand here. From
looking at the code it doesn't seem like the DWC driver makes any
distinction between prefetchable and non-prefetchable memory. Or at
least it doesn't allow both to be stored in struct pcie_port.

Am I missing something? Or can anyone explain how we're programming the
apertures for prefetchable vs. non-prefetchable memory? Perhaps this is
what Vidya was referring to when he said: "we are not using an outbound
ATU translation channel for prefetchable memory".

It looks to me like we're also getting partially lucky, or perhaps that
is by design, in that Tegra194 defines PCI regions in the following
order: I/O, prefetchable memory, non-prefetchable memory. That means
that the DWC core code will overwrite prefetchable memory data with that
of non-prefetchable memory and hence the non-prefetchable region ends up
stored in struct pcie_port and is then used to program the ATU outbound
channel.

> In other words, to reach the code that Vidya is changing, it can be only=
=20
> if the resource is a non-prefetchable, any prefetchable resource will be=
=20
> blocked by the previous call, if I'm not mistaken.
>=20
> Having this in mind, Vidya's change will not make the expected result=20
> aimed by him.

Given the above I think it does. We've also seen this patch eliminate a
warning that we were seeing before, so I think it has the intended
effect.

> I don't see any problem by having resources larger than 4GB, from what=20
> I'm seeing in the databook there isn't any restricting related to that as=
=20
> long they don't consume the maximum space that is addressable by the=20
> system (depending on if they are 32-bit or 64-bit system address).
>=20
> To be honest, I'm not seeing a system that could have this resource=20
> larger than 4GB, but it might exist some exception that I don't know of,=
=20
> that's why I accepted Alan's patch to warn the user that the resource=20
> exceeds the maximum for the 32 bits so that he can be aware that he=20
> *might* be consuming the maximum space addressable.

I think it's pretty common to have this type of prefetchable memory
region when you connect discrete GPUs to PCIe. It's not unusual for
high-end GPUs to have 8 GiB or even more dedicated video memory and
those will typically be mapped to a prefetchable memory region on
the PCI device.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7FEbkACgkQ3SOs138+
s6F6yg//fBafWy3d6e0tL7M5stxppWxWvQDR4/Z5dSLrjT7jNJWWRO315MZRLlVz
NOLteGGxX0u8AuPUrWpbT9Jh+Vzh4vT4QaauJ7xIUl1MTEf/P3csUfXx7n/AoETj
coBkKHNLXbLf1IwgkSaVepYp73Ml9Vr84n8Z+yf8cL1kNp8FBra/QrjcRTUGAgbJ
3fdGjAvAMVOpbes39E1O6JcL0nlDNyKL7XLfWk/g1Wc+9Ny+iUY+RlsFhPv/QGlk
fcwEWYCAjEyWeihxkQJaWHcyuXpjGQyc0RzQh/KI+3dQxO8m/ks5u+LiWa0kyNOa
vTAFx5PA3pYCElo7qraiGINzdBZ2plF0JnOMQDUb9OTPkdDZOQujT2jQLEyY7AGz
WD48DgbKotZ2B4I5YD9oBv5NULOEeVO/b+uifv3HzprM2Mxuqf5ptm90GLi6AUDQ
fkdEVUYQR4qiXCs9a9X/27HboiUhBVQ8gFB/IVV8w3Eatut2j1+NfOLUfRn/Y+iF
eWhra2JQAntY3fep8CrFurDgoyzF39+Ys7QLeJpHmcbEdlU+WpA2dvxFXv2+rTpg
8YjtT6IwrS9qBgmSIeF6kpFBEQCAgnOV1mLbqvJ1ImZAtDr2Tc3bPWONCCiQY5C3
YEPX9oPa6+xyGzSX2cpFc85K0vFMJmISXSoaf/Oe2YxxPJ2aXVU=
=0Qo8
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
