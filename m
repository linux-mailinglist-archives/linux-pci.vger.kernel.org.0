Return-Path: <linux-pci+bounces-13761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A783698EBE3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559D5286EC7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F513DDA7;
	Thu,  3 Oct 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M04nxZ9m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CC13B2B4
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945449; cv=none; b=nPj5RIWLVWRvNjAaEAbiYef55Fs9I5I2cRM7wikkA2rNEi57NpdREkRtV3tgY6Mc3NCtf+bJZPpIQNrUD/eGXysiZWmfwsv5JjvSEAcgazFfBiAZ0JsjVzgJz1skD6KMdQ4ILP6LZasAfkzzRrFco06CLYrXPHwNzxMVx5V61Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945449; c=relaxed/simple;
	bh=/FmHmBpd5XDOLhQhi/5I3Km8K1myZ143jQBtndvdIOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe0lEriR3Lv2wCnmxjRwx+t4WSWOWmyQmIsxM9ffqCXYJv3CdRFeJTQ3AqfayUsqVK/tSMkvKvbo5Nx7MgXNektIDupctx6H6/ACS2LmRqJAuJe616oHBoDSVTn8J4DRjvcDLAV9y7U+G7IpBVQ8hS7YleaqNQFb6vDy9ilZ0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M04nxZ9m; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d6ad6050so678056b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727945447; x=1728550247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7KQ7+I4I78I58DCOoMZSP/bllSWx1mddI+1OwxdetBE=;
        b=M04nxZ9mK3liv7VZMotY/Z5VWMGKY24OGYnGDnYjSv8jBAwx71YXfM+9TsgR8+2nws
         0kDjITYrEgLKqZezDvDRZ79/oj53ErPZ31eOT7gsfaCHOmqY+8k0LqeO123mYzjHE4K6
         sjVbazew4HWqNmnS/np3TvwevI9uf4102SAXGejvosh7wFaPwcY0fSZ090W3YDX6yn7Y
         gwZpMB/HiWBuxg41psiHpPUs19NajTOMpozltARuraTLhUzKnyzrjwgc/6Lgjie7fhN+
         Yc4GzpyszjjT/GRDIT3CH997Q4oWxEC34GH8VTTGhkmnvtiyl3zQzPecA3cH8Juk9LFC
         sfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945447; x=1728550247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KQ7+I4I78I58DCOoMZSP/bllSWx1mddI+1OwxdetBE=;
        b=mKLX/Sgzs0lRXWIiHj89OS1fELu+Y/P2W1gK0Hmn67lynKjfQDllS8z/PV9JuOG0vK
         XWYfGenbWdsbFlAASR8HP0CHM69zQ3V3hzTuxsyqJEstd0Wfo8JNKkrlQmaMjjQthUj2
         nOqO2d6Pc5YmtB1KLlBNiUkn69e6d7VsxQNqrzk11t/d/Dk8WYK0Wwug9MfIXmCNdiTC
         S2hMLeTXtdK4MFJz4/QmsLr2IeLE+3CLQZTr/vHtdH8LZj5648Ww/OxglAsxW9ExwvbB
         TliCR4QkV6lSrjbjnd7/4meR+nMAMbb3u9Kc4AEnt4GhjDIgo5QY1SUMrOaIFmAidQ7N
         Pzrw==
X-Forwarded-Encrypted: i=1; AJvYcCXrXNBqXRyF7ArOlLVEEtaqJA77PL8SfCAYClYA/ssNRA+/WgckbGGfMVZvEl5mOWNgjqbtPFI0EoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tGVSrOO4dsv55e/ZP3Q2LW/IiPwSwfUyoSlhWOPdz3i71vd0
	HLD+3BLU63a7tvJSx5B695hU7Te7wqAAz7FmnkGuzgCf2WyPNurvJxJwDDLGCQ==
X-Google-Smtp-Source: AGHT+IG2HoPAdPTHe9BKFz0bx6mX818wSoCf/G1Oj2DqmoO9d5KjePwIuI2iQfkVv1fwjTfAhr8xiA==
X-Received: by 2002:a05:6a00:4fc5:b0:717:90df:7cbb with SMTP id d2e1a72fcca58-71dc5d5bf53mr9374915b3a.22.1727945447365;
        Thu, 03 Oct 2024 01:50:47 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e65fsm829846b3a.87.2024.10.03.01.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:50:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 14:20:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2] PCI: take the rescan lock when adding devices during
 host probe
Message-ID: <20241003085042.w7d3h2tiogr56un7@thinkpad>
References: <20241003084342.27501-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003084342.27501-1-brgl@bgdev.pl>

On Thu, Oct 03, 2024 at 10:43:41AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Since adding the PCI power control code, we may end up with a race
> between the pwrctl platform device rescanning the bus and the host
> controller probe function. The latter needs to take the rescan lock when
> adding devices or we may end up in an undefined state having two
> incompletely added devices and hit the following crash when trying to
> remove the device over sysfs:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Call trace:
>   __pi_strlen+0x14/0x150
>   kernfs_find_ns+0x80/0x13c
>   kernfs_remove_by_name_ns+0x54/0xf0
>   sysfs_remove_bin_file+0x24/0x34
>   pci_remove_resource_files+0x3c/0x84
>   pci_remove_sysfs_dev_files+0x28/0x38
>   pci_stop_bus_device+0x8c/0xd8
>   pci_stop_bus_device+0x40/0xd8
>   pci_stop_and_remove_bus_device_locked+0x28/0x48
>   remove_store+0x70/0xb0
>   dev_attr_store+0x20/0x38
>   sysfs_kf_write+0x58/0x78
>   kernfs_fop_write_iter+0xe8/0x184
>   vfs_write+0x2dc/0x308
>   ksys_write+0x7c/0xec
> 

Thanks for adding the crash log. It always helps to have the log in patch
description to find *this* patch.

> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v1 -> v2:
> - improve the commit message, add example stack trace
> 
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..f1615805f5b0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	pci_lock_rescan_remove();
>  	pci_bus_add_devices(bus);
> +	pci_unlock_rescan_remove();
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);
> -- 
> 2.30.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

