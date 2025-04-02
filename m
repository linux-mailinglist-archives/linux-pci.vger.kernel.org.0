Return-Path: <linux-pci+bounces-25156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE6A78D85
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210931893231
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDAB23645F;
	Wed,  2 Apr 2025 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSOVj4vh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF820F07D;
	Wed,  2 Apr 2025 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594889; cv=none; b=YeksScLq/YXMFned+0IfXbQPySDPgc7TcQ6HiQfyYay9SCjIq0C6i6ceqhyw5INSxYhCbEOkCj5WIY9kpwhoxS1HvRbL2zSuJVcS2mqKuflJqhlghh30HUUouwUmKiNGxu9Byoo6aowDxJVFCubNlyFO4kgR3D9B1h1+gtfJfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594889; c=relaxed/simple;
	bh=wWGayYP/hKKwUZK12OK3t67zfmerVRmMA32CFVG32/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzMrJO87d1LRlhoICyv30ko270IxTolYeDRMiHsiKqTyPTmvw4TDaJgGqjBcYD+WdFpeNk+JQgB0kK06j45rvsY8Fqzlm+EaCxaBDxCq7GP4vbcvB++VCsR9vacnLYgtUtGoYq476IHFwjd3rImUBV5riEvENeL7rnnIRi4scUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSOVj4vh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ebe19489so5506661276.2;
        Wed, 02 Apr 2025 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743594887; x=1744199687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy9/NJXhvn4mIwhmDZnkXdRgiPzF0YdRinTdxKRE0Rw=;
        b=KSOVj4vhqTTnu5K1QPojNIa7RdrQOls6dznf9PXNwHJZl+k9JMRRb8cxy9y9DvwpV/
         gwWUejVzl1JY2MUK/deDqtzPcknd6cbChN0LuSbtojkBk5i0v0gQN5AkQ70K7MXPdDvF
         stBNX72UvVPXpfxVpQ5CIkUu+9pWB8xldYzApSsHdbzzxcK6QopctR8n+nmRJeGzzHmd
         Mhg45WaYgTSYNM05QlOKa40Mu3MMyXwWmBwBPsfn8OTzOBkK7bpNfBimofao3vniN0fj
         FJe61965qVEvhdZvLa8AySKpPEssF2UYYoqJazO0+GxtQ/TUyfxxH0RwK14XQtp+9Z6A
         3BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743594887; x=1744199687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy9/NJXhvn4mIwhmDZnkXdRgiPzF0YdRinTdxKRE0Rw=;
        b=PzPBPHOaENF9NDlikcwQdoCnB0YVDBQz4bhq787QCzigomeFEW9o8V9PROf5aHeITR
         m3N9GZC/RNQwbLePK4xOpRk4eao3mjGv30urWgvGR1IJ4jDuF+iCnYPOytkyP/Pe6LjF
         x1D2irrIkNSZk8JrJeIGRzXvUx9Rgif1+8Tkn+9pRjHW32iOAGSHfbjoCRot9imEpcLx
         y5n/Q4NyoX1xDATHzEZ4FbCDXNfxCnAroO2bmCv6HD8jNcoNm3Vzq1wxmuFg1RTrQI30
         UGHlED78hoSN6uW57kHaQQ/kNZTwv1n56EzenxnzjH0SPZSOVoROxW5TVSbEa0ppaLZb
         vtaA==
X-Forwarded-Encrypted: i=1; AJvYcCUFKwCd89Z/Dsk/LKA0WMxhhrWdLVyNcNFlWYOCj5qXIXNSt5Ai2GbwMP/2ArrTDh4aRjqZpjPEMGbsK7hlo9c=@vger.kernel.org, AJvYcCWk6HG6klR2vZOx2ee6U2/K1yjMyJPsiAG+oizIcQDtAUcf6xmv7njjJI194MsiL6eLhehtEsDszS/dAOg=@vger.kernel.org, AJvYcCWvv7q49mBrRDowbWDTxSxoQuF+oPFIqXaXJBg02dn7h94x04ktV8peyUNcZXYGoJdtAIGrhMFUE+cH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78P4DdpTaSI9hxNh/CAfozld55ihoXKB928IvjApiYfA4AnEH
	dTljXoiN4P+09e6PRHAnJp9pGwI5npY27w7Vm17J5V3ixMro4PL06IppQYM56BZMm4KDu7xImvz
	Sc4IxLiW6kHuqOpUwdIEiV2UESJM=
X-Gm-Gg: ASbGncuyrUTBEG/1YlIIvG4M2T9xbQXhuNYDZL4TwI8xNojy/F+chzlkInTD1DX7eOb
	KKigSh7odJy/3LSreiD2KDLKx3Bx1p94OXRVZMIlr520OYe7tR2tp7hIiW5n9djXGCuvktiBPCL
	o+635r1Vd7yj1n8+jX6w1eyztq
