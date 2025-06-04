Return-Path: <linux-pci+bounces-28989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D6ACE398
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 19:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7853A8B30
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF601FF1C4;
	Wed,  4 Jun 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K16Xu1EQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B991FDA82
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057813; cv=none; b=bP/p+J6Jrakwbd/zUZb+SvX5dhZObnpoHd+XRapBQq9ze7Ly+CYYL1EgyyHNTSiiv3GhYRdEfHBmgwukwG+4HcslBWjw98k4jhL1Fo+VepAlERv1WOzalygb6O3wk8pFr3XioI8AxZqvrFLwYKiZqj07ltVIeZLRoR1dEoErYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057813; c=relaxed/simple;
	bh=gZSXx3AMeT4oZP2iB0iJUp1MZzfV5OppJkNcfJLcdDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rphqPfONC8B6suvP960kuaiSj+IIW8mSf2dG7qtbpG/oKiQ/A21OwnUA5fcbrS1NNaordpxJ2yZCTIst8OQ/VtMVkP7ssPdqu5GQAGELHoSlzs7Whm9NITBYxIhPAqsqS+TvfqIAu5D03FY48gRu73xT1fTeQevD60T0+MkqSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K16Xu1EQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so1078365ad.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749057811; x=1749662611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHono2++O4fr0FrSH5Q5xobqEyxv94ONXS/va49k4Z8=;
        b=K16Xu1EQarnOLYxZ+KxOUwiFUrFPGthEsvvxo/KFVx5wyedFw+0ShZrfd1GX7uOeRl
         nMs4/3Zpt5j35wnkexKWWtw0NXaDY7k74k9KJQOUc52KV3zFlhMBymJKibaIsDyEiJAB
         NoJZKxo5U4yjG/E/rIXoQ32/kmDvRR9WsfKQH0Gw2/oe3nrUpYdSYSnrKQNd1RJ//dYB
         ALIyjQT1lJ8LK4+g/Ai0QCiFyVNf0pBf1wSFSIg5SNLHs7vKTSyBhXFLrna07wmfxxUk
         3h5ZcPm9kD0B/FChnixl4mnEEiAYiE33WWjaysWE+JKtP37+Tx5muYElQdEntbfQ9Kkw
         oT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057811; x=1749662611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHono2++O4fr0FrSH5Q5xobqEyxv94ONXS/va49k4Z8=;
        b=lxdG+JzVRFZU2r6/jonD1S0LPeuPXkCpv342nGh4/98jODH9KK7iQJuWXXLA02XiJ1
         ppe6HRVQvJlR+la2FnG9cPUiFMZLHdY/1D5j7WXUTDOgFgDr2xEyJ/p9X9gbfM3qdjuz
         VV/xnJ0Cd+plAiD3f/wyalx8kDBSLLtoP5gqOWQ34spseT409yxphOkJpHvrk3bFbaFe
         vn+iNHaJlFvVjrX9J8ULZoMk94u8Yyat6vxuZ6UBCfqa9lK4KPj90QI0s1i6lskco7LP
         fASZdrKkRZ0+tpBvk7Zehiq59489HRsqhPtja0yRn/2tEvDs/oXJxA897bBFcc4ki3M+
         +2IA==
X-Forwarded-Encrypted: i=1; AJvYcCUd/KD7X9XTTpjc35eXftd5WoRWoWVCpZgJoS8NOHnde1W176ZizbKVma2hPD6Qql/e4YT4xGNjxU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbo08ev+8kw0k7kXCxzX187mxT1iv2sQkjklOhSjTVj5oXqJX
	cULgScfHbbBO37ggYtmm5L+LGLWnwBt/2yufOkNmgJLKBNiSGGIedEZ1z8T+T8NQD4gilCzUKSC
	il4k=
X-Gm-Gg: ASbGncsglKHzvCkmKXnmh4L/LhIx9NLWaaYxn8S0my5OaNwrMjhKWrCcKBC4IHFOIWs
	krmWNQ+3Rxh0l/ylZWX6sn54lbQeS+ybcPpuZFyXkLbn4kPhoP+NYk2xxW/V78xOD2cHOgPF7LU
	J6I0CTNo8LjpLzZ+BhqI75PuBREhJXHn3gmWe+E5OziglWH88r87N/JTZFdAj9ICcUoffzio+Ml
	wmAofLrYjKxSr0Jk5uV0uwDG8urnxDr7x3pmJaQ9KxZhiq6U/dv8aAjEdKScrFCeZszFhmuVeIg
	oWuIwKxXwf5Eyaed3C5iGejY7G0Ad0in25BYMexKQC8uHktuiIIee881C+aV2Q==
X-Google-Smtp-Source: AGHT+IGwgeJyFDpkWLW3KBe5vXSpgr0D7NF/b6JqvGw4nc8XALIL1xWj89jgG04Uup6TALuRObzniQ==
X-Received: by 2002:a17:902:c94f:b0:234:ef42:5d69 with SMTP id d9443c01a7336-235e112337emr48387725ad.13.1749057811256;
        Wed, 04 Jun 2025 10:23:31 -0700 (PDT)
Received: from thinkpad ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235caa81c24sm30776725ad.200.2025.06.04.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:23:30 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:53:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Fix double cleanup on
 devm_add_action_or_reset() failure
Message-ID: <tghehtcxc45rtdnt4mj6td4zziebckwfclbu665mtmcwvz562u@q24eds5pn4bn>
References: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>

On Wed, Jun 04, 2025 at 10:38:33AM +0200, Geert Uytterhoeven wrote:
> When devm_add_action_or_reset() fails, it calls the passed cleanup
> function.  Hence the caller must not repeat that cleanup.
> 
> Replace the "goto err_regulator_free" by the actual freeing, as there
> will never be a need again for a second user of this label.
> 
> Fixes: 75996c92f4de309f ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Compile-tested only.
> ---
>  drivers/pci/pwrctrl/slot.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 18becc144913e047..26b21746da50baa4 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -47,13 +47,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>  	if (ret < 0) {
>  		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> -		goto err_regulator_free;
> +		regulator_bulk_free(slot->num_supplies, slot->supplies);
> +		return ret;
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>  				       slot);
>  	if (ret)
> -		goto err_regulator_disable;
> +		return ret;
>  
>  	pci_pwrctrl_init(&slot->ctx, dev);
>  
> @@ -62,13 +63,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
>  
>  	return 0;
> -
> -err_regulator_disable:
> -	regulator_bulk_disable(slot->num_supplies, slot->supplies);
> -err_regulator_free:
> -	regulator_bulk_free(slot->num_supplies, slot->supplies);
> -
> -	return ret;
>  }
>  
>  static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

