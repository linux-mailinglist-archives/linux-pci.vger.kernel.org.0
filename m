Return-Path: <linux-pci+bounces-21422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E72A35548
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 04:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F361516A6A4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638B15198F;
	Fri, 14 Feb 2025 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnzoy5RN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEE15199D
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503693; cv=none; b=VCCIAt4oAoc851dq+PHkqpbBGh/U1rQXnCK61O+bvULhUVDXJa0JdhTgqkmqopyMHtgMt+1Gyw1/2dxNGcaKt7RRiSqPOk8Wn+IdJEtdiq/ntqNf3M5CJvX6k2YYLJi7n7Bc9L6UmuNtp5sUbS0Yz9QoIC9TDLinoV4Me1Eu+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503693; c=relaxed/simple;
	bh=Yz4m/qudMiqmVYQs1oLijmO5U1jCX3cIDtf4priUKbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f7sXGIVWDpRCrDaqhF8+Oc9s8uqpclaW+mZk6g5aM7T+FHPZVF9yAf0uRl1znW/quNnb/xAv4EPNorz6oxTM8i0DAaZ0KnknUZcy4CyTPPr4hiWdYhu+3IGTZ1+Kcd+k34pCuA5AmEZDAlxgYN3U0LTzBEYmBe8J6ZoIW0+v4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnzoy5RN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739503691; x=1771039691;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yz4m/qudMiqmVYQs1oLijmO5U1jCX3cIDtf4priUKbk=;
  b=jnzoy5RNRhmQEPYpUiJXg+8RC6efXtxtSt2UdFSWaYeDQ8V+2x/U6oQ7
   iZy3yOTi98zXOe8tcZlaINSzTFOrJooqZjpJBbuo0gtDocs1WHmldC6vu
   8NQ7/VrSPCW8duZWw/bhawHbgr+IjPPh3PQCFzp2+b8PnhtIC05DtDmjp
   7fnk5sJm4q1VGlmtnOh58TWP5UlhbPg+XE4w91J7r/ltwLKQ6C/c8ddRC
   Tw4FcXcNBQGiIMNhpjLw0hrbPDHdKNHL/8VlGJuPMCsZKXIgt3duITlzy
   arg+7GxwnWNlR+TMRcNWR21IxkZM8+RQZlE/ZRP+aJ0vlqG6UtCZY0XWH
   Q==;
X-CSE-ConnectionGUID: L5igmNeUTuqxZ/1xw3jUSw==
X-CSE-MsgGUID: KRziHxkRR0CKP5DwEQWBtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50885366"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50885366"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 19:28:10 -0800
X-CSE-ConnectionGUID: U1MDDcVSRN63/dPwVRyXrw==
X-CSE-MsgGUID: cbz9X3sARZ++n4kMSf/UoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118549330"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 19:28:08 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1timN3-00191F-0L;
	Fri, 14 Feb 2025 03:28:05 +0000
Date: Fri, 14 Feb 2025 11:27:23 +0800
From: kernel test robot <lkp@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:aer 1/1] drivers/pci/hotplug/shpchp.h:256:3: error: call to
 undeclared function 'pci_printk'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202502141105.6eIoURaG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git aer
