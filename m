Return-Path: <linux-pci+bounces-41226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF84C5C511
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBCC435B63F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB9305E02;
	Fri, 14 Nov 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJUbhfPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE1235358
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112662; cv=none; b=XnC13CBnn/AcsFUmlxFBouHRSKhwIDl+Uva51ri4WXnb/RiGvgqRt0eyBOt94viyIx1pacKTazfaO9TpRo0jZ2UP9VusnYoeInp3gxroHKSNiN3ANa5RVWmlxrzvmQuRIrT+IEb29M994XVmwBVtXX6zWqDldZCyDEGQWez5B3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112662; c=relaxed/simple;
	bh=z4vfe0YOsLO7B6866/Z7uqgMkZ4yfdSBC06xVdFUy9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQt38iTbun0Oqti6Hkz6Y0thHuYgXz3c/t6wbVPOriFMjEAaZ/6PTre2CxeboIz/w9MjpEYsXfAYwoBbw8+dWjr2UER/Z+gCScH/pubNxzPt5r6KZYNzYC5f72O/adp+7KRBeIdEkXAD95mziF0kkz5RWHqe3S4kJbNqgNj3fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PJUbhfPs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so19548395e9.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763112658; x=1763717458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG1ndTGu7u+afhv3ORckpwAAuy9xCYDjJCa9P3afHXY=;
        b=PJUbhfPsw1jiyAHHlE+dLNv9ENXhHlrUS1nGmsO8nCLwoAszxU9yIdWPUIQMTcSYuL
         e/9bLg8AAwQlYh5USHOEoybJGQ85DOyV8U2iod94n5RVBMEwiXUSue4XMjAB9RewdzCE
         1/EHXVY/jaKZHPQg6sTDNLR7ukk9V/7FNvvEgekGb8jThCTw5a3U8CryLAujvxpPrHGK
         Rw25XXZF3LkjZ3JbU5i9ajqW668WhwRIZtwdzxhp6FeGgT4I39ugCXafYcR0vMlXt2Ko
         YmN/GI3ge8LCVYRPtAGpwxXNgrQnEmXl6gKtKg5tI4i7nSteXXyMhBam6LK3A6ivrXww
         DSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112658; x=1763717458;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uG1ndTGu7u+afhv3ORckpwAAuy9xCYDjJCa9P3afHXY=;
        b=EqTOYcSj0kG+fYBPlLTeq84JH3ljnWW7hqYLs6ElZN4v4laGE0EANCKFzpa9/tNoJ9
         N1Q2DnLhr9lvipqY4wWTpNh5ELc+ySlJnHvv25SMCFBuGV3Q6kalm068OJnDD04CzXTm
         xrAmd0FvZRldowlN24pbvU0WydoK3ADTBwxMNvx1X0H6kkgoHY5P3qZl1FUX8urVeNJg
         76jpy3Ku7Cy1m2r+OuEZqwTj1ikHkhX7iWRGfItQaNMcU8qr2Mosim0NVbjVr+yrxu89
         qxyhWyEUPC5Wux/5WqAQvAmeeLEPaRqNVkMej6EfndzvK27KzQN0IW9WEjD33lhwTLev
         ET/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyCbFQ7IeWlpUHaz22WbCIy+82IpaKyhkTcRtqWer/R0AtyhYxdOZ4T6Vlvj9JwQbCmTjsmpO7uGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9aY1ZSSjNsoAZaNYyT4CxsCEqNyXDGYAjR2H8s7jI4vglQs/z
	bfGem3cavN+q1+VQXuDBoIwSizNQzq5Zg2nZlbSY3kIkFtrsmhnCBSTvuo6X9gfck/s=
X-Gm-Gg: ASbGncvUw6juUuB7EsbYTNJaYmXivmj47k4xNnguP3Q3EjsWG5CIKY0s0mh7mzsir7T
	+c2m/oYDHBZCDpteLFcKwpwCrVQJpcy0g/hnki7udLgmSiuWVbbOBwKkSCXn7De5xgGpcDh6KOl
	zeH1d/3Ne9iOwuGVP+6o6YucMmBetgTqi/Zy8MseRVLu9CNVW7HAY4qxHoqBBbJUmR1HH9pb5vc
	dhDsF5K5i0nc6EyvnexOcpAN4knQAqZqysO87R+acA/OeYJeGOB4XV6zRkE4hJ7T1oIUa8bQ7Ly
	kBY0HR/l5uIRVY15z+NrrXMx6XHIf1RDlTatG71+/0YtzSFRgwCoAKVDhIi9JMwu0T81B1+NRz7
	XtlvruAQbN41+Ofpsotm1Tb+xjJtmnbA1s8/ApGZB4eOM5tSBCPAid9llwyVo5aiZg9bLqFAyVr
	e/
