Return-Path: <linux-pci+bounces-11702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F99537BA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD0B1F21BCA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F51B29AD;
	Thu, 15 Aug 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzVzhOtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99441AB521
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737558; cv=none; b=dKTKmfveViPORbukKaEDTyq0Dktui5QxPerC9kvNe5tYhzk8jxH/fqYMqkK+GBhVOIHdY5fTZ/mV/LNh1TnZQwcQLEGlE/riUeqfMqYFx7tEUZxQKl6wFZ3BrqvygIm1s4Vt7Y94lYVPUa9cjqm+f+6tLOLgiHROqyMOe9y9smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737558; c=relaxed/simple;
	bh=Z/fyRi93/FgvuhZIwHmKOmN49p2qBtOwlI7YvJ6Mm3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8sj/0qq35vVUhxeqCQWCcAKX1KIO5yq8Fxf5sno7cPeW5erWJPl/HujnGo4lMQX5NPLDEuWY4dBG37jQNR3i7eaQn64A9wsf8n8KqE+io+XpF2ykRT+DPwEr+7wdKkXOCe5Z+YiZExVlOA/SiX0DVwSIvBs2g4k1L/4ngOW/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzVzhOtg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso916683b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723737556; x=1724342356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Go1TBNFKLXqY7P67ovoHUjFQplVz6G9uJaPMlcb/pTE=;
        b=bzVzhOtg9IAvBisJHwbZCN41rlvYmy9NtseOS5883Y+FJ3gd8yULsv5KpIZOgKiuyq
         GZiZox/W1XezNRchxrw+l7W8Hrt28Sd6oQaO6Fghb92KOGJp3uzYSdwIfIHvhB9+roqK
         QRH8T1M1n5gGtMt/uUEP/myVJc1uGfJACzQZ9Nuz3nw/BevV6/umhpeaHW57aqKu04RV
         0BeHlbO3aajVLk5Y9ih8LWyenX8WuolWYpiXTldwnE0QdvC/WSgoq7xevBsNYn408qkd
         4t2hrgDzUd0BRUvree7ZS1bAFBltKYZTTVB5yYGQBQUYktErI7eIr+pnqBPSQfD+FKxG
         pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737556; x=1724342356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go1TBNFKLXqY7P67ovoHUjFQplVz6G9uJaPMlcb/pTE=;
        b=wj+EI3xMP/pWZXUW+3vaiLuCESpN7g2PNIlcl8hz3GrvH6626yQJLzJROPIp3XPnBx
         1kCIr/Yhh/GSGYSnlzOdQttgErjxRMTb2/qNHJX7EbEihchNAflufT42XHgpRowWkeLq
         EIiG+G10qm2WdKddDSJmkLNUF6RYWYSOZpo4BUt/+p+4BIDivI5aXogmE9iG32xqWeR/
         6liXjgFRpA6PihEORmw+T2lo1hYpjy58sKhAEjgGamPrCrApAoVStp2tNF1FYuKSELAU
         lXI7A+wyWFtflcuk7WQEIlrM9nOiqolHyr9/KvM4k5zDitSigZC8+EqUa7yhhNru0V2I
         ZeuA==
X-Forwarded-Encrypted: i=1; AJvYcCVKn8T8qHWCvnoT/pYb7wsDgS+Fc2nyS/tMT1vWF5v2oYqk3AlFz2lWB8WMi2aEyvrxswXNOmIddHzqcsukyIJAGfw0oFpeNM9L
X-Gm-Message-State: AOJu0YxIGaOck7ydTnABE/hoLqp/nECfb3Bbf1/c61CKpBdtJfP+O2ST
	7qm2dWhaU1UzAtb8vPFYY/ROAnl918/bbnMwEc5Th1zBhnbfG6bGddszQcaCdQ==
X-Google-Smtp-Source: AGHT+IGk4qceJ8StUFPW4JHw1XS1cn4wjioyj97u+D8ec4AIR96mMNUmXxt7TcNKR/bC4iSHsI2ajg==
X-Received: by 2002:a05:6a20:9f90:b0:1c0:f529:bad6 with SMTP id adf61e73a8af0-1c90505350emr174630637.45.1723737556019;
        Thu, 15 Aug 2024 08:59:16 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0393684sm11660685ad.239.2024.08.15.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:59:15 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:29:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kernel test robot <lkp@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <20240815155909.GD2562@thinkpad>
References: <20240731-pci-qcom-hotplug-v3-5-a1426afdee3b@linaro.org>
 <202408111053.0PLHSTeH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202408111053.0PLHSTeH-lkp@intel.com>

On Sun, Aug 11, 2024 at 10:47:08AM +0800, kernel test robot wrote:
> Hi Manivannan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-ep-Drop-the-redundant-masking-of-global-IRQ-events/20240802-024847
> base:   8400291e289ee6b2bf9779ff1c83a291501f017b
> patch link:    https://lore.kernel.org/r/20240731-pci-qcom-hotplug-v3-5-a1426afdee3b%40linaro.org
> patch subject: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for endpoint controllers
> config: microblaze-randconfig-r072-20240810 (https://download.01.org/0day-ci/archive/20240811/202408111053.0PLHSTeH-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 14.1.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408111053.0PLHSTeH-lkp@intel.com/
> 
> New smatch warnings:
> drivers/pci/endpoint/pci-epc-core.c:843 pci_epc_destroy() warn: inconsistent indenting
> 
> Old smatch warnings:
> drivers/pci/endpoint/pci-epc-core.c:908 __pci_epc_create() warn: inconsistent indenting
> 

Krzysztof, will you be able to fix the indendation while applying? If not,
please let me know. I'll spin v4.

- Mani

> vim +843 drivers/pci/endpoint/pci-epc-core.c
> 
>    830	
>    831	/**
>    832	 * pci_epc_destroy() - destroy the EPC device
>    833	 * @epc: the EPC device that has to be destroyed
>    834	 *
>    835	 * Invoke to destroy the PCI EPC device
>    836	 */
>    837	void pci_epc_destroy(struct pci_epc *epc)
>    838	{
>    839		pci_ep_cfs_remove_epc_group(epc->group);
>    840		device_unregister(&epc->dev);
>    841	
>    842		#ifdef CONFIG_PCI_DOMAINS_GENERIC
>  > 843			pci_bus_release_domain_nr(NULL, &epc->dev);
>    844		#endif
>    845	}
>    846	EXPORT_SYMBOL_GPL(pci_epc_destroy);
>    847	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
மணிவண்ணன் சதாசிவம்

