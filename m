Return-Path: <linux-pci+bounces-22710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A3A4AEA2
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 02:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8777D16F0DF
	for <lists+linux-pci@lfdr.de>; Sun,  2 Mar 2025 01:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FEFBF6;
	Sun,  2 Mar 2025 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRA38Wnt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ECE322E;
	Sun,  2 Mar 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740877958; cv=none; b=MlCg0XMFXwzc9AwZZkiJCqPWp0y08/atUvGiNbtRp37Uhpgs0c14q07/wEi+ZhKO0hVLGPbvVQGWRWPuT/2r3zNFm/rT40Vwx03cO5EavBn3Y9/28M+TnSj38UxXxldKuzAIEGONYHM7lOGEvW/I4YejgnMd5CWcM7Qpbbw7AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740877958; c=relaxed/simple;
	bh=8PzwIU+pVqzFTXdCsd9e9LKK4yEitdocKyokMp8dNUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj49ofQ0rr0bc6PvFNYP5cOBR2ftB+1SYvahy5locnFvXhVsaAbzoaKEFGnJcgPDMuLJgoYs+Uh7h4eLJPszb7wdm7t/geLjwjwymFIK62wk6xT0SYl03ZC9x8o0p+HGtQL4PjBqfvU9Phhj3Jivg6sczdDDKpoZSyvQzC4yjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRA38Wnt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740877956; x=1772413956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PzwIU+pVqzFTXdCsd9e9LKK4yEitdocKyokMp8dNUA=;
  b=BRA38Wnt3uW2kr2JviGrAjjQ7PHwWLluBBmy4o7kDVaO4eqeOSpmpMKK
   3oYH2rGn40T2+WzFS3C1421t9x+B0256qftquCz80R0LwrgOau7CtJvbg
   6bQImtYYjFX8H5qXoFrGeEVw/QVy3hpR2nwJxdmZcBD1Fj8xkSqYpIkYq
   o6wVYKaiOHPK7l4kNRKQpVp4ep7VxvAiHjFPE/3oNK9wY1SJ37YtgTpiK
   o3kTgNxy6vCa7EKcSlb08gqXw0I530EOfMqK9q6jeRmz/2THFqLcWCxLE
   +wHNQiS0QDUtqEcc5sZiJUCkEgUaUyoA+H3Q4y0KNItzTIF5eIfXsI6Rm
   Q==;
X-CSE-ConnectionGUID: zyCcxbHlRHyv/ZSTY5TUlw==
X-CSE-MsgGUID: FPCdhguuQiubbp3qcsR9BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41475825"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41475825"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 17:12:36 -0800
X-CSE-ConnectionGUID: 3AoXPGBfSM6CPJJeptimzw==
X-CSE-MsgGUID: 4VqIWQJnRzmD25mMZRw+nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122278012"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 01 Mar 2025 17:12:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toXsc-000GvC-1r;
	Sun, 02 Mar 2025 01:12:30 +0000
Date: Sun, 2 Mar 2025 09:12:04 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, manivannan.sadhasivam@linaro.org,
	kw@linux.com, kwilczynski@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v2] genirq/msi: Add the address and data that show MSI/MSIX
Message-ID: <202503020812.PKZf7JBa-lkp@intel.com>
References: <20250301123953.291675-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301123953.291675-1-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 76544811c850a1f4c055aa182b513b7a843868ea]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/genirq-msi-Add-the-address-and-data-that-show-MSI-MSIX/20250301-204332
base:   76544811c850a1f4c055aa182b513b7a843868ea
patch link:    https://lore.kernel.org/r/20250301123953.291675-1-18255117159%40163.com
patch subject: [v2] genirq/msi: Add the address and data that show MSI/MSIX
config: arm-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020812.PKZf7JBa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020812.PKZf7JBa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020812.PKZf7JBa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/msi.c: In function 'msi_domain_debug_show':
   kernel/irq/msi.c:770:9: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Wimplicit-function-declaration]
     770 |         seq_printf(m, "%*s%s:", ind, "", is_msix ? "msix" : "msi");
         |         ^~~~~~~~~~
         |         bstr_printf
   kernel/irq/msi.c: At top level:
   kernel/irq/msi.c:782:10: error: 'const struct irq_domain_ops' has no member named 'debug_show'
     782 |         .debug_show     = msi_domain_debug_show,
         |          ^~~~~~~~~~
>> kernel/irq/msi.c:782:27: warning: excess elements in struct initializer
     782 |         .debug_show     = msi_domain_debug_show,
         |                           ^~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c:782:27: note: (near initialization for 'msi_domain_ops')


vim +782 kernel/irq/msi.c

   775	
   776	static const struct irq_domain_ops msi_domain_ops = {
   777		.alloc		= msi_domain_alloc,
   778		.free		= msi_domain_free,
   779		.activate	= msi_domain_activate,
   780		.deactivate	= msi_domain_deactivate,
   781		.translate	= msi_domain_translate,
 > 782		.debug_show     = msi_domain_debug_show,
   783	};
   784	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

