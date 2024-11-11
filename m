Return-Path: <linux-pci+bounces-16442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5139C3D43
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F60284FEE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C26198A1B;
	Mon, 11 Nov 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UETxca2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433D197A72;
	Mon, 11 Nov 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324565; cv=none; b=YChAKIwPgtmWtpmZbFr/zh8mfDOpNFjHmvgtJw3LfUpaBys8XmOn1u+lpgy2q0ysVNweTWp34Oc163dYFUQsJLUFfGlDulOJICvAbhQzpsfCgOaw4P9JtNEST84U2f9r7FWCAPWfwsLjUNWE+YWLWjnIE0AhtJ8gJybtA98ZOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324565; c=relaxed/simple;
	bh=TNR8Irg9SFGemO0CwPl7apQbYEX5kMn4q8DdQYuF7iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN+vxkquA385ieXLChjmMjidrMXyHwwIGHMmeowWrIJN90vsgXXjepMNtop+Ry3S4PuKbzNMiImjYB2+Jm/FuCjzr02fD7kjNYS54eGMxngMN86J9rRVdI8hCJtqqemJ+cxiRNBiz7C8neiRRN1I1dcEqczCP3+FNLyPYTVNrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UETxca2u; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731324564; x=1762860564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNR8Irg9SFGemO0CwPl7apQbYEX5kMn4q8DdQYuF7iA=;
  b=UETxca2u9AOqoPmwLnper04cOOSd4VhU6bmx9lTcQmf7omjIZJwvEp0E
   LRRu/OkhOAWTsYSIkkXGGJGqiwqw1Ug54ZBOXSSaBmWoJBnfHfCeIAIid
   LVZP694Relj+g+eGlWY9qPSjhxux9TiZHBQgJH4yoc9gAtQrPS/5dTRC3
   hAoFqmJtLv03EjwTmNlk30hxdUx0zQnajwQdT2dXXYjUSpxoIdId4aCNO
   2M+TfOkPp66aSMOjbOpHwjMGWm4+Vhz2EKREG73twroC5dkioO1O7mPO2
   6germDAIlZPrLlAQ95hS1znhkYEZ81aiftij2U1UGRGovuMF05uSuvwsJ
   g==;
X-CSE-ConnectionGUID: d6ktAX7wR8qdlNu97nc8kw==
X-CSE-MsgGUID: EOU7AvM7SaeFJp7u1Fzvdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34814594"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34814594"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 03:29:21 -0800
X-CSE-ConnectionGUID: 7qdCuUaNROSsRPwhQ+1cLA==
X-CSE-MsgGUID: TNENUA3HTw6mQg31NfiN1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="86992621"
Received: from lkp-server01.sh.intel.com (HELO dc8184e5aea1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2024 03:29:16 -0800
Received: from kbuild by dc8184e5aea1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tASbZ-0000En-1o;
	Mon, 11 Nov 2024 11:29:13 +0000
Date: Mon, 11 Nov 2024 19:29:12 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
	u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
	bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
	lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <202411111935.kqORCWuE-lkp@intel.com>
References: <5051f2375ff6218e7d44ce0c298efd5f9ee56964.1731303328.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5051f2375ff6218e7d44ce0c298efd5f9ee56964.1731303328.git.unicorn_wang@outlook.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-pci-Add-Sophgo-SG2042-PCIe-host/20241111-140237
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/5051f2375ff6218e7d44ce0c298efd5f9ee56964.1731303328.git.unicorn_wang%40outlook.com
patch subject: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20241111/202411111935.kqORCWuE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411111935.kqORCWuE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411111935.kqORCWuE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pcie-sg2042.c:141:12: warning: 'sg2042_pcie_msi_irq_set_affinity' defined but not used [-Wunused-function]
     141 | static int sg2042_pcie_msi_irq_set_affinity(struct irq_data *d,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sg2042_pcie_msi_irq_set_affinity +141 drivers/pci/controller/cadence/pcie-sg2042.c

   140	
 > 141	static int sg2042_pcie_msi_irq_set_affinity(struct irq_data *d,
   142						    const struct cpumask *mask,
   143						    bool force)
   144	{
   145		if (d->parent_data)
   146			return irq_chip_set_affinity_parent(d, mask, force);
   147	
   148		return -EINVAL;
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

