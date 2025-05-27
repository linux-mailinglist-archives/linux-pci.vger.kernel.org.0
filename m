Return-Path: <linux-pci+bounces-28436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE72AC460E
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 03:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7053B47E6
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 01:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927382899;
	Tue, 27 May 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7uTqTDN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9E1EEE0;
	Tue, 27 May 2025 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748310916; cv=none; b=NXmdC2sT0rStyzXm7y546aDZtBOq2G3HFMK1lkgRgE+TxY+6P07sh2e6Mdwh2DRAGQYSwW1W8Z15cTMNqUZ3cmN7tYP6wrjA4j9goek7aDXNeiqdZUMGkTgQOYvLSlcOqnx43aTJv7BQ1EbDQ5vStgD/qpnZy4mePVBuUXHBKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748310916; c=relaxed/simple;
	bh=gsaXMnWjpEcWImJevfNNCwFvq8AerijKL5eN2i0nW9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWDcNCfwQpfy2+2Aa72y4ByXxYS0clU3qRTqW1rLQOn6+mhgLPOyVvz28v3/Hlg7jVfGLlp2/kAfldQpRCX/H07pEs2V8n8S2BPoNHen5Cv+Z6b9wG7C/wjmiqJDXuHl0SxvSuTSB1mNufs6ia4M3E4J/eI7dOtodML3vJAIwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7uTqTDN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748310915; x=1779846915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gsaXMnWjpEcWImJevfNNCwFvq8AerijKL5eN2i0nW9Y=;
  b=K7uTqTDNBgXLAKKuaZc92CXEAD3LqAv2SWBzdlLSqQsLQGe7rSOMj6b2
   dno1drE5ezSktyRzz+2aRoX9AZKlGZe9IO7oqLUMChhyyjEhg7OUFyBMC
   oNLJTkpYKJEsffkzjfkjx28sHF6JbnvxProGwHBGUwAcHCramY6Yc37Wd
   TUbX8Ml3pPHDpvQaF/2C7LkveDoSvmbkIi2ff8ciJGAkfKNZCujI7Alrb
   StFLomaiUUVn6Jc2ukmW/y2H3tWKFGFPfTatys1dDcgT1sSQ79yN794m9
   Cxy3D37BFE2pzUqJAmcmn0Mgv2xSuyxBmFdE9KmRaDpyolJI+E3rdBnGy
   Q==;
X-CSE-ConnectionGUID: +hWUb4Y3Tc6wPmbUeLZ8cw==
X-CSE-MsgGUID: eSfqaKUwRSOI1mSulndFXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="60913397"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="60913397"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 18:55:14 -0700
X-CSE-ConnectionGUID: QUUpjDcWReu8qjvUHgrAqQ==
X-CSE-MsgGUID: 0GRquuZeSz+pB5DK8uK7GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="173478145"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 May 2025 18:55:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJjX1-000So0-2m;
	Tue, 27 May 2025 01:55:07 +0000
Date: Tue, 27 May 2025 09:54:08 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH v8 3/6] PCI: Allow IOV resources to be resized in
 pci_resize_resource()
Message-ID: <202505270903.Mnc3qSMW-lkp@intel.com>
References: <20250526214257.3481760-4-michal.winiarski@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526214257.3481760-4-michal.winiarski@intel.com>

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus drm-xe/drm-xe-next drm-exynos/exynos-drm-next linus/master v6.15 next-20250526]
[cannot apply to drm/drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Winiarski/PCI-IOV-Restore-VF-resizable-BAR-state-after-reset/20250527-054652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250526214257.3481760-4-michal.winiarski%40intel.com
patch subject: [PATCH v8 3/6] PCI: Allow IOV resources to be resized in pci_resize_resource()
config: riscv-randconfig-001-20250527 (https://download.01.org/0day-ci/archive/20250527/202505270903.Mnc3qSMW-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505270903.Mnc3qSMW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505270903.Mnc3qSMW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci.c: In function 'pci_rebar_find_pos':
>> drivers/pci/pci.c:3756:14: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
      if (!pdev->physfn)
                 ^~~~~~
                 is_physfn
>> drivers/pci/pci.c:3758:13: error: 'struct pci_dev' has no member named 'sriov'
      pos = pdev->sriov->vf_rebar_cap;
                ^~


vim +3756 drivers/pci/pci.c

  3740	
  3741	/**
  3742	 * pci_rebar_find_pos - find position of resize ctrl reg for BAR
  3743	 * @pdev: PCI device
  3744	 * @bar: BAR to find
  3745	 *
  3746	 * Helper to find the position of the ctrl register for a BAR.
  3747	 * Returns -ENOTSUPP if resizable BARs are not supported at all.
  3748	 * Returns -ENOENT if no ctrl register for the BAR could be found.
  3749	 */
  3750	static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  3751	{
  3752		unsigned int pos, nbars, i;
  3753		u32 ctrl;
  3754	
  3755		if (pci_resource_is_iov(bar)) {
> 3756			if (!pdev->physfn)
  3757				return -ENOTSUPP;
> 3758			pos = pdev->sriov->vf_rebar_cap;
  3759			bar = pci_resource_num_to_vf_bar(bar);
  3760		} else {
  3761			pos = pdev->rebar_cap;
  3762		}
  3763	
  3764		if (!pos)
  3765			return -ENOTSUPP;
  3766	
  3767		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3768		nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
  3769	
  3770		for (i = 0; i < nbars; i++, pos += 8) {
  3771			int bar_idx;
  3772	
  3773			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3774			bar_idx = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, ctrl);
  3775			if (bar_idx == bar)
  3776				return pos;
  3777		}
  3778	
  3779		return -ENOENT;
  3780	}
  3781	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

