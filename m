Return-Path: <linux-pci+bounces-27160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8393AA969B
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68B6189E04D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FE266F04;
	Mon,  5 May 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqCVN/gC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F625DAF7;
	Mon,  5 May 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456574; cv=none; b=jl/GbSFf+ZC+2KFxWjMP5iVzWXtNd0YO2VWG9ZFdzUUKw3OMIwYdTmJUDy6abnIjo/vQKr9+FJv/g5wZ7A93Np9if9rEFUVwLAPLvYkBCeGs5jUkEU7VCTsKSejhZttia+o3ibUg86MtMtWCy1ETy4Z2J226r1B1zxK3B3DmM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456574; c=relaxed/simple;
	bh=LJjgk1ByHDk3YIGGFpQ4kDf+gqIVdRbQZOZxTDiZ9P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW27aJ5lld9Pb+ySkZrI6Zqwalk/rI2YtVZNoub8tLklinuBEzgZU0c2otVdk6XVQYixHgkwTlEMaLDfoEnPE21C3Gtoa/GvQ1WVCyt28flcgTywNNkzjir52xLb9xnnA/4Z+vfLqyzBU+Au6zhkqp7dB+2Qf7mISfBbh4CSFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqCVN/gC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549b159c84cso4958030e87.3;
        Mon, 05 May 2025 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746456570; x=1747061370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWghhPwRQnyBjM4WKGjObPR/MsMSgq7gL+g14y5zD+w=;
        b=WqCVN/gCOqu6z3E9HZu6xQUgjlsEAHO2CCwLwqwuizOlXfPbrt3EC0t3672gcrfeEJ
         xRiYZMdiGPlBOHQdstweHp5XKQ6AGFo7RpCXHKvjoSfZAw00Gwbwd3S8UAPonH/RnHoP
         NSX7+i6rtYu62J2pBxQqV/dVkV74HL/RdRU5ff3CnivuhTDe7PwyHiclzLjdvRGb9oRB
         Y1iw+Aul0r8/i5dGqz90wF1BBaxJ+H+jqmd4mrO3qyx5oLEdVZPbV1pMQFoGZsCQLb5X
         46Ol0ywQyDSWlhnJiUcM9pTEg7ZpHpOWV508GKxS3kebZGtS92cCGPxHcyOnpQrHViLg
         FGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746456570; x=1747061370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWghhPwRQnyBjM4WKGjObPR/MsMSgq7gL+g14y5zD+w=;
        b=s9y4sXvlNiUX0ucq+kI87T4GDg21u62gGe3uQD8ZQv5WyD6nVmASpaF+Vd02My7J8e
         ul0OG4+OF6SNdXgvY5fYunZW4zlbkovIXFABFcrCHIphSCGZToHRUUCK953mV8f03YnJ
         QJu54uAFoS6v1nkxpe1oYOZtkYDFxFEiXR+FRiHX1SjQ3O3rm3ZnON3bssAmbEMypSdC
         XXEKdb6GSPLjj14+3xdSrgDYZrmb9UKv0RTLpztjr0n76LjqWdHa3x70sodenlwh/hdl
         PxClk7m+LIjRH4EC7VDLDXP0aLe4ZbHscnkbM3ZbGKMUeLcc4blPUPJvQzPImmvxUbti
         7CIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPtts+JuXW6/lr9phD3swfPQKWjX5HRuEXoC1c6W13mBRVptBDYeU83hUnFKYzBzuaP+I7UX+Civ58@vger.kernel.org, AJvYcCUbQYdZ22u1gooz23hhXsM+EInmrsrp3l2YUJwqpaBqq+TpK5sD01PUODogpitfYT5MCZEIdpBQcOhyLI0=@vger.kernel.org, AJvYcCVaS9PMK5n9ar5mdlY+S3qWV9q7FKsOe6QUr7y6cpTWGZdScwh+C4xEfD+Rzk4i+fdLOb8Fp0ggr4Ezng0=@vger.kernel.org, AJvYcCWO/fTTKMg7FmxJ7ugTRQp2/OOJ1ZrQftwrZNgTqAj7BZ9AtI0c3VEjj0Tgnep7uLGZiCaKc+7HmXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJhHxIajyGydYgNR9X6c0B9g4sj6U/cYbbt0rPuBuT8nlScrS
	KsDT/yT8riFQCCXbgVlxCfX0RL5dvHFswyU8sg68aAQIR7p3XnXrrrqS0Fqk3G87zGTJ4AOgNxa
	gVPNwYsH/WTxo+JSmFXjZOYeM8TI=
X-Gm-Gg: ASbGncuFh7Pa5LF/U5Rfh/gGMRmxEEsoy/BkF3iS3iElb4pU0ofhsoORBpnWCO8yDXY
	KlmaWunJq8CnoPC43N3E2iIVuYhbgcVb3fmL3U56t1cWTAu7MLi+UVEjSbYp9P/Fo+ME4H91wyv
	91U+IaKkE+T2Zgnt/KH9bktA==
X-Google-Smtp-Source: AGHT+IEgAt9FbQ8bV5flz7Ihpl/0mM8m1B6xfuh4imni31bOSXReD6mr2ZGM91dyNgPK44dVEOZubQ9FH5vIvJsQ+Bg=
X-Received: by 2002:a05:6512:3b9f:b0:549:903a:1bf with SMTP id
 2adb3069b0e04-54fa4f96b5bmr1878098e87.48.1746456569476; Mon, 05 May 2025
 07:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-pci-tegra-module-v3-0-556a49732d70@gmail.com>
 <20250502-pci-tegra-module-v3-1-556a49732d70@gmail.com> <87tt5znqrj.ffs@tglx>
In-Reply-To: <87tt5znqrj.ffs@tglx>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 5 May 2025 09:49:16 -0500
X-Gm-Features: ATxdqUHyohcc7LbeWorAjva_83S_kXGUOo2fo1bPnsNYPXfQukKYy0nLKhMjXH4
Message-ID: <CALHNRZ_ctL1fJGO5752B6XEEXHwRe-a-Ofv+_=qtdq1WWXLLjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] irqdomain: Export irq_domain_free_irqs
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:14=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Fri, May 02 2025 at 14:00, Aaron Kling via wrote:
>
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Add export for irq_domain_free_irqs() so that we can allow drivers like
> > the pci-tegra driver to be loadable as a module.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>
>   https://lore.kernel.org/all/877c33qxss.ffs@tglx
>
> Is it that hard to address review comments?

Sorry, this review comment completely slipped my mind when I went to
work on the others for this series. Will fix.

Sincerely,
Aaron Kling

