Return-Path: <linux-pci+bounces-35915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D4B5349E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917677B9ABF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7132A3D1;
	Thu, 11 Sep 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBSErB3M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D13164C0
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599006; cv=none; b=FoExqQC71aMI7DYAlsRs0QKmIcB0ViB63RLKrClZ1NG1PVn/hKwendMS3eV7mG43lL1Apz5WEHherxhdaBXxtYGwOCBt+QpIZhc3zmharBQHDBXmX2LXLJtIrZRjkcYO4/vl5eayDAg/aNVoIslFqwAimSZNqVW7iSe9ce2TBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599006; c=relaxed/simple;
	bh=XreLRLQA9VQYVf55N1pr7vao9Kkcl1FgTuDhIhX0gt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKcOyDTNhOJuW7V8Iulkn3FLW0bub1Egyi6qEIdPeD/KMNL013Qj82bnf18Ac0gvpCkxMosBAfK3qy6Q0J781xboY05TNhCZw4uAtHY/VuMHLL2rWQCuUMIu6h26IOzW+NfAai7gxvCKq/dWtKwSUGiuwb3nSJ449PJebPbnCdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBSErB3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141CBC4CEFE
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757599006;
	bh=XreLRLQA9VQYVf55N1pr7vao9Kkcl1FgTuDhIhX0gt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pBSErB3Mq676ZtpVlSSDZH7F1BZSc7zHNrDK9HUhXYrHVQiYOJJsyoZYZWqDLqy8Z
	 Ji1CX+kDxNl1olUC3EnjAa2ZHt6g89usl5+emNkSof0v5kKY2rhGpuE7xJpCoJPvyS
	 kYNBvCij9gK+dhGu8drKA24n5lbIvEh5MeyMZiJDKt7l/zI8mgc/IinYn5fhs+AncV
	 M9GKRsgfwEKK5p3G6C9+E1WVKtlXRSgARNu4zfH+Or7C3Mx6WSs1oi74Y118FC2itk
	 58tPDNJzmIM4Za+ldBx7jFwsjHC5bwGN98ZBdOjRD5sWpMOz7GrgYCM9IsuXOns8wn
	 JLa6MkRrBF1XA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74526ca7a46so266756a34.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 06:56:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWvLuRzrf/IiMT718RR6/VkWb+Wu/38KyCTaW7AHLEnjgc4OLuVvYJuE5aMeRsdI8Krh+hax9gVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcAW6REzxRZNIPD/HW9owl9JOZ9Vejo0DBtmbVubFsOehheZ+
	G7GE/GEbvODJzZldcdj2wDKzRr40l30Kz2i8myEblCagpU2mIKyJ6pUWNsDvPrysA8+xlo0asiU
	X+fioHGn5a32Yy/NXutm3fCy/pxCNu+I=
X-Google-Smtp-Source: AGHT+IGewrkHSVC2eTTHWTcmKSSrQ5YjkLF2A24xWJgCYYx99uWpX75B43+fO5oF3eNbSRFyBQ04mhd396ycJfKVGeM=
X-Received: by 2002:a05:6830:348e:b0:74b:7c40:3592 with SMTP id
 46e09a7af769-74c6f315077mr10017347a34.6.1757599005085; Thu, 11 Sep 2025
 06:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75e4ae507fa4faddd063a3a9e17d319ed84529b6.1757562971.git.lukas@wunner.de>
 <80980751-64db-4dc2-9516-03046e8b4b31@kernel.org> <CAJZ5v0idqEPUpA0uBb_PAaKe0KNqCt0xLskPThPwtsfh3eCdxg@mail.gmail.com>
 <fd9629df-0718-4968-b22b-cad36d870f63@kernel.org>
In-Reply-To: <fd9629df-0718-4968-b22b-cad36d870f63@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 15:56:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJHxVvyNdvDSZg=Pn9=xEqO79T4Ou9toc0Qofi777NcA@mail.gmail.com>
X-Gm-Features: Ac12FXzQaZbYxSmuA4gYIQi2t8BWAAduta2HGD5DxcN46xT6wVPS-p3q4c093YQ
Message-ID: <CAJZ5v0hJHxVvyNdvDSZg=Pn9=xEqO79T4Ou9toc0Qofi777NcA@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Move ASUS EHCI workaround out of generic code
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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

On Thu, Sep 11, 2025 at 3:46=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/11/25 8:43 AM, Rafael J. Wysocki wrote:
> > On Thu, Sep 11, 2025 at 3:34=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> On 9/11/25 8:11 AM, Lukas Wunner wrote:
> >>> In 2012, commit dbf0e4c7257f ("PCI: EHCI: fix crash during suspend on=
 ASUS
> >>> computers") amended pci_pm_suspend_noirq() to work around a BIOS issu=
e by
> >>> clearing the Command register if the suspended device is a USB EHCI h=
ost
> >>> controller.
> >>>
> >>> Commit 0b68c8e2c3af ("PCI: EHCI: Fix crash during hibernation on ASUS
> >>> computers") subsequently amended pci_pm_poweroff_noirq() to do the sa=
me.
> >>>
> >>> Two years later, commit 7d2a01b87f16 ("PCI: Add pci_fixup_suspend_lat=
e
> >>> quirk pass") introduced the ability to execute arbitrary quirks
> >>> specifically in pci_pm_suspend_noirq() and pci_pm_poweroff_noirq().
> >>>
> >>> This allows moving the ASUS workaround out of generic code and into a
> >>> proper quirk to improve maintainability and readability.  Constrain t=
o x86
> >>> since the ASUS BIOS doesn't seem to have been used on other arches.
> >>>
> >>> lspci output of affected EHCI host controllers reveals that the only =
bits
> >>> set in the Command register are Memory Space Enable and Bus Master En=
able:
> >>>     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D658778
> >>>
> >>> The latter is cleared by:
> >>>     hcd_pci_suspend()
> >>>       suspend_common()
> >>>         pci_disable_device()
> >>>
> >>> pci_disable_device() does not clear I/O and Memory Space Enable, alth=
ough
> >>> its name suggests otherwise.
> >>
> >> That was my gut reaction as well.
> >>
> >>> The kernel has never disabled these bits
> >>> once they're enabled.  Doing so would avoid the need for the quirk, b=
ut it
> >>> is unclear what will break if this fundamental behavior is changed.
> >>>
> >>
> >> It's too late for this cycle to do so, but how would you feel about
> >> making this change at the start of the next cycle so it had a whole
> >> cycle to bake in linux-next and see if there is a problem in doing so?
> >
> > One cycle in linux-next may not be sufficient I'm afraid because
> > linux-next is not tested on the majority of systems running Linux.
> >
> > We'd probably learn about the breakage from distro vendors.
> >
> >> If there is it could certainly be moved back to a quirk.
> >
> > Most likely, it would work on the majority of systems, but there would
> > be a tail of systems where it would break.  That tail would then need
> > to be quirked somehow and it may be worse than just one quirk we have
> > today.
>
> But is that a reason not to *try* and rid the tech debt?
>
> We could just all agree that *if* there is breakage we revert back to
> the quirk just for EHCI.

Well, it's not that simple because how much time do you want to wait?

The distro installed on the system I'm using right now ships with a
6.4-based kernel, so it potentially sees and may report breakage
introduced into the mainline 2 years ago.

Will you decide to go back to the EHCI quirk if breakage is reported 2
years after dropping it?

IMV, if a decision is made to change the pci_disable_device() behavior
in this respect, we'll need to stick to it unless the breakage is
common and overwhelming (which I don't really expect to be the case).

