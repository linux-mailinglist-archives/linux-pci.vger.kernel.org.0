Return-Path: <linux-pci+bounces-13834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1D990A83
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76739B214D6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3D1DAC84;
	Fri,  4 Oct 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T40dcfB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E081AA7BA
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064797; cv=none; b=rs2w4cKSb8xTxYfADJO7YUtBqG8yqcKxye7HyLy6uRCgWHEMHJHb8qQ8C2Pn7ozTsBQ3qZlWJl3Z/rChpDs+1MDhK3IdR6Vl+jsUWZW/HuEuXRdXnNMMK4OHCp3AVFvE59nlrAoxGPs4AnsqtobZUoKzbLwOSEe8gk8qT5lbzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064797; c=relaxed/simple;
	bh=inuFU3NXMCe9t8sJPID56GbyaIR3FjwYuD3KDJW0AyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM8CXe/J5BIITyTXxAw8bglveNYRArWFDTOA5bR9pSYGIBlOoKfzcxAaQJVBkJBF18jUnWpSMNiJfhYV7fvcq4hxeF2BZiDMmyZ9XNVvaiKg0TyIUJIAkHfd990jIK2QXEjYjvQlTEk3NVnqZQiF+FwF8SYCCpqzpepUcDv2Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T40dcfB8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso2521557e87.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2024 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728064793; x=1728669593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIc2Q/g7SzIUf5LcQlTpJjF6kt6YPBe5J0bTkqMkNrs=;
        b=T40dcfB8p+1OQXYcJBLq1LnKRinIm1xPRCxHOd0bvQ7vuKOKp17ZYqUPjAc41efDNQ
         WONMm4DGQoVnjumLkuiZAEMumFCIm/xIKs1mP6O/YABc3hv1XSeOovpPJFx3x6HqxcfC
         ySS1Mus6NsHzR4DU/2DBfScjNNj6VxZFs6fvyqo0E3NO3KlQFUzMNiTBcVgHbY+Zr5oL
         injtWkYhdQINmHsAHPNAd7jeOstdpe+dUHZHmgQm6OG0Db8vJ77rk2IKQ0eKzwUXeSja
         PBofJzYmhcTe8FkFW3JVuMQHJkd+WpM4eJg6JfNatf56gQX1K5prly10DYZKr+l+EjUX
         Fg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064793; x=1728669593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIc2Q/g7SzIUf5LcQlTpJjF6kt6YPBe5J0bTkqMkNrs=;
        b=dQwteTlktOXDSrJBzOdN8utpaVdUfEETB/UK7ubBGBWEzcAtN6zmoU+SxDZozuGS0L
         oadHZ/Pbhqvk9xjxOsz63CKZQIrA8mMLwjI0+/9dJiYwKGZli7zWyh8UuEX9DJ80mM3o
         Q8ZVE+wy/ufu2Gk23t+DLyLov7T3As8u5oeVmgoIjFlifPJhwFlSmAXFWYsqjFoR2N6L
         p0ny3ZUzcf4FkzMUKtw0CxSBqhlhTmRbZXnA4GrwoLN6BpOeXUYKfPgIood0iNQguhoK
         Neny/8pBnCh6H1+7t8bgb1bJB78m51zxrL5XV7rEppc2nDIdZHCcGpaYkTupsy3Ejw7S
         7x9g==
X-Forwarded-Encrypted: i=1; AJvYcCWbY8qj8qgIBtaZaUxibZk6N4Iq4wOb9bo0IegZd/GI4rj69vpesxQnx1KuQ0DmAAnYMnyBH4RkPko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdgJvluWuViuF0H2DlFZ3ntkN7TPTbMpeIOK8o+2ratuLu4pc
	Fv9kHa9OjkuvdAcEjztt2+RJ3be/icVBNcfMgydvvYE+zfoLd77l60uXvxJ86FgVpHF5XBiD6AM
	0x3Z/qDZ8DIG2wVialf7+kMS5tgYTU9fpywFGKg==
X-Google-Smtp-Source: AGHT+IHHz8Cr6VTmIusVTwt1IY2wWXjjxXJuyGY5S7lxceFUPPBU36GfG5fFHG9WIFrL0iFdylF/a642abnf9QcKd5c=
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id
 2adb3069b0e04-539ab9e6cfcmr2638044e87.50.1728064792965; Fri, 04 Oct 2024
 10:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004125227.46514-1-brgl@bgdev.pl> <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
In-Reply-To: <rog6wbda7rdk6rebjyprnofgz4twzpg6kt4pnmeap4m4hga532@3ffxora5yutf>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Oct 2024 19:59:41 +0200
Message-ID: <CAMRc=MekMuV6ULeX_x8mgQiL=XoHuH3PrJLihqucWqowN-YRLQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: abandon probe on pre-pwrseq device-trees
To: Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:31=E2=80=AFPM Bjorn Andersson <andersson@kernel.or=
g> wrote:
>
> >
> > +     /*
> > +      * Old device trees for some platforms already define wifi nodes =
for
> > +      * the WCN family of chips since before power sequencing was adde=
d
> > +      * upstream.
> > +      *
> > +      * These nodes don't consume the regulator outputs from the PMU a=
nd
> > +      * if we allow this driver to bind to one of such "incomplete" no=
des,
> > +      * we'll see a kernel log error about the indefinite probe deferr=
al.
> > +      *
> > +      * Let's check the existence of the regulator supply that exists =
on all
> > +      * WCN models before moving forward.
> > +      *
> > +      * NOTE: If this driver is ever used to support a device other th=
an
> > +      * a WCN chip, the following lines should become conditional and =
depend
> > +      * on the compatible string.
>
> What do you mean "is ever used ... other than WCN chip"?
>

This driver was released as part of v6.11 and so far (until v6.12) is
only used to support the WCN chips. That's not to say that it cannot
be extended to support more hardware. I don't know how to put it in
simpler words.

> This driver and the power sequence framework was presented as a
> completely generic solution to solve all kinds of PCI power sequence
> problems - upon which the WCN case was built.
>

I never presented anything as "completely generic". You demanded that
I make it into a miraculous catch-all solution. I argued that there's
no such thing and this kind of attitude is precisely why it's so hard
to get anything done in the kernel. I made it *generic enough* and we
can cross any bridge requiring new features when we get to it. This is
why we have no stable APIs in the kernel! And why every long-lived
user-space library is at major API version 2 or 3. You can never
possibly get *everything* right.

Also: there's a big difference between the framework and this driver.
A driver is just a consumer of the larger framework. We could possibly
make it WCN-specific and create a new one for QPS615 (even if it was
to use pwrseq as well) instead of cramming a solution for every
possible corner case into a single compilation unit.

> In fact, if I read this correctly, the second user of the power sequence
> implementation (the QPS615, proposed in [1]), would break if this check
> is added.
>

Is it queued for v6.13 yet? If not, then we make no guarantees. A
regression is when something upstream stops working, not when
yet-unmerged patches from the list do. Have you really never had to
modify existing code to accommodate new one?

This is a fix that needs to go into v6.12 and be backported to v6.11.
Hence a simple patch. For v6.13 we can easily extend the match data to
become a structure indicating whether we should do the check or not.
That's a really simple change too. But it would grow the fix
needlessly.

> Add to this that your colleagues are pushing people to implement simple
> power supplies for M.2-connected devices into this framework - which I
> can only assume would trip on this as well (the one supply pin in a M.2.
> connector isn't named "vddaon").
>
> [1] https://lore.kernel.org/all/20240803-qps615-v2-3-9560b7c71369@quicinc=
.com/
>

I'm not sure what exactly you're referring to here.

Bart

