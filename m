Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A66155C29
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 17:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGQvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 11:51:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGQvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Feb 2020 11:51:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so3477200wru.7;
        Fri, 07 Feb 2020 08:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PA9PwNmxyxicG7zf4LpvtNx9S/HExxtCM5JGBPlK8N4=;
        b=EIQT0fdqJwQ/VOMS8Atn8WJue3BwbmO81ci/VBDdMwHEjbKnztBnqT2hp3sJRUwYjv
         RUPe/g7nH6kkMPZeEeq/k5SEgJIGuN/mQ3utuLhkWvgg8itfu6qWcYyZbx0ZVRtA6b4H
         l3KjfjcyDZiB9oGJx3Eg7XlyqJi9CQwEAd1MxHaTp0owFUgSaJJPr4ufC+gq0l6lTlCO
         c0oGshZZemdRXxPVFMdY0Ih7gKBznru2tfuyaoLBNG3mM+9bwVwCx6ZOBQ/IWhDMuxkK
         /3D/VoK7rYRxzlkje8L6D1GRuuLmeWabKmhOqZCz6+okxRqnscXARFuBVW2klVk+YKfA
         xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PA9PwNmxyxicG7zf4LpvtNx9S/HExxtCM5JGBPlK8N4=;
        b=CTuudvkhYf31lIJvwAyCGxgjOdqtVJ3WlroDg9LCjXPMa+H+3eT8UYcUy3yCj+l1Yk
         n3Gmwm320TbMaZ5LkQSUVzcmliktokW5wOVrwNhk1YEAqjaHXScvXvpWy+pw52KiyGqt
         zpYSHGT1lQBZMs1R/nRySNp63oe2YHSWbhHsWKlrb2kLh6yPk4iDuHSE2Fv8HlQKe8eD
         Z+QgDR1jJWll0a6rypO6TYugg5tRH+plEj/FD62IuDkC1/mKmUI+WaCfu7uoELRuKt1g
         gJ8u4/RHs4Ue0Oil66SF0xfThZFVNBJhLr1UoevuNTpncu8y0jcEcY+LCDEyeqjyuTpe
         OrVQ==
X-Gm-Message-State: APjAAAVYnahF5ppP+6J/0yYaKwDA2iyED67k0JrxA+jyKSzMWu63uBkO
        kRd4I1+H8WFwe2IOqWhfVDQ=
X-Google-Smtp-Source: APXvYqwKiOI2uMrGmC605wMxAYUmwcX6JMR0+CotWwTLyfg3W8gkJqNm1q333ZFWH4WEIVJcqWw09A==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr5919692wrv.180.1581094304588;
        Fri, 07 Feb 2020 08:51:44 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id t12sm4033907wrq.97.2020.02.07.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:51:43 -0800 (PST)
Date:   Fri, 7 Feb 2020 17:51:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200207165141.GA2608843@ulmo>
References: <20200206164639.GA2182011@ulmo>
 <20200207145001.GA183417@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200207145001.GA183417@google.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 08:50:01AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 06, 2020 at 05:46:39PM +0100, Thierry Reding wrote:
