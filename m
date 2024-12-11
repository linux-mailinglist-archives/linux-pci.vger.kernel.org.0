Return-Path: <linux-pci+bounces-18122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF699ECC17
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6598718887ED
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6302238E29;
	Wed, 11 Dec 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3/A7cS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7991C5CBA
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920355; cv=none; b=gyrsIRIQYSvIX440B35UVWELfTePtHa10Yn6WDo9XvHl92zx0qYF7BFta8xMcxTRNaUV3Lz1yF1Bz1vo8IZN3F2r5kwjIeX8//5ztXTsIygiRNAwYcv+K5VKoKwhhBzIlpLJWG3UAB1fxfLt2w+eogqsetZSkhREF8WC4Sl1S5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920355; c=relaxed/simple;
	bh=71wI1DFvaEWtKNoUNXYVXtT26U3V83DpBv8RT4vrESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF6Otjzq/m8r1BcLcMyYsiEAEHnrSYrpKSHP4e25SV2PnlI7XyujUUGNxNwqreZyquZg5EaLidhPhh291gXk7XGwoqqBHF6WCNSK1gSIJWCKG5P6UuMFHZzUeTH9DDAaw/+rgHMy45cXzOE8Du6smn/AF69/9hJ5cM3OqQLjg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3/A7cS4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733920354; x=1765456354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71wI1DFvaEWtKNoUNXYVXtT26U3V83DpBv8RT4vrESo=;
  b=T3/A7cS4rJTu7zNAd5NIQXEtPg3jbRPKW1MmphqEM2lA/EC1fgCSw4vm
   VFMZrSBKf2wIukVQVy60s/4iah6TIDTWCckwqVjFJUGpsr5dJGIKwGUfg
   SJOfBIsCEnEtDwKJjEBRjL0HRh7VyvXQaSvIQ7tZ/4ADsRd3RzlN6LyY+
   gcEr6mVHwc49uSNlVA+eAnNO3LEGxQemyJ1Jzz09WBTgqqH4tgdJF551K
   QH5Mm59jmIGhcJHUbaaEerFpCIWEWVjaVff8nbstSYJ2WjZnLq5wMQeZu
   XyprFrBEk4v2n3/Jd2q4Azj9MsBcHCy15DwceYRKzm0ByV4rG63G5N4sd
   g==;
X-CSE-ConnectionGUID: ogi/M2DpTVGTh36kj+zYLw==
X-CSE-MsgGUID: 66jRs9w+QQ2bL7kpYrQ3OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34197464"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34197464"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 04:32:33 -0800
X-CSE-ConnectionGUID: UDtcslNASIWMgW0uxxZpQg==
X-CSE-MsgGUID: xxzsp89jQZOVGtVWxIutiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95856342"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Dec 2024 04:32:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLLtD-0006dx-13;
	Wed, 11 Dec 2024 12:32:27 +0000
Date: Wed, 11 Dec 2024 20:32:16 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412112016.qpAKrNxI-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>

Hi Damien,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.13-rc2 next-20241211]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-Add-vendor_id-and-subsys_vendor_id-subsystem-attributes/20241210-174321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241210093408.105867-17-dlemoal%40kernel.org
patch subject: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241211/202412112016.qpAKrNxI-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112016.qpAKrNxI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112016.qpAKrNxI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/target/pci-ep.c:11:
   In file included from include/linux/dmaengine.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/target/pci-ep.c:658:9: error: call to undeclared function 'nvme_opcode_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^
>> drivers/nvme/target/pci-ep.c:658:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'const char *' [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 2 errors generated.


vim +/nvme_opcode_str +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

