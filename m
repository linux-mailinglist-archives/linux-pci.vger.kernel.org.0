Return-Path: <linux-pci+bounces-21080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEE3A2EB24
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E061661A0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842381D5CE8;
	Mon, 10 Feb 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArL8VDkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C58158538
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187134; cv=none; b=bFjewVoLaXrVIdjSV/A4SYUVOaUxPIQ0oIBitbA187dvv4/68lGOqjAkxVaFfNxwmBgLo73fmpoqtLOEUR9O8t+eJJ0H6RWtIR+GCnvjuhRyt6khY5YIxmeGNdYdM4y7gTSuq3PoPGzwnHxpa586xqLhXzCBrYtJumlDQ2+DFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187134; c=relaxed/simple;
	bh=9yL8yKsVg56eXF6gBgrbmMDEHR/t0nnj17bTdgOkCA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3NWDwP4k7FW2WJIwDmhh4kGRHi5NjHWpTt5Q+gzAkZy7V3LHmTbvyzNZUeICY0Q1P8hT/OTXnqAulCt2LHi05pMPefLdp+G0imDbSt2i7bCrQ/Fyb1r0CRQYWMa0QdnKJuzZ3Kv4L6dwHlyFv//OK5WQILVT0cGeESZA++39qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArL8VDkD; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5b4d615362so2241967276.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739187131; x=1739791931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0t7XPMJtnScQiFAUkjXlhhg/FgQ9ukhMGIEHnDiTC8=;
        b=ArL8VDkD1DO0w75b9uzLu1QfVV2U/xSyzaBV9aasCM67TOJJISiMm4JRArMLp4kbm5
         2pRCjQMb99x/eMTAE4xibqfh+FH5/7WzB8Ish83dHkXZx9V62ERD1a6QC9bVubw24C+P
         6q1sqEYDQyGkc8WBtsCC7c3yOVKuR35KCZQr3QEU0PSEtJhVAU178rB31vaYxVi4cDbC
         LOtfcm5yvinCrHifUl+QuxVJj9nvSAeLzmSRepni4R+LRCakkPCzg5jtHmB2HkDqk7Yx
         K0xdgBk4skSLqdXP7oXFhMx4+ilXtNgcJ4Elf+uJv9XEQWk3KZpsRJdjTYl9j1aEsN2h
         f9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187131; x=1739791931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0t7XPMJtnScQiFAUkjXlhhg/FgQ9ukhMGIEHnDiTC8=;
        b=xJ7tgdlfgIMcvRl1Cm0dBuVdp4sOvuZVD9QApUoSKjUpWmZM6J70jxNrvWnXFAgHnm
         ksZ9HuVtB7YDC27tqnToVtly8vHCMnlb/t91C9AkICk5oxeOhNW8ecbyntxBtpF/QB8h
         Mp0XIOzTSaopsAHwpRGYGVq87LnBNio+isuzm2SAwKaBeZMWZU3OreDhxFwsu6z/YgAF
         xxC5m7MXkLTQ5unjwF5Qe5iEaJEhqKcW/AVLrDhoww+yDpvQP7Of3w02uIiWt1tbRsBT
         DjYWK/kZiQuztt/hP/ddh2xHvASQEtR4ex4fJFryG17FeGorLvNQImuDy+oQz4sD63ty
         jTaw==
X-Forwarded-Encrypted: i=1; AJvYcCUfXqj33Ip/qCRBMDPMGYatv8YN6KL7HA6n9bgf7jo8kLkVqOg2uiyu3i/YiOga8CdXg+VsLs6szHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg77u2Xb7D/zAiowMtkn/5UsstI9BVIrkow854YsFSZXmvpGf9
	6yHdc3vyfpWeOd+zgrAZAWFYh/FVDRhG/HnDlCJlABwRaTu/WHgMj9hDeNx69o6/iLTREbE3XXa
	muWOmgD5UHMtodzdb4cvTKxUL3KbygZJ7LEulHw==
