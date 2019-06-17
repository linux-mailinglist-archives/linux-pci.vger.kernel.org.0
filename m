Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147FC48099
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfFQL0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 07:26:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35745 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfFQL0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 07:26:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so8700616wml.0;
        Mon, 17 Jun 2019 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFAmzUaSQdj6bLDsdqy9hIrBxzUAI5XCraEnBGBimYM=;
        b=j5ql7T8+Pu0mW8xqDjcOBsGIjYX2jLUpMxUUfatbZHzg7xpEiBIOpMCA4QUFgnvL4y
         rYzavB2nSWnuiXZ4Utj/3JEAh4spnDaEX+lzarWElULoKpNrM9JR4xZDvFXYyEirHkat
         U3m5OveN6L+7QqIBbYUPX6k/2uHz43C8kbX90D+FSUrKpmI1nbhbC0eAbX0bOsNlzcTP
         R9WdHYBFLNxRWAD4QPg7J0gZ6a8meaxyCenYMAKz3BX9WQ8Pq4CSuqzkpa1HiiiGcptS
         Q/NewqxIQ891aHIrUUPiWo+xQ/QIAHEz4e9vqFcGiqU+1nB26U0ceKtI/7tNu2LqbYOb
         W1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFAmzUaSQdj6bLDsdqy9hIrBxzUAI5XCraEnBGBimYM=;
        b=ceSzEY9xzx9a6vTurvrk2tUAu1bIBslqUqFqgK67kBTmNfxQaogPMv6eACXXhW2Zqh
         gBHcwhWql8f9gcbubUIuFDiqOPwQvyyjBuyHG4IYtRNvcs8Tr60yz2wKEwnt7XrlI4NA
         48d8GKpnmwaAro4j/Fj7uT9mSuou0pR9EGyGcuAxYWh7Ba2F8HUICf56itAfmwVdRXYM
         YlRaUFK1c/wx8j54LvI3GnijrVgqRueKg8A+hznkN09lhju+xzDFNhWd7mOm/E5Ffjao
         klaC52uP2CWFjdeOFtxDoUjCuFJCAtqGXLt0h/OIWLgTX9OohhJbvsIZrDt2nXat2AX8
         3Lmw==
X-Gm-Message-State: APjAAAXmncsjS9iy+JMupwSqgaaVPRizVFRTYEfgholiTgavUTiYZUb1
        qFpUFXVh25HXgtxZKt6fv68=
X-Google-Smtp-Source: APXvYqymFLNuSmABJO7t+i51rXKKOKOwGhGk8A4z4Fn2rVaFW+iVVfshLBocHOwY8LakUHR+XyWjNA==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr17667817wmj.43.1560770808758;
        Mon, 17 Jun 2019 04:26:48 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id l19sm7874557wmj.33.2019.06.17.04.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 04:26:47 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:26:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190617112646.GI508@ulmo>
References: <20190604132233.GT16519@ulmo>
 <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
 <20190614152304.GK15526@ulmo>
 <20190614155934.GA28253@e121166-lin.cambridge.arm.com>
 <51e4ae62-f842-1d2f-fbca-0b2063dd53a6@nvidia.com>
 <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tSiBuZsJmMXpnp7T"
