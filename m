Return-Path: <linux-pci+bounces-17816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E49E6206
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 01:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D45168AB1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E111C83;
	Fri,  6 Dec 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7kEMBmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8F1946B
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443999; cv=none; b=ZPG00DnPn2DoJr3kO7dDy/y6Pipr2ammVMDb46WnEBaPTU76lCHeSDxH/BD5X/lTX9Agv/02BKat0tcTEVYKmiKgFfVemRTZsKIwpQSwZbJLcAOaQaUVqBiGhNPb+qY38C8C8v3wvhC/XaDcmwn6wQ918s3PYYB0RKe1oRWTT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443999; c=relaxed/simple;
	bh=G3k5kdpZDzPR2z4Kv8oYbTAM4x/lxykBvWDQ8XU9s/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE2fsU1CGUrmW0gkSVjju8Ja5DAfY9zKagjyZ31vmIMreRcUj2glSITfOCJoay5tURi4/ECIYDC6y48kjZHRAPHAwaAwfFK7fHEuQSVFzRuPOmhFw/VZaxzBRqrsKHLrBVknaSBCeJNYwBLDnKS8D3n9OwggJwzwKdq/gfruNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7kEMBmh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733443998; x=1764979998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3k5kdpZDzPR2z4Kv8oYbTAM4x/lxykBvWDQ8XU9s/Q=;
  b=h7kEMBmhmSzvYzDbIxqH6kmPwCh/opjTYIE85qX0O4fjVgzYEKxVxUVn
   3wxXTd0WbML/26ZJrBnQwe3WNy5MgjCU9lcMOhD2ThV6w+7ZkTT4UX8qW
   j6RrIWZv4ah3PvbRUGhV9vYx5s65OkAVlRP9enmOZgYzOSk1M3WtQLLp7
   a3OOa4dZq/MtKXeugMhCFE4NtfoCGJLJ3ilRnKJKa5zse8FbB5gAOVx2/
   KhrByeEW+kWAOqctft4+OxmWSkARBPA8l6kbtjJHOjGFK8+jWVjKHQVtp
   LV/m0aBFEloot2+3IIYLLQrgeozf127Q+f6nOae2MeoUNiqNgit+mY+/c
   w==;
X-CSE-ConnectionGUID: ZaDLWfMBT92XmXfDI/PFZw==
X-CSE-MsgGUID: uUTSVEV7RAGRVGy1khIieg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="37567905"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="37567905"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:13:17 -0800
X-CSE-ConnectionGUID: xsOsT0DTRYmP2Xhx+3wfHA==
X-CSE-MsgGUID: KZRQUGdxR9qVfBXCLAARKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="117498516"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Dec 2024 16:13:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJLy4-0000Vz-2k;
	Fri, 06 Dec 2024 00:13:12 +0000
Date: Fri, 6 Dec 2024 08:12:49 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 09/11] PCI/IDE: Report available IDE streams
Message-ID: <202412060733.L2zUE7gx-lkp@intel.com>
References: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/configfs-tsm-Namespace-TSM-report-symbols/20241206-064224
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/173343744869.1074769.12345445223792172558.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH 09/11] PCI/IDE: Report available IDE streams
config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20241206/202412060733.L2zUE7gx-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412060733.L2zUE7gx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412060733.L2zUE7gx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/probe.c:597:33: warning: unused variable 'pci_host_bridge_type' [-Wunused-const-variable]
   static const struct device_type pci_host_bridge_type = {
                                   ^
   1 warning generated.


vim +/pci_host_bridge_type +597 drivers/pci/probe.c

   596	
 > 597	static const struct device_type pci_host_bridge_type = {
   598		.groups = pci_host_bridge_groups,
   599		.release = pci_release_host_bridge_dev,
   600	};
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

