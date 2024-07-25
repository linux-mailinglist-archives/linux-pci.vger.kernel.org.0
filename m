Return-Path: <linux-pci+bounces-10788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C393C285
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 14:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02541F23FE2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077819AD71;
	Thu, 25 Jul 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSpSx33N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCEF19AD6C
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912193; cv=none; b=ELpuOOdD8igjwOKmlLBah7V2yQivw1DRcb9p/Yn1t92HYubZmpzzzaoayoIocBtnb3sW6Z90HjuJHnPTA93RJYLG+e6qkV0It71p+RC1of3/6ZR8xrlk3rHOGb3gXrw8InO4sVSVaJEZjd7qlsgkkx9TU1RgE0KleT+8eH9ynhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912193; c=relaxed/simple;
	bh=W+wn0GlOw0Gf8eTKdYVnQsoy5a7TOWTISZPM87pGBkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpu90oIkR5IdBLpkrlgpTrPdMmByBR7ZTYSDoE8gpcZSnx80OUraeW7fPZ1elux83B/KrzBoLU9JxCX37MHD7/7sm7S9UZwNTSxombh1HZQqfWG7rJMLV8EswAH/8KFpnf6mzEEhKjckuV8NHKrDfSjA89dCxTvVjjXncToTvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PSpSx33N; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01afa11cso216446e87.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721912189; x=1722516989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J36xabAj2bKInLJhB2Kp1HMkLRnJXufSHyFnP7004CA=;
        b=PSpSx33NJKP/ArKf2Klir+NRPUFjRcJ+81zpng344POaanyiZGoOf7fARnvuuHf+Qa
         aBUlAboixii+dR90vvYLVKasQMpI6mzo6Zr4EE8kYxZyIMGEiu04ovDRQEOVl/vQxQsU
         1uyOJD+vsTnWHV7E9UzoXYDpS21SyA7zO87kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912189; x=1722516989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J36xabAj2bKInLJhB2Kp1HMkLRnJXufSHyFnP7004CA=;
        b=okatIT/tApQlAJkqLxmkC+GFqGU3gMXJ4vCRanQgfCoDu9BQThuiIfraO5cF3troDP
         o1q6jrQw8bPQ1rHqUbuMimC0dcYGNVM17x2q8kc3Pl74cqtpeYyzM3D2zCEwNxB39aQl
         2PI4AazSiXK2kVopV3wnPAjmid+N693B7M0trhh1J7JlZyQJdgdvN26PmyMi7a+vGZpi
         Lj+X2gvbet8kRKDdo3eJH68XfedxgzrwjkF/iXYD/GdYEj0eCz3ethc+Nr9ZaoeKyX6y
         +erI8aFHCduoME+CxsJHK8hzBOyP3i58AySpMJCo0yDbzBVYE08gBJKhhd/npVi1iT4I
         GgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOT8QPlt0l8zJz6G9tJIN2328xG6R2QvO2vRd5Xgly5viLt5GZMcxUmcuaU5uWy6srZvSW5HEMOhBNNyHO9UmPYAWsL3NEqBX5
X-Gm-Message-State: AOJu0YzORdWQqcpFj/dEBWgOX7g/oc+xXRfNHQ+amHvQULAuFtDTSf6Z
	FkVtoGnpi80LyXU8lIM2UbLS4WC/Wz6uaBhs/MSfceUFRyYDexJZqxS5rcIn+yH/Al48Db6iN/b
	+Ht5EuVUEy/wdw/0DNXD3tw9s56FISk6qtyj+
X-Google-Smtp-Source: AGHT+IHqe58dpuQj44+fi+BabiviB+bKNn8yQfGDBzJey5WA1EPHom3t+V10YXvWL2j00LON9G2edsy2X6K/lIjK1NY=
X-Received: by 2002:a05:6512:3092:b0:52c:e312:2082 with SMTP id
 2adb3069b0e04-52fd3f9e81dmr2126031e87.54.1721912189402; Thu, 25 Jul 2024
 05:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfW=qpNmSeQVG_qSeYpEdk9pf_RTAEEKp+OiBYrRFd3d6HOXg@mail.gmail.com>
 <20240710213837.GA257340@bhelgaas>
