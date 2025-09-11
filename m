Return-Path: <linux-pci+bounces-35913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F3B5342B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15000188F2F6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625986340;
	Thu, 11 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRDIokHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A332ED2D;
	Thu, 11 Sep 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598217; cv=none; b=f4ewu9uEYOs8SU3iwNpW0Hs+LjrIFGLbm53/vH3EjatNvqXTWbh0vDE6M5SeZx4VWcC/Y6utB5Qlsi116l0oAPdtbg34Nxz8neqONbl/Yu7I1H5vlOLDBiIg21NAYV4b7onzEXGDXKDiZ0gluEfOo21Waj0WRPkhFQ1fZDcrkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598217; c=relaxed/simple;
	bh=0GXo4WsPXbb94gtbo4YsNCOo6bkT29Ut19/AJPbQdME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKlhlkAfWqxQMN7yASXMMS+dOBuyjCaCw6dyHZo879m9ELssAYj+wCXeLEgWiJt8e/0sST2Zdt5Xu0tp5Oo86a4TrF8yb161Mt5675k6EnnC2zcOGRXN2bC2+kVezXOzx6H0yWSiG4qIzez/b8IhH4xvYUfLnOYJkh5nHvaj9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRDIokHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA47EC4CEFC;
	Thu, 11 Sep 2025 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757598217;
	bh=0GXo4WsPXbb94gtbo4YsNCOo6bkT29Ut19/AJPbQdME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sRDIokHV+3NXgwH90Z3qR3vXPcPx8SCzRFPduK9JxA5R64wArH2pxjAsKkr6+syON
	 BDXtAWWHZu7fVDQ9HCwFYquvzy4TOA6T/6dnZu+91j4Oko+FOLcNJmFqHIW+Y0wDQU
	 Ip7GmOsTzEIzC3lDJRkP97e7ZQqgjK77qTjCay38ZpPp3K6aZPFe4kuGPyo0QOkKJ8
	 cTW5QwzLNVs6bmInAxr1oJtgIXPMcWQvgOso2ugG3MyjSAYq7pZNMI/Dx8cYemxbPG
	 V0D09r4LtpT9haGes1lSfBeqzylbVB8AE7NsKy+RAj3cAwL8d6jR0tPudKzgwIQYP8
	 0DQzFxQRcEU0Q==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381e2079fso769418a34.0;
        Thu, 11 Sep 2025 06:43:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUa0bN1yco8b7+kApVVF3LRNr22/0l/6FNK0Ynj9j6bt049AuN874U9yHdV9IwPqYeHgDMv8sFYW0FG22k=@vger.kernel.org, AJvYcCUuT/MK8RKJ6JYspFqQGD0J+Nxrt0resH21FnuFEWSSppuBmJYmnQMC+BHMeV+f5/MsoxHSv5PTfmA=@vger.kernel.org, AJvYcCXFK378e3nPkJ989gT3ZZ0Em/2ZN3pXaNdJcmGdHf+dwOCfEz5n9Le8VUL0K6uPgSLmq2jpUUy7qk8Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/HIHHHeLkbBHvNQcykHqDi1fY1gKGvOK4DL/0NZDW8JzQp5u2
	aQ4w/a2WJ2x1J6QcjxODSCtLYZoxj7l1XaFwPr4TMibPvkm8rE8aQVduVuNjRyub4fJxKBo81HC
	rUECWaQ4iWlY+hkBZZ4K2BJwAOcxe3bM=
X-Google-Smtp-Source: AGHT+IE6Ady68fU71PxUHEDevFaxfnLgB7dpVmhBz5UaanlQR3tYIFV8QpjfWjN8l418mkJ0TLtqkyf/qpZL17czUqo=
X-Received: by 2002:a05:6830:6f85:b0:745:a336:7260 with SMTP id
 46e09a7af769-74c66210137mr12873344a34.0.1757598216239; Thu, 11 Sep 2025
 06:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
 <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>
In-Reply-To: <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 15:43:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idqEPUpA0uBb_PAaKe0KNqCt0xLskPThPwtsfh3eCdxg@mail.gmail.com>
X-Gm-Features: Ac12FXw8YYdZ59nK2i-Qn8MLk67KRnR9Lix3xAU-CKM32UvuPaTrcYVd_fsr0jI
Message-ID: <CAJZ5v0idqEPUpA0uBb_PAaKe0KNqCt0xLskPThPwtsfh3eCdxg@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Mario Limonciello <superm1@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Timo Jyrinki <timo.jyrinki@iki.fi>, 
	Ernst Persson <ernstp@gmail.com>, Steven Harms <sjharms@gmail.com>, James Ettle <james@ettle.org.uk>, 
	Nick Coghlan <ncoghlan@gmail.com>, Weng Xuetian <wengxt@gmail.com>, 
	Andrey Rahmatullin <wrar@wrar.name>, Boris Barbour <boris.barbour@ens.fr>, 
	Vlastimil Zima <vlastimil.zima@gmail.com>, David Banks <amoebae@gmail.com>, 
	Michal Jaegermann <michal@harddata.com>, Chris Moeller <kode54@gmail.com>, Daniel Fraga <fragabr@gmail.com>, 
	Javier Marcet <jmarcet@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 3:34=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/11/25 8:11 AM, Lukas Wunner wrote:
> > In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on A=
SUS
> > computers") amended pci_pm_suspend_noirq() to work around a BIOS issue =
by
> > clearing the Command register if the suspended device is a USB EHCI hos=
t
> > controller.
> >
> > Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
> > computers") subsequently amended pci_pm_poweroff_noirq() to do the same=
.
> >
> > Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_late
> > quirk pass") introduced the ability to execute arbitrary quirks
> > specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().
> >
> > This allows moving the ASUS workaround out of generic code and into a
> > proper quirk to improve maintainability and readability.  Constrain to =
x86
> > since the ASUS BIOS doesn't seem to have been used on other arches.
> >
> > lspci output of affected EHCI host controllers reveals that the only bi=
ts
> > set in the Command register are Memory Space Enable and Bus Master Enab=
le:
> >    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D658778
> >
> > The latter is cleared by:
> >    hcd_pci_suspend()
> >      suspend_common()
> >        pci_disable_device()
> >
> > pci_disable_device() does not clear I/O and Memory Space Enable, althou=
gh
> > its name suggests otherwise.
>
> That was my gut reaction as well.
>
> > The kernel has never disabled these bits
> > once they're enabled.  Doing so would avoid the need for the quirk, but=
 it
> > is unclear what will break if this fundamental behavior is changed.
> >
>
> It's too late for this cycle to do so, but how would you feel about
> making this change at the start of the next cycle so it had a whole
> cycle to bake in linux-next and see if there is a problem in doing so?

One cycle in linux-next may not be sufficient I'm afraid because
linux-next is not tested on the majority of systems running Linux.

We'd probably learn about the breakage from distro vendors.

> If there is it could certainly be moved back to a quirk.

Most likely, it would work on the majority of systems, but there would
be a tail of systems where it would break.  That tail would then need
to be quirked somehow and it may be worse than just one quirk we have
today.

