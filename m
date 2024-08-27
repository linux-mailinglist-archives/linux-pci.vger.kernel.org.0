Return-Path: <linux-pci+bounces-12260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC39604FD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE38A28121F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD2158DD0;
	Tue, 27 Aug 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiGdvWAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A6198A2A
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748985; cv=none; b=J6H/MofnDUBbWmN2fRl+nOhFf6apbsqyFH3sUIPrBTcUHvaLYZizHDbWVIQNsIGrzFofJbefOv9KsmhLatNRs8LkT6/OuaArdsMeMGG5JU8RuvgMSH+LLZCf360HblcqOpk9Tb2LA61uWwfTGTzJfzAvh0xbiubW2PoLrRuuhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748985; c=relaxed/simple;
	bh=KnshcSSjPgWEKcRoguKRkHR8KeIvH8sTByntzoFaFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy4g4KJ/gKXuoytYF6ls0KUn1fN6iR7ECTHCADMV+yK1RDdRC97e6U2F2aHKoayRfUj889ofUQvwkcKpvmEIYcFcK8KDbtFrw7mvDWqfdh93vXApHMR7LuyD7SNMXaQxOs6mlMF9w+DqKAHKeuv/0MsutDsG3hq06pIlgUYDoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiGdvWAv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20223b5c1c0so46736965ad.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724748983; x=1725353783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCjpA1BkM7XAvfhNc3VnANr4WtSUCNv2xJfm2SvPqTg=;
        b=aiGdvWAvtwTFE24lYyjFqyUeCcb+TLREeHNipukypn6EvDdulIT9kwKJjIIVA7hSJp
         Zw80wXQkveCs/iMWfAp0igykj1dv790iSxJrsueLDQ+xWJNZBu6vuyfPUH6YtXAcdmU6
         JstcY3SNb/6co/8cuoF9tIk/uo9h6jj+qTmDXrYkeh4NJvDcc9PAiHyD0svhJXxAeg4I
         gsMt76Ivr1OVVlATZ6L+CK0snXKdIzd6S8scN2ovlsAtTSuSf6bGvsv2qBTGGA3hKPE1
         I0FURsQO+bDIb6XrZA2JOucHPgupyV1L/nWDnduZZOAfRX3xLwwMAD5vML5FekoJ5edK
         hAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748983; x=1725353783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCjpA1BkM7XAvfhNc3VnANr4WtSUCNv2xJfm2SvPqTg=;
        b=Ro0z6D443GONySobPU5qssAx9gCs4JVwoxapzZudteRwtzrRKiQg4lxyiAM3ESPt9K
         sLMFZ+irch2fkT4XvZ9YUPNNLSKV1tggOM3Qqeyvn2CXFYOuC0Nb0hwaLJRyGdt33iuD
         8g2DB7w33lJ7V1ppjd34wnca4zp/df37BIJ7MlBeJVLB7vFZnGUGc8JvywjgDzuFYDKt
         ZZb0aV4KQzT1ofqSlmDOl1yQM9KAecP5eZ/Vmd3/hUXn2LpFSpQuCfiAmpQz2krsfnk2
         qJO3q/nGVM6HMhJERFWXhX/A+0VmzOUV8rMe6WNkdfmi7p+Md9r9MOBTK4nuB5OlkMpX
         xrnA==
X-Forwarded-Encrypted: i=1; AJvYcCVzaQ+3dHVv5+S1u4xazjc66oaxK9SkjiOZMiYqCANiZ1rkVWMyeyfdHEEqJEt9WRv2QKt6GexRSk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ovtnFVpF1OQ620Q8qwGdX08YqDvznr2Ou5CgT7+VDlmM1x5e
	RdciY4q9zinfQTPfqJLy0naPIU5CCwTmUSfKg9CVzvV8bi0gDCzWOtzAC1SIzg==
