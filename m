Return-Path: <linux-pci+bounces-35294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FAFB3F0F3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 00:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7314B487C27
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B427F017;
	Mon,  1 Sep 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCy5Z85R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66662CCDB;
	Mon,  1 Sep 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756765247; cv=none; b=XMvBUlS27X2d0ZLTahBsHJrVB4H4N6B2w0/lZgsSRJyj4G8pjk0zRQjMq4+MqUH1gpvaF50qO7g+lXMtkBdByuZzDH8JwX8dOVkDC5NEqis/KDutxfqYDUOAUrjr+ESrKbt4K9Dnf3GGCvyrontoxMnzusR7P/1bxXhYIZxresI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756765247; c=relaxed/simple;
	bh=vzHxECBJULxMHhhAe+gmEj/v8b5yWPOb8IwoQoHqnIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ1HgNQBiV+OzgNx9RaPD/1os8P/EtlyMxvczhmGTtbjtAB3m3I1USrNm8q1+S/Pobsiarf9dq8gkSqPim5ggh75XmUrvU6h4B5eR3xfi1psK5Av5riWS1qfAZyoOXzCyvovFll68A2+wI8/II0GLLYY3fzr32MP4t2wUAEOCWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCy5Z85R; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4628979b3a.0;
        Mon, 01 Sep 2025 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756765245; x=1757370045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbflhREK+bo6w9MGtFWZZvqgszV766pk7Lxgqi/NyO0=;
        b=ZCy5Z85RO2MVMQYvbySFs7ns9u5hVafJy+RvQ6qxT3VOxu3O5Xm1bGXAGlLWPaeJA/
         wkhqvhZAQMISljWE0aiFfPSyrm/Q7xW9xjfT/MDhX+K+FLqZrN+LJqUorIb0ebXx1Atd
         PNODk2M1YXaZKDJsZdI4QPWBztvi+LT6t4a+DPxo/AEBgM+fNcgSDuIlgzr4kmgcRk5N
         QyWUCXSGU3dKaMpnKz5h6QhG32bhkIbFrhoh/Rpb9aYnel0Sp8r4c9xbaginrdT0LnNY
         DWa9KaSw6VtQX1JQ2BOXC4tVBBsf9b7Wm4XpelRyxBbGX/k7Udx6o+IRHZtUjAdowpil
         E77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756765245; x=1757370045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbflhREK+bo6w9MGtFWZZvqgszV766pk7Lxgqi/NyO0=;
        b=cxEmZaoaA2ri+Rmbqt/gFtHJjy0xd58csAvXA41gsUNvvS1iYzf4cbM2NVo/TYAtUN
         eYwYVFPgw7rNOOgL7TqHeNxL7yhy8VjD4xmfyfrRZr/YHOP+UIRtwlHcrtSWEFQ2FjSc
         tC8ErfiP1M6SvFOuPXcDCGGymlmTwmCyglryI4NAgY8VtZrPwpmC5NY8CXfBI9tiVOC9
         QSv2haev1tVl+mHj0ywj5SlvPSK0IPmBABJSG5C0QnmHSOe/I/MIC4OazR6WqAgFzjAS
         ECFEPQBQPJg0nM2hJrM4hpIaxwHWd1/ixdAZfLGBfxtiDRNwdQsrnUZj2GlUsgwe5KU7
         54cg==
X-Forwarded-Encrypted: i=1; AJvYcCUlkut328VhqaaTA1wS2YApEK0pNKa3sdJhM3u/rXfsIPDAoCTaq2Qe4UFjxF5sOqSR3QdwQID8xQpm@vger.kernel.org, AJvYcCWK3BkeY9LUhmld4Vc9Jdv+Pwrk07a+RLM3EChNm9G8aRuyOqe/rUzCjMDLvcB7YjQUBcCIAOdaLwSekAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uGn2u3Kukn/uUfcLI6dvhqN/A5qCwz+pqwKd2mRx3iTPy0y0
	hx2Gm8ZcXYjET8QIlioBrmUq2Tyn3nVZAwzB0wb5aWBOQELj9GrRlo0B
X-Gm-Gg: ASbGnctcrJVFcEkB6AtFhaMfonV29pj19+DXG+LWkP6c3KNmCKXR1zzLamfa36p50oT
	IktygoGm3eRUTtGxlxY1O8ntDkHOr43H5272Do+fCxZC3+nbGDSTKlxVPIviCDZ7zfcKHr3TMel
	NIiitQtRlhk0Z/yQN0DX44bUjVFYoNG8uX6NxqSQ49khD2oGe0EByW9vbZN3lJUZmt1yPUuyTOi
	G6N2aYqfx9uQUttFRkEcjYoEy/jIhKnTAKTSBT5H3ZiNdVNTMeKUOeTq18bbZgf0Ldk5l2CGUUZ
	RyIZxq8unjpA4KdDyrgG+p+kBRC7OOcbmUfe/CaVAuvats3N4xNqn/6BiuBW+fpKPv7b9J9aAtS
	Vx/5xcMNTvuZbkdJNkyMZyQj66qss+gby
X-Google-Smtp-Source: AGHT+IH3q9RyYI5YQZ2zSR+XTeOamON+ApkqGXj+yOCi/4qh3pDtMQjI0pvg7/7m3Q6/1JRoJJy3cQ==
X-Received: by 2002:a05:6a00:2306:b0:771:ef50:346 with SMTP id d2e1a72fcca58-7723e343f7emr10715815b3a.15.1756765244964;
        Mon, 01 Sep 2025 15:20:44 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a4e1d4fsm11405849b3a.73.2025.09.01.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 15:20:44 -0700 (PDT)
Date: Tue, 2 Sep 2025 06:20:38 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Wei Fang <wei.fang@nxp.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <fqnwjgkqpvgxnzqocsdzqxyrczitjrztaxupjk43sk3gcgwbk2@3b6624izsfny>
References: <20250827230943.17829-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>

On Thu, Aug 28, 2025 at 07:09:42AM +0800, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_template will not unmask/mask the interrupt when startup/
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
> index e0a800f918e8..b11b7f63f0d6 100644
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

Hi Thomas,

Could you take this patch? I think this fix is good to go now.

Regards,
Inochi

