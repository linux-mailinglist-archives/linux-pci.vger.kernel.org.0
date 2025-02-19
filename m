Return-Path: <linux-pci+bounces-21791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD5BA3B126
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 06:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F201896C98
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 05:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4B1B86E9;
	Wed, 19 Feb 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqWVgQiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD721B85D0;
	Wed, 19 Feb 2025 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944688; cv=none; b=Gdtm5MbrOcnOulitV3xdV+O98gpQ8hIWe9yKAygaqKmG/WOkB0VUssh+ibDqW3MXglC6Ieq8uiEhNsmfR+Ejfy0UjCP/TeYl+VzWhNxCRVHOi+knjjgpnYN8oAoPCTFMCm09e+JPOT48i8OuSgU4gm5Q07jochTPgE6z+7PNlYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944688; c=relaxed/simple;
	bh=EDAsRXB8SZ2ht5Mbs7TF8sqNUbcycQ0l2Gg1SrMSF1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFW/eXQCQcX4/CetZ494nsY1jEsQ+E6Z5IBsB7UgodlvwjTKAqKcCQlwHYtsjwnUmXtTOpFoXUvzB1e6gBd2voWidpp874GNw90Fyphe5Q/agFVCvBIV8CIkjQ4dsPGnVHhPtbuqGuW2+fcKzvmKHPhvrwO2H9GG6QvCy+0bCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqWVgQiV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944686; x=1771480686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDAsRXB8SZ2ht5Mbs7TF8sqNUbcycQ0l2Gg1SrMSF1M=;
  b=DqWVgQiVPrednhncW/8NvK+JmlU+iCI98nFHOi7xk0++RZ/ClvNinKPV
   uY5HTfRX93IGzuwplN7xw/+vZyYUysxYekUI2wp/Bt0TKcmtmj+lKwH1k
   bKiuPBTty69ioT9iWq2yAO1ln7tkLYfRAu/0e5nbOcxySnlzjsh+pJ2UA
   Qd6LXOObyr2VYGWD8nBBqaZ8tM7RFoDYjr0AKmvfTjiPWGM/XsnmGmjZq
   poIIeogXaoCK66A3mx5hw8NEfRZdL0vJrNopXWU65OhlgeYsO43XbzCry
   X67Al69Xi84/+XI5zJfoPuPYDkvXY17Mr4s6INL2i5si7toYO8t8ZD4TQ
   g==;
X-CSE-ConnectionGUID: yE7ivT+QRDiKtk0e/zpMSg==
X-CSE-MsgGUID: GXJVo/TtRHSceCzr46GJlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40875971"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40875971"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:58:06 -0800
X-CSE-ConnectionGUID: eKIsJRRiS9i0NSqKzBmVQg==
X-CSE-MsgGUID: vz1Wvbg7SlqLNr1jajCn5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115093235"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Feb 2025 21:58:02 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkd5s-0001IH-0M;
	Wed, 19 Feb 2025 05:58:00 +0000
Date: Wed, 19 Feb 2025 13:57:23 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <202502191308.uQbXkZna-lkp@intel.com>
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218034859.40397-1-feng.tang@linux.alibaba.com>

Hi Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14-rc3 next-20250218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Tang/PCI-Disable-PCIE-hotplug-interrupts-early-when-msi-is-disabled/20250218-115134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250218034859.40397-1-feng.tang%40linux.alibaba.com
patch subject: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling hotplug events
config: csky-randconfig-002-20250219 (https://download.01.org/0day-ci/archive/20250219/202502191308.uQbXkZna-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502191308.uQbXkZna-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502191308.uQbXkZna-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/pcie/portdrv.c: In function 'pcie_wait_sltctl_cmd_raw':
>> drivers/pci/pcie/portdrv.c:212:18: warning: variable 'ret1' set but not used [-Wunused-but-set-variable]
     212 |         int ret, ret1, timeout_us;
         |                  ^~~~


vim +/ret1 +212 drivers/pci/pcie/portdrv.c

   208	
   209	static int pcie_wait_sltctl_cmd_raw(struct pci_dev *dev)
   210	{
   211		u16 slot_status = 0;
 > 212		int ret, ret1, timeout_us;
   213	
   214		/* 1 second, according to PCIe spec 6.1, section 6.7.3.2 */
   215		timeout_us = 1000000;
   216		ret = read_poll_timeout(pcie_capability_read_word, ret1,
   217					(slot_status & PCI_EXP_SLTSTA_CC), 10000,
   218					timeout_us, true, dev, PCI_EXP_SLTSTA,
   219					&slot_status);
   220		if (!ret)
   221			pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
   222							PCI_EXP_SLTSTA_CC);
   223	
   224		return  ret;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