In-Reply-To: <20240710213837.GA257340@bhelgaas>
From: George-Daniel Matei <danielgeorgem@chromium.org>
Date: Thu, 25 Jul 2024 14:56:18 +0200
Message-ID: <CACfW=qqPmiV6ez8Gf6GT6jyN5JEvF=mVeAqckWYVycsRuD746w@mail.gmail.com>
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, nic_swsd@realtek.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:38=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Wed, Jul 10, 2024 at 05:09:08PM +0200, George-Daniel Matei wrote:
> > >> Added aspm suspend/resume hooks that run
> > >> before and after suspend and resume to change
> > >> the ASPM states of the PCI bus in order to allow
> > >> the system suspend while trying to prevent card hangs
> > >
> > > Why is this needed?  Is there a r8169 defect we're working around?
> > > A BIOS defect?  Is there a problem report you can reference here?
> >
> > We encountered this issue while upgrading from kernel v6.1 to v6.6.
> > The system would not suspend with 6.6. We tracked down the problem to
> > the NIC of the device, mainly that the following code was removed in
> > 6.6:
> >
> > > else if (tp->mac_version >=3D RTL_GIGA_MAC_VER_46)
> > >         rc =3D pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
> >
> > For the listed devices, ASPM L1 is disabled entirely in 6.6. As for
> > the reason, L1 was observed to cause some problems
> > (https://bugzilla.kernel.org/show_bug.cgi?id=3D217814). We use a Raptor
> > Lake soc and it won't change residency if the NIC doesn't have L1
> > enabled. I saw in 6.1 the following comment:
>
> Can you verify that the problem still exists in a current kernel,
> e.g., v6.9?
>
I tested it with v6.9, still the same problem.

> If this is a regression that's still present in v6.9, we need to
> identify the commit that broke it.  Maybe it's 90ca51e8c654 ("r8169:
> fix ASPM-related issues on a number of systems with NIC version from
> RTL8168h")?
>
I also tried v6.9 with 90ca51e8c654 reverted and it works ok.

> > > Chips from RTL8168h partially have issues with L1.2, but seem
> > > to work fine with L1 and L1.1.
> >
> > I was thinking that disabling/enabling L1.1 on the fly before/after
> > suspend could help mitigate the risk associated with L1/L1.1 . I know
> > that ASPM settings are exposed in sysfs and that this could be done
> > from outside the kernel, that was my first approach, but it was
> > suggested to me that this kind of workaround would be better suited
> > for quirks. I did around 1000 suspend/resume cycles of 16-30 seconds
> > each (correcting the resume dev->bus->self being configured twice
> > mistake) and did not notice any problems. What do you think, is this a
> > good approach ... ?
>
> Whatever the problem is, it definitely should be fixed in the kernel,
> and Ilpo is right that it *should* be done in the PCI core ASPM
> support (aspm.c) or at least with interfaces it supplies.
>
The problem is actually the system not being able to reach
depper power saving states without certain ASPM states enabled.
It was mentioned in the other thread replies that this kind of problem
has been reported several times in the past.

> Generally speaking, drivers should not need to touch ASPM at all
> except to work around hardware defects in their device, but r8169 has
> a long history of weird ASPM stuff.  I dunno if that stuff is related
> to hardware defects in the r8169 devices or if it is workarounds for
> past or current defects in aspm.c.
>
What would be a good approach to move forward with this issue to
get a fix approved?

Make a general version of this toggle workaround in the aspm core
that would be controllable & configurable for each pci device individually?
Keep the quirks and fix the aforementioned comments?

> > > This doesn't restore the state as it existed before suspend.  Does
> > > this rely on other parts of restore to do that?
> >
> > It operates on the assumption that after driver initialization
> > PCI_EXP_LNKCTL_ASPMC is 0 and that there are no states enabled in
> > CTL1. I did a lspci -vvv dump on the affected devices before and after
> > the quirks ran and saw no difference. This could be improved.
>
> Yep, we can't assume any of that because the PCI core owns ASPM
> config, not the driver itself.
>
> > > What's the root cause of the issue?
> > > A silicon bug on the host side?
> >
> > I think it's the ASPM implementation of the soc.
>
> As Heiner pointed out, if it's a SoC defect, it would potentially
> affect all devices and a workaround would have to cover them all.
>
> Side note: oops, quoting error below, see note about top-posting here:
> https://people.kernel.org/tglx/notes-about-netiquette
>
> > On Tue, Jul 9, 2024 at 12:15=E2=80=AFAM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> > >
> > > On 08.07.2024 19:23, Bjorn Helgaas wrote:
> > > > [+cc r8169 folks]
> > > >
> > > > On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote=
:
> > > >> Added aspm suspend/resume hooks that run
> > > >> before and after suspend and resume to change
> > > >> the ASPM states of the PCI bus in order to allow
> > > >> the system suspend while trying to prevent card hangs
> > > >
> > > > Why is this needed?  Is there a r8169 defect we're working around?
> > > > A BIOS defect?  Is there a problem report you can reference here?
> > ...

