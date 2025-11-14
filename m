Return-Path: <linux-pci+bounces-41254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E0C5E5D6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D323B1E9C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C62BE7B4;
	Fri, 14 Nov 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hERqqFGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88F22A7E6
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139046; cv=none; b=LZRoB8bGgOok2nMzcLjCPjxEgmtreSxKCrJGsdbnK4bISXTZcwPyy15y6L5xkRFrX4Q+X1uGjKny/AAzvyl8PNLeW5H8ZtmgLdq5g1c0CyjqjmSqtXTgakQ12Lk2CWUWzdaL4ZR4+ZbYnYUgvyb+5yjtSTSeC+O6mc/wVRTsLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139046; c=relaxed/simple;
	bh=kRAIXpQL0rtpWzajaSCTkkyqSQYa+ftfCRXl8V2IxE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSXKDAmSjwjjDpPETPfzZItVQDzQEhXW+dUAM18AZv6iF7Cpyx1x5jJeL3h/W6puC7YxJbKAZLk9DGWLrX5PLxw+QntVHVYZiPh5Fi9W0N3LUn3hBfaAdKyqVs+XUNLIvLgk1QcKATOcl2uEQdOSeSS5tOUITcCs+6a60Mm5b/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hERqqFGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500D5C2BC87
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763139046;
	bh=kRAIXpQL0rtpWzajaSCTkkyqSQYa+ftfCRXl8V2IxE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hERqqFGFEWsgElkSKHoC3j1on9AuWyUT+X7M8qrqyZk/7B2v7cHEh9TG2rVvJ+HYs
	 jIBGlJWpjFVbX1ydcmDu8dv3/C9es21yyfhfyU9pm0MA2lioBhf583hiVt6Z8y8F6i
	 ZVjRol18PqFa6pc1htrm5XM4XO4goUKrjBtIlzRd/w1KahXUKEcHW6eQPKmJytK5u/
	 6rJb+DgjrH4T25CH0IJ15rAGsi7LZ2cSIJlO/nJ9Dkn4nsGSvE04Ys43hYA1iAUr11
	 Ww+hEwj40E5tufKCjB4k28M83umiVUO00LTP5BfetaPWVv6mYGHkI9e7owF5/xrTlZ
	 GAaV7Vc71uQ1g==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-44fffff5f73so1611025b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 08:50:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsYvMj5tnyHvXCZjpwKBSgxhgVjdz2om3UTTMYI+7rfzIcaO8Xpp/M0J/UR6FEHCo0ERv4exzXZ5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQM8IwI5sz8mtxGifevCCklAPocwoeANll3ILZapN1eh8s/BJ
	6OMpwdv5CLA+K4W23nGjPKCvRHFUilZpaIxkQ2n0d+RvV4telcQUZE8iQEhLwukxybD5cXF6Bxx
	88sbehg8O6uX0d2oDQ3BCbjHMJGvMRWg=
X-Google-Smtp-Source: AGHT+IEYoY5xYDQM2BBb9X6HkbmqaxbA6wbw9D2hrDeBHcEQWKaobtybIG/1lrjxhUBp4/SMuWImn4eAYFy9CIQanRY=
X-Received: by 2002:a05:6808:13d5:b0:44f:ddf1:f238 with SMTP id
 5614622812f47-4508625eabemr3567353b6e.0.1763139045390; Fri, 14 Nov 2025
 08:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com> <20251107-wakeirq_support-v5-1-464e17f2c20c@oss.qualcomm.com>
In-Reply-To: <20251107-wakeirq_support-v5-1-464e17f2c20c@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 17:50:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jF2DG8Dki8+vVbOR20Z-=5=1XW2AjU05fzQPDJfzhLzA@mail.gmail.com>
X-Gm-Features: AWmQ_bm376pzy83QmYYBd-oR2tNJ4Dlhl0hniQgkzHybVJ8j4IFmpm1XO_r7SUc
Message-ID: <CAJZ5v0jF2DG8Dki8+vVbOR20Z-=5=1XW2AjU05fzQPDJfzhLzA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 10:22=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Some devices require more flexibility when configuring their dedicated
> wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
> This is particularly useful in PCIe systems where multiple endpoints
> (e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
> line which requests platform to re-establish power and reference clocks
> to the components. In such cases, drivers can use this API with IRQF_SHAR=
ED
> to register a shared wake IRQ handler.
>
> Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
> irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
> and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior
> by passing default flags (IRQF_ONESHOT | IRQF_NO_AUTOEN).
>
> Introduce a new API, dev_pm_set_dedicated_wake_irq_flags(), to allow
> callers to specify custom IRQ flags. If IRQF_SHARED is used, remove
> IRQF_NO_AUTOEN and disable the IRQ after setup to prevent spurious wakeup=
s.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++++++++++++=
-----
>  include/linux/pm_wakeirq.h   |  6 ++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b2891f3af490175362cc1a759069bd50..655c28d5fc6850f50fc2ed74c=
5fbc066a21ae7b3 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -168,7 +168,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, =
void *_wirq)
>         return IRQ_HANDLED;
>  }
>
> -static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, =
unsigned int flag)
> +static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, =
unsigned int flag,
> +                                          unsigned int irq_flags)
>  {
>         struct wake_irq *wirq;
>         int err;
> @@ -197,8 +198,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct dev=
ice *dev, int irq, unsigned
>          * so we use a threaded irq.
>          */
>         err =3D request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -                                  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -                                  wirq->name, wirq);
> +                                  irq_flags, wirq->name, wirq);

It looks like IRQF_ONESHOT will always be there in the flags, so maybe do

+                                  IRQF_ONESHOT | irq_flags, wirq->name, wi=
rq);

here?

>         if (err)
>                 goto err_free_name;
>
> @@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct dev=
ice *dev, int irq, unsigned
>   */
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_ONESHOT =
| IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>
> @@ -255,10 +255,43 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>   */
>  int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
>  {
> -       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICAT=
ED_REVERSE);
> +       return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICAT=
ED_REVERSE,
> +                                              IRQF_ONESHOT | IRQF_NO_AUT=
OEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
>
> +/**
> + * dev_pm_set_dedicated_wake_irq_flags - Request a dedicated wake-up int=
errupt
> + *                                       with custom flags
> + * @dev: Device entry
> + * @irq: Device wake-up interrupt
> + * @flags: IRQ flags (e.g., IRQF_SHARED)
> + *
> + * This API sets up a threaded interrupt handler for a device that has
> + * a dedicated wake-up interrupt in addition to the device IO interrupt,
> + * allowing the caller to specify custom IRQ flags such as IRQF_SHARED.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, uns=
igned long flags)
> +{
> +       struct wake_irq *wirq;
> +       int ret;
> +
> +       flags |=3D IRQF_ONESHOT;
> +       if (!(flags & IRQF_SHARED))
> +               flags |=3D IRQF_NO_AUTOEN;
> +
> +       ret =3D  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, flags);
> +       if (!ret && (flags & IRQF_SHARED)) {
> +               wirq =3D dev->power.wakeirq;
> +               disable_irq_nosync(wirq->irq);
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_flags);

Instead of this, I'd introduce

int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq,
unsigned long additional_flags)

that would pass IRQF_SHARED combined with additional_flags to
__dev_pm_set_dedicated_wake_irq() to avoid having two different helper
functions that can be used for the same purpose.

I think that it would be sufficient for your use case.

