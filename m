Return-Path: <linux-pci+bounces-7790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0D8CD705
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284E8283A94
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE1F10A0A;
	Thu, 23 May 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOdsXZ1+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C74101CA;
	Thu, 23 May 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478025; cv=none; b=AAv9XXneCyXc06Kc+0hYMWWGCjsepVnZNyykoSJJj50XA09UTptVc4J9/r1P7PKUBrkiKzgMK1DgyiXMHKYjPn3AxC3NZ95NY8iD7hEE5DdxLRDNFquZ7JM7InJA5ZX8egeQf2uK8CdGwgx0jCXa8aZ0F1hc8qE7OT7n8/pR6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478025; c=relaxed/simple;
	bh=NZIAADL48S28HX9Sw3C6Ue42pIMIpL17ADa3oygMCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjA1cZk0KxxCLq2LszIptI+LX2zIYgazcvHR/5mBWuOHBYnwWQ8KN6LakVAU+f/TRNoW+R6+8wMzxH+cHWpLeHizCU6vGzf36HEHfCf3PtaCdmjhYppbwpVacLiJTlNohiqa3gFI+JDpAQYvuvda37fzqSVBXNZtSRxCqaQB7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOdsXZ1+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716478024; x=1748014024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NZIAADL48S28HX9Sw3C6Ue42pIMIpL17ADa3oygMCE4=;
  b=MOdsXZ1+VhRjmiH4AmwXPErb3ZLUSU3cSi97TU78LJE019T1Furkvuqq
   HxOEpPVof5uEtkv+brvCqnJE54az8cQm3c5LL0PQS0/eHsDrcfFkgzriX
   sDh4pniLpRDsMD1SkkfdqlYmkPC3eDHXfQyp28mEc2pyMPMCKevIBS/M0
   4rEfJQqL4nQto5JFuez3blxDy+jWaQG7uRAJ8gLyDY4/ifhkGxwShmCEM
   cxnXSbHxLQIjc56t2QJ0oWmJ7Ohp1TS5LvxgRQSXoN9WRRIQZvXBTbfl8
   El5Z9JvTs6xEOd9RwVeFZQiZZ4QPL2i1ZOHk5gToj+jtpk3fz/w7OhKHH
   Q==;
X-CSE-ConnectionGUID: v1jKVdXnQWuO0JOHIevt5A==
X-CSE-MsgGUID: YqHFWQCGSn6XJ1jeCTUafg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23376920"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="23376920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 08:27:03 -0700
X-CSE-ConnectionGUID: x/v4x+V/S7iFT1q2gBqK8Q==
X-CSE-MsgGUID: gNM+u2JyQAWvBQR8C+ocjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="64910341"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2024 08:26:59 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAALI-00030n-2I;
	Thu, 23 May 2024 15:26:56 +0000
Date: Thu, 23 May 2024 23:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <202405232329.5RfYqVrs-lkp@intel.com>
References: <20240522101142.559733-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522101142.559733-3-alistair.francis@wdc.com>

Hi Alistair,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master next-20240523]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/PCI-DOE-Rename-Discovery-Response-Data-Object-Contents-to-type/20240522-181416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240522101142.559733-3-alistair.francis%40wdc.com
patch subject: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
config: x86_64-randconfig-123-20240523 (https://download.01.org/0day-ci/archive/20240523/202405232329.5RfYqVrs-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405232329.5RfYqVrs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405232329.5RfYqVrs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/doe.c:107:1: sparse: sparse: symbol 'dev_attr_doe_discovery' was not declared. Should it be static?

vim +/dev_attr_doe_discovery +107 drivers/pci/doe.c

    99	
   100	#ifdef CONFIG_SYSFS
   101	static ssize_t doe_discovery_show(struct device *dev,
   102					  struct device_attribute *attr,
   103					  char *buf)
   104	{
   105		return sysfs_emit(buf, "0001:00\n");
   106	}
 > 107	DEVICE_ATTR_RO(doe_discovery);
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

