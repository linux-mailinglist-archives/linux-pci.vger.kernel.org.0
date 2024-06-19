Return-Path: <linux-pci+bounces-8960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA4E90E663
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E4281DD3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B60B7D07E;
	Wed, 19 Jun 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqHhkfCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E192139B1
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787436; cv=none; b=i4fD+GNR7WM4Or4RKpN3Gc48HGlIOa4Cuj7oQpsz6QLKKdFhB+Ku08tK1PI+jYa/GaSCiB0XCHRuDSilBrpgdKdZixbE62oPe+Xe/l9Aco72Y7rISO7sVT4Lc/60JNsCrgBYFXdOu3Aq0BLFB+X4a502rUUT5BhdKuqd68poyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787436; c=relaxed/simple;
	bh=e9rshvLEIkxR/GJPah57ZzQBHhw4MucJao7Fuc0ZGts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n8HQj1ung3aDbZ+8z+4nHpwWznS+5T77yvkglYQiuqtsPIs2Y/LtMleLlIanGfEU/uN3wcTO3JoW7VkhVtg8XOVelc2GJwfg1705DLkvLbuRnuyRX7xqle1Qo5mzwkmi0hYd9aXPLQpIwZuP7sAHwQ5DnAIG2e1cQBp1CmhjnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqHhkfCN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718787434; x=1750323434;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=e9rshvLEIkxR/GJPah57ZzQBHhw4MucJao7Fuc0ZGts=;
  b=gqHhkfCNQe5lfKxK1m/CFn5aXNaG77RTOaF+kR1zPd1pTJuOPpvU8nyZ
   G87dMLRIVeCciqrc4RJ7DmcEiLbgi/zqcVS3PLez66GGA33HycNce/0/W
   Yt4KkOh6TFRvKuaIkmGBvNvs31RCNnF8xoZk4oaQfs1oWdxXGrt1NwZ55
   CWZvfBBI3z7mlq+nRseWHO4nG3HofryGAUxLFZiw+B2HXQAV18zYyoTr6
   QJ/M3CVAJ89Q/imabnOcwheJltT9wipVgK+e3dpZ0d5OH2mdBEI4KJ3wW
   i7nb0jLY6gcOi7TmmRkI8oMT/QZqveNyQqCM/UTrzyHhOJe1IrOchCUub
   A==;
X-CSE-ConnectionGUID: JiRjo7HfSHiTAjq20al7+g==
X-CSE-MsgGUID: 8C0YsnAEQbKHcTeUtOa2Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19586526"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="19586526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 01:57:13 -0700
X-CSE-ConnectionGUID: CvgZJy1+TD6wtsLomim4hg==
X-CSE-MsgGUID: VUEtskEbSgu4nKyg4pqQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="41798272"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2024 01:57:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJr7t-0006S6-2u;
	Wed, 19 Jun 2024 08:57:09 +0000
Date: Wed, 19 Jun 2024 16:56:35 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:kwilczynski/sysfs-static-resource-attributes 11/11]
 drivers/pci/pci-sysfs.c:971:10: error: 'struct pci_bus' has no member named
 'legacy_io'
Message-ID: <202406191615.C3UP7pEc-lkp@intel.com>
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
config: powerpc-randconfig-001-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191615.C3UP7pEc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191615.C3UP7pEc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406191615.C3UP7pEc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pci-sysfs.c: In function 'pci_create_legacy_files':
>> drivers/pci/pci-sysfs.c:971:10: error: 'struct pci_bus' has no member named 'legacy_io'
     971 |         b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
         |          ^~
   drivers/pci/pci-sysfs.c:973:15: error: 'struct pci_bus' has no member named 'legacy_io'
     973 |         if (!b->legacy_io)
         |               ^~
   In file included from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/pci/pci-sysfs.c:18:
   drivers/pci/pci-sysfs.c:976:30: error: 'struct pci_bus' has no member named 'legacy_io'
     976 |         sysfs_bin_attr_init(b->legacy_io);
         |                              ^~
   include/linux/sysfs.h:55:10: note: in definition of macro 'sysfs_attr_init'
      55 |         (attr)->key = &__key;                           \
         |          ^~~~
   drivers/pci/pci-sysfs.c:976:9: note: in expansion of macro 'sysfs_bin_attr_init'
     976 |         sysfs_bin_attr_init(b->legacy_io);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/pci/pci-sysfs.c:977:10: error: 'struct pci_bus' has no member named 'legacy_io'
     977 |         b->legacy_io->attr.name = "legacy_io";
         |          ^~
   drivers/pci/pci-sysfs.c:978:10: error: 'struct pci_bus' has no member named 'legacy_io'
     978 |         b->legacy_io->size = 0xffff;
         |          ^~
   drivers/pci/pci-sysfs.c:979:10: error: 'struct pci_bus' has no member named 'legacy_io'
     979 |         b->legacy_io->attr.mode = 0600;
         |          ^~
   drivers/pci/pci-sysfs.c:980:10: error: 'struct pci_bus' has no member named 'legacy_io'
     980 |         b->legacy_io->read = pci_read_legacy_io;
         |          ^~
   drivers/pci/pci-sysfs.c:981:10: error: 'struct pci_bus' has no member named 'legacy_io'
     981 |         b->legacy_io->write = pci_write_legacy_io;
         |          ^~
   drivers/pci/pci-sysfs.c:983:10: error: 'struct pci_bus' has no member named 'legacy_io'
     983 |         b->legacy_io->llseek = pci_llseek_resource;
         |          ^~
   drivers/pci/pci-sysfs.c:984:10: error: 'struct pci_bus' has no member named 'legacy_io'
     984 |         b->legacy_io->mmap = pci_mmap_legacy_io;
         |          ^~
   drivers/pci/pci-sysfs.c:985:10: error: 'struct pci_bus' has no member named 'legacy_io'
     985 |         b->legacy_io->f_mapping = iomem_get_mapping;
         |          ^~
   drivers/pci/pci-sysfs.c:987:50: error: 'struct pci_bus' has no member named 'legacy_io'
     987 |         error = device_create_bin_file(&b->dev, b->legacy_io);
         |                                                  ^~
