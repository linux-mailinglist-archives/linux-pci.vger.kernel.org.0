Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F347646297
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfFNPXK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 11:23:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53406 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfFNPXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 11:23:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so2781592wmj.3;
        Fri, 14 Jun 2019 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCsIQkHts/WGN8UBpWhd/+xj5TSD+Bur2KRjDgtvffs=;
        b=oO2X+W9uAsJjUGStbkGRtQjX1SfgVtB0SbNkl+gnNF7KWTkyd6/VxCmxC7tosMy5Ie
         xtF+p11nkjefX6KDObAa6yjyfzTZ1VFGJYe3t3D0x7sX+u8YkRzzHft0CwJuL4QC7aOl
         A8XibhY3qDwxt7kc9M+jYpC+V0v/qq/KfNmbUGcM59p3K0UpKQUljAL1M6TMUB4QeJVA
         gx0jr93i72vm4hrZ4451EAUnTXRuUbQU8tdtKWQx0geFJlVLCGmzJ09MjaU6WmiHhqrI
         /SlUsRSgHuBbKpUTtockIZ9Wla7J/1htQLJ1WCHEm4Fpw9r6egX2TxB20MTd2yjH5IaR
         hH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCsIQkHts/WGN8UBpWhd/+xj5TSD+Bur2KRjDgtvffs=;
        b=aayWM06SDetAZef+8v0UUkClIw2teUJxnOVi2pBSoThnVTHU+dBtXXYwan9BcOS7So
         6yp+tjanenwPTQJsOHQ8cJP/GeyusjioVcCNuBJFuPBLifNIRNajcmGAyakGotol0XJU
         J/s4i7lhMd6g+omqxe9U1nqOqBR2y2vX29LHjVVM84buFhmGv34/serRo7+Ip6HAowIB
         4ThS+r63nZz4DlJaNUgcxrgbPoFGGwpBLRSYvGJsTgpSThdg20yezuuBKLn38Y0+yIZT
         7Cn/whPTJx8T+Pw3XttpfnYetNHRS9f3CDUaKY00HPvSWO6jWhBqNRzcbQ9Pm/vmD4Kv
         KYbw==
X-Gm-Message-State: APjAAAVQ3Pios9Ck8kEFirQ9DMeJS4ktxPGMqGydF5vdYnvo83ewrs6a
        Wt554ChHP924uwjheGvKovU=
X-Google-Smtp-Source: APXvYqzLWzJW/ljpcqiYy+u+u5SOMjYfo17C4C5REFiIwlQi8MiUwMqc2pKURX+tY+8+VdbINem8xQ==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr8400305wml.126.1560525787124;
        Fri, 14 Jun 2019 08:23:07 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id w67sm5577665wma.24.2019.06.14.08.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:23:06 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:23:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        vidyas@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V4 27/28] PCI: tegra: Add support for GPIO based PERST#
Message-ID: <20190614152304.GK15526@ulmo>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
 <20190516055307.25737-28-mmaddireddy@nvidia.com>
 <20190604132233.GT16519@ulmo>
 <20190613152404.GB30445@e121166-lin.cambridge.arm.com>
 <cb2dd446-1275-7179-33ac-e5c237d81da6@nvidia.com>
 <20190614143222.GB23116@e121166-lin.cambridge.arm.com>
 <1508173d-0ecc-f498-6ab2-78a718086b35@nvidia.com>
 <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Content-Disposition: inline
