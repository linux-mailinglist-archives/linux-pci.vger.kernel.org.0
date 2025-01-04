Return-Path: <linux-pci+bounces-19300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EEA013EB
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D9B3A42AB
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D0884E1C;
	Sat,  4 Jan 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pyFIwVN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502014E2E2
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735986215; cv=none; b=UhtZGl9gVP7Q2vXTrrtFyFhq86e7FuTTzpKxVhF2gC0YnRpbstgUb8J+sEHXlOl7C5951eW4f+4csgD+bt/DjayrTFk1LHlD/kymdrQjHyrx57DoLqme2jw4LVBeBV9l4A13e2Lx2eZBDmytkcoO5PAAJ7JgAk7wJoTFtsE7t2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735986215; c=relaxed/simple;
	bh=Fdf1rjpjA6sxjXaV2e0oeC/d7EbPbdaM3pY/SSgVVFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwOsukl0DGjV9WmNjXoAUPjyGxOvWFKWvKfNnPFbKsOOHablzgqMQrmuEbMdFs/Ny/SiHD4+rNQDzRwPHy3dG/t4rzy5VcAC9hxjxZUwrHAKfsBGhoXR4jNrvUWaN4ThCq4eGbWH/5/SbkDTeR8NsHBweC+w9fF/DP/nu/tg+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pyFIwVN8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21670dce0a7so108778175ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Jan 2025 02:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735986213; x=1736591013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d7WWzM81eH7w8ivFPUo0nbOJxsERMoQeN/4oy/OiqOM=;
        b=pyFIwVN8oIktyB1u2mXkK8eqFTOVEVbOBNfwfu/5YQxjWP5WqoaT382hBoA5WfLbQ7
         ESO3fy9qaAYRfA23Jz+NZIRyg+tKFP7FDyNeuJ699rDmwRM7IhZc6VSmTOC2DTWMoTV2
         J4kgRECsPU+oPoOOw5n2DMkvAU5QCW6Ne13kl/MMUvsiEZisk5KrGb89hCp4rbt2JqSZ
         mQoGlcA8zZRwfWQw7BiLT9lTJ3mFX1PeyiI5hme4IGUO9sURDSy4mcIYR9WcHuUGWfBN
         7lv+ybG4BvxV1KjQRUkuPvRg3BWStwQks0dsp/S5cg0nkLHAiqfuzYMGQZ33Wj8GwVm7
         +0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735986213; x=1736591013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7WWzM81eH7w8ivFPUo0nbOJxsERMoQeN/4oy/OiqOM=;
        b=HY4hg7L4EFG7anoaakAwOAk8DjYWZByU1GF4Z9nNe0E/LMj828YuAc5LpUPYJBiiK1
         F8NPTOaLTlzfvESVxjLpX7p/dyU0/BhnjXt/RcL5xwRIIDqqre7L6Fq0U0lmQvLHalhF
         oZs1H4ZeJLPHpczGHUb6QyqReycUYw7ptRMK2Zl7lBHJ/ROKW+jAHdOHLkrGI+cGJEsw
         qcOo82KZ9ob2cI+hdQercW73VjAIprt0aEg1n91xrd4cXpF0m94EHhUx9bx8/iNTr9pD
         eeeEd2aTMQjCYXlvDAWwXmphKCz/zTkOe2WWPPzeMPFwFjmoWnUBg+SkWQ5iuRZaii/v
         DZgg==
X-Forwarded-Encrypted: i=1; AJvYcCVwauGJ/1ZxZjBTNqUriqY8sUKs1Xvg5cFdVVn1EYtaWhU3/8/Odwf6+TQ5ZjWvh3nV8RvDi5isM9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSrcYQi8GplxDMbWTyFIGFuR4WYEylocOEO182JEZ7jyac+Vf
	10liTHK3NVvtZG/R1dJW6HtsP38TY197nL0iFosXOU0/3K7FVHS9Zu9Yyf+BTA==
