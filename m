Return-Path: <linux-pci+bounces-7831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B58CF62F
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2024 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD26D281D03
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2024 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510F130484;
	Sun, 26 May 2024 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOmBRc5K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8F947A
	for <linux-pci@vger.kernel.org>; Sun, 26 May 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716760075; cv=none; b=pNlCLg5LgpzGZHqpDkmAhYyKO+LzBrNswYswnA1EPF/fS8P/atR/Mz67eyzgNTWQ12r7BavH3v9s4xBFGRKtGEmtdifeFyD3JhN2yd8ovsI/mKFGLi8T7L/NjFX8uHZw7ZMOnUHI5qTEKuSKySo4h+Y67dLgWtryEfkyHSK/VGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716760075; c=relaxed/simple;
	bh=Wo7KosZhQwFSNB62TPZn511Lp0+CXG/OzbrDd8xxMbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZQlimgnDwqlGWpvA8S4z/19rk7Rq1wv+gjkO7mGNf15FNmH8C0YjGr9heMya//Vyk+lSM831p7qDVHUkbDmIpr/6HiwQuURwRS4QjreXdINhFGaKuuc6ZrQkgxLRjqS/0r7sV3epVBSKTWP8f2/wGBwtsdPXiGmKp5K1zn0PLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOmBRc5K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716760074; x=1748296074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wo7KosZhQwFSNB62TPZn511Lp0+CXG/OzbrDd8xxMbA=;
  b=mOmBRc5KPPo+LOcCPy9xwgG+vhIgCqhaGzOb9txMhsAGuUflu2olqJ/O
   DyaBfm+FnPBYPK14CLBNKJ+3JKDRIpHZZ+bad1iKd3idTPgJ++R2FSfmj
   7wkoT003ioEHtgOKft4O39ollJpf+FBfc6d7O0liKzjS/pBlDyBiWB7SO
   IiJW18FfLgEG3cY1oqco52VouIA+e+TBsw6JBDKZgT1y/szc/beGhfzob
   MaNiClJn/ZR0k/TtH/ePpLHSsWBByyIkQ53gZ2h2a9hzKC3JYX7iuUctt
   ALlzh/1JB5M0gS1G/Pp/FLMk9bpXQMuU//oGdQnFSCmeGov0mikG8eHW5
   w==;
X-CSE-ConnectionGUID: PnkFanIvTbGJyVWxUKxgHw==
X-CSE-MsgGUID: 2fCuJg2fT7aTurJ7Y2CEug==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13251619"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13251619"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 14:47:53 -0700
X-CSE-ConnectionGUID: Vh5PVpElSo2pXzeXC0jRrw==
X-CSE-MsgGUID: ufeJsivtR7qpEIp8648Qvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39408845"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 May 2024 14:47:51 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBLiW-0008fr-0z;
	Sun, 26 May 2024 21:47:48 +0000
Date: Mon, 27 May 2024 05:46:51 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [pci:endpoint 8/12] ld.lld: error: undefined symbol:
 pci_epc_deinit_notify
Message-ID: <202405270544.yKgcokbA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint
head:   5c172f7afc887f2cd383a125cc7fd98d921fe10f
commit: f94f2844f28c968364af8543414fbea9c8b3005d [8/12] PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers
config: arm64-randconfig-002-20240526 (https://download.01.org/0day-ci/archive/20240527/202405270544.yKgcokbA-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405270544.yKgcokbA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405270544.yKgcokbA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_epc_deinit_notify
   >>> referenced by pcie-tegra194.c
   >>>               drivers/pci/controller/dwc/pcie-tegra194.o:(pex_ep_event_pex_rst_assert) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

