Return-Path: <linux-pci+bounces-8571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C1903258
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 08:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F5D285A0C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F52516F917;
	Tue, 11 Jun 2024 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzkDOTUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB609A2A
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086797; cv=none; b=ggHkQ+aYTJV7Ocd3vMogEZ/qoH/zxe3Lsz48Z9dexQ0PunOr7ETlWv0IBiXeE0BtJwM9JsQQzpxWaLGbKtPoqrhtDD2MncM2U5In59PoYu/UadvfnNw1hTZuhRjPo5egruRzhDiONuHJPWhUv7mZHlVFV6TT0M7wZ6r1FoClrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086797; c=relaxed/simple;
	bh=TWjdN8edPSw4yglmzB2Sc0Vj1JJGDlnGYr8KMwHEehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpLecPgYYtkm0L3Tb1YxQ7T4L2rUkmZV8pA5qUFPpSBsnZoB/q/a4ZuTKekLfk0mc13WsMb9GpOv8YwFai9TsfiaHpEJ+X3He0KO2Y5ph0iHDTe8FAHxXkSoRWroSD+vKA6Ea9FCE7WdWrWi8XLPgQwavIxgtruBPMMAqt6N77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzkDOTUr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718086795; x=1749622795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TWjdN8edPSw4yglmzB2Sc0Vj1JJGDlnGYr8KMwHEehc=;
  b=NzkDOTUrB2w6ru5MpG31rlm+EoRaqFVdz6vb7mwLuTWoHeGpEeRAGwcj
   SEITyV+F+3xoH6KEQuYISFtGCdy49eEGbiGzcWKcDo5ctubO/yn9d1lPh
   UfqTI3mSCPQUUR3j76r8JYCWv2fWRdA1XznaYiS6WjXe4IRcGLwCdkhvu
   Seqq4BkCQMt4PgTOU13TIIwnE87mPDyOAdxLXfd7E/aHzpoW7cbJJV3et
   v37a64Lmht+X0BJ3/vc8Kz+Ih4PedAM8mZ9fQMqfTU/aHg+eMHI5R9ped
   r1ifW7ANHJHTR5LEtbRqKEFOpbIyMsLhI6pqZt6CEXzCyf1JmJoWyS7O0
   g==;
X-CSE-ConnectionGUID: nRIhWL3QTymoepoLsyO+Sg==
X-CSE-MsgGUID: C0RRlp+bRW+5u2ZP42o7jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12012050"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="12012050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:19:55 -0700
X-CSE-ConnectionGUID: SZdYA1jgRfOszR1Vg7fd+g==
X-CSE-MsgGUID: uXL8wdsuSxisycZ3WKnbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39769421"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2024 23:19:53 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGurH-000074-0b;
	Tue, 11 Jun 2024 06:19:51 +0000
Date: Tue, 11 Jun 2024 14:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] PCI: pciehp: fix concurrent sub-tree removal deadlock
Message-ID: <202406111416.XIxUrEy4-lkp@intel.com>
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
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240611/202406111416.XIxUrEy4-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111416.XIxUrEy4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111416.XIxUrEy4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/of.c:16:
   drivers/pci/pci.h: In function 'pci_dev_set_disconnected':
>> drivers/pci/pci.h:416:9: error: implicit declaration of function 'pci_notify_disconnected'; did you mean 'pci_doe_disconnected'? [-Werror=implicit-function-declaration]
     416 |         pci_notify_disconnected();
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         pci_doe_disconnected
   cc1: some warnings being treated as errors


vim +416 drivers/pci/pci.h

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

