Return-Path: <linux-pci+bounces-21728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CAA39C7C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 13:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D0816EB57
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005825A654;
	Tue, 18 Feb 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6heF/fB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635072594B7
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882999; cv=none; b=mNNVxIg+JxQQGGAzPKMDIad4frHyYCCTqgEtken0uLFaATYLMj1ocxUd5qROBDpPtL1NQrT1rciEb7wE7YWsrfvBYmdgGv0ycoqaVjIoT6qFx2REtuxxZ38JxCa3WO4QFRMCRRkbCIRMoEmDDIA9jtojf6jR9A32XE/rg64fs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882999; c=relaxed/simple;
	bh=EYXiIhJKzDkf/Zed83KpoEMdqEqpk8RBZccRoSos+zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjiHb09XTXQbV/mF4fDoU5QGUYlr4VhI1sx/TTgQJl14VwtWHZ2EV76UG01H66mX5I3Gq14ldtzVMBRs7HYppAShUyc65aAKpnscgN2SgI9jLc7cpl7+MpM/tY1XCLrW0b06fxMwCgD0mM12FxhEUydYyp+PNBWJKdcDRUk9Rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6heF/fB; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so2709299276.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 04:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739882996; x=1740487796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IiwBH1VwDjX3hwLw759NPJsM3Da1Zq4No+XqAt8EcVE=;
        b=g6heF/fBGLiDZw18AlyiUpOYB8fnjidsa+Wv6quUvseeLJkVzNR5tYB5x2QZHw6ewA
         fcJ+gaUX4kkZ31qVft3u96SH5pBBH3biLXHXR3Ao5IXWypn4mNFPxQJlOLjBvi5RHvve
         TKW49LwE/10VKypTQMxv5PDYa4j1VMhFiKfRz7zVs9SXbIxxDdZzhr7P8X96TJXwglUB
         KoEvznfytbIYa/mfGrpnzqDjMgQaJjhtu+MSaNxhvqBo2nTW3NQE0IM6IcbujdPemdv1
         KURwkp6TVeNNs9CAEKEdAs1ASma2lksSTEbn6fNym1zS+8gPdzysMNWZNWd2VRCKnkNT
         Zm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739882996; x=1740487796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiwBH1VwDjX3hwLw759NPJsM3Da1Zq4No+XqAt8EcVE=;
        b=MAtruKT9IJLzx3ryR7JzYBUev5PM1sSUarm4cZSDnVVn7THR2dgGdpfyk7W0mEBR0S
         JKDGF5MZiHWP9xElIbgiu8FNxLVbm+jgnqQw0KWBB6zATLL43ZCEXIACL8Bu8n/PuTep
         ilkHCIDPlcueeeyBrhvIp8LeVCloNlCdpczFc3oHmjiG/yJvX23vDS6qjj13GQdZHXCV
         CmYV0pwApNvUKkhC2lZ8GwB6E5MZt/YhVkvKzCGP4jqRBzX0Weh+vpDthUWVX9QO1tid
         hmRXXipm5aj9bNJf6P4oUJS4JIWdqk7V6E4mHF+cIRWjyUHvQJfoUVMKj1UgDGUiasGo
         Xf6A==
X-Forwarded-Encrypted: i=1; AJvYcCW2gMO8wOQvA0pzgXK4bedRrCdy2wdGk7YC4IqyvhkCu2VjBPGETDyzq+hUCqiaK4VRDoetd5MKUlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Zs9EDRd1M6VY+EIkybhG6uqHDFCe/KaUH0U3dPVbhukUhv/3
	EH6YlRtUtFaHSjvVvbs/UnI96aHVZHp9Fl2vpASoZb5WgeGC9CU5CRDwZ47CFN3yC7DY7WV2ED3
	DZe4yMWkbE4lWnQG9jL61tTXOY+jhYboJ+qApEn5Otmnj0zXokjs=
X-Gm-Gg: ASbGnculOqCNLGPV4kYlWO1aGX4hhaWizpjCt0ANiJlYEUjlsDbcRhOBL0fQRgVw2O4
	odmpAce6epm/HvSkgwKRyj64HBS9RciEEn8bmI7QhpfUsmQXbeonYJtaB0teVn0XPYZCn2cSBnw
	==
