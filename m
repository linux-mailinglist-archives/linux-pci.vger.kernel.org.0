Return-Path: <linux-pci+bounces-39310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45BC08DEC
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108BE1C805A8
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB6280035;
	Sat, 25 Oct 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpChKIl3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725B271476
	for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381484; cv=none; b=A7jZhkl0cny4ECRZg+9+/SSYHH+H+k+hMoBs2NHuMzgD3KeR0xNjNnFCcR6zKkB9nAqv/sOmGSrtSRzqwN7d0cGboDTq3cAtbP84bXZhtQ2z8OypB9P4nzTWod2m2hjdhNHjl1jij6akxq2FMuTmxoo5QTzSm06dx4q6LtPvJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381484; c=relaxed/simple;
	bh=811uHJZ37wZfACPU1YGuEeWKbSyaapCx8BFKBu79UWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaIWGbEdGZvf3WRNs/JJjFGJMhNvrkYWgSqoCrMNYrILVhqZbUBWXcv9H7Izt4Usi7g8oL3xBiNVVdGOeJNvlCGhYywEidZ7rF+gjiLW/WTuSdUVvjG1H/a6/D0ZQGSTIkwt2VTQRLrrGo/yG4xQBAwGv63yLV1bqKVoEng5N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpChKIl3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso618913966b.0
        for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761381479; x=1761986279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rt1zvt28at9xm8W3hs03xIo0raGpVE0ymzecLcbUr+c=;
        b=fpChKIl32RIl6MSzup/XREwSeOThdjqxXmB3RkXUywMmLUK62PsiwOtivjYW+WsgYD
         sSjRHrPRhPyabrJaEnPx81NaSTEzXFlie4QjoOadn+BMY0kyb4qYXw/Hn8sa7ctLmWxa
         X64MUREv15cikIdMGo9QAoatwKllxvIARzI0IbnEyeaPxihTbcDzZVQXSs1ZCgUkyve8
         cqwGOK8FsutPJqWpCNeM/mHd9nKTM/4oA60yKA0b0OXOv7HWdwf6YVqHze0FFjeQjQdt
         kQ466yaP1NgbBrE3e7tlr/UnC6wJWH/lh6eRXyHtYIMNRJfLQK1oqcTzSjpR8M6T25GS
         cq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761381479; x=1761986279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt1zvt28at9xm8W3hs03xIo0raGpVE0ymzecLcbUr+c=;
        b=MqP+ICWhInu2/yC1oSteaT5MZ6wyNgYTFApO3wel8vmqxLXuViQsZ3nyE/6+53ARsO
         oSKQL/vlslGr7cXNEbWY9/BjPTlmwm/7nss5PE09BuT90NLOMc2+IUDt7FG+cwX0nRoE
         8Hnxhjpq5TGW7PJLvBarbYM+p/ns0ipxZBFZYLpd/cAD9PIFe89+0v5Eodu86vsIL+/p
         x4VXpcPAhz/GJDblsNe2Cxxdv1wuQT+a6vBvR/7ZCl5u0RyFMqQOBapFCh1YeLEdI6va
         JSSmUPeABlPLszaWPQ87xSPaSzcxL1c+r5JvQg48yvVV1RSlfPRpxtijAmYNPLxY9RWG
         sCww==
X-Forwarded-Encrypted: i=1; AJvYcCX439sz4KeijAjMzMz1RbQXHznYzsRnNv8ZELVrBekjgdZyc1/cYCs+IBKf30slnMZm5BB4EQm2rhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhKs6SYOg85D+z8p7Vbu6nzuMzCyppo8/UWETd5Nm+vHdYcj0
	jiLKodKLtqO50tjfVTyiTGKebgN07sSWD4S3nJVkOUuyxMsdKqAPkfBfIOophqldqxGvK4zAeLb
	hWEiBLyZrNy2azjs5ZviHTKtyRmaHrRE=
X-Gm-Gg: ASbGncv2/3npD0nCZBK2npHzflb2Mp7X9pbSNoQuoRRs+kNJeHLEu64B2bLp16/aU+Q
	XR6TDxI/pUhWpBVdPVunnG82AV7w5tDIahK51xiLlcI5xms2yHNNt0J3ue+4fatYHjMnT0rOiGd
	wnN0ZG/8BDQVleySbnn8842kQeWS78LxYswaWXHUw2FthaezQnq8Nhax24M9iNtYTXys9WYfTIS
	SWQhJ9/a6TPehhI0BUOQwNdc9L0jDatasHgZ/YcCmj2hcZeTfVNg/ELusHWNh+wI16fag==
X-Google-Smtp-Source: AGHT+IFuGX6oiN+VZCvXlLc+k6tnFhyAvGLZQt/w/4MWDH5uLaa7YRkpj3wZ7I30zF9rslJZeftdwUUg96dShS04FjM=
X-Received: by 2002:a17:906:c10a:b0:b57:2c75:cc8d with SMTP id
 a640c23a62f3a-b6d6bb109d8mr624666366b.14.1761381478518; Sat, 25 Oct 2025
 01:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025074336.26743-1-linux.amoon@gmail.com> <20251025074336.26743-2-linux.amoon@gmail.com>
 <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
In-Reply-To: <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 25 Oct 2025 14:07:42 +0530
X-Gm-Features: AWmQ_bmQGviTXIcOd0mClyWfGzAI1T_FFNMyLfzBY5L8A_7DMNQFG7wRa3DtwXw
Message-ID: <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

Thanks for your review comments,

On Sat, 25 Oct 2025 at 13:20, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> > Use devm_clk_get_optional_enabled() helper instead of calling
> > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > the clk_prepare_enable() and clk_disable_unprepare() with proper error
> > handling and makes the code more compact.
> > The result of devm_clk_get_optional_enabled() is now assigned directly
> > to pcie->refclk. This removes a superfluous local clk variable,
> > improving code readability and compactness. The functionality
> > remains unchanged, but the code is now more streamlined.
> >
> > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: Rephase the commit message and use proper error pointer
> >     PTR_ERR(pcie->refclk) to return error.
> > v1: Drop explicit clk_disable_unprepare as it handled by
> >     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
> >     internally manages clk_prepare_enable and clk_disable_unprepare
> >     as part of its lifecycle, the explicit call to clk_disable_unprepare
> >     is redundant and can be safely removed.
> > ---
> >  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
> >  1 file changed, 5 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > index 5bc5ab20aa6d..b678f7d48206 100644
> > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > +++ b/drivers/pci/controller/cadence/pci-j721e.c
>
> [TRIMMED]
>
> > @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
> >
> >       if (pcie->mode == PCI_MODE_RC) {
> >               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > -             clk_disable_unprepare(pcie->refclk);
>
> j721e_pcie_resume_noirq() contains clk_enable_prepare().
Ok I will drop the clk_prepare_enable and clk_disable_unprepare in
this function?
>
> >       }
> >
> >       cdns_pcie_disable_phy(pcie->cdns_pcie);
>
> Regards,
> Siddharth.

Thanks
-Anand

