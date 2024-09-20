Return-Path: <linux-pci+bounces-13324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A797D462
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B381F25B36
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C03513E8A5;
	Fri, 20 Sep 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii7GrFgV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C113E02B;
	Fri, 20 Sep 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828790; cv=none; b=bAO9comvqdXeUJW9elpKjcq+QFvf1paxd0dkOUEHIsjgeLopKXOTimQUy1dSIDdMm/28R51yzzpsepcYnW2kDNpDGq5pGv8zDjQ2nFIeSeTn61vm4KRVCOcy7EGTs/hUAwO93uqabRlP1aKDth7PpE2fnJulEMJgLi51xncVBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828790; c=relaxed/simple;
	bh=ruDIGL9cknZF6atUXoTmt4B8Il/oLTo2DEPkSko8H8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQpXTOSFxhVjY+w7d8sls3MUH6cbEF2ZUwv8LYsDPnr/UteJMhuRuIA0HEusxAmqyX+AylGOo3Ro1C33lRkDDzuq/rP5mPvkHfJ2CyK21Gdf8inntwkV6CvYqRTFRZFoe1LOaoWx5nCYxnZuDobDuT7WOy940a4TurhMeWTbaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii7GrFgV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726828789; x=1758364789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruDIGL9cknZF6atUXoTmt4B8Il/oLTo2DEPkSko8H8Y=;
  b=Ii7GrFgVMXakouXq46ynsiCfC7uSt4GQ2uO7jej3HjuRmWKmkIdlBCRf
   ewQ+n9YrNv9ppITSxPvT0JkZHO7B3moLddt1h+6w9lvzuSjfjvJu6YIdX
   dywr3PbwMTjh4HZHm0iYGQG40FlOqcqrbsZBRvcCkx9DdHWfnnCEULU/O
   N84IogRbgF+EcK7HhcpvbL7d8i6aUK7CahKgTg6jAe8eBD5smTBCiy0Ur
   dzmthf4uuUIjKbui7ALMoU35Q2Mx91RapcGR/c7fcCglmjk3L7Vm6ssNq
   Dh+0G+eNMhauE8OQXt1rHAtrBo+K4R8qji73RO1+5LznkRJcjJQ2iAcii
   g==;
X-CSE-ConnectionGUID: MwzuaojNSAmdxWEjUr9/Yw==
X-CSE-MsgGUID: 6aVQJHG3QciyuJ3eQNVosw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25702672"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25702672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 03:39:48 -0700
X-CSE-ConnectionGUID: b424nWu5StaW2CWHCBOHwA==
X-CSE-MsgGUID: LWE97G+kTmC2wr3pGvhRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75214258"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Sep 2024 03:39:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srb34-000EHv-2s;
	Fri, 20 Sep 2024 10:39:38 +0000
Date: Fri, 20 Sep 2024 18:38:55 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jonathan.Cameron@huawei.com,
	helgaas@kernel.org, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	wei.huang2@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
	bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
	paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
Message-ID: <202409201831.ToruGbMs-lkp@intel.com>
References: <20240916205103.3882081-5-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-5-wei.huang2@amd.com>

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20240920]
[cannot apply to pci/next pci/for-linus v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Huang/PCI-Add-TLP-Processing-Hints-TPH-support/20240917-045345
base:   linus/master
patch link:    https://lore.kernel.org/r/20240916205103.3882081-5-wei.huang2%40amd.com
patch subject: [PATCH V5 4/5] bnxt_en: Add TPH support in BNXT driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240920/202409201831.ToruGbMs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240920/202409201831.ToruGbMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409201831.ToruGbMs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function '__bnxt_irq_affinity_notify':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:10873:35: warning: variable 'rxr' set but not used [-Wunused-but-set-variable]
   10873 |         struct bnxt_rx_ring_info *rxr;
         |                                   ^~~


vim +/rxr +10873 drivers/net/ethernet/broadcom/bnxt/bnxt.c

 10869	
 10870	static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 10871					       const cpumask_t *mask)
 10872	{
 10873		struct bnxt_rx_ring_info *rxr;
 10874		struct bnxt_irq *irq;
 10875		u16 tag;
 10876		int err;
 10877	
 10878		irq = container_of(notify, struct bnxt_irq, affinity_notify);
 10879		cpumask_copy(irq->cpu_mask, mask);
 10880	
 10881		if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
 10882					cpumask_first(irq->cpu_mask), &tag))
 10883			return;
 10884	
 10885		if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
 10886			return;
 10887	
 10888		if (netif_running(irq->bp->dev)) {
 10889			rxr = &irq->bp->rx_ring[irq->ring_nr];
 10890			rtnl_lock();
 10891			err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
 10892			if (err)
 10893				netdev_err(irq->bp->dev,
 10894					   "rx queue restart failed: err=%d\n", err);
 10895			rtnl_unlock();
 10896		}
 10897	}
 10898	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

