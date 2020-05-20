Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27EE1DB4BE
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETNQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETNQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 09:16:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CEC061A0E;
        Wed, 20 May 2020 06:16:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b91so3026719edf.3;
        Wed, 20 May 2020 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=unsLPAdrzKpSqO2y9Hxm7UycCcuN5BGqqb+uwmHexuA=;
        b=hRYZNqtLA/dr6ylH/hZHktaNl13F4MxNG9b5/tmy9+LcsbUTGFYNQE6AcjyVGUHYXm
         JIC15fiL5dFpOS9l+tTItowJkEocA4yQ5NeU2LrVQrBMkpE0R5biVGcI/lZj+RPl6KA6
         oE8Egi8OUTmn6eCp8lNC5tIolWmvfhgr7iSvcsBFoQwNvW3IiSgIzyZQFlk3qXn9GnJt
         UTNeX43AIMdvIAwpgac135FwaNeL4KxUkOwL/0A+6lAbSjNSEkblg1KvcbuQp1Epup8n
         FrUlzMf4IqM/5zAN+HWLSeHIL9da/xwWqUpqoshRdZid8aVcqH7LE1pE0HOFfT8+6hHb
         CWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=unsLPAdrzKpSqO2y9Hxm7UycCcuN5BGqqb+uwmHexuA=;
        b=Md9gafXo7v/81+9MYhwda4bJW8hhJ/9fmQ4uGEIQvAP+ClHfBV9e68Wbi1NTlUyol5
         lUcrQXLEbEpj3yp4hAWzaYZ1Do6vY1CBIj2Q4E1HdUBplqtHGXtAbTmZLeyt4RmrcrP1
         Rm2NMfQTwe/y8LjlBT6Y3PrHz3wzZXOQwvHhd2UKUm8eGXiSlwI75InfbKiHLpewROYR
         uvnnCksusdTadJ/SHmtS/I4wdKaaIxbL+Z39eU0THy4ZOfRy9liYuEMSmeQj47SGX6al
         KUIqGixcnfXM5oN/Pi+A6HplMno1SNKPRVYvQVYqSk2LoapWwgv7msZiRJRH5aorI1gN
         jmFQ==
X-Gm-Message-State: AOAM532Tfe/bdVda43alKP5PS4WiID/7SLrT68a0bQ8VVWNyJbQDdfqH
        NHKA9aXs0wXG+e2TdnXez3A=
X-Google-Smtp-Source: ABdhPJybhsRO5mW/82A5Q5CxFMlYR3LQ0/dF2nGkrJhRfQjhdqpG0hOOKVlJID/7Uivyvbw9TDBC1A==
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr3329563edb.14.1589980567946;
        Wed, 20 May 2020 06:16:07 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id a15sm1893216ejj.104.2020.05.20.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 06:16:06 -0700 (PDT)
