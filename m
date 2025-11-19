Return-Path: <linux-pci+bounces-41681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFDC711BA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id E9B6C24200
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48628DB76;
	Wed, 19 Nov 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBMghfui"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17727E05F
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586403; cv=none; b=FwFCbCcdZqKMsB9AKOTDMZaQiLzTJ1hddSCp/Kk3L1AMd8v+WtKbDezWjCzc8pz5cQ3zB69hBQZIcvpRwi5kQya3NDnYv9C3d+jWsgdF7T7TvgAJESJqAo+FBqfhjB4UTACzY4URjuDh51OqRRbQp/HnoRoOWgST6B7JAHPDN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586403; c=relaxed/simple;
	bh=wiW5Im+cSKrUpLwuFCugXLBn/QZFp+ixz0v54vet2DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O7vHMrsBUadSBqpHT/GcAF6VJnLmNq3xHF4xFEX1zu9r9C+64/GVBmO4Vsf0n8NnNDR2QtXA+B0DPzgFExAXL4aZDDJQB/Lxic7o7eOtaYTeb1+FDfnsW97eMqoX0N2hdGuxKx2OwHiYiZekdqLHkqm4OgrR8WM+XVwGZ8suAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBMghfui; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763586401; x=1795122401;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wiW5Im+cSKrUpLwuFCugXLBn/QZFp+ixz0v54vet2DI=;
  b=QBMghfuixpFMpegga385FKIoUSo96VDgBYGetsso3KNLXTrmpSzx96ZM
   Qy37ktxOlv/gevbG4+IWVELiZmvTfRlWlM41dkfemozAOrY9qWeamKbAw
   YgYSqCvGvUSVpLNszuYT5/d+/1H9XDFzGjz0fR9vTJ2q3d1SuVzZlbHer
   9fmuVc/6QmMPXE3vSZueqzzVdZipTMyHjjtugvsshR4Y7IzDvk5ICtNEj
   Hpl6nBiwsEPKftFUT7btk4HzL9d6u/t34YIvDrmy5I55ksoX2o2UO0MzL
   0XeFaVUk8y//wnr+KBE1gxhy0rnU5glSql/y1Rhd0OCdIJi1EsCtJ+PDW
   Q==;
X-CSE-ConnectionGUID: PpSFwwgsRomPRjGbCnmFiQ==
X-CSE-MsgGUID: 89x/7ENUSC6UXUMGMapQsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65522705"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65522705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 13:06:41 -0800
X-CSE-ConnectionGUID: hIx+6T2aTfSWiTVBNXtbqg==
X-CSE-MsgGUID: d/NUu+AkSNu9XwHBNLowfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="196121227"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2025 13:06:39 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLpNt-0003KT-2H;
	Wed, 19 Nov 2025 21:06:37 +0000
Date: Thu, 20 Nov 2025 05:05:55 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [pci:pwrctrl-tc9563 5/5] undefined reference to
 `i2c_unregister_device'
Message-ID: <202511200555.M4TX84jK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pwrctrl-tc9563
head:   72359837ad0d3f2cbc1364d1cba84357d6d38615
commit: 72359837ad0d3f2cbc1364d1cba84357d6d38615 [5/5] PCI: pwrctrl: Add power control driver for TC9563
config: alpha-randconfig-r054-20251120 (https://download.01.org/0day-ci/archive/20251120/202511200555.M4TX84jK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511200555.M4TX84jK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: alpha-linux-ld: DWARF error: could not find abbrev number 14070
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.o: in function `tc9563_pwrctrl_remove':
>> (.text+0x4c): undefined reference to `i2c_unregister_device'
>> alpha-linux-ld: (.text+0x50): undefined reference to `i2c_unregister_device'
>> alpha-linux-ld: (.text+0x60): undefined reference to `i2c_put_adapter'
   alpha-linux-ld: (.text+0x64): undefined reference to `i2c_put_adapter'

cocci warnings: (new ones prefixed by >>)
>> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:351:2-3: Unneeded semicolon
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:414:2-3: Unneeded semicolon
   drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:316:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