Content-Disposition: inline
In-Reply-To: <20190614165353.GB30511@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--tSiBuZsJmMXpnp7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 05:53:53PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 10:00:49PM +0530, Manikanta Maddireddy wrote:
>=20
> [...]
>=20
> > GPIO based PERST# is per-platform requirement.
> > If DT prop is not present, then devm_gpiod_get_from_of_node() returns
> > NULL gpio_desc.
> >=20
> > struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
> >                                          const char *propname, int inde=
x,
> >                                          enum gpiod_flags dflags,
> >                                          const char *label)
> > {
> >         struct gpio_desc *desc;
> >         unsigned long lflags =3D 0;
> >         enum of_gpio_flags flags;
> >         bool active_low =3D false;
> >         bool single_ended =3D false;
> >         bool open_drain =3D false;
> >         bool transitory =3D false;
> >         int ret;
> >=20
> >         desc =3D of_get_named_gpiod_flags(node, propname,
> >                                         index, &flags);
> >=20
> >         if (!desc || IS_ERR(desc)) {
> > */* If it is not there, just return NULL */****if (PTR_ERR(desc) =3D=3D=
 -ENOENT)****return NULL;*
> >                 return desc;
> >         }
> > 	...
> >=20
> > }
>=20
> Ok. My point then is that you have no way to enforce this requirement on
> platforms that actually need it, I do not even know if there is a
> way you can do it (I was thinking along the lines of using a
> compatible string to detect whether the GPIO #PERST reset is mandatory)
> but maybe this is not even a SOC property.

So this is definitely not an SoC property. From what Manikanta said, the
only reason why we need this is because on one particular design (that
we know of), the PCIe #PERST signal was connected to a pin that does not
originate from the PCIe controller. This happened by accident.

> Maybe what I am asking is overkill, I just wanted to understand.
>=20
> I was just asking a question to understand how you handle the case
> where a GPIO pin definition is missing in DT for a platform that
> actually needs it, the driver will probe but nothing will work.

I think we should handle this the way we handle other GPIOs as well. If
some device requires a GPIO to be toggled to put it into or take it out
of reset, then that's something that needs to be described in DT. In
this case it just so happens that typically we don't need to worry about
it because the signals are properly connected and then the PCIe
controller will do the right with the reset. For the one design where
it doesn't work the reset GPIO is a workaround and it's board-specific
knowledge that the engineer writing the DT will have to know. I suspect
that if the same accident happened on another board, then as part of
writing the DT somebody would have noticed that we need an external pin
to be hooked up because the SFIO doesn't work.

> It would be good to describe this and capture it in the commit log.

Agreed. Let's be more verbose about the situation where this is required
and make it very clear that this is a workaround for a board design
mistake that shouldn't be necessary if best practices are followed.

Maybe add that to both the commit message and the device tree bindings
to make it difficult for people to miss.

Thierry

--tSiBuZsJmMXpnp7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0HePQACgkQ3SOs138+
s6GyRw/+KiNbYezQti1sbqNBOr3ufw6pfbPk7zkFmFTzXPc/OTnSjYc5P1gdCN32
2OuGcnVhkFBRtMl2EIz33HMQN/v/PzbwKZB5qbx4C/jaskFfI9zPpqvrHUVWqq4I
WaIYm/ZHgwb+6pivz0/LFKtXIss11qrf/d/TWKtsgcAhuaTDW96lXjnzhrsZLHg+
16so4UgVtQqMpN6ICm4OZVcRxivJSNkJA2YwwOTCaz1/3KClMWncamM8apY31M4A
DAZReYxAubdOvwFM3UCOAHetsESlgqX1j3uGlxw/UPmwUpAXfoF0SIRVyG6k4AOF
hvAFxzs/WDVZtM+gVsQf6F3rA0nbRSJvLj72QmBEMnPBE+6CdQo3RC41C20ls6zK
CBRPlswy69oUywjWOL+8LqTZl7WPJHDWZFKempXLfG+M3bWYPwgelSnt7CcVgWM5
PbFel61c7nWT2lxzQflgrhp0DZ3dhSYjXUGND54C2A/079gFMpvbRy6WQKhW/soA
uFEHk/C56c4PAy+a5qtVc+CcPLwBsSKq3AHWslrm7h3zSnaUgtAg2+RNfDlc5XYp
M/hEtnrlglnImxm0B69dwEMEfMsWRKLCoRMhqIv2GrT4azyPAWubY9Bhloq5ghc0
mUpQ+oHNScI1yiVt6Of/qo4GJDFtkew0OeF95UugdRj8DltZHCQ=
=EYXc
-----END PGP SIGNATURE-----

--tSiBuZsJmMXpnp7T--
