Return-Path: <linux-pci+bounces-26448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C941EA97B22
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 01:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CCA177D39
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 23:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2A215162;
	Tue, 22 Apr 2025 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP/Nc4jc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAA214238;
	Tue, 22 Apr 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365165; cv=none; b=pDE5LotEUnr7ibEsyp6+Ad6sdQLHxgR+ZEJzNn2+USF3yMI21mwjIOc5fzUZXk7n21EuOv7+N1xE/XwUeqPzlSGU1+kcxwuIietvSgwX8wZhENdrjn6OG66f24YYNhU+FQVnoXdZEPhST3c/J6G/CKe0Rha2kL4GMxWSNK/dF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365165; c=relaxed/simple;
	bh=OHp/ytXznMMejV481b4911g5hrfbMuU8PzS3ocva4vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WScUuYmIZSIet6YVhqxxR0sIgijPNNmEC7UE+AQ5BFf3Bkln4JM1LOcEaZoJBhUnJI98jQundge48Wog57Dq9RpZ0DLTcpk3HNCvyjitn6O2RX1ckwK4smjxuoAhL5Ryc9oAp9Mc91e0awmlFu5YTmjiubJxY+RICCDxuETe++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP/Nc4jc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745365164; x=1776901164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OHp/ytXznMMejV481b4911g5hrfbMuU8PzS3ocva4vg=;
  b=HP/Nc4jc+9RHZoQoUiYTycSifvYCBtmbG2+o9EjwMeOxpf7eFPy3J/z2
   YXCCOTki9dEqMyUdFkvJfFVRSJG9UE5S2gc+DalJ4gYitOz01TKkVBnDw
   7SulT9wgHcZrt9sJN1A8Ylu6UFvxK2yV9GNwUqEL/9wL22ClEPkWWUD0B
   CBd3NCdJ/w6N6N7prCqfOHmmxzp36t9QRDZyE5Z9Od35wfVhezmOihZ70
   O6iUmDLomDmnlKJXRU8gJmTImAIB/lhZXkrzYZV8B/pzHjh9X7G3hKLjI
   PB+5KrzFLgPTr7v+Hw5hknLVD7EqyFFtBiTXewlKCDPT2RE8Nv7XkcD/G
   w==;
X-CSE-ConnectionGUID: yDggZxYsTcyv2LRfYSFUpw==
X-CSE-MsgGUID: XFRz2CldSrarP0WLS4fopg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="69434115"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="69434115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 16:39:23 -0700
X-CSE-ConnectionGUID: fQEYkKKmSKC4xWuha3AAHw==
X-CSE-MsgGUID: 0aZdvzErQcmFm0HgjA9OEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="155357764"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2025 16:39:19 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7NCv-0001Od-2U;
	Tue, 22 Apr 2025 23:39:17 +0000
Date: Wed, 23 Apr 2025 07:39:09 +0800
From: kernel test robot <lkp@intel.com>
To: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <202504230757.wEJUX3v6-lkp@intel.com>
References: <20250422135341.2780925-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422135341.2780925-1-raag.jadav@intel.com>

Hi Raag,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.15-rc3 next-20250422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raag-Jadav/PCI-PM-Avoid-suspending-the-device-with-errors/20250422-215734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250422135341.2780925-1-raag.jadav%40intel.com
patch subject: [PATCH v2] PCI/PM: Avoid suspending the device with errors
config: i386-defconfig (https://download.01.org/0day-ci/archive/20250423/202504230757.wEJUX3v6-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250423/202504230757.wEJUX3v6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504230757.wEJUX3v6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pci-driver.c:887:7: error: call to undeclared function 'pci_aer_in_progress'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     887 |         if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
         |              ^
   1 error generated.


vim +/pci_aer_in_progress +887 drivers/pci/pci-driver.c

   851	
   852	static int pci_pm_suspend_noirq(struct device *dev)
   853	{
   854		struct pci_dev *pci_dev = to_pci_dev(dev);
   855		const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
   856	
   857		if (dev_pm_skip_suspend(dev))
   858			return 0;
   859	
   860		if (pci_has_legacy_pm_support(pci_dev))
   861			return pci_legacy_suspend_late(dev);
   862	
   863		if (!pm) {
   864			pci_save_state(pci_dev);
   865			goto Fixup;
   866		}
   867	
   868		if (pm->suspend_noirq) {
   869			pci_power_t prev = pci_dev->current_state;
   870			int error;
   871	
   872			error = pm->suspend_noirq(dev);
   873			suspend_report_result(dev, pm->suspend_noirq, error);
   874			if (error)
   875				return error;
   876	
   877			if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
   878			    && pci_dev->current_state != PCI_UNKNOWN) {
   879				pci_WARN_ONCE(pci_dev, pci_dev->current_state != prev,
   880					      "PCI PM: State of device not saved by %pS\n",
   881					      pm->suspend_noirq);
   882				goto Fixup;
   883			}
   884		}
   885	
   886		/* Avoid suspending the device with errors */
 > 887		if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
   888			pci_save_state(pci_dev);
   889	
   890			/*
   891			 * If the device is a bridge with a child in D0 below it,
   892			 * it needs to stay in D0, so check skip_bus_pm to avoid
   893			 * putting it into a low-power state in that case.
   894			 */
   895			if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
   896				pci_prepare_to_sleep(pci_dev);
   897		}
   898	
   899		pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
   900			pci_power_name(pci_dev->current_state));
   901	
   902		if (pci_dev->current_state == PCI_D0) {
   903			pci_dev->skip_bus_pm = true;
   904			/*
   905			 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
   906			 * downstream device is in D0, so avoid changing the power state
   907			 * of the parent bridge by setting the skip_bus_pm flag for it.
   908			 */
   909			if (pci_dev->bus->self)
   910				pci_dev->bus->self->skip_bus_pm = true;
   911		}
   912	
   913		if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
   914			pci_dbg(pci_dev, "PCI PM: Skipped\n");
   915			goto Fixup;
   916		}
   917	
   918		pci_pm_set_unknown_state(pci_dev);
   919	
   920		/*
   921		 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
   922		 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
   923		 * hasn't been quiesced and tries to turn it off.  If the controller
   924		 * is already in D3, this can hang or cause memory corruption.
   925		 *
   926		 * Since the value of the COMMAND register doesn't matter once the
   927		 * device has been suspended, we can safely set it to 0 here.
   928		 */
   929		if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
   930			pci_write_config_word(pci_dev, PCI_COMMAND, 0);
   931	
   932	Fixup:
   933		pci_fixup_device(pci_fixup_suspend_late, pci_dev);
   934	
   935		/*
   936		 * If the target system sleep state is suspend-to-idle, it is sufficient
   937		 * to check whether or not the device's wakeup settings are good for
   938		 * runtime PM.  Otherwise, the pm_resume_via_firmware() check will cause
   939		 * pci_pm_complete() to take care of fixing up the device's state
   940		 * anyway, if need be.
   941		 */
   942		if (device_can_wakeup(dev) && !device_may_wakeup(dev))
   943			dev->power.may_skip_resume = false;
   944	
   945		return 0;
   946	}
   947	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

