Return-Path: <linux-pci+bounces-19712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED071A1025F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 09:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07799163515
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF042500A7;
	Tue, 14 Jan 2025 08:51:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686538FA3;
	Tue, 14 Jan 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844664; cv=none; b=on9wHFL5GjNG/ObWjajxxfHq2mCcQ9CKli5nCqML+xZwxWGxgkCZLa4fAxVpi2B/lo8QvnXGUFjSy2w7m3llkiGdJc47ZDuo2aT788RFjEaPMtqZjy9+8NKDwyriEOqNtmyDudjNb5KVUOR3Fs4rhifaIIeNYZg0Zn6ogkLyBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844664; c=relaxed/simple;
	bh=JRqmTAOBvR+mzBViA4yWgkoc22NIDipxEJJMBadYQnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAmkjklg8kP4Sw3knReER6R5/AVfJEyAfxJKkrCi6AfOgpnnaFbaZ9SLQqFHVQ+AjDx6ZCcCCaIziRItJQ1YnSnCCx+QtQGzANQlOiia6VNIUK0tPS6AJ/Wnn/lknlcLjG1wwsXIefTdPRLO3YuUIdd++c+F4+RdUDk2YGWb6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4aff31b77e8so2094885137.1;
        Tue, 14 Jan 2025 00:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844659; x=1737449459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZapeDv4kpaC5Gk5VUgNaknGqRDxt+j+i6l9YWXwmgk=;
        b=k2zj02I1OAA4PHBU3MHTRJEp5IuYtgTLx8EToNNW+yb5gbkN7ZeRUFvrHn8P9kxEe1
         cWSWtpdlF7yTek203O5V659d2ED0bOussNESAguK+Ro10vWbs/fEKyIHLl2FXvZyL68s
         yUA2ZQYrVAhdWJh2UNXPFtRUnUNquPvIk9F5DpoCsYvb5qBg6x/UVplEOQXkrJas70Vp
         UhXJfcLeKzu3YPgZIROcRZl0zhh74Yosiq7bq4x5oArEw4BHG3DkKY0L1tqqo6p6PPPD
         JtXpPjHAfy76nUQMi2ausiU/xuuO6SoFPs0s1o4lUS6OK4lqCAtOAtV/5nxXkXMz7Cbi
         ++oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYyiThbhv17DyvAG7OIKbo81nfULo+AhbBrRBUNRu2kD27HXAZVA/4zhgTbSpIfZetCIfFi+BZLhU=@vger.kernel.org, AJvYcCVXwU/lSYgVA2AAZD0akfo+/9km/kzqDco3ZpGfXpipaHCG9AZgofc8eeMdCRO9nPkHk2kNjJmNNXUEeIw=@vger.kernel.org, AJvYcCVzgbQzeyYV4HVGGZBX1ZwQMl0wZkkZKVoH/AR7+CjL4prDD7TQsXjdm28AGXHyz8MZ7XXccMKZxZWN@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkOnBIG17dS5vqosVobj+gYEFnPUYIEdGyUuSe8NJUm6Mt2SN
	42rgzEw6a/zi7UXpasdGGi+70IBITEs86W7YIGUbl3jpgW7OiCks+pxBe+tLvY0=
X-Gm-Gg: ASbGncutPaDvrowb6JXMLIQkbrY4lMrytW1r5YCUm46yW5AarRQu6rKWzvtJA3eq8yR
	qYivLxnCam4mwNuObuIXrd3jFnbXU42m2Acc6ArNRnL5Ygi+EG0ek5cc+0yl+acGeyRQepJRWe0
	V6rn8VFaQhrqR8Du04TnN1k6YDuSWI472h8Tb/AB9+/l8GkxChG+b7+6by/xQNvTnCewf2BkEiB
	KQalbpCE/DneNc00os7+0ye+Kgf5Zv68FWLh5WlUGkZLmyGPmCN36QoxakxU8B6DjWEBNLbH1hE
	A/0gfr8yQKdXVCW+0i0=
