Return-Path: <linux-pci+bounces-10387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45BB9330A5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2F1F21071
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79961CAB9;
	Tue, 16 Jul 2024 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qm7qPBQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096861A01A7
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155696; cv=none; b=qv1n48Qs4Cw1hl4Wj+FgBAvZcro1qKRcTl0W7olKoScAl+AliF+tHHtBZh2P001454JXe4GBeeSK+Dl9n5aNSHx51hMV4hljQCzkh5yrBJxEeLl3NLzrb8tUZ71Arjd1RV++0jPe1dkAWC7bu4OeSdjK+AsI10olcGl8gb2FH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155696; c=relaxed/simple;
	bh=X11kgaTdDhmi0C3IZxYTC5o1Z7yzGXY7w5xx+39RX4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+6pfEuuEPzvXDX2DwEPESlWv4+g8YQMbRTRa6aghoteoy9MP5nDqdtQDE9e9ocHKfOxKxBA3jEJXwjoyMLIC+dferuaiBVRqJF35iQh1M60MgDsn65TA1cV3j8+r8PKHbeUHDjOTuwoz82u4XVGc78oitAYThhk+/OZugHJaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qm7qPBQS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so81313921fa.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721155693; x=1721760493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOIRFFMAy+ymDlCZCc5cJzSJew0SEJjSB81xICfFquk=;
        b=Qm7qPBQSEL0rx77QBB9BB6GChZETOq/el9D3wCJTV9C6M2xFi8w1UkSkiNZTNR8PR6
         pExm1PCWrU7/dfHIq63U4Bqv7al77QDTc/m/XXnL0e2S9jV/Y63S2lzJChC6hHuoqayY
         8u16WcxuPYZsx3hJYcUCajlVNdhequKTShnom4V9nFB5ngNdeZJUVf54mvuqGqgYcPOl
         r0vtuzBeamgvg00QNff4DGwP3AvBq2qCqYbAEIRvE+q+jUf4CzDh9S7KsA51BEuq6vsq
         U+SDQeDXzno/8j04T/XMAyzA4Sg24CXmQwdAf5z8o3YMY11wCsQZGAfeq6d2GhjbfrFo
         FlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155693; x=1721760493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOIRFFMAy+ymDlCZCc5cJzSJew0SEJjSB81xICfFquk=;
        b=TXwCeQstXQkMlBGn3OYaTE++ngRJC+eNPALNylgM9lamQAIuh60jqUP2Pu1X3XkjDw
         VWsrmDuAO5UTSLjGE2SydDAA/8OxcE5HO9egyswvcqBxpFYvrEsVScfwFXw/O3QbUoTo
         AxUc01PWWNLQ5lr46Jrq+2oq3diV4lsLpSRUakYSAgXDDXUftOjEuBwPyg+/zrMisKEs
         oH6lbPibVbMPAR0jZ42FMO25gWhwSDdmBw8Z9L5IUIe7PGdDW9XH82J7u/d43loEtwup
         KiBwxn0OIrfUnBZhCOSQNmthgSt3+4T/W5zC5d+e8A1/rHnsvuKPf+fkgY2q9p33mBgN
         +iiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyLQoTr6uK/LnC3YAYDcMaiSlrnt4TELLWZdMUYDH1ZCRQva89cuucHPD5igrV7GR9tOMN19NqKzblMZ9gKJic8+7YhI32w2M/
X-Gm-Message-State: AOJu0YzTim00y97hasBRalxJ8Jbn6McKdvPCIVON4lNAjzUOUJ3pU/p2
	hggoUFH74iTPDNXsvOptzt+uOINh7O/ke1ZLdq7CC/K7h2hLRwuLrKVsGEml9a1KouM3zIJZw3K
	EcpgAuP0ZH0nkkTwCqZ24pCef53z6tTZssBuGkQ==
X-Google-Smtp-Source: AGHT+IEXAQSYmHQAGA83zyqUP4xjyj7ChqZ7HFkW8OFzsMU7WEeq6kHwuFzNS/cTYjdZuODkqgutB6HO1xnuMMd2Y80=
X-Received: by 2002:a2e:9094:0:b0:2ec:63f:fe91 with SMTP id
 38308e7fff4ca-2eef41cc7admr23824741fa.38.1721155692809; Tue, 16 Jul 2024
 11:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
In-Reply-To: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 20:48:01 +0200
Message-ID: <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 8:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 16 Jul 2024 at 08:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > Let's remove the public menuconfig entry for PCI pwrctl and instead
> > default the relevant symbol to 'm' only for the architectures that
> > actually need it.
>
> This feels like you should just use "select" instead.
>
> IOW, don't make PCI_PWRCTL_PWRSEQ a question at all. Instead, have the
> drivers that need it just select it automatically.
>

But this patch does it. PCI_PWRCTL_PWRSEQ becomes a hidden symbol and
the entire submenu for PCI_PWRCTL disappears. There's no question in
Kconfig anymore.

On the other hand there isn't really any driver that would require
this. It's a specific platform that needs additional handling of
resources before the PCI devices can be detected. This is why we do:

    default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)

If we selected it from the ATH1[12]K entry then we'd be building it
for many platforms that don't need it.

Bartosz

