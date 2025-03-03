Return-Path: <linux-pci+bounces-22748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD2A4BBC0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D3A16A7EC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818B1F1525;
	Mon,  3 Mar 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6vZzUqh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55F1F09A8;
	Mon,  3 Mar 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996876; cv=none; b=shj9cSNfOKojfWZZpuRES79xGaspJmxtPV4yXn+MQhpjtIOgJtS925W9UCqqy1KbEEQ4ZdJqYCEGr3nVS7sOqTUyQd6qO8upv0zNyGAk4RmiHSjeGzXqYo7qheW7wUhyxeB4h35ZSq4TPFZBdq/eMsAf2dIjBK70Ep9yOC5O/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996876; c=relaxed/simple;
	bh=lkZaj9uqtTh8hEsign5KZMtVATzuW4IX9LDEg7WlQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5sQpECTgmTB2lnvBsdBiaKMHNnAmZmMPuoO26fXklqYQMfopyXoMTdMCZgKM3a1AiE/taXo5dCMwyP5+fP3Q5ngEfUefrI9SbBan8H/gOxTT1NIUzQ9RPeEIXRcB2mWaOBbOqRfUsMeHGZo+QFLlLLPmZFTG7hoC8bhYoQr8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6vZzUqh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740996874; x=1772532874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lkZaj9uqtTh8hEsign5KZMtVATzuW4IX9LDEg7WlQWE=;
  b=f6vZzUqhvn8Q9mUsGGQs52rRurvElNYa5/oOwguuAKpOlNFMeqmPyFSQ
   JELl+zkdLwMYy3+SNXqKvQWqZtOdbsp1SHlx36qfP878eQxKUM6CwIwb6
   NOqmWDYxTY0KPOnEkrwiF5zjqmtkhJtDp5AHOaclQ/HZIOqNh9QbHRZK9
   ypBBpITgVzlXnn3fgYiQS2rS4CtAoyesCG3WU1MDVrS3IVJ6IZX63bSLz
   87gfwYMgXX6oldWmdqw8+xpWcTAuALFSbjsMWXx4kXsZ0lrYg/sE3DOFk
   G6JEeW9nUdyx7EKrCBSD4f6ABp+26BfE5l3SWsZxNEbg5rYUk/jrmE3xE
   A==;
X-CSE-ConnectionGUID: 6KiSZ6QFQHSaS2HjJkgD/A==
X-CSE-MsgGUID: QTxfqPWNTXatSf/wYSXiCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="52843611"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="52843611"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 02:14:34 -0800
X-CSE-ConnectionGUID: rN1sCiqRSv29QdX9eoTyaQ==
X-CSE-MsgGUID: cKOWUCSWQhyHb6DQ5Z4cBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117818554"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 02:14:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tp2od-000IKV-2v;
	Mon, 03 Mar 2025 10:14:27 +0000
Date: Mon, 3 Mar 2025 18:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Tsai <danielsftsai@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Andrew Chant <achant@google.com>,
	Brian Norris <briannorris@google.com>,
	Sajid Dalvi <sdalvi@google.com>, Mark Cheng <markcheng@google.com>,
	Ben Cheng <bccheng@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the
 parent
Message-ID: <202503031759.oiGkE9fl-lkp@intel.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303070501.2740392-1-danielsftsai@google.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus mani-mhi/mhi-next linus/master v6.14-rc5 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Tsai/PCI-dwc-Chain-the-set-IRQ-affinity-request-back-to-the-parent/20250303-150704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250303070501.2740392-1-danielsftsai%40google.com
patch subject: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
config: sparc64-randconfig-002-20250303 (https://download.01.org/0day-ci/archive/20250303/202503031759.oiGkE9fl-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503031759.oiGkE9fl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503031759.oiGkE9fl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware-host.c: In function 'dw_pci_msi_set_affinity':
>> drivers/pci/controller/dwc/pcie-designware-host.c:223:58: error: 'struct irq_common_data' has no member named 'affinity'
     223 |                 cpumask_copy(desc_parent->irq_common_data.affinity, mask);
         |                                                          ^


vim +223 drivers/pci/controller/dwc/pcie-designware-host.c

   178	
   179	static int dw_pci_msi_set_affinity(struct irq_data *d,
   180					   const struct cpumask *mask, bool force)
   181	{
   182		struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
   183		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
   184		int ret;
   185		int virq_parent;
   186		unsigned long hwirq = d->hwirq;
   187		unsigned long flags, ctrl;
   188		struct irq_desc *desc_parent;
   189		const struct cpumask *effective_mask;
   190		cpumask_var_t mask_result;
   191	
   192		ctrl = hwirq / MAX_MSI_IRQS_PER_CTRL;
   193		if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
   194			return -ENOMEM;
   195	
   196		/*
   197		 * Loop through all possible MSI vector to check if the
   198		 * requested one is compatible with all of them
   199		 */
   200		raw_spin_lock_irqsave(&pp->lock, flags);
   201		cpumask_copy(mask_result, mask);
   202		ret = dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_result);
   203		if (ret) {
   204			dev_dbg(pci->dev, "Incompatible mask, request %*pbl, irq num %u\n",
   205				cpumask_pr_args(mask), d->irq);
   206			goto unlock;
   207		}
   208	
   209		dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
   210			cpumask_pr_args(mask_result), d->irq);
   211	
   212		virq_parent = pp->msi_irq[ctrl];
   213		desc_parent = irq_to_desc(virq_parent);
   214		ret = desc_parent->irq_data.chip->irq_set_affinity(&desc_parent->irq_data,
   215								   mask_result, force);
   216	
   217		if (ret < 0)
   218			goto unlock;
   219	
   220		switch (ret) {
   221		case IRQ_SET_MASK_OK:
   222		case IRQ_SET_MASK_OK_DONE:
 > 223			cpumask_copy(desc_parent->irq_common_data.affinity, mask);
   224			fallthrough;
   225		case IRQ_SET_MASK_OK_NOCOPY:
   226			break;
   227		}
   228	
   229		effective_mask = irq_data_get_effective_affinity_mask(&desc_parent->irq_data);
   230		dw_pci_update_effective_affinity(pp, ctrl, effective_mask, hwirq);
   231	
   232	unlock:
   233		free_cpumask_var(mask_result);
   234		raw_spin_unlock_irqrestore(&pp->lock, flags);
   235		return ret < 0 ? ret : IRQ_SET_MASK_OK_NOCOPY;
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

