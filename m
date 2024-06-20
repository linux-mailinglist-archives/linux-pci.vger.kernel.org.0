Return-Path: <linux-pci+bounces-9035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14F910EEA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470961F2317D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC361BD028;
	Thu, 20 Jun 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCWdw6au"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4741B4C47;
	Thu, 20 Jun 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904751; cv=none; b=QFdmjSZknJRCSO9EElh/MyHrJG/s8v80IJTtE65SUpF43wFgEkwC7LTWO14EQphCIaqny5SZGGYe2yEkdC6YoVRTatpSYBcnovwBu2ImFLulvh5SBPU8stSSQVWYtPaFiuu8vGoUfZi6c5VK6hAceKw9IYBLgeiGcSK9rMx+pxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904751; c=relaxed/simple;
	bh=oFO9G2nRTwhWJIbyUtKnqB3LSa7KnG7okU5Gl/bU6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFrmxAfdg0AoCdS768suNqyjpL18jE3QtgNcMNO2x+z8VlVfU7n7Eb7IWRYYqn9CbHnYyZyE6RyB4tkVGqYCnVuhk4PlxRbzNY6EF4IQphXLcbVr7VTt9CYWGtEpZYOp1gIudLSBZghfl6qAurF5SzjzaKe9VAMyv+82D/rguGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCWdw6au; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718904750; x=1750440750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFO9G2nRTwhWJIbyUtKnqB3LSa7KnG7okU5Gl/bU6lk=;
  b=TCWdw6auSASFpv9dDQhhDPwllLUYzk64BJrniHpCjiqym5ET+Tl9GqK9
   y4HnQLQpRUBaMQDGkSnYIOCD5081rrlSTTgcI/2WJ9fQJ57hENqRd/P7g
   3kJcsJ19fNimW97ofkDsgnkgcCXH142eLeu7B9tEyFH3aWH8kgo2GEfg+
   miiUmYpQGkMSaaS2wRTUzidb3Ajp2egyQdCe6jZZT3uSDd/QxiBUkYcxG
   e+8nNz5pGrY/0k7QMFCv6QDqi/1+ReZunQtiLGTJ7Zf/PqTsuDgd2FWa8
   eFjkuMdYLVLaBEl3el89hCiVMVl94v98qsdem1VAO7X970s601fTrd3Bq
   Q==;
X-CSE-ConnectionGUID: kMB6VdBgTvWuUIF+dZyRaw==
X-CSE-MsgGUID: mPSaakP5T0yoMtaxZUyT8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="19684105"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19684105"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 10:32:29 -0700
X-CSE-ConnectionGUID: 718kP6xuREe79HcLq81ntA==
X-CSE-MsgGUID: cdf+326NRLmYXOBmkXIRiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47268510"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 20 Jun 2024 10:32:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKLds-0007nc-1O;
	Thu, 20 Jun 2024 17:32:12 +0000
Date: Fri, 21 Jun 2024 01:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <202406210131.rxenHeBG-lkp@intel.com>
References: <20240618164133.223194-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618164133.223194-2-linux.amoon@gmail.com>

Hi Anand,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.10-rc4 next-20240619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/PCI-rockchip-Simplify-reset-control-handling-by-using-reset_control_bulk-function/20240619-014145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240618164133.223194-2-linux.amoon%40gmail.com
patch subject: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240621/202406210131.rxenHeBG-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210131.rxenHeBG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210131.rxenHeBG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pcie-rockchip-ep.c:20:
>> drivers/pci/controller/pcie-rockchip.h:311:28: error: array has incomplete element type 'struct clk_bulk_data'
     311 |         struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
         |                                   ^
   drivers/pci/controller/pcie-rockchip.h:311:10: note: forward declaration of 'struct clk_bulk_data'
     311 |         struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
         |                 ^
   1 error generated.


vim +311 drivers/pci/controller/pcie-rockchip.h

   298	
   299	struct rockchip_pcie {
   300		void	__iomem *reg_base;		/* DT axi-base */
   301		void	__iomem *apb_base;		/* DT apb-base */
   302		bool    legacy_phy;
   303		struct  phy *phys[MAX_LANE_NUM];
   304		struct	reset_control *core_rst;
   305		struct	reset_control *mgmt_rst;
   306		struct	reset_control *mgmt_sticky_rst;
   307		struct	reset_control *pipe_rst;
   308		struct	reset_control *pm_rst;
   309		struct	reset_control *aclk_rst;
   310		struct	reset_control *pclk_rst;
 > 311		struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
   312		struct	regulator *vpcie12v; /* 12V power supply */
   313		struct	regulator *vpcie3v3; /* 3.3V power supply */
   314		struct	regulator *vpcie1v8; /* 1.8V power supply */
   315		struct	regulator *vpcie0v9; /* 0.9V power supply */
   316		struct	gpio_desc *ep_gpio;
   317		u32	lanes;
   318		u8      lanes_map;
   319		int	link_gen;
   320		struct	device *dev;
   321		struct	irq_domain *irq_domain;
   322		int     offset;
   323		void    __iomem *msg_region;
   324		phys_addr_t msg_bus_addr;
   325		bool is_rc;
   326		struct resource *mem_res;
   327	};
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

