Return-Path: <linux-pci+bounces-12259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F69604A0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C47F2821FF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85616197A97;
	Tue, 27 Aug 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1M3jX64"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70114A90
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748021; cv=none; b=VEKrCYzEr2Fc18VVNtx4c8mEJyzjrm/B8V9Xh0ji9RuTQXkawOevKTncwsZV7aQ/AczecJLJDuwzbqwWpp2+EWqEzd9JcoakH4ejT+pbYJ09ZJKHI3T6BP8IYYc4vzG2uO3kC5Ndp87Ytq1V0QhiFFvLF4GFmaBVdhe+j9MYu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748021; c=relaxed/simple;
	bh=9QN525WlZ9Yo78qHKye9xARuQKaUPonHRP2LxByxEI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjCIh1UQpmE+CokjWw9q6e3vrSf53aseWCM1AORP7zyaBbIzUjYujtmRVJGtcM5O0/xoLqeXrkXEC34d5rsE+TdJiEYFDV/YbtB3mNVqQMGVTBS1HjVMeECZNWlcSRy5c1y4k7fO1ZpioPlBP2bQU1uMUImTxo7kYXsTGWgBnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1M3jX64; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71433096e89so4437818b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724748018; x=1725352818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W5DWQ30yzJUOL5OR+PUaG1BUHvOl8uCgiA5aV3iacTk=;
        b=k1M3jX64MIjnUEN7qmAYqW/1DnJyTYBYOVmqRAZ6JurokW2w0FetjuABcJAEdiXYBe
         1hqQWUxqp0DTAmSQvZMOBJpzuhSjGpQN8wo8a3CyOE9p6isgrqnpfMYpXVwfkvJo2r04
         Hyx9p6MnKwMfiq23y/Mg4P33LWDe4zzmUeQdfibmStwEKlIGrf4xd+KVItcGZoCjLb37
         vUyM1dUZFpZJgu80Fi8gKEgsSub3nxAFXPutqDyxaeVE2uMGhQzvcbE2WFY1Qf17PqaJ
         7HQoABLNxada2DR3pSvtVznde30I7Lvbpm7989jO5utH6Y1dC5dLrLeLlq8oYiAn+CtP
         SFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748018; x=1725352818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5DWQ30yzJUOL5OR+PUaG1BUHvOl8uCgiA5aV3iacTk=;
        b=ubFsyAUeMDwwD1H/Wz9UyYY9xvtU1QgAZQ7RtTDxDBzg7as4sbKbcaFhMUBunymYoJ
         QyU/crz1gLedpuQKobLA0cPLRqdctHW4JTbWjEXL0MfbXeh5/amUwPbzvsv+3NPMzjfv
         uw+rFFPiiIToj025M9qOWMk9MyMC1ss9WpaqacCwMTtNeTH0rTKrILotQhkodWlswdQF
         QGq7ESZrivm327vcJh1xLCPgFHNGjHsLXz/4CVR7zVTss5huF1SR+SYcJRz5lpWi8wiY
         PuYLrE0yIqsz6CIAgNf0rLMjYtbWSWOcv6TWWL+9U4V2CMXWO8oz7lgnC34rdZ9k8D5X
         mCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6w7CK4sqMZ6QdHDTjCBmaA5GHwHPlcNvEqyvSvPJfZifa0bBGwxIMhpVu9T+p7bjfFOsYosyzCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuq/MNbmFEoutTirfoDjVHJ2tCafNEl4DfwVBAFEqWyb2m9CIU
	e2Ua/fQdWFPTzVeCrRD56xcVBJ2AEBQC8O5hG4uUD5A34e0qHVF/4mY7d/wG/Q==
X-Google-Smtp-Source: AGHT+IG2iISKIuVAXaWnpPKXfM3PnhSGzIjpbXAu2gNEwo5d6yOloFEy2S4aiVBjPvBY9Z0qfA7pcw==
X-Received: by 2002:a05:6a21:e591:b0:1be:c5ab:7388 with SMTP id adf61e73a8af0-1ccc08f1814mr2112530637.25.1724748018278;
        Tue, 27 Aug 2024 01:40:18 -0700 (PDT)
Received: from thinkpad ([117.213.96.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203859f02e0sm78678985ad.250.2024.08.27.01.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:40:17 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:10:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
Message-ID: <20240827084012.rjbfk4dhumunhaaa@thinkpad>
References: <20240823093323.33450-1-brgl@bgdev.pl>
 <20240823093323.33450-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823093323.33450-2-brgl@bgdev.pl>

+ Rob

On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> of_platform_depopulate() doesn't play nice with reused OF nodes - it
> ignores the ones that are not marked explicitly as populated and it may
> happen that the PCI device goes away before the platform device in which
> case the PCI core clears the OF_POPULATED bit. We need to
> unconditionally unregister the platform devices for child nodes when
> stopping the PCI device.
> 

It sounds like the fix is in of_platform_depopulate() itself and this patch
works around the API issue in PCI driver.

Rob, is that correct?

- Mani

> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/remove.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 910387e5bdbf..4770cb87e3f0 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
>  #include "pci.h"
>  
>  static void pci_free_resources(struct pci_dev *dev)
> @@ -14,12 +17,25 @@ static void pci_free_resources(struct pci_dev *dev)
>  	}
>  }
>  
> +static int pci_pwrctl_unregister(struct device *dev, void *data)
> +{
> +	struct device_node *pci_node = data, *plat_node = dev_of_node(dev);
> +
> +	if (dev_is_platform(dev) && plat_node && plat_node == pci_node) {
> +		of_device_unregister(to_platform_device(dev));
> +		of_node_clear_flag(plat_node, OF_POPULATED);
> +	}
> +
> +	return 0;
> +}
> +
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> -		of_platform_depopulate(&dev->dev);
> +		device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
> +				      pci_pwrctl_unregister);
>  		device_release_driver(&dev->dev);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

