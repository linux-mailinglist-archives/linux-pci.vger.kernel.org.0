Return-Path: <linux-pci+bounces-43548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB5ECD6FDA
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3604300A1E0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9593B1EFFB4;
	Mon, 22 Dec 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7GdwVco"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48933065E;
	Mon, 22 Dec 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432189; cv=none; b=CQf0Hhp0+uId8gjaBn/p9VjNpusJkMNkxmxbTdYeA/kVjB0AI+c6PocI4/VIrsIVQR9mMjpX4mSFWi+bJxSbuHioPTlIJli1l2nJAjUh+YockXnspdIE8LUhHaKwlLcvZhZby68MFMvkUZy0COaG90BgztrrSJUQO6dC7Fj+blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432189; c=relaxed/simple;
	bh=WouLnG/EDgvG12FRfKj7rC3BNHDgqCalZ+ubaC/6qOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWbGFwOLiyjQ8dIYn/rHXBA0KD46s7QrGwOrcHW39LPTmplxcJiVb5FJ6T9EkP23bGS00YE2EgruQ1QTlTe++kTYRx2/f6O2mPyt8ZYAjrmEzpihfiGYD/RTYohLDs6RK7fgTbrPkGtJiD/akuNCdFQn4l4voLAuhlmTZPjFI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7GdwVco; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766432188; x=1797968188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WouLnG/EDgvG12FRfKj7rC3BNHDgqCalZ+ubaC/6qOI=;
  b=l7GdwVcopJ2IB8VorkteCWYibY9VA1/cDtsSRfA/0hyKJIo9UzxJ7vd6
   wZh/uCwZSdhRyeeB6ym0K9DED2OdLU7tH+j/paJk8YFBnnhtfLbZ/DvjE
   Pa2t63x/klnOUMDUmIXz167VbzxyOO8lzEfi4Fh8V3nRNQ4apybcORf2Y
   W/6/pq9Ibu6WDCYHi8vJJEZJr8H1ox8XoG7BrKP7cj8ocOaITXhTSFR9V
   2oTE9FKyyrfGfKZQzAhy4LhezBQv8/0Af2uTMji17xc9EElW+f+0h7FRw
   rXOHOHQUfL+W8shhpBqT9/fQDmi3ekX1oklcYk4UjjOnV48+sDsaxYx2t
   Q==;
X-CSE-ConnectionGUID: FGZKmtjSSu+bi/h1ruiDXg==
X-CSE-MsgGUID: tZx9WNCiR8K1nfxOC9QqEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="90950052"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="90950052"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 11:36:27 -0800
X-CSE-ConnectionGUID: HKnqYG8eRmmu3a5YwP8JxA==
X-CSE-MsgGUID: SQK+jjjFQ8yMZr3kx2WaCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="200091893"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 22 Dec 2025 11:36:24 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXlhe-000000005bA-0L86;
	Mon, 22 Dec 2025 19:36:22 +0000
Date: Mon, 22 Dec 2025 20:35:48 +0100
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT
 schema
Message-ID: <202512222054.5XFbv0HE-lkp@intel.com>
References: <20251215141603.6749-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215141603.6749-2-linux.amoon@gmail.com>

Hi Anand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/dt-bindings-PCI-Convert-nvidia-tegra-pcie-to-DT-schema/20251215-231359
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251215141603.6749-2-linux.amoon%40gmail.com
patch subject: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
reproduce: (https://download.01.org/0day-ci/archive/20251222/202512222054.5XFbv0HE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512222054.5XFbv0HE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/scsi/scsi_mid_low_api.rst references a file that doesn't exist: Documentation/Configure.help
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/ABI/testing/sysfs-platform-ayaneo
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/mediatek-mdp.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
   Warning: include/rv/da_monitor.h references a file that doesn't exist: Documentation/trace/rv/da_monitor_synthesis.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