X-Google-Smtp-Source: AGHT+IFJ0DG17bS7Bpxic+Ik1NHnlwSocVb3TsoIa+Uww+ltuZjndP90MdsbrAR2R5TWE+X80Slu9A==
X-Received: by 2002:a05:600c:4706:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-4778fe0e0a9mr20589695e9.0.1763112658371;
        Fri, 14 Nov 2025 01:30:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c897bb8sm77561695e9.12.2025.11.14.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:30:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id DBD265F820;
	Fri, 14 Nov 2025 09:30:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>,  Lucas De Marchi
 <lucas.demarchi@intel.com>,  Alex Deucher <alexander.deucher@amd.com>,
  amd-gfx@lists.freedesktop.org,  Bjorn Helgaas <bhelgaas@google.com>,
  David Airlie <airlied@gmail.com>,  dri-devel@lists.freedesktop.org,
  intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,  Jani
 Nikula <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  linux-pci@vger.kernel.org,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  Simona Vetter <simona@ffwll.ch>,  Tvrtko
 Ursulin <tursulin@ursulin.net>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:17
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 09:30:56 +0000
Message-ID: <87pl9lot9r.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Hi all,
>
> Thanks to issue reports from Simon Richter and Alex Benn=C3=A9e, I
> discovered BAR resize rollback can corrupt the resource tree. As fixing
> corruption requires avoiding overlapping resource assignments, the
> correct fix can unfortunately results in worse user experience, what
> appeared to be "working" previously might no longer do so. Thus, I had
> to do a larger rework to pci_resize_resource() in order to properly
> restore resource states as it was prior to BAR resize.
>
> This rework has been on my TODO list anyway but it wasn't the highest
> prio item until pci_resize_resource() started to cause regressions due
> to other resource assignment algorithm changes.

Thanks I'll have a look.

Where does this apply? At least v6.17 doesn't seem to have
pbus_reassign_bridge_resources which 4/11 is trying to tweak.

>
> BAR resize rollback does not always restore BAR resources as they were
> before the resize operation was started. Currently, when
> pci_resize_resource() call is made by a driver, the driver must release
> device resource prior to the call. This is a design flaw in
> pci_resize_resource() API as PCI core cannot then save the state of
> those resources from what it was prior to release so it could restore
> them later if the BAR size change has to be rolled back.
>
> PCI core's BAR resize operation doesn't even attempt to restore the
> device resources currently when rolling back BAR resize operation. If
> the normal resource assignment algorithm assigned those resources, then
> device resources might be assigned after pci_resize_resource() call but
> that could also trigger the resource tree corruption issue so what
> appeared to an user as "working" might be a corrupted state.
>
> With the new pci_resize_resource() interface, the driver calling
> pci_resize_resource() should no longer release the device resources.
>
> I've added WARN_ON_ONCE() to pick up similar bugs that cause resource
> tree corruption. At least in my tests all looked clear on that front
> after this series.
>
> It would still be nice if the reporters could test these changes
> resolve the claim conflicts (while I've tested the series to some extent,
> I don't have such conflicts here).
>
> This series will likely conflict with some drm changes from Lucas (will
> make them partially obsolete by removing the need to release dev's
> resources on the driver side).
>
> I'll soon submit refresh of pci/rebar series on top of this series as
> there are some conflicts with them.
>
> v2:
> - Add exclude_bars parameter to pci_resize_resource()
> - Add Link tags
> - Add kerneldoc patch
> - Add patch to release pci_bus_sem earlier.
> - Fix to uninitialized var warnings.
> - Don't use guard() as goto from before it triggers error with clang.
>
> Ilpo J=C3=A4rvinen (11):
>   PCI: Prevent resource tree corruption when BAR resize fails
>   PCI/IOV: Adjust ->barsz[] when changing BAR size
>   PCI: Change pci_dev variable from 'bridge' to 'dev'
>   PCI: Try BAR resize even when no window was released
>   PCI: Freeing saved list does not require holding pci_bus_sem
>   PCI: Fix restoring BARs on BAR resize rollback path
>   PCI: Add kerneldoc for pci_resize_resource()
>   drm/xe: Remove driver side BAR release before resize
>   drm/i915: Remove driver side BAR release before resize
>   drm/amdgpu: Remove driver side BAR release before resize
>   PCI: Prevent restoring assigned resources
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +-
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c |  14 +--
>  drivers/gpu/drm/xe/xe_vram.c                |   5 +-
>  drivers/pci/iov.c                           |  15 +--
>  drivers/pci/pci-sysfs.c                     |  17 +--
>  drivers/pci/pci.c                           |   4 +
>  drivers/pci/pci.h                           |   9 +-
>  drivers/pci/setup-bus.c                     | 126 ++++++++++++++------
>  drivers/pci/setup-res.c                     |  52 ++++----
>  include/linux/pci.h                         |   3 +-
>  10 files changed, 142 insertions(+), 113 deletions(-)
>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

