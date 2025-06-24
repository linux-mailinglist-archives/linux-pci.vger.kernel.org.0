Return-Path: <linux-pci+bounces-30472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC8AE5A16
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 04:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BB64C1725
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255E204C36;
	Tue, 24 Jun 2025 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN9qdWgY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F31DFE12;
	Tue, 24 Jun 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750732159; cv=none; b=lR0JHaLnQjZnvNxBSr3k9o2C/vp6wNQPc+mE7ozYmGtqFLA82mr0PhwMYqmzp88DRRRFUHDZLjCeh/6kUmjXUWMPltA/WwSRH7lOxjgb8y/OaXPYltCGKh//S7dl1x80PMZykgcpEJP9ScWuZBBzAxJ4LS9yJPXClFuLrwB1qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750732159; c=relaxed/simple;
	bh=aCq7pU8kNb4mHcl6rtEIZfZyJWT3bMbgZHNQ3Cyafh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPjf5pRhd52OzssruU8yPmgmkdIk25dZrCs5/dSLKITvAGXiUzR8jttFDCLzV5txCxLfXK27je4zmobLpQw0SHBli+Ofs/6lAZJZIuqt0+ljKAWm2Wz4ssmdIkObGd6CFo229RRlpNMYT5VDoAO+bhgmp12R3G5dU8JkGyPbbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN9qdWgY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750732158; x=1782268158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCq7pU8kNb4mHcl6rtEIZfZyJWT3bMbgZHNQ3Cyafh4=;
  b=DN9qdWgYVaPlRxSQCVP/G9AzezzZR+CeW7E3r1ZaHdjOLzac4ffSuPib
   V4eWZGQeIPQTjmCi2imaWksKmaZPmjUPfIBev93YGe5raA/usuN5delcM
   MBOcxRAaQljl1NIE3akWaLv03bEO5Mw7Edt1CE9NIw1DKIU9besEanR7U
   6M12+Fypr4S20ZWCBa4HgAIEAeObyXNTkkbq7ceVE9ycZl9UFOefhoO3T
   X9GOT71mCsTSFqeWnBvmjawAYLf7f+9RnTUPP14sFBSHSRTwK70098fkP
   4bxAHlQA8jVYUyx4hcipo0504aI9k7yAX7mIBy97zm6/VXHc7EmM/RBm0
   g==;
X-CSE-ConnectionGUID: AYELB+vNSEKptdvvDNFABw==
X-CSE-MsgGUID: +GWRGvdzTC6/IW/eCFSskg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56629117"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56629117"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 19:29:17 -0700
X-CSE-ConnectionGUID: yMfGDS/9QleenYCj1nIOxw==
X-CSE-MsgGUID: KnB9MCWvQ7y/CioVZQ06Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="182808464"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2025 19:29:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTtPK-000Rdi-1a;
	Tue, 24 Jun 2025 02:29:10 +0000
Date: Tue, 24 Jun 2025 10:29:09 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com, sai.krishna.musham@amd.com
Subject: Re: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <202506241020.rPD1a2Vr-lkp@intel.com>
References: <20250618080931.2472366-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618080931.2472366-3-sai.krishna.musham@amd.com>

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.16-rc3 next-20250623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Krishna-Musham/dt-bindings-PCI-amd-mdb-Add-reset-gpios-property-for-PCIe-RP-PERST-handling/20250618-161100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250618080931.2472366-3-sai.krishna.musham%40amd.com
patch subject: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal handling
config: csky-randconfig-002-20250621 (https://download.01.org/0day-ci/archive/20250624/202506241020.rPD1a2Vr-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506241020.rPD1a2Vr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/pci/controller/dwc/pcie-amd-mdb.c:68 struct member 'perst_gpio' not described in 'amd_mdb_pcie'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

