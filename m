Return-Path: <linux-pci+bounces-14899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5976F9A4CB2
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134B9285181
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB41DF990;
	Sat, 19 Oct 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOg1sR9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CE1DF74B;
	Sat, 19 Oct 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729331077; cv=none; b=PXnaTjk677dcEPy+pNNDyba8S305vvEvQyjtKSYU+VlAuSkFqypjrStMmFla+m97QE1+N5vavYHrj3O3tpsvEVW87gO/LdXvzPvHK/UPhsrX1ucWwPhUPNKoFZshtlRpW83wg+I0SNXTVgCPtEvCxdNqpI60TlGUHm75Q1d2NTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729331077; c=relaxed/simple;
	bh=8JKQHEed5f/WTiLw6VZKnZcCY2h2Gs+L+t+SxwiypVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bInJ+2Qx+BwQR25IB0H1FiW56i5o3DmnoGG/31SN3mdR4NJ67KA0XeKlnGMlR7RFuKSJJuLzffa+n5R6Do1kva/kLiVYz87oMu/d6trJXUluiirNNNmXN5dzNTALNGCsxBNApEaosZOcdQ75X2R5tw7olKQnuJBUAsaoCm1IvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOg1sR9B; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729331076; x=1760867076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8JKQHEed5f/WTiLw6VZKnZcCY2h2Gs+L+t+SxwiypVI=;
  b=MOg1sR9BxCy/3od0ljh0pQj1Yw2NIa+wczzGJ4v22KT4Te6OBkUnksel
   0XSmk5ebPn3PS908x0+7UlAW1YrqL2X1ozirGdaICtK1j5kYvjDd1bv5H
   6d5ZcMu+9mf5MMFVAzJ0sJBu780T7yEsDJsDCaL9E010oJkw9IGTKRDje
   MHiwfXSymWjQ8HcfTTBiyB6qE56gV456Q7tBYiWdm+DOie9VQ7hm5K7mO
   67tLQfAf73y4hlAUOvRYvRqjzhPwsxAdubtQIGuLuRxnuc5NC3cwS5nyU
   JVJJyq/ncwh1nWZRENbYWus4PiFsfD2rseahfFtj2qfCr+VrzB5INKCjI
   Q==;
X-CSE-ConnectionGUID: rzH9TSsMSDuGph5uGy2EcA==
X-CSE-MsgGUID: 9J0JqVt4SSCWXUkaPeAQQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28995780"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="28995780"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 02:44:32 -0700
X-CSE-ConnectionGUID: BACNGPuUQ1WafYM+UNO0rg==
X-CSE-MsgGUID: OQg0m7ppRs2uezzrmdjyyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="79145234"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Oct 2024 02:44:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t260X-000OsF-20;
	Sat, 19 Oct 2024 09:44:25 +0000
Date: Sat, 19 Oct 2024 17:43:52 +0800
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
Message-ID: <202410191715.TQmESUy9-lkp@intel.com>
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20241019/202410191715.TQmESUy9-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410191715.TQmESUy9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410191715.TQmESUy9-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/net/ethernet/freescale/enetc/enetc_pf_common.o: in function `enetc_pf_netdev_setup':
>> enetc_pf_common.c:(.text+0x55e): undefined reference to `enetc_set_ethtool_ops'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

