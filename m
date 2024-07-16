Return-Path: <linux-pci+bounces-10375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F56C932A5E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98471F23BA7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C240198E80;
	Tue, 16 Jul 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PbswgmNY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2319DFA3
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143506; cv=none; b=fiplgVmX0C1hujYcziSTQvvIyNGc5E3fjYu0Zkiwma3oz7ZgPvBqy6BJd1LwxvMh8EMSGz9ibyxed5WXpWxj0t6/j0GwgR1D7jLAgnY2vnHC9IwWw/AL/9EO6CrUzUWTJhMophdEnmP4FM31EqVB/QWDqt8mOWXxnJHC0qZohks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143506; c=relaxed/simple;
	bh=NjzP1bMQDEdZ8Y3JypisVQRpqFiH2CHlcU7GXw/Xtmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvxQ8qA/8NTn+ZxlMInTwgeLDnpPhXSsUjFoEyQwiGOELb5HPXp/xRT9PUwcHsr3XJx1O2qCN5E5cViZmZlhGP1TA6Bdd5cq7zXOKWcvX+Vf6WroXz1uVmvnUYexx20QSRFsGeKUE2dE3EIWsFIc9+cezBHiKseBBR+grotafRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PbswgmNY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso54107981fa.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721143503; x=1721748303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/l3v+ow73zrM4kpAbQAblUkrnJW2lvbcsXrNXGV4iA=;
        b=PbswgmNY0USegl3gx71hxr3Qhp1RmXhMs5jhPDrnhHG/HA/E+GDcBQZIoEAZXhhY7h
         u1UJU12iakl9/rAlLKmHGD3Xq6bxWr4/r4p+4COFjjIzB/3/u/NBWA2p7ibjZZ6oIrK/
         Bed7ZLqy9SuXiRJj8CParfu22naAI3/GBQkGg9oDdEjMHhWKBHF9EDR4Dd6Qmi00dVG8
         p68qy4zodZG39aFZ35InbJQKcw6GwfmstVFOW5G2aXnYGr3P7H1P77emU8dBPGpAyB8B
         OFgZQYSMHkQ+xguoh6E2vZB6ghze0OJhPkNSiiIn/MSIVERL1YAxOvjK2PHlCD4qdDoY
         0Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143503; x=1721748303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/l3v+ow73zrM4kpAbQAblUkrnJW2lvbcsXrNXGV4iA=;
        b=Fq8/sWvg4IJ26pkNEvtbprPqtRS/I6pwcy+amP8Q71CtxbstE6UhtA0NsXGkmH0JJT
         wO50N5JjoY4mYn9bxImKULrnH9N9vop0ge8uTvgePTlfcRoUkP9lk7MlQdWUp5pXWOu8
         k46YcMYOvH78FiwWAdq2WRp8745wuQto/Q9Yzl0i96Xu4mxSbTeZu0ANXAYVYzcI/XRE
         KI9XZC4x7o0jhEtp5FruedX5acyxRGEXpT7oJYO1cSMRIkCl21mLYZu9sBAsIu8D+5i2
         zFuMCI9xPLQqHtWQShsJ4UhD/XlYW1PCk9q7PYeOzBZbbS3Tz+DaVZM7A5x3cemjXioU
         4EOg==
X-Forwarded-Encrypted: i=1; AJvYcCWTW09u0CeHsATINKoFvvxGfLTV3aEl+4roCP+hjjMfw9uDX5o49lr8AIkYresCpUGpo2VfCnk9P5Rrg4hdNP7lohSSW7P8zUKY
X-Gm-Message-State: AOJu0YzaC49aeGQW7U5txu74iUWYVSGWKWl7S/xzK29D3qMDK7nIE0wu
	kTgiOnfG9zOynRULMlja68Qw4oAFuRtzn4a3v9BFXf7mDJJ+Gw/Lh0laKbpJwVvD8xQZ67BHJ+F
	ygjuQ91EVj4ytDPsEM/xv0oXRn8GCqcAKeZA3dA==
X-Google-Smtp-Source: AGHT+IFDnnpQqpID/OidRh6RXRjU6nmcnhy3RVXPOzJzF7xbjujNCFFEfReZ7ian54CghHqW1RiQerJPORDah+zzoX8=
X-Received: by 2002:a2e:b5b1:0:b0:2ee:d5f3:7f59 with SMTP id
 38308e7fff4ca-2eef56ccb8emr6758081fa.15.1721143502725; Tue, 16 Jul 2024
 08:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 17:24:49 +0200
Message-ID: <CAMRc=MfL261fm4p5+RJ-zs4SAMFC0qpNvEM04yOvyrL36C23NQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check for the existence of 'dev.of_node' before
 calling of_platform_populate()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:04=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Commit 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if
> CONFIG_OF is enabled") added the CONFIG_OF guard for the
> of_platform_populate() API. But it missed the fact that the CONFIG_OF
> platforms can also run on ACPI without devicetree. In those cases,
> of_platform_populate() will fail with below error messages as seen on the
> Ampere Altra box:
>
> pci 000c:00:01.0: failed to populate child OF nodes (-22)
> pci 000c:00:02.0: failed to populate child OF nodes (-22)
>
> Fix this by checking for the existence of 'dev.of_node' before calling th=
e
> of_platform_populate() API.
>
> Fixes: 50b040ef3732 ("PCI/pwrctl: only call of_platform_populate() if CON=
FIG_OF is enabled")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/linux-arm-msm/CAHk-=3DwjcO_9dkNf-bNda6bzy=
kb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3bab78cc68f7..12849a164acf 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -350,7 +350,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>
>         pci_dev_assign_added(dev, true);
>
> -       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
> +       if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_bri=
dge(dev)) {
>                 retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
>                                               &dev->dev);
>                 if (retval)
> --
> 2.25.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

