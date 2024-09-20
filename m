Return-Path: <linux-pci+bounces-13315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9E97D0FD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 07:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D401F22211
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DE2746C;
	Fri, 20 Sep 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACgzrnJo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A888EBE;
	Fri, 20 Sep 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811485; cv=none; b=bs6aDGHYfjz7UUz6QO4F6MP8V5Le7Vowdh6f32xrgUFYrm2dEYyJkz397upzL1dC6og55gY/hadRHG68wfRZ/cXLGAFe1ul5ThPm88dkUdMBOrCt6vLbKn2o+Yy/rq5HaXot5d8e4Zq+WekNbp4kXk3QrT7Tqzumyw8oWluRC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811485; c=relaxed/simple;
	bh=uUOcIExMFxtXedoB/vYFOxBLShlasbQQzV+QHdNjWNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrpVdd3UGBz7zhKq9ZZMj5xZFgw9c3kS8CVAvzSIBszaBaahD1adJfCGrEOAQTLO0V2EwgVE/Yd4PET/Dqa4aCUNrZ/9jQEj4Tk1i4/ALJt1/KfH9taP9z7Mt5rS9ibfKbzKR5ZAXRgFMgKUZ1Mn3goDFD3jVm2uOWTY1jGqGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACgzrnJo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726811484; x=1758347484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uUOcIExMFxtXedoB/vYFOxBLShlasbQQzV+QHdNjWNg=;
  b=ACgzrnJoUvLEBvQ0NzTqn91O11Ee9RyKjedgZc+c5YG1GmmVwep2b91t
   yJB18jbyLIG3sQ0uhn7xdoZVorMKiGNfGUMTFbx9q9hKvTrd7HXFAfkjG
   cckOHgFeS3qakQm3zSHWEHxF3a/XNifFmHzorTO+i5UkHdDx1E1+iCjHW
   X/FAbRnYJX6oC8S9qpefkrcuJPzSeXjEGt0BRYraNbV6I5FR8bhXLZ3N+
   U/1Qxde/cFV3G2TVXSMgTiBRAoiAE6dUksclrqNPlBIaAueFeXM6nGn+i
   FRIHV4/SQbI7XjA8c1JrHch1YyaTlSFHFS6ofprQu/jU9Zx6G+6F8kuDB
   g==;
X-CSE-ConnectionGUID: 373roMu/S62ldm3LehWuFw==
X-CSE-MsgGUID: zhswyC7xTEKBTwBb2VJMOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29702006"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="29702006"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 22:51:23 -0700
X-CSE-ConnectionGUID: vnU+PBf+RW+Ev7skvffaLA==
X-CSE-MsgGUID: MltdL1EgRuiN9yC8sj+NAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70485990"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Sep 2024 22:51:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srWY1-000E0Q-1G;
	Fri, 20 Sep 2024 05:51:17 +0000
Date: Fri, 20 Sep 2024 13:51:16 +0800
From: kernel test robot <lkp@intel.com>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org, logang@deltatee.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com, sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [PATCH 2/2 v2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P
 links
Message-ID: <202409201333.LCx5k41f-lkp@intel.com>
References: <1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>

Hi Shivasharan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20240919]
[cannot apply to pci/for-linus linus/master v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivasharan-S/PCI-portdrv-Enable-reporting-inter-switch-P2P-links/20240919-162626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1726733624-2142-3-git-send-email-shivasharan.srikanteshwara%40broadcom.com
patch subject: [PATCH 2/2 v2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P links
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240920/202409201333.LCx5k41f-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201333.LCx5k41f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201333.LCx5k41f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/pcie/portdrv.c:86: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Determine if device supports Inter switch P2P links.
>> drivers/pci/pcie/portdrv.c:116: warning: Function parameter or struct member 'a' not described in 'pcie_port_is_p2p_link_available'
>> drivers/pci/pcie/portdrv.c:116: warning: Function parameter or struct member 'b' not described in 'pcie_port_is_p2p_link_available'


vim +116 drivers/pci/pcie/portdrv.c

   106	
   107	/**
   108	 * pcie_port_is_p2p_link_available: Determine if a P2P link is available
   109	 * between the two upstream bridges. The serial number of the two devices
   110	 * will be compared and if they are same then it is considered that the P2P
   111	 * link is available.
   112	 *
   113	 * Return value: true if inter switch P2P is available, return false otherwise.
   114	 */
   115	bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b)
 > 116	{
   117		u64 dsn_a, dsn_b;
   118	
   119		/*
   120		 * Check if the devices support Inter switch P2P.
   121		 */
   122		if (!pcie_port_is_p2p_supported(a) ||
   123		    !pcie_port_is_p2p_supported(b))
   124			return false;
   125	
   126		dsn_a = pci_get_dsn(a);
   127		if (!dsn_a)
   128			return false;
   129	
   130		dsn_b = pci_get_dsn(b);
   131		if (!dsn_b)
   132			return false;
   133	
   134		if (dsn_a == dsn_b)
   135			return true;
   136	
   137		return false;
   138	}
   139	EXPORT_SYMBOL_GPL(pcie_port_is_p2p_link_available);
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

