Return-Path: <linux-pci+bounces-32188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA36B0679A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28471888CAF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064A229B8FE;
	Tue, 15 Jul 2025 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmBiP0Mi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553C26E718;
	Tue, 15 Jul 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610480; cv=none; b=JfHIk/muB7qYHza+ZunajtNIs5Eo/90Rio00vqhphA/6JnOy8wdmHlQ3WchINcFZ0VOqIVV7eX6qDh9NQS+EzPxaAIKETgJs6zhHTa48PLvqBwERwLXHY2EnBVk9FT6iuYoCHMCqnYOlnMZE2VKELhNvt3/dsq4O6m5EVHAmVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610480; c=relaxed/simple;
	bh=eS6Mpdyp46gQ6nUgwPSL7+/IQm0H6qYJBJumRgSICho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CksmdEBWe0+Nd7/DXb3gTwHCHmmYRFQIaMJ6UYr0jG4pfuU/5d5qnbsrpH3WTYtlNX70LiSUVm2mTcsNSyPvvaqmFis2gnBEZ39LGyawu0Aqe2wkieWnph+MD18d050jhH2gLgSYRap59UkuKw7eYMizTBMRp2OZ7F1dLzEUwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmBiP0Mi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752610479; x=1784146479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eS6Mpdyp46gQ6nUgwPSL7+/IQm0H6qYJBJumRgSICho=;
  b=dmBiP0MiVnxoyxG7ejTolJiZyRfIWQ2WYlgBu6qlsKno6S5dxgbF/SvD
   34LCbRmvhCHrnJm0ridK7pfq1LfIWvUzUj/fvh0ZD0nsgD1VTdgaI4TzP
   jN9VtRKgbqXP+y/yplBfAqUVAa/RqOgvYQH+LqG1THbR9Kt3bwGBDfjC3
   yqjc5Sz2k7VZ0P1qwWkRO36bXgzYPzuoEzrZV0KVnm0+muBcbCOkhogJf
   hKhI0dwpcutFIVikhJiB2qqEQyDHXSI/Npvd9mpipPPt+ZO1nduBj2xJZ
   J1XJkHs0OG39SpHYC7/Oxit958NLn1HZ8NEw+HGqLhvw3f4+oT0b1k8yB
   A==;
X-CSE-ConnectionGUID: hfmNCGSkQS+Wd9wxJOWG4w==
X-CSE-MsgGUID: UP2wvDnzTZSf/yxQ43RFwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42473888"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="42473888"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:14:39 -0700
X-CSE-ConnectionGUID: swZoM0+0REi7GGWqObo93g==
X-CSE-MsgGUID: nZzgw5MpQzKGR4ifrqa3mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="161631582"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jul 2025 13:14:34 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubm2p-000BVn-1r;
	Tue, 15 Jul 2025 20:14:31 +0000
Date: Wed, 16 Jul 2025 04:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, p.zabel@pengutronix.de,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 08/10] PCI: Add FMT and TYPE definition for TLP header
Message-ID: <202507160314.e3odwyX7-lkp@intel.com>
References: <20250715034320.2553837-9-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-9-jacky_chou@aspeedtech.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Chou/dt-bindings-soc-aspeed-Add-ASPEED-PCIe-Config-support/20250715-114814
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250715034320.2553837-9-jacky_chou%40aspeedtech.com
patch subject: [PATCH v2 08/10] PCI: Add FMT and TYPE definition for TLP header
config: i386-buildonly-randconfig-004-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160314.e3odwyX7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160314.e3odwyX7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.e3odwyX7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
   In file included from ./usr/include/linux/pci.h:21:
>> usr/include/linux/pci_regs.h:1234:39: warning: // comments are not allowed in this language [-Wcomment]
    1234 | #define PCI_TLP_FMT_3DW_NO_DATA         0x0  // 3DW header, no data
         |                                              ^
   1 warning generated.
--
   In file included from <built-in>:1:
>> ./usr/include/linux/pci_regs.h:1234:39: warning: // comments are not allowed in this language [-Wcomment]
    1234 | #define PCI_TLP_FMT_3DW_NO_DATA         0x0  // 3DW header, no data
         |                                              ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

