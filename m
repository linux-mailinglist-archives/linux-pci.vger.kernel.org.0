Return-Path: <linux-pci+bounces-27063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E831AA5D42
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FC79C4C5F
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545EF218AC4;
	Thu,  1 May 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIK19x1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCA145A03;
	Thu,  1 May 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095635; cv=none; b=MQ4maOTK0Yy2s07ES4NOR0pKoqqN3ULyrB8evrC/QV23PZ2CoHhwkBDwHhtc5j0o1MhTK+ewB56LI87hDbX5PywCLb4pEzDIJYLBzmqJMK5xSVsfh2bw0G9cy5ebTdGi/2ooqZJHqBEBR1L5/H+CuUpT+WU2Yp5K3HR/lG5lmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095635; c=relaxed/simple;
	bh=X6UR650SqjHCyahtjHRoHLJWzg+YRrp5P85X9aePAJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9AseHg8HNxl32JDvIKsFLxEUQhIzmfZSzhOTtIiAXv50SkbGyyLHnzd950gai+LAN15BqpXgzTqM2HRNcp2gZGqAwVLZQ51mthpRrGY4bXUg6LA+Tr/Cd+nmZ8wZyCeNA8/K/GlV7X3Y1NHB6eQVFXPlXosdYW+1pB8bkuRzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIK19x1B; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746095633; x=1777631633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6UR650SqjHCyahtjHRoHLJWzg+YRrp5P85X9aePAJY=;
  b=LIK19x1B9uOqVY7STXK+Z4biUkMFj6BonLAC8n44wgdad8YPiUMDY3MQ
   xOu+7THMuhyIokYE411+I1FBHd/D/UMJxCk56etkzvYvCXv2lRflVFDcN
   h+IJFYmSdUVx28nAcXs1set7T1EN44frEkZIUixvcaQzlS8abgAIG0lWO
   AdjCUEhzgMRZnnGiqlqos9og2IPNC7V2eo4JCJ2kkdNrbdeN7S+BnR7b3
   0svmcL7jqv0WbfWPw0oDkgMsmCdlUlB4197vyKkXqhD8hAA95awko+bFx
   WIX7XpBipfL6NNMEIobanVbDP8aKOm2E7nZel4ODCF5Rr91x77yALhwKg
   Q==;
X-CSE-ConnectionGUID: 95WIXLUuROG7Fb2TP63cZw==
X-CSE-MsgGUID: 5krX5IgERMGXqVs4v9R25g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="70266716"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="70266716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:33:52 -0700
X-CSE-ConnectionGUID: GFVwQs/WS9WyCnQPuxzS9A==
X-CSE-MsgGUID: 9/8z731hQXmpMAACsa26tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134878633"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 May 2025 03:33:47 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAREe-00046b-2d;
	Thu, 01 May 2025 10:33:44 +0000
Date: Thu, 1 May 2025 18:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	saravanak@google.com, p.zabel@pengutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 1/8] soc: renesas: r9a08g045-sysc: Add max reg offset
Message-ID: <202505011843.2uKgWFN0-lkp@intel.com>
References: <20250430103236.3511989-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430103236.3511989-2-claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus geert-renesas-devel/next geert-renesas-drivers/renesas-clk robh/for-next arm64/for-next/core linus/master v6.15-rc4 next-20250430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu/soc-renesas-r9a08g045-sysc-Add-max-reg-offset/20250430-183951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250430103236.3511989-2-claudiu.beznea.uj%40bp.renesas.com
patch subject: [PATCH 1/8] soc: renesas: r9a08g045-sysc: Add max reg offset
config: arm64-randconfig-003-20250501 (https://download.01.org/0day-ci/archive/20250501/202505011843.2uKgWFN0-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250501/202505011843.2uKgWFN0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505011843.2uKgWFN0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/renesas/r9a08g045-sysc.c:23:3: error: field designator 'max_register_offset' does not refer to any field in type 'const struct rz_sysc_init_data'
      23 |         .max_register_offset = 0xe28,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +23 drivers/soc/renesas/r9a08g045-sysc.c

    20	
    21	const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
    22		.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
  > 23		.max_register_offset = 0xe28,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