Date:   Wed, 20 May 2020 15:16:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
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
Message-ID: <20200520131605.GD2141681@ulmo>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520110640.GA5300@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20200520110640.GA5300@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 12:06:40PM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
>=20
> [...]
>=20
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.=
c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *p=
p)
> > > > > > >                      pp->mem =3D win->res;
> > > > > > >                      pp->mem->name =3D "MEM";
> > > > > > >                      mem_size =3D resource_size(pp->mem);
> > > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > > +                       !(win->res->flags & IORESOURCE_PREFET=
CH))
> > > > > > >                              dev_warn(dev, "MEM resource size=
 exceeds max for 32 bits\n");
> > > > > > >                      pp->mem_size =3D mem_size;
> > > > > > >                      pp->mem_bus_addr =3D pp->mem->start - wi=
n->offset;
> > > > >=20
> > > > > That warning was added for a reason - why should not we log legit=
imate
> > > > > warnings ? AFAIU having resources larger than 4GB can lead to und=
efined
> > > > > behaviour given the current ATU programming API.
> > > > Yeah. I'm all for a warning if the size is larger than 4GB in case =
of
> > > > non-prefetchable window as one of the ATU outbound translation
> > > > channels is being used,
> > >=20
> > > Is it true for all DWC host controllers ? Or there may be another
> > > exception whereby we would be forced to disable this warning altogeth=
er
> > > ?
> > >=20
> > > > but, we are not employing any ATU outbound translation channel for
> > >=20
> > > What does this mean ? "we are not employing any ATU outbound...", is
> > > this the tegra driver ? And what guarantees that this warning is not
> > > legitimate on DWC host controllers that do use the ATU outbound
> > > translation for prefetchable windows ?
> > >=20
> > > Can DWC maintainers chime in and clarify please ?
> >=20
> > Before this code section, there is the following function call=20
> > pci_parse_request_of_pci_ranges(), which performs a simple validation f=
or=20
> > the IORESOURCE_MEM resource type.
> > This validation checks if the resource is marked as prefetchable, if so=
,=20
> > an error message "non-prefetchable memory resource required" is given a=
nd=20
> > a return code with the -EINVAL value.
>=20
> That code checks if there is *at least* a non-prefetchable resource,
> that's all it does.
>=20
> > In other words, to reach the code that Vidya is changing, it can be onl=
y=20
> > if the resource is a non-prefetchable, any prefetchable resource will b=
e=20
> > blocked by the previous call, if I'm not mistaken.
>=20
> I think you are mistaken sorry.
>=20
> > Having this in mind, Vidya's change will not make the expected result=
=20
> > aimed by him.
>=20
> I think Vidya's patch does what he expects, the question is whether
> it is widely applicable to ALL DWC hosts, that's what I want to know.
>=20
> > I don't see any problem by having resources larger than 4GB, from what=
=20
> > I'm seeing in the databook there isn't any restricting related to that =
as=20
> > long they don't consume the maximum space that is addressable by the=20
> > system (depending on if they are 32-bit or 64-bit system address).
> >=20
> > To be honest, I'm not seeing a system that could have this resource=20
> > larger than 4GB, but it might exist some exception that I don't know of=
,=20
> > that's why I accepted Alan's patch to warn the user that the resource=
=20
> > exceeds the maximum for the 32 bits so that he can be aware that he=20
> > *might* be consuming the maximum space addressable.
>=20
> I think it is most certainly a possibility to have > 4GB prefetchable
> address spaces so we ought to fix this for good. I still have to
> understand how the DWC host detects the memory region to be programmed
> into the ATU given that there is more than one but only 1 ATU memory
> region AFAICS.

Probably best to wait for Vidya to confirm since I'm not altogether
familiar with PCI on Tegra194, but looking at the DTS files and the
Tegra194 TRM, the prefetchable memory regions are set to a range in
0x1200000000-0x1fffffffff which is a region of the address map that
is reserved for "PCIe aperture for > 32-bit OS". Part of that is in
use for non-prefetchable memory (and ends up being programmed into
the ATU) whereas a much larger part is used for prefetchable memory
and is not programmed anywhere, as far as I can tell.

But I think given that this is a designated region of the address
map this is probably automatically redirected to the PCIe controller.
What I don't know is if that's something Tegra-specific or whether all
instantiations have something similar set up.

Thierry

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7FLZIACgkQ3SOs138+
s6GIyRAAh60TupOmgwKUsM8rfAWbliV5AGxkPhhyoSzqhJC9zXRStjpRjgTHWyYR
iDb1BrtATwnlko0RZkbpaULByggSpP3zgOkuNmBBK2e0clu0sNBLZquT5O+EtMDb
Z0wFx0UPSu3KtEXEsdNxdP3eJ4KAhc+0hV2+7ThWa2Cx7IcFHEMYxJVOMWQawFKw
HO2zZQ/4AuJ0d1wfnb6nwQTPF4NnpooxepChsxXTfVk6pSFI+LE574fpUuDKb1LZ
br8Y3OCP5H7igW67+696sHca38e15JX0q5vPTcmgA2bATv0LPJ7qFqePbrlupI3N
Yc1boNLtEKiI24kyAl0tzcJdIPWUQ1iIeqVssSXii2yeQMZ9oCssxhNtK3DcmVIL
JHkLB8+cSYEynxNAzhOA6pdc2q1Lm/CzEFeveBF2dlLItSXiD4Fw5SBbWkKhx7Aa
s7S2HCzclU5Z5bqN/waHESDB9glPoKTI/KJJT4uIG73IyrcyDn/6XKCRP4wjHBpD
D6lTi6boqxCcw66T2et30c33B+lWIk/9K0LwXlS7Kvn98t03b8Yn2QCZ7qNYUZYX
XRciuG60ql5GD4C30ZstWa6kfNZeeob/IRkK2lJrpTe1dhfHoZpqjSAr6rEGD32m
qIyUcrfgtsTgQbPVlKekj7t7lXrvPLchW8C96Em0wUZT+lCW1sA=
=tjau
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
