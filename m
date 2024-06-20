Return-Path: <linux-pci+bounces-9000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795E90FA8B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 02:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296FF1C2178A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB23A953;
	Thu, 20 Jun 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWjqmSpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3582B4C81;
	Thu, 20 Jun 2024 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844907; cv=none; b=LR7FugYQoW/lR7pPKT7Yczsn6GmNIYuQyb+HcmFe68/wCUNBzWx9rHPw7dFvyWnFvgLKTIBdjrIqIO5JLU7AIQa+rAxrc4apGFpHw9aMOWl5CPnYngY5DpnUips16vxZr14VZuX+yf108l4XxsQQ6pGemlatJAtCrRf7m0hkDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844907; c=relaxed/simple;
	bh=n1QL+U4fIPrZYaKvpV4ICwIHrMT2ebrPVzqIB4RJsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3eFkn5FS6sTSpkKmZFG2gfw8QRd4oUS9avpPbIKGkFeITaUJqc64tosTqDhk6oWxfNvmStEUVeU9FKP19s23vMaX/Ke4KjlUvxFGvAqdEfw5HYgEwrttpDqto0PmG1/Q5gCxN/R4pXFVzvJc92HZcyFrne5AAn+C5dySA3AJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWjqmSpq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718844905; x=1750380905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n1QL+U4fIPrZYaKvpV4ICwIHrMT2ebrPVzqIB4RJsnY=;
  b=DWjqmSpqpKtZMgyEBhLmetD1EbJ+gZtSpIs2TQCuI+bmjP8alYBeFRfP
   mUPsVBITkusbcsxk1+JID1gqLXiUC+PXizGvirG5j0lMmpR+PD126o/Zx
   fbjyfe6kS/Jla4f3L+2xfk/rjC11dhERzaSsQyLxK39eJJr2bU4vPnQUn
   DOw1ymDpvVswMIQWj1nFc4ZNEjzTk1ggOtjTYwncESAW3s5+KgtEusLe6
   hlgpKdsdsNze113HX/x8SvMt11bxUacvoJdCiV2NC5PTIVEoNHbjWUxSr
   BrB9vKvu4dHf0XPZzYNM/fS2ocrz9PJ/9NLJV94MscdGZ+LnUpXxSty5k
   g==;
X-CSE-ConnectionGUID: hMdpHOwaR6mVbnSwU7PHOQ==
X-CSE-MsgGUID: F7YxY/J3ThmZZITadw8+0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15514234"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15514234"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 17:55:05 -0700
X-CSE-ConnectionGUID: bgKIzhe/QEqEMRzkBBOe4w==
X-CSE-MsgGUID: HhCXmOfMS9+Uk2hXQFvTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="73267832"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Jun 2024 17:55:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sK64p-00079O-1x;
	Thu, 20 Jun 2024 00:54:59 +0000
Date: Thu, 20 Jun 2024 08:54:30 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: oe-kbuild-all@lists.linux.dev, Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <202406200818.CQ7DXNSZ-lkp@intel.com>
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
config: arc-randconfig-001-20240620 (https://download.01.org/0day-ci/archive/20240620/202406200818.CQ7DXNSZ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200818.CQ7DXNSZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200818.CQ7DXNSZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/pcie-rockchip-ep.c:20:
>> drivers/pci/controller/pcie-rockchip.h:311:31: error: array type has incomplete element type 'struct clk_bulk_data'
     311 |         struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
         |                               ^~~~


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