> > On Thu, Jan 23, 2020 at 10:49:41AM +0000, Lorenzo Pieralisi wrote:
> > > On Tue, Jan 21, 2020 at 02:44:35PM +0100, Thierry Reding wrote:
> > > > On Mon, Jan 20, 2020 at 03:18:49PM +0000, Lorenzo Pieralisi wrote:
> > > > > On Mon, Jan 20, 2020 at 12:10:42PM +0100, Thierry Reding wrote:
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > > > Currently the BSP has the kernel booting through Device
> > > > > > > > Tree mechanism and there is a plan to support UEFI based
> > > > > > > > boot as well in the future software releases for which
> > > > > > > > we need this quirky way of handling ECAM.  Tegra194 is
> > > > > > > > going to be the only and last chip with this issue and
> > > > > > > > next chip in line in Tegra SoC series will be fully
> > > > > > > > compliant with ECAM.
> > > > > > >=20
> > > > > > > ACPI on ARM64 works on a standard subset of systems,
> > > > > > > defined by the ARM SBSA:
> > > > > > >=20
> > > > > > > http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Ser=
ver_Base_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf
> > > > > >=20
> > > > > > I don't understand what you're saying here. Are you saying
> > > > > > that you want to prevent vendors from upstreaming code that
> > > > > > they need to support their ACPI based platforms? I
> > > > > > understand that the lack of support for proper ECAM means
> > > > > > that a platform will not be SBSA compatible, but I wasn't
> > > > > > aware that lack of SBSA compatibility meant that a platform
> > > > > > would be prohibited from implementing ACPI support in an
> > > > > > upstream kernel.
>=20
> "Vendors upstreaming code to support ACPI-based platforms" is a
> concept that really doesn't fit in the ACPI model.  More below.
>=20
> > > > > ACPI on ARM64 requires a set of HW components described in the
> > > > > SBSA.
> > > > >=20
> > > > > If those HW requirements are not fulfilled you can't bootstrap
> > > > > an ARM64 system with ACPI - it is as simple as that.
> > > >=20
> > > > That's an odd statement. We do in fact have an ARM64 system that
> > > > doesn't fulfill the ECAM requirement and yet it successfully
> > > > boots with ACPI.
> > >=20
> > > I know very well (but that's not a reason to break the PCIe
> > > specification).
> > >=20
> > > Still, the mistake you are making is thinking that ACPI compliancy
> > > stops at the MCFG quirk. Adding another quirk to the MCFG list
> > > will make PCI enumerates but there is more to that, eg MSI/IOMMU
> > > and that's just an example.
> > >=20
> > > There are platforms in that MCFG list that eg can't do MSI which
> > > basically means they are useless - you look at it as yet another
> > > hook into MCFG, I look at it with history in mind and from an ACPI
> > > ARM64 maintainership perspective.
> > >=20
> > > So first thing to do is to post full support for this host
> > > controller inclusive of MSI/INTx (which AFAICS is another piece of
> > > HW that is not SBSA compliant since DWC uses a funnel to trigger
> > > MSIs) and IOMMU, then we will see how to proceed.
> > >=20
> > > Look at this (and again, that's just an example but AFAICS it
> > > applies to this host bridge as well):
> > >=20
> > > https://lore.kernel.org/linux-pci/VE1PR04MB67029FB127DBF4A725CB969890=
4E0@VE1PR04MB6702.eurprd04.prod.outlook.com
> >=20
> > So it turns out we indeed have the same issue with MSIs since
> > Tegra194 uses the same DesignWare controller that others do (looks
> > like at least HiSilicon and Annapurna Labs are in the same boat).
> > That said, most drivers fallback to legacy interrupts and that works
> > fine. Agreed that it isn't ideal, but it's about as good as it's
> > going to get on this hardware.
> >=20
> > > > > It is not even appropriate to discuss this on a Linux mailing
> > > > > list anymore since it is HW requirements and it has been
> > > > > public information since ACPI on ARM64 was first enabled.
> > > >=20
> > > > Erm... we're discussing Linux patches. Why would it be
> > > > inappropriate to discuss them on a Linux mailing list?
> > >=20
> > > I am not discussing Linux patches at all - I am telling you that
> > > the DWC host controller is not a) PCIe spec compliant b) SBSA
> > > compliant and there is nothing to review from a Linux kernel code
> > > perspective.
> > >=20
> > > This is just another quirk to enumerate with ACPI a non-compliant
> > > system, if Bjorn is willing to take it go for it.
> >=20
> > Yeah, I'd like to hear Bjorn's opinion on this. I understand that
> > this is far from an ideal situation and I'd much prefer that this
> > chip was compliant. But for historical reasons it isn't. This chip
> > was designed before SBSA became the quasi standard. Tegra194 also
> > isn't a server chip to begin with, so SBSA compliance would likely
> > not have been the main objective.
> >=20
> > > > > > > These patches will have to be carried out of tree, the
> > > > > > > MCFG quirk mechanism (merged as Bjorn said more than three
> > > > > > > years ago) was supposed to be a temporary plaster to
> > > > > > > bootstrap server platforms with teething issues, the aim
> > > > > > > is to remove it eventually not to add more code to it
> > > > > > > indefinitely.
> > > > > >=20
> > > > > > Now, I fully agree that quirks are suboptimal and we'd all
> > > > > > prefer if we didn't have to deal with them. Unfortunately
> > > > > > the reality is that mistakes happen and hardware doesn't
> > > > > > always work the way we want it to.  There's plenty of other
> > > > > > quirk mechanisms in the kernel, and frankly this one isn't
> > > > > > really that bad in comparison.
> > > > >=20
> > > > > Because you don't have to maintain it ;) - I think I said what
> > > > > I had to say about the MCFG mechanism in the past - it has
> > > > > been three years and counting - it is time to remove it rather
> > > > > that adding to it.
> > > >=20
> > > > What makes you think you can simply remove this without breaking
> > > > support for all of the devices that currently rely on the
> > > > quirks?
> > >=20
> > > Don't you think I know ? I said "eventually" for a reason, read
> > > what I write.
> >=20
> > I read what you wrote. My point is that even "eventually" things are
> > going to break if you just rip out the quirks.
>=20
> I doubt we'll actually remove quirks; I suspect Lorenzo meant that in
> future hardware we should be removing the *need* for the quirks.  They
> are annoyances and they do make maintenance more difficult, but in
> general I don't think we should remove things that are being used.

