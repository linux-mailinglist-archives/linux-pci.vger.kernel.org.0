Return-Path: <linux-pci+bounces-23123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADFA56A0D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3A8167572
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88021ABC3;
	Fri,  7 Mar 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeTjE5bo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378A13A86C;
	Fri,  7 Mar 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356682; cv=none; b=kFbejARYrCLopiHte/9woUWmimBXcc7TOfw0tJIyVTdiHDN3MEBmIj8MPBMQfI7bvYY2P7rdce7z7JbolbX+36aCZXCnaZhrdoyShd+/who0VtGbRfN8/Ym8h9heUdfUXkYhuFfvKFKsDcypOxmVj4ZiPxMNmndAD0jJoyZsP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356682; c=relaxed/simple;
	bh=yTlXssuljQaYsdIFV4oTsy3eB8buOW1rjXsfqeZlkw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU2V7sRDUPZHKlnlxn9tYJ40pXzCTXiV0QQnc5rfE0U4A9R2+g7WqVmIjnrleBo1VeTDUSk0eZdlBOrBCX3JOA4NhhrkQaIsM1j6vZPEcbQ5izGk6LTr6DfTwWHYMTVS3N2mnDv2gbSJ0z/y4kPT6QYvTwWXW+/4W2btAMsZo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeTjE5bo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741356680; x=1772892680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yTlXssuljQaYsdIFV4oTsy3eB8buOW1rjXsfqeZlkw0=;
  b=TeTjE5bobTqhi1o38L3m6aev/8FDIwnY9YmrihH4FFx9T0yQbRvZ806z
   WoAHYb4hYWnnY56TjE67p0YpBpdjUdq+LkmCt1brbB1atEWFV4Fo1hY2Y
   5lm5m6lgI+zWeUjHANyyiO6ikSXepvbx/akTpu51tfw00s6Vk4akmuKCZ
   Lf0kpjCH+OJ1TvtZbZLQWXFShu4WTR5CN2Lq5pRie9ZyZ1ry7vfnT2Vci
   civ+SZRnNGYW63ZmTGWQRCqF5e53wNXaNwY8wHMr2Mmkd+JUjl6xqwkm2
   iPeMoQXAv0uhdckH0KNNvWRwUhxZBA/rmeNCuxwx10qyHIUWt7qRAPjsy
   w==;
X-CSE-ConnectionGUID: h3zxnbYXRBaauVTaQo7vqA==
X-CSE-MsgGUID: UHUo4F19Qoab6bdzIHvBhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53041183"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53041183"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:11:19 -0800
X-CSE-ConnectionGUID: daiZfncWSVaaIoj4T6dC7w==
X-CSE-MsgGUID: zKESH/YCSn+oDQSKUJSrkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123521211"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2025 06:11:15 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqYPx-0000Yl-12;
	Fri, 07 Mar 2025 14:11:13 +0000
Date: Fri, 7 Mar 2025 22:10:47 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com,
	gregkh@linuxfoundation.org, logang@deltatee.com,
	linux-kernel@vger.kernel.org, alistair23@gmail.com,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <202503072119.bmT7zRPN-lkp@intel.com>
References: <20250306075211.1855177-3-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306075211.1855177-3-alistair@alistair23.me>

Hi Alistair,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.14-rc5 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Francis/PCI-DOE-Rename-Discovery-Response-Data-Object-Contents-to-type/20250306-155550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250306075211.1855177-3-alistair%40alistair23.me
patch subject: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
config: microblaze-randconfig-r111-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072119.bmT7zRPN-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250307/202503072119.bmT7zRPN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072119.bmT7zRPN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/doe.c:109:1: sparse: sparse: symbol 'dev_attr_doe_discovery' was not declared. Should it be static?

vim +/dev_attr_doe_discovery +109 drivers/pci/doe.c

   101	
   102	#ifdef CONFIG_SYSFS
   103	static ssize_t doe_discovery_show(struct device *dev,
   104					  struct device_attribute *attr,
   105					  char *buf)
   106	{
   107		return sysfs_emit(buf, "0001:00\n");
   108	}
 > 109	DEVICE_ATTR_RO(doe_discovery);
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

