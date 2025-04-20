Return-Path: <linux-pci+bounces-26315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61593A948DA
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594913B0E63
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E0C1339A4;
	Sun, 20 Apr 2025 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWdVtuhL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959912E5D;
	Sun, 20 Apr 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745173951; cv=none; b=QKJcK1grrJ/EWc6wjbKqCeACSiOJEbXkjtmXKqPap/Lrl52KnXM1hexxoZH8ezaO7YefszwCAxjIgOblF7MPTB58OhHc8/R2QFPz7lgPrRpRtF+9fuMyVakZjNVSHRb3YcCKoqOvH7S6iYZyX59cFSmqe6Ue5uoAyzOgIJeYsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745173951; c=relaxed/simple;
	bh=DFfPSqrpSJBOh0Doj1D5GPz3sZovrvlAbrLj0YUgNSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjFaEQWODr2zhBRffdWKGrq4JSdhOtEHpU5OLyYzusoH10nrJIhexOTOiFCL8oTXBLWavr6SDkSXk/qg5qfDfPjqytGpH2O0ZHiyiQyk2b6G1iDz7cBzEYh6XFl7WTQ5PkqHDlqLj1QLd92mLgqOe9rdbUnjtffAIxJcBrbVSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWdVtuhL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso4689577a12.1;
        Sun, 20 Apr 2025 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745173948; x=1745778748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHMwCYxqYB4K3bjOqiaSP4Irh07mGm4NozXsP5GfdHY=;
        b=UWdVtuhLeEs9Si6tPyldWZzonNhS1AAyH2pe/lwGajKkZLS8JnbetqzJVs8KWbs1yj
         wmqJE+AT6JD4EN0mHZyn5obpzkMrCJAWFWNl5xtzOwUT1/xTdIQlyvSNWeW3nFGWN1Ad
         EsXGcltbv6dVWa0vx7lZ7qsrrSnWyi4U529TQ8QXIcL1mJL9U40277faI15YZlXeIUQA
         08Cwsjm9cLO+m1/P59cqGqmSXuEcmGpLGPyi1BG3r0cBTBhcwTfZvAA/UmHsH9E/TpCK
         olMjTT9eMQfTztsYsD1v9IWqXLCvf8hHkrs/i7ltVWXqTp8PFH1cjLpjr377e0rOo7PY
         xQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745173948; x=1745778748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHMwCYxqYB4K3bjOqiaSP4Irh07mGm4NozXsP5GfdHY=;
        b=qbTwYvfk0tM83EJzHaOdkdYRrH7W1XOsFw3hx3fdpg3scxFlDAcTn1c9h8Mii6mcSY
         tB4JzJ/NsGqj9jwaR9WFC3rxEGP3ZWkdblMcPFXXQ6nJD/kM020GnJ2u7O6KmemGTWUu
         Zj9PVToP5GTNGx136hl03uMzerDZ7LCzraNt7IPA4pOtacE5fytO+bU0PbGPOjhTUw+B
         mBsDPVcQOOeiYVcebB+jtKYchsBiZuOBFrDwjKy2IrkoXxuolu8N4AGTmugv04gEs2EN
         WqYF4oOAKe3dLIAkGiYAzbW7iIH9e1b5rtjmmbpzNcRgFsxMEUw31ZYDCekzQd27eVuc
         XcBg==
X-Forwarded-Encrypted: i=1; AJvYcCW1tRqT5iM1kDTOh284/R53hm+7PpvkKcKrVV7tZKwHBTplS3kOTC/jSIlECKiJsKQt7J5RJm+m2A1u@vger.kernel.org, AJvYcCX+qPdyv5SCzmkarGAVnSJSaQ8j3WkR4lkL1+ZmKmXdgfHJr/rKDOS3Y9JQOHF8tburmznvFCUoZbwwobA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFho1waJasZvjN5xZW4zm0/BMIcKctk+HVhnC2OnNubAiL3YS6
	wpqyG04N/7vWpRHAUXT7bfBA+851cZsKKUnVfHcuFobA1NCSlz2O/8rWDRPn/37QvktuYo/rupf
	S+Gp8AXQkSOFjzYjXmKoKDb4t9h8=
X-Gm-Gg: ASbGncsWTX1k2EJpDqvhmUGPR2CS4JPHc72fsqxfT5S7fzS+7oj0s5a/mzh1eIHRBRg
	VIKMuf8jb31Zzrz/Mp3iBLnTuy9o+3qBi0mFmh9DNzhPtPbeCt5epsO0kIOFYGrYwdr8oAOp3Mr
	khmYa+BOjjpig7CX7bsGWz
X-Google-Smtp-Source: AGHT+IEPnmkH31oj51s5hozVKGyKY4kHpuP56H8iCYA0KDxboPaUS8t/fzUA+hf4uNYOr4Ph2UvpcAYZ+IX+97nC6gs=
X-Received: by 2002:a17:906:d555:b0:aca:b72b:4576 with SMTP id
 a640c23a62f3a-acb74b8e573mr850451066b.33.1745173948216; Sun, 20 Apr 2025
 11:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
In-Reply-To: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 21 Apr 2025 00:02:10 +0530
X-Gm-Features: ATxdqUG-QxcvLxPfRs54ioB0-541ISnYj4P0uxPpXHd3OZ6wOWJhvsW_PVi29sk
Message-ID: <CANAwSgTmmqkphvu=S8Li=O=oGNr2T7Eo8ocZpTx3kNix_CyX2w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
To: Jensen Huang <jensenhuang@friendlyarm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jensen,

On Fri, 28 Mar 2025 at 16:29, Jensen Huang <jensenhuang@friendlyarm.com> wrote:
>
> The order of rockchip_pci_core_rsts follows the previous comments suggesting
> to avoid reordering. However, reset_control_bulk_deassert() applies resets in
> reverse, which may lead to the link downgrading to 2.5 GT/s.
>
> This patch restores the deassert order and comments for core_rsts, introduced in
> commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").
>
> Tested on NanoPC-T4 with Samsung 970 Pro.
>
> Fixes: 18715931a5c0 ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 11def598534b..4f63a03d535c 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -320,11 +320,15 @@ static const char * const rockchip_pci_pm_rsts[] = {
>         "aclk",
>  };
>
> +/*
> + * Please don't reorder the deassert sequence of the following
> + * four reset pins.
> + */
>  static const char * const rockchip_pci_core_rsts[] = {
> -       "mgmt-sticky",
> -       "core",
> -       "mgmt",
>         "pipe",
> +       "mgmt",
> +       "core",
> +       "mgmt-sticky",
>  };

Thanks for this Fix. Could you add my if you can?

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

