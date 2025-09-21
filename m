Return-Path: <linux-pci+bounces-36602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366CB8D575
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D951F2A0F9C
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9492857C2;
	Sun, 21 Sep 2025 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWIUgSmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27FEEA8;
	Sun, 21 Sep 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758434757; cv=none; b=AVSFUZkRQDd59txxZlwdbOanU6AhE0u0rTqv1MlWgizXU/AJ0Ib6O39VSOk6QjJ/mwtLm9Yh8AY/2Fd1No4vGJeNZlRqznvQVMKHMsgNxJMvBt40qdtzANDWI7r+lzp3Z7Rbx0Rz3oM0EUOa2M9q5Oaif84ge7pErdw95VEXAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758434757; c=relaxed/simple;
	bh=8ctr9bJIScthH2cD/1XQ1vcsW7U4Lt1MN5qWna68e2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHEeGmdnbmr3C/s1Fm5fITYQj/zEbuJi1INZsooJa6zNKp6Ke5jngbV7UX8vBrprLjHSc/lg8gjsJGAQS19ynjrt+RmnhUTGGITO1gLy8iEN6bsb19e6Muz29h9ldWD75Z+WNqTPkIBQPc/8OQ00ozeOrnqZLUOyWtXib4hT3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWIUgSmJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758434755; x=1789970755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ctr9bJIScthH2cD/1XQ1vcsW7U4Lt1MN5qWna68e2c=;
  b=GWIUgSmJkDdV7Jj9BY+7xYY1nrdNPgBPcGNG3kj+CapcpjW6jLaDMf3A
   cQdE11V2AJMb+CisiYMIyBmhv/ceic7v1CgzVbqxS/ql4NyQGB8BbulSF
   XKiHg3LANyPQ9XlZ1DQKKvmh6rF3NNl60QIoBmVc55uWvGofWS37yy2Uq
   gPNJQ1OY4Wm0+cLirfoZztJDvZ3i3Xnq5eYbwyn9uxD/IZi5F2xb6ZRg5
   ISQ/kQltGLA7lNuRJUicZwjK59FH0gJ6SwIj7lpVgEniZDEd1RArDLHv0
   vV0r5j1ZC6Y/aWOyYCntl61PlsEe0OzOUmxId6GVWnRzx9Mdgf2vkxj4s
   g==;
X-CSE-ConnectionGUID: 6vzy5fbQQyG2aJDCRcfxUQ==
X-CSE-MsgGUID: ERH2kYZ3SHOKpxujiZTJNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="59769787"
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="59769787"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 23:05:54 -0700
X-CSE-ConnectionGUID: Bx5ZTH74RSeyEBDMZHWvWw==
X-CSE-MsgGUID: rnp+F5cfT3GT6/klwfGJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,282,1751266800"; 
   d="scan'208";a="199916867"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Sep 2025 23:05:51 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0DCn-0000Ur-0u;
	Sun, 21 Sep 2025 06:05:49 +0000
Date: Sun, 21 Sep 2025 14:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] PCI: mediatek: add support for Airoha AN7583 SoC
Message-ID: <202509211315.51HZNnRI-lkp@intel.com>
References: <20250920114341.17818-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920114341.17818-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.17-rc6 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/PCI-mediatek-add-support-for-Airoha-AN7583-SoC/20250920-194637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250920114341.17818-1-ansuelsmth%40gmail.com
patch subject: [PATCH] PCI: mediatek: add support for Airoha AN7583 SoC
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250921/202509211315.51HZNnRI-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509211315.51HZNnRI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509211315.51HZNnRI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/controller/pcie-mediatek.c:163 struct member 'skip_pcie_rstb' not described in 'mtk_pcie_soc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

