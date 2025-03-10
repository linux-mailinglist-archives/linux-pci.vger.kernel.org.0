Return-Path: <linux-pci+bounces-23354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3135A5A190
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5153F3A76A5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3D227EA0;
	Mon, 10 Mar 2025 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiKUi+sK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C522B8A5
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629748; cv=none; b=YeiSQqUZOHHv9D+y+cul1jQ8ZiBSt4eQJ/sZ9tX0ciXLqZU4cDIlh+xhA+DEmF9VBORq9/tlI/05pyXIo+xH4AgklhVHuE6Y5E2AEdf+tMdPdT0oW0rEMOWuRNJCq+NjNqYEmNMU0x+Wa5QkxszrVtmweo7wIEOByg7eJGQ5SfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629748; c=relaxed/simple;
	bh=q79+mOokGgEvGJnA5NXQFtUyN8kLJysRvbxewzau2/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L8PuDT7Ue1WCN8NcCJvaRfl1bybmQN/DF1F9YD2ubA1TwMr5ei9rIXKJ6g++kzdZdLmeCzPEl9nF+WvxqRUuPquw6sF6mA8KBs5JaE+myzAi2Ic2s+Yo2SbktniDEIDD87eJnXq+C/FnTA7JMXGxjme7h5isoI3FnWc+hXySFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiKUi+sK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741629746; x=1773165746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q79+mOokGgEvGJnA5NXQFtUyN8kLJysRvbxewzau2/0=;
  b=DiKUi+sKHu4yc5WjwIZOGjzy0dk7f3AMEhHqlKA9Oq+XUhsQwZUFJPzm
   oVgRFrfhWgcrIUtrgQbnTvRXUuoqAtgLflb+pffqf3ouzWotSqUrb8PvQ
   17KrE8ib/ADDTlqjkvItGRfJJSypxWevyNpXGRhG5q2aOzMs4o43O4CSE
   vN8H20yXuUy+CTlp5etp22nekLheh0jY3SV54u3+ONR8/oMwlJg/XhUy1
   +XH8sD+13XixRiFf2lFnKqMBH30QLjldhgvf6cH7f+BWkD9bh4Vud7CGm
   g6CpN6pO9qwPU5pMi21YQnzYsBbzcUVVYAE3EbML8Nzxnz84ef+xzsYfD
   A==;
X-CSE-ConnectionGUID: BA30ree2TVi+HOGsuPoABg==
X-CSE-MsgGUID: StU1SCVIQ0ygBZUmvibeUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46551113"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46551113"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:02:26 -0700
X-CSE-ConnectionGUID: vKOnUVXNRaW7hTok9oxIKA==
X-CSE-MsgGUID: tFYs7FXDQxyucSMP95ypFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120957656"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 11:02:24 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trhSI-0005eg-0t;
	Mon, 10 Mar 2025 18:02:22 +0000
Date: Tue, 11 Mar 2025 02:02:12 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator
 'intx_capable' does not refer to any field in type 'const struct
 dw_pcie_ep_ops'
Message-ID: <202503110151.vQXf5yof-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Niklas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint-test
head:   d87a0e7ac55245a3f75ca5c646ffdf0cfa36e749
commit: da8628c06a7f08cb3402d02040d7a6195949772c [16/18] PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts
config: s390-randconfig-001-20250311 (https://download.01.org/0day-ci/archive/20250311/202503110151.vQXf5yof-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503110151.vQXf5yof-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503110151.vQXf5yof-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator 'intx_capable' does not refer to any field in type 'const struct dw_pcie_ep_ops'
           .intx_capable = false,
            ^
   drivers/pci/controller/dwc/pcie-dw-rockchip.c:530:33: warning: shift count >= width of type [-Wshift-count-overflow]
           dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
                                          ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.


vim +316 drivers/pci/controller/dwc/pcie-dw-rockchip.c

   313	
   314	static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
   315		.init = rockchip_pcie_ep_init,
 > 316		.intx_capable = false,
   317		.raise_irq = rockchip_pcie_raise_irq,
   318		.get_features = rockchip_pcie_get_features,
   319	};
   320	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

