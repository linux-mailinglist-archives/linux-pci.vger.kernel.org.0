Return-Path: <linux-pci+bounces-41185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ECBC5A0C2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0A184E3183
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1572F6186;
	Thu, 13 Nov 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFIgKq5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E312D2494
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067835; cv=none; b=dKHuZ5Zr7YVVVDi6s8oqjF7eIkrNimziUAvt0BnhTZSY87nsicGT2I8/aUKZxwmcxv4JEmEkorgicM+oFO2bH1jU96dG/h4N0HZAZClLrcm3svY4WbW7WxpiwTEnUPx9zmpmqeHJoSwmta8wV/fqnjBSXuETt1rNO4DFqJbYgJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067835; c=relaxed/simple;
	bh=l1kwHOu+FvSimzRnA3MbT/c6yK4JOJDpeQC1zywnzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRmqwUWQ7A9DVs7h8K08YuimZ0XcGRO8VyBnd+TY8j97mpQWlnoodhO2z40Mcb0EQPx4F45WlXf0Tg5D4w3dVsyb0mharl1YFiaGIqWE9eYZsGw+BakZqOAHXaXobnbQT/SLfoZOsqEVBYZlnwjSs3pfAipucEJwzCk0raSLTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFIgKq5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27841C4CEFB
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763067835;
	bh=l1kwHOu+FvSimzRnA3MbT/c6yK4JOJDpeQC1zywnzFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oFIgKq5vymoxcBHwDnOkz9UxZaZ+S4lHXHQ5XgePNUsWyCFn00/N9GzHNClGG+QjD
	 sPvollPnnbHp30flzSx6ckugamM0neSTasywkW23Vis+BwO7Kkv6KI2OAu4TTug48S
	 eQtAXp9bkJsnb/Crffnpfg2KsAxDgpAb41OkGb0xj3sUM6DhzHNJuRE7W3Y0d+T6fP
	 hdvP38UZ5dRJmw8IIpSb7XSOqYpiWW+RK+zwU7Xo+UcFczL53ymu2wZc4Qv40V53+P
	 9hYi5mX5AbCmfcjzsKbIguNYEl2INzAFsjrXUSn9NsXvOetX32JT3z4l/+ErzcxTcI
	 h8qSkQJcI9yrQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-44fe903c1d6so211176b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 13:03:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVP2AV8TbspAjtTdeytjVNJv+dMTgQSalj1eW3dxsL8vPl9owauITrBjsB170YTn9h7kIHdgeyz880=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcOiQzO7fxjUjTxjclI6nWR4yyl4myvDObJYkjKIdofArV9tM
	Y+dVLG7U6lUjuSX50/ojgi0C/E1jRdw+n/l1+eQtI7ONsMFDwooWPwhXi+K0ReFv3N8kpxSvhWa
	TX90FnvHqMhaNhg6n2jFr1qudyrRc5Ss=
X-Google-Smtp-Source: AGHT+IE0fbHk6As1rDorm+7a0crtd6lfOOXOPtfAdhgHmLrMuSQqUrE+FVVqxktvMt7FcyX7LzaZaDhmTgVQsuOgNNY=
X-Received: by 2002:a05:6808:220f:b0:43f:7dee:46b1 with SMTP id
 5614622812f47-4509749f401mr321513b6e.29.1763067834339; Thu, 13 Nov 2025
 13:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760274044.git.lukas@wunner.de> <070a03221dbec25f478d36d7bc76e0da81985c5d.1760274044.git.lukas@wunner.de>
 <CAJZ5v0hE31RqZ19oN_11cKYnLY_CP0KccTGwa9ViT4UmR+6rfg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hE31RqZ19oN_11cKYnLY_CP0KccTGwa9ViT4UmR+6rfg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 22:03:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0inkPVO-H5df1ZPCax89g6rtGOYPHPdbpZ_wXS1KHN9nA@mail.gmail.com>
X-Gm-Features: AWmQ_bmG8mA3nZdUGitr0pr_4t3kvFmvM8MIydo8M7Uc876xYarDE7ZeTUZ4WGs
Message-ID: <CAJZ5v0inkPVO-H5df1ZPCax89g6rtGOYPHPdbpZ_wXS1KHN9nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Ensure error recoverability at all times
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, 
	Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com, 
	Dave Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sun, Oct 12, 2025 at 3:30=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wr=
