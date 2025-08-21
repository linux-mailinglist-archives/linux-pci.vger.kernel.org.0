Return-Path: <linux-pci+bounces-34422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA3B2E9CD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 02:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C151AA05DC3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 00:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7011E32D3;
	Thu, 21 Aug 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeQ/g63d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F331804A;
	Thu, 21 Aug 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737701; cv=none; b=sziBKrB6Cpm4K1XngzakOAsA2Ck0ONXjTfqkbAHUKa/FvHR7CNpCAd3IDGlAnmPu2B9nBmb5JOnrxRDQgOJ2nBhjy8YMHNct6aRbIodueH15Y8XR4Ls0zcJYrt850iaCbKaR/kWKmzUUFaaaggGKBxB5gfjUoM+81r1K6yfvxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737701; c=relaxed/simple;
	bh=zEKH0whlqLewLZsL8A8sZUR/hXkcaQSTvtaOJ3AF/CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2CuRpFLX2Ev7xiVSMI9hGgbmdoULpLhMmyKF6/vD3IuH/9aSfltzho9hIOxy6qbw60coZqcHF78RagSm0AyhrfJg6PQb5moab513bPW/SyJGYNjbA3wKyEVyJbfQMUKT1k8j9Lp3iJLVrLPWtFxDMXBarM3WN7KHk4XPzeUgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeQ/g63d; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-61a94bd82a5so849696a12.1;
        Wed, 20 Aug 2025 17:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755737698; x=1756342498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECt6+t5ZFrrfkRkr0o7E1VCkPJWhGAI+xLcJ6W+PWtc=;
        b=VeQ/g63dz+YuNBBWe12yaleoR/xvwjE/lPB7i/eemdByNiu78d2BzOolJkj6VVZ4kV
         6s4Xv1EMy1SRMgYe1DHawb8F9ATscYLA+1sN0RgWxwuLyG3HspBlRm/BhdbnXYWJHvan
         zyCCFnO5f9E7AqrKX1kyJwHxLYeWe+UKhWJfzc2tU/lJYVU0rHNydLz9Hle4az9SBPpo
         DyoTZXHRn+jN/RR7mVCVMwLtFPXntPNE2ynI6C5zVDGHMJSJmim8baxlbzpcXaDFXJsL
         mVQXNXDa8Rc4WBeamWYM9wbU2jytyQfllyH1Bq2BklGO4VkLi1yFNyVj2pK19qeVyxT3
         sosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755737698; x=1756342498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECt6+t5ZFrrfkRkr0o7E1VCkPJWhGAI+xLcJ6W+PWtc=;
        b=u7uIdhsTeOYDlNRG3adA7X1MDAthb4/HJZK59HeZ/lBCRKbdGfne5ThE4/nIr7I4tO
         oDcDci9ffOJE2gEGBIUiDpxgIW31bhApo/q2npksImHG8xS3GqAglv3ruwtyZsOJVtTm
         2x8lPitw5ntyvwDjlXdB430g0lFAj55WmSLGXLaDT+wEwKXUqfC13ls3PSq2zWJglNx3
         IG66Ya/SSLekW51F/C7xBghgm3+NpANFOxY+fUOBB7GyTb2SIP8jlEisKDLnaO7TJBdD
         63Bq6ylD1oVwxsKx7IMPJtPRh8qUYWfNCFarELmS5Vze2/NSQOFNP/kBcfn4+Vv9kRFc
         Rkcg==
X-Forwarded-Encrypted: i=1; AJvYcCWGaPNnEHeYbUrM0JEeh+7nECO5zyy7fsXUD+g1iCOlawnpjZTSJke45qP1Sjn+n5enCIO7Gx4kHfA=@vger.kernel.org, AJvYcCWOOiLGndnlmRZjiicq5KFIub7TSK4iudwwN1UtcP0xWAhIHyIIzL4Tc07d8wIl4RnHWYKLv3LI@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgavGVUEPhevK3vin9pomkumzK6DGdngvmuIm8z4NSbfkbfVq
	Lt7T+JakzHpJNUCYh1xTFvLDr8ihInjzSP7Gag9X+uyHRV99B0NIBicb
