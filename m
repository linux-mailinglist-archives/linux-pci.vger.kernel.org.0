Return-Path: <linux-pci+bounces-15855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB99BA241
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 20:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E911C21B6A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7041AB533;
	Sat,  2 Nov 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMDBpJm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294C1AB51E
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577355; cv=none; b=oRhrDUew1vMg7tYNvlgw1MQsaNAx2c/FpcZSGrjwGCJUQzkX8633rz2LZ5Sj/mHN414R9HQEVTo2Ew5jRjrIQ/aurDiKYaKmqzaoD16GVLq0kalXCzPynvpuZBpJXyEADAWhoGFvUxPw3Ho0B0KVAwcoZRdK9xSxNSiVzZMmjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577355; c=relaxed/simple;
	bh=0qQmFctEhg0NU6h8qc+RlT3dSgDN316sYapSLWjV0l0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TcI/EaAYxwwuVPSye78EQFBcgHZ93VEJ0DJGvrTVCczZBujH9Ul+Ub+UqUOnd1Qju92VI/NXZ8TJEL/HaUnGzya4wsPLw0JhrMYkmv8sg+A3tOy1pLkdO7mEmuMCro7ECBQPo2GnQ8Y+GDKixnkHTnCb38m92mvezgJ+5jvWMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMDBpJm2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730577354; x=1762113354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0qQmFctEhg0NU6h8qc+RlT3dSgDN316sYapSLWjV0l0=;
  b=PMDBpJm2Lv4dMr1G1KOxly0EEIY6t8mg9lkzSvVrI7q19Tib0VX61tk5
   1dPBuBkIHZ4aTgF/37Th8EBHtqUauQCyyhqSme/veZR51p8B80YzOyL2i
   hg4+VslqEwUFl1nz/9fSEB4+5TYRTn1iaeBurKcFneckHNZ6XxTYH3kne
   50uZlmfyxzZtZWmQcD+Ll+3co5qwxptc7/eHkEF2yeSKhYXd/9QFJRZKt
   j/tflBEwn9SOG+pg5XUAUMRWs9H9GOrktr7ARPiHgu89KDMdpbYVlUeU1
   U1B35LWDW2s7o1JIDGBxcqvlT25OrajMseS0L6/weZXjQktTnIj/Ih92D
   g==;
X-CSE-ConnectionGUID: RoKUnaTmSWmUi8/7hobw1g==
X-CSE-MsgGUID: immY0+BgQA2NgoQZrvAU4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="17938970"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="17938970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 12:55:53 -0700
X-CSE-ConnectionGUID: BrUcU1lsRtqlUmBt7O6mlA==
X-CSE-MsgGUID: RtzM9tY/TFOqWRQotFcn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="88086148"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Nov 2024 12:55:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7KDt-000jI5-0R;
	Sat, 02 Nov 2024 19:55:49 +0000
Date: Sun, 3 Nov 2024 03:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [pci:bwctrl 2/5] drivers/pci/msi/../pci.h:834:1: error: expected
 identifier or '(' before '{' token
Message-ID: <202411030310.MsYt3PLH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git bwctrl
head:   5ccc52fd1e5a9a7602b6e20ce931a7fd4f3be87b
commit: 5f2710a4c2754c3c63bbe751fe1c54eb7f5c8441 [2/5] PCI/pwrctl: Create pwrctl devices only if at least one power supply is present
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241103/202411030310.MsYt3PLH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241103/202411030310.MsYt3PLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411030310.MsYt3PLH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pci/access.c:8:
   drivers/pci/pci.h:834:1: error: expected identifier or '(' before '{' token
     834 | {
         | ^
>> drivers/pci/pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
     833 | static inline bool of_pci_is_supply_present(struct device_node *np);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/bus.c:20:
   drivers/pci/pci.h:834:1: error: expected identifier or '(' before '{' token
     834 | {
         | ^
>> drivers/pci/pci.h:833:20: warning: 'of_pci_is_supply_present' used but never defined
     833 | static inline bool of_pci_is_supply_present(struct device_node *np);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/msi/pcidev_msi.c:5:
>> drivers/pci/msi/../pci.h:834:1: error: expected identifier or '(' before '{' token
     834 | {
         | ^
>> drivers/pci/msi/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
     833 | static inline bool of_pci_is_supply_present(struct device_node *np);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/pcie/portdrv.c:22:
   drivers/pci/pcie/../pci.h:834:1: error: expected identifier or '(' before '{' token
     834 | {
         | ^
>> drivers/pci/pcie/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
     833 | static inline bool of_pci_is_supply_present(struct device_node *np);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/pci/hotplug/pci_hotplug_core.c:32:
   drivers/pci/hotplug/../pci.h:834:1: error: expected identifier or '(' before '{' token
     834 | {
         | ^
>> drivers/pci/hotplug/../pci.h:833:20: warning: 'of_pci_is_supply_present' declared 'static' but never defined [-Wunused-function]
     833 | static inline bool of_pci_is_supply_present(struct device_node *np);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +834 drivers/pci/msi/../pci.h

   832	
 > 833	static inline bool of_pci_is_supply_present(struct device_node *np);
 > 834	{
   835		return false;
   836	}
   837	#endif /* CONFIG_OF */
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

