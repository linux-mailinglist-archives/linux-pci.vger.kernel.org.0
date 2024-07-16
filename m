Return-Path: <linux-pci+bounces-10403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C699332F7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2056C281AA2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35513B784;
	Tue, 16 Jul 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FpaFvr57"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E781448ED
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161798; cv=none; b=RsICzoe5tzVgFtWG9b+3KNyeBdSYkzmvplaDCf9A1t6/QQri+NYH1GIyZ+5F5HZGEe3GryVJecqD8bORZZVU8XyDOefJLvOHGAb8lXPWL5PMKBrjSoR2MxuvwvnFO7CxIOHYY8g5CUGgzhmwSBbl4y2nToBm9I4AZNiBG9W8Ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161798; c=relaxed/simple;
	bh=up0D5nQQftdcKhSarVd2jtZJoskmXDlGtz+96WFVZLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP6X58gC5MPYZZX1Q8DLBOEl0ATsdhjKAX0MD3/NHXABPSXTsxeUTyQGuw4mR7/bAnl2nD4J5Ax7ELFoIPkWMN1Jwbojr19BkIn9yU7P7o17nq+9WfOr1YkjHqzkeXnJnT9nazuEuJI+9P4f8JpgE6u6nz5rgD6JD2h7s5kvDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FpaFvr57; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so7350078a12.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721161795; x=1721766595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcqla/AFwdtdNx0I9cN8FcPEG+DdSCj27CfmPF17X+o=;
        b=FpaFvr57i/y4aSZgmNlhiWTvfDkQnhiagoK7ZHptrURmxRz5Moqh+52WdXVlJunUWU
         8Mblq1TGW2T2dPcENDdjJchG7F/3JCA5qz9rvOTbHKc1kjeeD3wY2QZIFiOgzJgZTjMX
         MDYVqsIueMbwaVIeU9ToTB8eddIsaEbzeHhek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721161795; x=1721766595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bcqla/AFwdtdNx0I9cN8FcPEG+DdSCj27CfmPF17X+o=;
        b=Ffeoxevd4hIRnCmu8iGkfsTaVTfF2BE8mGvrwI5M0TI0EchEr5WyDNjl5NhEk1i3Bc
         89CVteX5CLpR/sNKmVqCUidA+JVAQ3n9auCPtVs17hdu+llACeQUjaO9h1ZYX3RYkhTO
         l2YMK/jnSBeY879yD9Zp6CRia90mEcP7gVOaDRrOA/qexxKn5eZ1VMvaC63L+HNI/2Qe
         40Zmj9O5wqi0sU1xyOe+a5YZcT0mHAdGVLhl8Lp3C87SprlpzpZCQsPVVwPm1hYi06XS
         XDuudyDN2wDPuEFbRBFE8t6S/zS/hCv+r2HkwzZOUR9KoAEWZbZndCRw5eGetT7F9btO
         CN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyVUXh5ppyK/R9i/c8fKUgqDV5neaNF1yIZIQNYFuMs7twv3Jf+WoSBPXrDLorRuM9CkGqJW+kMuRRD9L3nIvk+UC+CgnPk0AO
X-Gm-Message-State: AOJu0YwImsFS86wdtIM1JObPS6oFL0raxekryb0TT0ecoxmaOkxSDBoY
	2ZFE6o2lluWmUDzedDuAiusj1X0D39qZTafWHQiNYOT9QITK58pPLu1HzQQDRuxLoxhj+qCZcF+
	jsaBbVw==
X-Google-Smtp-Source: AGHT+IHpUJpwYRq172txYCgrN0ObHI+14pIZX0ozCu2+oSxdPlm0RYo2gX1OY6i8e6Nywpb/bRGKuw==
X-Received: by 2002:a05:6402:234d:b0:57a:1e0a:379f with SMTP id 4fb4d7f45d1cf-59eee832048mr2824828a12.16.1721161794896;
        Tue, 16 Jul 2024 13:29:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b8c6sm5560953a12.37.2024.07.16.13.29.54
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 13:29:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so6835144a12.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 13:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWm7xOCAXHFhLZAe9RvE1gvcc3Lxp6oXP+ZmNrxxfFSnVunWvkI8qYsVqsaBBEHK6Qgst6/RRbcd2KxWg5FplOQV5NHhfNEDJE7
X-Received: by 2002:a05:6402:2711:b0:59f:6797:57c1 with SMTP id
 4fb4d7f45d1cf-59f6797623bmr2049355a12.11.1721161794010; Tue, 16 Jul 2024
 13:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
 <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
 <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com> <CACMJSeuSS1GBeMP66xt8CP3=6X9xNUZvj9cZHm_Lav6iaw9Gdw@mail.gmail.com>
In-Reply-To: <CACMJSeuSS1GBeMP66xt8CP3=6X9xNUZvj9cZHm_Lav6iaw9Gdw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 13:29:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK=P_7LbCH9pzX4EZFYSd7HdJ8y=Fpt797F9XxT3ThUQ@mail.gmail.com>
Message-ID: <CAHk-=wgK=P_7LbCH9pzX4EZFYSd7HdJ8y=Fpt797F9XxT3ThUQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 13:10, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
>     select PCI_PWRCTL_PWRSEQ if ARCH_QCOM
>
> in the ATH11K_PCI and ATH12K Kconfig entries? Am I getting this right?

So on the whole, I'd prefer these things to be done where they are
actually required.

But I'm not actually entirely sure what the hard _requirements_ from a
hardware - or a kernel build - standpoint actually are.

If there aren't any hard requirements at all, then maybe the whole "do
you want pweseq" should be an actual question (but limited only to
situations where it makes sense).

If the hard requirement is at the level of the driver itself, then the
"select" should be in the driver.

That doesn't seem to be the case here, since ATH11K_PCI certainly
works without it, but if that driver requires power sequencing on
ARCH_QCOM platforms, then maybe that is indeed the right thing.

And if the hard requirement comes from some SoC setup, then optimally
I think the "select" should be at that level, but we don't actually
seem to have that level of questions (but maybe something in

   drivers/soc/qcom/Kconfig

might make sense?)

Anyway, this is not necessarily something where there is "one correct
answer". This may be a somewhat gray area, and it looks like ARCH_QCOM
is a very big "any Qualcomm SoC" thing and not very specific.

So I'm not sure what the right answer is, but I *am* pretty sure of
what the wrong answer is. And this:

        default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)

looks like it cannot possibly be right if ATH11K_PCI is built-in,
since then the probing of the device will happen long before that
PCI_PWRCTL_PWRSEQ module has been loaded.

And that doesn't sound sensible to me. Does it?

TL;DR:  I do think that the

      select PCI_PWRCTL_PWRSEQ if ARCH_QCOM

in the ATH11K_PCI and ATH12K Kconfig entries *may* be the right thing.
But again, I'm not actually 100% sure of the hard requirements here.

           Linus

