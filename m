Return-Path: <linux-pci+bounces-12069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A6195C676
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 09:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E378284999
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B713C3F6;
	Fri, 23 Aug 2024 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImVFoA92"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F38131BDF
	for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397830; cv=none; b=b+Vxr0uQCun1qJ00SCPwsxNCdNOHAwkV31bbg4QmTbOTpBlZjIrgrl0MtnFSkpWQIOcdMS8D5sl7JqB+x0qbHkPJur6xBIdjxjfG+cVIvYwQteOaBYZMXvijqTJrZ6kOruHpiFKk+6nbaOHfWIC40uGRg5oLXT8DU7t6kZ8DnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397830; c=relaxed/simple;
	bh=iHS7rbkShMfUPZAmnOlThc8ibOAJHNhxRONLIiuqN58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9SVe7I8XXmmkCFrbiN+P5MKL4LaFksJ0PtsZKmP4yZgt9JGA0cgV+sE4GkuWGkuVQoK2zXfidyfDANRUTU3+sBJuoflVMK9cefYXPUwrFPk9GAtfBpEcGnhMQ9buX+39Gj7GxUXfA0gbnYcTscmuAasCmPftDj6gVxPzFNbFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImVFoA92; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714261089c1so1170474b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2024 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724397827; x=1725002627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v5ElHlHRIu5slLIV+mCF9JmI6Y4XWgj6Cd25Jej8q74=;
        b=ImVFoA92UV7EnvWgPwjqfgKN4wepkAlm5LIwHeugg4xcYzebSHenKmF8kVC6LyVqOZ
         DQN3iIi+Vw1KdBNszlAUeP4jDCqXEZn9ndyFHyPJeygxKJmzWqeZTgYa25hPODsdP8AG
         jzR5exz0hBUE/YRWzKONVSWRj3Mo2REiQ3Witi5mZ5fNqkse24FDLLrgLk4z9Bqqbzku
         sJHvK2SQGdCwxOoZuSzgIPjGVcZ6QNQKqHwYSPM6srEqxDhG7pCdKOdLHiG7V7DG8IHG
         sPGDZHi0jECaXZBlL70hgXJZEZiAOy4ON66JNBdGQUftzMdxx5JBNER3MWyiQuu4oPX2
         8Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724397827; x=1725002627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5ElHlHRIu5slLIV+mCF9JmI6Y4XWgj6Cd25Jej8q74=;
        b=Q/kXRWNkBcZG5pbKsYSWUhnApe9QEFtSGG1RH/DJZavT86KdFjW2h04CnnI8IRayMf
         FsOAVm4tBi+T6Fb3jvUqovCz6+t3uSTgT3YKXXfVqO1Px/Vr5vPb45x1spGgrXSpgdBe
         9NpdENwT3fPvU6YLqosdSicvDj5lnKpw3DlhyzkbjrWxZbfTbnzPffFk7xQn+R4KD76D
         q3kGZG94DheoePc8e0cR6vkeO0pCIYHRq1095ZXUof0b4mfN81SqzD2MCTHklv56IBfy
         a/6muM3mHEKAFICOaisngbogOnlOlBF2SlZibFxj0kowNYgtem0uaPmscwU1tH2Zq/m2
         ux0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMOGXl0CHjzj6iEcL5yuRxEBtWf8MsVX37XKRAsXv7ZFlvkeulb48V6Th9HHdvcx9CYm0RRlSYUUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5FUdWm/SmeKnTDbRYboWjFQz3m1KhSDwzsLmk01OOOvtMQOI
	R5VLPnQXFfWZjCa2pSqaJBJc/Xu2jCIHthhJR8CUyVG2vFzWNrGJCOd6FF6FAg==
X-Google-Smtp-Source: AGHT+IFci5MVjwKGKSuKLPiYMi40vitXCDqOaX7wyqWrXkZSVfN3mDYsFqyHTQR/+iLqpPsiZXbVXg==
X-Received: by 2002:a05:6a00:2fce:b0:70e:ce95:b87 with SMTP id d2e1a72fcca58-7143162f704mr9396156b3a.0.1724397826876;
        Fri, 23 Aug 2024 00:23:46 -0700 (PDT)
Received: from thinkpad ([120.60.60.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e03a3sm2510295b3a.140.2024.08.23.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:23:46 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:53:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jingoo Han <jingoohan1@gmail.com>, andersson@kernel.org,
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent
 pcie hierarchy
Message-ID: <20240823072340.qcd6afkgwssr4muw@thinkpad>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-4-9560b7c71369@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803-qps615-v2-4-9560b7c71369@quicinc.com>

On Sat, Aug 03, 2024 at 08:52:50AM +0530, Krishna chaitanya chundru wrote:
> Currently the pwrctl driver is child of pci-pci bridge driver,
> this will cause issue when suspend resume is introduced in the pwr
> control driver. If the supply is removed to the endpoint in the
> power control driver then the config space access by the
> pci-pci bridge driver can cause issues like Timeouts.
> 
> For this reason change the parent to controller from pci-pci bridge.
> 

Also, what if the PCIe controller driver tries to access the device? Like for
sending PME_Turn_Off etc... during suspend? I think you should also make sure
that the suspend callback of the pwrctl driver has to happen _after_ the
controller driver.

Still the parent-child hierarchy is not going to change, but only the devlink
part.

- Mani

> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/bus.c         | 3 ++-
>  drivers/pci/pwrctl/core.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 55c853686051..15b42f0f588f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -328,6 +328,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>   */
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	struct device_node *dn = dev->dev.of_node;
>  	int retval;
>  
> @@ -352,7 +353,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>  		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
> -					      &dev->dev);
> +					      host->dev.parent);
>  		if (retval)
>  			pci_err(dev, "failed to populate child OF nodes (%d)\n",
>  				retval);
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index feca26ad2f6a..4f2ffa0b0a5f 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -11,6 +11,8 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +#include "../pci.h"
> +
>  static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>  			     void *data)
>  {
> @@ -64,18 +66,23 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>   */
>  int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
>  {
> +	struct pci_bus *bus;
>  	int ret;
>  
>  	if (!pwrctl->dev)
>  		return -ENODEV;
>  
> +	bus = pci_find_bus(of_get_pci_domain_nr(pwrctl->dev->parent->of_node), 0);
> +	if (!bus)
> +		return -ENODEV;
> +
>  	pwrctl->nb.notifier_call = pci_pwrctl_notify;
>  	ret = bus_register_notifier(&pci_bus_type, &pwrctl->nb);
>  	if (ret)
>  		return ret;
>  
>  	pci_lock_rescan_remove();
> -	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> +	pci_rescan_bus(bus);
>  	pci_unlock_rescan_remove();
>  
>  	return 0;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