head:   c928d117f57c9ca1801c0e37019a357f86eb96f1
commit: c928d117f57c9ca1801c0e37019a357f86eb96f1 [1/1] PCI: Descope pci_printk() to aer_printk()
config: x86_64-buildonly-randconfig-001-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141105.6eIoURaG-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141105.6eIoURaG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141105.6eIoURaG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/hotplug/shpchp_ctrl.c:22:
>> drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp.h:267:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |                 ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
>> drivers/pci/hotplug/shpchp_ctrl.c:51:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      51 |         ctrl_dbg(ctrl, "Attention button interrupt received\n");
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:75:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      75 |         ctrl_dbg(ctrl, "Switch interrupt received\n");
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:80:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      80 |         ctrl_dbg(ctrl, "Card present %x Power status %x\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:112:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     112 |         ctrl_dbg(ctrl, "Presence/Notify input change\n");
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:147:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     147 |         ctrl_dbg(ctrl, "Power fault interrupt received\n");
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:183:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     183 |         ctrl_dbg(ctrl, "Change speed to %d\n", speed);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:240:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     240 |         ctrl_dbg(ctrl, "%s: p_slot->device, slot_offset, hp_slot = %d, %d ,%d\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:279:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     279 |         ctrl_dbg(ctrl, "%s: slots_not_empty %d, adapter_speed %d, bus_speed %d, max_bus_speed %d\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:297:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     297 |         ctrl_dbg(ctrl, "%s: slot status = %x\n", __func__, p_slot->status);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:301:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     301 |                 ctrl_dbg(ctrl, "%s: Power fault\n", __func__);
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:348:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     348 |         ctrl_dbg(ctrl, "%s: hp_slot = %d\n", __func__, hp_slot);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:528:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     528 |                 ctrl_dbg(p_slot->ctrl, "%s: Power fault\n", __func__);
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_ctrl.c:572:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     572 |         ctrl_dbg(ctrl, "%s: p_slot->pwr_save %x\n", __func__, p_slot->pwr_save);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   15 errors generated.
--
   In file included from drivers/pci/hotplug/shpchp_sysfs.c:19:
>> drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp.h:267:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |                 ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   2 errors generated.
--
   In file included from drivers/pci/hotplug/shpchp_hpc.c:22:
>> drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp.h:267:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |                 ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
>> drivers/pci/hotplug/shpchp_hpc.c:305:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     305 |         ctrl_dbg(ctrl, "%s: t_slot %x cmd %x\n", __func__, t_slot, cmd);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:461:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     461 |         ctrl_dbg(ctrl, "%s: slot_reg = %x, pcix_cap = %x, m66_cap = %x\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:487:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     487 |         ctrl_dbg(ctrl, "Adapter speed = %d\n", *value);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:760:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     760 |         ctrl_dbg(ctrl, "%s: intr_loc = %x\n", __func__, intr_loc);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:773:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     773 |                 ctrl_dbg(ctrl, "%s: intr_loc2 = %x\n", __func__, intr_loc2);
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:798:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     798 |                 ctrl_dbg(ctrl, "Slot %x with intr, slot register = %x\n",
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:868:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     868 |         ctrl_dbg(ctrl, "Max bus speed = %d\n", bus_speed);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:882:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     882 |         ctrl_dbg(ctrl, "Hotplug Controller:\n");
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:895:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     895 |                 ctrl_dbg(ctrl, " cap_offset = %x\n", ctrl->cap_offset);
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:909:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     909 |                 ctrl_dbg(ctrl, " num_slots (indirect) %x\n", num_slots);
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:918:4: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     918 |                         ctrl_dbg(ctrl, " offset %d: value %x\n", i, tempdword);
         |                         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:950:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     950 |         ctrl_dbg(ctrl, "ctrl->creg %p\n", ctrl->creg);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:967:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     967 |         ctrl_dbg(ctrl, "SERR_INTR_ENABLE = %x\n", tempdword);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:973:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     973 |         ctrl_dbg(ctrl, "SERR_INTR_ENABLE = %x\n", tempdword);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:980:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     980 |                 ctrl_dbg(ctrl, "Default Logical Slot Register %d value %x\n",
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:1006:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1006 |                 ctrl_dbg(ctrl, "request_irq %d (returns %d)\n",
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_hpc.c:1014:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1014 |         ctrl_dbg(ctrl, "HPC at %s irq=%x\n", pci_name(pdev), pdev->irq);
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
--
   In file included from drivers/pci/hotplug/shpchp_pci.c:21:
>> drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp.h:267:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |                 ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
>> drivers/pci/hotplug/shpchp_pci.c:70:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      70 |         ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:%02x\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   3 errors generated.
--
   In file included from drivers/pci/hotplug/shpchp_core.c:22:
>> drivers/pci/hotplug/shpchp.h:256:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |                 ctrl_dbg(p_slot->ctrl,
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp.h:267:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     267 |                 ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
>> drivers/pci/hotplug/shpchp_core.c:99:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      99 |                 ctrl_dbg(ctrl, "Registering domain:bus:dev=%04x:%02x:%02x hp_slot=%x sun=%x slot_device_offset=%x\n",
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:148:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     148 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:161:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     161 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:171:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     171 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:182:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     182 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:197:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     197 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:212:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     212 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:227:2: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     227 |         ctrl_dbg(slot->ctrl, "%s: physical_slot = %s\n",
         |         ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   drivers/pci/hotplug/shpchp_core.c:272:3: error: call to undeclared function 'pci_printk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     272 |                 ctrl_dbg(ctrl, "Controller initialization failed\n");
         |                 ^
   drivers/pci/hotplug/shpchp.h:51:4: note: expanded from macro 'ctrl_dbg'
      51 |                         pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
         |                         ^
   11 errors generated.


vim +/pci_printk +256 drivers/pci/hotplug/shpchp.h

53044f357448693 Keck, David 2006-01-16  243  
53044f357448693 Keck, David 2006-01-16  244  static inline void amd_pogo_errata_restore_misc_reg(struct slot *p_slot)
53044f357448693 Keck, David 2006-01-16  245  {
53044f357448693 Keck, David 2006-01-16  246  	u32 pcix_misc2_temp;
53044f357448693 Keck, David 2006-01-16  247  	u32 pcix_bridge_errors_reg;
53044f357448693 Keck, David 2006-01-16  248  	u32 pcix_mem_base_reg;
53044f357448693 Keck, David 2006-01-16  249  	u8  perr_set;
53044f357448693 Keck, David 2006-01-16  250  	u8  rse_set;
53044f357448693 Keck, David 2006-01-16  251  
53044f357448693 Keck, David 2006-01-16  252  	/* write-one-to-clear Bridge_Errors[ PERR_OBSERVED ] */
53044f357448693 Keck, David 2006-01-16  253  	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, &pcix_bridge_errors_reg);
53044f357448693 Keck, David 2006-01-16  254  	perr_set = pcix_bridge_errors_reg & PERR_OBSERVED_MASK;
53044f357448693 Keck, David 2006-01-16  255  	if (perr_set) {
f98ca311f3a32e2 Taku Izumi  2008-10-23 @256  		ctrl_dbg(p_slot->ctrl,
be7bce250a88fbb Taku Izumi  2008-10-23  257  			 "Bridge_Errors[ PERR_OBSERVED = %08X] (W1C)\n",
be7bce250a88fbb Taku Izumi  2008-10-23  258  			 perr_set);
53044f357448693 Keck, David 2006-01-16  259  
53044f357448693 Keck, David 2006-01-16  260  		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISC_BRIDGE_ERRORS_OFFSET, perr_set);
53044f357448693 Keck, David 2006-01-16  261  	}
53044f357448693 Keck, David 2006-01-16  262  
53044f357448693 Keck, David 2006-01-16  263  	/* write-one-to-clear Memory_Base_Limit[ RSE ] */
53044f357448693 Keck, David 2006-01-16  264  	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET, &pcix_mem_base_reg);
53044f357448693 Keck, David 2006-01-16  265  	rse_set = pcix_mem_base_reg & RSE_MASK;
53044f357448693 Keck, David 2006-01-16  266  	if (rse_set) {
be7bce250a88fbb Taku Izumi  2008-10-23  267  		ctrl_dbg(p_slot->ctrl, "Memory_Base_Limit[ RSE ] (W1C)\n");
53044f357448693 Keck, David 2006-01-16  268  
53044f357448693 Keck, David 2006-01-16  269  		pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MEM_BASE_LIMIT_OFFSET, rse_set);
53044f357448693 Keck, David 2006-01-16  270  	}
53044f357448693 Keck, David 2006-01-16  271  	/* restore MiscII register */
53044f357448693 Keck, David 2006-01-16  272  	pci_read_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, &pcix_misc2_temp);
53044f357448693 Keck, David 2006-01-16  273  
53044f357448693 Keck, David 2006-01-16  274  	if (p_slot->ctrl->pcix_misc2_reg & SERRFATALENABLE_MASK)
53044f357448693 Keck, David 2006-01-16  275  		pcix_misc2_temp |= SERRFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  276  	else
53044f357448693 Keck, David 2006-01-16  277  		pcix_misc2_temp &= ~SERRFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  278  
53044f357448693 Keck, David 2006-01-16  279  	if (p_slot->ctrl->pcix_misc2_reg & SERRNONFATALENABLE_MASK)
53044f357448693 Keck, David 2006-01-16  280  		pcix_misc2_temp |= SERRNONFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  281  	else
53044f357448693 Keck, David 2006-01-16  282  		pcix_misc2_temp &= ~SERRNONFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  283  
53044f357448693 Keck, David 2006-01-16  284  	if (p_slot->ctrl->pcix_misc2_reg & PERRFLOODENABLE_MASK)
53044f357448693 Keck, David 2006-01-16  285  		pcix_misc2_temp |= PERRFLOODENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  286  	else
53044f357448693 Keck, David 2006-01-16  287  		pcix_misc2_temp &= ~PERRFLOODENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  288  
53044f357448693 Keck, David 2006-01-16  289  	if (p_slot->ctrl->pcix_misc2_reg & PERRFATALENABLE_MASK)
53044f357448693 Keck, David 2006-01-16  290  		pcix_misc2_temp |= PERRFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  291  	else
53044f357448693 Keck, David 2006-01-16  292  		pcix_misc2_temp &= ~PERRFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  293  
53044f357448693 Keck, David 2006-01-16  294  	if (p_slot->ctrl->pcix_misc2_reg & PERRNONFATALENABLE_MASK)
53044f357448693 Keck, David 2006-01-16  295  		pcix_misc2_temp |= PERRNONFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  296  	else
53044f357448693 Keck, David 2006-01-16  297  		pcix_misc2_temp &= ~PERRNONFATALENABLE_MASK;
53044f357448693 Keck, David 2006-01-16  298  	pci_write_config_dword(p_slot->ctrl->pci_dev, PCIX_MISCII_OFFSET, pcix_misc2_temp);
53044f357448693 Keck, David 2006-01-16  299  }
53044f357448693 Keck, David 2006-01-16  300  

:::::: The code at line 256 was first introduced by commit
:::::: f98ca311f3a32e2adc229fecd6bf732db07fcca3 PCI hotplug: shpchp: replace printk with dev_printk

:::::: TO: Taku Izumi <izumi.taku@jp.fujitsu.com>
:::::: CC: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

