Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A91DE620
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEVMHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgEVMHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 08:07:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99DC061A0E;
        Fri, 22 May 2020 05:07:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so12717327ejd.8;
        Fri, 22 May 2020 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VNdpRkFTwiDTQMMCQPHbyrhP0paOadRy+XLIjTBXbwk=;
        b=C7LuZnZr+eKUkyIe1DvB/Sg5Ld8us1op3+Dfn93EKWMsq8AcL9PisAQjNFVeLfqc/l
         mrtT06+SjIgQNQE0I2gGm4XtmOWIucB1wUap7qeKBNGuaYZWyBNP3BoQqmij8YboD20E
         P4s8Dbq9Dp5aTOdnHRHQLX4W8boIYIOXkdzxwWycjg04IhuIPMpOk8BTaTS+D8d8ZyDh
         0aggVZDKAdO++52xzvChURG5FzyWRwYLXB7Z6dXgQocL62thgwH7nhVW9IFzgPlKxMZ9
         TvRMTH9ZlM6eCAf5sCarAZKKDZT3ExUKfsK/LVV0DPLnXKFSrvVnKcAjAM9xpIHExqSV
         O1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VNdpRkFTwiDTQMMCQPHbyrhP0paOadRy+XLIjTBXbwk=;
        b=aXD0AyHUQLNXDUde2BJXl/Dmj/wIB3QjBxg4Mt8x56+mEcpRxBtUcmXs8AYs+tOibp
         itWU2YXQNN7lofES9K9W9QgG5kXI7zWNx148ocLTXQrneC8+aoNmvmgWjc3ulMryxsSw
         V/HMJFrPOKkkr9n9ZKq4ih3lGnIMg9h7Fw7zIs0TZD9RcFE5T7DCU64HmlyS4Jtxa74Z
         zPXmt3vjZK5z7uNbaYWNEMHm8RFKq8bThmspHz3OUQ+cTHV1+llcGSB0hV3UjT1xpnKI
         I5h1+8zT0QWioSj4PsWr8u3mkgQjCZr/mdCQGEanYHbixpP5O3Uwty6V2DfFi2xiiT6m
         rezA==
X-Gm-Message-State: AOAM5313BDVxL2lrOnlE0ZBnV9HLegaCj2vXr93M6vD47AJH8XFnyKiy
        PWqnmSLxjZypCvjk6weWHN4=
X-Google-Smtp-Source: ABdhPJxatryhBKs0cHNecpMtBSmDsYusMfueAuEuWlnXRLTXDzKvuZU/dbHtBsFQau2JhzEQ6+UBPA==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr7521606ejb.119.1590149219435;
        Fri, 22 May 2020 05:06:59 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id c12sm7732851ejm.36.2020.05.22.05.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:06:56 -0700 (PDT)
Date:   Fri, 22 May 2020 14:06:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: Re: Re: [PATCH] PCI: dwc: Warn only for non-prefetchable memory
 resource size >4GB
Message-ID: <20200522120655.GC2163848@ulmo>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520111717.GB2141681@ulmo>
 <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
 <20200520224816.GA739245@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200520224816.GA739245@bogus>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 04:48:16PM -0600, Rob Herring wrote:
