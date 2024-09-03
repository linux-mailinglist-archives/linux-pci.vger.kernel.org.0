Return-Path: <linux-pci+bounces-12677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6C396A411
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBD5283B84
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62254405C9;
	Tue,  3 Sep 2024 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELxiChKw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632118858C;
	Tue,  3 Sep 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380317; cv=none; b=qFcrXIO5V5tSXwFOQzuxbxVKcLkDXfHpPuRhOogzsgbAzCm/6nidDJggdV3R0pneb5JaCseQeRD8aGno3Wco/ul1xH4SJdNTrGF7eDcd2e5w/9dojDouZfiZNtjE0P9RxtuaFuP/0vWAfCpHWRKOLKZDvj26OqJMcudQS42gYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380317; c=relaxed/simple;
	bh=e+ztJAswj0zgxwfKO74jE9paujDwSwvONdxkFHmYZtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naA9Azucd2g/SqEQFdVZ108kO9U942mZGK5qSspoSb/Zt2/KpiY5mNnHHFSAYgki2sdHf4OjbaIYEQrgS81+g0IAojYCgOEfaBSjTrY5bs8He8f9IRjDXRnHguiRsxe0MO/H69j4jKAEu/+eE2YV4LvCEtbjtm5v7GwL2B6QEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELxiChKw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725380315; x=1756916315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+ztJAswj0zgxwfKO74jE9paujDwSwvONdxkFHmYZtQ=;
  b=ELxiChKwc4dF49dhSp8SJgCvijuaQLbRpCeWDypeH5xfYPyKrBSMAY99
   oG2TdpEnA1Vx6IG7H4qyYhckxkNytMwzY7eC9gl2jyvLzD2RPXtoxpBLF
   2IGmup6uKGZZCWP0gIy1WQAWMCws+31VrTZdN0H9VUP4msXx2qWfsxvjw
   A12d+775sYxt7ddB479PQAhXWGGyg34QF4NmPrR+7lWPXHChhLvSnePxw
   UhZyiCZp8euY6dXVmO0D1Zr58b2ftZQTKcVqwHkTo2eJGftmVhbb7yaHe
   CTkzHGWKAaLUOwEfWA10OyNrAk8s8o2v/2PaN+uln4JkMsx0QxfdVHbxa
   w==;
X-CSE-ConnectionGUID: Z11yb9mcSximYVxaEofeGg==
X-CSE-MsgGUID: HLLeWEr2TtShi7vdmljLWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="13350043"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="13350043"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 09:18:27 -0700
X-CSE-ConnectionGUID: WLEjygFwQ62mC3ud2PgMXA==
X-CSE-MsgGUID: zETu7SKwTqORrT/a8qb2dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69753081"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Sep 2024 09:18:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slWER-0006t0-2e;
	Tue, 03 Sep 2024 16:18:15 +0000
Date: Wed, 4 Sep 2024 00:17:35 +0800
From: kernel test robot <lkp@intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, acelan.kao@canonical.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <202409040016.XGnUy9HW-lkp@intel.com>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903025544.286223-1-kai.heng.feng@canonical.com>

Hi Kai-Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/PCI-vmd-Delay-interrupt-handling-on-MTL-VMD-controller/20240903-110553
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240903025544.286223-1-kai.heng.feng%40canonical.com
patch subject: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240904/202409040016.XGnUy9HW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040016.XGnUy9HW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040016.XGnUy9HW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/vmd.c:115: warning: Function parameter or struct member 'delay_irq' not described in 'vmd_irq'


vim +115 drivers/pci/controller/vmd.c

7cdbc4e9cd808b5 drivers/pci/controller/vmd.c Kai-Heng Feng 2024-09-03   98  
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12   99  /**
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  100   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  101   * @node:	list item for parent traversal.
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  102   * @irq:	back pointer to parent.
21c80c9fefc3db1 arch/x86/pci/vmd.c           Keith Busch   2016-08-23  103   * @enabled:	true if driver enabled IRQ
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  104   * @virq:	the virtual IRQ value provided to the requesting driver.
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  105   *
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  106   * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  107   * a VMD IRQ using this structure.
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  108   */
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  109  struct vmd_irq {
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  110  	struct list_head	node;
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  111  	struct vmd_irq_list	*irq;
21c80c9fefc3db1 arch/x86/pci/vmd.c           Keith Busch   2016-08-23  112  	bool			enabled;
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  113  	unsigned int		virq;
7cdbc4e9cd808b5 drivers/pci/controller/vmd.c Kai-Heng Feng 2024-09-03  114  	bool			delay_irq;
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12 @115  };
185a383ada2e779 arch/x86/pci/vmd.c           Keith Busch   2016-01-12  116  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

