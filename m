Return-Path: <linux-pci+bounces-32795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8DB0F1AD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991D616C869
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC6D2E1753;
	Wed, 23 Jul 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs2FNDo/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F22DEA8E;
	Wed, 23 Jul 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271695; cv=none; b=TtXV/D0J7kUi8B8BMizAGsMx/g+Lp5FBsG08C5rgRQsQWET9ujQc+vrB/71ZMfeL221TvGhkhPNQSxuoRteNslQAcupTG1CjR4ii65ete1nzJ4yDw9ukHmC6UptrW6ZS2gUGWzxtSVMqCShwPG4GrZ30PpO0a4PvwcD9t2M2WsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271695; c=relaxed/simple;
	bh=gU91kJImrNKzTDuVp5MR6n+TP8gZtaB2XBfvrSi6okU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxwgYvCAuO8AKHlzDpMxwS8oK6RQ12i2Cw+8mzg8oDGirVINrMrf3YwoNo8XQx9i5AYBA11EIBqQQ9z+IHYklrNv5pS/uGQnX+eEMLzrksbQAII7Qc+3I0l66+qSNu4tCsetV/AbTlLoYJKOopxp5zLyknC8Z6usQOOhB/YpWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs2FNDo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B297C4CEF5;
	Wed, 23 Jul 2025 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753271694;
	bh=gU91kJImrNKzTDuVp5MR6n+TP8gZtaB2XBfvrSi6okU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bs2FNDo/O7C6B5PqDSegVSeNggapA2aO/0FgQ/5M/D6zrwPo8ZVT5XM9bnY2dWvn5
	 ySEbJK1OiKUWXxTpZ6LuyLoNZjukwGUBJhN0slrS31K4W9mzgDSXoFMeSKayPYejXv
	 IOBavxHYZfwCWeDsxCIpszLas32+TCRL2cwUjC6N6RRTSE5IpYoe4/aVn6lhOeAUEN
	 GT0VF5YRliazMoFvJK2GORw+5yTTFPMnJniVYRFDvFIV30B3VcQEgpgML+QgYudJ6e
	 HL9+2sqlVi0qfRXaRAZ2abDzwtuq5SqeBLkzKAnznwFrlpZ3rJLTrF1sH/NzAaf50n
	 nbCsoMXTcqE+A==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-615950642d9so3697586eaf.1;
        Wed, 23 Jul 2025 04:54:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMU52HWenEnNp8o71/nwVLmaCgMgBJ8LKxzc7IdyXVCF2zORVeHEwOwfHOK6B6axZHtpGWBSZnRCF281A=@vger.kernel.org, AJvYcCWoMtMC7UCOKy3VvQ6vySMZ39j95DkZTYvwh4fqY9TvfT/Vwtx47IV2cN02dbIc/O0PE5dQFG6TWV0=@vger.kernel.org, AJvYcCXWTr8OgGiLj+QY8phHCwLRIgf9nKwgTnlg60gGbQxYsDyU7TKxGWcsmKPviYaQYvCvuk4QwsfABBB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvdh5QrbUEqpJJkVeU5HDpnP3Pen6t9fLTNOVufjrE3VFsy9Px
	csRQo6hCvhnRbqqXAHO6siqfsUnLriepYSV709HJTAmnrh+UusiXlTCRXLb6w1GR49xyam/12r8
	PBdh5vonJ2DtL8fIG7/TZRi2woq/d9P4=
X-Google-Smtp-Source: AGHT+IH0Hs59GC0gBEPiCz/CF/v19O8hUkE89gtG7/LzNvKbK/c2XqE9rFvLoDl3K1LZB80Jn0n09xKQZPR4fzHio/I=
X-Received: by 2002:a05:6820:199b:b0:609:dd17:795 with SMTP id
 006d021491bc7-6187d8d3119mr1667142eaf.6.1753271693723; Wed, 23 Jul 2025
 04:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720190140.2639200-1-david.e.box@linux.intel.com> <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
