Return-Path: <linux-pci+bounces-25134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A59A78972
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782DE165D86
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 08:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F72F5A;
	Wed,  2 Apr 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y781sa9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B02AE77
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581165; cv=none; b=hy+zGxrxCVBt2yMj0Q/iUs2jvhpDheINy/+yqMF8SW2Ia/7lWKVXT51euXDxGfmpyjJYiS7hPk9YEnrXntTet+0dw/w1Zf2ZP+yHfbHpwV7QOEhbmTj76CZUp8ImTuKuL4e4pVYTk2pdY6ZU27aA6pS+FtPf/MaJbgGzNeruxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581165; c=relaxed/simple;
	bh=N207eWCWUxkSP1EIvpo1j/kRarKKw70g0XhxUfCGvjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk70J9uI2p9wjivEk50TKDd3bg/Ft2/tCN8R820Tci2WZYPuv0Q4ENabYssXl3V+c/fk1B4DooKxYj8W/sze/1uH1ruzODQvKqEnK8ZYqUeHKwmytvKSZplWW21o2hND4M6gBHSgeE3UeCfai1aXmKrjwwB6BcSIF0NL7tprT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y781sa9h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2279915e06eso131269535ad.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743581163; x=1744185963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ECiII6vd3sPY61Owt8NhtZi2vZPZCQQbcTiouyTBaf0=;
        b=Y781sa9hhVxHtpPjoZye05SubiMchojlBHCiUCk7sz0dG/2tvzBpCXlmSh/HtI/1tc
         4/c1Jm7FVnLRCj5av48KwcSdqwGx8QWUTlMBDv50YAz4qsI+ipo0RR8L3MG0SNAtOruE
         e7Xr2y70L6DJiZZLeoFBDYBtEd9mMzhK8yqTDhwYFWY9df5G4clA5mKPVvqaaCvw3xgh
         OQR+tauxbLY6s7t0ITe6ADGGw7gKXK1vGp3CG+uCuH+WzvQpfR3dW8sBvdSV66mKiaFs
         WgYIXIZykjoU8MxcorWtYsMNrR879FsoXskzhm+JAz5igSCCVh/q4F3qKP8jabNmnsXH
         o7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581163; x=1744185963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECiII6vd3sPY61Owt8NhtZi2vZPZCQQbcTiouyTBaf0=;
        b=cE3FXcA56EvmT7w636dnBuWGvQrAKmUfIRMf2JDPNLwlMvrYU8VkbdOeM+L+f23Dez
         ww4gSpUpDIQB3xtLlrVwLqU0RmV7x8V20qEhhZPFRJMe/Fh5vyyXfiW4JJrh+wE51KZI
         Bgg7wcbv6IYABjA+g4rK8WdkEjpZo3o1phuwR639MZmAsuIv5H3KL0sG6N8fNk5+IP2d
         UUcpqyurWQvm36pM7Z4zz/1B0HT9FvgNEBFpYx3U8T16fUzpEhImw/gMsUJcb4pE++G1
         jSeL8D2A92AWp7XnBozjBmnX26sKCEQzk8KvlNEnugwai9DRGvSNH6PSwhy0zbqg5JOB
         n/OA==
X-Forwarded-Encrypted: i=1; AJvYcCWVUF44lvVIsDUBjgir2227BdEaL8+qefVNTMbj0/EikVSDrKzSFCb4BB7W+zczxVKZj9Cxp2uucUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ec9ZHGoQxZm4vh6uYL8fCQQyHGXWqsAR1j+KXvWGYw7aRtzI
	PZIwIx2kPOFGP1XmQkEJKYgExPxYt8tKRJ8ADs9ynoNv5Z53Nni+XYqBqbC28w==
X-Gm-Gg: ASbGncsGM6NyqheqaMPnIHcIqTxuGKOtUCtxjLWyc6mlEbipx/D+zcTB+1Bchma+JSt
	qGj76rjOT1nm+CaQkzOgcHamTzRcVUwbqMihjViPTuwtiA0AbTtg+qi7lw+QyqhsRpdzKVwJ8Ba
	de0cFfMelSpOPauv11f5YGUUrAagCv2/WtU1BMzvLmBTs9PwjKOyf2/Qo8dD4hM4s+H0uFyZT9b
	6lgj0KcvMp7ZXXMlMEcgliOajAW2SPXFOAIfAhBnxxp7S8roi5cM/pg8gJqCWGNWfWrLKs332tU
	WRKRiwP7xJ2ionKcwMJsLld386uhVDlOOxvdnkSHNM3uxZ9ccpfpWCg/
X-Google-Smtp-Source: AGHT+IGVTpRRj5G1hd9jPU8e96BmRan6Ei7Kpo43greYxZi4zomLciodYcKOKqUyIfajjCtsvTFZxQ==
X-Received: by 2002:a17:902:d2cc:b0:21f:2ded:76ea with SMTP id d9443c01a7336-2292f9d4e12mr212345135ad.36.1743581163093;
        Wed, 02 Apr 2025 01:06:03 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ef62asm102274055ad.217.2025.04.02.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:06:02 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:35:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH] PCI: rcar-gen4: set ep BAR4 fixed size
Message-ID: <53inwqbz7faoat5pwngx2rqgygt2ksg7yfjqkltxtde3jattvx@t2fdptqivmcn>
References: <20250328-rcar-gen4-bar4-v1-1-10bb6ce9ee7f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328-rcar-gen4-bar4-v1-1-10bb6ce9ee7f@baylibre.com>

On Fri, Mar 28, 2025 at 03:30:44PM +0100, Jerome Brunet wrote:
> On rcar-gen4, the ep BAR4 has a fixed size of 256B.
> Document this constraint in the epc features of the platform.
> 
> Fixes: e311b3834dfa ("PCI: rcar-gen4: Add endpoint mode support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> This was tested on rcar-gen4 r8a779f0-spider device.
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fc872dd35029c083da58144dce23cd1ce80f9374..02638ec442e7012d61dfad70016077d9becf56a6 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -403,6 +403,7 @@ static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
>  	.msix_capable = false,
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_1M,
>  };
> 
> ---
> base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
> change-id: 20250328-rcar-gen4-bar4-dccd1347fe38
> 
> Best regards,
> -- 
> Jerome
> 

-- 
மணிவண்ணன் சதாசிவம்

