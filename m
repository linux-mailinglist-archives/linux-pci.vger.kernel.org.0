Return-Path: <linux-pci+bounces-14422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77199C25D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F26281303
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A28155C83;
	Mon, 14 Oct 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yW7oWpZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931B155A25
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892762; cv=none; b=beptuiwCwQAPP/xJHgdbmmHeszaveGqTEbnPnLGPeLZLPS7tehIrjhppLbqwaYIuU9STZ1URDRsr1+Sur16nRqf94H1z9FXaSnolKWYpQr95XFUujgeMNzcHptFk/HRxpFxAm3V0TS3NtqWMcBytaTz/K65jM0WJTUTzuwbRVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892762; c=relaxed/simple;
	bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3oTLrFNwCxIMgMZSk0IA3OOA21K9ZlebxWH6WlaUAPbxV0kxQ6I19iV1YiEfLBVsikunLgzy2dWSCRVk+6+1kE793vA3nrFXkmhwsPzG8Ml91bLIZ7XSROM+K6VaZL5FsJB7+T/7B6gtb1JTVpleUABlEduzgGxRo1TAxHFRCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yW7oWpZA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e59dadebso2131541e87.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728892759; x=1729497559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
        b=yW7oWpZA3BTF2qLluR9yNKl8wmcaBX1Ca0r0VcsJjz8TMfs1Q9ltSdkFdoGa0n0gZg
         9vz175ulwvN72ljFMjlXE8Bda7Aq4wDL9T7c5J6rwm35psM+brYjcdbDnERepfTa76V/
         F8QGNrShmfHd4tak/31zRJl7xsCjwl4y3Zm4TS1tLYK5lyLqTAUNRDf29LzLQ/kP1lJv
         D6n53Zv3bAKKSjwrY7AQoH1R6r7ofISZ17sdk8Gux7jvb+M57yd5zH/SeWjbaierGyFG
         DHSpZWXtskUg2d9ZgVE2Atis6F/5bFru7s31ew8AijdX0+ATXXx2TaYS41AhF39aNNjE
         sWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892759; x=1729497559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tVaK1PwUlL+I4aBVzPDvZNVDH6jBwylHdHPE0Qiet8=;
        b=ANY2V7e+BdbqUGBw0cZpH3S2Ral4NAq4vIUBaNkAyb5ld298qPW07pNWnlgohpUSav
         /iPs8t22N37Slq9IVET+MkZvupKL2HTvNAHYO6HwxO7tMCI3b1BVLMQstnbTEkdcTd2b
         dlq+NEzTpAJ9g9scbl5zyA6UWY7EbV1Vx6g6Qh7H35z3BxjxEY8181GDKSeWvjNTJPXs
         /axFKqXsKYK0XzO3NlsF6cAcRF3pgGOQJARgCRGyJTJJKmKzmCwmAvrm8kZrpzVsVk9a
         VF2kbAGarm7he4YC36t5ybeVZ12STAdgQ9PabTSg967JUbcXELskFDz+PRm9YMdJRY8l
         hSrg==
X-Forwarded-Encrypted: i=1; AJvYcCXSdJjye188NhQX1CZyC92Aeq+DQUO49Wu/9GNeIYDqoECzESdQAmoXV1rWxD72UwcKDj6Vfnc0RqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PzUj6iY315YRSkQHV/lsn19B5xEzI5i6k7xyRAFWPNxD0vy2
	+ivtidyrZLiAn25NuIk1FwwOZyZagV1SWYjgJTBE3KfQrPIBfZJ6MZ1AB5W91CBq5dE1JoAawDC
	6icJazI9rSnpqog2gxiJHWO/OxnPMyUl0gu6A4Q==
X-Google-Smtp-Source: AGHT+IEpWHvzePip2AbpOZrDDoOTlWCLBCnZZjhQ7Blogjf+ZP6Ifrw41m8GkUv9NHZszflLIk7m6dG7ATFP47hYxNQ=
X-Received: by 2002:a05:6512:3a8d:b0:52e:76d5:9504 with SMTP id
 2adb3069b0e04-539da3be550mr5304615e87.3.1728892759031; Mon, 14 Oct 2024
 00:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014075329.10400-1-pstanner@redhat.com> <20241014075329.10400-5-pstanner@redhat.com>
In-Reply-To: <20241014075329.10400-5-pstanner@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:59:08 +0200
Message-ID: <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keith Busch <kbusch@kernel.org>, Li Zetao <lizetao1@huawei.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:53=E2=80=AFAM Philipp Stanner <pstanner@redhat.co=
m> wrote:
>
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace those functions with calls to pcim_iomap_region().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

This is part of a larger series so I acked it previously but at second
glance it doesn't look like it depends on anything that comes before?
Should it have been sent separately to the GPIO tree? Should I pick it
up independently?

Bart

