Return-Path: <linux-pci+bounces-30715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C192DAE9B48
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98AB7B56F3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C5926B77C;
	Thu, 26 Jun 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPszLtAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7126B94E
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933633; cv=none; b=q7SjPo9PO4ZcHqTyciUCEG+9a/DTG/rax05H086xGlMpKzWJICIB6H9gswwBxRowWPVOYF389yKLTUc0+C0zAj3rxL5r0bON5RwET7VOaTnp154R/HTABqlVqtiYWEXbpxhv0I6PI2Xl4gmj5QDU7SKILCJ1hTrnYkPHAll4Bf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933633; c=relaxed/simple;
	bh=wXor+Iu4ZqX+8KR5rS7jShl7KiOg0hIycr4pUXG2LA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aofIyozrJHPz74Oee+a055XNAPPvZTW2WhMxy3eiU0A7HzYOD6p+Zf4FTqE7/Z6W4f+KERMz1pPA/UJcicyF+wBIfImCOa7c9IsOnyhLckwtSjyqrYrc/oF6cnmEc8Jp4ZzIs9YE9PZUGMYc2aAJMW7QnzJh4fN4uo3rE3ZKGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPszLtAX; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81826d5b72so616576276.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750933630; x=1751538430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tC4oe5CceAg11SZ/GxR4A1Su4YWoGCi7TQKuNigj2uY=;
        b=HPszLtAXKaje4cfy1nx706etbFV2RTzx7eiMr6G1wM00CrpXIBb0glfzTlxUTD0TAH
         AIl9F1h+AS7DVFfrc2tFWW7JiKWKnwdqVkXzY+mbmD8Pco8lEhtfrAiapatv21iJXC/c
         8R9sIqHv13M8lphEskFCMh54QGsWMWBYnyVkdxHjysA8h26etKrhVKGmVpQ3mRj6NABK
         hz1qSqsMXsw1V9rTkwK/mRanRoBE0NNmbdgJ9qWg+zTHxbxODmpfwwGbOwMbeqpT+PU5
         1sKx3dYMXpmXwSLWzMQAn2+nSL8PbUgZ8ppSp3AcgjrvZdsygLZN1udpW1bifsempTm0
         gpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750933630; x=1751538430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC4oe5CceAg11SZ/GxR4A1Su4YWoGCi7TQKuNigj2uY=;
        b=baQFr5tG4I7ZNcwtG7T7lbc2DExiEAxprEs2JpNT9Ck4EzdVRItqYACZsS7I6h7nt2
         kVzimAZCYEaPOGuoUdQCSJfhzywq1KBe1+mQ3dR7nNIO1NKRQW47OrlyCoeqAWXjYHgu
         kmDkF9ViVgNZXklQxqg6kc9YOBVckMFAn5ko9mGQntw2ydRE9+IBKjm5VLx5sbsmrvuV
         0BNDxObxRA40y1Pxx3e5vnIr+E9+y3xGfaXORh+ubVGhUsQPock+4iOYQhopb+RzgftY
         glYXIgP4DiaX68G+z1AgbOmudJn8/42rS9oRTCBOGsaRIixR5J6D7kzfHuImj4RvxFnQ
         JWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVq2Xx01O/HFglUGUonrwZz1G7zjktMiGk0FSuVopEuMzLvRNDDdDptrJxMnhXmQ4fu5kWmcGl7j/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIdTgBpMv/g0nF34lEweortO7SiCkf0vsU7MTMFhCkr54RtuA
	aRA4AodcZUxxN/qCZU0xBDuWP+BI0KZR+TgZvehYcPR1IXLmSkn7jzh9QlCBP+pnsupXIc7ciSj
	wPapnuMygCWy4o6clqXFqKtJBoWcu2m7tYrtfk1d8jA==
X-Gm-Gg: ASbGncuYDp3XkPrbdz2RImaPost/zUl/difMms0r3XG6GwetJ4tDV7bZweeaaN3N49a
	EV5YKoD4bqFyctIh65i+BH5Vnq4JpGxUnxnaVdqH6/8GuA9Dn1mW8ULe1vq+lpQ6c948wJqflm3
	uhFzZMn21d6z0txEf7L/+hu/4nlvJ1Im7bheT0mNwIlZmi
X-Google-Smtp-Source: AGHT+IGxNrLa6fzp3dATT8WqE5Ge3MnCPt0sfiGJHFrcqs/3wlCuQT2HFWBcurUCyGXwJjSYlm1Efl+nkkyoah0fDOA=
X-Received: by 2002:a05:6902:1106:b0:e7d:ca03:4474 with SMTP id
 3f1490d57ef6-e860177d4cfmr8481272276.36.1750933629782; Thu, 26 Jun 2025
 03:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <1847016.VLH7GnMWUR@rjwysocki.net>
