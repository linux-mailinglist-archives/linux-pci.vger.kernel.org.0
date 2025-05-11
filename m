Return-Path: <linux-pci+bounces-27557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF6AB2941
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DC1712B7
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679801FF603;
	Sun, 11 May 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot6a00a+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA22907;
	Sun, 11 May 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746975212; cv=none; b=Y1W8flClrPoYKowwmfpEzzlk4c2ScIlWfONQWKe/OPODUDNUx+DRhjNBE8Hw7Sz0SRYrt6DsqOyztom6lvv3rNVW1jIBifLUsjW8v7b4U8r8HDdqwmx67SYPscWiAxzG4kb6YxePoBe69+wvCQaIawcqnKEJB7fBr9PDueaMcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746975212; c=relaxed/simple;
	bh=0NU8uplAjo4GOERxUeXyP2g2dEIPieHAx2aUymbRIeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrl+qORwVXKBXnIGRrTUZZVXSi6kEW6rAXb8J2aqtgkDJ6BapSpCLBEo7HK65Jnq9c/DfRXH42LvHfzImY9zzAfSTvaNBw4X2i7GLrAQ7f1cNnBZa7Yq251vUgy29n/TsJAYvnk2aBKKc2k2pcBsCbPPp7VdmFgtToxwkj1fe6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot6a00a+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3105ef2a071so41344091fa.1;
        Sun, 11 May 2025 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746975208; x=1747580008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+SNn9MtbqikaPdKk5wtAAM3FI1+8eVlKOTCGSspdmU=;
        b=Ot6a00a+k8qGkVBxmIITktKwfDrx+HtgH3maiX/APHtnEEHx2pyNsVHbeo2giNV0Wx
         edmn2FFaEt1UvDSL+qRRJJ/8cgbjcRZ3vd91aXyRkS+tN+slgp+54NUh0nnjdHY18dqJ
         vO4g9FxY0BPhiTWELqWLW9WT60p1rrBwIROHxdui+gHrofpwSoAEQgL+FIhNjm9Af81G
         8/j8CDIyTuA+LqDHFedKZQYXuInt4Mlzv/qr6lDo2XAWa/+1Knu9mfc4EnWjSrtoUZY6
         28S2OF7YUqFg/LuYO+Vv40n4rUvv7pS2j6pcvDXYFKx7mlMBsRvLGqJqg8RjUbdGZ37G
         dl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746975208; x=1747580008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+SNn9MtbqikaPdKk5wtAAM3FI1+8eVlKOTCGSspdmU=;
        b=LWYXWUCkyIiYx5PfTH9wz8MoXOtzNyBJB3/dc5gHNSertjEGVlRLEPN5/OWG/mTLxr
         +m/+LHO3HdTw7V1uL/zKo1/ZuntTDWv1wbpQ3Dosy6BFMXiH7srj8m06fKw9JbinHM7K
         0O560CaT8rU7jA4SCBN+YXqxcP51s8J2yEp/txDo5qRkaJXM0bMQ5ube4QvIHOwaqJ3o
         ySVeFZFrOoGTlXt6gNnhVPJF3o0h2DFmk1ez9g0nAAlZZ92P6crIC90nQZysMbzt1exP
         fCOihJ8UY3GFcTO9ezlg/7MFZb89uxkOwpV+S9KplNbXQkx7eSjeZWBBB4NJxszKoWBT
         ctng==
X-Forwarded-Encrypted: i=1; AJvYcCU06QlD/cfml08HP3mx3citftoOsH02D8GAJCxBYNEwO8YCSaEoSdHHh29ZfSYYYS5bpmlefZZX91E=@vger.kernel.org, AJvYcCURcRic6I5sy15Sm4+YhyunWD0gmoK7UcVwBwNiHE4Z+9FgAH0UB4tsB4FNtvnppgEtbeAKHXTi120G@vger.kernel.org, AJvYcCV9H6wwXI6MnQVGSz3sKqW2gJxDOif5nvoENKTsP28ELnzDztFHcn6iOK937FuEdmnTXn0gF8QemBf7e+w=@vger.kernel.org, AJvYcCXJrp0+Xq68VMT/4mlh70Z458+jHp/KVYnCYaq3l1bVXCgpvWVkGRjJWyfGer8sZK0wwx8xblHoF956NNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc1UObKdvfCsRFcP/SsHu4kWpNxGGkvsVjCia8qocZegz0yfS
	2rJwPnMwc0ISy6dv0ZtRSDpH+kMLD3VDvOqAJe4djL2xiEsBoZZLFOSMelw6Ngu1rqbIrZQH2to
	gmA2kpM3h9HCTppi6Tw8htIuyLD8=