ote:
> >
> > When the PCI core gained power management support in 2002, it introduce=
d
> > pci_save_state() and pci_restore_state() helpers to restore Config Spac=
e
> > after a D3hot or D3cold transition, which implies a Soft or Fundamental
> > Reset (PCIe r7.0 sec 5.8):
> >
> >   https://git.kernel.org/tglx/history/c/a5287abe398b
> >
> > In 2006, EEH and AER were introduced to recover from errors by performi=
ng
> > a reset.  Because errors can occur at any time, drivers began calling
> > pci_save_state() on probe to ensure recoverability.
> >
> > In 2009, recoverability was foiled by commit c82f63e411f1 ("PCI: check
> > saved state before restore"):  It amended pci_restore_state() to bail o=
ut
> > if the "state_saved" flag has been cleared.  The flag is cleared by
> > pci_restore_state() itself, hence a saved state is now allowed to be
> > restored only once and is then invalidated.  That doesn't seem to make
> > sense because the saved state should be good enough to be reused.
> >
> > Soon after, drivers began to work around this behavior by calling
> > pci_save_state() immediately after pci_restore_state(), see e.g. commit
> > b94f2d775a71 ("igb: call pci_save_state after pci_restore_state").
> > Hilariously, two drivers even set the "saved_state" flag to true before
> > invoking pci_restore_state(), see ipr_reset_restore_cfg_space() and
> > e1000_io_slot_reset().
> >
> > Despite these workarounds, recoverability at all times is not guarantee=
d:
> > E.g. when a PCIe port goes through a runtime suspend and resume cycle,
> > the "saved_state" flag is cleared by:
> >
> >   pci_pm_runtime_resume()
> >     pci_pm_default_resume_early()
> >       pci_restore_state()
> >
> > ... and hence on a subsequent AER event, the port's Config Space cannot=
 be
> > restored.  Riana reports a recovery failure of a GPU-integrated PCIe
> > switch and has root-caused it to the behavior of pci_restore_state().
> > Another workaround would be necessary, namely calling pci_save_state() =
in
> > pcie_port_device_runtime_resume().
> >
> > The motivation of commit c82f63e411f1 was to prevent restoring state if
> > pci_save_state() hasn't been called before.  But that can be achieved b=
y
> > saving state already on device addition, after Config Space has been
> > initialized.  A desirable side effect is that devices become recoverabl=
e
> > even if no driver gets bound.  This renders the commit unnecessary, so
> > revert it.
> >
> > Reported-by: Riana Tauro <riana.tauro@intel.com> # off-list
> > Tested-by: Riana Tauro <riana.tauro@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> > Proof that removing the check in pci_restore_state() makes no
> > difference for the PCI core:
> >
> > * The only relevant invocations of pci_restore_state() are in
> >   drivers/pci/pci-driver.c
> > * One invocation is in pci_restore_standard_config(), which is
> >   always called conditionally on "if (pci_dev->state_saved)".
> >   So the check at the beginning of pci_restore_state() which
> >   this patch removes is an unnecessary duplication.
> > * Another invocation is in pci_pm_default_resume_early(), which
> >   is called from pci_pm_resume_noirq(), pci_pm_restore_noirq()
> >   and pci_pm_runtime_resume().  Those functions are only called
> >   after prior calls to pci_pm_suspend_noirq(), pci_pm_freeze_noirq(),
> >   and pci_pm_runtime_suspend(), respectively.  And all of them
> >   call pci_save_state().  So the "if (!dev->state_saved)" check
> >   in pci_restore_state() never evaluates to true.
> > * A third invocation is in pci_pm_thaw_noirq().  It is only called
> >   after a prior call to pci_pm_freeze_noirq(), which invokes
> >   pci_save_state().  So likewise the "if (!dev->state_saved)" check
> >   in pci_restore_state() never evaluates to true.
> >
> >  drivers/pci/bus.c   | 7 +++++++
> >  drivers/pci/pci.c   | 3 ---
> >  drivers/pci/probe.c | 2 --
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index f26aec6..4318568 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -358,6 +358,13 @@ void pci_bus_add_device(struct pci_dev *dev)
> >         pci_bridge_d3_update(dev);
> >
> >         /*
> > +        * Save config space for error recoverability.  Clear state_sav=
ed
> > +        * to detect whether drivers invoked pci_save_state() on suspen=
d.
> > +        */
> > +       pci_save_state(dev);
> > +       dev->state_saved =3D false;
> > +
> > +       /*
> >          * If the PCI device is associated with a pwrctrl device with a
> >          * power supply, create a device link between the PCI device an=
d
> >          * pwrctrl device.  This ensures that pwrctrl drivers are probe=
d
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b14dd06..2f0da5d 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1855,9 +1855,6 @@ static void pci_restore_rebar_state(struct pci_de=
v *pdev)
> >   */
> >  void pci_restore_state(struct pci_dev *dev)
> >  {
> > -       if (!dev->state_saved)
> > -               return;
> > -
>
> So after this change, is there any mechanism to clear state_saved
> after a suspend-resume cycle so that the next cycle is not confused by
> seeing it set?

Never mind, this hasn't changed.

So I agree with Bjorn that it would be good to expand the new comment
in pci_bus_add_device() because it doesn't really explain much in its
current form.  Or maybe even split it to say "Save config space for
error recoverability" before pci_save_state(dev) and then explain why
state_saved is cleared after it?

Apart from this and modulo possible changelog adjustments

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