In-Reply-To: <1847016.VLH7GnMWUR@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:26:34 +0200
X-Gm-Features: Ac12FXw4MkHlXtc5UB46tZcXfZhtWkugMv31joFE6m6KalHIU0zcpnVSriOLTD8
Message-ID: <CAPDyKFr8LpkR+DK2suNzGaBzuQ+gohYML4TC-FS+oCUWr6TTzA@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] PM: Make pm_runtime_force_resume() work with DPM_FLAG_SMART_SUSPEND
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Curently, drivers using pm_runtime_force_suspend/resume() cannot set
> DPM_FLAG_SMART_SUSPEND because the devices with that flag set may need
> to be resumed during system-wide resume regardless of whether or not
> they have power.needs_force_resume set.  That can happen due to a
> dependency resolved at the beginning of a system-wide resume transition
> (for instance, a bus type or PM domain has decided to resume a
> subordinate device with DPM_FLAG_SMART_SUSPEND and its parent and
> suppliers also need to be resumed).
>
> To overcome this limitation, modify pm_runtime_force_resume() to check
> the device's power.smart_suspend flag (which is set for devices with
> DPM_FLAG_SMART_SUSPEND set that meet some additional requirements) and
> the device's runtime PM status in addition to power.needs_force_resume.
> Also change it to clear power.smart_suspend to ensure that it will not
> handle the same device twice during one transition.
>
> The underlying observation is that there are two cases in which the
> device needs to be resumed by pm_runtime_force_resume().  One of them
> is when the device has power.needs_force_resume set, which means that
> pm_runtime_force_suspend() has suspended it and decided that it should
> be resumed during the subsequent system resume.  The other one is when
> power.smart_suspend is set and the device's runtume PM status is
> RPM_ACTIVE.
>
> Update kerneldoc comments in accordance with the code changes.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |   38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1964,10 +1964,6 @@
>   * sure the device is put into low power state and it should only be used during
>   * system-wide PM transitions to sleep states.  It assumes that the analogous
>   * pm_runtime_force_resume() will be used to resume the device.
> - *
> - * Do not use with DPM_FLAG_SMART_SUSPEND as this can lead to an inconsistent
> - * state where this function has called the ->runtime_suspend callback but the
> - * PM core marks the driver as runtime active.
>   */
>  int pm_runtime_force_suspend(struct device *dev)
>  {
> @@ -2014,20 +2010,28 @@
>   * pm_runtime_force_resume - Force a device into resume state if needed.
>   * @dev: Device to resume.
>   *
> - * Prior invoking this function we expect the user to have brought the device
> - * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
> - * those actions and bring the device into full power, if it is expected to be
> - * used on system resume.  In the other case, we defer the resume to be managed
> - * via runtime PM.
> + * This function expects that either pm_runtime_force_suspend() has put the
> + * device into a low-power state prior to calling it, or the device had been
> + * runtime-suspended before the preceding system-wide suspend transition and it
> + * was left in suspend during that transition.
> + *
> + * The actions carried out by pm_runtime_force_suspend(), or by a runtime
> + * suspend in general, are reversed and the device is brought back into full
> + * power if it is expected to be used on system resume, which is the case when
> + * its needs_force_resume flag is set or when its smart_suspend flag is set and
> + * its runtime PM status is "active".
> + *
> + * In other cases, the resume is deferred to be managed via runtime PM.
>   *
> - * Typically this function may be invoked from a system resume callback.
> + * Typically, this function may be invoked from a system resume callback.
>   */
>  int pm_runtime_force_resume(struct device *dev)
>  {
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!dev->power.needs_force_resume)
> +       if (!dev->power.needs_force_resume && (!dev_pm_smart_suspend(dev) ||
> +           pm_runtime_status_suspended(dev)))
>                 goto out;
>
>         callback = RPM_GET_CALLBACK(dev, runtime_resume);
> @@ -2041,8 +2045,20 @@
>         }
>
>         pm_runtime_mark_last_busy(dev);
> +
>  out:
> +       /*
> +        * The smart_suspend flag can be cleared here because it is not going
> +        * to be necessary until the next system-wide suspend transition that
> +        * will update it again.
> +        */
> +       dev->power.smart_suspend = false;
> +       /*
> +        * Also clear needs_force_resume to make this function skip devices that
> +        * have been seen by it once.
> +        */
>         dev->power.needs_force_resume = false;
> +
>         pm_runtime_enable(dev);
>         return ret;
>  }
>
>
>

