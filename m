Return-Path: <linux-pci+bounces-32898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4FBB11175
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 21:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92871CE36EE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEBE274665;
	Thu, 24 Jul 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el2lrjsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61F1EF39F;
	Thu, 24 Jul 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384378; cv=none; b=GAbjgOV/n1bJC7mgdDOQFpwjmV7mSA7eqIB+fwRxc7WsK2UB6VohKkhiuyUKxRDkoUyTGg6N63T6dLCXxg+fysvRamivc405W+PjQaX0+oBZmYdZoCXQdo7QkzmbBjP7yghKF2iVAAR1c0Ujtm0KSOAq+2aotuam4XeS2Zx+r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384378; c=relaxed/simple;
	bh=vJUICzDD4InKrsoQB68IGsYa0ViATbp7jHPQDQJKJro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfokurdYEjyHonrIGJK5iFY1EoQL0OKrqwS8UksZBqVKsCj1GIkLh4uf25mXK8YYJi7pw8MZ4lHHwUAFQBjItk09MzbUHLw36jfBZd2Fik+LGPPDN92bfKtWunqIkCeXHBoS++2xnmd88JrbK956V0CNdgs+qj3qz3O8faehNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el2lrjsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA53AC4AF09;
	Thu, 24 Jul 2025 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753384377;
	bh=vJUICzDD4InKrsoQB68IGsYa0ViATbp7jHPQDQJKJro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=el2lrjsvqhzZAFl//OlR33T5TS45RCmzC8FuesQsM5qxvLYYUH90Y89B/4nmzH8bd
	 b7AWBPS1fOgOwagOlvgshlC/gra6eQM7/sSD4WE1ED1bc3v3bI/GMdK+xDJk3uSZqa
	 zKJ1iJLzIo/jz3CnLVRtzXE/VJWCHZ9Zyz5mpOpquk5DgQh1/kwtDDT0+3F9qAIYbp
	 dhwRzGnAUEauIrALUafw0nYqxDCwk7fiAUXAk85WB+IwZHb+8EAHMqqcxO+O7jo/yt
	 2ITzSn+DKJOssJpDo1fGT7dhT7026KyMUJIY83ZCzemYlXxWb+M6KyfpPNDm13GsfW
	 LdNJ5QB6OKHRw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-615da180061so707494eaf.2;
        Thu, 24 Jul 2025 12:12:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGNkZWM3//Fb0lA4itMtTFne0F+pgi30/O7d2P2JpH3/ZUSdQKQbHn4hfnW+qTANZhKnMcgnii4llihds=@vger.kernel.org, AJvYcCVu+pTLm8avNE0Yu2EXVM/Fy0Wl9DB/aJHkideQFsbKY5TEJ7zjDxhCKC0LfFTRQvTUgVRV/M74jgM=@vger.kernel.org, AJvYcCXFK17hfMZhuMX9noOoLDfw1+KvZKfKat5Xih5AT3SupSYN5Vwf/wjZkENpu9xDYT0q/q1szQLZJbYy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wug23ZKFcXOPK73hlbk8Mo1aYGpd6JeVE5vj5UsVGYYkuZJB
	yJXg5y4xS1vc7yCOw/6J1PceZuLyR7iewS0F4bKa6/+BKbleBHcbSZkk6C9KmpzZyF9wqDfC7mp
	QRR4wsezBQUVsXJuX7Oe6TRgTDfszTHc=
X-Google-Smtp-Source: AGHT+IFbB46Hjxj4k6TmuR4peJJBucCkWQW1c8okqZZI2QqIZpTGocMp9N0FBCmeOFIfDNehhDb7L4EdiflXxYavJmE=
X-Received: by 2002:a05:6820:1356:b0:615:fc41:b0b3 with SMTP id
 006d021491bc7-6187d8ed440mr6856151eaf.7.1753384376975; Thu, 24 Jul 2025
 12:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
 <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
 <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
 <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
 <CAJZ5v0hDEX_ZMiAZU-PwriCpURiw04f=JLAVwP9UJ54wv3HBEg@mail.gmail.com>
 <scajymgengcxt6e4ekl53hteig4mgu34wwif2r737xvtcdghg4@ej4qn2rbcxzg> <fiuyebro52meyyri2qamj3h2eijjebl3uhgnalo7wwjholwml7@rgpmcegwjxid>
In-Reply-To: <fiuyebro52meyyri2qamj3h2eijjebl3uhgnalo7wwjholwml7@rgpmcegwjxid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 21:12:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLJwOe-__7DpEEOcZpxan12VOUhucv+WxkYuh-Q+YOGQ@mail.gmail.com>
X-Gm-Features: Ac12FXxtROj7PeUT4GLAuydg_OgUJXnKEwptFmCPBLKFJ9bCV_yA-gwfF01KB7I
Message-ID: <CAJZ5v0hLJwOe-__7DpEEOcZpxan12VOUhucv+WxkYuh-Q+YOGQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
To: David Box <david.e.box@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 9:08=E2=80=AFPM David Box <david.e.box@linux.intel.=
com> wrote:
>
> On Thu, Jul 24, 2025 at 10:18:47PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jul 24, 2025 at 11:58:40AM GMT, Rafael J. Wysocki wrote:
> > > On Wed, Jul 23, 2025 at 11:27=E2=80=AFPM David Box <david.e.box@linux=
.intel.com> wrote:
> > > >
> > > > On Wed, Jul 23, 2025 at 01:54:41PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Jul 21, 2025 at 10:24=E2=80=AFAM Manivannan Sadhasivam <m=
ani@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > > > > > > Synthetic PCIe hierarchies, such as those created by Intel VM=
D, are not
> > > > > > > visible to firmware and do not receive BIOS-provided default =
ASPM and CLKPM
> > > > > > > configuration. As a result, devices behind such domains opera=
te without
> > > > > > > proper power management, regardless of platform intent.
> > > > > > >
> > > > > > > To address this, allow controller drivers to supply an overri=
de for the
> > > > > > > default link state by setting aspm_dflt_link_state for their =
associated
> > > > > > > pci_host_bridge. During link initialization, if this field is=
 non-zero,
