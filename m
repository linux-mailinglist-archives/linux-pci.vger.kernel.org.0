Return-Path: <linux-pci+bounces-32409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C636CB090B2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CF6168C4E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F62F85D1;
	Thu, 17 Jul 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4DCe0Wu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906C1E47A5;
	Thu, 17 Jul 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766639; cv=none; b=Y8DRVVhqN0fHAkgv3dtW7U17p32xU2SU8qEPO0h4AYJk8sFZOqlzw/bjhho7ZIl7Ky2gCdQDQI8JekufJhxApk+xR3NjZ2ND7Gu8v+V1BC7DwnFMD8XkuDOP8FC0KQsptyY7pq2/b3cMqf5RKgYmm5GfDU1azusLeDvLW7MvyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766639; c=relaxed/simple;
	bh=a0vlojsWLFqpyamqySLu2FdpCAD0OWEIk4/dwKtK5A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIxEVCqQQFH8yQwdIsrJTT9xGfbEumzHaffHjXkG3/y1uEHc98UoRCtGnDAtFsEWqlMheON9qkhVPi0Ej6WQe/1mO7W3LSnx2AjG6nih7XSAQE38aE9aahS+qKOwkQdwFZTr9mySRSTdEaeT+N8khI/XPQSiTFU7zM2btaybgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4DCe0Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F2C4CEE3;
	Thu, 17 Jul 2025 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752766638;
	bh=a0vlojsWLFqpyamqySLu2FdpCAD0OWEIk4/dwKtK5A4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I4DCe0Wu76JCO9xDZy6z3QT2EJSoL/4HAqn+/RCsaDSmDHrDAffYxqBN+fp1+p8qT
	 Rm+phDh+PpHpqtRCqc0X8nSSZcIeu5Y+kW1sTJ4WCwdKawJm0plH+j2eYbLeySCVAE
	 81bCNEtaI4kWfJNmEfRnw2VQLLHyX50NKRojmVmmt/CTilaNNjHCGIO9P9XDz9a8FJ
	 dosf7emh8TZRcXGVBafNZfeuga5fSHkOyiUywPe6eFDpJ0fHumazp7yuthkjkq/YpQ
	 aD7zkmdIF9i1mmE5cbn/4LyVyecfchmSV8Xlwd5dHP9oCVt7RqRJSp7FJjE6gmRfKw
	 3UJpxNawRqRJg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611f48c6e30so541433eaf.0;
        Thu, 17 Jul 2025 08:37:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1tfAg67VouVbSCH1D2K/p6MxEjPkQmjtL/HZg8T0XT3iQfbop2/eLNP+N9K9vUiG2cOZ7g10yW9PKf3Y=@vger.kernel.org, AJvYcCWEOw74NqA51kAcA/lOXbzkKg7YHTFXfoKuLH0buZ3Ovl7QvP/vvcn1n8Ij6It7nKTAfyOLrpTT3XE7@vger.kernel.org, AJvYcCX+007svqMEdh/moRgrZvflPzxF07ygQC1cRhIC2GogPftfGS/XQWLPHhZNPmVJqeAdoeVdWa43VPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFYDUYI/XGgCbUWzDqJ5Wtu71CKYZY8ZdnVEOtEXXLIvptEPK
	1y1ziq2kodTYWxgiQvKqksc6t4jtthUJhkaffdtpP/Bex8e9rNSBUhG1hhHLu1rNxJ2X96NQ3NJ
	YPESTGTcJst/IcNdExIdGSTtud0Z6XoA=
X-Google-Smtp-Source: AGHT+IEml34oxpvPpWkQPR5hHME0NYRSKwIBLGlh1zEHVcWbgVoD5yKsFFOO7VaTzk+7e7M5k8nyi+GD5WtLrHXmAjs=
X-Received: by 2002:a05:6820:6408:b0:615:7f6b:2ccc with SMTP id
 006d021491bc7-615ad9c1bb9mr1656821eaf.3.1752766633284; Thu, 17 Jul 2025
 08:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
 <4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr>
 <CAJZ5v0h+v5pUP39vTWpNNK2D8=X2UdjUTtZ7yQHCQ2k=r2kkMg@mail.gmail.com> <tbj67d2j4bzf3em5nw73w354lqji3baurajbseyouls53odjxq@4edjrxtdaeum>
