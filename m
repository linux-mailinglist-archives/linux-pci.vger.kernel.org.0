Return-Path: <linux-pci+bounces-8572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40390325A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 08:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028E9285A23
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8B17164D;
	Tue, 11 Jun 2024 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIQRIZVm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1F171083
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086800; cv=none; b=EXKB4M6iUeBTx/pUExA8vKTqH+F7rVZKiTCdoaTdQqDKh28NrpdqRwdSAq9q1AYSOhvF3p0LxPdtkgU1fQWD2RTUvBw629744fu7qUHBxv5+hHpPx561tQErw6qPkTV9OtBkSzfXx+oSpHJfKmyb1EAiO73oJU2CTonLMzq9kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086800; c=relaxed/simple;
	bh=T0yjSh1L3Pl6VYqTlAxp8N83pGQKtxK1OjahAu0RNjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2scSOJcSuy26+jMlPwCUIycOLo1kRfXjsicsx6tQ9JRK7mnepUdyJJ2dkHoXei7AmT0ekjZeylgmLnMHCLFiddvbTd7e2+L9IiTokvu/gFBDrJwWD6xnol/OG4g0qK4FizR36GNgXU8pZM4Qe8sHL8MiaIgzwQgpnmxGjjo6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIQRIZVm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718086797; x=1749622797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T0yjSh1L3Pl6VYqTlAxp8N83pGQKtxK1OjahAu0RNjA=;
  b=kIQRIZVmUJWt8X/E7ujvZWXKDMpW0sYEiYs7kxbRcrsm/fVdMZpOGyxA
   zHnD+eGkPcQWxDeTbGht1PvxBlUdp5p1YSq7VQWNiljZBof/PYrqrOcbR
   nhIOc6UHgbizvZnYXSNNvkGPcrf7ZNH5orMTSq2IPy1GgZHjZIGsZsjJP
   mME3lQJjffz88mVbvieLNPyjZjDMZgcc2M4LvFAGW16zmi1LTUsBjv2qF
   G3KLID9a8y+r6i7QmdNd58g5rQEWkj63u+GAHJDeS3QngGdHDqbTUThPG
   xqlmeMBIIfKA8KeCcW4klizhQgYbJPQdsvyZAUqX2qAMK5XxsQgekgf66
   w==;
X-CSE-ConnectionGUID: fidhsS92RkqSpUEoa/oYlA==
X-CSE-MsgGUID: pcbPy8SiShuwJIXPja40OA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12012056"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="12012056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:19:55 -0700
X-CSE-ConnectionGUID: v2PAWd+KRzuIeAFyDi1G9w==
X-CSE-MsgGUID: q12bnFuST6mZ2NQT33xPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39769422"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2024 23:19:53 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGurH-000076-0l;
	Tue, 11 Jun 2024 06:19:51 +0000
Date: Tue, 11 Jun 2024 14:19:07 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
Message-ID: <202406111313.UuWo45kC-lkp@intel.com>
References: <20240610220304.3162895-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610220304.3162895-2-kbusch@meta.com>

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/PCI-pciehp-fix-concurrent-sub-tree-removal-deadlock/20240611-060555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240610220304.3162895-2-kbusch%40meta.com
patch subject: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240611/202406111313.UuWo45kC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111313.UuWo45kC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111313.UuWo45kC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:11:
   In file included from include/linux/pci.h:2672:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/pci/of.c:16:
>> drivers/pci/pci.h:416:2: error: call to undeclared function 'pci_notify_disconnected'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     416 |         pci_notify_disconnected();
         |         ^
   drivers/pci/pci.h:416:2: note: did you mean 'pci_doe_disconnected'?
   drivers/pci/pci.h:376:20: note: 'pci_doe_disconnected' declared here
     376 | static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
         |                    ^
   1 warning and 1 error generated.


vim +/pci_notify_disconnected +416 drivers/pci/pci.h

   411	
   412	static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
   413	{
   414		pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
   415		pci_doe_disconnected(dev);
 > 416		pci_notify_disconnected();
   417	
   418		return 0;
   419	}
   420	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

