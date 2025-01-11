Return-Path: <linux-pci+bounces-19644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080EA0A339
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F418016B0A4
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CF18FDDF;
	Sat, 11 Jan 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdFNufYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E71917F9;
	Sat, 11 Jan 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593786; cv=none; b=gb7uabl42Qb9TijNxcB+pkRYenZULhCzh9tg8k5HiZYLCYkS09lHa7uYSPVRbFrU7EEwBtuEAM+Gz76py2fwYa+PfLugpchlkaH6yZElHM0E6ahdpo7RnSoiMDBUnpsrOR4qdKYz2D3UEiUMkqnkPw3QOl9i/AjW6gwMRnFCMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593786; c=relaxed/simple;
	bh=EPRt+kkcZBvWzhnBv8y7+iUHRzGlu9gQ1lTAJLYHr68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrW6w2T0aG3hWX19Hm8MeXCxJk9+Dp/YbxFRA9ok3KbBUDcooBAp2nGVfBbkPZW9WQiVS6MAT3Yx2D2nTrY9N5Jm3I68iYydNG7vxgR1120pIkg0bf+mtarkLzeGtGUSSjCuXVcLffkZHE+YquUHB0yh4lfI7+cEz5gNUJ6VYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdFNufYb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736593783; x=1768129783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPRt+kkcZBvWzhnBv8y7+iUHRzGlu9gQ1lTAJLYHr68=;
  b=kdFNufYborH24+L5R5XKIFSBjbS/lQu1jJyD4U7cYjjw9YYKvmLGeW2z
   0bRTPz2wL8s+vGlixlgpayGVHQauuBCFOhZOmaiX26y1p7VnllfCpk1BR
   lsgoX4RZLW5qWWP4Yg1ErnG7motcoE89QhxtZkX5IjOu4ApP6yqPrfNWC
   2xj/Raz7k8detE39su7zAizjCeKAdq0+Ns2C0Jw0Xv5Tdi3DvjFvhZx8s
   /owmIkvLTBfUea+civO+HrGfvlbdn1eb059fK380r9tczwF18Y3/PAOf2
   ytLKw1R/Nl1Bn9VU9RtAebhPdJP+A9wlmlw59wUBj9jFSw7dLa8eHGsS+
   A==;
X-CSE-ConnectionGUID: TKHh4Z0xQGC8/1TMOLKE+A==
X-CSE-MsgGUID: +p8YwKNATBWvGkOox2CC/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="39698422"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="39698422"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 03:09:42 -0800
X-CSE-ConnectionGUID: tgfbQNgiRQWNL1IdbkLGug==
X-CSE-MsgGUID: zWHsp1HuRgmlsZU4b7yXxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="104150974"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jan 2025 03:09:39 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWZN2-000KZD-0q;
	Sat, 11 Jan 2025 11:09:36 +0000
Date: Sat, 11 Jan 2025 19:08:50 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
Message-ID: <202501111839.HXJGe5FL-lkp@intel.com>
References: <20250110140152.27624-4-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110140152.27624-4-roger.pau@citrix.com>

Hi Roger,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus xen-tip/linux-next tip/irq/core linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-Pau-Monne/xen-pci-do-not-register-devices-outside-of-PCI-segment-scope/20250110-220331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250110140152.27624-4-roger.pau%40citrix.com
patch subject: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
config: arm64-randconfig-003-20250111 (https://download.01.org/0day-ci/archive/20250111/202501111839.HXJGe5FL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111839.HXJGe5FL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111839.HXJGe5FL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/msi/msi.c:288:40: error: incomplete definition of type 'struct irq_domain'
     288 |         const struct msi_domain_info *info = d->host_data;
         |                                              ~^
   include/linux/irq.h:130:8: note: forward declaration of 'struct irq_domain'
     130 | struct irq_domain;
         |        ^
   drivers/pci/msi/msi.c:604:40: error: incomplete definition of type 'struct irq_domain'
     604 |         const struct msi_domain_info *info = d->host_data;
         |                                              ~^
   include/linux/irq.h:130:8: note: forward declaration of 'struct irq_domain'
     130 | struct irq_domain;
         |        ^
   drivers/pci/msi/msi.c:714:40: error: incomplete definition of type 'struct irq_domain'
     714 |         const struct msi_domain_info *info = d->host_data;
         |                                              ~^
   include/linux/irq.h:130:8: note: forward declaration of 'struct irq_domain'
     130 | struct irq_domain;
         |        ^
   3 errors generated.


vim +288 drivers/pci/msi/msi.c

   283	
   284	static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
   285				      struct irq_affinity_desc *masks)
   286	{
   287		const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
 > 288		const struct msi_domain_info *info = d->host_data;
   289		struct msi_desc desc;
   290		u16 control;
   291	
   292		/* MSI Entry Initialization */
   293		memset(&desc, 0, sizeof(desc));
   294	
   295		pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
   296		/* Lies, damned lies, and MSIs */
   297		if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
   298			control |= PCI_MSI_FLAGS_MASKBIT;
   299		if (info->flags & MSI_FLAG_NO_MASK)
   300			control &= ~PCI_MSI_FLAGS_MASKBIT;
   301	
   302		desc.nvec_used			= nvec;
   303		desc.pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
   304		desc.pci.msi_attrib.can_mask	= !!(control & PCI_MSI_FLAGS_MASKBIT);
   305		desc.pci.msi_attrib.default_irq	= dev->irq;
   306		desc.pci.msi_attrib.multi_cap	= FIELD_GET(PCI_MSI_FLAGS_QMASK, control);
   307		desc.pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
   308		desc.affinity			= masks;
   309	
   310		if (control & PCI_MSI_FLAGS_64BIT)
   311			desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
   312		else
   313			desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
   314	
   315		/* Save the initial mask status */
   316		if (desc.pci.msi_attrib.can_mask)
   317			pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
   318	
   319		return msi_insert_msi_desc(&dev->dev, &desc);
   320	}
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