In-Reply-To: <tbj67d2j4bzf3em5nw73w354lqji3baurajbseyouls53odjxq@4edjrxtdaeum>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 17:37:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htsq80MT53HQ+=yJZjjjtaKc7Ccmvps6j9Z5phjT0d4w@mail.gmail.com>
X-Gm-Features: Ac12FXyNRFPLuXjNGlwSJ-_TR4lsaaA7B_XUzqOjzN5kL3XwM3ytEw5kXKjHd5w
Message-ID: <CAJZ5v0htsq80MT53HQ+=yJZjjjtaKc7Ccmvps6j9Z5phjT0d4w@mail.gmail.com>
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
To: David Box <david.e.box@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mani@kernel.org, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:13=E2=80=AFPM David Box <david.e.box@linux.intel.=
com> wrote:
>
> Hi Mani, Rafael,
>
> On Thu, Jul 17, 2025 at 12:03:32PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 05:40:24PM GMT, David E. Box wrote:
> > > > Hi all,
> > > >
> > > > This RFC series addresses a limitation in the PCIe ASPM subsystem w=
here
> > > > devices on synthetic PCIe hierarchies, such as those created by Int=
el=E2=80=99s
> > > > Volume Management Device (VMD), do not receive default ASPM setting=
s
> > > > because they are not visible to firmware. As a result, ASPM remains
> > > > disabled on these devices unless explicitly enabled later by the dr=
iver,
> > > > contrary to platform power-saving expectations.
> > > >
> > > > Problem with Current Behavior
> > > >
> > > > Today, ASPM default policy is set in pcie_aspm_cap_init() based on =
values
> > > > provided by BIOS. For devices under VMD, BIOS has no visibility int=
o the
> > > > hierarchy, and therefore no ASPM defaults are applied. The VMD driv=
er can
> > > > attempt to walk the bus hierarchy and enable ASPM post-init using r=
untime
> > > > mechanisms, but this fails when aspm_disabled is set because the ke=
rnel
> > > > intentionally blocks runtime ASPM changes under ACPI=E2=80=99s FADT=
_NO_ASPM flag.
> > > > However, this flag does not apply to VMD, which controls its domain
> > > > independently of firmware.
> > > >
> > > > Goal
> > > >
> > > > The ideal solution is to allow VMD or any controller driver managin=
g a
> > > > synthetic hierarchy to provide a default ASPM link state at the sam=
e time
> > > > it's set for BIOS, in pcie_aspm_cap_init().
> > > >
> > >
> > > I like the idea and would like to use it to address the similar limit=
ation on
> > > Qcom SoCs where the BIOS doesn't configure ASPM settings for any devi=
ces and
> > > sometimes there is no BIOS at all (typical for SoCs used in embedded =
usecases).
> > > So I was using pci_walk_bus() in the controller driver to enable ASPM=
 for all
> > > devices, but that obviously has issues with hotplugged devices.
> > >
> > > > Solution
> > > >
> > > > 1. A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, based on Ra=
fael's
> > > > suggestion, to signal that the driver intends to override the defau=
lt ASPM
> > > > setting. 2. A new field, aspm_bus_link_state, in 'struct pci_bus' t=
o supply
> > > > the desired default link state using the existing PCIE_LINK_STATE_X=
XX
> > > > bitmask.
> > > >
> > >
> > > Why would you need to make it the 'bus' specific flag? It is clear th=
at the
> > > controller driver is providing the default ASPM setting. So pcie_aspm=
_cap_init()
> > > should be able to use the value provided by it for all busses.
> > >
> > > Like:
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 2ad1852ac9b2..830496e556af 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -791,6 +791,7 @@ static void aspm_l1ss_init(struct pcie_link_state=
 *link)
> > >  static void pcie_aspm_cap_init(struct pcie_link_state *link, int bla=
cklist)
> > >  {
> > >         struct pci_dev *child =3D link->downstream, *parent =3D link-=
>pdev;
> > > +       struct pci_host_bridge *host =3D pci_find_host_bridge(parent-=
>bus);
>
> I see. This is better. I'll make this change.
>
> > >         u32 parent_lnkcap, child_lnkcap;
> > >         u16 parent_lnkctl, child_lnkctl;
> > >         struct pci_bus *linkbus =3D parent->subordinate;
> > > @@ -866,8 +867,8 @@ static void pcie_aspm_cap_init(struct pcie_link_s=
tate *link, int blacklist)
> > >         }
> > >
> > >         /* Save default state */
> > > -       if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
> > > -               link->aspm_default =3D parent->bus->aspm_bus_link_sta=
te;
> > > +       if (host && host->aspm_bus_link_state)
> > > +               link->aspm_default =3D host->aspm_bus_link_state;
> > >         else
> > >                 link->aspm_default =3D link->aspm_enabled;
> > >
> > > This avoids the usage of the bus flag (which your series is not at al=
l making
> > > use of) and allows setting the 'host_bridge::aspm_bus_link_state' eas=
ily by the
> > > controller drivers.
> >
> > This is very similar to what I have just suggested and I like this one.
>
> I considered this. But 0 could technically mean that the controller wants
> ASPM to be disabled. The VMD driver doesn't need to do this though and if
> others don't currently need this then I can drop the flag.

Until anyone wants 0 to mean something different from "figure out the
default settings for me", I would not use the flag.

