Return-Path: <linux-pci+bounces-165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A66A7F88BA
	for <lists+linux-pci@lfdr.de>; Sat, 25 Nov 2023 08:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B361C20A06
	for <lists+linux-pci@lfdr.de>; Sat, 25 Nov 2023 07:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCC23D0;
	Sat, 25 Nov 2023 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrjxofCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42191A6
	for <linux-pci@vger.kernel.org>; Fri, 24 Nov 2023 23:06:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c993da0b9eso5972251fa.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Nov 2023 23:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700896002; x=1701500802; darn=vger.kernel.org;
        h=delivered-to:in-reply-to:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RYcgJht5CpJHvQZaHH5yIH/bBoeNKDITyrwLoWPeXA=;
        b=PrjxofCFMYtDROirgydAemrOb9e0tmZFqq6blnwLodL5WcbbWQtvtusSk4YxYXBe3p
         pufyt1+X2Lx3arovSWJIziTZFIhP7KS+9SSz7SynhfKifP+Qj+y1g+GezMKPCTay7ZAv
         IhSQhJV4IlRLV1lhuATB4gr1FPpPRBPErzuQTnXTkPVme/oyHsHRzkBLjyBKKCNonvqy
         5sjFkHh0+dOkNLNMuyYzw5vZb/RpcB8MeChTpPHhxj11y0QDjtTwfD6NtWvwjh7ZI0cp
         I3CkGSM6AP2fU7JkcKYwfAj+SBblg5zld1CEci/d273GKs3i9p4LmhINHnM1rNAypMSx
         zeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700896002; x=1701500802;
        h=delivered-to:in-reply-to:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RYcgJht5CpJHvQZaHH5yIH/bBoeNKDITyrwLoWPeXA=;
        b=oGmi9jrDhmcABTmh9cz8dEvLm3BvL2Py/CYcEbK23Jb6bODBSm/BiiUhdi/BLXx0IE
         Qb0q5zqJ7mED0hKF0JfNszvG5AruHzAC+9OA3BpGaktsjondMo34dR1gBEvGipdMuWXC
         SRsom3l5ua355Z4P96kTH+wbuQnYgPmDEU2/Sk/nW8Cs9h3z9txqFstdgEfaOK3zlpYM
         z0mi+uGiL5qwL+HIbpriUm4ChkMsaqRrD6KfnGJQYSxHYagQPM1fG2cqXGtCTKni+Mx7
         XhUotYEUQmqOYHSUFMyBVu+tbi9EL8e0D2KsrwgRnRyeVErlRbjUhiYovVtdfW3/ksak
         jJmA==
X-Gm-Message-State: AOJu0YxN/ZT/UniG9CUKzM0OjzY+B6nuwrLky5tou+GubZeL/a7QvX54
	YHDRk4+aNb5KRSwdrUSNUqTZ6g==
X-Google-Smtp-Source: AGHT+IEl1CSFNwWMzseTi4XTfwjKF2e9sXcTUutVfBef9FdgkexlK4fipWOxI+J3R9rYKe6Idbdlug==
X-Received: by 2002:a2e:3503:0:b0:2c6:eea4:3cfb with SMTP id z3-20020a2e3503000000b002c6eea43cfbmr3445356ljz.50.1700896002513;
        Fri, 24 Nov 2023 23:06:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332d04514b9sm5922765wrc.95.2023.11.24.23.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 23:06:42 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 25 Nov 2023 10:06:39 +0300
To: oe-kbuild@lists.linux.dev, Shuai Xue <xueshuai@linux.alibaba.com>,
	ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
	helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
	Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	rdunlap@infradead.org, mark.rutland@arm.com,
	zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <2d52f588-f584-4c01-8f41-227815a54e41@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121013400.18367-5-xueshuai@linux.alibaba.com>
Delivered-To: unknown

Hi Shuai,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/docs-perf-Add-description-for-Synopsys-DesignWare-PCIe-PMU-driver/20231121-093713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231121013400.18367-5-xueshuai%40linux.alibaba.com
patch subject: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
config: x86_64-randconfig-r071-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241906.0ymlLjyo-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241906.0ymlLjyo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311241906.0ymlLjyo-lkp@intel.com/

smatch warnings:
drivers/perf/dwc_pcie_pmu.c:352 dwc_pcie_pmu_event_update() error: uninitialized symbol 'now'.

vim +/now +352 drivers/perf/dwc_pcie_pmu.c

3481798a4ec51d1 Shuai Xue 2023-11-21  338  static void dwc_pcie_pmu_event_update(struct perf_event *event)
3481798a4ec51d1 Shuai Xue 2023-11-21  339  {
3481798a4ec51d1 Shuai Xue 2023-11-21  340  	struct hw_perf_event *hwc = &event->hw;
3481798a4ec51d1 Shuai Xue 2023-11-21  341  	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
3481798a4ec51d1 Shuai Xue 2023-11-21  342  	u64 delta, prev, now;
3481798a4ec51d1 Shuai Xue 2023-11-21  343  
3481798a4ec51d1 Shuai Xue 2023-11-21  344  	do {
3481798a4ec51d1 Shuai Xue 2023-11-21  345  		prev = local64_read(&hwc->prev_count);
3481798a4ec51d1 Shuai Xue 2023-11-21  346  
3481798a4ec51d1 Shuai Xue 2023-11-21  347  		if (type == DWC_PCIE_LANE_EVENT)
3481798a4ec51d1 Shuai Xue 2023-11-21  348  			now = dwc_pcie_pmu_read_lane_event_counter(event);
3481798a4ec51d1 Shuai Xue 2023-11-21  349  		else if (type == DWC_PCIE_TIME_BASE_EVENT)
3481798a4ec51d1 Shuai Xue 2023-11-21  350  			now = dwc_pcie_pmu_read_time_based_counter(event);

uninitialized on else path.

3481798a4ec51d1 Shuai Xue 2023-11-21  351  
3481798a4ec51d1 Shuai Xue 2023-11-21 @352  	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
3481798a4ec51d1 Shuai Xue 2023-11-21  353  
3481798a4ec51d1 Shuai Xue 2023-11-21  354  	delta = (now - prev) & DWC_PCIE_MAX_PERIOD;
3481798a4ec51d1 Shuai Xue 2023-11-21  355  	/* 32-bit counter for Lane Event Counting */
3481798a4ec51d1 Shuai Xue 2023-11-21  356  	if (type == DWC_PCIE_LANE_EVENT)
3481798a4ec51d1 Shuai Xue 2023-11-21  357  		delta &= DWC_PCIE_LANE_EVENT_MAX_PERIOD;
3481798a4ec51d1 Shuai Xue 2023-11-21  358  
3481798a4ec51d1 Shuai Xue 2023-11-21  359  	local64_add(delta, &event->count);
3481798a4ec51d1 Shuai Xue 2023-11-21  360  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


