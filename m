Return-Path: <linux-pci+bounces-14448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893299C9F9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1FB1C225B6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5B19F13F;
	Mon, 14 Oct 2024 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2vg2pIq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896B1A38D9
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908508; cv=none; b=HwUAYQvCXm5a9BCdrh6WQzzb0ZV93mE4RWsnTCPM4l/OlHYxCqXnrS9pEHv65M6rjf9LWEKpUrC3vitf+A9r2wl0FikO7p5X7ak+xe1KxC+dcD0Qmv/kmrS4UdG9ZodhpJlo/JPnYomS+oSiEiHtId404+tnJQohXowbk/8dRuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908508; c=relaxed/simple;
	bh=V4Vs4iRGK5EDUFr0K97ljbVe21sAcMVT5Ca2rjV/LGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5eswSpvwpeod5ABSwDvRjSZcne2NMSIWGJi5mWB8w2BqtX82NFlRGcoMsNZJOH7cDZR7oa6xpkN6qxbjVhTIujgKkD/+XXvTqoMYzer4jxNjq3uFI2/eK6u2/wbqsMfbq/39+jUY6DzSnv2CN5qlYeHuEesMwzsjp2faUGPr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2vg2pIq7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f84907caso895491e87.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728908505; x=1729513305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdIjq9E+ofaWFeYo084HeOgml1TunZeIGKlPscNL9ys=;
        b=2vg2pIq76uHTzZXBdg+2y01GB2Kl2A+DaKKnd1pkc9xHaiY8oppVbppoGJRavf/qBg
         WYyYVzQYc23W//pJMluUrfNwH0bbVWtCBq9xmeHYa8ztn06EkTFYduA3F9/0EGYWqDvm
         z6xhaeFaXRAxkPz9rcKHmehtXP5fuKHhHjBzZVlMxMY+9bsmNQF0dBJgKZyq1wMJeKSh
         x9sOg/aqSzgzlTf4DsO/DVGB2N6ZVkiqbc1HUDoIdKrksOR5d9xpofDgoYWzLtyPrTgd
         Wo3T21tJ3fWz+uKvyjIUzYjk5JDjC0gtLnxKw/j0J3xiIzSOeWvXahY5CQ7NyeqPpCIf
         Z3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908505; x=1729513305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdIjq9E+ofaWFeYo084HeOgml1TunZeIGKlPscNL9ys=;
        b=H48BJFz3g+BbIKiCn3JLJnbJKqRyVgY/tqUk4ykVQ3BEXbOh1eWc9VEUEL/J0HYX3n
         95qC7Ls0INaXfcJcH7nKtAQvFjQ7D0XDOnRYMIbiwpXRZkqdSLOdY1nG2OaiNVhLkrOj
         uTmKPhH+VoihVQee/+kR7zTFIrny01GDLZbMyEMBCkDtlq2QabrfIBYHyU0xJKqV0K4x
         gTO+CsOfQAgkQ8ySbmTLGNlxA9nPfptkEFodb/rpn1W02o1OogD4duP95EQJQC/SM8uY
         gr/GwnVIneNg3xna7YecUBdzUnJOl/6LC+FDXig+IGJ+uPsojBx7yK3i2Y/z4E0dNEnd
         NrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4y3wQQsoVniDPv17jyFAzVNtPUlVv9/1RSfHW9iPtpTVO8TfrBf1dExiOJlxA8z2PP1bSE/t0uHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywro00hNk71K+zthJ4alfg8vW4AZY2dBAJeqHqJjopPgpCCxkcT
	sVnMuLxxxudqU/TpcNmuFNVKTAYGw2a8/qegy4pxpCSWI8E20P1hbdQ6AzrWobzbDQPVwUTO1Qt
	T4SPgvjXNZu6bEKH1FzUU98tLV8WcSYIvs29ulA==
X-Google-Smtp-Source: AGHT+IHratWwYWjuedWOE/8EOjYDbb4mw/kGliv/RMA2yPFekhnQZzILEe2jK1a2h/bA6tQjJ5/6R54bWxH3hy5BiBA=
X-Received: by 2002:a05:6512:4018:b0:539:e776:71f7 with SMTP id
 2adb3069b0e04-539e77673e6mr2623106e87.37.1728908505378; Mon, 14 Oct 2024
 05:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MeUW3jsOPTxxu38+w_ps2FQFYR-PmgGY=V+vjnqNs0RYw@mail.gmail.com>
 <20241012143119.GA604156@bhelgaas>
In-Reply-To: <20241012143119.GA604156@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 14:21:34 +0200
Message-ID: <CAMRc=MfKJWE8BA5hE23fWJ8Sjycz1dwDm_yj73mmqQJjrunfoA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: take the rescan lock when adding devices during
 host probe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 4:31=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Oct 10, 2024 at 11:17:47AM +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 3, 2024 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Since adding the PCI power control code, we may end up with a race
> > > between the pwrctl platform device rescanning the bus and the host
> > > controller probe function. The latter needs to take the rescan lock w=
hen
> > > adding devices or we may end up in an undefined state having two
> > > incompletely added devices and hit the following crash when trying to
> > > remove the device over sysfs:
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000000
> > > Internal error: Oops: 0000000096000004 [#1] SMP
> > > Call trace:
> > >   __pi_strlen+0x14/0x150
> > >   kernfs_find_ns+0x80/0x13c
> > >   kernfs_remove_by_name_ns+0x54/0xf0
> > >   sysfs_remove_bin_file+0x24/0x34
> > >   pci_remove_resource_files+0x3c/0x84
> > >   pci_remove_sysfs_dev_files+0x28/0x38
> > >   pci_stop_bus_device+0x8c/0xd8
> > >   pci_stop_bus_device+0x40/0xd8
> > >   pci_stop_and_remove_bus_device_locked+0x28/0x48
> > >   remove_store+0x70/0xb0
> > >   dev_attr_store+0x20/0x38
> > >   sysfs_kf_write+0x58/0x78
> > >   kernfs_fop_write_iter+0xe8/0x184
> > >   vfs_write+0x2dc/0x308
> > >   ksys_write+0x7c/0xec
> > >
> > > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > > Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> > > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > It's been a week, so gentle ping - can this be picked up into v6.12?
>
> I hoped we could fix the similar latent issues in other drivers, but
> yes, we can get this in v6.12.  Thanks for the hint that it should go
> there.  I'll pick it up when I return from vacation on Wednesday.
>

Sure this can still be done but this patch fixes an urgent issue and I
think it warrants fast tracking it to mainline.

Bart

