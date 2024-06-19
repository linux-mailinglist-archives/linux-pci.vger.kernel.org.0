Return-Path: <linux-pci+bounces-8962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103290E6C8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 11:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61457284EBE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D57FBD1;
	Wed, 19 Jun 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EANk6S/j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB881ACB
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788698; cv=none; b=H9EXflL8gdv8cQLG74wH5xLOJE4/Lq0r/Wma+Bk9ra4peQrNLpuJVdBneeNbk6VsAZk7lYHXtgiOodi7OgNkMfbgcXGCXh3KCQInqpuctPhDVBsAkQDsFhlDD9F/CS9qX+EvrZ4eD2f7t0ga8WI2wXO55vv4PB4nCrKPX5td6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788698; c=relaxed/simple;
	bh=MpVu2CG+KvjhnfALLnTmb/atxIChYs9dD6hK3LIeTho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6J/glTfWDeQvaYZNUeulvsr4jsFBsjencZ0rytRLtvtI7fW3OTh1tmo+kS2rXPRpCaJXJN02h+TuJxLqv0da8H7LwIRStw1i8ytcIeyw4l0vwTJHQMSedDv++hdL/R4hc427n5aLaDl4NZF9Op0pbZvIujwPXIRQ3G2fN041Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EANk6S/j; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718788697; x=1750324697;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MpVu2CG+KvjhnfALLnTmb/atxIChYs9dD6hK3LIeTho=;
  b=EANk6S/jLC+mo368MxcmzBwbot3wMjO1YIY6Sj3N2synFPWBM80vZhoB
   7Bz0w/mgebGBNWmWmmD8pwGp0uIfNqW2zrEJmyI1JVoV8v5gddLkTMlYP
   PXgr90+d/vSmjy4xEQAJyvu0INBBuVmUCRyXPSqS+EZMHOPYIEuVJJWI1
   cSl/n6dtTS6WAQgB/qZyw7gqLuZj/mVmY+4K7tT5K3Qpv4gPtw1xPvQi5
   WnMNdvysat3QU6gwumk9ZKtgCFVR5pag1cRNsG2MfYamxZAvKqBUYg6k1
   cGX3qcVIQuxN7UIxp4LgGCC0F3eEwjusITtUP0bMKAwWq3XAkIPBXENRl
   Q==;
X-CSE-ConnectionGUID: bz0/wJvuSFKL7jTrR/0r1w==
X-CSE-MsgGUID: MpvAxPJVSq2ve9X53TfEYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15429139"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15429139"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:18:16 -0700
X-CSE-ConnectionGUID: OvOWSqFmS3C+h1v5yFlvyg==
X-CSE-MsgGUID: 5S/X+LqzS/Syp85XNZ0rhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46402906"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Jun 2024 02:18:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJrSG-0006Ty-1N;
	Wed, 19 Jun 2024 09:18:12 +0000
Date: Wed, 19 Jun 2024 17:18:04 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-static-resource-attributes 11/11]
 drivers/pci/pci-sysfs.c:971:5: error: no member named 'legacy_io' in 'struct
 pci_bus'
Message-ID: <202406191749.Tjh9cRdX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git kwilczynski/sysfs-static-resource-attributes
head:   7f395964ea2fe94ad5099688ff13d6ba89c68f97
commit: fde9d2216e37abdc20fdbb73878fa040f751cb42 [11/11] PCI/sysfs: Limit pci_sysfs_init() late initcall compile time scope
config: powerpc-randconfig-002-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191749.Tjh9cRdX-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191749.Tjh9cRdX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191749.Tjh9cRdX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pci-sysfs.c:971:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
           ~  ^
   drivers/pci/pci-sysfs.c:973:10: error: no member named 'legacy_io' in 'struct pci_bus'
           if (!b->legacy_io)
                ~  ^
   drivers/pci/pci-sysfs.c:977:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->attr.name = "legacy_io";
           ~  ^
   drivers/pci/pci-sysfs.c:978:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->size = 0xffff;
           ~  ^
   drivers/pci/pci-sysfs.c:979:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->attr.mode = 0600;
           ~  ^
   drivers/pci/pci-sysfs.c:980:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->read = pci_read_legacy_io;
           ~  ^
   drivers/pci/pci-sysfs.c:981:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->write = pci_write_legacy_io;
           ~  ^
   drivers/pci/pci-sysfs.c:983:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->llseek = pci_llseek_resource;
           ~  ^
   drivers/pci/pci-sysfs.c:984:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->mmap = pci_mmap_legacy_io;
           ~  ^
   drivers/pci/pci-sysfs.c:985:5: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_io->f_mapping = iomem_get_mapping;
           ~  ^
   drivers/pci/pci-sysfs.c:987:45: error: no member named 'legacy_io' in 'struct pci_bus'
           error = device_create_bin_file(&b->dev, b->legacy_io);
                                                   ~  ^
