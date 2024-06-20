Return-Path: <linux-pci+bounces-9005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B909B90FBAD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 05:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7A31F226C7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 03:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C061D556;
	Thu, 20 Jun 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9gqrc/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BA1CD2F;
	Thu, 20 Jun 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718854097; cv=none; b=QYIYAzFd43ChTcdUhKec2/c8kjRHadx7djyywsH68BufuI/k8ci7CwqYoChMvwkj64us/+5Z9/QaES1lxdDFJzKzCcJyZasYoQsgnXUDA76yDN6+892SqtNHhEHBiMNBnTqSKhGoIrtQv0+ea+iIlW1ZvEKeANOckvanT+ZaAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718854097; c=relaxed/simple;
	bh=vp8t5n8rFVShQT8gyp2X5h16GPqlHOy09DNcnwnr8sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+S7xcfoZiJYcBX6g4N8kt/0XhGTAU0BWFjEz9c1dCqjx/87GXfPT/vmCh8rJu5OCxC8NuDwxoTq+TBqUGEl6zuEyk7rxjnRR7+wRBpMyXrQ5VH1WmpiUjFjWHxnd6sj0bWhFlAC76q9nNLJ3L5V8q1Nm1E7LTxw7+VBSrfZL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9gqrc/A; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718854095; x=1750390095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vp8t5n8rFVShQT8gyp2X5h16GPqlHOy09DNcnwnr8sk=;
  b=l9gqrc/AGuoz1jLsBKka/D0953eJEMoiIc3WFK8Npy9i2ZyDgu6Kio2G
   Rd2k+g8WpnGwOwIXvJuhZ3aIRT3KSTLKbkotbVoknj3YA5do8ECIkQ3PW
   op6OcYiLswVM1YJebu4w2Oxnl6Bwq3ACkcViarVXN8QnvolIoJCJq0Ypi
   FGf6r7y03FsSrcVycR+zV3w3vkfD2by2menrgjKl1+MZH6Lkn7To8Le1b
   G36wOQeEtiv35xFMvQpl0eqthy81mAL2lnqBOEOd47eXCcMxt6eR46oTW
   QLvSpZ6Q0MDd6ncEQIdeDtnKh5CS6/dfQDTQDlkwbplf+H439CdoTKJk7
   A==;
X-CSE-ConnectionGUID: XtNNUu1rRCiOEUFMMBh8/g==
X-CSE-MsgGUID: RK+NR1c3SSmdMoYwXPOsvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="12156132"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="12156132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:28:15 -0700
X-CSE-ConnectionGUID: 1G7Zoa7hRYuQ+/ydfUKMQQ==
X-CSE-MsgGUID: BUFuuXQdR+2iQYQx8Tq75g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41966318"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2024 20:28:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK8T4-0007Gw-08;
	Thu, 20 Jun 2024 03:28:10 +0000
Date: Thu, 20 Jun 2024 11:27:22 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <202406201156.PPCyjK8r-lkp@intel.com>
References: <20240618164133.223194-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618164133.223194-3-linux.amoon@gmail.com>

Hi Anand,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.10-rc4 next-20240619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/PCI-rockchip-Simplify-reset-control-handling-by-using-reset_control_bulk-function/20240619-014145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240618164133.223194-3-linux.amoon%40gmail.com
patch subject: [PATCH v1 2/3] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
config: arc-randconfig-001-20240620 (https://download.01.org/0day-ci/archive/20240620/202406201156.PPCyjK8r-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201156.PPCyjK8r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201156.PPCyjK8r-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pcie-rockchip-ep.c:20:
>> drivers/pci/controller/pcie-rockchip.h:319:41: error: array type has incomplete element type 'struct reset_control_bulk_data'
     319 |         struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
         |                                         ^~~~~~~
   drivers/pci/controller/pcie-rockchip.h:320:41: error: array type has incomplete element type 'struct reset_control_bulk_data'
     320 |         struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS];
         |                                         ^~~~~~~~~
   drivers/pci/controller/pcie-rockchip.h:321:31: error: array type has incomplete element type 'struct clk_bulk_data'
     321 |         struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
         |                               ^~~~


vim +319 drivers/pci/controller/pcie-rockchip.h

   313	
   314	struct rockchip_pcie {
   315		void	__iomem *reg_base;		/* DT axi-base */
   316		void	__iomem *apb_base;		/* DT apb-base */
   317		bool    legacy_phy;
   318		struct  phy *phys[MAX_LANE_NUM];
 > 319		struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
   320		struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS];
   321		struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
   322		struct	regulator *vpcie12v; /* 12V power supply */
   323		struct	regulator *vpcie3v3; /* 3.3V power supply */
   324		struct	regulator *vpcie1v8; /* 1.8V power supply */
   325		struct	regulator *vpcie0v9; /* 0.9V power supply */
   326		struct	gpio_desc *ep_gpio;
   327		u32	lanes;
   328		u8      lanes_map;
   329		int	link_gen;
   330		struct	device *dev;
   331		struct	irq_domain *irq_domain;
   332		int     offset;
   333		void    __iomem *msg_region;
   334		phys_addr_t msg_bus_addr;
   335		bool is_rc;
   336		struct resource *mem_res;
   337	};
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