>> drivers/pci/pci-sysfs.c:992:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     992 |         b->legacy_mem = b->legacy_io + 1;
         |          ^~
   drivers/pci/pci-sysfs.c:992:26: error: 'struct pci_bus' has no member named 'legacy_io'
     992 |         b->legacy_mem = b->legacy_io + 1;
         |                          ^~
   drivers/pci/pci-sysfs.c:993:30: error: 'struct pci_bus' has no member named 'legacy_mem'
     993 |         sysfs_bin_attr_init(b->legacy_mem);
         |                              ^~
   include/linux/sysfs.h:55:10: note: in definition of macro 'sysfs_attr_init'
      55 |         (attr)->key = &__key;                           \
         |          ^~~~
   drivers/pci/pci-sysfs.c:993:9: note: in expansion of macro 'sysfs_bin_attr_init'
     993 |         sysfs_bin_attr_init(b->legacy_mem);
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/pci/pci-sysfs.c:994:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     994 |         b->legacy_mem->attr.name = "legacy_mem";
         |          ^~
   drivers/pci/pci-sysfs.c:995:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     995 |         b->legacy_mem->size = 1024*1024;
         |          ^~
   drivers/pci/pci-sysfs.c:996:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     996 |         b->legacy_mem->attr.mode = 0600;
         |          ^~
   drivers/pci/pci-sysfs.c:997:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     997 |         b->legacy_mem->mmap = pci_mmap_legacy_mem;
         |          ^~
   drivers/pci/pci-sysfs.c:999:10: error: 'struct pci_bus' has no member named 'legacy_mem'
     999 |         b->legacy_mem->llseek = pci_llseek_resource;
         |          ^~
   drivers/pci/pci-sysfs.c:1000:10: error: 'struct pci_bus' has no member named 'legacy_mem'
    1000 |         b->legacy_mem->f_mapping = iomem_get_mapping;
         |          ^~
   drivers/pci/pci-sysfs.c:1002:50: error: 'struct pci_bus' has no member named 'legacy_mem'
    1002 |         error = device_create_bin_file(&b->dev, b->legacy_mem);
         |                                                  ^~
   drivers/pci/pci-sysfs.c:1009:42: error: 'struct pci_bus' has no member named 'legacy_io'
    1009 |         device_remove_bin_file(&b->dev, b->legacy_io);
         |                                          ^~
   drivers/pci/pci-sysfs.c:1011:16: error: 'struct pci_bus' has no member named 'legacy_io'
    1011 |         kfree(b->legacy_io);
         |                ^~
   drivers/pci/pci-sysfs.c:1012:10: error: 'struct pci_bus' has no member named 'legacy_io'
    1012 |         b->legacy_io = NULL;
         |          ^~
   drivers/pci/pci-sysfs.c: In function 'pci_remove_legacy_files':
   drivers/pci/pci-sysfs.c:1019:14: error: 'struct pci_bus' has no member named 'legacy_io'
    1019 |         if (b->legacy_io) {
         |              ^~
   drivers/pci/pci-sysfs.c:1020:50: error: 'struct pci_bus' has no member named 'legacy_io'
    1020 |                 device_remove_bin_file(&b->dev, b->legacy_io);
         |                                                  ^~
   drivers/pci/pci-sysfs.c:1021:50: error: 'struct pci_bus' has no member named 'legacy_mem'
    1021 |                 device_remove_bin_file(&b->dev, b->legacy_mem);
         |                                                  ^~
   drivers/pci/pci-sysfs.c:1022:24: error: 'struct pci_bus' has no member named 'legacy_io'
    1022 |                 kfree(b->legacy_io); /* both are allocated here */
         |                        ^~


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

