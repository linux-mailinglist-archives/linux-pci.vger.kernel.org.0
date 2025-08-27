Return-Path: <linux-pci+bounces-34948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD8B38EF2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F611B233D2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311030DD05;
	Wed, 27 Aug 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJgFX29w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266B2586C7;
	Wed, 27 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336101; cv=none; b=SasOjosv/gh4CMG+QSlFXG8QMWYH+BOjPXOHa8n3ZwkIzUWUeoUNEhcO5jbPESKfdBUSzqkELA7bS5H3lbVcbDQw3fqsNLO1BpxN5Pbl7DYN3JQQb5qwJ4iqGfu1ADjNucJZl4/9YE79EEsaDZ+tDyouTeqTtAmUh1fZDLH0iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336101; c=relaxed/simple;
	bh=rBHPg7TbEmAkY04M8E9R2JNyzZMGICD3ljSXBdSnUNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT+uTmDTE1Cg4DLWAy+3aIeaHLk81y5CkkPtqCgoVpouRFG5Q8I7+pgE46xsqqJDSCgz099ptIc23PfDUXyv20H1BXMEHbl2pwcoCfHuHlvvFeznJF8aElLfxD6GDpSMbjsdusncdkijE9vB+IuaekPziSARMmpB9MWoBouYMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJgFX29w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24633f57e0bso2429135ad.0;
        Wed, 27 Aug 2025 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336099; x=1756940899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xmRMKcp/4/wqiX4OlpV2pARrFrt2A17fOj7RHwDDn0=;
        b=aJgFX29wayYpPQeYgaSeThfjgWXpSsKjlfgBiRPknw58Og48nTpmfmojz5N0oR6+m7
         1gy+HKjh2ep8m4wGLYkJLGUsMxe6F8jpY9dOhh7zmRO8gd6/Zlvmwg9upZ2p/4etSFhS
         FHH6b5iQqPebopiALQfGdAkmgT5hhwRm7hj9jKgD9wGDgv77+32SwMjfO36CyaXD7YKa
         AiHUGzlRNlt2cwlQqMmEM/uoL5AntOfWG4CVj5hbS2dV9gTmVZRZMZ8WyxbPSpuGHuk1
         6xYagJ3tT7sC7/C8MyQvOrJw0KmQFQLREaEh1nyEi4At/ixlFIR4JSA7raEsRc3y8Ith
         pMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336099; x=1756940899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xmRMKcp/4/wqiX4OlpV2pARrFrt2A17fOj7RHwDDn0=;
        b=TcDygCFMNZT0IcRfdQzNKH+juQI6UgScVAIcEylvCnssVt0EC6MgAthKuwAC1t7ybE
         u3Jl+YxvZojjIr/N2NmqI+LWLPF3jDArs0fAgN6eFfj4tPn6uBr7UkoYkcx9qyZfBYLP
         muNz79YnsYh4SvyPmEtiaJDzf2F0Mnyc89ElH7S+HLKNZLs3qsw4EPlHwWqcUzsJms8B
         P98FFzvogFHMF0xhwJHtUSwvul+JoVFB8GoU9xFLYkPrrdpPPn2DMmnuoibZTOeoTOXN
         oVKCECC2pVPkGDyyQV9jNnRCeojBmYiWwwzUGVYWEvV9uzri7eOY/dpudbtiDqlOsSHZ
         h1ag==
X-Forwarded-Encrypted: i=1; AJvYcCU/UydG4qMrb+9Www7fXE7LCHXCOGPyH+wIfLJHKtWbvmDX5q4n60PUTfFkF0h0n/W3w18CZIREqAdL18o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0euw6ySxVzW2Occ5eU4tAjsjAxuYY7G2SnR1A2UHGDd5Flgr
	G8YENnZxOApX0vHtD62lriT07hOZp+iygylw0QyzBXPe4YOV4RytRbwM
X-Gm-Gg: ASbGncv4Kvzgkr2i9hfLqgEJ1rS56t6HVgwnLc9GALU+iRn75F2l/5UxDNmgeQUlpcu
	qNbUfvMnAkRlk2cQK+5DlkPx5Y+o6sg+ULiqNtiOXyZ1BJMBE7+Y3uh1ce2Xr3ES0liVSECpLK4
	LBXuNpd6HeTfz4qdFTNmYZyjPONGMwFiO4fzLQaiVGnzCy4/3wcDuxNNs3skidF2vUSy08yujiR
	6k5F7H3E0Tz0DoCVnR6T7HKo5r3dasiI4MWQ+EKK0jwCH+6LNWsXBsk/iqw2BhKg4y9ZIZIqn6C
	/Dxq0IalDkKzZNR1pX8YPYxhjyYZ/EfSNycmBb8i84IvraBWR8bBW0BtrGaewsP3tE53OXj868w
	HsRsl0ciqI277XULBjATFvw==
X-Google-Smtp-Source: AGHT+IHKM4rK3euHXgeMEaVfe1lfZbMb3D1T8e1kJe0wR9Voh0HrlDcOCkTogRK3E+WQR4bX7hl+Lg==
X-Received: by 2002:a17:902:d486:b0:246:b46b:1b09 with SMTP id d9443c01a7336-246b46b2296mr189109065ad.30.1756336098874;
        Wed, 27 Aug 2025 16:08:18 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466886456csm130874945ad.72.2025.08.27.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 16:08:18 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:07:10 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Wei Fang <wei.fang@nxp.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <o5d3uiuntafsbblqyt2ltcgckpo4ugc6rlkb6vyk6kzf4ngaen@cb623hd6zs2g>
References: <20250827230354.16249-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827230354.16249-1-inochiama@gmail.com>

On Thu, Aug 28, 2025 at 07:03:53AM +0800, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_tamplete will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
> 
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> 
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> Change from v1:
> - https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/
> 1. Apply Tested-by, Reported-by and Tested-by from original post [1].
> 2. update mistake in the comments.
> 
> [1] https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> ---
>  drivers/pci/msi/irqdomain.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 50ccac32f4cf..cbdc83c064d4 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
> 
>  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>  		irq_chip_shutdown_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_mask_parent(data);
>  }
> 
>  static unsigned int cond_startup_parent(struct irq_data *data)
> @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
> 
>  	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>  		return irq_chip_startup_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_unmask_parent(data);
> +
>  	return 0;
>  }
> 
> --
> 2.51.0
> 

Please ignore this version, I generate this with wrong parameters
I will send a right v2.

Regards,
Inochi

