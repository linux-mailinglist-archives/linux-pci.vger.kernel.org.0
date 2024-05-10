Return-Path: <linux-pci+bounces-7315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEF8C1CC9
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 05:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4061F20F6E
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38090148851;
	Fri, 10 May 2024 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb18Ne6C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1D14884F;
	Fri, 10 May 2024 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310468; cv=none; b=RgvotprgbBl75TldnQ6LllIXUFtgbFfvz0PgCbDLyhBaqtV7ds+aGnWpEFEAsvQx9zrRTf0vz9PM3SNxELT0SyTZ+l7Eokmg0SUz0WhZOhSP9CbHFmEu3AhcDNecAfkVG/O0q7NqZg24NqK5Qme6VtmcNQh3QBdpey2OGIwrUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310468; c=relaxed/simple;
	bh=s4Lld+sZVfkD+rXdYBt1CAyO3c7rZMktnDBfsx6v9O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFxFc3dcC7k7TrtBglsiACmmx7uDGMbqEtn3Y8pZDVLiuFRn+pJ5LJo7cz+bF1J5NhzDSmlslgoAmDRc34OMzyYbzbePcX0GBCuEo6Dnx+RIab5JFarXET+4U+nIDcKIkHuDkSNlz75/VUA3/KDN3ftrhgk43lcGs9mjQFOYTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb18Ne6C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715310467; x=1746846467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4Lld+sZVfkD+rXdYBt1CAyO3c7rZMktnDBfsx6v9O0=;
  b=Wb18Ne6CeuzvmAvf2B2gjlglJazMvmyAbsC0Du0psrrDgiuwBGqIyqVg
   gIXW/jGxeE6IzrsVCKAiKLWcfYkKEVoSH4aNRATiv2Ry5pJiblE9bX3Hf
   zQpmnLQeBa0PabolHg7JHibWGvKYen9b5DJPdXIVcs9WDvRvA+G9XkCa+
   tJwNEXFc4Nb6nJDZs1KbOVZQff4aFUHSLXyj3LuH/JMdOE2VYqNEagNRQ
   KI7rSoBYuPnDVKlw5g89KnR+OjCosjzSZ60OmhNmzanX0MRkBlHwKc7h2
   flA7YPCIxMyJI1ePJcDrdHEluRNmaPCrgw4hTOrkG5lx0+wnAB/0276V1
   A==;
X-CSE-ConnectionGUID: C5GY+4O3QqumurP+k3aeNg==
X-CSE-MsgGUID: l/1HsOCvSHK45u/lfK8QRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21847658"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="21847658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:07:46 -0700
X-CSE-ConnectionGUID: xw73KJxWT0C6owjg4j2dxQ==
X-CSE-MsgGUID: c4AvYiPiRY21c7uL6knCng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="60634912"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 May 2024 20:07:43 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5Gbj-0005et-2H;
	Fri, 10 May 2024 03:07:39 +0000
Date: Fri, 10 May 2024 11:07:28 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com
Subject: Re: [PATCH V1 5/9] PCI/TPH: Introduce API functions to get/set
 steering tags
Message-ID: <202405101033.2xLAqHIx-lkp@intel.com>
References: <20240509162741.1937586-6-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509162741.1937586-6-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on awilliam-vfio/next linus/master awilliam-vfio/for-linus v6.9-rc7 next-20240509]
[cannot apply to pci/next horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Introduce-PCIe-TPH-support-framework/20240510-003504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20240509162741.1937586-6-wei.huang2%40amd.com
patch subject: [PATCH V1 5/9] PCI/TPH: Introduce API functions to get/set steering tags
config: parisc-randconfig-r081-20240510 (https://download.01.org/0day-ci/archive/20240510/202405101033.2xLAqHIx-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405101033.2xLAqHIx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405101033.2xLAqHIx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pcie/tph.c: In function 'tph_msix_table_entry':
>> drivers/pci/pcie/tph.c:95:22: error: 'struct pci_dev' has no member named 'msix_base'; did you mean 'msix_cap'?
      95 |         entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
         |                      ^~~~~~~~~
         |                      msix_cap


vim +95 drivers/pci/pcie/tph.c

    80	
    81	/*
    82	 * For a given device, return a pointer to the MSI table entry at msi_index.
    83	 */
    84	static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
    85						  __le16 msi_index)
    86	{
    87		void *entry;
    88		u16 tbl_sz;
    89		int ret;
    90	
    91		ret = tph_get_table_size(dev, &tbl_sz);
    92		if (ret || msi_index > tbl_sz)
    93			return NULL;
    94	
  > 95		entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;
    96	
    97		return entry;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

