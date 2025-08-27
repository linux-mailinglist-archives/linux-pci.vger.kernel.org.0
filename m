Return-Path: <linux-pci+bounces-34842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F1B37782
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 04:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10DC7A42AF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297D1A3172;
	Wed, 27 Aug 2025 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdZ+lvMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DC1C84D0
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260275; cv=none; b=QlrAAUxJqDNJSEA8EBCp8o473SGBNqj+4fO4BV6/74gdHb3qI7SfEWjXABhKVHrS7LVvxQGmdhVa4ZfzEIwA+dHWJ325aCq2r1g9WiEQRfK39eIwlRAH0lGzVnQJGXrB6XZ1YkIVdf8fGOLb5DuXi9S19hpZAhjLFS+eqUSDcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260275; c=relaxed/simple;
	bh=xBwZrzP8Omw+QgnrS8FgZIeYp1/6MXYyssSSiI8n24Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mZJ/TTOg85yQ/gZ7coEh+qjL8e1a8f7pzwTjqUrHxGa5ollUrub08kHqRgaHCcTkJou+sgkVE6BpSwyBCR/IP/IA4/vtj9dr65PKnkhV6eHcQ+pbcbJHVAuwmPBQldqlzBx1f1PGZonGi1dtO1Hk/hlCqdcV5zwaNnJdkQcoxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdZ+lvMF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756260274; x=1787796274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xBwZrzP8Omw+QgnrS8FgZIeYp1/6MXYyssSSiI8n24Q=;
  b=kdZ+lvMFM0x7DHqnML0/NH6vaohQDbuvbKTgMxJcFs3iCPbHLjX88Ygn
   gryXcsMaY7K+7UBsfgYqLPoirvUGDKyC1Ppc5NmKDXYL1oRaEqNHX+jkP
   xhll+M1LxsJRLnfxv12NfsNNTqYDGZoYCf7NgJMC6sqjT3q+vq/8G9RaL
   RrAavwhmN1kraWvC/Hp+/eCoWROgNtMSfuRYvWUS/dUPoDneveXNZGE5r
   09boq4ZJ3P0pUbYlST6l7m0nSA3xPWvxRIQp2uwoIjdkm8Oph6/arfqOR
   tlPPprjLIsGe15tOCK1QPm5mK4HDBtX4qjod3OQSHdXS9R2+QCbMKqx4m
   g==;
X-CSE-ConnectionGUID: kBfhw1J0RimKnecrYzf8Xg==
X-CSE-MsgGUID: MtbfQqHKR3WhSl5DHNqz5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69878193"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69878193"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:04:31 -0700
X-CSE-ConnectionGUID: McjJGXyWQmCGlhbKa1Xzww==
X-CSE-MsgGUID: Blkgh0nOS0CwwdUflhNByA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193373716"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2025 19:04:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur5WV-000SZj-1X;
	Wed, 27 Aug 2025 02:04:27 +0000
Date: Wed, 27 Aug 2025 10:03:56 +0800
From: kernel test robot <lkp@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: [pci:wip/2508-david-aspm-api 1/2] include/linux/pci.h:1870:56:
 error: two or more data types in declaration specifiers
Message-ID: <202508270921.b1XgvRZo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2508-david-aspm-api
head:   a373462082599403e030c605ff260fd45429fe66
commit: 5ea26ba40d978b9f34faec2ca92c60e6d9db11c5 [1/2] PCI/ASPM: Add pci_host_set_default_pcie_link_state()
config: x86_64-buildonly-randconfig-003-20250827 (https://download.01.org/0day-ci/archive/20250827/202508270921.b1XgvRZo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250827/202508270921.b1XgvRZo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508270921.b1XgvRZo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/char/applicom.c:32:
>> include/linux/pci.h:1870:56: error: two or more data types in declaration specifiers
    1870 |                                                    u32 int state) { }
         |                                                        ^~~
   drivers/char/applicom.c: In function 'ac_register_board':
   drivers/char/applicom.c:130:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     130 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
   drivers/char/applicom.c: In function 'ac_read':
   drivers/char/applicom.c:542:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     542 |         int ret = 0;
         |             ^~~
   drivers/char/applicom.c: In function 'ac_ioctl':
   drivers/char/applicom.c:705:32: warning: variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
     705 |         volatile unsigned char byte_reset_it;
         |                                ^~~~~~~~~~~~~
--
   In file included from drivers/char/hw_random/intel-rng.c:31:
>> include/linux/pci.h:1870:56: error: two or more data types in declaration specifiers
    1870 |                                                    u32 int state) { }
         |                                                        ^~~


vim +1870 include/linux/pci.h

  1834	
  1835	#define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
  1836	#define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
  1837	#define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */
  1838	#define PCIE_LINK_STATE_L1_2		BIT(4)	/* ASPM L1.2 state */
  1839	#define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)	/* PCI-PM L1.1 state */
  1840	#define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)	/* PCI-PM L1.2 state */
  1841	#define PCIE_LINK_STATE_ASPM_ALL	(PCIE_LINK_STATE_L0S		|\
  1842						 PCIE_LINK_STATE_L1		|\
  1843						 PCIE_LINK_STATE_L1_1		|\
  1844						 PCIE_LINK_STATE_L1_2		|\
  1845						 PCIE_LINK_STATE_L1_1_PCIPM	|\
  1846						 PCIE_LINK_STATE_L1_2_PCIPM)
  1847	#define PCIE_LINK_STATE_CLKPM		BIT(7)
  1848	#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_ASPM_ALL	|\
  1849						 PCIE_LINK_STATE_CLKPM)
  1850	
  1851	#ifdef CONFIG_PCIEASPM
  1852	int pci_disable_link_state(struct pci_dev *pdev, int state);
  1853	int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
  1854	int pci_enable_link_state(struct pci_dev *pdev, int state);
  1855	int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
  1856	void pci_host_set_default_link_state(struct pci_host_bridge *host, u32 state);
  1857	void pcie_no_aspm(void);
  1858	bool pcie_aspm_support_enabled(void);
  1859	bool pcie_aspm_enabled(struct pci_dev *pdev);
  1860	#else
  1861	static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
  1862	{ return 0; }
  1863	static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
  1864	{ return 0; }
  1865	static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
  1866	{ return 0; }
  1867	static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
  1868	{ return 0; }
  1869	static inline void pci_host_set_default_link_state(struct pci_host_bridge *host,
> 1870							   u32 int state) { }
  1871	static inline void pcie_no_aspm(void) { }
  1872	static inline bool pcie_aspm_support_enabled(void) { return false; }
  1873	static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
  1874	#endif
  1875	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

