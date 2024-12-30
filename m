Return-Path: <linux-pci+bounces-19095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B29FE95B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C81E1882D11
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD631AAE0D;
	Mon, 30 Dec 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1X92P7Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92233C9
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735578719; cv=none; b=EWeRXu2+yuFkl0u4+/1/keU4fzvqgY06Tr2xsCCYnONUUqCePX2Fd/uYVtijX4HJExRlXgj7car0eQ3ortP5ZB/8jFheXX6eITBs3oXbjnfYGHxTKJaZlfd3zlHxeMkkAHFuaG075th1tf3M2nt+Jee6EyA0al12a4E56zD7UHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735578719; c=relaxed/simple;
	bh=dCIZ/NMFEEBomGMOrm1A9FSBcKh2gYJk9o4/wUQGEbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfQ4rZd5GzGoQodGiHgvIzVrhjyTdGjevRonoczMun0uQyylH1RrLy6KBiYtUG/E8eDR3hJfH5Dhb2rCSNH8sTCp1boIXAZ6ajKE+ubqIADEjaRqnE6NHW1SkCX3pZMKlbO5JjlYZPZdr75Ub2Zf+QI/X2Twggn2vwjsjO4KldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1X92P7Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso161694545ad.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735578717; x=1736183517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfwNqQqXUFYCXkUWp/TOAB4xKTViC/JZlOdRDh9c4zk=;
        b=j1X92P7ZUC+jugAZdV+CQWMVH1L4gvAxFDpyu3tclAz25dRGw6GxPWb7Ejvg93DWS+
         pVXBkAtjParIsBshY++IYIsh/Ge6FWEtwrErFHAdvcFn9dP/GijvtLll+fPE+OrAnkvm
         u8YsNvtsVZz+X/hij7DkHdT2JBg6YIPCdeYzHtUf4bsdPCb9PaIG7KgUTf9iC7YkbNdD
         5ZT6rijkxAj2WIcP3HJmUNyobgaRBqaP+GbK/ZdpkBZNV1xSSHGX5X3NGPfIqKeyrnva
         1pRtnRZ/fhaO/0RA5QDJqHuZcK0BNWJcQ5hKCrrMShomfQhdi6u3Cz0vOTyVIGYL/oPr
         aQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735578717; x=1736183517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfwNqQqXUFYCXkUWp/TOAB4xKTViC/JZlOdRDh9c4zk=;
        b=IZFjqifJRM5BDdyptEM17slM4RlPbyZhyatEb2oUxlCLaQDfuJetSglJoGogZEI93H
         1eStjfLh7cBKVWYHRktyHDVG76DPm8D4GI5IZXBVB76pOkeWZ7Ey4MJDBXC33IQT6MQT
         WJT/XRXPigy+Pu7Bo0gB0QuoPElVFjaE6VixwdIJ2smbJDrhv9qZC4XC2etsEq3OuMve
         dV/PcpNqaiMIUlv4wQGLIFNIt5glSwCB0y+y3dgzru8a3b66TWnKBMwYCCF3a293KaLw
         TJCveZRRVzIcdb3mx4fIcyA2ART5RkoQxx1Pg+wT2PJQe2d+/AH1gTwzgx+Z26m6ZGO4
         5r0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSahU5ARSktTnipVN/SiGd0yVLyNpOf26xhJtMzDczrmt8LH0WiiDI1cVXJjd9Hxe6mpMtuTRfi94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBsCtA6+5u0t8aoCFIYWn3A/8bqeP0sdAmkWtOBQZvL/lnZaP
	wKfjbpBjXfDU1g4eYl0s5F6dyAGUzapGtKIhQ7+4zEhW2yocaAjeVA012xllMQ==
X-Gm-Gg: ASbGncs+uKPP3gEEHJAnoGYaMksM+WvOwmUEyzXs4RFXcYlCM6nm7euE82dlSpUolE/
	jRVLXdNk40RnXyebkS0AZpaXfFG/tchkvWOpZNmATZQpCi8NfOfo2GLI96WlnF0DxQudLzFJ7WR
	KZVgPC7wigLAukFCsHqEVgCRmb0e0pNwPlOflI6ZPjZ7yS37ZGPA31we0mfWXJgsazhjp8mc2cP
	HSMLkcIRPiHXMTdOFC6opj+QUp74bzzgGvuK3GLtmSu6u5wXihZHrJiXoQTJiSGApxH
X-Google-Smtp-Source: AGHT+IFwgvk481sU68Q8zxzSLG4BiOIx4W8KpDbELH9PwlRKWt+xiKLtXJaVpqdvB396XpJQJIW0WQ==
X-Received: by 2002:a05:6a00:35ce:b0:725:eb85:f7ef with SMTP id d2e1a72fcca58-72abddcaf2fmr51349434b3a.14.1735578716738;
        Mon, 30 Dec 2024 09:11:56 -0800 (PST)
Received: from thinkpad ([120.60.139.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad81575fsm19379685b3a.36.2024.12.30.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 09:11:56 -0800 (PST)
Date: Mon, 30 Dec 2024 22:41:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Brian Norris <briannorris@google.com>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <20241230171145.hsqynixmowjn77ki@thinkpad>
References: <20241015141215.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015141215.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>

On Tue, Oct 15, 2024 at 02:12:16PM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> Per Synopsis's documentation, the msi_ctrl_int signal is
> level-triggered, not edge-triggered.
> 

Could you please quote the spec reference?

- Mani

> The use of handle_edge_trigger() was chosen in commit 7c5925afbc58
> ("PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API"),
> which actually dropped preexisting use of handle_level_trigger().
> Looking at the patch history, this change was only made by request:
> 
>   Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
>   https://lore.kernel.org/all/04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com/
> 
>   "Are you sure about this "handle_level_irq"? MSIs are definitely edge
>    triggered, not level."
> 
> However, while the underlying MSI protocol is edge-triggered in a sense,
> the DesignWare IP is actually level-triggered.
> 
> So, let's switch back to level-triggered.
> 
> In many cases, the distinction doesn't really matter here, because this
> signal is hidden behind another (chained) top-level IRQ which can be
> masked on its own. But it's still wise to manipulate this interrupt line
> according to its actual specification -- specifically, to mask it while
> we handle it.
> 
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c7290..0fb79a26d05e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -198,7 +198,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  	for (i = 0; i < nr_irqs; i++)
>  		irq_domain_set_info(domain, virq + i, bit + i,
>  				    pp->msi_irq_chip,
> -				    pp, handle_edge_irq,
> +				    pp, handle_level_irq,
>  				    NULL, NULL);
>  
>  	return 0;
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