I fully agree that we should learn from this and make sure that future
chips move closer towards SBSA compatibility so that these kinds of
quirks will not need to be added indefinitely.

However, there's always going to be transition periods where chips are
not as compliant as we want them to be. This can be timing related, as
well as target related. For example, Tegra194 was designed while the
details of the SBSA were still being worked out, so it can't be expected
to be fully compliant. At the same time, Tegra194 is not a server chip,
so even if SBSA had been finalized prior to its design, compliance may
not have been a consideration.

I guess this wouldn't have been much of an issue if circumstances hadn't
changed in the past few years and users didn't start to want ACPI even
on non-server systems.

> > > > > > > So I am afraid but this quirk (and any other coming our
> > > > > > > way) will not be merged in an upstream kernel anymore -
> > > > > > > for any queries please put Nvidia in touch.
> > > > > >=20
> > > > > > Again, I don't understand what you're trying to achieve
> > > > > > here. You seem to be saying that we categorically can't
> > > > > > support this hardware because it isn't fully SBSA
> > > > > > compatible.
> > > > >=20
> > > > > I am not trying to achieve anything - I am just stating public
> > > > > information - let me repeat it again for interested readers:
> > > > > to bootstrap an ARM64 system with ACPI the platform HW design
> > > > > must follow the SBSA guidelines.
> > > >=20
> > > > Can you clarify for me where I can find this public information?
> > > > What I've been able to find suggests that that SBSA-compliant
> > > > systems would typically run ACPI, but I can't find anything
> > > > about SBSA compliance being a prerequisite for booting a system
> > > > with ACPI.
> > >=20
> > > https://developer.arm.com/architectures/platform-design/server-systems
> > >=20
> > > Read: SBSA/SBBR
> > >=20
> > > /Documentation/arm64/arm-acpi.rst
> > >=20
> > > > I can understand why someone might *wish* for that to always be
> > > > true, but it seems to be a bit far removed from reality.
> > >=20
> > > It is reality and it is not a *wish*, Nvidia will comply - even if
> > > *eventually* we end up merging this code.
> >=20
> > I already said that we reported these findings to the hardware team
> > and this is hopefully going to allow us to be SBSA compliant in
> > future chips. However, it's too late for Tegra194 and we can't
> > retroactively fix it.
> >=20
> > > > > > Do you have any alternative suggestions on how we can
> > > > > > support this in an upstream kernel?
> > > > >=20
> > > > > Booting with a device tree ?
> > > >=20
> > > > We can already do that, but should that prevent us from making
> > > > UEFI and ACPI an alternative boot mechanism?
> > >=20
> > > Why do you need ACPI support ? What for ?
> >=20
> > Customers have requested it and they want to be able to use an
> > upstream kernel.
> >=20
> > > > > > We realized a while ago that we cannot achieve proper ECAM
> > > > > > on Tegra194 because of some issues with the hardware and
> > > > > > we've provided this as feedback to the hardware engineers.
> > > > > > As a result, the next generation of Tegra should no longer
> > > > > > suffer from these issues.
> > > > >=20
> > > > > We will bootstrap next generation Tegra with ACPI then, there
> > > > > are SBSA tests available for compliancy - again, that's a
> > > > > matter for Nvidia and Arm to settle, not a mailing list
> > > > > discussion.
> > > >=20
> > > > I don't understand why you keep insisting on this. The mailing
> > > > lists are where kernel patches are discussed, are they not?
> > >=20
> > > See above.
> > >=20
> > > > > > As for Tegra194, that chip taped out two years ago and it
> > > > > > isn't possible to make it fully ECAM compliant other than by
> > > > > > revising the chip, which, frankly, isn't going to happen.
> > > > > >=20
> > > > > > So I see two options here: either we find a way of dealing
> > > > > > with this, by either merging this quirk or finding an
> > > > > > alternative solution, or we make the decision that some
> > > > > > hardware just can't be supported.
> > > > > >=20
> > > > > > The former is fairly common, whereas I've never heard of the
> > > > > > latter.
> > > > >=20
> > > > > What does this mean ? Should I wreck the upstream kernel to
> > > > > make it boot with ACPI on *any* ARM64 platform out there then
> > > > > ?
> > > >=20
> > > > Heh... you must have a very low opinion of the upstream kernel
> > > > if you think merging these 100 lines of code is going to wreck
> > > > it.
> > >=20
> > > I have a very high opinion of the upstream kernel and that's why
> > > as I said above I think in terms of overall ACPI ARM64
> > > maintainership rather than a platform quirk to get ACPI PCI
> > > enumeration going.
> >=20
> > From a maintenance point of view things aren't going to change much
> > just because we add these additional quirks. These are for the same
> > IP that's already supported by other quirks for other platforms and
> > the code lives entirely in the DesignWare driver, so I don't see how
> > this negatively impacts maintainability of the kernel.
> >=20
> > > > And if you look at the patch, the bulk (95/109 lines) is
> > > > actually in the Tegra194 PCIe driver and only 14/109 lines are
> > > > added to the MCFG quirks.  That's hardly the kind of change
> > > > that's going to wreck the kernel.
> > >=20
> > > See above, show us the rest of the story.
> >=20
> > Like I said, not much we can do about MSI support without more
> > driver- specific code. But since we can fallback to legacy
> > interrupts, things end up working fine.
> >=20
> > Again, I fully realize that this isn't ideal and I'd rather prefer
> > we didn't have to add this. But I'm also realistic and understand
> > that hardware designs aren't always perfect, no matter how much we
> > want them to be. The best we can do is take the lessons learned and
> > try to make the next chip better.
> >=20
> > > > > My stance is clear above and the ACPI PCI programming model -
> > > > > inclusive of firmware - has been there since ACPI was
> > > > > deployed, if ACPI support is required HW must comply, either
> > > > > that or it is out of tree patches and I can't be blamed for
> > > > > that.
> > > >=20
> > > > Looking at the existing quirks table, there's evidently a number
> > > > of people that didn't get the memo. The issue seems to be fairly
> > > > common, yet for some reason you're singling out Tegra194.
> > >=20
> > > The issue is not very common at all. I said it before and I repeat
> > > it again: those MCFG quirks were merged more than three years ago
> > > to help bootstrap ACPI ARM64 ecosystem on early HW and ACPI for
> > > ARM64 is meant for server (SBSA/SBBR compliant) systems, for other
> > > platforms DT is the firmware of choice, ACPI on those does not
> > > work well (and *I* will have to work around it).
> >=20
> > Like I said, Tegra194 is not a server chip. But it turns out that
> > people want to use ACPI on non-server systems as well. The website
> > that you linked to above:
> >=20
> > 	https://developer.arm.com/architectures/platform-design/server-systems
> >=20
> > even says that SBSA is being extended to other segments. So, again,
> > this means that we either have to say, collectively, that we don't
> > want to support ACPI on ARM64 except on systems that are fully SBSA
> > compliant or we have to find a way to make things work. I'm not sure
> > we really want the first option and the quirk is a good compromise
> > to get us the second option.
> >=20
> > > I am not singling out anybody, read the mailing lists and you will
> > > realize. You asked for this patch to be reviewed, I told you what
> > > my thoughts are and this patch implications - you want to go
> > > ahead, ask Bjorn to merge it but at least we do it with the
> > > broader consequences in mind.
> >=20
> > You seemed to be categorically rejecting this patch only because the
> > system wasn't fully SBSA compliant. Given that other, non-SBSA
> > compliant devices are currently supported, it certainly seemed like
> > you were singling out.
> >=20
> > Anyway, like you said, it's ultimately up to Bjorn to take this or
> > not, so it's not productive to go back and forth on this between the
> > two of us.
> >=20
> > Perhaps a more productive way to go forward would be to look at what
> > you had in mind in terms of a deprecation plan for the MCFG quirks.
> > One idea that came up as we were discussing this internally was to
> > move the quirk code into the DesignWare driver. That is, instead of
> > having this code live in the ACPI code and referencing the
> > DesignWare code, it'd be the DesignWare driver itself that would
> > initialize PCI. This would have the added benefit that MSIs could be
> > used, since the DesignWare driver does have the means of decoding
> > which MSI occurred. The same code that is used to do this when
> > booting from DT could be reused when booting from ACPI.
>=20
> I think the idea of moving this code around misses the fundamental
> point that bringing up a new system with ACPI should require *zero*
> kernel changes.  It's not a question of where in the kernel quirks
> live; it's simply that no drivers (DesignWare or other), no quirks,
> no config changes, no new code at all should be required.
>=20
> One should be able to take a RHEL/SUSE/Ubuntu/etc CD released years
> ago and boot it on hardware designed today.  If that CD doesn't boot,
> the starting assumption is that the OEM needs to fix the hardware or
> firmware.  This is standard operating procedure in the x86 world, and
> it's essential if we want to participate in the upstream and distro
> world.

