Return-Path: <linux-pci+bounces-26677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88EBA9AB41
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EC73B7124
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4322258B;
	Thu, 24 Apr 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJyy0YXK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA9215771;
	Thu, 24 Apr 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492408; cv=none; b=AjOaX0/gz+9Adjplypq9wLk5KxHDfobr2McUJVTa7RE2H5dUz4lRnTsQQOjVV0rxztQLn7CGKDiozRccRwuXj14MZ9GgMHgTM4+N6SWsoJyM+P2g5iof9fIHU8cMGAoHRTjD9Nmb1UPkH9tg0KasCqq/RlMfrKtBOnaVUuT/9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492408; c=relaxed/simple;
	bh=FUCQAFWdBsTzh3ISwglLz2C+UdrgUnxa1ScDArq2zrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/M5QslJ4+7zj+nR0NQgbmuidm87TG4+nyhEp5jmQ2uplE9ZWHLK6q84sG5/NvrVz6VZ1ImI9DPXPWw4cVcge9ykDaDD+OjmxWVbOjlnCCdENjUS3gm1sp70qU0wBi5DwlUB0tu0swFi87KpBqipyliDBKbvX1veKbkt1zqGE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJyy0YXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A846C4CEE3;
	Thu, 24 Apr 2025 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745492408;
	bh=FUCQAFWdBsTzh3ISwglLz2C+UdrgUnxa1ScDArq2zrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rJyy0YXKWBr3qsWkr806vRB6cI4YknNqBL9xcJwbJzsmtoRv0FcNyPi3JMdfAtmHz
	 Yo1wcMVEmWnu4+wjoIJWH3uR3v8dbtvubUQWt4si8Cfk9hR25AQU6APsBG/1WFELmE
	 wO4HDzEZxxHjbV2TPwkEBjb/Vu+aDfuJI2heISks80xUdzvJaXXTKopBoql2W+rSPU
	 NTUjpYm55FFj486lK/PEMu22GOfqP4J0pN7rBXFvO2mHHjOh/AhiIIxqvJiGARmj9N
	 aOXN7W1uFznC0RbcG2IZwFt590CpXasyQKMYTr1c1/MXA74ev2xQ3VS+4mJB+vwU9q
	 8IfxvmG9abe6A==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2d09d495c6cso194137fac.3;
        Thu, 24 Apr 2025 04:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeWG14RVPfoNCR5iHhnK0feTXFfDGYDdnTeLSiyZMuo8rOna9bZ7rf/VbuuP8hCioKmtwHLAy4l0YV@vger.kernel.org, AJvYcCUuTF5EEnsU0DrsHdkRk45qtx2nmtzl0EdxyaMEE92Jk7kgzAL6c6zDKulkqO/GUQ+T8KD4MWOIXOjNUnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysE+Vq6tq9OJW8r4FFmNCB+4DhUHOmoROE55lTLTfpe8qUONQo
	fLIa6jRhyufpMevzZYK4k7n/JkdYHxhw/FSxz5tKz9xMhOhbnGRBk0zcHYcsZGx9U2eDVh+Z2vD
	fD7OfzutQBhf56d6p7UtZTsc4IYc=
X-Google-Smtp-Source: AGHT+IHte21cVQEWAahEKnIVsuZJBPGR7By5iPTfjit7uIclLc276KTM7v2HwfR+or+tBr5Kso5z6u6WlsiwlBVICU8=
X-Received: by 2002:a05:6870:56a0:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2d96e6de018mr1187554fac.36.1745492406720; Thu, 24 Apr 2025
 04:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <20250422194537.GA380850@bhelgaas> <aAnILntDM4xwaoPX@black.fi.intel.com>
In-Reply-To: <aAnILntDM4xwaoPX@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 12:59:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifgqzqP8N+NXJ=UVZ434SiyzgZjn1EuWy4HTT4TKOGWg@mail.gmail.com>
X-Gm-Features: ATxdqUGHWU9XhOrwHUjDxteSxZhLVLFkcZwF2MaVL0w5Gkap2DwrDkErc5gOYMI
Message-ID: <CAJZ5v0ifgqzqP8N+NXJ=UVZ434SiyzgZjn1EuWy4HTT4TKOGWg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
To: Raag Jadav <raag.jadav@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, rafael@kernel.org, mahesh@linux.ibm.com, 
	oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:12=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Tue, Apr 22, 2025 at 02:45:37PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 22, 2025 at 07:23:41PM +0530, Raag Jadav wrote:
> > > If an error is triggered before or during system suspend, any bus lev=
el
> > > power state transition will result in unpredictable behaviour by the
> > > device with failed recovery. Avoid suspending such a device and leave
> > > it in its existing power state.
> > >
> > > This only covers the devices that rely on PCI core PM for their power
> > > state transition.
> > >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > >
> > > v2: Synchronize AER handling with PCI PM (Rafael)
> > >
> > > More discussion on [1].
> > > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=3D9eRPuW08t-6Pwzdy=
MXsC6FZRKYJtY03Q@mail.gmail.com/
> >
> > Thanks for the pointer, but the commit log for this patch needs to be
> > complete in itself.  "Unpredictable behavior" is kind of hand-wavy and
> > doesn't really help understand the problem.
> >
> > >  drivers/pci/pci-driver.c |  3 ++-
> > >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> > >  include/linux/aer.h      |  2 ++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index f57ea36d125d..289a1fa7cb2d 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *de=
v)
> > >             }
> > >     }
> > >
> > > -   if (!pci_dev->state_saved) {
> > > +   /* Avoid suspending the device with errors */
> > > +   if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> >
> > This looks potentially racy, since hardware can set bits in
> > PCI_EXP_DEVSTA at any time.
>
> Which is why it's placed in ->suspend_noirq() callback. Can it still race=
?

With the hardware?  Yes.

