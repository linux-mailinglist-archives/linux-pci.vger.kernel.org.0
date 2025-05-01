Return-Path: <linux-pci+bounces-27062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACDEAA5CA3
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73291BC1FD3
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EE22B8C0;
	Thu,  1 May 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjY2C2cm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73520E03C;
	Thu,  1 May 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746091641; cv=none; b=dsEu9zacKD7q3GGljDxScicBUGLecO19Cprm5uQVQnxXd4u2XQys8w/2x9cHveh7VdmY8ZdFlnO6BooM/2npBiXrIwk0nBcTKNxCWNjkvk9TBzkNQFt2R2sobbSgUmnnau3fJdzxcbHwp5Hvfc59Vy///uo+31SXGVxqXMLxf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746091641; c=relaxed/simple;
	bh=Z3FUNBSpbmp7v3k/CJmY5lFbQ1TQFPplgNK+yntHNR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbZXB7H63wlbd/mGepKa8TOFpgcEQj8m5feLCgFUr4/MuyESYP6lk9Ii3Of8ukaH7+tXSDDnayZ2eiQh5sFvdMkTwViP2yvlzifgo4RDMFn++jNCEBlp1pO/9Fpe3IySW6+fj3Y1GVW9M6JWf7pXAyIc/Ew8hMIzSKuhUS3OW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjY2C2cm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746091639; x=1777627639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z3FUNBSpbmp7v3k/CJmY5lFbQ1TQFPplgNK+yntHNR8=;
  b=bjY2C2cm/6qr/XpQAa1Z24vfiWqSfK1gG09PepJD6NfOGeX8gXFQr7GW
   UZhFJBH52A3fTwu+uvyI0LOuX2E5hTJcw2JEuWchiO9LrAstUANFYkIr6
   8TqrWQdDpLRpmfb62GwUNTPuY17uzWWGM9e2F7htLcQ6HgJp97jLyLrk0
   yh336TgS/J3owpqM3od6o7Kr5LjMmPkOxqSBeD+wWGSueEnjirdzg19tj
   +5Jj0kVV47Jf8H1873CySe/oGf0G3TCmTV0itH6ZBl8EXriAydOQg1Mnh
   dkaqVA5ZU5VVqSwTCtMaqPsY58J2oDeq6w769oHgaxBJ6CAtncP5MSn1Y
   g==;
X-CSE-ConnectionGUID: sA/ltEP6SqSswYldygPMww==
X-CSE-MsgGUID: JTZ7ZMLjTBKTTUOuU/BF7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51584512"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="51584512"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:27:18 -0700
X-CSE-ConnectionGUID: I/qWFAg7SGqQ9mZHJC7ZZA==
X-CSE-MsgGUID: o9QTmBoyRuqRtpnZz5bIJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134088028"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 May 2025 02:27:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAQCE-000453-1I;
	Thu, 01 May 2025 09:27:10 +0000
Date: Thu, 1 May 2025 17:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	saravanak@google.com, p.zabel@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 1/8] soc: renesas: r9a08g045-sysc: Add max reg offset
Message-ID: <202505011714.p63Hj7Fe-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus geert-renesas-devel/next geert-renesas-drivers/renesas-clk robh/for-next arm64/for-next/core linus/master v6.15-rc4 next-20250430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu/soc-renesas-r9a08g045-sysc-Add-max-reg-offset/20250430-183951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250430103236.3511989-2-claudiu.beznea.uj%40bp.renesas.com
patch subject: [PATCH 1/8] soc: renesas: r9a08g045-sysc: Add max reg offset
config: arm64-randconfig-001-20250501 (https://download.01.org/0day-ci/archive/20250501/202505011714.p63Hj7Fe-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250501/202505011714.p63Hj7Fe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505011714.p63Hj7Fe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/renesas/r9a08g045-sysc.c:23:3: error: 'const struct rz_sysc_init_data' has no member named 'max_register_offset'
      23 |  .max_register_offset = 0xe28,
         |   ^~~~~~~~~~~~~~~~~~~
>> drivers/soc/renesas/r9a08g045-sysc.c:23:25: warning: excess elements in struct initializer
      23 |  .max_register_offset = 0xe28,
         |                         ^~~~~
   drivers/soc/renesas/r9a08g045-sysc.c:23:25: note: (near initialization for 'rzg3s_sysc_init_data')


vim +23 drivers/soc/renesas/r9a08g045-sysc.c

    20	
    21	const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
    22		.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
  > 23		.max_register_offset = 0xe28,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

