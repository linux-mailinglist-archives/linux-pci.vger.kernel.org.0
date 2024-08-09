Return-Path: <linux-pci+bounces-11531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7E94D06B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8FD281202
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1A194A4B;
	Fri,  9 Aug 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHeq6EW3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8A1946B5;
	Fri,  9 Aug 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207502; cv=none; b=MBPTTplj8U9XZGn/TUr9s6Nvc7lxLWo5eSWKTAO0M34B80F/CIPiGk2fW230PJaMJFu5ox0GwwlMwOq0ijha7zXlRZWMvWZk9R9IApcPuA+8NSrkd7FqM+tkjNo1WWq5UeaQ2gX3hvcDgsKQ4B9DEJ5cfICVNpfJraF2N244kvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207502; c=relaxed/simple;
	bh=6bpHH55PmHSIuGpxKe9OccM54IHzFmKO4NMykoSFxLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOPAhg9TliffnJoApICLdkKhNKXHB+oziZ3r+LoulDVZcxQel6Jywevos6BPvLlSoL9SZC6bRcycjJ1fGP48o1RtNYtomIOPiZ+14NGF9YlXEmvEiW0GQP6N03m/yMNM9czEHWBfpkIqBRTVs9eF6PU2NwmvzhR9xWfVw9cWAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHeq6EW3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fea2d40adso11284161cf.0;
        Fri, 09 Aug 2024 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723207500; x=1723812300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48vf7nEd9vZ/92NQo32xfCTGoa6badiJ+foOxBm4pMM=;
        b=ZHeq6EW3okJkOeBUVEcIypide5SqNbjGY4+ehp6s2tYXCfnun2GlkG+8ODNsvvtjIF
         vHAtTrTwiI4g32N9NY8Ac3q5fNZypf4Adn0VaQhGn7fqcOTtHa9YGhaahL+YQUh3SBlN
         FGF412fOlMw0rdscEbldGDwYC6yp++1Mhv0ycsmULU+xrXIArwSS4+uPZ6qzK8v4Atkn
         xiZZfiF46DcGcNMc0nfs5i4E4saFXV+MNh+MuO+WTW1SvKGKnDOKfWrEvSRVrj1VIY8k
         2/1SrAd4M77rp2bT4asvNSrH/4LPdITX2b2yWbfuXGU8WOJFzZBXc0OIiK+Th95Xrm2P
         F02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723207500; x=1723812300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48vf7nEd9vZ/92NQo32xfCTGoa6badiJ+foOxBm4pMM=;
        b=nDdF8wd1pfSmIe8ssAKkP/l16wXKjw66xi6LWRGq5lXfoMu2PI9P2d801Z7BdI+Q1Q
         gD8944rUyhyAUZfvmIsOSl8tyar4TyQ2OOhISYS1Zb5HP/KZzVsZEF75qM4qn+7U1IUL
         Jt2+jRBTc8t8sdvm3hRRbyQDAmNegraj2JFQVirfk2MfmvDBhhnTS9FCU4Nfe2i1vHrK
         eVIFJF71CvfOVaxXI6tzEwOXcpcHwUxcfFiGwaWHDh24NuAsSD9vgOoXRCmjgJHeRBnU
         z/cBfZgJKydegPUEk3olPaY8y5l2vgUfaRHspDEEOVeOHmiKCE4R8nV0X28BYYZ8a1XZ
         bVtg==
X-Forwarded-Encrypted: i=1; AJvYcCUwmreAXhxzYTV3gaPYmtGzMztaLXN/OogAJXQfY11hnMahIf0fROUbuKCG0kUSvImquJedrfjbloz0+INu2QVVI+KoYBvL7IeuEhbHPGM0GL7zX2Z0fWu4W4twZ72VCLOuaYqFDRuD
X-Gm-Message-State: AOJu0YzhM33bSl7LFm2TKHadgrss7xGMZ/BFK7irZdNrKBMDAzrAi+TC
	hoBJKR1E0wCn2WE7OuRaGck5pF89eCkjc4nfzz34Ckd+UiWsVspoBik5o/ZHRSaVteniWMD/tKt
	DyHKewo5cgzJAsvfeXdkcGSxbfJY=
X-Google-Smtp-Source: AGHT+IG4RrSMH6jQUVSj/2DF1V5mNULbFfIw/hZk+moAeVVLZVYEmX9YsqoQGFPLc91KES7XMUhkl/v7lXJ4VoNtQCg=
X-Received: by 2002:a05:622a:4084:b0:451:cd18:8498 with SMTP id
 d75a77b69052e-453126e1eadmr14411461cf.52.1723207499632; Fri, 09 Aug 2024
 05:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_RzfZWns316GziuWbX-ZhO-xZm8rhssoC6tAdizGK1s3Ai+g@mail.gmail.com>
 <20240806213602.GA79716@bhelgaas> <CAM_RzfYZLVTNgvML3OuBDoupcz4BxWHY3R1mUmVaskD5648x1A@mail.gmail.com>
In-Reply-To: <CAM_RzfYZLVTNgvML3OuBDoupcz4BxWHY3R1mUmVaskD5648x1A@mail.gmail.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Fri, 9 Aug 2024 09:44:23 -0300
Message-ID: <CAM_RzfbJMbukzcchCA=HF+=orhx95X8RxNEd7JUg9Vck=pDLFw@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove type return
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Guilherme Gi=C3=A1como Sim=C3=B5es <trintaeoitogc@gmail.com> write:
>
> Bjorn Helgaas <helgaas@kernel.org> writes:
> >
> > On Tue, Aug 06, 2024 at 05:54:15PM -0300, Guilherme Gi=C3=A1como Sim=C3=
=B5es wrote:
> > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:
> > > >
> > > > > I can see that the function pci_hp_add_brigde have a int return
> > > > > propagation.
> > > ...
> >
> > > > The lack of return value checking seems to be on the list in
> > > > pci_hp_add_bridge(). So perhaps the right course of action would be=
 to
> > > > handle return values correctly.
> > >
> > > Ok, so if the right course is for the driver to handle return value,
> > > then this is a
> > > task for the driver developers, because only they know what to do whe=
n
> > > pci_hp_add_bridge() doesn't work correctly, right?
> >
> > pci_hp_add_bridge() is only for hotplug drivers, so the list of
> > callers is short and completely under our control.  There's plenty of
> > opportunity for improving this.  Beyond just the return value, all the
> > callers of pci_hp_add_bridge() should be doing much of the same work
> > that could potentially be factored out.
> >
> > Bjorn
>
> Okay, then what the action that the drivers must be do when the add
> bridge is failed?

Maybe we can make a change to the drivers that use pci_hp_add_brigde() to
check the return of the function and return an error to its caller like thi=
s:

ret =3D pci_hp_add_bridge(dev);
if (ret)
    goto out;

I have looked at all the drivers that use pci_hp_add_brigde() and they all =
have
an out flag to call pci_unlock_rescan_remove() to unlock the mutex and
return a code.
We can return in the out flag the code that is the return of
pci_hp_add_brigde() and
then we can set that return code to some #define to identify the error
that is returned.

