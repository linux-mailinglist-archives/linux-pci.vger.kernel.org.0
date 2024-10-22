Return-Path: <linux-pci+bounces-14971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913019A989D
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CBF1F21442
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36006137747;
	Tue, 22 Oct 2024 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNckA/ba"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BF135A79;
	Tue, 22 Oct 2024 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575322; cv=none; b=IRcydg6nUWlOFly4DiNgwLXzRssJQ2g5DFye3LWkxMcRme7b3uUup1nY3jlAsDqWnirLDRb4+pZORP5XQ6y9aWobKRW1e+bz3Q5CTZH1V0wyPDMw8Aep2ymuxqPmSLvKSugJixs4poh7V5kVw2wr+ScmCWrgs1dw8Dxzlajy+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575322; c=relaxed/simple;
	bh=meA9jqJFq7R1V+kv/Z3qNiGP17F+ReXJwGKUUOr0S4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGDThuDu5UwM//3muUUjwH/00d5F5G3N7neB9QqxPO+EP9T3mAXmwTT2mCKXCg4ILkqYdZI/MQdZPfQ0HPYqLQH+nLHfXOASGpbxt1nwGBpZzcjvTS358vY79T6LPyYWJI8Dw3LW7FF5ac4vp1U/3AQLJY1CcwTIhU3KnCXrvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNckA/ba; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575320; x=1761111320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=meA9jqJFq7R1V+kv/Z3qNiGP17F+ReXJwGKUUOr0S4U=;
  b=GNckA/bac15WBp2MNYW+pen1R0FVcdrsJFMk9HRQsg3+dyqDOa2Me3rb
   fg+RR35oJ/bTIjNbfQBdYumVREXnA3u7wurA4nl24WWcF5QCAVIDM+VEK
   6nY85Oyc7icDhDVI1bSSXC4fY/xL2zf6zqNJBOF7SLqujMhHw/GH+CnfY
   szCcmQK2X/qPt0ormjj6bqukwePVUI0BhbPgeGeqdYyxMRPOZtdQzmx8q
   F/1zOwrpYUlmUZA7ZEPAl+cEyAlA1OGYBmhlVeEKGkkSZw8tHjESsffom
   GElFr4QM5Du52qO8psraEEnIM61GBYN1ei5vOscStZa2P3Kndrf0IdUp8
   g==;
X-CSE-ConnectionGUID: iWACL2pHQP+Mg5itVMRlog==
X-CSE-MsgGUID: wjkVvDepSpi5hKZiCH264Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015285"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:35:19 -0700
X-CSE-ConnectionGUID: CRADIpniR3azeKhOMX+utw==
X-CSE-MsgGUID: qhdp/qqsRgKIjfc8p6I17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84557530"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 22:35:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t37Y0-000T6z-2D;
	Tue, 22 Oct 2024 05:35:12 +0000
Date: Tue, 22 Oct 2024 13:34:51 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Eichenberger <eichest@gmail.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v3] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <202410221309.BXeJNrxw-lkp@intel.com>
References: <20241021124922.5361-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021124922.5361-1-eichest@gmail.com>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.12-rc4 next-20241021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Eichenberger/PCI-imx6-Add-suspend-resume-support-for-i-MX6QDL/20241021-205155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241021124922.5361-1-eichest%40gmail.com
patch subject: [PATCH v3] PCI: imx6: Add suspend/resume support for i.MX6QDL
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241022/202410221309.BXeJNrxw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410221309.BXeJNrxw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410221309.BXeJNrxw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-imx6.c:86: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Because of ERR005723 (PCIe does not support L2 power down) we need to


vim +86 drivers/pci/controller/dwc/pci-imx6.c

    75	
    76	#define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
    77	#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
    78	#define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
    79	#define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
    80	#define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
    81	#define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
    82	#define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
    83	#define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
    84	#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
    85	/**
  > 86	 * Because of ERR005723 (PCIe does not support L2 power down) we need to
    87	 * workaround suspend resume on some devices which are affected by this errata.
    88	 */
    89	#define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