In-Reply-To: <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Jul 2025 13:54:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
X-Gm-Features: Ac12FXzMW7Cto7NTqU5RbT5fVbinucbXZbD7oQz3kciucsgpuE-fgaBsanQ_qOU
Message-ID: <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
To: Manivannan Sadhasivam <mani@kernel.org>, "David E. Box" <david.e.box@linux.intel.com>
Cc: bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com, 
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 10:24=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > visible to firmware and do not receive BIOS-provided default ASPM and C=
LKPM
> > configuration. As a result, devices behind such domains operate without
> > proper power management, regardless of platform intent.
> >
> > To address this, allow controller drivers to supply an override for the
> > default link state by setting aspm_dflt_link_state for their associated
> > pci_host_bridge. During link initialization, if this field is non-zero,
> > ASPM and CLKPM defaults are derived from its value instead of being tak=
en
> > from BIOS.
> >
> > This mechanism enables drivers like VMD to achieve platform-aligned pow=
er
> > savings by statically defining the expected link configuration at
> > enumeration time, without relying on runtime calls such as
> > pci_enable_link_state(), which are ineffective when ASPM is disabled
> > globally.
> >
> > This approach avoids per-controller hacks in ASPM core logic and provid=
es a
> > general mechanism for domains that require explicit control over link p=
ower
> > state defaults.
> >
> > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d99561=
1cef@panix.com
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >
> > Changes from RFC:
> >
> >   -- Rename field to aspm_dflt_link_state since it stores
> >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> >   -- Move the field to struct pci_host_bridge since it's being applied =
to
> >      the entire host bridge per Mani's suggestion.
> >   -- During testing noticed that clkpm remained disabled and this was
> >      also handled by the formerly used pci_enable_link_state(). Add a
> >      check in pcie_clkpm_cap_init() as well to enable clkpm during init=
.
> >
> >  drivers/pci/controller/vmd.c | 12 +++++++++---
> >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> >  include/linux/pci.h          |  4 ++++
> >  3 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.=
c
> > index 8df064b62a2f..6f0de95c87fd 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_h=
ost_bridge *root_bridge,
> >  }
> >
> >  /*
> > - * Enable ASPM and LTR settings on devices that aren't configured by B=
IOS.
> > + * Enable LTR settings on devices that aren't configured by BIOS.
> >   */
> >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> >  {
> > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev=
, void *userdata)
> >        * PCIe r6.0, sec 5.5.4.
> >        */
> >       pci_set_power_state_locked(pdev, PCI_D0);
>
> This call becomes useless now.
>
> > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> >       return 0;
> >  }
> >
> > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
> >       resource_size_t membar2_offset =3D 0x2000;
> >       struct pci_bus *child;
> >       struct pci_dev *dev;
> > +     struct pci_host_bridge *vmd_host_bridge;
> >       int ret;
> >
> >       /*
> > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, =
unsigned long features)
> >               return -ENODEV;
> >       }
> >
> > +     vmd_host_bridge =3D to_pci_host_bridge(vmd->bus->bridge);
> > +
> > +#ifdef CONFIG_PCIEASPM
> > +     vmd_host_bridge->aspm_dflt_link_state =3D PCIE_LINK_STATE_ALL;
> > +#endif
>
> I think it is better to provide an API that accepts the link state. We ca=
n
> provide a stub if CONFIG_PCIEASPM is not selected. This will avoid the if=
def
> clutter in the callers. Like:
>
> void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
>                                 unsigned int state)
> {
> #ifdef CONFIG_PCIEASPM
>          host_bridge->aspm_default_link_state =3D state;
> #endif
> }
>
> Or you can stub the entire function to align with other ASPM APIs.
>
> One more thought: Since this API is only going to be called by the host b=
ridge
> drivers, we can place it in drivers/pci/controller/pci-host-common.c and =
name it
> as pci_host_common_set_default_link_state().

I agree with the above except for the new function name.  I'd call it
pci_host_set_default_pcie_link_state()

> > +
> >       vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > -                                to_pci_host_bridge(vmd->bus->bridge));
> > +                                vmd_host_bridge);
> >
> >       vmd_attach_resources(vmd);
> >       if (vmd->irq_domain)
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 29fcb0689a91..6f5b34b172f9 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -380,6 +380,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_st=
ate *link, int blacklist)
> >       u16 reg16;
> >       struct pci_dev *child;
> >       struct pci_bus *linkbus =3D link->pdev->subordinate;
> > +     struct pci_host_bridge *host =3D pci_find_host_bridge(link->pdev-=
>bus);
> >
> >       /* All functions should have the same cap and state, take the wor=
st */
> >       list_for_each_entry(child, &linkbus->devices, bus_list) {
> > @@ -394,7 +395,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_s=
tate *link, int blacklist)
> >                       enabled =3D 0;
> >       }
> >       link->clkpm_enabled =3D enabled;
> > -     link->clkpm_default =3D enabled;
> > +     if (host && host->aspm_dflt_link_state & PCIE_LINK_STATE_CLKPM)
> > +             link->clkpm_default =3D 1;
> > +     else
> > +             link->clkpm_default =3D enabled;
> >       link->clkpm_capable =3D capable;
> >       link->clkpm_disable =3D blacklist ? 1 : 0;
> >  }
> > @@ -794,6 +798,7 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
> >       u32 parent_lnkcap, child_lnkcap;
> >       u16 parent_lnkctl, child_lnkctl;
> >       struct pci_bus *linkbus =3D parent->subordinate;
> > +     struct pci_host_bridge *host;
> >
> >       if (blacklist) {
> >               /* Set enabled/disable so that we will disable ASPM later=
 */
> > @@ -866,7 +871,11 @@ static void pcie_aspm_cap_init(struct pcie_link_st=
ate *link, int blacklist)
> >       }
> >
> >       /* Save default state */
> > -     link->aspm_default =3D link->aspm_enabled;
> > +     host =3D pci_find_host_bridge(parent->bus);
>
> You can initialize 'host' while defining it.
>
> Also, please add a comment on why we are doing this. The inline comment f=
or the
> member is not elaborate enough:
>
>         /*
>          * Use the default link state provided by the Host Bridge driver =
if
>          * available. If the BIOS is not able to provide default ASPM lin=
k
>          * state for some reason, the Host Bridge driver could do.
>          */
>
> > +     if (host && host->aspm_dflt_link_state)
> > +             link->aspm_default =3D host->aspm_dflt_link_state;
> > +     else
> > +             link->aspm_default =3D link->aspm_enabled;

Or

link->aspm_default =3D pci_host_get_default_pcie_link_state(parent);
if (link->aspm_default)
        link->aspm_default =3D link->aspm_enabled;

and make pci_host_get_default_pcie_link_state() return 0 on failures.

Then you can put all of the relevant information into the
pci_host_get_default_pcie_link_state() kerneldoc comment.

> >
> >       /* Setup initial capable state. Will be updated later */
> >       link->aspm_capable =3D link->aspm_support;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 05e68f35f392..930028bf52b4 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -614,6 +614,10 @@ struct pci_host_bridge {
> >       unsigned int    size_windows:1;         /* Enable root bus sizing=
 */
> >       unsigned int    msi_domain:1;           /* Bridge wants MSI domai=
n */
> >
> > +#ifdef CONFIG_PCIEASPM
> > +     unsigned int    aspm_dflt_link_state;   /* Controller provided li=
nk state */
>
>         /* Controller provided default link state */
>
>
> Nit: Please expand 'default' as 'dflt' is not a commonly used acronym for
> 'default'.

I agree.