>> drivers/pci/pci-sysfs.c:992:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem = b->legacy_io + 1;
           ~  ^
   drivers/pci/pci-sysfs.c:992:21: error: no member named 'legacy_io' in 'struct pci_bus'
           b->legacy_mem = b->legacy_io + 1;
                           ~  ^
   drivers/pci/pci-sysfs.c:994:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->attr.name = "legacy_mem";
           ~  ^
   drivers/pci/pci-sysfs.c:995:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->size = 1024*1024;
           ~  ^
   drivers/pci/pci-sysfs.c:996:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->attr.mode = 0600;
           ~  ^
   drivers/pci/pci-sysfs.c:997:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->mmap = pci_mmap_legacy_mem;
           ~  ^
   drivers/pci/pci-sysfs.c:999:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->llseek = pci_llseek_resource;
           ~  ^
   drivers/pci/pci-sysfs.c:1000:5: error: no member named 'legacy_mem' in 'struct pci_bus'
           b->legacy_mem->f_mapping = iomem_get_mapping;
           ~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +971 drivers/pci/pci-sysfs.c

10a0ef39fbd1d4 Ivan Kokshaysky        2009-02-17   952  
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   953  /**
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   954   * pci_create_legacy_files - create legacy I/O port and memory files
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   955   * @b: bus to create files under
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   956   *
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   957   * Some platforms allow access to legacy I/O port and ISA memory space on
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   958   * a per-bus basis.  This routine creates the files and ties them into
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   959   * their associated read, write and mmap files from pci-sysfs.c
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   960   *
25985edcedea63 Lucas De Marchi        2011-03-30   961   * On error unwind, but don't propagate the error to the caller
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   962   * as it is ok to set up the PCI bus without these files.
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   963   */
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   964  void pci_create_legacy_files(struct pci_bus *b)
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   965  {
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   966  	int error;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   967  
efd532a679afae Daniel Vetter          2021-02-05   968  	if (!sysfs_initialized)
efd532a679afae Daniel Vetter          2021-02-05   969  		return;
efd532a679afae Daniel Vetter          2021-02-05   970  
6396bb221514d2 Kees Cook              2018-06-12  @971  	b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   972  			       GFP_ATOMIC);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   973  	if (!b->legacy_io)
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   974  		goto kzalloc_err;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   975  
62e877b893e635 Stephen Rothwell       2010-03-01   976  	sysfs_bin_attr_init(b->legacy_io);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   977  	b->legacy_io->attr.name = "legacy_io";
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   978  	b->legacy_io->size = 0xffff;
e2154044dd4168 Kelsey Skunberg        2019-08-13   979  	b->legacy_io->attr.mode = 0600;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   980  	b->legacy_io->read = pci_read_legacy_io;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   981  	b->legacy_io->write = pci_write_legacy_io;
24de09c16f974d Valentine Sinitsyn     2023-09-25   982  	/* See pci_create_attr() for motivation */
24de09c16f974d Valentine Sinitsyn     2023-09-25   983  	b->legacy_io->llseek = pci_llseek_resource;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  @984  	b->legacy_io->mmap = pci_mmap_legacy_io;
f06aff924f9758 Krzysztof Wilczyński   2021-07-29   985  	b->legacy_io->f_mapping = iomem_get_mapping;
10a0ef39fbd1d4 Ivan Kokshaysky        2009-02-17   986  	pci_adjust_legacy_attr(b, pci_mmap_io);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   987  	error = device_create_bin_file(&b->dev, b->legacy_io);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   988  	if (error)
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   989  		goto legacy_io_err;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   990  
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   991  	/* Allocated above after the legacy_io struct */
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  @992  	b->legacy_mem = b->legacy_io + 1;
6757eca348fbbd Mel Gorman             2010-03-10   993  	sysfs_bin_attr_init(b->legacy_mem);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   994  	b->legacy_mem->attr.name = "legacy_mem";
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   995  	b->legacy_mem->size = 1024*1024;
e2154044dd4168 Kelsey Skunberg        2019-08-13   996  	b->legacy_mem->attr.mode = 0600;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03   997  	b->legacy_mem->mmap = pci_mmap_legacy_mem;
24de09c16f974d Valentine Sinitsyn     2023-09-25   998  	/* See pci_create_attr() for motivation */
24de09c16f974d Valentine Sinitsyn     2023-09-25   999  	b->legacy_mem->llseek = pci_llseek_resource;
c6c3c5704ba708 Linus Torvalds         2021-09-01  1000  	b->legacy_mem->f_mapping = iomem_get_mapping;
10a0ef39fbd1d4 Ivan Kokshaysky        2009-02-17  1001  	pci_adjust_legacy_attr(b, pci_mmap_mem);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1002  	error = device_create_bin_file(&b->dev, b->legacy_mem);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1003  	if (error)
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1004  		goto legacy_mem_err;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1005  
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1006  	return;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1007  
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1008  legacy_mem_err:
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1009  	device_remove_bin_file(&b->dev, b->legacy_io);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1010  legacy_io_err:
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1011  	kfree(b->legacy_io);
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1012  	b->legacy_io = NULL;
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1013  kzalloc_err:
7db4af43c97b68 Bjorn Helgaas          2019-05-07  1014  	dev_warn(&b->dev, "could not create legacy I/O port and ISA memory resources in sysfs\n");
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1015  }
f19aeb1f3638b7 Benjamin Herrenschmidt 2008-10-03  1016  

:::::: The code at line 971 was first introduced by commit
:::::: 6396bb221514d2876fd6dc0aa2a1f240d99b37bb treewide: kzalloc() -> kcalloc()

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

