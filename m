Return-Path: <linux-pci+bounces-19342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA459A02AFC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AD91885BA7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405958634A;
	Mon,  6 Jan 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKusq9io"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED2DF71
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177959; cv=none; b=fPqLUTP374SWOrBV2NLgBPqmG2v5VZNZjOs5husIM5Jl4akNojghxoneztfiEyc9GBXBo/fOkGVh4mWEBfxwG2JEQHeFqxFk2H0PF6ME1rvyOjusHYA359NKu/662kB/3B9esWJMWpXgFVhtSafBeR3vNtjl5D+gyhu89AlfAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177959; c=relaxed/simple;
	bh=6FTeL7J9W/8v/MFftWkYANi3oEghJQhAORIbcFv+bpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2Nv2E7yWpldRjAHZ9iKVSz0AEN1C90fVYUIqM4MQyJJl/fDdHiGaOlGB1Pb8jo4ghTk3I00qUDIUnN7H+QZ+k1fsSzZxYol5NsyTj0zKkB8gcdnBoPH8F0bcgALVmVCxEdUG7fN/k8s7TIzQlLm6ZdcEo5LLM4ovMzUzI27rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKusq9io; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so26056424a12.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2025 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177956; x=1736782756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjInjQ8EYFWqvY7RVufEqpVSTgGfiOzA1xoY/iPL4eM=;
        b=GKusq9ioBeBSsSHh3W65CEtb7vowlSru2FAaGRPAjrRxO/9+XTFv5Ufjh0j+wlyad4
         Ui7irwkbnz28pk0q71zeN2CXZ/ojWGWOw+6STLf8lfvh81EjM/wc3n1IjppRnXS/4Vdz
         s9PHzaPYktjDSkiGowdkNL2Va6L12vjh/ZLEEukDfBaIuuT+kTSxwanF1VUh312PM0fu
         +sq+rnWOX5lqNrRw2pU++JvVk2C6b/9DhhPbVEm2y/6Oy0XA/ynS95CIgsIseO/16tNP
         W3TJnEX826Hg+mMISElOfogIN59TyV8WDCkPTSwsLBbc19Z0M5r9MaNV8T0lHjMfPyCt
         WmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177956; x=1736782756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjInjQ8EYFWqvY7RVufEqpVSTgGfiOzA1xoY/iPL4eM=;
        b=Fx/W3BZfbc6/7UxJ9MnnA676VjzabBjMFLi22SvP2SvyAPcFxrSL4szJpvfH4jw/Hp
         JbD9S+2d9OiSFo0rUG/pRoOZSXqIoyDo3FQUOyoSXuXKBUHCBC8mrNlKSqn+kmaP8yxC
         IAFdLn7ot/ivswcQF+cAC8W1S5KV+9OUEsMo9UJF4aquc+cRFw733FVRdiuUruRSvJbM
         O5RSMCC0yjnjFEDMqoBFbKcTyPjMyVtX0WlIM1idSB1W8MXlYWUpY6iKTn+XzayDo7dD
         26sQmLXzOAkzgvMlzYKLUqpoRRfPUpd7u/0P6s7AhG2WN1H1EJCFWssko8p1vvnJMmkt
         iuvA==
X-Forwarded-Encrypted: i=1; AJvYcCUFpH+44f21VQwFVz0F32aA9P053feRFnw8u3vAwrVGR0Atitl2FKH2PxJah0DHreVT89jiq8DT+fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+DW8suIISBLqWXhwfnZBE6dXHHo86d45i6DNUHQMXVSvuUpy8
	iJPEAtRVCaPGBBKEid33TJzHfQDLxnpn5h74b7e/R91JeIQDpI3JEctGpx6HqHwuzpKhpqPtPt4
	aSHoKVJP4ifjKQw6hcK7hWTU29Xm5BdpTT/s=
