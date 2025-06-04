Return-Path: <linux-pci+bounces-28953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D3ACDAF3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CF8177220
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB6204C2F;
	Wed,  4 Jun 2025 09:24:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53C628A709;
	Wed,  4 Jun 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029087; cv=none; b=Klz8s5CJfSHlTu3INNKsNUdfST2KGMWISgcLD68OMbSDKVODuDIpBVV46PLlXlwPjjDv+DcK6+xS0ZVagunzibNtrIaW8NDJAjtnx9bTa8tN1/z1mYQVZIjmfRqUuPyMxsQ+/SphKzZE09Hfn/DZgVQ9ak01t3lUveROAu0dKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029087; c=relaxed/simple;
	bh=UMOTjEqzvMvXx72TG2/egrmI/Vb+dCYfjfnRgDycRW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ZMcNK10V0Sj6ZCFeC2ns4o3cmQzpEyZTityIJnnzYayPt9GgsqZU5Wk61Sy0K/TlJBCFo9SZU4r+n7emyUATgri5ncGxSWheHiYNXzRo3K2fgWXtegcW3UMVlqZ5aR7ew3INUNwtQ7vEVbRie/YkglQHuqDcapBrSH/ytAw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fac1c60e19so8207906d6.1;
        Wed, 04 Jun 2025 02:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749029082; x=1749633882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsYVl2hdQ/guAvtcE43mR4izrkYEpK8YkARVgLSUAJs=;
        b=DEIkI+24sS0K227ot5XGHU0kdo8CyZIOFsKsSIUb0VHUL3VpCfzAS2xwJzPWBqECr8
         nxZOqfWVo3f8zq6o/9oJJJZW5j+GWE9DTqbHQ550DB+O1HvFT+9qayRO2/rsU9qUEISs
         BxlVRWUaAF1BTnSqCWVS/p/t7+7p7LBRsfGZoBj0E5rBO1fRKRpjAGMsXIau++wR/LNb
         OtFof2peTs8kFaPycN5ryskPT/FQvKhpxKPN5CMBZIE8sOW5kPnes89tGrEjNQXwOMhi
         Rw3yj96FDgtCATOe86zovQ6doi6U9EhFLioQfcn7mg4CUPsH3dQKaUbZHUVVT7ccMIBP
         +bWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6wmeojyo4tn3eDsPuU+pir4ISUzFslxcIhNoXtJfQ+kZ2PssydgDUHz3sS0tnGl2bGXs8GdEPJGWW@vger.kernel.org, AJvYcCVC8x8RtY6UGd4JWw81WlLQCdHcTLP6saJJglqfsCxGvM60pjkaS1cieKgVy7aigJxky4hVkcM1f0Wy@vger.kernel.org, AJvYcCVmYC+LP0/m8xeIyGRL9baoR6a04fSt/oDzWiHDH4ezfegln44ZlxVbe1mUqFJb++X0NsbXrN+2WYL37UQ/CCf4UcA=@vger.kernel.org, AJvYcCX+e+PQFvexGvBatzY87KzJQX4dVIya0G56kcGYzwH236B+rwQL5j3Kp3iMR2nhapc/kB1pQpHdlxTdVukw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjyhn4c4dnmIUonTiSiqBM67skCcb1N6XtOqEJDAyArbVubTjN
	LvZmDk3UVsvKAJWFpC/AfBscN7wa7fsIpMCzc6M+T8Xy34t6Fs7W/Y53OQLNuT42
