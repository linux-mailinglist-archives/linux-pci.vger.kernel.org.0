Return-Path: <linux-pci+bounces-23357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DAA5A2DF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDB1895CFA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE192309BD;
	Mon, 10 Mar 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzMQw6RB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867522758F
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631082; cv=none; b=T+oya55jVHm65k1WlRfP/HqGfkR4uztOh6sZgEM6uiO+AadkMwUxbp4B2e5BoPxUsdFwHBR+4A5Ytk1W2+ijVrzhfBRcLLyTDEPTVdDBhx2TA99g4i9f9/R8cXV1iW5MbiVD6FCQFYvQfEinGo57i/yEcxFYezLHkpqV8lSWLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631082; c=relaxed/simple;
	bh=MXp75bobc7IdNcSQMhdbIEIgV0hZWRSOaDIqAhYRZyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kj9YfCQJPlDi4y3pr/hgY87HYmKbG/ci35eVCFKAkuNpQSFpAZ/BkkVSeKCikbhN6h8rKZDouOLP5usF9s/nVE+vTeN9HOz3d5rHa5+d1JRQLY4WsNSVYLj8IhD2vkXqBSK3OhELZU6bLLrjDpIJayG44Oz9CLYAPY/bw6Ikx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzMQw6RB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741631081; x=1773167081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MXp75bobc7IdNcSQMhdbIEIgV0hZWRSOaDIqAhYRZyw=;
  b=hzMQw6RBKjVvTDKnS/x/xXz2xWnHr3vhlOXnt4arDQWxa4BA8P2h2UO1
   qDfpnvPd3rHdMTz8RaXpIe7ndRekHWltqD09eVr/KuZSTPFGNEi662R2J
   DGZQo9+GCRQOy9McyNyb1gqwVqWh9wAqihO9sPORlAU3gD+Tg3fXElw/I
   8QfKIdUfc8AUhkjQMUdSk4WUY+Sk/josEyvJrLsIH6Frtn5q0LwE3rJLT
   hbQaz8sU9+aGZhIncLWT1TBKPbhI/5GBoeauLJXwsIsnlpO4QCsgGymSG
   uSHjUWhTLL4ATCSHwH2fng7WTe1dnjoQ6xTH0qyLb1ecEYCCqpSgeJ6QZ
   A==;
X-CSE-ConnectionGUID: Cbq/8amlTm+/8QnNTFok4A==
X-CSE-MsgGUID: 6TVjuRrWQye4qbpErC2Nbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60048892"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60048892"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:24:41 -0700
X-CSE-ConnectionGUID: UOwUNMZwQzeXYSVK+c8YYQ==
X-CSE-MsgGUID: r1UKsHRwQKK3tC6FZk6I3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="125109975"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 10 Mar 2025 11:24:39 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trhnp-0005wN-0T;
	Mon, 10 Mar 2025 18:24:37 +0000
Date: Tue, 11 Mar 2025 02:23:45 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:10: error: 'const struct
 dw_pcie_ep_ops' has no member named 'intx_capable'
Message-ID: <202503110203.VT1mN4uk-lkp@intel.com>
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
config: csky-randconfig-002-20250311 (https://download.01.org/0day-ci/archive/20250311/202503110203.VT1mN4uk-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503110203.VT1mN4uk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503110203.VT1mN4uk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:10: error: 'const struct dw_pcie_ep_ops' has no member named 'intx_capable'
     316 |         .intx_capable = false,
         |          ^~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-dw-rockchip.c:317:22: warning: initialized field overwritten [-Woverride-init]
     317 |         .raise_irq = rockchip_pcie_raise_irq,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-dw-rockchip.c:317:22: note: (near initialization for 'rockchip_pcie_ep_ops.raise_irq')


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

