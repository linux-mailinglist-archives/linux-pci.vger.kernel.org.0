Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657491DE87E
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgEVOGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVOGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 10:06:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A7C061A0E;
        Fri, 22 May 2020 07:06:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d24so9318198eds.11;
        Fri, 22 May 2020 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKomine+13kKXQ1uSKwJ46XzKp9FSB7Ngcupfo+FaTg=;
        b=axGyCRvJrM28IxRyzB8xzV5OwSYa5s//GUgkkOk2riWAOAqAZ3/aRZZONpE6dP2w1U
         I38RTUw74/E2NsEJCjxtsxIlm6U5WCwJ/v31QBwuz3k284R5NokRwceMeMhJGT/pxZRO
         fu/oHMdc17nR8n6tT6xOGfVF7JRXjFSWciQQlVpUeqAE0X8yp1xI9X5ZzvW81mWyYrjH
         WpVrSs2YehA07qv3uuAzpKcSv/TE9ZExJuZM/9NrW6a5zq5h6H4Vchn5INjnfIwlgLew
         6+dZ5anOr7klnq+Ypy4GxxFPRGVvcQ13Yn3msdGl65bdiZXFlB41vlq5TKv0kEaNQEHn
         qdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKomine+13kKXQ1uSKwJ46XzKp9FSB7Ngcupfo+FaTg=;
        b=HVLFpmi1lrMRn6D8ExyrpEUR7eCy0ffuyvyNkQKGFKLiPRL0Lw//IKdZEibBbXipvu
         R9jFRnknypnFL5NPN6swVZFi6fTqIkOeZo2r/8vKmn8yg1W2YTtgJFzKpy9+Lqlz+txY
         8EnrJ1tuv38VGMkrjYERQMRtQDKJoz8fpRpI4YfgG9yXYgjdhWj9LTinsz/1JNIKpVnr
         VBlTd8x+YtQ3m+8vkM+naT6X1G9xq1YgfictJl9P9kmloraA+l2qP1TYf4WAJP3u02Ka
         gPbSsVCCVO1iD6UiiH3jPZkpEYstVr4+6c6AJCqMEvkzU5du7B1kNiec24fAD96uxf+o
         GTqw==
X-Gm-Message-State: AOAM532PW9Q5JqY0ANISv0tmERgixnckx3gRRHy8cWfFp4wAEzP9s/M9
        fAlcsJcAz2cjskevBTfxOoo=
X-Google-Smtp-Source: ABdhPJwqYoVn/O7NbXqIo3OI+5P/IpZqFPAeDMkYAYf367GjyQES2w788ZdnJAtxsw/rxKXF7UuwUA==
X-Received: by 2002:a50:a9c4:: with SMTP id n62mr2907588edc.347.1590156405862;
        Fri, 22 May 2020 07:06:45 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id h25sm8173145ejx.7.2020.05.22.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:06:41 -0700 (PDT)
Date:   Fri, 22 May 2020 16:06:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
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
Message-ID: <20200522140640.GA2373406@ulmo>
References: <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
 <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520111717.GB2141681@ulmo>
 <b1a72abe-6da0-b782-0269-65388f663e26@nvidia.com>
 <20200520224816.GA739245@bogus>
 <20200522120655.GC2163848@ulmo>
 <20200522133249.GF11785@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20200522133249.GF11785@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 02:32:49PM +0100, Lorenzo Pieralisi wrote:
