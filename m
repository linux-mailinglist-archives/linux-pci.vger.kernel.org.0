Return-Path: <linux-pci+bounces-13318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EB97D2D1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554E6283A12
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124952F9E;
	Fri, 20 Sep 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCemhpwo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4B3BBD8;
	Fri, 20 Sep 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821459; cv=none; b=c9pqmAr5JrqwutHTWphHn8O0bPK36MERBs6z4auZ6JbrO3OAKXVzC9L05tcvG6nqaPSCvTEpMiZeOtGqPf2s2MlPCHze3JUFFaHymXDEvoIUsRemh41EPp3ToueW5Kw8W/eZiaWnROcu9h1ocECzw8vJ+jLkSoMJZOIDHsHNFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821459; c=relaxed/simple;
	bh=FjYT2BKjGT6OchrotM7LjHr6S6Ni/aoPuOPvVS5kbqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2SB7N0DuSpcsfAsYDiLF4Gwu1yBzTYtM6Ri2mHtRUlg92b8ck7rIveI4kHmJmMt2euVYrqjETRTUGKmfyx19vm2Irw+bHPulZKoJ5tk++p81lNwHWQtVXAa65GkOvxDfeMQoY5fsHvlbYKAo/moEPumgy/cAS2BL0jjLOA6UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCemhpwo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726821458; x=1758357458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FjYT2BKjGT6OchrotM7LjHr6S6Ni/aoPuOPvVS5kbqU=;
  b=eCemhpwoplWgliqNxRtvRZJWspE9EeLvYFhGczQz4dePwLsEY4NZz7jp
   gttH714tzax2oRISeAXKFEAiFSgC8pnfdwaKaBTEjdw9E9swwYK7unfXj
   8kcUoP+JNbszLgXh9eofPbREYu8UyIuTpIXw/ibEyDTVGLhX+Z2U9dhfG
   mFjm7Xg3Sjm+WxDUtMGkWycsQxcEEy8TLRtR7xQdDTorYGlMIQuybGbV/
   wkzEtAn+zQLf6Nz+nlttOQjvf2rxeUFRmNspBdeYV4FEnPUmvVqV0DfXS
   UtezTIS6X16SFua60w1FyB7OIKjXoJ3i6ozdEm/el/ffalg2NtWTEFUAf
   Q==;
X-CSE-ConnectionGUID: IJTYp2uzRnWZ3IpU/cbGOQ==
X-CSE-MsgGUID: HI/qhd7RTqmpczmH1ZahZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29605466"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="29605466"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 01:37:38 -0700
X-CSE-ConnectionGUID: Rm93kEgkS8SLlfUah43CXQ==
X-CSE-MsgGUID: zz7eSZuWRdKWQL8YubJJjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="93540570"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Sep 2024 01:37:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srZ8s-000E8n-30;
	Fri, 20 Sep 2024 08:37:30 +0000
Date: Fri, 20 Sep 2024 16:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 1/3] PCI: Add support for VF Resizable Bar extended cap
Message-ID: <202409201629.QlC0MRbn-lkp@intel.com>
References: <20240919223557.1897608-2-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919223557.1897608-2-michal.winiarski@intel.com>

Hi Michał,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on drm-xe/drm-xe-next drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11 next-20240919]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Winiarski/PCI-Add-support-for-VF-Resizable-Bar-extended-cap/20240920-064112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20240919223557.1897608-2-michal.winiarski%40intel.com
patch subject: [PATCH v2 1/3] PCI: Add support for VF Resizable Bar extended cap
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240920/202409201629.QlC0MRbn-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201629.QlC0MRbn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201629.QlC0MRbn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/pci.c:1920:20: warning: variable 'res' set but not used [-Wunused-but-set-variable]
    1920 |                 struct resource *res;
         |                                  ^
   1 warning generated.


vim +/res +1920 drivers/pci/pci.c

  1903	
  1904	static void pci_restore_vf_rebar_state(struct pci_dev *pdev)
  1905	{
  1906		unsigned int pos, nbars, i;
  1907		u32 ctrl;
  1908	
  1909		if (!pdev->is_physfn)
  1910			return;
  1911	
  1912		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
  1913		if (!pos)
  1914			return;
  1915	
  1916		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  1917		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
  1918	
  1919		for (i = 0; i < nbars; i++, pos += 8) {
> 1920			struct resource *res;
  1921			int bar_idx, size;
  1922	
  1923			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  1924			bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
  1925			res = pdev->resource + bar_idx;
  1926			size = pci_rebar_bytes_to_size(pdev->sriov->barsz[bar_idx]);
  1927			ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
  1928			ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
  1929			pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
  1930		}
  1931	}
  1932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

