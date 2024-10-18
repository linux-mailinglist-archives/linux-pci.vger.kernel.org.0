Return-Path: <linux-pci+bounces-14883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AB9A48B7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 23:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9517F1F219FD
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA818E35F;
	Fri, 18 Oct 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCC/aZR8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909F18E341;
	Fri, 18 Oct 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285811; cv=none; b=XZ7B3s2F82906VDpAUmizgkNSbfNUhvPPpRmgQ+aI/dFzqWKPjy90bFeGgvJc47ZF6sV8//qVatXB9Nl7sli6afoqVVWx1SLCbPVm88JU59I4L8Z3VksNLGtWYp1Do15ofG4PRgWP64EwywLe+0h3HECkXHDjsEeN9kutJVyA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285811; c=relaxed/simple;
	bh=hQ0DG6/Eb3j0prKHYX364xskTLEd+9vKpIg1xcOPcDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxxOBegOZrX3Dfm9/r/tfspMHt2SJNwdCgDvIwFEoOhgXXqbBXrqpY7hmhp5kAenC/djxkZ4wiOzPti2U/Rt06Fg6xPI14dfyhVbH8iyu+TlXYCotDbIVqldYCH0SNvrKG/pawp8F8uLPiDi2PfvtxmzEyinmNzyP41xVgbbBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCC/aZR8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729285809; x=1760821809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hQ0DG6/Eb3j0prKHYX364xskTLEd+9vKpIg1xcOPcDw=;
  b=GCC/aZR8vwcft9DKreLN/fmFJWkpkZJFH67WpSDHNksW/CR04ZaKyeWL
   XtoZtoCtFYtmcegKvkavN+KJGVxCjzqAhdXbd+IOOezcGUxYRgKG+kMbb
   xQAYv8nfmcqKBuL0PvyKpfNP6vX9UeHUun1IeLr+j7jsejyAHejBEg/tT
   s16Q+FTgxKC0wfRkNfHwQWmF7NPSlPljsyZ789mZrfGKSamDYzSLkMm8y
   KtP6Yza+q5j5uz+ift8Tp9tKB45O2JaoAIcvYkYlpHFTGrcFA2Cp6MUp4
   QCHIHtEr9tqwvVvFf4T9CQFxMMesDXYZZQ5B3/anHpvfvyAoXOs6vFg0M
   Q==;
X-CSE-ConnectionGUID: V2vtrIvqQPKeQ+r6dTJnFg==
X-CSE-MsgGUID: Zp44uaT9Rnizfp3w3Th97w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28993129"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28993129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 14:10:08 -0700
X-CSE-ConnectionGUID: dr8iIfhTSkuHbpup6ssh2A==
X-CSE-MsgGUID: zkUFIu82SCqVszaErv+rJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78938262"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 14:10:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1uES-000OJS-0e;
	Fri, 18 Oct 2024 21:10:00 +0000
Date: Sat, 19 Oct 2024 05:09:12 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <202410190431.wiCDZy8G-lkp@intel.com>
References: <20241017074637.1265584-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-7-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-net-add-compatible-string-for-i-MX95-EMDIO/20241017-160848
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241017074637.1265584-7-wei.fang%40nxp.com
patch subject: [PATCH v3 net-next 06/13] net: enetc: build enetc_pf_common.c as a separate module
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241019/202410190431.wiCDZy8G-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190431.wiCDZy8G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190431.wiCDZy8G-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>> ERROR: modpost: "enetc_set_ethtool_ops" [drivers/net/ethernet/freescale/enetc/nxp-enetc-pf-common.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

