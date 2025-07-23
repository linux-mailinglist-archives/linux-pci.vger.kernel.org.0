Return-Path: <linux-pci+bounces-32842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B6B0FAF0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D37B9635D3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1582C60;
	Wed, 23 Jul 2025 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqgJKdzN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACF1DDC2B;
	Wed, 23 Jul 2025 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299065; cv=none; b=eCBtmUXxyDWQ4QDhr81CRMxCJ/Yw8pBFXMWsjVvAF5k3YYs8xf2j8kYdZgAudeacK3vsqqRyYPqbr1hYFHWqxLGNvC49X7lJBVRRj+vFe9VB9eTpkIVxVZbd8WwNQyeFvo/7PfUX69/Hzn3la13OL1Ry+TjG97JaBvRae8oOQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299065; c=relaxed/simple;
	bh=LkOz38MhnKC7F/1ZpVoBGtSBfVOA/gBncZyaq92bCQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj/ommfvME1bWmKxs1e+4ld6lcoih3kHqj3D7IUoE/eQCmPj0jBk6RiavJSse4lGP4KD7P05qmAvervhlps3GXkWOKr7x7Edvk74P1ZQtWConJhzD0H5HfRdtSkuWlDzq+j4PG69Gm9WugjqpI1u7lykVCE4OqHzAIueWuTsv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqgJKdzN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753299064; x=1784835064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkOz38MhnKC7F/1ZpVoBGtSBfVOA/gBncZyaq92bCQM=;
  b=AqgJKdzNcmU3CZpKM520Mku25NHatlFA1HHJIpiR3KMEUT+kErrX1YEB
   Dy0QDazptm/nNMJG/Gxw9HnI1TVUQFNa10RlJvLe6NZqLvxHKO6wf4oND
   Nd/W9EoYc6aNVw7k9xtnG5wTFOspTZTnWn/wQlCplNDlNh6rss3WpqJ31
   aXwlzHBYbZ09fhkVGnHYF478l7+e+YVZxxB8FcuurnBdIdckvNRV7tq7I
   jSw181EJpXUmxv8X998f1JMI7VbLFLWmhyWZvUHqEfMyDkrtmEyahwm8G
   cORE6AC8a7n98qwqK+WXvB3M7Yiyo+CuKpGCjpfJnhV10HimIw1Ow3Ozn
   g==;
X-CSE-ConnectionGUID: NHYPcn0sRI6cn+zbvPYB9A==
X-CSE-MsgGUID: Bjpg4PaMSjaXO2eURcKVkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55692358"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55692358"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 12:31:03 -0700
X-CSE-ConnectionGUID: FifCLr7RSom6B/Svb2aXQg==
X-CSE-MsgGUID: YStQdyFBSp66BT9qy2zqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="196813932"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jul 2025 12:30:58 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uefB1-000Jix-1A;
	Wed, 23 Jul 2025 19:30:55 +0000
Date: Thu, 24 Jul 2025 03:30:17 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, rostedt@goodmis.org,
	lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
	Jonathan.Cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, bhelgaas@google.com, tony.luck@intel.com,
	bp@alien8.de, xueshuai@linux.alibaba.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <202507240322.nJGdyXsy-lkp@intel.com>
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723033108.61587-3-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on trace/for-next linus/master v6.16-rc7 next-20250723]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-trace-Add-a-generic-RAS-tracepoint-for-hotplug-event/20250723-113454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20250723033108.61587-3-xueshuai%40linux.alibaba.com
patch subject: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link speed changes
config: sparc-sparc64_defconfig (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240322.nJGdyXsy-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/pci/probe.o: in function `pcie_update_link_speed':
>> probe.c:(.text+0x370): undefined reference to `__tracepoint_pcie_link_event'
>> sparc64-linux-ld: probe.c:(.text+0x37c): undefined reference to `__tracepoint_pcie_link_event'
>> sparc64-linux-ld: probe.c:(.text+0x3dc): undefined reference to `__traceiter_pcie_link_event'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