X-Gm-Gg: ASbGncuZf0k//Lij9vhj53bo7O6gZKqCYoowNiNA7NDMJ4izZAahrkULNC5gbuuS4TD
	0Tn7xUV1qJteVXRR4m5CpcY4JrASKVtwdYunv7s9ovpjnz79UXEbN/kn+ubFbqbBnfWWZ/ONmqN
	yRMghpIkzJfg+wfpSIFhb/67MUz6iu84mvs5Pzj1XG0ToTEUrcvyigWRCJda2wPjOfLEiciyel9
	OCefVm1bk3bnjlgZgdzQRWQgJVtYrqUM0i1PVKhmfDnBfwiiTz5dUVSf+akarUK4Vw=
X-Google-Smtp-Source: AGHT+IGcYitKOORgbvygOZzt0NgzHQbBY9dbcSLI15yYAQJ/pt0tykyK+M3h+WkGeOApZbx9WoujYg==
X-Received: by 2002:a17:903:320a:b0:216:6901:d599 with SMTP id d9443c01a7336-219e6e9e86emr788176895ad.13.1735986213063;
        Sat, 04 Jan 2025 02:23:33 -0800 (PST)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962bfasm258736595ad.2.2025.01.04.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 02:23:32 -0800 (PST)
Date: Sat, 4 Jan 2025 15:53:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH v2 6/6] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
Message-ID: <20250104102327.fxswvs3dvsixbsh3@thinkpad>
References: <20241231-pci-pwrctrl-slot-v2-6-6a15088ba541@linaro.org>
 <202501020407.HmQQQKa0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501020407.HmQQQKa0-lkp@intel.com>

On Thu, Jan 02, 2025 at 04:56:44AM +0800, kernel test robot wrote:
> Hi Manivannan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 40384c840ea1944d7c5a392e8975ed088ecf0b37]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/regulator-Guard-of_regulator_bulk_get_all-with-CONFIG_OF/20241231-174751
> base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
> patch link:    https://lore.kernel.org/r/20241231-pci-pwrctrl-slot-v2-6-6a15088ba541%40linaro.org
> patch subject: [PATCH v2 6/6] PCI/pwrctrl: Add pwrctrl driver for PCI Slots
> config: x86_64-randconfig-074-20250102 (https://download.01.org/0day-ci/archive/20250102/202501020407.HmQQQKa0-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250102/202501020407.HmQQQKa0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501020407.HmQQQKa0-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/pwrctrl/slot.c: In function 'pci_pwrctrl_slot_probe':
> >> drivers/pci/pwrctrl/slot.c:39:15: error: implicit declaration of function 'of_regulator_bulk_get_all'; did you mean 'regulator_bulk_get'? [-Werror=implicit-function-declaration]
>       39 |         ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~
>          |               regulator_bulk_get

Sigh! The driver was built with !CONFIG_REGULATOR. This requires fixing
'include/linux/regulator/consumer.h'. Will add it in next iteration.

- Mani

>    cc1: some warnings being treated as errors
> 
> 
> vim +39 drivers/pci/pwrctrl/slot.c
> 
>     28	
>     29	static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>     30	{
>     31		struct pci_pwrctrl_slot_data *slot;
>     32		struct device *dev = &pdev->dev;
>     33		int ret;
>     34	
>     35		slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
>     36		if (!slot)
>     37			return -ENOMEM;
>     38	
>   > 39		ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>     40						&slot->supplies);
>     41		if (ret < 0) {
>     42			dev_err_probe(dev, ret, "Failed to get slot regulators\n");
>     43			return ret;
>     44		}
>     45	
>     46		slot->num_supplies = ret;
>     47		ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>     48		if (ret < 0) {
>     49			dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
>     50			goto err_regulator_free;
>     51		}
>     52	
>     53		ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>     54					       slot);
>     55		if (ret)
>     56			goto err_regulator_disable;
>     57	
>     58		pci_pwrctrl_init(&slot->ctx, dev);
>     59	
>     60		ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
>     61		if (ret)
>     62			return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
>     63	
>     64		return 0;
>     65	
>     66	err_regulator_disable:
>     67		regulator_bulk_disable(slot->num_supplies, slot->supplies);
>     68	err_regulator_free:
>     69		regulator_bulk_free(slot->num_supplies, slot->supplies);
>     70	
>     71		return ret;
>     72	}
>     73	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
மணிவண்ணன் சதாசிவம்

