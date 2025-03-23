Return-Path: <linux-pci+bounces-24472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C84A6D0C0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B1416C01C
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BC19C54A;
	Sun, 23 Mar 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFGf4qJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077CF510;
	Sun, 23 Mar 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758007; cv=none; b=eVTC/zTpXPMfVNifb+QU855kfN9WFZhufmOcz0HGYDVK9TNreGGR7sBqbZkib1gH7US+edaWWGD9Xaykrub7XpOlOaRK9hwX29ICY3WumBHYFQeXTS35Z4rNnPSBECBHkzbRM0J4vZsRG0Adr0BsnXA1kq5+IkeowfW+fUhh9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758007; c=relaxed/simple;
	bh=YezEgk1iCgYxkv79mD9bPU21i+VeN7khhGctWDqAaH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXBPJYN+AiJaMKgwIlg3fsaGz7c5o2dJlGNEsADgv7noBd6wmeLLF7Ho3xfEZiIaqEMy4rFb2QBcDDswrggdBUiis2SZSP2nZtmdlB/lnddnlnpkm1mDVVlW1bWv7Qu3r9hHViHU2EO2i8Qg4rPuBxqQRmhQ89bXc4zNNNmTTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFGf4qJ/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742758006; x=1774294006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YezEgk1iCgYxkv79mD9bPU21i+VeN7khhGctWDqAaH8=;
  b=WFGf4qJ/oPeJQ0psB+U8L2boW7axsbLgLunLHXUF38DuQ5xA8rCAihTP
   MpFZA5iIWtGFDWBh+wlVIH8EfqvX1n6gb2mBm5LsI8m7pgjcWGLeIBQgH
   ahu5TKoq/vBvkvWMGWJz/yGytmy83ABjBxjkGp1f/BfArxVUbonyhBsxN
   kUiAOys5XiXC+r5pEX9kucAtSXCrlJjNIg1qYtUtdBmxlRMUVFpHsOPdB
   gUOVnINvniKj+wETLehzg75vAaY6M9+F+5eVjr0T0NKT5XoROk7AC6Dn8
   UFObcZYbYMFOui5zXuMzyPI05CdE8u2aV0vNU5QRycWX0vT9N/6g8yf1v
   g==;
X-CSE-ConnectionGUID: vwByPp4qQEGS5bHoVkH00w==
X-CSE-MsgGUID: jYBhkp2oSHmueHrZFsOnIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="43685422"
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="43685422"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 12:26:45 -0700
X-CSE-ConnectionGUID: mAZak0DkR/yNjmwT4L+UcQ==
X-CSE-MsgGUID: gw8cFEQ5QZyVQfCML4f3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="124378757"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Mar 2025 12:26:41 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twQxz-0002vK-1A;
	Sun, 23 Mar 2025 19:26:39 +0000
Date: Mon, 24 Mar 2025 03:26:19 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <18255117159@163.com>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <202503240338.N37HXlm9-lkp@intel.com>
References: <20250323164852.430546-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323164852.430546-4-18255117159@163.com>

Hi Hans,

kernel test robot noticed the following build errors:

[auto build test ERROR on a1cffe8cc8aef85f1b07c4464f0998b9785b795a]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-Zhang/PCI-Introduce-generic-capability-search-functions/20250324-005300
base:   a1cffe8cc8aef85f1b07c4464f0998b9785b795a
patch link:    https://lore.kernel.org/r/20250323164852.430546-4-18255117159%40163.com
patch subject: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for finding the capabilities
config: riscv-randconfig-001-20250324 (https://download.01.org/0day-ci/archive/20250324/202503240338.N37HXlm9-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240338.N37HXlm9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503240338.N37HXlm9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/cadence/pcie-cadence.c:20:11: warning: variable 'val' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      20 |         else if (size == 1)
         |                  ^~~~~~~~~
   drivers/pci/controller/cadence/pcie-cadence.c:23:9: note: uninitialized use occurs here
      23 |         return val;
         |                ^~~
   drivers/pci/controller/cadence/pcie-cadence.c:20:7: note: remove the 'if' if its condition is always true
      20 |         else if (size == 1)
         |              ^~~~~~~~~~~~~~
      21 |                 val = readb(pcie->reg_base + where);
   drivers/pci/controller/cadence/pcie-cadence.c:14:9: note: initialize the variable 'val' to silence this warning
      14 |         u32 val;
         |                ^
         |                 = 0
>> drivers/pci/controller/cadence/pcie-cadence.c:28:9: error: call to undeclared function 'pci_host_bridge_find_capability'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      28 |         return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
         |                ^
>> drivers/pci/controller/cadence/pcie-cadence.c:33:9: error: call to undeclared function 'pci_host_bridge_find_ext_capability'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
         |                ^
   drivers/pci/controller/cadence/pcie-cadence.c:33:9: note: did you mean 'cdns_pcie_find_ext_capability'?
   drivers/pci/controller/cadence/pcie-cadence.c:31:5: note: 'cdns_pcie_find_ext_capability' declared here
      31 | u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
         |     ^
      32 | {
      33 |         return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                cdns_pcie_find_ext_capability
   1 warning and 2 errors generated.


vim +/pci_host_bridge_find_capability +28 drivers/pci/controller/cadence/pcie-cadence.c

    25	
    26	u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
    27	{
  > 28		return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
    29	}
    30	
    31	u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
    32	{
  > 33		return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
    34	}
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