> On Wed, May 20, 2020 at 11:16:32PM +0530, Vidya Sagar wrote:
> >=20
> >=20
> > On 20-May-20 4:47 PM, Thierry Reding wrote:
> > > On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
> > > > On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi
> > > > <lorenzo.pieralisi@arm.com> wrote:
> > > >=20
> > > > > On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > > > > > > External email: Use caution opening links or attachments
> > > > > > >=20
> > > > > > >=20
> > > > > > > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
> > > > > > > > [+cc Alan; please cc authors of relevant commits,
> > > > > > > > updated Andrew's email address]
> > > > > > > >=20
> > > > > > > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> > > > > > > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource siz=
e exceeds max for
> > > > > > > > > 32-bits") enables warning for MEM resources of size >4GB =
but prefetchable
> > > > > > > > >    memory resources also come under this category where s=
izes can go beyond
> > > > > > > > > 4GB. Avoid logging a warning for prefetchable memory reso=
urces.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > > > > ---
> > > > > > > > >    drivers/pci/controller/dwc/pcie-designware-host.c | 3 =
++-
> > > > > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-h=
ost.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_por=
t *pp)
> > > > > > > > >                       pp->mem =3D win->res;
> > > > > > > > >                       pp->mem->name =3D "MEM";
> > > > > > > > >                       mem_size =3D resource_size(pp->mem);
> > > > > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > > > > +                       !(win->res->flags & IORESOURCE_PR=
EFETCH))
> > > > > > > > >                               dev_warn(dev, "MEM resource=
 size exceeds max for 32 bits\n");
> > > > > > > > >                       pp->mem_size =3D mem_size;
> > > > > > > > >                       pp->mem_bus_addr =3D pp->mem->start=
 - win->offset;
> > > > > > >=20
> > > > > > > That warning was added for a reason - why should not we log l=
egitimate
> > > > > > > warnings ? AFAIU having resources larger than 4GB can lead to=
 undefined
> > > > > > > behaviour given the current ATU programming API.
> > > > > > Yeah. I'm all for a warning if the size is larger than 4GB in c=
ase of
> > > > > > non-prefetchable window as one of the ATU outbound translation
> > > > > > channels is being used,
> > > > >=20
> > > > > Is it true for all DWC host controllers ? Or there may be another
> > > > > exception whereby we would be forced to disable this warning alto=
gether
> > > > > ?
> > > > >=20
> > > > > > but, we are not employing any ATU outbound translation channel =
for
> > > > >=20
> > > > > What does this mean ? "we are not employing any ATU outbound...",=
 is
> > > > > this the tegra driver ? And what guarantees that this warning is =
not
> > > > > legitimate on DWC host controllers that do use the ATU outbound
> > > > > translation for prefetchable windows ?
> > > > >=20
> > > > > Can DWC maintainers chime in and clarify please ?
> > > >=20
> > > > Before this code section, there is the following function call
> > > > pci_parse_request_of_pci_ranges(), which performs a simple validati=
on for
> > > > the IORESOURCE_MEM resource type.
> > > > This validation checks if the resource is marked as prefetchable, i=
f so,
> > > > an error message "non-prefetchable memory resource required" is giv=
en and
> > > > a return code with the -EINVAL value.
> > >=20
> > > That's not what the code is doing. pci_parse_request_of_pci_range() w=
ill
> > > traverse over the whole list of resources that it can find for the gi=
ven
> > > host controller and checks whether one of the resources defines prefe=
tch
> > > memory (note the res_valid |=3D ...). The error will only be returned=
 if
> > > no prefetchable memory region was found.
> > >=20
> > > dw_pcie_host_init() will then again traverse the list of resources and
> > > it will typically encounter two resource of type IORESOURCE_MEM, one =
for
> > > non-prefetchable memory and another for prefetchable memory.
> > >=20
> > > Vidya's patch is to differentiate between these two resources and all=
ow
> > > prefetchable memory regions to exceed sizes of 4 GiB.
> > >=20
> > > That said, I wonder if there isn't a bigger problem at hand here. From
> > > looking at the code it doesn't seem like the DWC driver makes any
> > > distinction between prefetchable and non-prefetchable memory. Or at
> > > least it doesn't allow both to be stored in struct pcie_port.
> > >=20
> > > Am I missing something? Or can anyone explain how we're programming t=
he
> > > apertures for prefetchable vs. non-prefetchable memory? Perhaps this =
is
> > > what Vidya was referring to when he said: "we are not using an outbou=
nd
> > > ATU translation channel for prefetchable memory".
> > >=20
> > > It looks to me like we're also getting partially lucky, or perhaps th=
at
> > > is by design, in that Tegra194 defines PCI regions in the following
> > > order: I/O, prefetchable memory, non-prefetchable memory. That means
> > > that the DWC core code will overwrite prefetchable memory data with t=
hat
> > > of non-prefetchable memory and hence the non-prefetchable region ends=
 up
> > > stored in struct pcie_port and is then used to program the ATU outbou=
nd
> > > channel.
> > Well,it is by design. I mean, since the code is not differentiating bet=
ween
> > prefetchable and non-prefetchable regions, I ordered the entries in 'ra=
nges'
> > property in such a way that 'prefetchable' comes first followed by
> > 'non-prefetchable' entry so that ATU region is used for generating the
> > translation required for 'non-prefetchable' region (which is a non 1-to=
-1
> > mapping)
>=20
> You are getting lucky with your 'design'. Relying on order is fragile=20
> (except of course in the places in DT where order is defined, but ranges=
=20
> is not one of them).

Yeah, I think the DWC core should be improved to differentiate between
the two types of memory resources. There shouldn't be a need to encode
any ordering because the type is already part of the value in the
ranges property.

Thierry

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HwF0ACgkQ3SOs138+
s6FGAQ//UkChqmNoKeWSkMmPsJLkILoXpcxJseYWbu7s1ZyT3k/ltG+t52aTHmtM
Ka8GvgHiN0ryhm+fh+ErdFhgkzUthIDzfzpwEpiTwEjGu+/wCVwWRRjFz8RJpYeU
zvLRcQXhFSzoV0gjhPWX9wXXHcvRMNTg5Lo1MTausUIonrO0FuvV6J+qw+QSDCcv
Zy5ycSsY1YRlx3nQ+RA3twQKMMa3V8E8WykpMDzrpcoHHFsXwXQHON1bcxaKlMCW
iUhaT7oejlvApFd46sO+f3ZCXWeQDD2n9vpTB/Kv/GRRfaMZgf47GytEIgDXpvGC
3fDrGijA8LjD7m0sygE4RzrmiVVS39hDUb8pQk/tjGZJEa1iJySDDChitunRIIr5
ue/N14WbgvsrOjJVNB+ghfUJ0rCGFzHjDYvi9tbDa4HpDBHDG0USZntFCIeRtA/D
oVfMzCsvaalu7sJEnpbzrcL2ATkWqY0WlV7ft03cGTjWG23eHR7eIc12wx/09qK9
dmmIZaFsliJPOjAEtDnL0tfa/E1a3PBwNdgSMKAy2xuU3fEENSJNpkEC4zuCLZqs
vRVh1LCOWCoZv2ZK/eSTU9SiyzMhuM+6hK2k3Q8wIkVPW1Sfc73pn0hbaEvXdx0D
xhkob/OfovNgmdHH9/sVymTCL2k2ES9kQHK7Wc5wpqP1Jg9WLBY=
=rE4G
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
