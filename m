Return-Path: <linux-pci+bounces-3292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B484FA76
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 18:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EBB1F21447
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0C74E33;
	Fri,  9 Feb 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgR9OMU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164621D682
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498149; cv=none; b=FnexSSCeNNNQb3BG7N1DrUYmWFyW9Pgx7C6INYZCJAQeoKQfEYC+ioIfuOjnRPlHoZdvzFymcWXphbENvz3bxaLpVMLdzqASr977Mfs0mta49XadADl6VB59c/wMLCKMFLr9c694c2hdH/zkMN0W7uNwqVmgA3QmyCWz44Lp/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498149; c=relaxed/simple;
	bh=lnhEn9vY6QlxiFk2rpKMoidP2MF7gVLrYSZhxeR+9kU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RMg6knIf2dcDG4ojSKA5V6LzKDPVWELNib0EMNkGE1mTTsGAzUoDgCjGa8mXl79+zV0DM86p6MqVQEzPfsoNviGBdR3nZyTDWDWTJj6HWuxWhm/EkNqxbHEwFmjatpaOcwL0+ZELVsTwy7qIpXmLNP1Ufo6qmKuPZnBk72qMfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qgR9OMU/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so3584169a12.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707498146; x=1708102946; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZYxkJvmyvwo7sccM5VPUtTxUyq0KncuIUTdYNLgjm0=;
        b=qgR9OMU/W8owym3o8nEcCrhdn2rFSK3c5TrF2jzqbvBiS8FsNmMcVMPuc73CwVjZLX
         AYlBWPWvrTighjRia0DNMj9EMhjmS8vP/ou0og1h1y7meoJQKLPA6njaleHlugAt5+Kf
         45D/ZxHzZ/9BXwXtV6CnWpnBVvrvwwBEL0/J7nTNptIaNnC10wfKBBePLFimDgxs1V7V
         xMRXz1qincQhb/NnKQvsardp58IaWE7zBSbayk7J21bHC/S0E6QHF3/l+a7M7VOan/xr
         lgVIgDsJ5QJhRNruCiadixjG71NnVhQXAjCpwEV+7SgDijJpUTfPQ+1aOmQKiRNiDHgK
         JrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498146; x=1708102946;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZYxkJvmyvwo7sccM5VPUtTxUyq0KncuIUTdYNLgjm0=;
        b=SlKfEDcklOg9V5HNPwaDPOdcQVXoBL4XFhvC+1qTWqaSNUMPD/Ogmt8LMJQ4ZtMW/A
         H3YSa/lFYbvhBfk0Oey+qpqvZpJVwuwUv8FAjF7QDA5UkHiZ95Pah2wwFI36yHPTyvii
         RXvniYWv3+KhcTduQkyxNwNt7AeaS6xkQUm+qPgOBL6GRwY5oMXwX9zME9CJO9Jr2poh
         CNBQkwMGKPt6QnO8PYfWyzlgMyGQG6N5YDHCjRRozzO1K0hMfurZQoj1UkMSXSiyLY/N
         pt3mZZ8j7zfHbYANqcZVl5zLLcpvHdQHd7gdQMnRSvhqoKtWQNl4ANXEB4tEEGmZFkNE
         /hvA==
X-Forwarded-Encrypted: i=1; AJvYcCUD+hrCmVOtxOIRTgsi/x8LNEElLvnQmi765PzWnu4iwGl5/RdzWhECoU5MQ9MYRk/+EVutqCel1k1n1Imdgo1Ul2wQoAuQg80Z
X-Gm-Message-State: AOJu0YznWvEiPk0dCoFrIfaRphKlD3x/H1/ZnByCl7WQMvA4G8lMOsCv
	YVa28WWF9vOrdLrlM+2tYEmUERGFjpsr66LnaUhEaZFg6fPAtjd6P4zRGQVXJKs=
