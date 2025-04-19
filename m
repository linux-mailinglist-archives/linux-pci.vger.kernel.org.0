Return-Path: <linux-pci+bounces-26290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080DBA944BF
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 18:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D18F3A96F5
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5F1DEFF5;
	Sat, 19 Apr 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v58tI5tf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170E7E107
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745081523; cv=none; b=CjAbaF7F8X68UrwsjhTqRS5z9gUyUdt/WzwKBjKu4z6nnuUpYgw2Mk491Yh/wvD7TbkRT248gcMaWFoqVysnbmlEnWWlUzyOSqRWR4efKbBb6c4b0nXjxLvOubmVBdFwn2qQbbTT36mYzoUjMz6cvKsGphN/3NMqmBIBIin6U9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745081523; c=relaxed/simple;
	bh=0umZVab4MInIm6Hh9sW7E6pBic4UWXBleyLmUV0NDJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+9teGQhN8IflgGgZVfgV0oGyrCv2Lq6neVneLrjrmTBtvZwM/TGyoxaUlZRF47Q0BBOEiqSz2YXEsOG+a7HejqfWixLQy1UhgLWwEPzp6RdT3gJ6PJ+gGnIGD4ZcRBWPBVBav2sgh010YcaM3TMurKJJLYa5aJ997yrHx2AuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v58tI5tf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2295d78b433so32537235ad.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745081521; x=1745686321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+ZQg5iuK94qPLtJ84KAwd3BvA9WmtkRkwUWNrpfTPA=;
        b=v58tI5tf286k4dhYLLj/7Tq4eqUckl+Xz/PppA2E7MsTB9pUXI/R0tUPok235vOwlQ
         tQZBUe+hxbWFXaaf3B6Bm3RhOgXodPSJStPHR5G4JLXdctEpVV4PBJjt7ExRyGvNFH9E
         uYYx0ZiNI7ANP3JCPV8j7Id9q9l9I15UDG+acrpgqMjunrA7ZRI/8s0F942YF0i2WLa6
         oRyQSmHdg4cy9a9+CNSryj3S02kJkCTSORpwGRDt/e6dbJ+LJLqYBkbR/XdBWkHYkV7d
         aYdFsJ8nDiwRmjjHWd96wRza34NyNL0sSTSfzF+ZCKejE6EKYtDmut2Yp2suM+5bkRmr
         MvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745081521; x=1745686321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+ZQg5iuK94qPLtJ84KAwd3BvA9WmtkRkwUWNrpfTPA=;
        b=AVtBfR7vd5REd06k/oR514WefOTKEPKNXAsJdBuLQ848AvwR2lbVfs2Jz5RQT1UONR
         aOxoYH8hwadRI/XTP7uuZ8+qxo9v5vU1mchUjW65wLw2nP33WYnVms1ePxVKIuuj4God
         c0km7ccAtxh2HRd9c3YJ+oXFUyBzz0VEbCWCuvdX9lwxcSPvUj3U6QIxZzqXERcU85Oh
         sl0/RiGpfPGmxuStTFQ/zFkdJuNK/GnJFurC2UpJZWilOjusKfecm62ey86ROrQ1sSjt
         CRc8VACUmbvP5Y2rgfKev8rQqiEm80gLJNUR0qYkeYHJ3IZ59DyIwO7Ks6pOo/O7yeEs
         W4ww==
X-Forwarded-Encrypted: i=1; AJvYcCXwzdFigmUAxQN4YwsiOguVGyz2dQi3NTwYRp7/ZljcSR/ojTacVtLv3T4YLZJn0i1nEPmLnENbb20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQKcmp2gyZqB0G0qkTbC4SMFo/WmxNqsgNgy8bQMyiPC7+Hj5
	bOAWH1pZ6rIShbeISty5BO1f0EJE21Jupr9aOETSSpH5TIzU5xONAXIEzebPzg==
X-Gm-Gg: ASbGncsGGZC+i8/+favqp09J3Vhomq9GpxfcrMpVR8BCKYyE3h0UPHOlHv3hN98cpUY
	xAJBIblH+j2yUMIiS3wnYKAwPVXHmMqf/t4kU5UgJByUXzw1Ye8A5ckmNJsV4V/0ztzuxpHPtgL
	TyDs7VlqzFkuAmqNdJLSyNLnyMUxbZa2Ive/lCbFYpeaS1ekdop3CnFTXSDgHaUWe+cC4k22jVY
	IVvFtKlpkTi9cdalQVcH18XZI83Dm1S4Wd1Kl3cyIZ1VbyQB0oDV6NUsHRXoAC1WxrkxOsHcm7A
	wfIMjLGKsmeURqJLiHOXvB9a/ehevSP3PAkaCFcZibGDOHlejqXYqIa21Ph/cg==
X-Google-Smtp-Source: AGHT+IHOvuDRuhzgmIYZ0PseMo6wMw5ZW9e3ASq9UuPs4rj4cDesFYOxLb1JejQpj1NRcFCMCHE/VQ==
X-Received: by 2002:a17:903:228a:b0:21f:5638:2d8 with SMTP id d9443c01a7336-22c53620bdfmr86912015ad.53.1745081520863;
        Sat, 19 Apr 2025 09:52:00 -0700 (PDT)
Received: from thinkpad ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bde283sm36154275ad.6.2025.04.19.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 09:52:00 -0700 (PDT)
Date: Sat, 19 Apr 2025 22:21:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, s-vadapalli@ti.com, thomas.richard@bootlin.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [PATCH v2] PCI: cadence: Fix runtime atomic count underflow.
Message-ID: <pjacxodfaywqxabqeftguqcrz2eoib5l5l32oevy5j5rrwl5s6@hhglbkyrmnzg>
References: <20250419133058.162048-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419133058.162048-1-18255117159@163.com>

On Sat, Apr 19, 2025 at 09:30:58PM +0800, Hans Zhang wrote:
> If the call to pci_host_probe() in cdns_pcie_host_setup()
> fails, PM runtime count is decremented in the error path using
> pm_runtime_put_sync().But the runtime count is not incremented by this
> driver, but only by the callers (cdns_plat_pcie_probe/j721e_pcie_probe).
> And the callers also decrement theruntime PM count in their error path.
> So this leads to the below warning from the PM core:
> 
> runtime PM usage count underflow!
> 
> So fix it by getting rid of pm_runtime_put_sync() in the error path and
> directly return the errno.
> 
> Fixes: 1b79c5284439 ("PCI: cadence: Add host driver for Cadence PCIe controller")
> 

This is not the correct Fixes commit. In fact it took me a while to find the
correct one. This exact same issue was already fixed by commit, 19abcd790b51
("PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path").

But then, this bug got reintroduced while fixing the merge conflict in:
49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")

I will change the tag while applying.

- Mani

> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 8af95e9da7ce..741e10a575ec 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -570,14 +570,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	if (!bridge->ops)
>  		bridge->ops = &cdns_pcie_host_ops;
>  
> -	ret = pci_host_probe(bridge);
> -	if (ret < 0)
> -		goto err_init;
> -
> -	return 0;
> -
> - err_init:
> -	pm_runtime_put_sync(dev);
> -
> -	return ret;
> +	return pci_host_probe(bridge);
>  }
> 
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