X-Gm-Gg: ASbGncv1yY72zDEEay8AH2cNH8tLOFSUizKoAh0uIHfpjx2fWN1h0cFkrWg9bF82YTz
	UQID1R4dUqAYci6ftwpH1fWqBFSeME7aCzueSyjHroKnZQt9HLCuq7PtmyXjgjhRAET6cWIm9ic
	4c9mCUxIV+FUnw6BoUFt6OVuMi6IdYvqjK4GwMKyyA7NqeJphAxUmjKEduDbuqe8zman9ArXnkg
	lLbEjZtrvERf4WAwePMOqZc8vDLrtO+DYPbyAUeu3Fo1j0f0jXuN7Vfl8EybR8WSvzjgRraljyw
	sGkncjQ0HJ+a6WKBcYdfJjgDltY1z9G0BPqj2k+zhYUyGq/sGZUE05RgX5cduPWECsIwsUhAosG
	HeptixP62y1iLHNLQSxASVkZ0
X-Google-Smtp-Source: AGHT+IGT3OP0+rx5WJQBf3W0DGO+OAn7Enf3/ZUlZVtRwieI6nS9s+tdM1/nvwscq+eIsAnMSw0s8g==
X-Received: by 2002:a05:6214:e4b:b0:6fa:ae40:3023 with SMTP id 6a1803df08f44-6faf6a6c333mr33366836d6.7.1749029082559;
        Wed, 04 Jun 2025 02:24:42 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fadf67f797sm61657096d6.17.2025.06.04.02.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:24:42 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8b2682d61so8107596d6.0;
        Wed, 04 Jun 2025 02:24:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrP1okLPOIHDZafZHTBWztRzOwpyESJWNmHyteO9VqxXbIWF0FqXiWEQjmrkthoGjRw1KXohIPhnhG@vger.kernel.org, AJvYcCWU0spBZBplT4jDoV8fnY8kj4SglwGKv+mAJ1lq0hiyqGcwEtlleBltKL5KwWdaahK7ptyJ5hKSM5SxOmtr@vger.kernel.org, AJvYcCWquaDkLOLRlyLpxtm/y5ka8O187DMzqDKv+HEEGNLFvs6jL8+JGZ9PD4nc6CLrn99kdem59B3d9Lo8@vger.kernel.org, AJvYcCXOfkwpO3t4Cd5pxrX5BsEo0essd27qC5g36sOgFLMeGsISe9Wn6q+4OP3cYdGXhG1tGSWqF54VGGJkQqpYAm/bti8=@vger.kernel.org
X-Received: by 2002:a05:6102:b08:b0:4df:9aed:3114 with SMTP id
 ada2fe7eead31-4e73612362amr4782752137.8.1749029071180; Wed, 04 Jun 2025
 02:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org> <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250530225504.55042-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Jun 2025 11:24:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVYzaUyP=OUOST8SK66_BpubOh0WCXcaVWBy=RxBrquA@mail.gmail.com>
X-Gm-Features: AX0GCFtylgjPOc_MFC3oHf3t5Dztq8GFmxVQy74EOxxbbt3KzH-GIiIRW1TtAWg
Message-ID: <CAMuHMdUVYzaUyP=OUOST8SK66_BpubOh0WCXcaVWBy=RxBrquA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r8a779g3: Describe split PCIe
 clock on V4H Sparrow Hawk
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sat, 31 May 2025 at 00:55, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The V4H Sparrow Hawk board supplies PCIe controller input clock and PCIe
> bus clock from separate outputs of Renesas 9FGV0441 clock generator chip.
> Describe this split bus configuration in the board DT. The topology looks
> as follows:
>
>  ____________                    _____________
> | R-Car PCIe |                  | PCIe device |
> |            |                  |             |
> |    PCIe RX<|==================|>PCIe TX     |
> |    PCIe TX<|==================|>PCIe RX     |
> |            |                  |             |
> |   PCIe CLK<|======..  ..======|>PCIe CLK    |
> '------------'      ||  ||      '-------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> V2: Use pciec0_rp/pciec1_rp phandles to refer to root port moved to core r8a779g0.dtsi

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I understand this has a hard dependency on [PATCH v2 1/3] (and on
enabling CONFIG_PCI_PWRCTRL_SLOT), so I cannot apply this before that
patch is upstream?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