X-Google-Smtp-Source: AGHT+IFV9+p4KGq953gb9Ygs5FJ/2Cq+/II4+fSXpQadcHenCDQI8dVl1agYXuFKW5/2VG+FDeTGo04AqfI0ojx2avw=
X-Received: by 2002:a05:6902:2684:b0:e5b:1c0a:6cb6 with SMTP id
 3f1490d57ef6-e5dc92f3a3dmr9935964276.36.1739882996443; Tue, 18 Feb 2025
 04:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2984234.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2984234.e9J7NaK4W3@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:49:20 +0100
X-Gm-Features: AWEUYZmAiMQQjoSXdJvdY6LlYTyK9cHRbbIMKwfyPB3OyZ8WmWz4Jn-c8CS83kE
Message-ID: <CAPDyKFonaX6gfHgj-OJaowUxhYZR4qQ8EZvvLHfF9AP1GvqrZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: Block enabling of runtime PM during system suspend
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 21:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If device_prepare() runs on a device that has never had runtime
> PM enabled so far, it may reasonably assume that runtime PM will
> not be enabled for that device during the system suspend-resume
> cycle currently in progress, but this has never been guaranteed.
>
> To verify this assumption, make device_prepare() arrange for
> triggering a device warning accompanied by a call trace dump if
> runtime PM is enabled for such a device after it has returned.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c    |    9 +++++++++
>  drivers/base/power/runtime.c |   24 ++++++++++++++++++++++++
>  include/linux/pm.h           |    1 +
>  include/linux/pm_runtime.h   |    6 +++++-
>  4 files changed, 39 insertions(+), 1 deletion(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1109,6 +1109,8 @@
>         device_unlock(dev);
>
>  out:
> +       /* If enabling runtime PM for the device is blocked, unblock it. */
> +       pm_runtime_unblock(dev);
>         pm_runtime_put(dev);
>  }
>
> @@ -1815,6 +1817,13 @@
>          * it again during the complete phase.
>          */
>         pm_runtime_get_noresume(dev);
> +       /*
> +        * If runtime PM is disabled for the device at this point and it has
> +        * never been enabled so far, it should not be enabled until this system
> +        * suspend-resume cycle is complete, so prepare to trigger a warning on
> +        * subsequent attempts to enable it.
> +        */
> +       pm_runtime_block_if_disabled(dev);
>
>         if (dev->power.syscore)
>                 return 0;
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1460,6 +1460,26 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>
> +void pm_runtime_block_if_disabled(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.disable_depth && dev->power.last_status == RPM_INVALID)
> +               dev->power.last_status = RPM_BLOCKED;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
> +void pm_runtime_unblock(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.last_status == RPM_BLOCKED)
> +               dev->power.last_status = RPM_INVALID;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
>  void __pm_runtime_disable(struct device *dev, bool check_resume)
>  {
>         spin_lock_irq(&dev->power.lock);
> @@ -1518,6 +1538,10 @@
>         if (--dev->power.disable_depth > 0)
>                 goto out;
>
> +       if (dev->power.last_status == RPM_BLOCKED) {
> +               dev_warn(dev, "Attempt to enabled runtime PM when it is blocked\n");

/s/enabled/enable

> +               dump_stack();
> +       }
>         dev->power.last_status = RPM_INVALID;
>         dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
>
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -597,6 +597,7 @@
>         RPM_RESUMING,
>         RPM_SUSPENDED,
>         RPM_SUSPENDING,
> +       RPM_BLOCKED,
>  };
>
>  /*
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -77,8 +77,10 @@
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
> +extern void pm_runtime_block_if_disabled(struct device *dev);
> +extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
> -extern void __pm_runtime_disable(struct device *dev, bool check_resume);
> +extern void __pm_runtime_disable(struct device *dev, bool regular);

This looks unrelated to the $subject patch.

>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -271,6 +273,8 @@
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return 0; }
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> +static inline void pm_runtime_block_if_disabled(struct device *dev) {}
> +static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
>  static inline void pm_runtime_allow(struct device *dev) {}
>
>
>

With the minor things above fixed, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