X-Google-Smtp-Source: AGHT+IFNDtBcIAQYO7+mpC5YBdxcpT/tGHFxiQO0PB6nI3IzfmthfCbTHs6kmv4TBqJ5DaKFjmvLCaVtnbat1OZZT2c=
X-Received: by 2002:a05:6902:2289:b0:e69:371d:6861 with SMTP id
 3f1490d57ef6-e6b838d5499mr22764455276.8.1743594886959; Wed, 02 Apr 2025
 04:54:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143646.27678-1-johan+linaro@kernel.org> <20250328143646.27678-2-johan+linaro@kernel.org>
In-Reply-To: <20250328143646.27678-2-johan+linaro@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 2 Apr 2025 13:54:36 +0200
X-Gm-Features: AQ5f1Joz82s1WEmRV4TLp7DwBdkZ7lMGLaFCty5_AWjWPHUmCYB4oGRiYB1dCkM
Message-ID: <CAOiHx=mo6Qd+7WrO2JvBLhqjGR7oHds14FwFFAVoEkVWLnbhdA@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have some nitpicks ...

On Fri, Mar 28, 2025 at 3:41=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Commits b88cbaaa6fa1 ("PCI/pwrctrl: Rename pwrctl files to pwrctrl") and
> 3f925cd62874 ("PCI/pwrctrl: Rename pwrctrl functions and structures")
> renamed the "pwrctl" framework to "pwrctrl" for consistency reasons.
>
> Rename also the Kconfig symbols so that they reflect the new name while
> adding entries for the deprecated ones. The old symbols can be removed
> once everything that depends on them has been updated.
>
> The new slot module is also renamed to reflect the framework name and
> match the other pwrctrl modules.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/pwrctrl/Kconfig  | 27 +++++++++++++++++++++------
>  drivers/pci/pwrctrl/Makefile |  8 ++++----
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 990cab67d413..62f176e42e33 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -1,19 +1,19 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> -config HAVE_PWRCTL
> +config HAVE_PWRCTRL
>         bool
>
> -config PCI_PWRCTL
> +config PCI_PWRCTRL
>         tristate
>
> -config PCI_PWRCTL_PWRSEQ
> +config PCI_PWRCTRL_PWRSEQ
>         tristate
>         select POWER_SEQUENCING
> -       select PCI_PWRCTL
> +       select PCI_PWRCTRL
>
> -config PCI_PWRCTL_SLOT
> +config PCI_PWRCTRL_SLOT
>         tristate "PCI Power Control driver for PCI slots"
> -       select PCI_PWRCTL
> +       select PCI_PWRCTRL
>         help
>           Say Y here to enable the PCI Power Control driver to control th=
e power
>           state of PCI slots.
> @@ -21,3 +21,18 @@ config PCI_PWRCTL_SLOT
>           This is a generic driver that controls the power state of diffe=
rent
>           PCI slots. The voltage regulators powering the rails of the PCI=
 slots
>           are expected to be defined in the devicetree node of the PCI br=
idge.
> +
> +# deprecated
> +config HAVE_PWRCTL
> +       bool
> +       select HAVE_PWRCTRL

I'm not sure this will work as intended. This symbol can only be !=3D n
if anything selects it, but there may also be (outdated) config
symbols that depend on its value. E.g. ath1*k has "select
PCI_PWRCTL_PWRSEQ if HAVE_PWRCTL", and if there is nothing selecting
HAVE_PWRCTL, but HAVE_PWRCTRL directly instead, HAVE_PWRCTL will be =3Dn
and the condition will fail.

Since you rename the only one selecting HAVE_PWRCTL in patch 2/4, but
update ath1*k in 3/4 and 4/4, their select PCI_PWRCT(R)L_PWRSEQ use is
temporarily ineffective. Moving the arm64 patch last would avoid that
though, at least for the current state.

The alternative would be split this by config symbol instead of per
tree, so all users would be atomatically updated as well. These
patches need to go through the same tree anyways, so I see no issue
doing it that way.

> +
> +# deprecated
> +config PCI_PWRCTL_PWRSEQ
> +       tristate
> +       select PCI_PWRCTRL_PWRSEQ

Similar issue, but there are no conditionals based on this, so this may be =
fine.

> +
> +# deprecated
> +config PCI_PWRCTL_SLOT
> +       tristate
> +       select PCI_PWRCTRL_SLOT

This one won't work. Its value will be automatically calculated based
on other symbols selecting it, and since there is nothing selecting
it, it will always be n, regardless what any existing .config says.

So unless you make this a user selectable symbol as well, this will
(potentially) break existing .configs since its value will be then
automatically calculated as =3Dn, and the new symbol takes the default
=3Dn (unless explicitly enabled, or selected by ath1*k).

Best regards,
Jonas

