Return-Path: <linux-pci+bounces-8909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2263D90C9AF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C331C217F8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1515278B;
	Tue, 18 Jun 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b="WCh45wPf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A913AD0D
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707247; cv=none; b=vDp8B18egE+lGAbw2vOQ4rPf9MWDgsuOropIOT6/ubCNb969dEGIv7hNN4p3ufFv39n+rFWKMJxN5WR9u3Wfx9si+WgkCktovBlaP+PzwybE4o+ZnSjJnhAyfszukXtk1dRwJoUyZxdSB3D7mkKg9qikHdRBo/ISPFPKEH3JaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707247; c=relaxed/simple;
	bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD85nWIRgKayemDpoacAa0XsMVnBf5yZnOzTIetaR6Zy5x611dFbv7GqPVNjnjI4V8WBJenew0j3UDZspz1SE4k4qL/xYWrexfXY+8w4iObc4uru/SlV9gCrr02mAReUo/o6GUs5iS0v4rGNXIZtkNTyWT7EEPj+BTfvzFTjvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp; spf=pass smtp.mailfrom=igel.co.jp; dkim=pass (2048-bit key) header.d=igel-co-jp.20230601.gappssmtp.com header.i=@igel-co-jp.20230601.gappssmtp.com header.b=WCh45wPf; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igel.co.jp
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so1839029241.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1718707245; x=1719312045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
        b=WCh45wPf+3zeUTO4xLEfdM+TDH2ABUImqUVBJSh8iTK6nOt+AeeXKQXzpW/TwHPCq7
         VLHT8iayH4E5azDpDH8o9PUE7iraNckzp+341rN5nh9mwpMea2S9IJH6bgYOHj9mjL9J
         1Z5PypGjPH4Ac9XXRQKjDQ18IUc26ZXohrg2xtrjftr7SNTSPhDrIcKNR9XjA2hUZsdk
         Nx7DpTo/GzWDk9OSMnxKMnNpCIlXwvLxVzgK1gOkp66SM89mB/SRbYiw/OueRqYf1syd
         qBJGfARkA+9Jm3MhnyBV7QQ0Clj0MUMGcy3oFkcBbYRBwHLlAfnuxT6VG+x0G08GLtiE
         HzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707245; x=1719312045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUZtEG9m5EGGPIsNYlvFNCzGak0heKIOdAl3a6ylhIw=;
        b=VTiQGOoPU8rgb00Ek4eJERFmgepquy747MLLmfiiNcUGfwmrA7wqmuHWkYA2wAcU33
         ZMwU+paAz5lmOKkyfRH3NJxHHxhYEadCa9K61pp/CYN1BAVq/tXNXu2UmLotMM8B49n9
         S0Hl8F3VFtE6x0ofMnlizc1z+7vfdDY6g/IKoDEP4N9Yoj38V9lTubX2vyvcTjsIjSe/
         lrb4MucK7gIkgBQmhWTVOAxk4JGm/psn74bnBLkCYMwYs4QUjsoi9NWKQrq5mFLoRlw4
         Zxc4jdBCWY+m2MG5NCM3U1mECWvUdq/WAwvsapvAvXqvSnp6hFUCPiZCu9wh1Ak9isrv
         3dAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtV2JxrmRSPwUcGRGPgx+sPffiAF+7GvRFG2LSfcj9JhQBK2DzXgBnMVWunTZ/vcwQBnvpD97OEFT+Us3LPFExzBb3SmEIbDb0
X-Gm-Message-State: AOJu0YyB8CVhFUcVnerpj0TulI9IRbTNvHLYcNCncwiEz0Yjft2ghqGj
	OVZtjJArVFcdeaJ8i5c9Zu4Oj2E1D9gMlkmF23pKTYdgDW1T+tbv8+VjRywjwV2JP9RcmmO6xtS
	0hZNIimyKQAK1tjLaoQDJHTqXIGd8P+YzWvpNiA==
X-Google-Smtp-Source: AGHT+IGvfcGfqQoY3MzRav8ed/slokoh5A3Ps7owp6wpMs2ZMHdV4kkvRQ+BzhDS69u78xzULFIbl4tCnNz67fGKqJE=
X-Received: by 2002:a67:cd9a:0:b0:48c:4e31:4e25 with SMTP id
 ada2fe7eead31-48dae34bccdmr12303977137.19.1718707245269; Tue, 18 Jun 2024
 03:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad> <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad> <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org> <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240618061705-mutt-send-email-mst@kernel.org>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 18 Jun 2024 19:40:34 +0900
Message-ID: <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 19:33 Michael S. Tsirkin <mst=
@redhat.com>:
>
> On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > Thank you for your response.
> >
> > 2024=E5=B9=B46=E6=9C=8818=E6=97=A5(=E7=81=AB) 18:47 Michael S. Tsirkin =
<mst@redhat.com>:
> > >
> > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > Let's clarify the situation.
> > > >
> > > > The Virtio device and driver are not working properly due to a
> > > > combination of the following reasons:
> > > >
> > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > Physical DMAC to be used.
> > > > - This feature is not available in the legacy spec.
> > >
> > > ... because legacy drivers don't set it
> > >
> > > > 2. Regarding Virtio PCIe Capability:
> > > > - The modern spec requires Virtio PCIe Capability.
> > >
> > > It's a PCI capability actually. People have been asking
> > > about option to make it a pcie extended capability,
> > > but no one did the spec, qemu and driver work, yet.
> > >
> > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > >
> > > why not?
> > PCIe Endpoint Controller chips are available from several vendors and a=
llow
> > software to describe the behavior of PCIe Endpoint functions. However, =
they
> > offer only limited functionality. Specifically, while PCIe bus communic=
ation is
> > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > virtio's.
>
> Okay. So where could these structures live, if not in pci config?
What does "these structures" refer to? PCIe Capabilities? virtio configs?
> --
> MST
>

