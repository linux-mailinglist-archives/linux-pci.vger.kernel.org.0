Return-Path: <linux-pci+bounces-32880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE83B10725
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5A73BC6EF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FE25A2A7;
	Thu, 24 Jul 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw+McJPC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08FB257440;
	Thu, 24 Jul 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351134; cv=none; b=W9ZrLDtK4Eouuq7CO7apmJFfifJcSCEY1/SE6DjOkWhzyz6K6ywxTyM/ORZNQio6EJUoUmt8c52AgcGtoaeT/TbTXVFizY/ZYsljlVxGIe6wf1tRhNXI5YGZgb1C5JXFohRUQD223p01qlju/03Pr9Bz4/Exv6sKddw67wTsHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351134; c=relaxed/simple;
	bh=4KcbXiAk6KU/vgJDDoU5l9DZUfzMiDCuLPIQqZu6bm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYUe7cjUWfwDtHC60QgSbUBNaqfhcBeK9E3Ok/Q6FGKmxjlSQ3jyZ1UMeHJom/RxRmk3B0sP+w1SnorFPvgoVw/Dlo4UxeMLukyx5f3YUeG2ubPx4LM2yovfJONeU0X/bG4PnugmwV1WJToIDdPyUkc/Ml98ZNxplUAPNaD8vy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw+McJPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3A7C4CEF8;
	Thu, 24 Jul 2025 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351134;
	bh=4KcbXiAk6KU/vgJDDoU5l9DZUfzMiDCuLPIQqZu6bm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lw+McJPC8yKTl5Q4n+FKt+drPNo9Hjojl9UiOHdx9f8H/TuTXRZZaBVN+JZFVCXzn
	 odol8RKPHqCd8aoeoltXS5ZK4B+C/dI4Zecpg1i2DU/bhrY7C0Fkw+3WZClu6n+Wpa
	 WUmAKhZ4ZKfKxNRYcZnvlY4wYpEI5QQG01WoLlwf21YdMcHlVz9oRXqY6ecnTU0bL/
	 a16jTfBWbk4R+o+C/YZ009IW2Y9uFJfPqRJpoTNF6WoGlXNlciLiGwoS58PvvedrB5
	 GcCPt+FNVM0SYMHTE0yhcO0aNFs9hBeHkT8O4K8XevRd8Oo9Dc/0xD2qM9EBUFQQQZ
	 NVCkaVHZqAc7w==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c09f8369cso374897a34.3;
        Thu, 24 Jul 2025 02:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXhquWq5n5v01uJHjS+OJs29T96jJwQKHXzgn4mH5rj/EmtxH1jEPHWhEzJNhiq28O64RzEDfQlXpz@vger.kernel.org, AJvYcCV/hzWutxg4jyoO9AKvx1hB6NYElhXbh78paBBKpblxv+7ZSN1+vUChEChKLisIwOvijLyCZ8j60M+Z/z0=@vger.kernel.org, AJvYcCVWauBh6KXmaHiRQgbSNK0+qHjeiEEG49LAQJlj4wQpp5x3nw4giy5WyX5H6b9njYJL6uyQLJqF/6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW4JbXLLazDnJA4gHZJoih24uv0P4qAqY8nzb/o9HNcTKmDmzk
	6v0G/wE5gDE+YI61g+qQykALP30ohZdj/EOzg1WYr9/eqc0WkX02KbQ3zEPPNCnz5KC7c2cRrCY
	K0eWU/hwLCGJTKuYV0NgGT6dYMe0szKc=
X-Google-Smtp-Source: AGHT+IEvVUcaL09saG7JvMSWU2BvT8HuFgwXOot+6fLdqKzHF4Ko/+EjvNeckIwhnzGvMOUmxiZcTHwJ7vlG6jxShwg=
X-Received: by 2002:a4a:ec44:0:b0:615:a6d2:348a with SMTP id
 006d021491bc7-6187d959488mr3918147eaf.6.1753351133238; Thu, 24 Jul 2025
 02:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
 <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
 <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com> <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
In-Reply-To: <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 11:58:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hDEX_ZMiAZU-PwriCpURiw04f=JLAVwP9UJ54wv3HBEg@mail.gmail.com>
X-Gm-Features: Ac12FXzHRJ85hgVv_l3XWTJ-C4BbF4wouOGVrAAO-azI8wwa5-WFrcSxuTPgTiA
Message-ID: <CAJZ5v0hDEX_ZMiAZU-PwriCpURiw04f=JLAVwP9UJ54wv3HBEg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
To: David Box <david.e.box@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:27=E2=80=AFPM David Box <david.e.box@linux.intel=
.com> wrote:
>
> On Wed, Jul 23, 2025 at 01:54:41PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 21, 2025 at 10:24=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > >
> > > On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are=
 not