X-Google-Smtp-Source: AGHT+IGjSx6opmTV7Rzh2KU7lkKAF8ale9xwGMxzHelt1NcMKyjyd2vsTqYMastoRgH+6uCtZ1qGdw==
X-Received: by 2002:a05:6102:3750:b0:4b2:5d67:94c3 with SMTP id ada2fe7eead31-4b3d0fc4134mr18849582137.18.1736844659237;
        Tue, 14 Jan 2025 00:50:59 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623134c6b9sm5220941241.1.2025.01.14.00.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:50:58 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso1333673241.0;
        Tue, 14 Jan 2025 00:50:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH/Vsytaw/0kPzr2z5UV4M1IV/7AIsjDW1QNZ5KG2vDjF2nwXnchkXbuKaeeLalKAcpJVAGX4bYH4=@vger.kernel.org, AJvYcCWuR8iwoDoInmIMsScjwdSCoGwBWuw/QcMEubVAo7SQDgrTzxeoaL4IVYrdvBCTgBKUqtudQvDEd5D2@vger.kernel.org, AJvYcCX2l2oj8gbxcVdS1c5q0kAmOlhMFJFmr0D3vQNuNjn0/HYRs+pNEEDClW201Q6dHQDVDR6uu84ZWrIlfJ8=@vger.kernel.org
X-Received: by 2002:a05:6102:d89:b0:4af:bf45:39a8 with SMTP id
 ada2fe7eead31-4b3d0f41da6mr18880384137.16.1736844658081; Tue, 14 Jan 2025
 00:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org>
In-Reply-To: <20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jan 2025 09:50:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtpVTtUEX=hF+r+rt_awk=w8iYWHd5yzZYGUpKoyYcgA@mail.gmail.com>
X-Gm-Features: AbW1kvYO1dSgvIgmXpf3X7_IJcFWeR2PErQvf8ZhVlDPZnKWck-RCDeidez29AE
Message-ID: <CAMuHMdVtpVTtUEX=hF+r+rt_awk=w8iYWHd5yzZYGUpKoyYcgA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/portdrv: Disable bwctrl service if port is fixed
 at 2.5 GT/s
To: Niklas Schnelle <niks@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, "Krzysztof Wilczy??ski" <kw@linux.com>, "Maciej W . Rozycki" <macro@orcam.me.uk>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:56=E2=80=AFPM Niklas Schnelle <niks@kernel.org> w=
rote:
> Trying to enable bwctrl on an Intel JHL7540 (Titan Ridge) based
> Thunderbolt port causes a boot hang on at least some systems though the
> exact reason is not yet understood. As per the spec Thunderbolt PCIe
> Downstream Ports have a fake Max Link Speed of 2.5 GT/s (USB4 v2 sec
> 11.2.1):
>
>    "Max Link Speed field in the Link Capabilities Register set to 0001b
>     (data rate of 2.5 GT/s only).
>     Note: These settings do not represent actual throughput.
>     Throughput is implementation specific and based on the USB4 Fabric
>     performance."
>
> More generally if 2.5 GT/s is the only supported link speed there is no
> point in throtteling as this is already the lowest possible PCIe speed
> so don't advertise the capability stopping bwctrl from being probed on
> these ports.
>
> The PCIe r6.2 specification section 7.5.3.18 recommends to primarily
> utilize the Supported Link Speeds Vector instead of the Max Link Speeds
> field to prevent confusion if future specifications allow devices not
> to support lower speeds. This concern does not apply however when
> specifically targeting devices claiming support only for 2.5 GT/s.
>
> Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
> Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe =
BW controller")
> Tested-by: Niklas Schnelle <niks@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Niklas Schnelle <niks@kernel.org>
> ---
> Note: This issue causes a boot hang on my personal workstation.
>
> While there is an ongoing discussion about generalizing this to all
> devices with a single supported speed. It turns out however that in my
> case dev->supported_speeds incorrectly claims 2.5-8 GT/s requiring
> a seperate second fix. So in the interest of simplicity and because I'll
> be out from the 19th until January, I'd like to propose to do this simple
> fix to the boot hang now and take the time to figure out a more general
> approach afterwards.
> ---
> Changes in v2:
> - Improve commit message to mention the specific controller and
>   why using the Max Link Speeds field should be fine here.
> - Add a comment (Lukas)
> - Add R-b's (no change to logic).
> - Link to v1: https://lore.kernel.org/r/20241207-fix_bwctrl_thunderbolt-v=
1-1-b711f572a705@kernel.org

This is now commit e50e27a613db6f18 ("PCI/portdrv: Disable bwctrl
service if port is fixed at 2.5 GT/s") in pci/next, which conflicts
with  commit 774c71c52aa48700 ("PCI/bwctrl: Enable only if more than
one speed is supported") in v6.13-rc4.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

