Return-Path: <linux-pci+bounces-29914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BAEADC24D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 08:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3344C3AD1C8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE228B7DB;
	Tue, 17 Jun 2025 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJ6AIsUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C818528E;
	Tue, 17 Jun 2025 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750141318; cv=none; b=p2gc+WNMvhmuBF255Vp8dCdcQVv5Mxn2wNu9wiTHmnCC4BAstX7nyglhHru6R9JYO2ekpRZe0C9QPNiUFXMKSjU4tqB7+WWnaRn1f6i0r/VbUP6OEbP48GfAcNSJ72yMT8d5iD+3HMNcaSBauhXQvzK6+RqC9v1V2oJ3El3xnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750141318; c=relaxed/simple;
	bh=7WMnIAB52I00dnpzMybWE815AWl4bKC3OBG2ss/MyDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWA27Gl1Y5ShzO+xjJorLMbfhuB27M4VVy6rjnyJ4iJz6gGuuj156ErUJiCXWHtiudGN+nE9ZgxTFQOgwZW6isoaVuvaDCEKHMpxoytjIaR3YhEOAo0/GtsfUbCUPxctA7IllpcFmegO1zIqmqqGgqmJuhH0SeNXP1pENtQcEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJ6AIsUe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750141317; x=1781677317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WMnIAB52I00dnpzMybWE815AWl4bKC3OBG2ss/MyDg=;
  b=EJ6AIsUerss0l/nmH1DB/M4tp+3TYVSCn4ClGh2/cpNwYv/4z8n0LBs/
   uM0Qz87MZydoL4PrFgmSo1lRdMTharwa89iUVcD2LE2TDwqzIpcY8XDqE
   E3Y99ECxwD/e1bncWFt8qD5Ochr+gLQyUCN8dokOt5+W5Zoqr0V/4omRR
   bUZMu+odTfbNQ1J3E3uaEGZ1p+TpXeyp/3hHYfZcZB6PDY/5F0SctZ7qe
   QMBkd9HYf9bYAHgIFJIX4UW5oykF4RPy9fZ/zNvI640y0trN/0O2fwsme
   UhNZMwfd8R5jNnNLVPLlDFVh27snJv0PcoZOqWC1H/ebF/18V1fZ/w9uP
   Q==;
X-CSE-ConnectionGUID: kqVGJnwXQoWjAtomGqUrIw==
X-CSE-MsgGUID: ke/bNd4fTCaw401ATKXL1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="77698159"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="77698159"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 23:21:56 -0700
X-CSE-ConnectionGUID: EZlHW9uoR9Whd36m92cfMg==
X-CSE-MsgGUID: 2W3a49RCS/KbjciADHmnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="153857607"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Jun 2025 23:21:54 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRPhf-000Fg0-0v;
	Tue, 17 Jun 2025 06:21:51 +0000
Date: Tue, 17 Jun 2025 14:21:35 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH] PCI: endpoint: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <202506171435.UiUpSaqs-lkp@intel.com>
References: <20250616152515.966480-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616152515.966480-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-endpoint-Use-common-PCI-host-bridge-APIs-for-finding-the-capabilities/20250616-232735
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20250616152515.966480-1-18255117159%40163.com
patch subject: [PATCH] PCI: endpoint: Use common PCI host bridge APIs for finding the capabilities
config: powerpc-randconfig-r073-20250617 (https://download.01.org/0day-ci/archive/20250617/202506171435.UiUpSaqs-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506171435.UiUpSaqs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506171435.UiUpSaqs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-ep.c:90:9: error: call to undeclared function 'PCI_FIND_NEXT_CAP_TTL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      90 |         return PCI_FIND_NEXT_CAP_TTL(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
         |                ^
   1 error generated.


vim +/PCI_FIND_NEXT_CAP_TTL +90 drivers/pci/controller/dwc/pcie-designware-ep.c

    87	
    88	static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
    89	{
  > 90		return PCI_FIND_NEXT_CAP_TTL(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
    91					     cap, ep, func_no);
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