But that's impossible. A CD released years ago wouldn't have had any of
the drivers to enable hardware support for hardware that didn't exist at
the time.

I suspect that you may even be able to boot an old kernel on a Tegra194
with ACPI support and everything that has a standard driver may work.
However, there's a lot of hardware for which standard ACPI drivers
simply don't exist, so there's always going to be code that needs to be
upstreamed in order to fully make use of new hardware.

Thierry

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl49lZoACgkQ3SOs138+
s6Gy+BAAuXpvBD81mTNUXT7wG8Ehu1Ts1hbuyiaDAlrQ4rDNuE0C/lXArDkoN/Kv
bo9HwSiYSEHvxG2RjAYtjkHrxQCRE0Dq7lL+yKf4Z4BlpSUn7tiNaUicDy/YqjqC
xm9L4SttPHSipvcAS8s299kjobAQLp5brQjEpGlKuAvpyFIqjz5hl1iSrzW1tflk
RwQ1L+vyrCAST51oKYOSBWfprUkTrHqzRZZDAUyjJh/f+SWogGTiS9OOORzyiFH4
ruAtAw949hsE6feiNPDWFmiOTJB+bl8MB++wXF/b6QjiiPVV0ojII0D62XQwqCzY
pfCQlzc8SFawejIxBWvGQyEqpS+jEgLIXyeO6cmhRpFHnjUk8Bkm9WppfUVxHcEM
gC1t/UV+389wQEMlUm0v9D9bNl2MB5AbgLgJte/6xzCO7F+aXU8XKNzgyYq5Kn1V
Y/L675/9Bo9JeMCqHMkw0haZqOAxNFA+wkt+L1J3YiRMX7eSZ0GWTUfHjddm5JyU
PHuTR4FJNxM12/fkxZKhxVMxuCdGJrenN4E4TYCsO8neeRM/BHmBec9fwy57WTvT
t0YVOoaLhMdm2Ova3IZQypERFopXBHRePKhRpxPZs3rHQvZ995be3uqjbCa9HKvC
K9lc8fGIk19AtxRHwfeHs0NKdu/1HkKbZmtmCCZhslDvyv1NZFE=
=GjwT
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