X-Gm-Gg: ASbGncsZlicflViyan75LqUOCll9K0pvawGqxhWiC+DkqF0uEZRKUsd3/pU1v8o9gEA
	o75RGM3c/5YUYDu0IzJEzUmE1sz2RgvkjROY32niYTotKu8bVcY2orHShOeOvruHCHWsuD19A9G
	lOYq9SmkzbUb9xG0kKd9HrdpwK6a2YznskTPZ8TF6qzS16ezIIrg3Y1w6Uw65wV5XPur5GAHZyv
	vTsFsHy8QDgGAPciha5rWM+0TyvjFcFqXW4p28CXzYir5BiaGHnKDSoEBhw7m9Z1LRn/QqL1CpR
	QU6ea4WBgPjIUWxuaGAiEH7dqjSUI9AiGJNLpPLt08B0WXgfuYRcYmKTEUtKCHOLy+bjT/gDyMS
	6cdcNNBQjns4IrCSSiqRKiJtcTPOI81/UpJVczmYgL8drOlVtz1Yc92DadNvOPcire06qgVBPqm
	M1H2T8vc+Xfdh7kzrYruai
X-Google-Smtp-Source: AGHT+IGqhADzawZRc4KqXqlNcb31shVNdQejYqkinActEiOhb/cOrOXHd0P2GElngi4E1XNG9BHO5g==
X-Received: by 2002:a17:907:6d24:b0:af9:5b1f:b87a with SMTP id a640c23a62f3a-afe07b08fdemr68615666b.20.1755737698151;
        Wed, 20 Aug 2025 17:54:58 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded30bf00sm281725666b.30.2025.08.20.17.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 17:54:56 -0700 (PDT)
Message-ID: <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
Date: Thu, 21 Aug 2025 08:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
To: Brian Norris <briannorris@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Brian Norris <briannorris@google.com>, stable@vger.kernel.org
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/2025 1:26 AM, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> max_link_speed, max_link_width, current_link_speed, current_link_width,
> secondary_bus_number, and subordinate_bus_number all access config
> registers, but they don't check the runtime PM state. If the device is
> in D3cold, we may see -EINVAL or even bogus values. 
My understanding, if your device is in D3cold, returning of -EINVAL is
the right behavior.  >
> Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> rest of the similar sysfs attributes.
> 
> Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>   drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..160df897dc5e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
> +
> +	pci_config_pm_runtime_get(pdev);
This function would potentially change the power state of device,
that would be a complex process, beyond the meaning of
max_link_speed_show(), given the semantics of these functions (
max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
....),
this cannot be done !

Thanks,
Ethan>
> -	return sysfs_emit(buf, "%s\n",
> -			  pci_speed_string(pcie_get_speed_cap(pdev)));
> +	ret = sysfs_emit(buf, "%s\n",
> +			 pci_speed_string(pcie_get_speed_cap(pdev)));
> +
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>   }
>   static DEVICE_ATTR_RO(max_link_speed);
>   
> @@ -201,8 +208,15 @@ static ssize_t max_link_width_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
> +	ssize_t ret;
> +
> +	pci_config_pm_runtime_get(pdev);
> +
> +	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
>   
> -	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
> +	pci_config_pm_runtime_put(pdev);
> +
> +	return ret;
>   }
>   static DEVICE_ATTR_RO(max_link_width);
>   
> @@ -214,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
>   	int err;
>   	enum pci_bus_speed speed;
>   
> +	pci_config_pm_runtime_get(pci_dev);
>   	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>   	if (err)
>   		return -EINVAL;
>   
> @@ -231,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
>   	u16 linkstat;
>   	int err;
>   
> +	pci_config_pm_runtime_get(pci_dev);
>   	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>   	if (err)
>   		return -EINVAL;
>   
> @@ -247,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
>   	u8 sec_bus;
>   	int err;
>   
> +	pci_config_pm_runtime_get(pci_dev);
>   	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>   	if (err)
>   		return -EINVAL;
>   
> @@ -263,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
>   	u8 sub_bus;
>   	int err;
>   
> +	pci_config_pm_runtime_get(pci_dev);
>   	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
> +	pci_config_pm_runtime_put(pci_dev);
> +
>   	if (err)
>   		return -EINVAL;
>   


