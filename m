Return-Path: <linux-pci+bounces-9331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBB918E4B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E69B21E33
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5FC19048B;
	Wed, 26 Jun 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVHyXF/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9119047F
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426266; cv=none; b=dQz4yH6d7KbyjKf/cT5bmPd61iGlBI1Hq4uM894+DZDXi5BQfFVVoUs+sOcHbFJOYXETeGY6K+SzO8mUVYnjcm2MEkb4MFz08+0/EwfqswETBrwjs3NilRgLRNDW5hW4GnuL8+JEkfNpGBIHpdsMlHnlKee5XVyACPqa4m9bDTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426266; c=relaxed/simple;
	bh=xvUgX3X1rnbSdokwi4SSmcmsd8/UKrqKNCZc0KVdWCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hL1HYrgUoCVBPcu1XZad/CmAHR8juGATNkbv0XuhPRcISJX75sDO48JdHGIjH1CZ4EEZvm4esmH0JxG8vrGx+SqfaMpVi+XAqSmhNESXSQoX8x9d6q+KpkRg6Zk7RyFRAbyHbLkPVWTcE3voIzwB1k0WGHHYJK7JwFRQdbz9tI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVHyXF/f; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719426265; x=1750962265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xvUgX3X1rnbSdokwi4SSmcmsd8/UKrqKNCZc0KVdWCo=;
  b=EVHyXF/f3wckIygUnfGUdYTa/MisFJ7oF+2qU5hRNSCZbCKbb08nZS3l
   470clDtorrB6ZjVVD9SyiAaCVLdST0M4TY6BIl5mimNKQAoMpxjW+/ynL
   HAlalogNSC4Xujj4it4bGrO0mAnF0wlQffh3WoKigpBD+keslI1f/ftQg
   ghymmDx4TggM3NcJq/8R5cR0Y5nRwiIJYlv6kK1DHjLb8qEB8/Mvz8KeJ
   /hw5R6nrGvXmAPwcyHqbAa0FRVHRWLE6N+BjUCfgxMgwdYElHBCIq8eWI
   MME9RC8+RmAbiiUIPeV+fJS0yg6qPT95aiTkTL4AdzHpPnzJJNt8l/0yd
   g==;
X-CSE-ConnectionGUID: i590latdTD2HpnN2WCq0DQ==
X-CSE-MsgGUID: iPe/7ztdSmGafJVXH97baQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16744953"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16744953"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 11:24:24 -0700
X-CSE-ConnectionGUID: 6DpaWhbGTQm45gdsJWsyEQ==
X-CSE-MsgGUID: ylRDAfqUS22gI+X1WKXQIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="49259591"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 11:24:23 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMXJc-000FTS-1P;
	Wed, 26 Jun 2024 18:24:20 +0000
Date: Thu, 27 Jun 2024 02:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [pci:controller/rockchip 10/11]
 drivers/pci/controller/dwc/pcie-designware-ep.c:26:undefined reference to
 `pci_epc_init_notify'
Message-ID: <202406270250.k2esVVnL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/rockchip
head:   246afbe0f6fca433d8d918b740719170b1b082cc
commit: 9b2ba393b3a659a4695691794dc030b6f7744b23 [10/11] PCI: dw-rockchip: Add endpoint mode support
config: loongarch-randconfig-r081-20240626 (https://download.01.org/0day-ci/archive/20240627/202406270250.k2esVVnL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270250.k2esVVnL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270250.k2esVVnL-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init_notify':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:26:(.text+0x1e4): undefined reference to `pci_epc_init_notify'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_deinit':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:640:(.text+0x83c): undefined reference to `pci_epc_mem_free_addr'
>> loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:643:(.text+0x854): undefined reference to `pci_epc_mem_exit'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkup':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:811:(.text+0x924): undefined reference to `pci_epc_linkup'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_linkdown':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:836:(.text+0x964): undefined reference to `pci_epc_linkdown'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.o: in function `dw_pcie_ep_init':
>> drivers/pci/controller/dwc/pcie-designware-ep.c:875:(.text+0xe90): undefined reference to `__devm_pci_epc_create'
>> loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:888:(.text+0xf20): undefined reference to `pci_epc_mem_init'
>> loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:895:(.text+0xf54): undefined reference to `pci_epc_mem_alloc_addr'
   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-designware-ep.c:906:(.text+0xf74): undefined reference to `pci_epc_mem_exit'


vim +26 drivers/pci/controller/dwc/pcie-designware-ep.c

f8aed6ec624fb4 drivers/pci/dwc/pcie-designware-ep.c            Kishon Vijay Abraham I 2017-03-27  17  
7cbebc86c72aa2 drivers/pci/controller/dwc/pcie-designware-ep.c Manivannan Sadhasivam  2024-03-27  18  /**
7cbebc86c72aa2 drivers/pci/controller/dwc/pcie-designware-ep.c Manivannan Sadhasivam  2024-03-27  19   * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization complete
7cbebc86c72aa2 drivers/pci/controller/dwc/pcie-designware-ep.c Manivannan Sadhasivam  2024-03-27  20   * @ep: DWC EP device
7cbebc86c72aa2 drivers/pci/controller/dwc/pcie-designware-ep.c Manivannan Sadhasivam  2024-03-27  21   */
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  22  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  23  {
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  24  	struct pci_epc *epc = ep->epc;
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  25  
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17 @26  	pci_epc_init_notify(epc);
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  27  }
c57247f940e8ea drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-03-03  28  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
ac37dde7217764 drivers/pci/controller/dwc/pcie-designware-ep.c Vidya Sagar            2020-02-17  29  

:::::: The code at line 26 was first introduced by commit
:::::: ac37dde721776463f866ba5c93986af19a6b73b9 PCI: dwc: Add API to notify core initialization completion

:::::: TO: Vidya Sagar <vidyas@nvidia.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

