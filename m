Return-Path: <linux-pci+bounces-23130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E5A56D04
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D47169D0C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762552206BA;
	Fri,  7 Mar 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk5R+Hr0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894AF2206AF;
	Fri,  7 Mar 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363316; cv=none; b=Hy56UcXjRz2ll85IU2jrHdokFk/mVyf9cefptw9Fj+X8mcZTqa3kCoryahtjyZM8LLej3C1gJF0RAylJvXDdl6Wyx5QmrPs8nIDpKhmq1c+ehmHa4KNYCLiHdgkpU/iNWaxsYVyhDpQW9XtKyKP8qqCcW0sStFxaW43vytfngIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363316; c=relaxed/simple;
	bh=USwgT1jzvRdp1Oc/wwluIHHtxEgVqiKoaZgZt7DJfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqIYwjDJhsM+TBFnqp/qmrdETa8u/yDo3f5DUlYDFsPW9tHXIll1NYf21N0Adnk6rDpNL8u50n0jpvxKS7L6ZzRavR8ykY1jx8d30RgVSUEYdoHmX7wGEjukB3DpJ33ZSnmR5ps/hNvtFm6knftJuJJSwbOVh6PN2cQpSyDisXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nk5R+Hr0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741363314; x=1772899314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=USwgT1jzvRdp1Oc/wwluIHHtxEgVqiKoaZgZt7DJfwI=;
  b=Nk5R+Hr0A2siAGdi0x1buvXx1C1dxmXuRJMLGxQUqSf4xyZ3iTLNo/lg
   fQhofL+eVGakk2EE1RzSz2TOey8FGmPyxmZYiI09m8R3OSWAry8ERnnI4
   XOseMMMq5/stpv7aOtHls9cbcZaEA9Cth56MqBEO761qqR41xsNtWunei
   9Ba3Mf6kmR+84O7vK/Kdy2lMlP44ksok39g7hN3abZGoOvUTkKKyfubPl
   o5RYwspJN/hovhQfy7civjwODJdj/TSf8n/srBz6k0klPBE3FS0ygXdnW
   tgKZXK9cPjXEylONXF8jQn9e80eG2Z5iu7vv7K+iDvdv+2rveO6LNU5BI
   A==;
X-CSE-ConnectionGUID: y+28BxEsQJuD6Cm4x7CRXg==
X-CSE-MsgGUID: T9iFjlcCTSeiZfymK4R8Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="67787545"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="67787545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:01:54 -0800
X-CSE-ConnectionGUID: lJYz6EQ0TJK06fvY5zZCjQ==
X-CSE-MsgGUID: YgnBBq1qRMqrsML9DcgrSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="123943522"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 07 Mar 2025 08:01:50 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqa8v-0000gr-3B;
	Fri, 07 Mar 2025 16:01:46 +0000
Date: Sat, 8 Mar 2025 00:01:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <202503072302.i9H71Jqv-lkp@intel.com>
References: <20250306075211.1855177-3-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075211.1855177-3-alistair@alistair23.me>

Hi Alistair,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/PCI-DOE-Rename-Discovery-Response-Data-Object-Contents-to-type/20250306-155550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250306075211.1855177-3-alistair%40alistair23.me
patch subject: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
config: um-randconfig-r063-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072302.i9H71Jqv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072302.i9H71Jqv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072302.i9H71Jqv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pci/msi/pcidev_msi.c:5:
   drivers/pci/msi/../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/msi/../pci.h:488:70: warning: 'return' with a value, in function returning void [-Wreturn-type]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/msi/../pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/pcie/aspm.c:27:
   drivers/pci/pcie/../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/pcie/../pci.h:488:70: warning: 'return' with a value, in function returning void [-Wreturn-type]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/pcie/../pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/hotplug/pci_hotplug_core.c:32:
   drivers/pci/hotplug/../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/hotplug/../pci.h:488:70: warning: 'return' with a value, in function returning void [-Wreturn-type]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/hotplug/../pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/controller/dwc/pcie-designware.c:24:
   drivers/pci/controller/dwc/../../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/controller/dwc/../../pci.h:488:70: warning: 'return' with a value, in function returning void [-Wreturn-type]
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/controller/dwc/../../pci.h:488:20: note: declared here
     488 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~


vim +/return +488 drivers/pci/msi/../pci.h

   483	
   484	#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
   485	void pci_doe_sysfs_init(struct pci_dev *pci_dev);
   486	void pci_doe_sysfs_teardown(struct pci_dev *pdev);
   487	#else
 > 488	static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
   489	static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
   490	#endif
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

