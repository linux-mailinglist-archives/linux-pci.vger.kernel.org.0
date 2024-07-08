Return-Path: <linux-pci+bounces-9965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8992A9AD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 21:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D001C214DA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A6149E03;
	Mon,  8 Jul 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zftEpZcq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2654146D74
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466231; cv=none; b=eZSfC8NsAv/n0KNyoeTyanAuGS6lzxxtARG9PrmeNvZ1sHhVKjwOyeA6+QRRw7kUqBDI9fKgBy/K8faN1zHVCpqpQ2AZGQa1lsgH1epTdvD0JAaBTptk3r2YgfGx0D1ZeUAF9deli5jFz7ZhZl06y3jECbdPl+s6cgd7akWYRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466231; c=relaxed/simple;
	bh=2YkPKybmFfXpEtlWnSAev+qWlFwWhYKuHeoHZDJ8qg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rK3EjAaeTmS629F91djWid3B3++0dn7mMMk9HhTPl2IOIZkf3CJdxeC3A7eNwYydmorwho03N64hIjE5yZLgEx9lgp7WqLBGwb6whqUSrxg95lfUGF8XwlAVIEyTsNvsfFU9Pz9SaYwVJBj4eGCv0p8Y44xr54ZPbp+8K7PIbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zftEpZcq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso4000776e87.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720466228; x=1721071028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I46/sl1vOkRD0VawTjt8d9rDXOduKgs3gSTuztxTpWU=;
        b=zftEpZcqSMyqPRtj9lUTgSMe8GwIN5VToeioKSOxP7k7mb8SIMEW3DP3lGeGphCyQ9
         RNM+no1+JVQt4ErLrcyuHBjo5/2QSFW+phHTr9LYIoafXIb3ER6hGheg0fpIWiki1KRp
         7Igs0VIx3RAnzSBBpG2M9UcpdbMLKni4kMXN4JpLV3Ko2BqqYKpWSDRN3JJiszdyXsOA
         e9GW1mbyOSCuOqJQ9RqG0qNTMOtukVZwIwv/ew+U6m3TGjvd5q5gwE2S9J/cV13JXuOz
         AgBixA1V/mfqA257hiPA06RvgAT5OKq7ZyEOUny0e1ZpsSj9y+KVtqFHiyCwGbyKzqig
         AUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466228; x=1721071028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I46/sl1vOkRD0VawTjt8d9rDXOduKgs3gSTuztxTpWU=;
        b=fY8aJmrJ40QQnpBhkCpTY34HoLaEMf5BqgCaNoRI6cwb+M/05mWfMvFnQBNfOlhrwF
         5f6YelDQDAvRtJ5pVjYoMYriUlRRMFIZ8PUlpriBoMjm0qygnrXUVDOiLmH/xgF9sufX
         x+cG0u3pNH2Fmeu/VilEU/1l29kcloW5Md6hffFe1yvSQWp2V6a2O6zhKePdNsgTX9rt
         H0GhEsVFnCQaPLbhlCMVMZ2tRyyGv2AELhEv9Wwi0B0trVD7E15zkYdJvwLd45P9ZiZl
         vLU0H2PY4Iakpez2lsTV+h9zTgWNediQL/5Gy+Dv33vSfT/XqYbFF1/2yMB1jlP45Yze
         2/FA==
X-Forwarded-Encrypted: i=1; AJvYcCVcV7UlbG/TR95cmPr5cnkQTRtzd2nJ8wNrVLJtmOHUUUMgo9eF5y1YLyJ8ot/D1BXCMu90iXgCga5U0eSWbmFNfXhIfJfCCHMM
X-Gm-Message-State: AOJu0Yx7DDBm+otPQU9/y+Uj9LvOQNQobTmp7XpZK3xXbCIDdxA0OBvn
	RK3xPkq+PU1MeWEHlpkkS8BbsxmF34hREMlKSwmFSUm0GXTHUzl28ix9H+lSWsjDInlFu4SC4+Z
	Gb2uts5yJuHw/xDMv5uae3Y4PGoK07xb4xP//rg==
X-Google-Smtp-Source: AGHT+IEOcs5WiL9t3ypSXAsKH3R8wqGw0/8hutzF2x6cX3HDJo0KH1tPGbq0+RmIJbts9PCp+07nF+vJYonw5qvGrf0=
X-Received: by 2002:ac2:5605:0:b0:52e:97b3:42a1 with SMTP id
 2adb3069b0e04-52eb9995536mr133025e87.24.1720466227717; Mon, 08 Jul 2024
 12:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <20240708191328.GA144620@bhelgaas>
In-Reply-To: <20240708191328.GA144620@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jul 2024 21:16:56 +0200
Message-ID: <CAMRc=Mc5vRmh5huLZ0hxbaJCZXOOfYe-8c5Xcuy+f3GU-7-C0Q@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org, 
	neil.armstrong@linaro.org, Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:13=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Sun, Jul 07, 2024 at 08:38:28PM +0200, Bert Karwatzki wrote:
> > If of_platform_populate() is called when CONFIG_OF is not defined this
> > leads to spurious error messages of the following type:
> >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> >
> > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF =
nodes of the port node")
> >
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>
> I didn't trace all the history of this patch so I don't know whether
> it's in or out.  If it hasn't been applied yet or will be revised, run
> "git log --oneline drivers/pci/bus.c" and match the style, e.g.,
>
>   PCI/pwrctl: Call of_platform_populate() only when CONFIG_OF enabled
>
> This would also match the 8fb18619d910 subject so it's more obvious
> they are connected.
>
> Bjorn
>

Good point. I updated the commit title in my pwrseq branch.

Bart

