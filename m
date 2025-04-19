Return-Path: <linux-pci+bounces-26277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B8A942C9
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B517E8C4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC181C8630;
	Sat, 19 Apr 2025 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voSWt/2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF31C9B97
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745058330; cv=none; b=UvnwJXUmS759Tku+j2EyLd8ImELsZYOtSo/3y0RsV0KlRRkDcr+w40UqHEKt8cC6GuJWerdMtkevHs5r9SQ6DXJWaEfPTfLzFHMBMz26r5vmmeAHFspf1L4ePcKjqIU9HzWvtBJKqUz0enWMxuOJj/HlP/0Zjo+XTtDIwPIY3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745058330; c=relaxed/simple;
	bh=DcO3ROOzgUjQ/5kHF2gjv5zDkM0gaI/3g2awacqfOjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAmigZFYP/UQT7d8p/0/dGvQAMu3Pjfu6TKW8XCC8VVw1JD9HDHi2xg7iLj36FNX55UsoVB9u8piJSqiIiPGtwhgCpOaKyOpLjYZk8+svYgigeZF2anVnz3ISaf7HAFHL2Bku3VDswdiw+40K+si4+eQ6jPpuAhnszojDnDsIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=voSWt/2e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b98acaadso2483683b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745058328; x=1745663128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+kX6tt0WQrfY8YrNj+cDm3WUNmcy+WlRdyh2Q2criFg=;
        b=voSWt/2exZApQJkXsx9jgzNyEoXVqw+TjZ0W5ES8hXuSRCBdEqXn/G7NmPM2InGzQK
         PCY2iwQRfxkoX0dBYQZA0YtcjYWHsPqZR4igt1hOJRSJ0yxgYj8fQYu3eOnP+n/0fxOH
         D8uQ6m0PnA9brLpyZ84wDSQoveY0DqzsN1ZpPLUQime45At7xzK7ZEgyO+zY2RRmNN/9
         S72C09uoqRkUX7p+tHnSOFRjEQ2JROytRg/1veAlbZxxxq5C7ohRHrkyqn/znSAUarbT
         5RfgD03ma4KxHwYGJYFKWsKhErJZmY+tAufnOJ4HRILgEnkz31Lw2+pZoArVYbQ0VcBE
         f8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745058328; x=1745663128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kX6tt0WQrfY8YrNj+cDm3WUNmcy+WlRdyh2Q2criFg=;
        b=JTXHPQ4tDCI2JgisKq5MV2C+E4F4R10F2zCRbR80OxVrwiuMkoJxMFuuoWpHMWCmWc
         xGYj13scvXpS5QrtXKjs4h9KS+kMxskteMit5o0R1blF8CA0qLfd5zTfQC+2ltxCJcpB
         KjQznJ9cKLEvLtnDHFX+R/R+3eAmMoAIjLnI9Yxyz2iZjdfkrLSXSEM/h3iItWMxW0vi
         X4EvSBHfItPd32aNPL8CszGXnSS5JZ7+KO+MUcLomMk9noPCdzs8v/EbCUMaq8AKJSYy
         bTCkryDtCSug3YLkEVC36t0zr9VzGhENwudi1V63jGzdu0CgpZE2S6HKCUTUvg+Afo20
         TGRg==
X-Forwarded-Encrypted: i=1; AJvYcCVPi6BvR4lkH1yfWhejbmxa7PuTgQ9rW7VrmAizuua+bV74wDSxDUkyE2w/ux2p8rebPZNZx7rY1U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dj02WcQOuLMEtBBvh1gkEJCMa9tGiyN6VB/huE6ya5lop3XZ
	VJZfK0PQhvV4myFN+Fk7yxw/Bix9x15aefaa03IK1qlPBEzmN9Be5jJK/X0X89E7NUrbMLn94tU
	=
