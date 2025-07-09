Return-Path: <linux-pci+bounces-31798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB8AFF0DD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DDD1C451B2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D54239082;
	Wed,  9 Jul 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqpX7s1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4448F40
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085568; cv=none; b=XndwqmpxQHf2VWRSr4o7Z9xFs9QDtrWt0HulpEd68IJkrg8p8v9h9U1kuypq/nlGLUwcI44wo2OD21Q+J0clb4+pXURRYjhQhLng4gjx/A50M4IRwH22GP1JCNERdJUxN04asknGwdvxKlC0ABRofYIRR9OM69Ss9pO39glHAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085568; c=relaxed/simple;
	bh=eOxaD0xP66sLnf7EJXIhw08t6rlYKB5w+krSS59aIiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdE6N/JFZw34Xgak4K77UlXLn7Uja1fP31keba30xDcxc85Q1+NeGX0Y49d2cASzvVOo6pqGXiLSdTskhnaKtD2Jfqq83JTt8rkzpUfYEvdtUytZx6qMZOewzRZlbn+owMFQk87WWFxfb3qpmbjHUJsw+bSRHhhjRo7BU4St6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqpX7s1M; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso43721cf.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752085566; x=1752690366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jw0U0pt810CrvcEtnpGnkQ1gm1d+fCbUdzB2KqcB6I=;
        b=NqpX7s1MkZfX+v5w6s1O7s0bYCyFicZbuF9ckvF/O66BdInNRRce2NkBBUCV/B0vB7
         Z5936Fhq0sascsB/9Kbzgr+MGpK8QHUQEcEIhCaLVg3rUbk+e3mnLGX7tlTVVWfnlAgJ
         jDGxV959OJuWC4VNEfZrIt7wRpphhXzRxhFF5/5KXl3hqAAMWXeZQ6fB1N0VQh/AHu6D
         7wRJwtQ7qfcyRmWaFBq5dJChO2IDgE8kU8w79hWBegBoz6g3N/ACfiyP66jybvmVvLyZ
         0I9an/WXK5JVTxzGbrBoH/lgPKJ5O9jECIPnWUF8JBhqS54llOsq5ZEbGTqfb6wjSBWP
         oLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085566; x=1752690366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Jw0U0pt810CrvcEtnpGnkQ1gm1d+fCbUdzB2KqcB6I=;
        b=dNdKBKzwvyvr7hcp7VyVbGxwCt8KmKGdTuZvOD2lqw51175O4BZ4noP3VtHdGzVK9l
         My7U4lNpXZg1MoNB7MKL+anlQG4ks3dvh2UdjPddsmGuYyZpbP5Bp8kbqTOqUDs2vh2i
         0AmOMHsQUU6C+YvsYGlPUC3fitQVLKmv+wBpPVQuhV8hyjEslEF/42qQHK2te5p5ntQl
         V+gBJ8H1DrfkahihZcu9pTikLztHEYdj4TEtSXvuDiHJ0kUSCO9VpG21xYTmR2XowYS2
         YqAx44iXLcWRH1gVijPl082++oxivJb30PRvlSt7s7YgJtrEK0XzSnHKBXEXh5jLvMov
         FqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpOi3PhZ6+SXS68G+y9YCtAnafyQ8ZjH0Oqsuz/Rz90NtPjHNuDsU6Blq05Gx+qZFkCSVm1qJFdSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGZP7sOUKjc+dubbY3/JpRM0TMcW+mpgkmnCYc7UM//IqnaA9
	8b6BBWLQ5Ufi/YOa1geyzdHnZnZrmCtFy9BaODk8rd2lcptyc39Z4x09bAG1OwxOcY+IMCO7kLl
	aYff5RPjGfMZTgFepKOLBukYUjjr3NgEXZ814laGc
X-Gm-Gg: ASbGncuqAB4n8It7aRKJnZZC3UNNzDZU6m9Xz59/67Nkl+Zr8gkV0TbWs46WkC1wqi5
	AWdnkPc1jPr6jAhJy1u0WqMceSzkvkdWz19Xswuk1aWdh/p3RzPqznNTWeED0lDlYyHEQoAj3HC
	Xv0gdJ3wPB/dVGvAmpyv44uIEujJ9ZUjX2i4vJiAjPdmV5Uu1Dm0drG+DiBp1buFKWOvQRrBWAJ
	DErFTDmkIjVXpw=