X-Google-Smtp-Source: AGHT+IE1rgR8+yyQWa5wIANJNMpAX1XXUQS+uZ8+XMfk9HlE0GmezrZblJ8U8iol6/Rz0qEIFUedJg==
X-Received: by 2002:a17:903:1210:b0:203:a115:59a2 with SMTP id d9443c01a7336-204df50677fmr30875585ad.54.1724748982807;
        Tue, 27 Aug 2024 01:56:22 -0700 (PDT)
Received: from thinkpad ([117.213.96.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae512bsm78756345ad.259.2024.08.27.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:56:22 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:26:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI/pwrctl: put the bus rescan on a different
 thread
Message-ID: <20240827085616.v3xzrgyojxd746bv@thinkpad>
References: <20240823093323.33450-1-brgl@bgdev.pl>
 <20240823093323.33450-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823093323.33450-3-brgl@bgdev.pl>

On Fri, Aug 23, 2024 at 11:33:23AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> If we trigger the bus rescan from sysfs, we'll try to lock the PCI

I think the first 'we' is user and second 'we' is PCI and pwrctl drivers. If so,
it should be spelled out to make it clear.

> rescan mutex recursively and deadlock - the platform device will be
> populated and probed on the same thread that handles the sysfs write.
> 

A little bit rewording could help here:

'When a user triggers a rescan from sysfs, sysfs code acquires the
pci_rescan_remove_lock during the start of the rescan. Then if a platform
device is created, pwrctl driver may get probed to control the power to the
device and it will also try to acquire the same lock to do the rescan after
powering up the device. And this will cause a deadlock.'

> Add a workqueue to the pwrctl code on which we schedule the rescan for
> controlled PCI devices. While at it: add a new interface for
> initializing the pwrctl context where we'd now assign the parent device
> address and initialize the workqueue.
> 
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>

Don't we need 'Closes' link these days? I hope this is reported in ML.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With above changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
>  include/linux/pci-pwrctl.h             |  3 +++
>  3 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index feca26ad2f6a..01d913b60316 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -48,6 +48,28 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>  	return NOTIFY_DONE;
>  }
>  
> +static void rescan_work_func(struct work_struct *work)
> +{
> +	struct pci_pwrctl *pwrctl = container_of(work, struct pci_pwrctl, work);
> +
> +	pci_lock_rescan_remove();
> +	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> +	pci_unlock_rescan_remove();
> +}
> +
> +/**
> + * pci_pwrctl_init() - Initialize the PCI power control context struct
> + *
> + * @pwrctl: PCI power control data
> + * @dev: Parent device
> + */
> +void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev)
> +{
> +	pwrctl->dev = dev;
> +	INIT_WORK(&pwrctl->work, rescan_work_func);
> +}
> +EXPORT_SYMBOL_GPL(pci_pwrctl_init);
> +
>  /**
>   * pci_pwrctl_device_set_ready() - Notify the pwrctl subsystem that the PCI
>   * device is powered-up and ready to be detected.
> @@ -74,9 +96,7 @@ int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
>  	if (ret)
>  		return ret;
>  
> -	pci_lock_rescan_remove();
> -	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> -	pci_unlock_rescan_remove();
> +	schedule_work(&pwrctl->work);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index c7a113a76c0c..f07758c9edad 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -50,7 +50,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	data->ctx.dev = dev;
> +	pci_pwrctl_init(&data->ctx, dev);
>  
>  	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
>  	if (ret)
> diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
> index 45e9cfe740e4..0d23dddf59ec 100644
> --- a/include/linux/pci-pwrctl.h
> +++ b/include/linux/pci-pwrctl.h
> @@ -7,6 +7,7 @@
>  #define __PCI_PWRCTL_H__
>  
>  #include <linux/notifier.h>
> +#include <linux/workqueue.h>
>  
>  struct device;
>  struct device_link;
> @@ -41,8 +42,10 @@ struct pci_pwrctl {
>  	/* Private: don't use. */
>  	struct notifier_block nb;
>  	struct device_link *link;
> +	struct work_struct work;
>  };
>  
> +void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev);
>  int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
>  void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
>  int devm_pci_pwrctl_device_set_ready(struct device *dev,
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