X-Gm-Gg: ASbGncuzKmoTQ4HgcmwkmKmgwkI4S9RJhKcVx1YMxxihcJkq82mBWPsJtCFqQwFObHa
	KlNuyyczd7sUTww6XgKx32Ukx+aCF86eiERM6JDq+4Tpq9LEjXPQmswXO9qZeJIEtwN1DRDWrO7
	zOKzN13LzgR9MD18FNcur1pwJImQVCS9znBkvH41xCf+RpnGhHTWKY50IlReXv3i+X9Q5oncRNI
	cTZJlzU0XieYGLAULtPE6hCpHU4tkVn2AWc2Kqr+sZUpSivbzOwdHInQQaxtk20xrinaoBaLUCd
	VpI+cpbzw/vYtkyh8vITRqYvZ8Q0fWlUrRODzmWjb4xmBtaanPU6VGCKNzgoPw==
X-Google-Smtp-Source: AGHT+IEvZE9JIei3Ibhx1cF0BrmFZhXKhDCAZ9hI+byU/7L8ln4sWb7BEEKyIKe3b7Qr6G6Sw5yIKg==
X-Received: by 2002:a05:6a00:14d2:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-73dc14ad1a8mr8603047b3a.8.1745058327986;
        Sat, 19 Apr 2025 03:25:27 -0700 (PDT)
Received: from thinkpad ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e0bbesm3035291b3a.37.2025.04.19.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 03:25:27 -0700 (PDT)
Date: Sat, 19 Apr 2025 15:55:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Mason Huo <mason.huo@starfivetech.com>, 
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: plda: Remove unused IRQ handler and simplify
 IRQ request logic
Message-ID: <dmzf2lup7iiqcqhq773rtrikb7sleoq743q7nbakrcpvcbzuf4@54qbngfpw2bc>
References: <20250316171250.5901-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250316171250.5901-1-linux.amoon@gmail.com>

On Sun, Mar 16, 2025 at 10:42:45PM +0530, Anand Moon wrote:
> The plda_event_handler() function has been removed since it only returned
> IRQ_HANDLED without performing any processing. Additionally, the IRQ
> request logic in plda_init_interrupts() has been streamlined by removing
> the redundant devm_request_irq() call when the request_event_irq()
> callback is not defined.
> 
> Change ensures that interrupts are requested exclusively through the
> request_event_irq() callback when available, enhancing code clarity
> and maintainability.
> 

Could you please reword the description in the imperative form? I have
mentioned this a couple of times in the past, but you are still not following it
:(

> Changes help fix kmemleak reported following debug log.
> 

But you didn't say 'how'. In your last version you mentioned that it could be
due to passing NULL as the 'devname' to devm_request_irq(). Can you verify that
by passing an arbitrary name and see if the leak is disappearing?

> $ sudo cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffffd6c47c2600 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942263
>   hex dump (first 32 bytes):
>     cc 7c 5a 8d ff ff ff ff 40 b0 47 c8 d6 ff ff ff  .|Z.....@.G.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 4f07ff07):
>     __create_object+0x2a/0xfc
>     kmemleak_alloc+0x38/0x98
>     __kmalloc_cache_noprof+0x296/0x444
>     request_threaded_irq+0x168/0x284
>     devm_request_threaded_irq+0xa8/0x13c
>     plda_init_interrupts+0x46e/0x858
>     plda_pcie_host_init+0x356/0x468
>     starfive_pcie_probe+0x2f6/0x398
>     platform_probe+0x106/0x150
>     really_probe+0x30e/0x746
>     __driver_probe_device+0x11c/0x2c2
>     driver_probe_device+0x5e/0x316
>     __device_attach_driver+0x296/0x3a4
>     bus_for_each_drv+0x1d0/0x260
>     __device_attach+0x1fa/0x2d6
>     device_initial_probe+0x14/0x28
> unreferenced object 0xffffffd6c47c2900 (size 128):
>   comm "kworker/u16:2", pid 38, jiffies 4294942281
> 
> Fixes: 4602c370bdf6 ("PCI: microchip: Move IRQ functions to pcie-plda-host.c")

This tag is not the one introduced the bug. It just moves the core around.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

