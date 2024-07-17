Return-Path: <linux-pci+bounces-10430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48404933D03
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EB21F240EB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0C17FAD8;
	Wed, 17 Jul 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="chlnY269"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533717FABC
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219534; cv=none; b=DBcnOedFAxp+sQ4FFZJGXOrAK/Qd0luRShpWBclEtFI0C2OBgDPD89jiDS7r+RNTswnfaod4wIsnaN0b6hEI5IJnwaD5TtYupVo/ZsKMfbvqbJITNe+4ODhweYs4w+u3g0qtHrroimlZD502S9sAWCzGpvVPcsF9Po93a59zx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219534; c=relaxed/simple;
	bh=l05qdUDYtYtzIwJ2QhcxqvorSJ35g1P9v6/n6D76rGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hni4/yzbVU+bknh3Qevn2u+AYbG15nb5B+isgRcTXlVob7TA0qFAAbLF8xsDo1qUecc3vC+o5CjEW2XFKk9dNjfb1eSG6Zs9M7gOSBPIlkAF1UO7tSO9vdICl/vv+ItnWQyOLqRwS+5UKzc8FWDO2byZgWBUOGkA8cA+nbnqAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=chlnY269; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so87351921fa.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721219529; x=1721824329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbUBi1oeUQFJbnBtGH+G+FVuJioTAizxvp0fQS1vBdo=;
        b=chlnY269M/8PJCXrxxYMx5C4UbVcY/XeBhtBF+N+eaDqDph64xeVJV4o3B+prlrMAw
         I9jxcoxnFDahQ67hgmg0HANHBMtBfnBXxHgqTE24XRr/IOHaSQXdsZW5RnFRLCMUPAKy
         sL5hipQhKV4kDnJZNF5r+eqqXkrprxuxFM++pspUPw9kohv9Appgcel/SIEMoqdwPeUz
         7hbnvQD4wSXn5WQhGWRpMBgXbhS50Q1Z96QD2D8nzL4yb6u1pSaihcdtTxaCKli7YGQs
         9lAWflDitq/3JCuKOAsoKgdpJEZ0ieOge1voWhfkEmfd8xpUz6voa1T700cRZo3MZNRY
         jnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721219529; x=1721824329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbUBi1oeUQFJbnBtGH+G+FVuJioTAizxvp0fQS1vBdo=;
        b=RJATaKdHAbs+rQ2Lekmzpk0mYzOEIxm1eBOG4A6w0lKD9yxGyGkMNlPKmiP7prKK2E
         LwicTUWGXPmIqR72QOdDN3d3PYXFX39cm5Jh5ibnmbPKNKyfefJJHEihu8jm5p+tUgHf
         GSzRCWvhvcfzY/uf5/b+HuIpRgJqg5nhvrEU7ZnpxNvgeFRnEnVy45Ir4mz1dr4eCT34
         BsLH/DsjeKkEL9H6Uv4Rj3jMY+7/luhV8NjKR0ajSdWnQyyPj6oEscZdnxLrq6nW548q
         2dryT+UhufeVc5OHjasqpRd/kmu+EReH5oWgVp1csUw1ThGHlUybq/4cDJP0kNokdcri
         EUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHX/8yxGwF0BU8vcZ9/sNRxyBK+f6cvSm6oksyL5cTJZsA2ZsCVBcTg0V3Fd+ZzttTwo4vrzScTUUbqvSxxmhCr8OM+1u23DOW
X-Gm-Message-State: AOJu0YwqxVgZoZ/ThFzhasOEeoRx9gNuzseFnNS0/bhPs19vCqNIBoJJ
	ewvZzVYT79EQvUwb13bjaFsAEnbSQaCXCBTWHu1kSVwBdQ9wLqYkM4X77TOXaGP7kKbJoaschS1
	qVI5Lah6fhZAJnCAiBr/dfboG1fwqp0h7MzzuYQ==
X-Google-Smtp-Source: AGHT+IHrd6WA/u4topx2ck+TD1y4nbBr1UNLmG0DLlnysPBcQgOKnNlEbr4yK/AY56sZ0v8vExJDv8A5pxM3+zla9B8=
X-Received: by 2002:a2e:a456:0:b0:2ee:4aaf:5f16 with SMTP id
 38308e7fff4ca-2eefd04b65amr10712341fa.1.1721219528955; Wed, 17 Jul 2024
 05:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
 <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
 <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
 <CACMJSeuSS1GBeMP66xt8CP3=6X9xNUZvj9cZHm_Lav6iaw9Gdw@mail.gmail.com> <CAHk-=wgK=P_7LbCH9pzX4EZFYSd7HdJ8y=Fpt797F9XxT3ThUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgK=P_7LbCH9pzX4EZFYSd7HdJ8y=Fpt797F9XxT3ThUQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 17 Jul 2024 14:31:57 +0200
Message-ID: <CAMRc=MdcUhBe6-P0KH8KfrHfp8wqM0fCWGoUZaVZ7+FAkECtpA@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 13:10, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> >     select PCI_PWRCTL_PWRSEQ if ARCH_QCOM
> >
> > in the ATH11K_PCI and ATH12K Kconfig entries? Am I getting this right?
>
> So on the whole, I'd prefer these things to be done where they are
> actually required.
>
> But I'm not actually entirely sure what the hard _requirements_ from a
> hardware - or a kernel build - standpoint actually are.
>
> If there aren't any hard requirements at all, then maybe the whole "do
> you want pweseq" should be an actual question (but limited only to
> situations where it makes sense).
>
> If the hard requirement is at the level of the driver itself, then the
> "select" should be in the driver.
>
> That doesn't seem to be the case here, since ATH11K_PCI certainly
> works without it, but if that driver requires power sequencing on
> ARCH_QCOM platforms, then maybe that is indeed the right thing.
>
> And if the hard requirement comes from some SoC setup, then optimally
> I think the "select" should be at that level, but we don't actually
> seem to have that level of questions (but maybe something in
>
>    drivers/soc/qcom/Kconfig
>
> might make sense?)
>

The hard requirement really comes from the board level - not SoC. It's
the board that has the BT/WLAN module hardwired and - depending on how
the module is powered - may or may not require power sequencing. But I
don't think we have any per-board infrastructure in Kconfig.

> Anyway, this is not necessarily something where there is "one correct
> answer". This may be a somewhat gray area, and it looks like ARCH_QCOM
> is a very big "any Qualcomm SoC" thing and not very specific.
>
> So I'm not sure what the right answer is, but I *am* pretty sure of
> what the wrong answer is. And this:
>
>         default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
>
> looks like it cannot possibly be right if ATH11K_PCI is built-in,
> since then the probing of the device will happen long before that
> PCI_PWRCTL_PWRSEQ module has been loaded.
>
> And that doesn't sound sensible to me. Does it?
>
> TL;DR:  I do think that the
>
>       select PCI_PWRCTL_PWRSEQ if ARCH_QCOM
>
> in the ATH11K_PCI and ATH12K Kconfig entries *may* be the right thing.
> But again, I'm not actually 100% sure of the hard requirements here.
>
>            Linus

After sleeping on it I really think that it may be better to introduce
a more generic ARCH_HAVE_PCI_PWRCTL symbol so that we don't have to
update the ATH Kconfig entires for every new platform that needs it.
For want of a more fine-grained solution, we would select it from
ARCH_QCOM.

Bart