> > > > visible to firmware and do not receive BIOS-provided default ASPM a=
nd CLKPM
> > > > configuration. As a result, devices behind such domains operate wit=
hout
> > > > proper power management, regardless of platform intent.
> > > >
> > > > To address this, allow controller drivers to supply an override for=
 the
> > > > default link state by setting aspm_dflt_link_state for their associ=
ated
> > > > pci_host_bridge. During link initialization, if this field is non-z=
ero,
> > > > ASPM and CLKPM defaults are derived from its value instead of being=
 taken
> > > > from BIOS.
> > > >
> > > > This mechanism enables drivers like VMD to achieve platform-aligned=
 power
> > > > savings by statically defining the expected link configuration at
> > > > enumeration time, without relying on runtime calls such as
> > > > pci_enable_link_state(), which are ineffective when ASPM is disable=
d
> > > > globally.
> > > >
> > > > This approach avoids per-controller hacks in ASPM core logic and pr=
ovides a
> > > > general mechanism for domains that require explicit control over li=
nk power
> > > > state defaults.
> > > >
> > > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d9=
95611cef@panix.com
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > ---
> > > >
> > > > Changes from RFC:
> > > >
> > > >   -- Rename field to aspm_dflt_link_state since it stores
> > > >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> > > >   -- Move the field to struct pci_host_bridge since it's being appl=
ied to
> > > >      the entire host bridge per Mani's suggestion.
> > > >   -- During testing noticed that clkpm remained disabled and this w=
as
> > > >      also handled by the formerly used pci_enable_link_state(). Add=
 a
> > > >      check in pcie_clkpm_cap_init() as well to enable clkpm during =
init.
> > > >
> > > >  drivers/pci/controller/vmd.c | 12 +++++++++---
> > > >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> > > >  include/linux/pci.h          |  4 ++++
> > > >  3 files changed, 24 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/=
vmd.c
> > > > index 8df064b62a2f..6f0de95c87fd 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct p=
ci_host_bridge *root_bridge,
> > > >  }
> > > >
> > > >  /*
> > > > - * Enable ASPM and LTR settings on devices that aren't configured =
by BIOS.
> > > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > > >   */
> > > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdat=
a)
> > > >  {
> > > > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *=
pdev, void *userdata)
> > > >        * PCIe r6.0, sec 5.5.4.
> > > >        */
> > > >       pci_set_power_state_locked(pdev, PCI_D0);
> > >
> > > This call becomes useless now.
>
> Missed this. I'll remove it.
>
> > >
> > > > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > > >       return 0;
> > > >  }
> > > >
> > > > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vm=
d, unsigned long features)
> > > >       resource_size_t membar2_offset =3D 0x2000;
> > > >       struct pci_bus *child;
> > > >       struct pci_dev *dev;
> > > > +     struct pci_host_bridge *vmd_host_bridge;
> > > >       int ret;
> > > >
> > > >       /*
> > > > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *v=
md, unsigned long features)
> > > >               return -ENODEV;
> > > >       }
> > > >
> > > > +     vmd_host_bridge =3D to_pci_host_bridge(vmd->bus->bridge);
> > > > +
> > > > +#ifdef CONFIG_PCIEASPM
> > > > +     vmd_host_bridge->aspm_dflt_link_state =3D PCIE_LINK_STATE_ALL=
;
> > > > +#endif
> > >
> > > I think it is better to provide an API that accepts the link state. W=
e can
> > > provide a stub if CONFIG_PCIEASPM is not selected. This will avoid th=
e ifdef
> > > clutter in the callers. Like:
> > >
> > > void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
> > >                                 unsigned int state)
> > > {
> > > #ifdef CONFIG_PCIEASPM
> > >          host_bridge->aspm_default_link_state =3D state;
> > > #endif
> > > }
> > >
> > > Or you can stub the entire function to align with other ASPM APIs.
> > >
> > > One more thought: Since this API is only going to be called by the ho=
st bridge
> > > drivers, we can place it in drivers/pci/controller/pci-host-common.c =
and name it
> > > as pci_host_common_set_default_link_state().
>
> This would require VMD to select PCI_HOST_COMMON just to set one field in=
 a
> common struct. Seems heavy-handed. Thoughts? Also, with this and dropping=
 the D0
> call, I'll split the VMD cleanup into a separate patch again.

So maybe define a __weak pci_host_set_default_pcie_link_state() doing
nothing in the ASPM core and let VMD override it with its own
implementation?

> >
> > I agree with the above except for the new function name.  I'd call it
> > pci_host_set_default_pcie_link_state()
>
> Sounds good.
>
> >
> > > > +
> > > >       vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus=
),
> > > > -                                to_pci_host_bridge(vmd->bus->bridg=
e));
> > > > +                                vmd_host_bridge);
> > > >
> > > >       vmd_attach_resources(vmd);
> > > >       if (vmd->irq_domain)
> > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > index 29fcb0689a91..6f5b34b172f9 100644
> > > > --- a/drivers/pci/pcie/aspm.c
> > > > +++ b/drivers/pci/pcie/aspm.c
> > > > @@ -380,6 +380,7 @@ static void pcie_clkpm_cap_init(struct pcie_lin=
k_state *link, int blacklist)
> > > >       u16 reg16;
> > > >       struct pci_dev *child;
> > > >       struct pci_bus *linkbus =3D link->pdev->subordinate;
> > > > +     struct pci_host_bridge *host =3D pci_find_host_bridge(link->p=
dev->bus);
> > > >
> > > >       /* All functions should have the same cap and state, take the=
 worst */