X-Gm-Gg: ASbGncu4QHm0wDn3eH9GEJFjiF35csT0vNPlCfIXroiv9xa1HfKFCpg2nwhfqlo0Xsv
	kSxJmDFiwoY2lAjpI21w7TB4+fMxcRIz8QzL59QUSRTBSVG7BWRlPUHS7MTv0P/Z9XHRZGDBcsw
	==
X-Google-Smtp-Source: AGHT+IG0aR9/4plkySCbp1bqTtI82MdpqrOiHVZLPWZsEQ6ce+6yiD5Wlvdmwvaf0DBMBOWwyD2Skk7a8hAGjrj5wzE=
X-Received: by 2002:a05:6902:32a2:b0:e5b:54b0:6ad5 with SMTP id
 3f1490d57ef6-e5b54b06b74mr5887024276.43.1739187131488; Mon, 10 Feb 2025
 03:32:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6137505.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6137505.lOV4Wx5bFT@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Feb 2025 12:31:34 +0100
X-Gm-Features: AWEUYZmHSQbQffF7_ka9s0NS0kXgD2P_JnaSOcnNvX6dibEuupIM41BukF4WqIA
Message-ID: <CAPDyKFqEK3jBQxmuGTRHGHgyNUY+veE+iiujgcJpyOuLjw0vBg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Restrict power.set_active propagation
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 18:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of
> parents and children") exposed an issue related to simple_pm_bus_pm_ops
> that uses pm_runtime_force_suspend() and pm_runtime_force_resume() as
> bus type PM callbacks for the noirq phases of system-wide suspend and
> resume.
>
> The problem is that pm_runtime_force_suspend() does not distinguish
> runtime-suspended devices from devices for which runtime PM has never
> been enabled, so if it sees a device with runtime PM status set to
> RPM_ACTIVE, it will assume that runtime PM is enabled for that device
> and so it will attempt to suspend it with the help of its runtime PM
> callbacks which may not be ready for that.  As it turns out, this
> causes simple_pm_bus_runtime_suspend() to crash due to a NULL pointer
> dereference.
>
> Another problem related to the above commit and simple_pm_bus_pm_ops is
> that setting runtime PM status of a device handled by the latter to
> RPM_ACTIVE will actually prevent it from being resumed because
> pm_runtime_force_resume() only resumes devices with runtime PM status
> set to RPM_SUSPENDED.
>
> To mitigate these issues, do not allow power.set_active to propagate
> beyond the parent of the device with DPM_FLAG_SMART_SUSPEND set that
> will need to be resumed, which should be a sufficient stop-gap for the
> time being, but they will need to be properly addressed in the future
> because in general during system-wide resume it is necessary to resume
> all devices in a dependency chain in which at least one device is going
> to be resumed.
>
> Fixes: 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of parents and children")
> Closes: https://lore.kernel.org/linux-pm/1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com/
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1191,24 +1191,18 @@
>         return PMSG_ON;
>  }
>
> -static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
> +static void dpm_superior_set_must_resume(struct device *dev)
>  {
>         struct device_link *link;
>         int idx;
>
> -       if (dev->parent) {
> +       if (dev->parent)
>                 dev->parent->power.must_resume = true;
> -               if (set_active)
> -                       dev->parent->power.set_active = true;
> -       }
>
>         idx = device_links_read_lock();
>
> -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
>                 link->supplier->power.must_resume = true;
> -               if (set_active)
> -                       link->supplier->power.set_active = true;
> -       }
>
>         device_links_read_unlock(idx);
>  }
> @@ -1287,9 +1281,12 @@
>                 dev->power.must_resume = true;
>
>         if (dev->power.must_resume) {
> -               dev->power.set_active = dev->power.set_active ||
> -                       dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
> -               dpm_superior_set_must_resume(dev, dev->power.set_active);
> +               if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
> +                       dev->power.set_active = true;
> +                       if (dev->parent && !dev->parent->power.ignore_children)
> +                               dev->parent->power.set_active = true;
> +               }
> +               dpm_superior_set_must_resume(dev);
>         }
>
>  Complete:
>
>
>

