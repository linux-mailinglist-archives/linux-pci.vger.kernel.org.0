Return-Path: <linux-pci+bounces-26867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C719CA9E31E
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065165A23BD
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3FB663;
	Sun, 27 Apr 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdl6s05O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128B1AC88A
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758452; cv=none; b=Q3Z4XzZSjUPARpMhe9LoG+zMiF98iph6ZBaggzXUdD4l/ZSX2W/5dd/IPS5FCHdbf/du9Vc1qdRitSUrPafahhIybXCS2Al5nyHw+SOeD5sbVd65Wn14XxlYBVwsuO1hU56tiwUwUo6G7ZinR3IerfeXH2gYeUPvZB2f4aJBfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758452; c=relaxed/simple;
	bh=m0ncI8ywbDUYe+YOGHI5QGQIaD+jjjvzA74NbJAljbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHb8n0xXUKr45IfZvF54nT0TQciYxsQaIDyJeKZEW28C0Y51j42YmpmfLougHYo/OC9OVi9zoXtavi1nitj+GjrweNba/XDnFtfk0sdniBC3f7K1CjIdmKRss3EVGbKKvhkQm+FtPTCoPM2c4M6sPuSksjvrHKEmTPPsTK9LV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdl6s05O; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso36090225e9.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745758449; x=1746363249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nA7928bge5F0w9D37QG7wtoorVGmVQz/sIPfIZUOAl8=;
        b=Gdl6s05OnjNLBWdEtAimPl48fULBh1OPs/ZvOvqFt0O1U9bCevItqTK2hmdMIoR5fT
         dForR/YSLO+cNInBbL6SlZLVI/4iD8Fw+raqAjPqJQanbcpsiBORpycmnV6hjtRUSezn
         CTOT4F6zSPAHi+T9YKim2Wv7U45Ll8Zp1cy98tepzHWRhrHLNlaGkSmIun4UwFWn31Lu
         xOOLuX0K2u6LRRTEKkwOSRIn0Yfe/hdmeW4ledYCDe/0yPwVlCMoYbYzhcobET6Ps7HL
         WaJbWVfgvsOA0WMO2+828nFBbREk3inx2pxkmNTmVpvHmL3C9KcDGbg23Z3oPP8gHhUC
         5PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745758449; x=1746363249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nA7928bge5F0w9D37QG7wtoorVGmVQz/sIPfIZUOAl8=;
        b=OOn0yqQXAh64z4acyozq+qVId5OrBQLo0F0wY5l/hMG1igIX9Q3i6wxJ4mhjVv+erQ
         BaXpnbfdP/lZLrIEPdhbGHxuUOwsHeFv4X7Es0KkUEjRJcsch5mz8gsi+u+Sr4BZI0r4
         qlhqgaRQONOWm7s4cVW4V4juCWzvR0T7q0LNGxZZ2Hy8AvWMCt76VrPPBfoViygFipoZ
         QCAqQBaeNk+DGvZn46oSw4K2qXLiZwWYMtO3aCMM3rsqLk3TeIYZTBFohZSn/t+R0221
         Or0zP9dTH2HkHKkWv/06QAfYr4uspWCPsjhigMtsAtOkPL4mslfe+xyUDMtPOFlHTCwK
         nW+A==
X-Gm-Message-State: AOJu0Yww8Bs6jbymLg1p/UIs//ix/+X7BfTibV6sILQPsdvE1x6ZttOU
	SAHBbr4cyvctLWaQtZRVMO2jpECwAp6o+i7eFDjLlqBcotMjNytk
X-Gm-Gg: ASbGncuQ0gMvwJbG8GcKw+q6EB6oPvG6xYrH2A63oqsjJBpW9BuQB232P8Ur5TGGD72
	R9LPcMvX+JVI+mA2lKWS3TdZR2osou6UglbnVhpjfeJ2fauHE9Hf6ryg+AbcCPLbNMhsnvXpxvL
	3tum5GUVbTHDEXWBAc/RL1CB8slz9WwSW+tGD5iuHYZhGol+9cUwt8vp/IPtiiYDSBIlVDTHyih
	8MY3H57Ui0DVcNYBmEM/eePs3+HTS4WYYxXZqqpYZgRt9afLR9iyx23XXVBwKHLYT7urSRN190j
	C74anqAzTBYZFMPViZWuxEwEbm60j2A3+1WS51IUnSdk9osVoUBk
X-Google-Smtp-Source: AGHT+IEBSIo0/tf1XX3NJMfYoKKJQPVBsh9PHQ2CDOzDz/xSHr9oMGUEneulT6WpnLK1CqCm2HsISA==
X-Received: by 2002:a05:600c:4f46:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-440aea50effmr25791195e9.32.1745758448768;
        Sun, 27 Apr 2025 05:54:08 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ad112sm123288985e9.24.2025.04.27.05.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 05:54:08 -0700 (PDT)
Message-ID: <ae60787a-7e98-4180-838a-34df402c8f86@gmail.com>
Date: Sun, 27 Apr 2025 14:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu
Cc: linux-pci@vger.kernel.org
References: <20250424043232.1848107-1-superm1@kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20250424043232.1848107-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> AMD BIOS team has root caused an issue that NVME storage failed to come
> back from suspend to a lack of a call to _REG when NVME device was probed.
>
> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> added support for calling _REG when transitioning D-states, but this only
> works if the device actually "transitions" D-states.
>
> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> devices") added support for runtime PM on PCI devices, but never actually
> 'explicitly' sets the device to D0.
>
> To make sure that devices are in D0 and that platform methods such as
> _REG are called, explicitly set all devices into D0 during initialization.
>
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Move runtime PM calls after setting to D0
>  * Use pci_pm_power_up_and_verify_state()
> ---
>  drivers/pci/pci-driver.c |  6 ------
>  drivers/pci/pci.c        | 13 ++++++++++---
>  drivers/pci/pci.h        |  1 +
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f72..082918ce03d8a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  }
>  
> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> -{
> -	pci_power_up(pci_dev);
> -	pci_update_current_state(pci_dev, PCI_D0);
> -}
> -
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  {
>  	pci_pm_power_up_and_verify_state(pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0cec..8d125998b30b7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>  
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> +{
> +	pci_power_up(pci_dev);
> +	pci_update_current_state(pci_dev, PCI_D0);
> +}
> +
>  /**
>   * pci_pm_init - Initialize PM functions of given PCI device
>   * @dev: PCI device to handle.
> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>  	u16 status;
>  	u16 pmc;
>  
> -	pm_runtime_forbid(&dev->dev);
> -	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>  	device_enable_async_suspend(&dev->dev);
>  	dev->wakeup_prepared = false;
>  
> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +	pci_pm_power_up_and_verify_state(dev);
> +	pm_runtime_forbid(&dev->dev);
> +	pm_runtime_set_active(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62a..49165b739138b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>  void pci_dev_complete_resume(struct pci_dev *pci_dev);
>  void pci_config_pm_runtime_get(struct pci_dev *dev);
>  void pci_config_pm_runtime_put(struct pci_dev *dev);
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>  void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
Applying this patch makes my laptop power-off quickly and no hardware-related services gets stuck anymore during shutdown.

Tested-by: Denis Benato <benato.denis96@gmail.com>

