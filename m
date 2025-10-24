Return-Path: <linux-pci+bounces-39258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D590CC057BF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A346D5016F4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048E30E0D8;
	Fri, 24 Oct 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSlB0Dh1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49930E0D0
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300333; cv=none; b=VQRJGFHMqIhiO5kbgz9BEuoZkA5VpxtzzrJwdX/CSQgkSf6U+wLbZTJjG223YFe7UXh9hzXk3HohJg3zObFe6YM8PiX8hSlcXKn8J2Ef6A7tg85nTu9g+Cln+jrP8UF3TCeb0GJL/XmxfBWKZ6EiXPNUoZAEloaV+zIviteKF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300333; c=relaxed/simple;
	bh=efrS9BaHzDRqhG4QPznfmvIjLIwB/bsLCdY70IE0Tv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnzVRIe7ar8XVHINZlLHrP7CpnDwu0Nr5IiKt6Psf4mf015TMH2QXFKqIcbSngCsuQn8PPLzn6pyuy4MU9BCtaKacTazMzU44OqgU21CnWpn4HgdI0whg+LoGJVeeTSd4b4DLKu7nXAUKk5b4v4oxFzDtTCrJFOALIZ8uAwHZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSlB0Dh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9F6C116D0
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761300333;
	bh=efrS9BaHzDRqhG4QPznfmvIjLIwB/bsLCdY70IE0Tv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LSlB0Dh1NSpS/8uneJsnnbGYw6rT7CMLI2jcZevmBWtZpigdzWvSTOzE4mXD4eqdn
	 2w4TtPSZnPE606Dqnm0qzfQPlujwqqBAIbsjqgTVOAAp7nc5mzAckY/VZYCSig7UiV
	 wKwfhMx862FZZUcc5yGBudrBYPDAACMpiaGzTwczT/NB9eXVTRsqH54r2pTrUov9S3
	 Epx4VstKOE4K2AZlT7MWmrBF46uDeryS4nVfbf0lEDAYyk/zwxuETeBwWTt2TNpNtV
	 ujpK1IXZtAFizaa0IjOh+hgpDrvb0cjfqQmqstkk0I4A7X+SqUqtszq6zRtd6hrJ7o
	 ucsa30tvHR6kg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso3032220a12.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 03:05:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPwrPopyDGdy96QswOOyHowyuCjnh5t5QHDvC7iHDy1+9yhokzCdnU9ZGU6Sk1dBLXvTD9qQKMeGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFNLkhb27e6v1FSxirOMHh7xnOIL0IaJ1b3YhIZwZuMCgOFCA
	qipoqhU/BYL/JJOZNLqGw1YkdEpdfERf8r6+Rg44X3FnE5qPudB1bfeCtc9eXFUUAEZYMuPAFIr
	+B3Iqnm7ufWdUwFE/5a1GMaG29JgFVcM=
X-Google-Smtp-Source: AGHT+IFHKF3NqoBmlDZaV0FmRNKD8/mFve+wH2ZdxsuoPoEiVQWtYjjzOJHSr2GPjLRNRae1vdUmrmDSA+Q6Q598ylA=
X-Received: by 2002:a05:6402:2551:b0:639:ff4f:4bba with SMTP id
 4fb4d7f45d1cf-63c1f631c38mr25690693a12.2.1761300331796; Fri, 24 Oct 2025
 03:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3f11e8562f589ddb2c1c83e74161bd8948084c3.camel@linux.ibm.com>
 <CAAhV-H4Q932R0fAbL6JyygZcgALdO_HJZ1Cqo88EhNMm04yjtQ@mail.gmail.com> <163456ca8cf900e24fe3b9ce71fdad7b68398058.camel@linux.ibm.com>
