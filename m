Return-Path: <linux-pci+bounces-34513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE9B30C91
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 05:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD611C88046
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D228A73A;
	Fri, 22 Aug 2025 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5v/vvGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE1289E21;
	Fri, 22 Aug 2025 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833345; cv=none; b=bfpNmtRL/b9vSMooThXK/AnQXkQYKwYfISTHq8dsJo6b+7Meh3/ZcY5QNr3FbUcaAsBxgqA3rX0FP1uF5QVeXecZGy93dwTluSb3up7wbSH5L+xA0zdHPam7bngPt9IuYfrNuykATLTuae8RL+h0c0MdgCn/XOB3aGIQCRZOth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833345; c=relaxed/simple;
	bh=4g+NOdWwaTNFdwMM6/vbTTgDQgvH1CGzNnjQxHwcBQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irwqx36rwPyRNeJkf9PqOP4HIjrXbQVkIPfssYtZsdCV2mrWS5WlTl1EazXtlhu4MWYJ/8I3zuJY4bHQjNStCb6E7FFWWz2UVbMbzOuhddcGMNfQq3LGZ61znkjfHEIT9vAtgZ1qvdKGxF8Hr0jL4tU+lYLoYtlQ4Z5VsfmLul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5v/vvGF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755833344; x=1787369344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4g+NOdWwaTNFdwMM6/vbTTgDQgvH1CGzNnjQxHwcBQg=;
  b=h5v/vvGF0yPb3ZlzxICNZ4iSXBs5EEBrL0kVdw9HUJ6Fvud7i7EMvKHD
   9+J6mlNAkoHwamzpOv8NTQqnq39lf0XiLVnCgReF2i0ujud+SiPiBUTOm
   I7qpuBXwECMUbASKqqZSJ2e5Q1ev8GSQ/8/b/ubP4xnhlqUyMRhJDJB40
   4N/h2LH/45XF43v6RweH31T/D0gyE+GnwhUxaxi8h7O4a+0Xay3fawXDG
   3WxpY3zfpJbzhUMwAvAUva3RGCsu/PaMLdU3/+JDJCJnclIokq8LOeq++
   xcoRt6kiXvJSuoWk172hIPDkofGW+PtL1jo31zL2gbQW/qai57XQ+SNpI
   A==;
X-CSE-ConnectionGUID: gkzudP81Q2a3/Izx1fl6MA==
X-CSE-MsgGUID: DqbZOzOdT+yjxjmFbTRayw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69575023"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69575023"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:29:03 -0700
X-CSE-ConnectionGUID: 0GUAmjcMR3u1FdznOpBq/g==
X-CSE-MsgGUID: l+1pqG1rTImOpTAfJ8Xm/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168496106"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2025 20:29:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upISY-000KsD-0k;
	Fri, 22 Aug 2025 03:28:58 +0000
Date: Fri, 22 Aug 2025 11:27:38 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Del Sol Vives <marcos@orca.pet>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marcos Del Sol Vives <marcos@orca.pet>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
Message-ID: <202508221142.ETxcEpjA-lkp@intel.com>
References: <20250821101902.626329-2-marcos@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821101902.626329-2-marcos@orca.pet>

Hi Marcos,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes pci/next pci/for-linus linus/master v6.17-rc2 next-20250821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Del-Sol-Vives/gpio-gpio-regmap-add-flags-to-control-some-behaviour/20250821-182416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20250821101902.626329-2-marcos%40orca.pet
patch subject: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some behaviour
config: x86_64-buildonly-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221142.ETxcEpjA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221142.ETxcEpjA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221142.ETxcEpjA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpio/gpio-fxl6408.c:11:
>> include/linux/gpio/regmap.h:26:31: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      26 |         GPIO_REGMAP_DIR_BEFORE_SET      = BIT(0),
         |                                           ^
>> include/linux/gpio/regmap.h:26:31: error: expression is not an integer constant expression
      26 |         GPIO_REGMAP_DIR_BEFORE_SET      = BIT(0),
         |                                           ^~~~~~
   In file included from drivers/gpio/gpio-fxl6408.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpio-fxl6408.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpio-fxl6408.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpio-fxl6408.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/gpio/gpio-fxl6408.c:12:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/x86/include/asm/elf.h:10:
   In file included from arch/x86/include/asm/ia32.h:7:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:34:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here


vim +/BIT +26 include/linux/gpio/regmap.h

    14	
    15	
    16	/**
    17	 * enum gpio_regmap_flags - flags to control GPIO operation
    18	 */
    19	enum gpio_regmap_flags {
    20		/**
    21		 * @GPIO_REGMAP_DIR_BEFORE_SET: when setting a pin as an output, set
    22		 * its direction before the value. The output value will be undefined
    23		 * for a short time which may have unwanted side effects, but some
    24		 * hardware requires this.
    25		 */
  > 26		GPIO_REGMAP_DIR_BEFORE_SET	= BIT(0),
    27	};
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

