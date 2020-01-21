Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 411D4143E6B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 14:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAUNom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 08:44:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgAUNol (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 08:44:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so3060453wmi.5;
        Tue, 21 Jan 2020 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=if+g8L2ZfoMcIKn+DcPuF7NKQRL3TFRLPN4rsOE3noI=;
        b=oOTfSGFdPLIG3ZFP7RAXMRpRBnIhxnmzZhfnwwpKyaAGD8I5m/xM61q0aD4KkGxU+x
         kph8eF3tFaclGy4y0MsxuJyLM1mBAwXAxLNUASJuuLWedtqdhs9tZLvsXyT3bJfmVaaO
         4NqulbBDC3t8eTofVSIbN7XzOo2mhtQzGTJulQz5CG5iT8F2hYRyanAQKNGDllH23Ibw
         zM4OfF52TN1sglQnrZQCnO/lYGPie1hmRQhQp85BebSAmNe6Y71utgONMKruQf16mKni
         xid3wjVsMyIRQZ5ppWc1Bh1YdIJZJZOfmCpnnXETpYNfim5DmqPxx5fCPa5OC6QfOho4
         BHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=if+g8L2ZfoMcIKn+DcPuF7NKQRL3TFRLPN4rsOE3noI=;
        b=o+HFfhsmDK2ZcifrSSPA4YFWO2KjMftuQ1KEyCH9YYDdG3Ve0VkeoIbzh0tfMLa0V8
         jiv7hOHShVW8VhhBR3rfVTw8CvpNb9Vr31ylU1eHiFQ7KOV1SOR8OCrL/V9A25xevvZN
         NHEygXLez5aKtt+Miivn5BEf3vUzd0JDm8T3LM6JLrGzsjx4pKT0vBzYlnQcb7dJySlq
         SuYhFOwRMIaLF/PJNQTzli6eT2H0755E3g1JmYZOh+Fwwz2ZmGxC4kXsNM7wKFnjpDCZ
         gjNQBgDDCxNBucFEwzeNBVMS7ni7yrMazHhwN2oPMh/e5PxcG6DnAAhtMtlHdydbBLas
         v6uw==
X-Gm-Message-State: APjAAAUl53GfTi0gHqnwW6bzWpzyl3ZOyaHNPhdNqjcZ0RAv+fX7mRMY
        Ind2rbYeZRu/WL3PXF3UVoY=
X-Google-Smtp-Source: APXvYqxvUn0yt7E953WqxyycUnvvZpLZrK+yLK0AeN05Sb669QrM1PQPZMDISUTTAH7ZJwVd2KC1Ag==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4742468wmk.68.1579614278174;
        Tue, 21 Jan 2020 05:44:38 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id 16sm3811188wmi.0.2020.01.21.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:44:36 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:44:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200121134435.GC899558@ulmo>
References: <20200103174935.5612-1-vidyas@nvidia.com>
 <CABhMZUUHGEEhsJ-+foSsodqtKXyX5ZNPkGgv_VzXz=Qv+NVcUA@mail.gmail.com>
 <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
 <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
 <20200120111042.GA203160@ulmo>
 <20200120151849.GA24402@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20200120151849.GA24402@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 03:18:49PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Jan 20, 2020 at 12:10:42PM +0100, Thierry Reding wrote:
>=20
> [...]
>=20
> > > > Currently the BSP has the kernel booting through Device Tree mechan=
ism
> > > > and there is a plan to support UEFI based boot as well in the futur=
e software
> > > > releases for which we need this quirky way of handling ECAM.
> > > > Tegra194 is going to be the only and last chip with this issue and =
next chip
> > > > in line in Tegra SoC series will be fully compliant with ECAM.
> > >=20
> > > ACPI on ARM64 works on a standard subset of systems, defined by the
> > > ARM SBSA:
> > >=20
> > > http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base=
_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf
> >=20
> > I don't understand what you're saying here. Are you saying that you want
> > to prevent vendors from upstreaming code that they need to support their
> > ACPI based platforms? I understand that the lack of support for proper
> > ECAM means that a platform will not be SBSA compatible, but I wasn't
> > aware that lack of SBSA compatibility meant that a platform would be
> > prohibited from implementing ACPI support in an upstream kernel.
>=20
> ACPI on ARM64 requires a set of HW components described in the SBSA.
>=20
> If those HW requirements are not fulfilled you can't bootstrap an ARM64
> system with ACPI - it is as simple as that.

That's an odd statement. We do in fact have an ARM64 system that doesn't
fulfill the ECAM requirement and yet it successfully boots with ACPI.

>                                             It is not even appropriate
> to discuss this on a Linux mailing list anymore since it is HW
> requirements and it has been public information since ACPI on ARM64 was
> first enabled.

Erm... we're discussing Linux patches. Why would it be inappropriate to
discuss them on a Linux mailing list?

> > > These patches will have to be carried out of tree, the MCFG quirk
> > > mechanism (merged as Bjorn said more than three years ago) was suppos=
ed
> > > to be a temporary plaster to bootstrap server platforms with teething
> > > issues, the aim is to remove it eventually not to add more code to it
> > > indefinitely.
> >=20
> > Now, I fully agree that quirks are suboptimal and we'd all prefer if we
> > didn't have to deal with them. Unfortunately the reality is that
> > mistakes happen and hardware doesn't always work the way we want it to.
> > There's plenty of other quirk mechanisms in the kernel, and frankly this
> > one isn't really that bad in comparison.
>=20
> Because you don't have to maintain it ;) - I think I said what I had to
> say about the MCFG mechanism in the past - it has been three years
> and counting - it is time to remove it rather that adding to it.

What makes you think you can simply remove this without breaking support
for all of the devices that currently rely on the quirks?

> > > So I am afraid but this quirk (and any other coming our way) will not=
 be
> > > merged in an upstream kernel anymore - for any queries please put Nvi=
dia
> > > in touch.
> >=20
> > Again, I don't understand what you're trying to achieve here. You seem
> > to be saying that we categorically can't support this hardware because
> > it isn't fully SBSA compatible.
>=20
> I am not trying to achieve anything - I am just stating public
> information - let me repeat it again for interested readers: to
> bootstrap an ARM64 system with ACPI the platform HW design must follow
> the SBSA guidelines.

Can you clarify for me where I can find this public information? What
I've been able to find suggests that that SBSA-compliant systems would
typically run ACPI, but I can't find anything about SBSA compliance
being a prerequisite for booting a system with ACPI.

I can understand why someone might *wish* for that to always be true,
but it seems to be a bit far removed from reality.

> > Do you have any alternative suggestions on how we can support this in an
> > upstream kernel?
>=20
> Booting with a device tree ?

We can already do that, but should that prevent us from making UEFI and
ACPI an alternative boot mechanism?

> > We realized a while ago that we cannot achieve proper ECAM on Tegra194
> > because of some issues with the hardware and we've provided this as
> > feedback to the hardware engineers. As a result, the next generation of
> > Tegra should no longer suffer from these issues.
>=20
> We will bootstrap next generation Tegra with ACPI then, there are
> SBSA tests available for compliancy - again, that's a matter for
> Nvidia and Arm to settle, not a mailing list discussion.

I don't understand why you keep insisting on this. The mailing lists are
where kernel patches are discussed, are they not?

> > As for Tegra194, that chip taped out two years ago and it isn't possible
> > to make it fully ECAM compliant other than by revising the chip, which,
> > frankly, isn't going to happen.
> >=20
> > So I see two options here: either we find a way of dealing with this, by
> > either merging this quirk or finding an alternative solution, or we make
> > the decision that some hardware just can't be supported.
> >=20
> > The former is fairly common, whereas I've never heard of the latter.
>=20
> What does this mean ? Should I wreck the upstream kernel to make it boot
> with ACPI on *any* ARM64 platform out there then ?

Heh... you must have a very low opinion of the upstream kernel if you
think merging these 100 lines of code is going to wreck it.

And if you look at the patch, the bulk (95/109 lines) is actually in the
Tegra194 PCIe driver and only 14/109 lines are added to the MCFG quirks.
That's hardly the kind of change that's going to wreck the kernel.

> My stance is clear above and the ACPI PCI programming model - inclusive
> of firmware - has been there since ACPI was deployed, if ACPI support
> is required HW must comply, either that or it is out of tree patches
> and I can't be blamed for that.

Looking at the existing quirks table, there's evidently a number of
people that didn't get the memo. The issue seems to be fairly common,
yet for some reason you're singling out Tegra194.

Thierry

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4nAEEACgkQ3SOs138+
s6G5DQ/9G0ZaDC8Mzmqe9WaV7CIEFGsBcaF8PeT7dmcnEc9yaR1hcFy255/cDsSA
IKNlJgD7GdhlSLKRqUOA1jpfMBhfGGRrZ62yG/Ba7Ha1IevQTlmQrvqW4lDbCAH4
My53v0C3pEsBu9SFsvUxG8PenzWwq6OWtFXOwSngmF/iVyXoNgENJCxjC1perYn6
mAWNINizszqjmlKyaOguNx4Pct/9awCESnrmATe6pnGkZ84r3SSU3TkzihizNpGc
4tbTBHfzAIkldohAJ/dskbXdRDlv2uFabwJMYt554Irb6tnmx8xPZ73SBXjJ6qFz
ljQf2d6c82KEfyVkfAODJaskWWvMLIhq9vVnpNDjtXQbQaRtXtYBD3TG4sRyDOFh
G4hCRYmNkunnr636vR/la/0yi5ld5K0dSJOlYfzLFbjmyZ3OSv0ppJw3QHcyYN9F
0H66WiZNYKHaVhhtGwSjEd3mYX0lH2xGgfNBHTekARi0BUbVfNT1kuwfaontTJYw
HXhrdMRc+rugMu4jZ5rFq3KrX31sY6pUw07Z0O//EYne4pGDtx8Fluqei2kMZwug
MmeO0ikMgXpXDloX5azoWn7wUvjMfhsAzVULVX8kahDmL8BgKttH/y5iSWDWFwao
bdNvSU81crFj9E37pnjfo1+tAQ9N9hLcF16frOywJnDhvAvvpAM=
=/1Qm
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