> > > >       list_for_each_entry(child, &linkbus->devices, bus_list) {
> > > > @@ -394,7 +395,10 @@ static void pcie_clkpm_cap_init(struct pcie_li=
nk_state *link, int blacklist)
> > > >                       enabled =3D 0;
> > > >       }
> > > >       link->clkpm_enabled =3D enabled;
> > > > -     link->clkpm_default =3D enabled;
> > > > +     if (host && host->aspm_dflt_link_state & PCIE_LINK_STATE_CLKP=
M)
> > > > +             link->clkpm_default =3D 1;
> > > > +     else
> > > > +             link->clkpm_default =3D enabled;
> > > >       link->clkpm_capable =3D capable;
> > > >       link->clkpm_disable =3D blacklist ? 1 : 0;
> > > >  }
> > > > @@ -794,6 +798,7 @@ static void pcie_aspm_cap_init(struct pcie_link=
_state *link, int blacklist)
> > > >       u32 parent_lnkcap, child_lnkcap;
> > > >       u16 parent_lnkctl, child_lnkctl;
> > > >       struct pci_bus *linkbus =3D parent->subordinate;
> > > > +     struct pci_host_bridge *host;
> > > >
> > > >       if (blacklist) {
> > > >               /* Set enabled/disable so that we will disable ASPM l=
ater */
> > > > @@ -866,7 +871,11 @@ static void pcie_aspm_cap_init(struct pcie_lin=
k_state *link, int blacklist)
> > > >       }
> > > >
> > > >       /* Save default state */
> > > > -     link->aspm_default =3D link->aspm_enabled;
> > > > +     host =3D pci_find_host_bridge(parent->bus);
> > >
> > > You can initialize 'host' while defining it.
> > >
> > > Also, please add a comment on why we are doing this. The inline comme=
nt for the
> > > member is not elaborate enough:
> > >
> > >         /*
> > >          * Use the default link state provided by the Host Bridge dri=
ver if
> > >          * available. If the BIOS is not able to provide default ASPM=
 link
> > >          * state for some reason, the Host Bridge driver could do.
> > >          */
> > >
> > > > +     if (host && host->aspm_dflt_link_state)
> > > > +             link->aspm_default =3D host->aspm_dflt_link_state;
> > > > +     else
> > > > +             link->aspm_default =3D link->aspm_enabled;
> >
> > Or
> >
> > link->aspm_default =3D pci_host_get_default_pcie_link_state(parent);
> > if (link->aspm_default)
> >         link->aspm_default =3D link->aspm_enabled;
> >
> > and make pci_host_get_default_pcie_link_state() return 0 on failures.
> >
> > Then you can put all of the relevant information into the
> > pci_host_get_default_pcie_link_state() kerneldoc comment.
>
> Sure. I'll add get/set APIs (plus the !) and put the comment there.

Sounds good!

> > > >
> > > >       /* Setup initial capable state. Will be updated later */
> > > >       link->aspm_capable =3D link->aspm_support;
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index 05e68f35f392..930028bf52b4 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -614,6 +614,10 @@ struct pci_host_bridge {
> > > >       unsigned int    size_windows:1;         /* Enable root bus si=
zing */
> > > >       unsigned int    msi_domain:1;           /* Bridge wants MSI d=
omain */
> > > >
> > > > +#ifdef CONFIG_PCIEASPM
> > > > +     unsigned int    aspm_dflt_link_state;   /* Controller provide=
d link state */
> > >
> > >         /* Controller provided default link state */
> > >
> > >
> > > Nit: Please expand 'default' as 'dflt' is not a commonly used acronym=
 for
> > > 'default'.
> >
> > I agree.
>
> Will do.

Thanks!