X-Google-Smtp-Source: AGHT+IEPsqXgXKcs68otjzIQp/EHpgEv+qOgU4M4KwBEoT0L0vU4N0DPI8e2G3PMVJ/OvZRFwXvBVg==
X-Received: by 2002:a05:6402:54e:b0:560:a95:5271 with SMTP id i14-20020a056402054e00b005600a955271mr1560824edx.5.1707498146318;
        Fri, 09 Feb 2024 09:02:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTJ6byOiY5/ZTv1DsPdr4JBmrnUlxJ30Wv3YwT6xIzX6fTBUu1lnOlQByeHBIG4JXLwzQbctLP5LRlCqIMgedqDVi+C4IF3LKcmyE4Q5yo4/CIMtAIbOuc5OZip+26NT4orG+/lPrQ9mJfkieK22hZ9UIWKujh8OdJd6FQyn6Dd4fD5wu3S2EdsiUr99ZB7ZS1Bs2Zt2ByFxiQNKe4jZKQeKNzKphPLhxoC6vbU1UL9kNwR3YO/NOfOUk9D/hVXW+yPAoc1D00dbs=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e16-20020a50d4d0000000b005605716e755sm993471edj.52.2024.02.09.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:02:25 -0800 (PST)
Date: Fri, 9 Feb 2024 20:02:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [pci:endpoint 3/5] drivers/pci/endpoint/pci-epf-core.c:275
 pci_epf_alloc_space() error: uninitialized symbol 'dev'.
Message-ID: <7ea6ca33-3954-43a0-a9b8-a09c5db095b6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
head:   f7bcec825e728e0baecf96118e36c8afb7b93f8a
commit: 6441639b8a253254b00d7ccfbc2c9c67a8f42d10 [3/5] PCI: endpoint: Improve pci_epf_alloc_space() API
config: x86_64-randconfig-161-20240209 (https://download.01.org/0day-ci/archive/20240210/202402100046.9zcFnPl3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202402100046.9zcFnPl3-lkp@intel.com/

smatch warnings:
drivers/pci/endpoint/pci-epf-core.c:275 pci_epf_alloc_space() error: uninitialized symbol 'dev'.

vim +/dev +275 drivers/pci/endpoint/pci-epf-core.c

2a9a801620efac Kishon Vijay Abraham I 2019-03-25  259  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
e891becdccaa90 Niklas Cassel          2024-02-07  260  			  const struct pci_epc_features *epc_features,
e891becdccaa90 Niklas Cassel          2024-02-07  261  			  enum pci_epc_interface_type type)
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  262  {
6441639b8a2532 Niklas Cassel          2024-02-07  263  	u64 bar_fixed_size = epc_features->bar_fixed_size[bar];
e891becdccaa90 Niklas Cassel          2024-02-07  264  	size_t align = epc_features->align;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  265  	struct pci_epf_bar *epf_bar;
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  266  	dma_addr_t phys_addr;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  267  	struct pci_epc *epc;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  268  	struct device *dev;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  269  	void *space;
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  270  
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  271  	if (size < 128)
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  272  		size = 128;
2a9a801620efac Kishon Vijay Abraham I 2019-03-25  273  
6441639b8a2532 Niklas Cassel          2024-02-07  274  	if (bar_fixed_size && size > bar_fixed_size) {
6441639b8a2532 Niklas Cassel          2024-02-07 @275  		dev_err(dev, "requested BAR size is larger than fixed size\n");

"dev" is uninitialized.

6441639b8a2532 Niklas Cassel          2024-02-07  276  		return NULL;
6441639b8a2532 Niklas Cassel          2024-02-07  277  	}
6441639b8a2532 Niklas Cassel          2024-02-07  278  
6441639b8a2532 Niklas Cassel          2024-02-07  279  	if (bar_fixed_size)
6441639b8a2532 Niklas Cassel          2024-02-07  280  		size = bar_fixed_size;
6441639b8a2532 Niklas Cassel          2024-02-07  281  
2a9a801620efac Kishon Vijay Abraham I 2019-03-25  282  	if (align)
2a9a801620efac Kishon Vijay Abraham I 2019-03-25  283  		size = ALIGN(size, align);
2a9a801620efac Kishon Vijay Abraham I 2019-03-25  284  	else
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  285  		size = roundup_pow_of_two(size);
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  286  
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  287  	if (type == PRIMARY_INTERFACE) {
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  288  		epc = epf->epc;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  289  		epf_bar = epf->bar;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  290  	} else {
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  291  		epc = epf->sec_epc;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  292  		epf_bar = epf->sec_epc_bar;
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  293  	}
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  294  
63840ff5322373 Kishon Vijay Abraham I 2021-02-02  295  	dev = epc->dev.parent;
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  296  	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  297  	if (!space) {
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  298  		dev_err(dev, "failed to allocate mem space\n");
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  299  		return NULL;
5e8cb4033807e3 Kishon Vijay Abraham I 2017-04-10  300  	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


