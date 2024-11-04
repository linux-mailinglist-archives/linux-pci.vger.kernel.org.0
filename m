Return-Path: <linux-pci+bounces-15965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A29BB7AA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AE61F24246
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D71AA7BE;
	Mon,  4 Nov 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTWkeaOo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2B1632C7;
	Mon,  4 Nov 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730323; cv=none; b=LAUwTwPkuPrzRy2t5UOSXDb8+vSZ03hIdlsaZgBasWZZSEA7HyLwoclanXSi3GL8xbE7ElPiXZ+fvWKO5CjMnLxPqA1h7AjScT0POEjhCtTiA9UGxj8jmHdWI6Tfz35JzRvcHXIVYT1nrHGgHa9LHrC4WxXASFuLn1Rs7lxyMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730323; c=relaxed/simple;
	bh=CT7brXbn9NKpu0p4b2oRMcjvrtTgl29owzk4cIVFwAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCj4oqkixx2A6VBxGkK9fSGvOtdUQQ6ColSCjKZ4jV3Xgb3CyM4bU1SnuAJvDjiCfPo3kzJmPvuhCnSzecLLAv3kcIiZAh7XkilVXG0y18hsl8Rp570lknc36AppxLVYk1575StfR35vwA/Nvh6wTLPPMtmD13zDv90FbPRH+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTWkeaOo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730730321; x=1762266321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CT7brXbn9NKpu0p4b2oRMcjvrtTgl29owzk4cIVFwAQ=;
  b=mTWkeaOoEDfICAh8y96W4/9VIcP3C80s3TUPEeMnKVbrf+KkXqBFWn0G
   uadpd+NPZCtv7eL6/tt0ghEV85ahD2W96/lEDdAoS2QOVlDjcEsjQs8/t
   KCcMEsyIXdpzvgB2OJSI7uhZP4J2ZUv1TvmZwRzQZEQMeMXbsGqxrKfGU
   9wdvZ2+j+jlVtLUA5bVFV1RE9yLQsFJ2ymF/NW/ahomu1My4jGvcOvNFa
   4/vC1kxD6AMV7NhdC+FW4w9jHgF4uHGmJBjhngwxROtZRn3JAGxL7oekY
   shpsA5xehY1mtci3J2R5nYZh9/7JeP8B/UUa5fmRX0cJUt3Ix+auKel4N
   Q==;
X-CSE-ConnectionGUID: +vKuNp0eQoOsuX5VLSqIsA==
X-CSE-MsgGUID: ics2bEzJTNqWN6Cwxch/gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33265760"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="33265760"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:25:20 -0800
X-CSE-ConnectionGUID: vKIxw/FaRaSqqupeNOnP6A==
X-CSE-MsgGUID: hGrie7GzTXCqRPAazkBXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83778622"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2024 06:25:15 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7y13-000ktz-1V;
	Mon, 04 Nov 2024 14:25:13 +0000
Date: Mon, 4 Nov 2024 22:24:32 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	frank.li@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <202411042110.bIIyBWlv-lkp@intel.com>
References: <20241101070610.1267391-9-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101070610.1267391-9-hongxing.zhu@nxp.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus shawnguo/for-next mani-mhi/mhi-next linus/master v6.12-rc6 next-20241104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Zhu/dt-bindings-imx6q-pcie-Add-ref-clock-for-i-MX95-PCIe-RC/20241101-150006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241101070610.1267391-9-hongxing.zhu%40nxp.com
patch subject: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
config: i386-buildonly-randconfig-004-20241104 (https://download.01.org/0day-ci/archive/20241104/202411042110.bIIyBWlv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411042110.bIIyBWlv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411042110.bIIyBWlv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/controller/dwc/pci-imx6.o: in function `imx_pcie_resume_noirq':
>> pci-imx6.c:(.text+0x88): undefined reference to `dw_pcie_resume_noirq'
   ld: drivers/pci/controller/dwc/pci-imx6.o: in function `imx_pcie_suspend_noirq':
>> pci-imx6.c:(.text+0x111): undefined reference to `dw_pcie_suspend_noirq'
   ld: drivers/usb/misc/onboard_usb_dev.o: in function `onboard_dev_probe':
   onboard_usb_dev.c:(.text+0x6ae): undefined reference to `i2c_find_device_by_fwnode'
   ld: onboard_usb_dev.c:(.text+0x711): undefined reference to `i2c_smbus_write_block_data'
   ld: onboard_usb_dev.c:(.text+0x72f): undefined reference to `i2c_smbus_write_word_data'
   ld: onboard_usb_dev.c:(.text+0x74c): undefined reference to `i2c_smbus_write_word_data'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_PERFORMANCE [=y] && GCC_PLUGINS [=y] && MODULES [=y]
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM [=m] && DRM_XE [=m] && DRM_XE [=m]=m [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