In-Reply-To: <163456ca8cf900e24fe3b9ce71fdad7b68398058.camel@linux.ibm.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 24 Oct 2025 18:05:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58cjSgPLPfSSZD4DSSct_bKLF6SYMSJpBwdUT8NY3AhA@mail.gmail.com>
X-Gm-Features: AWmQ_bn7F9mwmAnOW8C62JDHkaD4KHO_NxlTLxyK-o3RilHrWBmtY9bE5wxagHA
Message-ID: <CAAhV-H58cjSgPLPfSSZD4DSSct_bKLF6SYMSJpBwdUT8NY3AhA@mail.gmail.com>
Subject: Re: Potential issue with hypervisor_isolated_pci_functions() handling
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, jailhouse-dev@googlegroups.com, 
	linux-s390 <linux-s390@vger.kernel.org>, loongarch@lists.linux.dev, 
	Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Gerd Bayer <gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Niklas,

On Thu, Oct 23, 2025 at 11:25=E2=80=AFPM Niklas Schnelle <schnelle@linux.ib=
m.com> wrote:
>
> On Wed, 2025-10-22 at 22:49 +0800, Huacai Chen wrote:
> > Hi, Niklas,
> >
> > On Wed, Oct 22, 2025 at 7:40=E2=80=AFPM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
> > >
> > > Hi Huacai, Hi Jan, Hi Bjorn,
> > >
> > > I noticed that with commit a02fd05661d7 ("PCI: Extend isolated functi=
on
> > > probing to LoongArch") LoongArch now also makes use of the isolated
> > > function probing. First, nice to see this sees more users and that th=
e
> > > interface is useful to you.
> > >
> > > Seeing this, I was reminded of an issue I ran into when using this
> > > mechanism with SR-IOV capable devices. In that case VFs with devfn > =
7
> > > and PCI_SLOT(devfn) !=3D 0 wouldn't get probed.
> > > This is because if a device is found next_fn() will check whether dev=
-
> > > > multifunction is set. So if for example devfn =3D=3D 8 is found (fn=
 =3D=3D 0)
> > > dev->multifunction won't be set in pci_scan_slot() and for VFs it's
> > > also not set via PCI_HEADER_TYPE_MFD. So we won't check for devfn =3D=
=3D 9
> > > even though that could very well be there.
> > >
> > > Now for s390 this currently doesn't cause issues because for all
> > > multifunction devices we have, we either get a VF alone and then sinc=
e
> > > commit 25f39d3dcb48 ("s390/pci: Ignore RID for isolated VFs") use dev=
fn
> > > =3D=3D 0, or we have the parent PF passed-through and then VFs always=
 get
> > > hot plugged after SR-IOV enable, which then uses
> > > pci_scan_single_device(). And for non VFs we always have devfn =3D=3D=
 0
> > > and/or devfn =3D=3D 1 and multifunction via the header. So in a sense=
 the
> > > above commit works around the issue, though that wasn't its primary
> > > intention.
> > >
> > > Did either of you also run into this issue or can reproduce it?
> > >
> > > Somewhat related, if ARI is enabled this would also break the isolate=
d
> > > function case including on s390 where ARI is used by the platform
> > > firmware, but detected as off by Linux because there is no struct
> > > pci_dev associated with the PCI bus. If I patch Linux to correctly
> > > detect ARI, it no longer finds an isolated PF with devfn =3D=3D 1.
> > LoongArch do have some problems after commit a02fd05661d7 ("PCI:
> > Extend isolated function probing to LoongArch"). Please see:
> > https://lore.kernel.org/linux-pci/20251014074100.2149737-1-chenhuacai@l=
oongson.cn/
> >
> > Now we don't know what happens exactly, so I haven't answered Bjorn's
> > question...
> >
> > Huacai
> >
>
> Hi Huacai,
>
> I have now send[0] a fix proposal together with correctly exposing ARI
> enablement in s390. I also reproduced both the issue I saw with SR-IOV
> and with ARI and confirmed that the first patch in the series fixes
> them. You're on Cc and I'd highly appreciate if you could test whether
> this fixes your issues as well.
>
> Thanks,
> Niklas
>
> [0]
> https://lore.kernel.org/linux-pci/20251023-ari_no_bus_dev-v4-0-8482e2ed10=
bd@linux.ibm.com/

There are two patches in this series. If LoongArch has a similar
problem as S390, only the first patch is enough, or should we need an
architectural change similar to the second patch?

Huacai