X-Gm-Gg: ASbGncsyUq9EY2mFMFoahNk99svheonUg4B1zpd0IrriGMQbGkPFivPgEzAhc+Ex/6h
	m2wPFvoloDOdQ9xfGu18ndr2sYqGqjEg7w3VndGj5i9fHJHhItJlyVGv/LPXSncSrERdBuAEbKs
	ojd0O4Sq5GVCj+hCEaZm9HuodejI8cK/EV
X-Google-Smtp-Source: AGHT+IEW2M3t9r376LdN00E7nRVrPqLJdblkVY1e1M8Lu+r3rQ6L8tocf5XoHcoGI5voVVL5e9HLMLf0oZGyxIKDbaM=
X-Received: by 2002:a2e:a541:0:b0:30b:ce0a:3e63 with SMTP id
 38308e7fff4ca-326c459a4c5mr39892771fa.7.1746975208267; Sun, 11 May 2025
 07:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com> <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
 <CALHNRZ88VaS6zmmnkQg_WrBVPjMT4e2uPUPEQUj8ARL1TieZPg@mail.gmail.com>
 <gxbuvopbhum3v622gf4olzfspgihxt3dm4z3rsj4gquaabt2c4@peemxrxshjuu>
 <CALHNRZ9DHApwS_W22aD0uOFJKBk8WkucFo04_vjLRpnRjP4WCg@mail.gmail.com> <nsldcdzdf7xazzm3dlb4jrjkehgt3hjlar7uc62twpkwocrer3@u5kirzyify4n>
In-Reply-To: <nsldcdzdf7xazzm3dlb4jrjkehgt3hjlar7uc62twpkwocrer3@u5kirzyify4n>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 11 May 2025 09:53:05 -0500
X-Gm-Features: AX0GCFuYOPYdeDB4aKbOtH-_GwGqt75BeJmtEnem2ldfw3E7EAu1DKFq3T6g3Yw
Message-ID: <CALHNRZ84EmZ3reCns9c4s1DavZLYsPvdNtm0wstAiF-CbD=d4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 1:24=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 05, 2025 at 11:59:27AM -0500, Aaron Kling wrote:
> > On Mon, May 5, 2025 at 11:48=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, May 05, 2025 at 11:43:26AM -0500, Aaron Kling wrote:
> > > > On Mon, May 5, 2025 at 11:32=E2=80=AFAM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Rela=
y wrote:
> > > > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > > > >
> > > > > > Debugfs cleanup is moved to a new shutdown callback to ensure t=
he
> > > > > > debugfs nodes are properly cleaned up on shutdown and reboot.
> > > > > >
> > > > >
> > > > > Both are separate changes. You should remove the .remove() callba=
ck in the
> > > > > previous patch itself and add .shutdown() callback in this patch.
> > > > >
> > > > > And the shutdown callback should quiesce the device by putting it=
 in L2/L3 state
> > > > > and turn off the supplies. It is not intended to perform resource=
 cleanup.
> > > >
> > > > Then where would resource cleanup go?
> > > >
> > >
> > > .remove(), but it is not useful here since the driver is not getting =
removed.
> >
> > I may be misunderstanding how stuff works, but don't those resources
> > still need cleaned up on shutdown/reboot even if the driver can't be
> > unloaded? I recall seeing shutdown errors in the past when higher
> > level debugfs nodes tried to clean themselves up, but bad drivers had
> > left their nodes behind.
> >
>
> Each callback has its own purpose. The cleanup is only performed by the
> .remove() callback, but it will only get called when the driver gets remo=
ved.
>
> > In any case, do you want me to just not add .shutdown() at all, or try
> > to set the proper power state? Prior to the half-baked attempt to make
> > this driver a loadable module several years ago, there was no such
> > cleanup.
> >
>
> As a first step, you can ignore .shutdown() callback and just remove the
> .remove(). Shutdown callback implementation should follow the steps I men=
tioned
> above, so it can be done later.

This has already been done in v6 [0].

Sincerely,
Aaron

[0]  https://lore.kernel.org/r/20250507-pci-tegra-module-v6-0-5fe363eaa302@=
gmail.com

