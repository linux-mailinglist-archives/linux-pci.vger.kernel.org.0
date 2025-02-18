Return-Path: <linux-pci+bounces-21729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA2A39C81
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3450E3A83B0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00168264A8A;
	Tue, 18 Feb 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LI1XOXi5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827525A62C
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883013; cv=none; b=SBQwxl0YN0Q3v4EqPLrvD+DFIKPh7O24HfAgzZ/vv5nBPvnHBxJRHQiSYTExhTr4856/HNT6+u7ogG/YgUkAAI5v87uiwp8XrbieKmLLAuqpPeGxYm4vgTbP8aoT3Kc6fHSlKZ/RgxlX+h5QmuXXNY/DAw0R/uQBMANOS8pSUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883013; c=relaxed/simple;
	bh=DSSMR5/oEhrBBxMGuRsitGmxXCXATnKq0oSmeDXTbJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPFT2mQmS4mISrDLhS1mmQgtZ4s8jg5FsLKhYXRcrKYCAIQUhmwAPPVRoRuiYGHXylYqcy5oBU06Noqv4QuNx9xuF7EJx6F9K6BV0x8fxHMWSr6lcvnMnrVdxeP0kZQlwOXkcyEFBtSQPy4+MP4NCF5HadVXWR27tFqX5FugcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LI1XOXi5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4015718276.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883010; x=1740487810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=LI1XOXi5tf3zljDF0S2W8d4a0gEosS7HarkrSAemlYCh41CU7SWjumrljK7DB+dNqG
         ndkGY6MsMzto8nTXbqAtWtlJiIL2sIMhYjR/lJaZR18zJiJXRPGYi8k2byALdl0UGy3v
         Gk3EKDm8mISHW8w2A1vjknH0yO+F77m612hUEjGLLp50UPKtJq+tAYggbTgPmreKc6qI
         Cg04nUgYmvp/PwT7z3pOO1pv8bfSMdUg8YnYShMOvWpyDa+i2HvGe2Iavrx4SuBVWnfM
         H11DFYBxZV037n98jzY3/imgPiGfLYBHoQ+kVhL8LFhe9FXKkiHSrIBhpV6ZV83WzBL8
         iEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883010; x=1740487810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QK+dyc1PR4OboE+3BwHPM5pfaMLTgXZ0OSHSzMoMBf4=;
        b=gAw5OU67lD6oK224cTbqR3kM97DhYeGtPMkIyIxV/YbyLpVdVgFBUzfoCqloWjM/vi
         0CEhnThJEX4N7VSDLBedXmB/t8f9+06j//AUTy6XuNxrunrXYLyqnFIkCRgOEbioJwci
         FRSFglKgncvkdcbvYK0iKsz0R62zJeuKXeuIv3cuIJBbG7713u2s4D+DimCPfveMbsH2
         Y4vHL5wNFk5ByIJrNNAi9LiO4NnsNmawORxmyC5YB7jKb7VSNP55O78o8XQKTf3EsI7q
         TDBDKpZXGHleGDppsWXf6gc6Og6Vj5RKIc5gR5zWDmzHJ+S4WNZVPhg7GUfnObB28yZV
         V06A==
X-Forwarded-Encrypted: i=1; AJvYcCXEPvDFUaSJfCKCK61kKmvKfQvjwt+/liXbJ7Lu/c/RPEjFL4V90hGdtsbLn5tHzDVLVlUgRcI+CU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsgv2d3+gqT44LluGbXcxtYtaH9qed6/II7Dn2kFLphvVRKDct
	/9pN7qHbn7F+wcked10f9Oh5SDheU13LVSDoHbPN//CwikFSLL6Q2AuN9MvfjISQygIZqaQ61su
	BkKeCIKZOrowecE4LejvzRADV+sttOrYGEltabkQJQ8VQZT9XUv8=
X-Gm-Gg: ASbGnctqWwxrdFdvuxX9DUxaHoOvnOJtpcLhqMPgQhLFzu0DybJQzMVJ3cK/VcURjFp
	aM58M6KeMq2ereBMZdh9HZdFGuClnYTi+5F9lF5mHd4ZSTRW6QguA9BrUenS4/rQ/rqZIk80kuw
	==
X-Google-Smtp-Source: AGHT+IGH6vLk+U+IpOyIROSa4vJIPltJqku8QV1ftbJYlBuc7ZpPko6DcHgsxYIF2mNCIF53PQLSxJLqorXWqZRliXg=
X-Received: by 2002:a05:6902:1086:b0:e5d:dcdb:18ed with SMTP id
 3f1490d57ef6-e5ddcdb1badmr6882930276.32.1739883010026; Tue, 18 Feb 2025
 04:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <8497121.T7Z3S40VBb@rjwysocki.net>
In-Reply-To: <8497121.T7Z3S40VBb@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Feb 2025 13:49:34 +0100
X-Gm-Features: AWEUYZmNBflOPEaSpUMJ4BLjpv29L0jW7mM1vQW96k8wGYHbNA9-sC34ojg02fg
Message-ID: <CAPDyKFpp1iuBXZB-T2=hhTND4Z63s7kJfaXWuiKTu1rrqMGc_Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PM: runtime: Introduce pm_runtime_blocked()
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
> Introduce a new helper function called pm_runtime_blocked() for
> checking the power.last_status value indicating whether or not the
> enabling of runtime PM for the given device has been blocked (which
> happens in the "prepare" phase of system-wide suspend if runtime
> PM is disabled for the given device at that point and has never
> been enabled so far).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |   17 +++++++++++++++++
>  include/linux/pm_runtime.h   |    2 ++
>  2 files changed, 19 insertions(+)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1555,6 +1555,23 @@
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +bool pm_runtime_blocked(struct device *dev)
> +{
> +       bool ret;
> +
> +       /*
> +        * dev->power.last_status is a bit field, so in case it is updated via
> +        * RMW, read it under the spin lock.
> +        */
> +       spin_lock_irq(&dev->power.lock);
> +
> +       ret = dev->power.last_status == RPM_BLOCKED;
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       return ret;
> +}
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -81,6 +81,7 @@
>  extern void pm_runtime_unblock(struct device *dev);
>  extern void pm_runtime_enable(struct device *dev);
>  extern void __pm_runtime_disable(struct device *dev, bool regular);
> +extern bool pm_runtime_blocked(struct device *dev);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
> @@ -277,6 +278,7 @@
>  static inline void pm_runtime_unblock(struct device *dev) {}
>  static inline void pm_runtime_enable(struct device *dev) {}
>  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> +static inline bool pm_runtime_blocked(struct device *dev) { return true; }
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
>
>
>

