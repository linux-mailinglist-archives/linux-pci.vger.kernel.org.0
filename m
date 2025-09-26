Return-Path: <linux-pci+bounces-37114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1390DBA4B55
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E02A6258C7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416AE3043D4;
	Fri, 26 Sep 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoT0wyb8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99A2F616B
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905314; cv=none; b=HcrtDaGWldWHi5B1FitKGmKopcZ+K9wcwQmddyk40u072nXRzPyZ8D4L3TCElCcL1VYFBXkY/1usMnQQEe/T+ah/oCnMCWDaTDLZ+PeUKS+uHmD7wkNOsCiskBrckNRkL5+Si0x9nPCX+gbYltPo5rqfUWrTwqNRUuEzxMtTRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905314; c=relaxed/simple;
	bh=AZnqdfAmXTllcDi3Twzujw+p767HReUg+7EPXmuH628=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/oTR1I28Q5naM0vIAQmhunJ8t6w69/up3FvC3vCaSkQ10BoToq4pikicTxaR5BDZvldh0OJonk1WD21f2vO7d01hevGRp8j8kBenpD/8GCGm3yV4tRtT4AD2E3J1EI7o/yzL6BddsWBKK+MKCqmQbk+BJs5aMAxcQ1DhIyS/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoT0wyb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46E7C113CF
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758905313;
	bh=AZnqdfAmXTllcDi3Twzujw+p767HReUg+7EPXmuH628=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uoT0wyb8+EotlTCRNvxGW6iFxYGgtrsEmbVcfakHMWIFrApEU8sf/6Nrw/bGI8nDP
	 mkKwt5JVqs8Lu1aaR4fYtRNESc2kWnRr7ccKsJMeMaMi9xxFUu4FqpVVkj1zddLx8J
	 Biuty12MfRmbn5c98e7ZdYuOneavM92JzCbOxSIYtBxGnfFFDdRjqLK+nbxVHT4GSg
	 He4YlXqZ1upUmfdOroAayFp7/wB2xBT+e0PMcUEEP1I+ZlMuyNQW0bfXUBKcLVyBbN
	 8sH1Em9VNY/v5TTNTrj1hCAmW64hfWvU/O5C85swktFCHHJI3joUFRSvcYo7SYs+g0
	 a0sQts7qeborA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30cce892b7dso1560256fac.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 09:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgxV6f8xY3av6ZABDsfJb9ZwVSYqvmj6McFhG5zJmj7MtvQjkf+K4nhdSp68k1Wnt27TYGg7GRLIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZg8HDwgbCfv69TUbqzyFmiTIbIfdWXkzwF+Hycjl24X/CHVZ
	uEVtMifom05R2rWAxF57jCfEqJROiQ9AmG5Yh56LfXBRBSA0OsbBdmumfytHi4A6sRglV67nwC3
	hfEkgAtVhoqA1WdDIgC70SCLrBbXckEI=
X-Google-Smtp-Source: AGHT+IFQQISfNqAJjJL3OPQ0qJUETOCYhtsACvYO34HWfu9x5TF1hVGFvwZM9GCP/oQResGeCcYUThxAP2N+35DWW1E=
X-Received: by 2002:a05:6870:31cf:b0:35b:32d5:8fbb with SMTP id
 586e51a60fabf-35eea9524d1mr4002216fac.37.1758905312998; Fri, 26 Sep 2025
 09:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki> <7855547.EvYhyI6sBW@rafael.j.wysocki>
In-Reply-To: <7855547.EvYhyI6sBW@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 18:48:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gX-uCsq1OWb2DnTo1PBunwuAOyfopLOO7Qo3KsLV4cZw@mail.gmail.com>
X-Gm-Features: AS18NWAlFhczlMle0U4gfQp5x5t4FEY-QQemtRbZyEjuMWVTERCtrm3tG7InkKY
Message-ID: <CAJZ5v0gX-uCsq1OWb2DnTo1PBunwuAOyfopLOO7Qo3KsLV4cZw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PM: runtime: Drop DEFINE_FREE() for pm_runtime_put()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 6:27=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The DEFINE_FREE() for pm_runtime_put has been superseded by recently
> introduced runtime PM auto-cleanup macros and its only user has been
> converted to using one of the new macros, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> ---
>
> v3 -> v4: Pick up R-by from Dhruva
>
> v1 -> v3: No changes
>
> ---
>  include/linux/pm_runtime.h |    2 --
>  rust/kernel/cpufreq.rs     |    3 ++-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -561,8 +561,6 @@ static inline int pm_runtime_put(struct
>         return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>
> -DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
> -
>  /**
>   * __pm_runtime_put_autosuspend - Drop device usage counter and queue au=
tosuspend if 0.
>   * @dev: Target device.

The hunk below does not belong to this patch.  It was added here by
mistake, sorry about that.

> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -39,7 +39,8 @@ use macros::vtable;
>  const CPUFREQ_NAME_LEN: usize =3D bindings::CPUFREQ_NAME_LEN as usize;
>
>  /// Default transition latency value in nanoseconds.
> -pub const ETERNAL_LATENCY_NS: u32 =3D bindings::CPUFREQ_ETERNAL as u32;
> +pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =3D
> +    bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
>
>  /// CPU frequency driver flags.
>  pub mod flags {

