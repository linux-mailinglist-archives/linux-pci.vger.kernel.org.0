Return-Path: <linux-pci+bounces-32447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F0B094E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09511C8005B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E452FCE3D;
	Thu, 17 Jul 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sbAp6+nn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E1288CAC
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780029; cv=none; b=NTiQoREATm2RG0BsemooB3avF4mle/HDQZZxepums7317Ehf567P3QjrJWT06FDKBwUVkIdFrIH+zRaLKirvJp5lIs9XtvI33pBRU3KoBStTdhu1W5vQb8yPXbU9EIvQS1uaBLPWHI/zX4UzEO9g0WHb5fzR4ozESM1Q7s6I5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780029; c=relaxed/simple;
	bh=TMKaD2jDZftv2KL4usKq/1tWi4qHNmQsjmx7ZcR3kqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXRSKSUej9QdkUOiv+yH8lZoHSWrvGDJNgz2Q1Ygr7ZZEj2VD69Sn65rfbR5DSu8SdGwJSG7J50PQhR8MRj1XjVfLcdON/CeB35wvdtSJPcYee26DpDCEdGRXSsUJylrljqfXUdmdJt+7c0nRAEJ4EaSuttQgIr4b6CUr3tLuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sbAp6+nn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-558f7fda97eso1015757e87.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752780025; x=1753384825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWmeJ/AYffWPF+7aeLi3O1CN5eBnowfZ5iJlSoV66Ok=;
        b=sbAp6+nnq/u3USPVZGW4iwlInFi/C6FH7dCTKS+TGYR8Ktl6ip1qvyFh4cVWF1MBh5
         +UxnpU3bByWpfu7Z5HI2uXaCjUAciqAA8RpG2jobpVAkikxFlaIceW7yyDfeolkUCIGg
         e3TVDWFFTvLMUdECYuJOA1lY3FW8XLnXyXVm7FmntEAvRuaAqHQ4AiGOLDpblwWQQmlX
         TkQ7lBqvHbQM0xmZDnjO2yzJxFWxeUG44IlfiIFeJTJTkRjsWBC8ys8sNSP7SnGw9GDP
         r0w27hsLxzvhT/E7iMBSuAuuHnijRhroUpyVotwy4V6jZs0WrBGn1T9xYRb4k/mrSozB
         ONZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780025; x=1753384825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWmeJ/AYffWPF+7aeLi3O1CN5eBnowfZ5iJlSoV66Ok=;
        b=wR1MQopXXgHvcyXaSiLA+J3uiayszImNJLkMSXIKJLgDQZVUt5Mod9d0g3wL8W7Mqp
         17FOWVBWIAEDf3PwVFBm1OcE1BNE2mHNbnEv0VRfwfO1VI59I9gxlhAU46lkzeGjbW8S
         G3j3oKbvjcTBnlPRqR3OOXlz8cerb1QUD9UIyG617oblI5FZDy+1wguRYa0iPCtsfg5k
         ZAN4yQS753I+gni+jyzisgX1/mncDxCRLjdReLCXClajNfV4mPqUhK7o0yo2jBZNRwP7
         f4Dd+rP/LHg89v2rKkDSmEopqBFQ2A/ujvkqyd7inENyn7IyHZECDSml0UKLqUrUIRaV
         KXXA==
X-Forwarded-Encrypted: i=1; AJvYcCWa6qANJCKzZpqh/z7ji4zUL/2cxD8Tw8RWERdZntFEwYzovkt1SxU/KnmJFDKGskRn1Ys4BefVRkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYYbvo0MARhBZ2AQNgpw+khUMj+x/snhWo7kjuwS6O+30JV21+
	6SDgnCsCWEkzsDomkUvReBGUiMIrR7+qRe8H4QfdbvD9BrKZpDlq4uSaSqKEVva7EGHEfK4la4g
	jZWUYUvPu+288Ib1l7tfQsVxD21ON4fvXRGy+nD7KUg==
X-Gm-Gg: ASbGnctRsTLPB4wYwE4x5JHtlEci8pfxXCUBzFP9xU5VFKC0FkE4qaD0BlBcND59b1n
	4qnggxlgM+gh8kuNmCf3BvSQGRBOF2M/GrP0/wrrK/QJEp4rrLUN7W+/N4bvKFPWgYBc+oHXTEp
	qxpH43V/qZ9Pkpzf2rxShiuVVJU4Cm62yJwolWuYimC+X0WEKSznXdFdqM2aVjgPeV7qI9YBsLk
	akwat1RpEj5WDwTyzEmI1Q5U0hw8lqUz75hn10=
X-Google-Smtp-Source: AGHT+IHBqWiNsRs7vWuJdEggEGVd2H9f8DdxvzoK+Bh6RPSuDwvhNgHoglZoAw8m1co7xPnKhEzvtoGChRKZ44lXf5U=
X-Received: by 2002:a05:6512:6184:b0:553:3178:2928 with SMTP id
 2adb3069b0e04-55a23f1eb8fmr2611071e87.16.1752780025333; Thu, 17 Jul 2025
 12:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com> <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
 <aHfXrT_rU0JAjnVD@google.com> <aHgmzpNzMTL2alhp@google.com>
In-Reply-To: <aHgmzpNzMTL2alhp@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Jul 2025 21:20:14 +0200
X-Gm-Features: Ac12FXzeMHloLpoxCo2SJb7cHfTgSTnMXV5KQxSGs3TLk0VL7h8ZlOyW2yje9eY
Message-ID: <CAMRc=Meepp_5WS2Tdu2gevUbv-_D_Xb-NfAneP5UBYJNck22Vw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:25=E2=80=AFAM Brian Norris <briannorris@chromium=
.org> wrote:
>
> On Wed, Jul 16, 2025 at 09:47:41AM -0700, Brian Norris wrote:
> > (2) Even after resolving 1, I'm seeing pci_free_host_bridge() exit with
> >     a bridge->dev.kboj.kref refcount of 1 in some cases. I don't yet
> >     have an explanation of that one.
>
> Ah, well now I have an explanation:
> One should always be skeptical of out-of-tree drivers.
>
> In this case, one of my endpoint drivers was mismanaging a pci_dev_put()
> reference count, and that cascades to all its children and links,
> including the host bridge.
>
> Once I fix that (and the aforementioned problem (1)), it seems my
> problems go away.
>
> I'll let a v2 soak in my local environment, and unless I hear some news
> from Bartosz about OF_POPULATED to change my mind, I'll send it out
> eventually.
>
> Brian

Hi! Sorry for the late reply, I would really like to be able to assist
with these changes (although Mani is doing a great job!) I'm currently
really busy with other stuff. :( FWIW I just spent 30 minutes looking
at the tree as of commit f1536585588b~1 and I am no longer sure what
exactly did I refer to when I said that the PCI core clears the
OF_POPULATED flag but I'm 100% sure I was facing this issue and seeing
OF nodes associated with a device that's registered without this flag.

Looking at it again now, it's no longer obvious, I wish I had been
more verbose in the commit message. Feel free to try and revert this
change, maybe over a year later it's no longer needed (or never was).
If it is, we should quickly see some issues triggered by it.

Bartosz

