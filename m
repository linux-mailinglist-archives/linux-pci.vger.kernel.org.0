Return-Path: <linux-pci+bounces-11582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B00894DFC4
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 04:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7091C20D7A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2024 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94199DDA1;
	Sun, 11 Aug 2024 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNHk7ZeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59DA629;
	Sun, 11 Aug 2024 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723344438; cv=none; b=agLS2UWMTDPQxLsf8VOedAL2p2QTi8QA2+eYKso7MPfCS74I/qZIZJ11vQoA0AKBsRAPcX0Ln5wOjnC7Wpr/Ktmn29PhuwH6viibxDO0K6j7iPEVg2ux9S+8phcUaboMmPD386/f2DPWBWuJI5U3EYtOvecY0VA37uED98kY/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723344438; c=relaxed/simple;
	bh=2E/PiludrIJ0UrQUTezJNfl+zlTw2eH3E1f8aYq02Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJjgP6e29ixIontPv6Kja9VyKibWSQ+mX3bA2GVU2MaS5opnyQLs/YPU8ZOnr4H6gKVNJzZ0oN+pID4LTSlWSfcYumDrmqgRn4yp+ZPFS4Ac+JQDT9Kg7lFXUzFKeXYfcMaa97uNE/86ixscfQDrULcQ/t8m0epq7JzhN8YVMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNHk7ZeR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723344437; x=1754880437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2E/PiludrIJ0UrQUTezJNfl+zlTw2eH3E1f8aYq02Mo=;
  b=jNHk7ZeRmQmIGMRVatKSM4f1SnalUbvHQ97jF6WSI3DnjW44HIZDpIq2
   RKNe9lmqXotvYMwvngTGdNDmgQP6ZT/37FfCnck6fclOuBvdex4dZZ87r
   hzCHl8mp1GLD3ikned4mvKCitVVW5P837rvhX9Vn2cQ85EWgv87Fdr1kx
   cyYhTbZLTFVpHlgza7FYDz5IBRV/3JPemJcYuh44HDG6eqY+sOqzHVQcy
   jHedGp+uiDBOsh5xZ712VtV9mK4NIa6g2b9lBnsAaQe20qz2jJmD6OVvf
   xCBzmOOWROaaxIs2m6wvWwC2MlxmFR6NVZBUafLCzdU/OXJMZ0j3YWgwO
   w==;
X-CSE-ConnectionGUID: 3OX8NRndSqiDSpPMo1NWCQ==
X-CSE-MsgGUID: sFjycRF7Tj+75EkCyf8Frg==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21643362"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="21643362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 19:47:16 -0700
X-CSE-ConnectionGUID: fH2jAi7mTqGtzQAh14LKUA==
X-CSE-MsgGUID: WMPuEdyNS8GFwvmP1R1Yvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="58155448"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 10 Aug 2024 19:47:13 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scybu-000AWN-0g;
	Sun, 11 Aug 2024 02:47:10 +0000
Date: Sun, 11 Aug 2024 10:47:08 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <202408111053.0PLHSTeH-lkp@intel.com>
References: <20240731-pci-qcom-hotplug-v3-5-a1426afdee3b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-pci-qcom-hotplug-v3-5-a1426afdee3b@linaro.org>

Hi Manivannan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-ep-Drop-the-redundant-masking-of-global-IRQ-events/20240802-024847
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240731-pci-qcom-hotplug-v3-5-a1426afdee3b%40linaro.org
patch subject: [PATCH v3 05/13] PCI: endpoint: Assign PCI domain number for endpoint controllers
config: microblaze-randconfig-r072-20240810 (https://download.01.org/0day-ci/archive/20240811/202408111053.0PLHSTeH-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408111053.0PLHSTeH-lkp@intel.com/

New smatch warnings:
drivers/pci/endpoint/pci-epc-core.c:843 pci_epc_destroy() warn: inconsistent indenting

Old smatch warnings:
drivers/pci/endpoint/pci-epc-core.c:908 __pci_epc_create() warn: inconsistent indenting

vim +843 drivers/pci/endpoint/pci-epc-core.c

   830	
   831	/**
   832	 * pci_epc_destroy() - destroy the EPC device
   833	 * @epc: the EPC device that has to be destroyed
   834	 *
   835	 * Invoke to destroy the PCI EPC device
   836	 */
   837	void pci_epc_destroy(struct pci_epc *epc)
   838	{
   839		pci_ep_cfs_remove_epc_group(epc->group);
   840		device_unregister(&epc->dev);
   841	
   842		#ifdef CONFIG_PCI_DOMAINS_GENERIC
 > 843			pci_bus_release_domain_nr(NULL, &epc->dev);
   844		#endif
   845	}
   846	EXPORT_SYMBOL_GPL(pci_epc_destroy);
   847	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