X-Google-Smtp-Source: AGHT+IE/UXmHmew6r4eZ0wcZsjs4AYXpci7aKhDdA2pi8AQ9I7IXluLXGjerSI4MA3Fh0XCat49I3fNXfnWQVQZ7uAc=
X-Received: by 2002:a05:622a:1309:b0:4a5:9b0f:a150 with SMTP id
 d75a77b69052e-4a9eb161d2cmr334831cf.16.1752085565703; Wed, 09 Jul 2025
 11:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbbpayW+y8s3i4qxzHcoY0Yz5qeAhb7ziey=FayDiZbC_mm7w@mail.gmail.com>
 <20250613220950.GA986935@bhelgaas>
In-Reply-To: <20250613220950.GA986935@bhelgaas>
From: Ammar Qadri <ammarq@google.com>
Date: Wed, 9 Jul 2025 11:25:54 -0700
X-Gm-Features: Ac12FXx8x6b8gR53M7MJ4PEwsP40NUglknMl5orGHNNKeJ1xjT1ATDEIWhdsCAs
Message-ID: <CAFbbpazQU6S4MDAGcHDKG79T2GOaxz9Ezg2Ls6hhPDCTVLrdEA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
To: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is the only message I can see being consistently printed as a
result of the open/close of the devices.

I am not opposed to carrying this out of tree at all, but for the sake
of exhausting options people would be comfortable with, would you
be okay with moving this to dev_dbg, or would you have the same
hesitations, Mani (et al)? Or is there some alternative flag-controlled
behavior you'd recommend?



On Fri, Jun 13, 2025 at 3:09=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jun 13, 2025 at 02:40:40PM -0700, Ammar Qadri wrote:
> > Hi Mani,
> >
> > The issue we are experiencing is not caused from
> > removing/reattaching the device driver, so the other messages have
> > not been problematic.
> >
> > The vfio-pci driver is attached to each VF once. Clients in our
> > system call open and close on the vfio-pci driver, respectively, at
> > the start and end of their use, with fairly short-term tenancy,
> > which ends up triggering these enable messages.  This message is
> > proving challenging not only because they are not particularly
> > useful,  but because they are causing log files to rotate once every
> > 30 minutes or so, and we lose a lot of other more valuable logging
> > as a consequence.  I'm open to other solutions, but in my opinion
> > this preserves the message, without over-engineering and introducing
> > throttling or other behaviour.
>
> Are there any other messages associated with the open/close?  I assume
> probably not, or you would want to demote those as well.
>
> I did happen to find some value in this particular message just the
> other day because it showed that a config read was successful after
> previous ones had failed.
>
> But I agree in general that it's fairly low value and at least the
> uninterpreted "%04x -> %04x" part is not really user-friendly.
>
> If people think there's enough value in retaining it at KERN_INFO, I
> suppose there's always the option of carrying an out-of-tree patch to
> demote it?
>
> > On Thu, Jun 12, 2025 at 11:12=E2=80=AFPM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > >
> > > On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> > > > Excessive logging of PCIe device enable operations can create signi=
ficant
> > > > noise in system logs, especially in environments with a high number=
 of
> > > > such devices, especially VFs.
> > > >
> > > > High-rate logging can cause log files to rotate too quickly, losing
> > > > valuable information from other system components.This commit addre=
sses
> > > > this issue by downgrading the logging level of "enabling device" me=
ssages
> > > > from `info` to `dbg`.
> > > >
> > >
> > > While I generally prefer reduced verbosity of the device drivers, dem=
oting an
> > > existing log to debug might surprise users. Especially in this case, =
the message
> > > is widely used to identify the enablement of a PCI device. So I don't=
 think it
> > > is a good idea to demote it to a debug log.
> > >
> > > But I'm surprised that this single message is creating much overhead =
in the
> > > logging. I understand that you might have 100s of VFs in cloud enviro=
nments, but
> > > when a VF is added, a bunch of other messages would also get printed =
(resource,
> > > IRQ, device driver etc...). Or you considered that this message is no=
t that
> > > important compared to the rest?
> > >
> > > - Mani
> > >
> > > > Signed-off-by: Ammar Qadri <ammarq@google.com>
> > > > ---
> > > >  drivers/pci/setup-res.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > > > index c6657cdd06f67..be669ff6ca240 100644
> > > > --- a/drivers/pci/setup-res.c
> > > > +++ b/drivers/pci/setup-res.c
> > > > @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, i=
nt mask)
> > > >       }
> > > >
> > > >       if (cmd !=3D old_cmd) {
> > > > -             pci_info(dev, "enabling device (%04x -> %04x)\n", old=
_cmd, cmd);
> > > > +             pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_=
cmd, cmd);
> > > >               pci_write_config_word(dev, PCI_COMMAND, cmd);
> > > >       }
> > > >       return 0;
> > > > --
> > > > 2.49.0.987.g0cc8ee98dc-goog
> > > >
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D

