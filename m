Return-Path: <linux-pci+bounces-23076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A11A559D4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 23:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5635517494B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030E27C173;
	Thu,  6 Mar 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWs/uECY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB876279338
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300429; cv=none; b=Cizim1OyYvpKbG/M8mDJS1wcQ2fwZLR1dwkG4OrIE/S7xiuesmzoCTSNfq3bMCwlQbLCcnfyICdc4gYDG0Zmb+FpQl4KxnyLga8vmxBddojwGtW44ilhtUp/uLEiiEAZRoHrIzXgIJ+Ufpq5OoXv/+8HHfm4xYYGa2DNN19EOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300429; c=relaxed/simple;
	bh=1NsPM2P84MNO8PiIuApTLCyBJ2kvrJaw4c8rPxsqCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOw94suq59OiWo+/uukOErQnKmQzsdGjOymVkF/7gZfw6SBGbKXWUBxVyJ3fE4PP0Gb31qR27kg6AAJq7fCuR7EMF6hcePaWSgz5lYPKabOwmhylCLdUPJlrLlsyLxYn4bcEj/LRxPkG5rgt30xATPcUZxlZ5LW3K5gbzqYlzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWs/uECY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741300428; x=1772836428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1NsPM2P84MNO8PiIuApTLCyBJ2kvrJaw4c8rPxsqCxo=;
  b=FWs/uECY6aiMp8k/Z8jDtg8Wp3bnXfOX3kkuJaz8CULIrexmjpz3I/xj
   ABeMYFBHmm/9DGEy5FgBXmwR9ivTgRZinNK4QwcoJCaJbTDaLIiDlmnv+
   xGbxpOXk1Z7VgiCr6KAef9k5/lbecmJ+1PAWYtyuIszjyvxe2Nvx2wF+T
   yucfl12614W1mH9ztsppyGi6EMSQdSWjwXRg4iRkjwvwMDtE3q9VzoYsm
   qpn6hCpPdQX/Armb5ZeKXs10UUfXueeToFL5PgE91DGAbwbyMgt8vHgWV
   Zy3+gP6T2r4oQUCbuHktp+rzr3yNpzcDTSYGvS9D4Yu52A0VRxpLqBqfV
   Q==;
X-CSE-ConnectionGUID: txUCx2gkRK+ZIPuW8TGeSw==
X-CSE-MsgGUID: Yj7r281VR8mpSWeGHbzaxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42571699"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42571699"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:33:47 -0800
X-CSE-ConnectionGUID: p+/S+BpTQNqK+ydzf1OOgQ==
X-CSE-MsgGUID: M5TdkHOJROGB7UQGqdyLKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119848824"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 06 Mar 2025 14:33:45 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqJmh-000Ni7-22;
	Thu, 06 Mar 2025 22:33:43 +0000
Date: Fri, 7 Mar 2025 06:33:08 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Francis <alistair@alistair23.me>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [pci:doe 3/4] drivers/pci/pci.h:464:70: error: 'return' with a
 value, in function returning void
Message-ID: <202503070631.aZNf56QY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git doe
head:   d7706150d71eca96b6eb8865152bb9fd9830e9fc
commit: c4cef7f8f8202238f89668e1c0d013a94c0069fd [3/4] PCI/DOE: Expose DOE features via sysfs
config: riscv-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070631.aZNf56QY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070631.aZNf56QY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/quirks.c:37:
   drivers/pci/pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/pci.h:464:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/pci.h:464:20: note: declared here
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/pcie/aspm.c:27:
   drivers/pci/pcie/../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/pcie/../pci.h:464:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/pcie/../pci.h:464:20: note: declared here
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/msi/msi.c:14:
   drivers/pci/msi/../pci.h: In function 'pci_doe_sysfs_init':
>> drivers/pci/msi/../pci.h:464:70: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                                                                      ^
   drivers/pci/msi/../pci.h:464:20: note: declared here
     464 | static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
         |                    ^~~~~~~~~~~~~~~~~~


vim +/return +464 drivers/pci/pci.h

   459	
   460	#if defined(CONFIG_PCI_DOE) && defined(CONFIG_SYSFS)
   461	void pci_doe_sysfs_init(struct pci_dev *pci_dev);
   462	void pci_doe_sysfs_teardown(struct pci_dev *pdev);
   463	#else
 > 464	static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { return 0; }
   465	static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
   466	#endif
   467	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

