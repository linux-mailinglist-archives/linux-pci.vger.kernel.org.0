Return-Path: <linux-pci+bounces-10382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E62932F36
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0581828538A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D619EEA5;
	Tue, 16 Jul 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DZfcO+C1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6519DF87
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721151541; cv=none; b=mh5ajxbLeC8/IqakyLV/8pqRMd8VG8tDnqeiDdMXvnOtoEGJTYPJI1idz0phQdV6B4DVUXepRiwPc/enYW11DRB+KTWsjOrpxZiwne3zzU5cgKezOLs0OeQYmRnC3T5HLGDUdfpZIThR4nqZ986gIbljeORxgAPcwWfDMP4eMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721151541; c=relaxed/simple;
	bh=fiuf3BXNn2hReR+sxnVMbn9Wa/YussXuxBdQcdgwLiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww4K0+3knznLeLIFAt+edSbweWwUl/+kjyPy/dznaa97tbyLj2K+fwWT+DypkDTx/NSsdh/lLB+Q1GTlz6QRcWzw3W12Jl1gwroPZuh8dUplje31j0p9VBoabzjsL/BD/lrHmMDdBNgtEkmBANvjdJnz5U6A5MibgrZYx1fJ3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DZfcO+C1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eede876fcbso38185201fa.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721151538; x=1721756338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiuf3BXNn2hReR+sxnVMbn9Wa/YussXuxBdQcdgwLiQ=;
        b=DZfcO+C1X3vJk7prvjcdloA1Vu1hfDpoSSW9t+RjTZhnfJsyS0fkn+yf85zW/Le1WL
         GybGinpI3khd14lhDu7WqaNXopk+XzN9GFabtla/20wlj40WNjgKS3wMmXjdgGem+n+m
         wB/GfO3aYz22wFsj4z5TCOnolaifEDrF5Iq9y6/HLWkxp0gVvO7ePZIJCBunbPzRGWfi
         +nlfMtsjCXMcWxI0z5U+7GErxltq8tDJKFfY4J6STDELuPUVFjUhbOAYlipKK2kuRPgn
         r/JFmR9RYEPn0Lw874ckATGFiYK5EwN89VCq2X/ENXuTnmdNdxGAk3iQ+PiE6vVUzNED
         8JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721151538; x=1721756338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiuf3BXNn2hReR+sxnVMbn9Wa/YussXuxBdQcdgwLiQ=;
        b=PAK2ADtYm+hox6SdSVp8a8mdNuITMsWsjCIa+byWEdNIHVUenTwqyBhqdQOnKsyPxt
         EuX647k57GQr30W5QoonwqvUSYuRx1xMgHCrpIrZnJOesaIAu1ItCF+S4eE/3aXT5IiT
         M67sBV3uXWsOJj1sTw8Bd3nKUqyjftist38NzIUsJveSzZURHLBbUGkZ+eOTuhd+h8K6
         vf8B5vHwdJRTSH9Sl/4Vl5DaLR7248TbllnbnzKINz8z7de7EM9FwJhw6j2Izz54Qc6K
         lwdyVXLH5ZOhCUebuw+lFvqv6jzBhLQFyKl/BRh9cpcArr0n+x3On+gPL1GCt4kC2FUE
         ISDA==
X-Forwarded-Encrypted: i=1; AJvYcCVvK7Lry3o9q3w3AbMuZQuM/lD91E2U5apbmxdtkz2zcFWXkqzbzVaZsgF9Z2uMqSiNRUr8EZr9d1RnsN/xOGtqeIjGjj4+75JW
X-Gm-Message-State: AOJu0YyVzNrdooeEXuloxPbzYg8rntDPw/un9BRfWhJjRabgaD0DVWbR
	Z2Y6eudWWyovX1WmIzggd9ajUlqaBKX7T6vKTDR++WTE1ZV4LwiEZA1i+MF4VbBK0UNDjOGSsda
	xQb7+ock2SBgT9CMraq/E3oa/fSGhwRDTnRyfbA==
X-Google-Smtp-Source: AGHT+IECPMk9nLTlTEBNBAM0hlphHHU06zWDAV/V7jCJo+x5uJ2sPc1vymCk2s3xyDlUux14Sy2sFoQ/7Uwhcj2sgsE=
X-Received: by 2002:a05:651c:a06:b0:2ee:7d3c:670 with SMTP id
 38308e7fff4ca-2eef416e906mr25736141fa.19.1721151537558; Tue, 16 Jul 2024
 10:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <20240716155943.GM3446@thinkpad>
 <CAMRc=McObC-+xPfZADQ2wEHO5c3htLbPZLU0Ng-VmgBPEN-2Yw@mail.gmail.com> <20240716163312.GN3446@thinkpad>
In-Reply-To: <20240716163312.GN3446@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 19:38:46 +0200
Message-ID: <CAMRc=Mdr3QaP1-tLwH9Oyjw1+8mfCsNj18u3YGwpHTmhBtB6OA@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:33=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 16, 2024 at 06:29:04PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Jul 16, 2024 at 5:59=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 05:23:18PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Kconfig will ask the user twice about power sequencing: once for th=
e QCom
> > > > WCN power sequencing driver and then again for the PCI power contro=
l
> > > > driver using it.
> > > >
> > > > Let's remove the public menuconfig entry for PCI pwrctl and instead
> > > > default the relevant symbol to 'm' only for the architectures that
> > > > actually need it.
> > > >
> > >
> > > Why can't you put it in defconfig instead?
> > >
> >
> > Only Qualcomm uses it right now. I don't think it's worth building it
> > for everyone just yet. Let's cross that bridge when we have more
> > platforms selecting it?
> >
>
> This is the same case for rest of the Qcom specific drivers as well, but =
we
> enable it in ARM/ARM64 defconfig. So I think this driver should also foll=
ow the
> same.
>

Ok, so let's do it in the next cycle.

Bart

