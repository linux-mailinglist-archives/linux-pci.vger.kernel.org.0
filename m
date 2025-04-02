Return-Path: <linux-pci+bounces-25135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F35A78998
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2223B1E7A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297E233D87;
	Wed,  2 Apr 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ExeKrk5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976C23373C
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581600; cv=none; b=mW926VjU3oX45pdude7KZNwlxLUi/BLI95oxOtLsKmVCQt2PYAUH3uv9Eiv2x5LujRs6dLuXScpoizUnsh7MlYaBKoBnswpfxBagSf0NdFJ6113RO1mWSSbxucrZmi9Axg2YQFW50M198zf2QFZk3P2GCWo1ZzbvXhJv0DgeTvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581600; c=relaxed/simple;
	bh=w93RkYtfhsYpvj5VoEDDq9lpAvc4F47ifTML7icGMbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIZ4DXjoInFCaGbrtQCBo59RG6JzYL6w+e6f17g60vA+e+Pi8UgNVdfWsmnk4o4BjPg7e4r5M0130qX6R9YGmTeJV999yG4PEdWKNrT5WRUe3Gw76SsuRgqtN/NkaIvBVyoKa5zfNAT6LTTwCAVjiCXLEhyZ+TMFcxRbtyG6UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ExeKrk5M; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfed67e08so65134831fa.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743581595; x=1744186395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5bKkMRbKxlSUJHVqMm4hUmrEWQcNn5FC/pLkQqhEAk=;
        b=ExeKrk5M71A4I/E0XnkK88ktgGsgb1DsyE2/Dxxd+Iti0JcVq0nQUFIffaZxz8kpEW
         rcWaGAqz9bm7QGpP4sIbTW0GTNOb8B7AXw4QL5F4R/Z/RLgwszH+OwfYdrB6m2Un0/51
         VypwSCDr8bWHk0daZ2FNq2O5nu6MJbJRh2DB+B9ntXHgqJEy0Q3i2VWZAiA9Q2cmhgYZ
         M1VQAjPn/FxLqzvAY4pcIRK2m8dTUZHj8iZCQoFZCaTYlZDBf7Usbsg7UImYbLVbNkJG
         XKFLgoVCWYxQY5/P7cJUhL6X4w1tzT7ZX+/SuROS75XutBptZcnIQOaSXI3oqkqSVHom
         2IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581595; x=1744186395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5bKkMRbKxlSUJHVqMm4hUmrEWQcNn5FC/pLkQqhEAk=;
        b=gkCfMKHbjoQD3SWraM22RUXVHoBY4Wpp2F3Z0QhP3LlKK3Yx3dzQVbUEJcKJoSwxt+
         OBrcoiTfqds/Tba/ZUFTkyXJA2zYm6P8GzVsceH6QSJ2aWa2Repk4MhyAX2JUK15Ht8b
         +RssFUmWJTaVcP99YevQz/8lHLdI23ftMERRxF+OsL4GGwrwhnB7rV2BZsYlFeID/YOw
         A4qt3HoHnX0vIMX0VuJkCUPGHkLt9Cdv+76rsOJHBElApVIekciVSKysG6VSXS5aY4pO
         xE5HpaNmaB9QVqd4aDmpyIzqQBOVXQCtwyIB8GZA2PBvgCchHo0rcjGdv+2yrTf7GTha
         z6vA==
X-Forwarded-Encrypted: i=1; AJvYcCWeMv00Odr5lRRKPOBwdL2x90oSC6B/nNArytDni4wrCgyjVeK6ghcf20O5Wdmq4xF9jdCo2u8CKZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsIRNrUu8qJib+MCAOfS4RXBMpFFmeNEgDK2nP+G+uLKnujhI
	YRz/i22P6bMDP47F15WK8Ku2MeyptzKFhJn0Tfc9+YujkjYrWM0tEgzJn+6etKE6LAK8gi5G83e
	WupdhiZaypK2jLX2KvybNkpWTtoWMDPBmJJnG/w==
X-Gm-Gg: ASbGncuT2WXvChQaozF3lMgfkAGXfx6+SRoSTss2vbJiPi/3CoCR7gYnjSGzmIIydRj
	VcCczmEHgBwD2v9QWRm5K6S16BQeVvsmNE6z+vzi2vOANhY8x3y5Z4HyWT2neYoXvR0vlku/NyE
	DjQlLC1ZEpwQ4QGJSg8XDs7LfOkREVMcOuUVdDnY3DMrjQ58JsdAE8KIVQlA==
X-Google-Smtp-Source: AGHT+IFkSOGGYa3V9WycrY+gu8XDZN3eeiEk30gJ0tR1xS7OpisGKyrqxHEtle04WwZppsgW2yf3BQ5HfqnjWB9F/Gs=
X-Received: by 2002:a05:651c:904:b0:30b:ee81:9622 with SMTP id
 38308e7fff4ca-30de035019cmr53207541fa.31.1743581594610; Wed, 02 Apr 2025
 01:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143646.27678-1-johan+linaro@kernel.org>
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Apr 2025 10:13:03 +0200
X-Gm-Features: AQ5f1JoGfVJ9ts98vDCtSYScI8e3HIFmZAN4o5AGXV0GNmnQTKivDH_VGXOT9Xk
Message-ID: <CAMRc=McRPmWu4q9EqYC_3wDCKoniu7Rf308SsKrbCk5rbopFwA@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 3:41=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
>
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
>
> Let's rename also the Kconfig symbols before this gets any worse.
>
> The arm64, ath11k and ath12k changes could go through the corresponding
> subsystem trees once they have the new symbols (e.g. in the next cycle)
> or they could all go in via the PCI tree with an ack from their
> maintainers.
>
> There are some new pwrctrl drivers and an arm64 defconfig change on the
> lists so we may need to keep deprecated symbols for a release or two.
>
> Johan
>
>
> Johan Hovold (4):
>   PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
>   arm64: Kconfig: switch to HAVE_PWRCTRL
>   wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
>   wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
>
>  arch/arm64/Kconfig.platforms            |  2 +-
>  drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/pci/pwrctrl/Kconfig             | 27 +++++++++++++++++++------
>  drivers/pci/pwrctrl/Makefile            |  8 ++++----
>  5 files changed, 28 insertions(+), 13 deletions(-)
>
> --
> 2.48.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

