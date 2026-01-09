Return-Path: <linux-pci+bounces-44400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED71D0C242
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 21:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0618C300E8CA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 20:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11BB1B4F2C;
	Fri,  9 Jan 2026 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doIiqsRD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA211F151C;
	Fri,  9 Jan 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989371; cv=none; b=ULZ+XVcRpt+/zq/yfzJY8Bn25GikYfZSZjLWVO/kVhvh0vovaYfcRbnpX75RVygoKrR6obrgQwUHOtOCxFVRF2JzeMwfSU7gU5ucYxOMTuaFWZymxzvq9yEu948V9exEFHYfY1b56U2Ruklm8l+pHWNsQJe6ir2i4us49rwHHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989371; c=relaxed/simple;
	bh=5axzby49Fa/0SEo5UFGiSuW7Dqdl7D33czvCIivdFOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFARaBa2CudKXOtW/NWUnJPeWOliYAlzFCNPB9azeIBORQMcevkiARaFJ10kOZ1NcBvxuHbQqWVS2DUEhOUegvs+7SPDSqqtQOm2OsJBPwWNOeQOTvc+Elg8GzxiJBadU2kAcZn4F/ZSELSqVW80UQC1Stkkm0P0Tk+AJnaB84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doIiqsRD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767989369; x=1799525369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5axzby49Fa/0SEo5UFGiSuW7Dqdl7D33czvCIivdFOQ=;
  b=doIiqsRDFzty6R6WiEK1huNTIj8jYhJGwsWTdZL+2Y5OhWwSgeTI/ZO0
   OXDDrtiw224XizuI9k2/1dOOsRKVoj0GfFfUA2LWAICCgWQKMaqopZC84
   losKRfIBsMaQOzhed3MzNY20LbDZ8r1jpjCzPEF3qi6M5nDJ0Ore9m3dL
   EFBGan/HfJyXxYjQYCnF097/3KFKBZ+2ZFMaXptKA1fkpY3wHGCsbV6af
   iAF5O/iFCYkzzSWf84TlOBqkTUczggNgiO86R42hx9B8SjvBZrGcrht0f
   GmFIjMTHYuU8lgKMA5qR3+g1iyDbTupWlzaLbOPGsqqeULGBwL+sp3jz+
   g==;
X-CSE-ConnectionGUID: rkOWqxzpSFqOu9r0MHWJvw==
X-CSE-MsgGUID: RmTxEXLKSTqz4tqf+LRg/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69445827"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69445827"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 12:09:29 -0800
X-CSE-ConnectionGUID: 7xfIFGvxRrm0x7xEk1P3Tw==
X-CSE-MsgGUID: 9+5xRz03SICboPHoeOcpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="208083989"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 09 Jan 2026 12:09:27 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veInU-0000000028K-011v;
	Fri, 09 Jan 2026 20:09:24 +0000
Date: Fri, 9 Jan 2026 21:08:56 +0100
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event
 documentation
Message-ID: <202601092104.0IlUz26P-lkp@intel.com>
References: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20260109]
[cannot apply to pci/for-linus mani-mhi/mhi-next trace/for-next linus/master v6.19-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/PCI-trace-Add-PCI-controller-LTSSM-transition-tracepoint/20260109-153843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1767929389-143957-3-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event documentation
reproduce: (https://download.01.org/0day-ci/archive/20260109/202601092104.0IlUz26P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601092104.0IlUz26P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARNING: No kernel-doc for file ./include/linux/delay.h
   ERROR: Cannot find file ./include/linux/delay.h
   WARNING: No kernel-doc for file ./include/linux/delay.h
   ERROR: Cannot find file ./include/linux/delay.h
   WARNING: No kernel-doc for file ./include/linux/delay.h
>> Documentation/trace/events-pci-conotroller.rst:21: WARNING: Title underline too short.
--
   ERROR: Cannot find file ./include/linux/mutex.h
   ERROR: Cannot find file ./include/linux/mutex.h
   WARNING: No kernel-doc for file ./include/linux/mutex.h
   ERROR: Cannot find file ./include/linux/fwctl.h
   WARNING: No kernel-doc for file ./include/linux/fwctl.h
>> Documentation/trace/events-pci-conotroller.rst: WARNING: document isn't included in any toctree [toc.not_included]


vim +21 Documentation/trace/events-pci-conotroller.rst

    19	
    20	pcie_ltssm_state_transition
  > 21	-----------------------
    22	
    23	Monitors PCIe LTSSM state transition including state and rate information
    24	::
    25	
    26	    pcie_ltssm_state_transition  "dev: %s state: %s rate: %s\n"
    27	
    28	**Parameters**:
    29	
    30	* ``dev`` - PCIe root port name
    31	* ``state`` - PCIe LTSSM state
    32	* ``rate`` - PCIe bus speed
    33	
    34	**Example Usage**:
    35	
    36	    # Enable the tracepoint
    37	    echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_transition/enable
    38	
    39	    # Monitor events (the following output is generated when a device is linking)
    40	    cat /sys/kernel/debug/tracing/trace_pipe
  > 41	       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

