Return-Path: <linux-pci+bounces-37597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9EABB8AF5
	for <lists+linux-pci@lfdr.de>; Sat, 04 Oct 2025 09:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7664A22D7
	for <lists+linux-pci@lfdr.de>; Sat,  4 Oct 2025 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B61236A70;
	Sat,  4 Oct 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gr1lJ247"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A6226CFD;
	Sat,  4 Oct 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759562933; cv=none; b=MK6k81PuCKFeJyB2+PX5hBGH2ox3Fh98FPLBkf75AShRf/wc2GGj8iHBDH+zCq7bB2mSDlhIH8HS4RzzPU0DQ1Cs1wiz6Iv7L6Zj+OiHf1iacIFn8PV2geBGg+2gQMuWM6ZXSQiggZq1W7tS2Ovw9Btq+GGsZ6VtWTIdx6WoFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759562933; c=relaxed/simple;
	bh=Loo773o+nNlKAHZV9BqWO5rGZNFf3qmRPjEFQXtovHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDMim4ZOqK2iQ2TSDq55LxhExKlnqI68sMi5+1tZI9LwjqaVkKYAVQUd9VHFprOxFQgsxQxuQg6CEnAHDl/UpghBgFqLghnwybvGgWWHoQDmdU5iQUfL2MNOQjk7F4HhDtggYribK96ywQ/ssSsIHCtp3cBoiZ/Hppgwz4OzSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gr1lJ247; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759562933; x=1791098933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Loo773o+nNlKAHZV9BqWO5rGZNFf3qmRPjEFQXtovHY=;
  b=Gr1lJ247xDfOChx/ANgpe4k9X0YkdzOyPe+NRDAxZHoVr5r6Ml5nbLBO
   slyp9wnrxOboZtSNrsFFc8Z5fDcFsioTtVsIbxEZQrb0Lym1JeCf8qDbg
   Cz1I3TKc08cr2MdlLuhFKvwmmcivaXF2qmwaESIdxlG5oUpOMdr81q3wg
   zdfFN11Q4hkZ2lSEU9eL0Vl0zPFIivvhbWUz2wv6vfzIe5bMqkATvF2Rk
   ERgLpktsij8HlpQ+InSmcMw9XwB5XMemDx5dV9sPhvMFNWQ5I6gmpILLS
   l7V9N+im+INxp4KV696tWT3UeD3FdrQgwdOuIMe5TIPjSn1gG9LmxpQbP
   Q==;
X-CSE-ConnectionGUID: BT9wrQ9sTw6LXu8a+DWGrg==
X-CSE-MsgGUID: RHrvNVR4Snmv4Pkv0X7NBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61538895"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="61538895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2025 00:28:52 -0700
X-CSE-ConnectionGUID: GlTyvsNSRlyCVeq+HKfhBw==
X-CSE-MsgGUID: TF6WPJYORZS2on2lZz658g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="210438407"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Oct 2025 00:28:48 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4whB-00058l-2y;
	Sat, 04 Oct 2025 07:28:45 +0000
Date: Sat, 4 Oct 2025 15:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <202510041550.xoRbz92p-lkp@intel.com>
References: <20251003160421.951448-4-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160421.951448-4-rrendec@redhat.com>

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on pci/next pci/for-linus mani-mhi/mhi-next linus/master v6.17 next-20251003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Rendec/genirq-Add-interrupt-redirection-infrastructure/20251004-000948
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251003160421.951448-4-rrendec%40redhat.com
patch subject: [PATCH 3/3] PCI: dwc: Enable MSI affinity support
config: x86_64-randconfig-002-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041550.xoRbz92p-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251004/202510041550.xoRbz92p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510041550.xoRbz92p-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `dw_pcie_init_dev_msi_info':
>> drivers/pci/controller/dwc/pcie-designware-host.c:36:(.text+0x21dd630): undefined reference to `irq_chip_pre_redirect_parent'


vim +36 drivers/pci/controller/dwc/pcie-designware-host.c

    28	
    29	static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
    30					      struct irq_domain *real_parent, struct msi_domain_info *info)
    31	{
    32		if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
    33			return false;
    34	
    35		info->chip->irq_ack = dw_pcie_msi_ack;
  > 36		info->chip->irq_pre_redirect = irq_chip_pre_redirect_parent;
    37		return true;
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

