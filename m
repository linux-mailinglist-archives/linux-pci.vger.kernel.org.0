Return-Path: <linux-pci+bounces-7638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A88C8F4F
	for <lists+linux-pci@lfdr.de>; Sat, 18 May 2024 04:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6601F21C2C
	for <lists+linux-pci@lfdr.de>; Sat, 18 May 2024 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FA3D64;
	Sat, 18 May 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnMTP/g7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42D6FB1;
	Sat, 18 May 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715998054; cv=none; b=tCFASL+AqOHTZxzsdj5yXdij3m3Y3kFzbj+oAI1/lQavXtqcXTzjgiY9h5r7JETmKEcKolfbmaVcUBGLIMR04J+ywSdp+Mn+vB0GVmyrR23k2frnm5YZguOXvpFtZqd9KnksGBRsa+ES4uRLSMddVJln7BYOzTwz6uQyFw3BH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715998054; c=relaxed/simple;
	bh=Oh7sF9OjA0BSp6JAbwwufKhQSAjtCl7i1HcOwVLPdjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re4jeVd1z44C+tE/FWGxyEr9wSiLDsDIoqRWEFnyK0laZzNLUdZHeNkQN7QLcn6bNAf4nZvCHji1C67jfYLsWvLUNKd7Md9emtYdJxNnf9D6fEDQ0D2aQYD5cI3Tx3KkU2qcc7PYC2DrcXBtbIBXZ7h/1OqcqKEerBlLy5+OyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnMTP/g7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715998053; x=1747534053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oh7sF9OjA0BSp6JAbwwufKhQSAjtCl7i1HcOwVLPdjs=;
  b=lnMTP/g77rbkGHZWVIAvZ6yrsGkkf69uNjAEHFI8BxMVIeIKU2dmjIKo
   pkI9Jo7eC3dNpGzg91UcOkznESn2K7xUAMIxQKU/ptaC8FlOZdRDQ8z5/
   6CbvcY723ZcvQcd30z9dAJGoivTajS0YLDYsLZeCuDPb+eAUSMTvdIL7M
   NW7A3pj5PDP5GOIq+wYxF/tx6ohw6g11oz0CGBMzawov2V2Eq2Me8ylki
   nBWajxJu4YhD5UKztABvHhWMBG2/N2TK1oUFTNQe6BD6NQa5R1/0IGaLO
   Drsd2pJ2DBuI7Zz16wid3WO0wcIwxnMBp/HH2XyRjCzs+G5fD1G5MY21k
   A==;
X-CSE-ConnectionGUID: Yk2PxUllSsquWEWnhoqEOg==
X-CSE-MsgGUID: +ExhwQoiQ3a5bFJgHshy3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12049162"
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="12049162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 19:07:32 -0700
X-CSE-ConnectionGUID: OB8/0o0zRWyy9XvXY8ofvA==
X-CSE-MsgGUID: nqKV49kyRam4/ngQRirs2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,169,1712646000"; 
   d="scan'208";a="32129202"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 19:07:31 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s89Ts-0001Wu-0d;
	Sat, 18 May 2024 02:07:28 +0000
Date: Sat, 18 May 2024 10:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: Lianjie Shi <Lianjie.Shi@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Lianjie Shi <Lianjie.Shi@amd.com>
Subject: Re: [PATCH 1/1] PCI: Support VF resizable BAR
Message-ID: <202405180954.pffoQtM9-lkp@intel.com>
References: <20240516093334.2266599-2-Lianjie.Shi@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516093334.2266599-2-Lianjie.Shi@amd.com>

Hi Lianjie,

kernel test robot noticed the following build errors:

[auto build test ERROR on cf87f46fd34d6c19283d9625a7822f20d90b64a4]

url:    https://github.com/intel-lab-lkp/linux/commits/Lianjie-Shi/PCI-Support-VF-resizable-BAR/20240516-173624
base:   cf87f46fd34d6c19283d9625a7822f20d90b64a4
patch link:    https://lore.kernel.org/r/20240516093334.2266599-2-Lianjie.Shi%40amd.com
patch subject: [PATCH 1/1] PCI: Support VF resizable BAR
config: i386-randconfig-014-20240518 (https://download.01.org/0day-ci/archive/20240518/202405180954.pffoQtM9-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405180954.pffoQtM9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405180954.pffoQtM9-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/pci.o: in function `pci_restore_vf_rebar_state':
>> drivers/pci/pci.c:1895:(.text+0x3bff): undefined reference to `__udivdi3'


vim +1895 drivers/pci/pci.c

  1869	
  1870	static void pci_restore_vf_rebar_state(struct pci_dev *pdev)
  1871	{
  1872	#ifdef CONFIG_PCI_IOV
  1873		unsigned int pos, nbars, i;
  1874		u32 ctrl;
  1875		u16 total;
  1876	
  1877		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
  1878		if (!pos)
  1879			return;
  1880	
  1881		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  1882		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
  1883	
  1884		for (i = 0; i < nbars; i++, pos += 8) {
  1885			struct resource *res;
  1886			int bar_idx, size;
  1887	
  1888			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  1889			bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
  1890			total = pdev->sriov->total_VFs;
  1891			if (!total)
  1892				return;
  1893	
  1894			res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
> 1895			size = pci_rebar_bytes_to_size(resource_size(res) / total);
  1896			ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
  1897			ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
  1898			pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
  1899		}
  1900	#endif
  1901	}
  1902	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