X-Gm-Gg: ASbGncsabyi8hYYPa5ZhWHO9sSLr0Bt9EAGOHtJ+GJgRGyUaqSbBtK+hIUSG4MNWH1m
	B/6ERkD73/+KNHA8bSkXaUi1Ux8dWoUIy5qkl6A==
X-Google-Smtp-Source: AGHT+IEGN1GdG+i3TIHVGvpAsiqTdVpoXIFMSYU+j0qxRCJAVqb+OjpdIo8gZVE36TK6MxTksPlnEo2hd8k6w5btTAA=
X-Received: by 2002:a50:cc04:0:b0:5d8:a46f:110b with SMTP id
 4fb4d7f45d1cf-5d8a46f1123mr28655123a12.17.1736177955405; Mon, 06 Jan 2025
 07:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc020ef3-e48a-42cb-aa4c-81d46ebac338@stanley.mountain>
In-Reply-To: <dc020ef3-e48a-42cb-aa4c-81d46ebac338@stanley.mountain>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 6 Jan 2025 21:08:44 +0530
Message-ID: <CANAwSgRzexcPSwJxORxG9FSuCXCeKHSCa90brmG0bX-jD9DoZQ@mail.gmail.com>
Subject: Re: [pci:controller/rockchip 1/3] drivers/pci/controller/pcie-rockchip.c:134
 rockchip_pcie_parse_dt() warn: passing zero to 'dev_err_probe'
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Mon, 6 Jan 2025 at 17:09, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
> head:   8261bf695c47b98a2d8f63e04e2fc2e4a8c6b12b
> commit: fa0ce454cd4ee35703d4126c5b8e4a9a398cf198 [1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
> config: arm64-randconfig-r073-20250102 (https://download.01.org/0day-ci/archive/20250104/202501040409.SUV09R80-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202501040409.SUV09R80-lkp@intel.com/
>
> smatch warnings:
> drivers/pci/controller/pcie-rockchip.c:134 rockchip_pcie_parse_dt() warn: passing zero to 'dev_err_probe'
>
> vim +/dev_err_probe +134 drivers/pci/controller/pcie-rockchip.c
>
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  115     rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  116     if (IS_ERR(rockchip->aclk_rst)) {
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  117             if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  118                     dev_err(dev, "missing aclk reset property in node\n");
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  119             return PTR_ERR(rockchip->aclk_rst);
> e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  120     }
> e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  121
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  122     if (rockchip->is_rc)
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  123             rockchip->perst_gpio = devm_gpiod_get_optional(dev, "ep",
> 840b7a5edf88fe drivers/pci/controller/pcie-rockchip.c Manivannan Sadhasivam 2024-04-16  124                                                            GPIOD_OUT_LOW);
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  125     else
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  126             rockchip->perst_gpio = devm_gpiod_get_optional(dev, "reset",
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  127                                                            GPIOD_IN);
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  128     if (IS_ERR(rockchip->perst_gpio))
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  129             return dev_err_probe(dev, PTR_ERR(rockchip->perst_gpio),
> a7137cbf6bd53a drivers/pci/controller/pcie-rockchip.c Damien Le Moal        2024-10-17  130                                  "failed to get PERST# GPIO\n");
> e77f847df54c6b drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-09-03  131
> fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02  132     rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
> fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02  133     if (rockchip->num_clks < 0)
> fa0ce454cd4ee3 drivers/pci/controller/pcie-rockchip.c Anand Moon            2024-12-02 @134             return dev_err_probe(dev, err, "failed to get clocks\n");
>
>
> "err" is zero.  It should be "rockchip->num_clks".
>
> 4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  135
> 964bac9455bee7 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2018-05-09  136     return 0;
> 4816c4c7b82b55 drivers/pci/host/pcie-rockchip.c       Shawn Lin             2016-12-07  137  }
>
Thanks for the report I have submitted this fix for this.

[0] https://lore.kernel.org/linux-pci/20250106153041.55267-1-linux.amoon@gmail.com/

Thanks
-Anand

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