In-Reply-To: <20190614145023.GA24588@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 03:50:23PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 14, 2019 at 08:08:26PM +0530, Manikanta Maddireddy wrote:
> >=20
> >=20
> > On 14-Jun-19 8:02 PM, Lorenzo Pieralisi wrote:
> > > On Fri, Jun 14, 2019 at 04:07:35PM +0530, Manikanta Maddireddy wrote:
> > >>
> > >> On 13-Jun-19 8:54 PM, Lorenzo Pieralisi wrote:
> > >>> On Tue, Jun 04, 2019 at 03:22:33PM +0200, Thierry Reding wrote:
> > >>>
> > >>> [...]
> > >>>
> > >>>>> +	} else {
> > >>>>> +		value =3D afi_readl(port->pcie, ctrl);
> > >>>>> +		value &=3D ~AFI_PEX_CTRL_RST;
> > >>>>> +		afi_writel(port->pcie, value, ctrl);
> > >>>>> +	}
> > >>>>> =20
> > >>>>>  	usleep_range(1000, 2000);
> > >>>>> =20
> > >>>>> -	value =3D afi_readl(port->pcie, ctrl);
> > >>>>> -	value |=3D AFI_PEX_CTRL_RST;
> > >>>>> -	afi_writel(port->pcie, value, ctrl);
> > >>>>> +	if (port->reset_gpiod) {
> > >>>>> +		gpiod_set_value(port->reset_gpiod, 1);
> > >>>> After this the port should be functional, right? I think it'd be b=
etter
> > >>>> to reverse the logic here and move the polarity of the GPIO into d=
evice
> > >>>> tree. gpiod_set_value() takes care of inverting the level internal=
ly if
> > >>>> the GPIO is marked as low-active in DT.
> > >>>>
> > >>>> The end result is obviously the same, but it makes the usage much
> > >>>> clearer. If somebody want to write a DT for their board, they will=
 look
> > >>>> at the schematics and see a low-active reset line and may be tempt=
ed to
> > >>>> describe it as such in DT, but with your current code that would be
> > >>>> exactly the wrong way around.
> > >>> I agree with Thierry here, you should change the logic.
> > >>>
> > >>> Question: what's the advantage of adding GPIO reset support if that=
's
> > >>> architected already in port registers ? I am pretty sure there is a
> > >>> reason behind it (and forgive me the dumb question) and I would lik=
e to
> > >>> have it written in the commit log.
> > >>>
> > >>> Thanks,
> > >>> Lorenzo
> > >> Each PCIe controller has a dedicated SFIO pin to support PERST#
> > >> signal. Port register can control only this particular SFIO pin.
> > >> However, in one of the Nvidia platform, instead of using PCIe SFIO
> > >> pin, different gpio is routed PCIe slot. This happened because of a
> > >> confusion in IO ball naming convention. To support this particular
> > >> platform, driver has provide gpio support. I will update the commit
> > >> log in V5.
> > > What happens on that platform where you trigger reset through a port
> > > register with :
> > >
> > > value =3D afi_readl(port->pcie, ctrl);
> > > value |=3D AFI_PEX_CTRL_RST;
> > > afi_writel(port->pcie, value, ctrl);
> > >
> > > (imagine the DT is not updated for instance or on current
> > > mainline) ?
> > >
> > > Lorenzo
> >=20
> > Lets take an example of PCIe controller-0, SFIO ball name which is
> > controlled by the port-0 register is PEX_L0_RST. It will deassert
> > PEX_L0_RST SFIO line but it doesn't go to PCIe slot, so fundamental
> > reset(PERST# deassert) is not applied to the endpoint connected to
> > that slot.
>=20
> That's the point I am making, if the reset is not applied nothing
> will work (provided PEX_L0_RST does not do any damage either).
>=20
> For the platform in question you should make reset-gpios mandatory and
> fail if not present (instead of toggling the wrong reset line) there is
> no chance the driver can work without that property AFAICS.

I'm not sure I understand what you're proposing here. Are you suggesting
that we put a check in the driver to see if we're running on a specific
board and then fail if the reset-gpios are not there?

Thierry

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0Du9YACgkQ3SOs138+
s6HbbxAAhZP/PrlezAF2+SWVXXEizqiwWsERJwH8MJqbzsUkAkYXXr+07Xd4VNLS
Hz+7Vg7jopAplEICym/ryuOM8AssVpCpZW3rCZK6s5MfKPdejD5fQ0ISBkTxGUB3
+g/bYtqxe//zvP99f5gJH9B94GLGgWg5K/xPTME+0g4ymeqLtR6ZlFXcbn4FrYNv
R1uI2vIo6HhldniwelxDZRrt4BsRe9XggfFqd1y/9UDfxFmhdUhRJtglp9o3CJl8
9rkPqC15Jul39FxsqaqPKilgn2emBinYUJAM6ty9oEQYh9XPe+CBMtoTg8Idm5zz
8SZ85itpeTSyguGlwsmuaQHxq6V79GqGW9MoI7Imf1sQQheMZEPId5Tk5+FoAw3S
YLKpIcI/sr1aYGvULe0qB5COzKQulmgbbLMZ1gQ9r4hQzIDR0cLE41LXkB+UMoDM
5Tj8xrTuKBqYcMsqLCZQ1ZiI/zlupH7jPn1I4j9oleEaEv1NBMCXclPUhtD2v9EW
5C25/MT7axcvJOfXTFszJCmbHE88ybSLJkGvCM52QoEXkIVfFjwSCRVcMYotTqMm
lQivd80PayTYR1TP2KwYsjR3RyqVSb0b9NE2TNO9qEHU3UU6QIP9PHfABHibd0/x
4laNBy09J1Q88exwSstLI+irvxaLDTmiSMUuVk7epOmU4KPNpZI=
=yRTH
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--
