Return-Path: <linux-pci+bounces-16976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DE9CFF5C
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FBFB226B7
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF117BCA;
	Sat, 16 Nov 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIjLpmPt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A517597;
	Sat, 16 Nov 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768638; cv=none; b=SVmRjVFfqVUw4gzJe6T9U2nUU82p1cT8xR/ed52e5Q0FqEtRgGDJYEMiSmj8aPkKleTseZYC7t9CzM2nx4L0+vnePbf3bdevdfh/ciiftmjSZwXZyEAxnh5J1Fy1oRnZ3+Wd8AoXMBFJCiAAFGIHrygx7zcNn/lpityj9Ghyh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768638; c=relaxed/simple;
	bh=aNCZ64MCmt/N4DbLmTH85EEO8OSXwz2VH7eNqqs2mZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4wCTvpIM8NQOCFgxaP27dUTrOGojYe5kYqF5V6XBedviUuksppmvCHnewySzyyeItPprwVbmndN1RXeL3oBY4ggLhV5cL/AqhGuIKs/iNlRWx4rVE+Y5WCCM6MTHiKaH4+iGBC4uqDxSiLFoctAH5UA/jqkfbmkuqqEoZ/dSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIjLpmPt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731768636; x=1763304636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aNCZ64MCmt/N4DbLmTH85EEO8OSXwz2VH7eNqqs2mZ8=;
  b=EIjLpmPtW9XJVb/0Lm1FHjsrHtIBsW6QbN0wRK84qCH57RuUOWdmMIjY
   GJde51oG/Csig2ZEWrmNyBbU/qV43JGhQ+Abz4A00rg0iam2gemhvB9fg
   CTvnslJsJwjBhK+tr+s+0IZ0HjOCMRJennC9zHMUezRoOFbOzD1C4eWCI
   OWXul2cmdqAzkjoiL2UQd/TTiXbZsDj/WCj+UyRlLVOMVwqoe8iN9Z8/w
   hEDM19kUqFUvvWPb/0ffRUSvjE4GedtJO/LOcAQsgQFL93wW0UB8xTxql
   9taf77lmypC6ZNLHFQFDAp3P6PtHgzj5+PQZMXwRWfa/k3gvpH5joBxjj
   w==;
X-CSE-ConnectionGUID: dwkzLzLyRrWBT8l/s44Ssg==
X-CSE-MsgGUID: J1xqH81yQcq3Wo77Vt7JqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="49197542"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="49197542"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 06:50:36 -0800
X-CSE-ConnectionGUID: CuyfysNaStaHbS/lCrjC7g==
X-CSE-MsgGUID: 8gfPGFzsR4OOG0b7jpoc+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="88711502"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Nov 2024 06:50:31 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCK84-0000hV-1f;
	Sat, 16 Nov 2024 14:50:28 +0000
Date: Sat, 16 Nov 2024 22:49:28 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
Message-ID: <202411161334.rczGLGKY-lkp@intel.com>
References: <20241113215429.3177981-9-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113215429.3177981-9-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/PCI-AER-Introduce-struct-cxl_err_handlers-and-add-to-struct-pci_driver/20241114-060000
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241113215429.3177981-9-terry.bowman%40amd.com
patch subject: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream switch port RAS registers
config: i386-randconfig-141-20241116 (https://download.01.org/0day-ci/archive/20241116/202411161334.rczGLGKY-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241116/202411161334.rczGLGKY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411161334.rczGLGKY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/pci.c:782: warning: Excess function parameter 'host' description in 'cxl_dport_init_ras_reporting'


vim +782 drivers/cxl/core/pci.c

d1a9def33d7043 Terry Bowman   2023-10-18  775  
577a67662ff529 Li Ming        2024-08-30  776  /**
577a67662ff529 Li Ming        2024-08-30  777   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
577a67662ff529 Li Ming        2024-08-30  778   * @dport: the cxl_dport that needs to be initialized
577a67662ff529 Li Ming        2024-08-30  779   * @host: host device for devm operations
577a67662ff529 Li Ming        2024-08-30  780   */
23f51024741fc0 Terry Bowman   2024-11-13  781  void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
f05fd10d138d8b Robert Richter 2023-10-27 @782  {
23f51024741fc0 Terry Bowman   2024-11-13  783  	struct device *dport_dev = dport->dport_dev;
23f51024741fc0 Terry Bowman   2024-11-13  784  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
f05fd10d138d8b Robert Richter 2023-10-27  785  
23f51024741fc0 Terry Bowman   2024-11-13  786  	if (dport->rch && host_bridge->native_aer) {
23f51024741fc0 Terry Bowman   2024-11-13  787  		cxl_dport_map_rch_aer(dport);
23f51024741fc0 Terry Bowman   2024-11-13  788  		cxl_disable_rch_root_ints(dport);
23f51024741fc0 Terry Bowman   2024-11-13  789  	}
6c5f3aacb2963d Terry Bowman   2023-10-18  790  
23f51024741fc0 Terry Bowman   2024-11-13  791  	/* dport may have more than 1 downstream EP. Check if already mapped. */
23f51024741fc0 Terry Bowman   2024-11-13  792  	if (dport->regs.ras)
c8706cc15a5814 Li Ming        2024-08-30  793  		return;
d1a9def33d7043 Terry Bowman   2023-10-18  794  
23f51024741fc0 Terry Bowman   2024-11-13  795  	dport->reg_map.host = dport_dev;
23f51024741fc0 Terry Bowman   2024-11-13  796  	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
23f51024741fc0 Terry Bowman   2024-11-13  797  				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
23f51024741fc0 Terry Bowman   2024-11-13  798  		dev_err(dport_dev, "Failed to map RAS capability.\n");
23f51024741fc0 Terry Bowman   2024-11-13  799  		return;
f05fd10d138d8b Robert Richter 2023-10-27  800  	}
c8706cc15a5814 Li Ming        2024-08-30  801  }
577a67662ff529 Li Ming        2024-08-30  802  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
f05fd10d138d8b Robert Richter 2023-10-27  803  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

