Return-Path: <linux-pci+bounces-610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A48084CB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AB2282BB3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F134CE4;
	Thu,  7 Dec 2023 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbkudBwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BFD5E;
	Thu,  7 Dec 2023 01:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701941787; x=1733477787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xCC9VMF8HQQ5iJ4fro+1qWC/m9zv5+EUIPiEyIdfFw=;
  b=cbkudBwGqZoRrekMmwXXWK1oZ8SiUdMWwERTjwO3qfvSs3pJ7iDzFsMM
   44p6GJ54SaaVojC/fPkWsVZAzA0jdju+Fne48mqwodv29CHX4QqSnn7xe
   vpRtDuZZ1V0kr84dT+t53UyR2Rd3knIkwOWJ3bvroqbFqIr6o7XZuDaCa
   UZNom0NY+pI93rpAoy+px7FnCPT7Mclu5v5LzQW2q6oB1AgRMrLKPqNFK
   ya/MnMa9K629ACdYBnjwmLO8gK1RvR7eKDaYPSUin3Y2lwvIMu81iLm2z
   qIgX+p5Jxz1pEfKIHySwl84jMa4UouKSMZZXu3oTCgS5iXbC8+c/QrG4d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391378018"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391378018"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="895075318"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="895075318"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2023 01:36:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBAnq-000C2A-2f;
	Thu, 07 Dec 2023 09:36:18 +0000
Date: Thu, 7 Dec 2023 17:35:30 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 7/9] PCI: imx6: Simplify switch-case logic by involve
 init_phy callback
Message-ID: <202312071732.l6LvuDdy-lkp@intel.com>
References: <20231206155903.566194-8-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206155903.566194-8-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.7-rc4 next-20231207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-imx6-Simplify-clock-handling-by-using-HAS_CLK_-bitmask/20231207-000209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231206155903.566194-8-Frank.Li%40nxp.com
patch subject: [PATCH 7/9] PCI: imx6: Simplify switch-case logic by involve init_phy callback
config: powerpc-randconfig-002-20231207 (https://download.01.org/0day-ci/archive/20231207/202312071732.l6LvuDdy-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312071732.l6LvuDdy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312071732.l6LvuDdy-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/pci/controller/dwc/pci-imx6.o: in function `imx6_pcie_host_init':
>> pci-imx6.c:(.text.imx6_pcie_host_init+0x120): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

