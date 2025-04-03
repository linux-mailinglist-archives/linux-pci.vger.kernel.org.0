Return-Path: <linux-pci+bounces-25216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF794A79D1D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0339C3B213A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29162241661;
	Thu,  3 Apr 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jSOnHL0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636C24061F
	for <linux-pci@vger.kernel.org>; Thu,  3 Apr 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665919; cv=none; b=WtXTzevVA0bVOptPJv7RYd4JWP99iRq6FeItrW/7NkRT2FtBdjhksSPxuQurIOKcksWNwpEpFVMNMjNqxZEVd6ZS4f/BHbazW3x499EIS2sUaBiTD9g4aj1JoysdOwKtJGBm2KoJhGV9ICbWuBB+e+isuKmiJExbMmpMZQWt4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665919; c=relaxed/simple;
	bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlIha3aj7hO0fLpaUjmyoTkY/LL9AAUlKnqDmVSOM5zXDHmG4ncgyKm35TbKEpsRL0NgbHSNcnvB3VcV6VJPGukWDI2lXv0dcLyMY6/1DzBnU8nkUjAeRopeeXlDHrvYMaj5NUnS3M1T1ZhveSIrYCYE+GXnlFUT/DGrgYoBVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jSOnHL0P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c2d427194so5891001fa.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2025 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743665915; x=1744270715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
        b=jSOnHL0P6rxBH3daRFVWc0mGrRQ1uwVoxMTC4Wlvzx9cz1tQPKc6ojaSDg8NQNsDtI
         i8+8MJv0fSOU98YTGMdQFEzT7Aab/Qe0UJYhMQwiU2ubt4jPXw1FtVcg/SNmOUl3H94V
         rFgzks4TE9PgWsc1M/Rkv8KbwHNQpCFXRvCZT2O2mJCm7Epud5O6pE/hcW9TdWw9tYON
         Yln7qTkOm8FUeHmzS5LUIJ1xgfs0tNw0gWiuqymy+1P0hatXAazO9NFNXgHTmZrFu6uA
         GmHRbei4iGTJS9UrawVq51hxKrmeZC64Y3XKvuyr435LLeNte1cLEuIwZpMu7AFGkH0t
         BKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665915; x=1744270715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
        b=RTaHKc6wWAaDwdGDzVylRysHnlqFm7kagvUCNo5CHWS09IEfJRxZEkxWXF035xFj5b
         AtMRoAVqaqYjGGMLY0tAm+cYhAZVE54Fd8CcKNQ0gV6WohgsVmthomK9jIgP3csrzEEE
         3SeN9t/m1DTRw4mBP3W6ERYtfVA+EOMX3Z95HNVrbnF9TcPFsNDFGQ0NUaPMgBaX7VJ1
         NfucyQwIWrtuxjy67GdVN8Bfohic9+pvvUb0NwkoRbePAZXmHu93eIWj4NzP1YWQtLUM
         JuW/DWv3lyUSCMaML/wtwtfub9wM6A0qXfGL0HoIjqL6pMSVg+ClnVguEiewCBhBksgP
         tiHA==
X-Forwarded-Encrypted: i=1; AJvYcCU1EhS+Y/EGnkqR/bH3Wqhc4i7l2gvWfAwK6BIxt94OUa2GygCVPSEsL8sLQxcqFvfkKCAJZJUA0O8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsk0kw7Z/fDPAC/WHO785r/5pJH1KLWIl4G/lQKvTSC7RA58MY
	QdGZvROABMnwuX6bClNBv11cjV+gb3FlYuok7KOBg2GIWRq0eyIWoZyIvWApBYcyoll7hOKa0KO
	+p7g2hxOQd9hC8UZtwuwT7iCt4aDDSsSQAFLbqg==
X-Gm-Gg: ASbGncuwZLF4PuS3URY+48iY2t0gJcbiSokCI77DpUM9yYJdM7Ma5nCC97ow1GenYpB
	0lZn1SCr8ii0UaUYL0KRyJNuFZWMWeVLpv+ySYrYmj953QetzJlwG1xTm8Kwc6aNewUR3i92ikW
	KNUz3fdblyHbyxY1HlkgK/zdxA+hgqbqI2mCfRX1NAvabQSxAcmK0WkwjI
X-Google-Smtp-Source: AGHT+IE+efI2xX/8yZlFAe4Vm/Cxzz+Nax11lqQy3zdclZUZJJhpwXV7c7fhUqN3JwjPrbPY+ZyZGS0ljljrKBqXCe4=
X-Received: by 2002:a2e:be14:0:b0:30b:8f60:cdb7 with SMTP id
 38308e7fff4ca-30f02b985a2mr4363601fa.24.1743665915290; Thu, 03 Apr 2025
 00:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402132634.18065-1-johan+linaro@kernel.org>
 <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com> <Z-42nVkEZeWHdwAm@hovoldconsulting.com>
In-Reply-To: <Z-42nVkEZeWHdwAm@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 09:38:24 +0200
X-Gm-Features: AQ5f1JoaECCB4Ig-OQoVaRV_IJbeuDbZtSRj286KtUBGCZkrM4_HeX7c4fhC4-E
Message-ID: <CAMRc=Mf3on3TpiPDhtPnp1-3b0ika2GHy6h-NJqcgvYpWMHpoQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jonas Gorski <jonas.gorski@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:19=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Thu, Apr 03, 2025 at 09:11:07AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Apr 2, 2025 at 3:27=E2=80=AFPM Johan Hovold <johan+linaro@kerne=
l.org> wrote:
> > >
> > > The PCI pwrctrl framework was renamed after being merged, but the
> > > Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> > >
> > > This leads to people not knowing how to refer to the framework in
> > > writing, inconsistencies in module naming, etc.
> > >
> > > Let's rename also the Kconfig symbols before this gets any worse.
> > >
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > I'm re-adding the tag here as otherwise b4 will only pick it up for
> > patch 4/4 on v2 of the series.
>
> I had already added it to the first three patches so it was only
> missing on the last one.
>
> Johan

Indeed, sorry for the noise, I saw b4 only applying it for the last
one and didn't check git log.

Bartosz