> On Fri, May 22, 2020 at 02:06:55PM +0200, Thierry Reding wrote:
> > On Wed, May 20, 2020 at 04:48:16PM -0600, Rob Herring wrote:
> > > On Wed, May 20, 2020 at 11:16:32PM +0530, Vidya Sagar wrote:
> > > >=20
> > > >=20
> > > > On 20-May-20 4:47 PM, Thierry Reding wrote:
> > > > > On Tue, May 19, 2020 at 10:08:54PM +0000, Gustavo Pimentel wrote:
> > > > > > On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi
> > > > > > <lorenzo.pieralisi@arm.com> wrote:
> > > > > >=20
> > > > > > > On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > > > > > > > > External email: Use caution opening links or attachments
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas w=
rote:
> > > > > > > > > > [+cc Alan; please cc authors of relevant commits,
> > > > > > > > > > updated Andrew's email address]
> > > > > > > > > >=20
> > > > > > > > > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar w=
rote:
> > > > > > > > > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource=
 size exceeds max for
> > > > > > > > > > > 32-bits") enables warning for MEM resources of size >=
4GB but prefetchable
> > > > > > > > > > >    memory resources also come under this category whe=
re sizes can go beyond
> > > > > > > > > > > 4GB. Avoid logging a warning for prefetchable memory =
resources.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > > > > > > > ---
> > > > > > > > > > >    drivers/pci/controller/dwc/pcie-designware-host.c =
| 3 ++-
> > > > > > > > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designwa=
re-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > > > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host=
=2Ec
> > > > > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host=
=2Ec
> > > > > > > > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie=
_port *pp)
> > > > > > > > > > >                       pp->mem =3D win->res;
> > > > > > > > > > >                       pp->mem->name =3D "MEM";
> > > > > > > > > > >                       mem_size =3D resource_size(pp->=
mem);
> > > > > > > > > > > -                   if (upper_32_bits(mem_size))
> > > > > > > > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > > > > > > > +                       !(win->res->flags & IORESOURC=
E_PREFETCH))
> > > > > > > > > > >                               dev_warn(dev, "MEM reso=
urce size exceeds max for 32 bits\n");
> > > > > > > > > > >                       pp->mem_size =3D mem_size;
> > > > > > > > > > >                       pp->mem_bus_addr =3D pp->mem->s=
tart - win->offset;
> > > > > > > > >=20
> > > > > > > > > That warning was added for a reason - why should not we l=
og legitimate
> > > > > > > > > warnings ? AFAIU having resources larger than 4GB can lea=
d to undefined
> > > > > > > > > behaviour given the current ATU programming API.
> > > > > > > > Yeah. I'm all for a warning if the size is larger than 4GB =
in case of
> > > > > > > > non-prefetchable window as one of the ATU outbound translat=
ion
> > > > > > > > channels is being used,
> > > > > > >=20
> > > > > > > Is it true for all DWC host controllers ? Or there may be ano=
ther
> > > > > > > exception whereby we would be forced to disable this warning =
altogether
> > > > > > > ?
> > > > > > >=20
> > > > > > > > but, we are not employing any ATU outbound translation chan=
nel for
> > > > > > >=20
> > > > > > > What does this mean ? "we are not employing any ATU outbound.=
=2E.", is
> > > > > > > this the tegra driver ? And what guarantees that this warning=
 is not
> > > > > > > legitimate on DWC host controllers that do use the ATU outbou=
nd
> > > > > > > translation for prefetchable windows ?
> > > > > > >=20
> > > > > > > Can DWC maintainers chime in and clarify please ?
> > > > > >=20
> > > > > > Before this code section, there is the following function call
> > > > > > pci_parse_request_of_pci_ranges(), which performs a simple vali=
dation for
> > > > > > the IORESOURCE_MEM resource type.
> > > > > > This validation checks if the resource is marked as prefetchabl=
e, if so,
> > > > > > an error message "non-prefetchable memory resource required" is=
 given and
> > > > > > a return code with the -EINVAL value.
> > > > >=20
> > > > > That's not what the code is doing. pci_parse_request_of_pci_range=
() will
> > > > > traverse over the whole list of resources that it can find for th=
e given
> > > > > host controller and checks whether one of the resources defines p=
refetch
> > > > > memory (note the res_valid |=3D ...). The error will only be retu=
rned if
> > > > > no prefetchable memory region was found.
> > > > >=20
> > > > > dw_pcie_host_init() will then again traverse the list of resource=
s and
> > > > > it will typically encounter two resource of type IORESOURCE_MEM, =
one for
> > > > > non-prefetchable memory and another for prefetchable memory.
> > > > >=20
> > > > > Vidya's patch is to differentiate between these two resources and=
 allow
> > > > > prefetchable memory regions to exceed sizes of 4 GiB.
> > > > >=20
> > > > > That said, I wonder if there isn't a bigger problem at hand here.=
 From
> > > > > looking at the code it doesn't seem like the DWC driver makes any
> > > > > distinction between prefetchable and non-prefetchable memory. Or =
at
> > > > > least it doesn't allow both to be stored in struct pcie_port.
> > > > >=20
> > > > > Am I missing something? Or can anyone explain how we're programmi=
ng the
> > > > > apertures for prefetchable vs. non-prefetchable memory? Perhaps t=
his is
> > > > > what Vidya was referring to when he said: "we are not using an ou=
tbound
> > > > > ATU translation channel for prefetchable memory".
> > > > >=20
> > > > > It looks to me like we're also getting partially lucky, or perhap=
s that
> > > > > is by design, in that Tegra194 defines PCI regions in the followi=
ng
> > > > > order: I/O, prefetchable memory, non-prefetchable memory. That me=
ans
> > > > > that the DWC core code will overwrite prefetchable memory data wi=
th that
> > > > > of non-prefetchable memory and hence the non-prefetchable region =
ends up
> > > > > stored in struct pcie_port and is then used to program the ATU ou=
tbound
> > > > > channel.
> > > > Well,it is by design. I mean, since the code is not differentiating=
 between
> > > > prefetchable and non-prefetchable regions, I ordered the entries in=
 'ranges'
> > > > property in such a way that 'prefetchable' comes first followed by
> > > > 'non-prefetchable' entry so that ATU region is used for generating =
the
> > > > translation required for 'non-prefetchable' region (which is a non =
1-to-1
> > > > mapping)
> > >=20
> > > You are getting lucky with your 'design'. Relying on order is fragile=
=20
> > > (except of course in the places in DT where order is defined, but ran=
ges=20
> > > is not one of them).
> >=20
> > Yeah, I think the DWC core should be improved to differentiate between
> > the two types of memory resources. There shouldn't be a need to encode
> > any ordering because the type is already part of the value in the
> > ranges property.
>=20
> DWC resources handling is broken beyond belief. In practical terms, I
> think the best thing I can do is dropping:
>=20
> 9e73fa02aa00 ("PCI: dwc: Warn if MEM resource size exceeds max for 32-bit=
s")
>=20
> from my pci/dwc branch. However, the ATU programming API must be fixed
> and this reliance on DT entries ordering avoided - it is really bad
> practice (and it prevents us from reworking kernel code in ways that are
> legitimate but would break owing to DT assumptions).
>=20
> So yes, the DWC host bridge code must be updated asap - this is not
> acceptable.

Vidya, would you have any spare cycles to look into this a bit since
you're already familiar? I think for starters it would be good to add
a special case to the IORESOURCE_MEM case in dw_pcie_host_init() that
deals with IORESOURCE_PREFETCH set and then store the result in a
separate struct resource in struct pcie_port, something roughly along
the lines of:

	struct pcie_port {
		...
		struct resource *mem;
		struct resource *prefetch;
		...
	};

	...

	int dw_pcie_host_init(struct pcie_port *pp)
	{
		...
		resource_list_for_each_entry(win, &bridge->windows) {
			switch (resource_type(win->res)) {
			...
			case IORESOURCE_MEM:
				if (win->res.flags & IORESOURCE_PREFETCH) {
					pp->prefetch =3D win->res;
					...
				} else {
					pp->mem =3D win->res;
					...
				}
				break;
			...
		}
		...
	}

I suppose for the non-prefetchable memory we could leave the warning in
because they can never be larger than 32 bits anyway. Then again, I'm
not sure the check is actually fully correct. My recollection is that
non-prefetchable memory needs to be completely within the 4 GiB range,
rather than just the base and the size. So I think something like the
base starting at 3 GiB and then spanning 2 GiB would be valid according
to the current check, but I don't think it's valid according to the
specification.

The other interesting datapoint to have would be whether the DWC core
always has 1:1 mappings for prefetchable memory. If so, I think it might
be useful to still parse them, even if nothing in the driver is using
them. But I don't know what would be a good way to find out if that's
really the case.

I also saw, like you did, that none of the other, non-Tegra device trees
specify any prefetchable memory for the DWC, so I don't understand how
they would work. Perhaps they just don't support prefetchable memory?

If you don't have the time to do this I could possibly take a stab at it
but there are a few other things I need to look into, so I probably
won't get around to this within the next two or so weeks.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7H3G0ACgkQ3SOs138+
s6H7fA//cS2l6RvIAesUNqQkRbJlwoP5NA73bqEp3puKo6fpFAS22RhNQ3wsDSp5
eGw4Xr3YIU5iX0upOWlm4C3rqKgqlVckcuZWSm2MRXty8TaRG6EpE1q4yd0P1ASD
8qg+BbFIpfXIQ8/ulGSuVaBYJ9dz68NdvqzeYPAxupiVSDPN79jxxu2hALChTZK+
dQ+jUYDzV8CSFeD0nwYPAJ891atH0Gea380BMfsQ0+p19gY++sG7u+RMJtjr2Jit
8On3OTFurs9wWvoWnwrU3bnSc9rSO6QvCDb6tCEy5pH1WOkOAf3Q9thFsate/dec
VjZQ3qU0CbcSUWHCKFfKM5mwTy7bEftXJklmGoyYm+xSr4gtRfF9U1Vh9wpt4Xjt
jwHvg6AX0yI7w0+HnU0alqg05ytpkh1hwWnf5cKcrYkg9l3DqSc1jwBZJUOAInSy
aHz39nkmOWsQ7vSmgfhFNHX+GOWUnOHA6MbHNL2dDRDNIyEGLwdFTKXfWcLPhY2V
6IKdoNk3PJqDeEsqPXMU8niNVAoCr6V6eV7vu3rnQZURwV/TfH0lCj436raYeCCi
XcgnCysHwT4s2tUSOZNesZ7PuQJo09FvpMhSX86L6v8LM8tn5gqZVfWhzRxui7Rm
lg/peBjfQJsMmqJDWK8WsVWDdP2N0xpVzdfJz58sjuDND4A9sLM=
=IG18
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
