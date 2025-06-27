Return-Path: <linux-pci+bounces-30980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CEAEC296
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754A06E6915
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C028D8C2;
	Fri, 27 Jun 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djw67N73"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9228A3EC;
	Fri, 27 Jun 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062855; cv=none; b=Em/RsU3fzqMT9EC6w1D8GbpCr1ExL6ixoRNURxdTiFou+Ey7hkXoiIOFk9Ll+F9zJCV02R1tj9sjnEhLV+QSlnwssCupWezVmESIxsW1cjG/xxRsuoDJ6y1TC65Ckn48YuheuC9NzgSn65y0uELQrZmRmnLeEyq/8bj4K8lY17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062855; c=relaxed/simple;
	bh=9L0ixXMRbVqYGzBnfUXhugHIfiWqtm/lpXgHMiILOps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMkL6u1qTbOV8+PAhUWOJwTuKqXvakt/EVPpvV6ii8Rt9ekpdJEPluSaOL/CvvT3Fco+L0u3d8qQRHJ/tMcMym1GiSU7M4MhT1LbLcgF2wTCYQTCH9RL25UL6/rhZLVq6IBLAo0MdzlIa5+Q15p14lcdHAgse6YCc9NwK6vR8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djw67N73; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751062854; x=1782598854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9L0ixXMRbVqYGzBnfUXhugHIfiWqtm/lpXgHMiILOps=;
  b=djw67N73ktSDG/aAzbauhF/+Ec5uAv4OIscBeEJ1/hAA6DiPMyK+vF/p
   QLl7s8S3I+qWN57IUzsvEkxpE0PT2d8z+qa+kabulI04vyJzmhcFRzJh1
   hddxLBrxIilooWKYK5EzGolDULI4Q9WZsCzG8tfzU5T3v/f2VulbeJDQh
   aZJnXx+016TyDBEWaYhW0aXStQrE4m+4r1dfWolAiy483BuCFOqVG7T+e
   /zR3VEIaN+yqmrJtOFQ37igCpjEBGNMWf8tz8EgQqeIYg0Kw9Gxb2qVa7
   xjX5MuF43+o1Xo+Huw/6xZzgcN5Zv+HRVMz2A8GWlzIJhOeUomwRX2wyd
   Q==;
X-CSE-ConnectionGUID: Od122P7QTZOORZK4JP0Axw==
X-CSE-MsgGUID: Nk0JDsI8TZeEf+rk3XOXnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53509083"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53509083"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:20:54 -0700
X-CSE-ConnectionGUID: rpVEiyRYQB+NIypkshJRVw==
X-CSE-MsgGUID: 6rfxsHhQR1ysfl3rVu0jWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153095261"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jun 2025 15:20:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVHRA-000WaM-2O;
	Fri, 27 Jun 2025 22:20:48 +0000
Date: Sat, 28 Jun 2025 06:20:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org,
	bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v3] PCI: dwc: Refactor code by using
 dw_pcie_clear_and_set_dword()
Message-ID: <202506280542.6ttkdrur-lkp@intel.com>
References: <20250626145040.14180-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626145040.14180-3-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-dwc-Refactor-code-by-using-dw_pcie_clear_and_set_dword/20250627-031223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250626145040.14180-3-18255117159%40163.com
patch subject: [PATCH v3] PCI: dwc: Refactor code by using dw_pcie_clear_and_set_dword()
config: arc-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280542.6ttkdrur-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280542.6ttkdrur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280542.6ttkdrur-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-amd-mdb.c:21:
   drivers/pci/controller/dwc/pcie-designware.h: In function 'dw_pcie_dbi_ro_wr_en':
>> drivers/pci/controller/dwc/pcie-designware.h:712:2: error: implicit declaration of function 'dw_pcie_clear_and_set_dword'; did you mean 'pcie_capability_set_dword'? [-Werror=implicit-function-declaration]
     dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
     pcie_capability_set_dword
   cc1: some warnings being treated as errors


vim +712 drivers/pci/controller/dwc/pcie-designware.h

   709	
   710	static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
   711	{
 > 712		dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
   713					    0, PCIE_DBI_RO_WR_EN);
   714	}
   715	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