> > > > > > > ASPM and CLKPM defaults are derived from its value instead of=
 being taken
> > > > > > > from BIOS.
> > > > > > >
> > > > > > > This mechanism enables drivers like VMD to achieve platform-a=
ligned power
> > > > > > > savings by statically defining the expected link configuratio=
n at
> > > > > > > enumeration time, without relying on runtime calls such as
> > > > > > > pci_enable_link_state(), which are ineffective when ASPM is d=
isabled
> > > > > > > globally.
> > > > > > >
> > > > > > > This approach avoids per-controller hacks in ASPM core logic =
and provides a
> > > > > > > general mechanism for domains that require explicit control o=
ver link power
> > > > > > > state defaults.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-221=
2-50d995611cef@panix.com
> > > > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes from RFC:
> > > > > > >
> > > > > > >   -- Rename field to aspm_dflt_link_state since it stores
> > > > > > >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> > > > > > >   -- Move the field to struct pci_host_bridge since it's bein=
g applied to
> > > > > > >      the entire host bridge per Mani's suggestion.
> > > > > > >   -- During testing noticed that clkpm remained disabled and =
this was
> > > > > > >      also handled by the formerly used pci_enable_link_state(=
). Add a
> > > > > > >      check in pcie_clkpm_cap_init() as well to enable clkpm d=
uring init.
> > > > > > >
> > > > > > >  drivers/pci/controller/vmd.c | 12 +++++++++---
> > > > > > >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> > > > > > >  include/linux/pci.h          |  4 ++++
> > > > > > >  3 files changed, 24 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/contr=
oller/vmd.c
> > > > > > > index 8df064b62a2f..6f0de95c87fd 100644
> > > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(st=
ruct pci_host_bridge *root_bridge,
> > > > > > >  }
> > > > > > >
> > > > > > >  /*
> > > > > > > - * Enable ASPM and LTR settings on devices that aren't confi=
gured by BIOS.
> > > > > > > + * Enable LTR settings on devices that aren't configured by =
BIOS.
> > > > > > >   */
> > > > > > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *u=
serdata)
> > > > > > >  {
> > > > > > > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci=
_dev *pdev, void *userdata)
> > > > > > >        * PCIe r6.0, sec 5.5.4.
> > > > > > >        */
> > > > > > >       pci_set_power_state_locked(pdev, PCI_D0);
> > > > > >
> > > > > > This call becomes useless now.
> > > >
> > > > Missed this. I'll remove it.
> > > >
> > > > > >
> > > > > > > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL)=
;
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_d=
ev *vmd, unsigned long features)
> > > > > > >       resource_size_t membar2_offset =3D 0x2000;
> > > > > > >       struct pci_bus *child;
> > > > > > >       struct pci_dev *dev;
> > > > > > > +     struct pci_host_bridge *vmd_host_bridge;
> > > > > > >       int ret;
> > > > > > >
> > > > > > >       /*
> > > > > > > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_=
dev *vmd, unsigned long features)
> > > > > > >               return -ENODEV;
> > > > > > >       }
> > > > > > >
> > > > > > > +     vmd_host_bridge =3D to_pci_host_bridge(vmd->bus->bridge=
);
> > > > > > > +
> > > > > > > +#ifdef CONFIG_PCIEASPM
> > > > > > > +     vmd_host_bridge->aspm_dflt_link_state =3D PCIE_LINK_STA=
TE_ALL;
> > > > > > > +#endif
> > > > > >
> > > > > > I think it is better to provide an API that accepts the link st=
ate. We can
> > > > > > provide a stub if CONFIG_PCIEASPM is not selected. This will av=
oid the ifdef
> > > > > > clutter in the callers. Like:
> > > > > >
> > > > > > void pci_set_default_link_state(struct pci_host_bridge *host_br=
idge,
> > > > > >                                 unsigned int state)
> > > > > > {
> > > > > > #ifdef CONFIG_PCIEASPM
> > > > > >          host_bridge->aspm_default_link_state =3D state;
> > > > > > #endif
> > > > > > }
> > > > > >
> > > > > > Or you can stub the entire function to align with other ASPM AP=
Is.
> > > > > >
> > > > > > One more thought: Since this API is only going to be called by =
the host bridge
> > > > > > drivers, we can place it in drivers/pci/controller/pci-host-com=
mon.c and name it
> > > > > > as pci_host_common_set_default_link_state().
> > > >
> > > > This would require VMD to select PCI_HOST_COMMON just to set one fi=
eld in a
> > > > common struct. Seems heavy-handed. Thoughts? Also, with this and dr=
opping the D0
> > > > call, I'll split the VMD cleanup into a separate patch again.
> > >
> > > So maybe define a __weak pci_host_set_default_pcie_link_state() doing
> > > nothing in the ASPM core and let VMD override it with its own
> > > implementation?
> > >
> >
> > No. There are other controller drivers (like pcie-qcom) going to use th=
is API.
> > So please move it to the pci-host-common library as it should be.
>
> I was going to suggest that it could simply stay in aspm.c.
> pci_enable_link_state_() is there and currently only used by controllers =
as
> well.

This sounds reasonable to me.

