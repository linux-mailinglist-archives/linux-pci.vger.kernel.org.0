Return-Path: <linux-pci+bounces-22460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47DA46C17
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 21:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBD51886613
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C58275606;
	Wed, 26 Feb 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHEo+UvO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDC275601
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600633; cv=none; b=UpL5bGp1lckBQ9p+f6pOQKVUO613UMR++8rZLcfjbXcFz7j6GEZ54ItCKHbZQ6Yhw2mFwnybju0Moc1FHcV1Blo0Gg2LPBP4JQYJ3kKZC3QKWlMZKHiOtP/tu1cuUbdZcHuyqh83i5Gfd38S6FWOOdBJevfjFt9QUTC8Qs/OcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600633; c=relaxed/simple;
	bh=pRkW/VIXj51Wpqa2lHCdRQt7BxvlMUEfWFcI2BvH9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mGrO41zXGBanB9h5uL07LWhAhoxG3Slqxht+ZYRPTv6BWx0KGaprcHhNgU2Kl6naoCsNuLaT40Iyc+wxXmclUG3Zk9ldHUgTZMlcaS09/Xlk4wIDAkhjC9aBxCKMCKOU99GbEI67/GXapsJF2kUx0uJcWBAiGsAaGm9s1I7HSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHEo+UvO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740600630; x=1772136630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pRkW/VIXj51Wpqa2lHCdRQt7BxvlMUEfWFcI2BvH9tc=;
  b=VHEo+UvOMthkFk1sgsR2+I2logeqy9LG3Mb/lfkWsfz9sXWtks7xgd5R
   v7Eo82EvCmYw3A+BC9WG8OrLmCkXn09s8xc+qLNaU+XChhWe5L3lQ3Rfi
   O6bi+3rk7T2dKKhucddEj+Qdoox+bpSfyQ/4hB6w2DxtVGWCZzpgBL/43
   sK5oiFqviERxl5fYWNpIlH1oKq+6z5sNrubMgZFNfdtN6u6pKfOmW3maf
   g6dSsuJBztYDGpzpHFW5npIrUHEs046ZfnPMbAA1+6MnzkUqErrPPmEip
   svnxZWFyN4aR3yqbLL6dIqhYgrengKf94vaqnAfrrEsWJg0BTUv7vSJ0e
   g==;
X-CSE-ConnectionGUID: 1wGox1NQT7mMlx2Zt4eiHw==
X-CSE-MsgGUID: pr0GNb1hQGaT0vS9CWv6Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52883793"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52883793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:10:29 -0800
X-CSE-ConnectionGUID: hZBtLdHrSbyQgkziMvPTXA==
X-CSE-MsgGUID: 1LyqnwCrToWJA1VNfGBMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="140027255"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Feb 2025 12:10:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnNj9-000CPE-1l;
	Wed, 26 Feb 2025 20:10:15 +0000
Date: Thu, 27 Feb 2025 04:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/dwc 6/8]
 drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:undefined reference
 to `dw_ltssm_sts_string'
Message-ID: <202502270336.4xpaTVPE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
head:   b9d6619b0c3ef6ac25764ff29b08e8c1953ea83f
commit: d4dc748566221bfdd0345c282ec82d3eee457f39 [6/8] PCI: dwc: Add debugfs property to provide LTSSM status of the PCIe link
config: sparc64-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502270336.4xpaTVPE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502270336.4xpaTVPE-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/pci/controller/dwc/pcie-designware-debugfs.o: in function `dwc_pcie_ltssm_status_show':
>> drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:(.text+0x125c): undefined reference to `dw_ltssm_sts_string'
>> sparc64-linux-ld: drivers/pci/controller/dwc/pcie-designware-debugfs.c:561:(.text+0x12c4): undefined reference to `dw_ltssm_sts_string'


vim +561 drivers/pci/controller/dwc/pcie-designware-debugfs.c

   554	
   555	static int dwc_pcie_ltssm_status_show(struct seq_file *s, void *v)
   556	{
   557		struct dw_pcie *pci = s->private;
   558		enum dw_pcie_ltssm val;
   559	
   560		val = dw_pcie_get_ltssm(pci);
 > 561		seq_printf(s, "%s (0x%02x)\n", dw_ltssm_sts_string(val), val);
   562	
   563		return 0;
   564	}
   565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

