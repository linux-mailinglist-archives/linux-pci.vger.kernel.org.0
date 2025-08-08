Return-Path: <linux-pci+bounces-33648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843FB1F152
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44AB14E25D7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906628DEE1;
	Fri,  8 Aug 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGa68hSC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09E28BA8C;
	Fri,  8 Aug 2025 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754696156; cv=none; b=LCIpG+LuAWUtxh8E6eoZ3vSaFTHP35dMDCvykUr8qPdic0anGC7Uy0I1xSSRawt/ATPPeSX+kp0NQasT8GZMdHCe1Y9oeqExVFsJoqD3OyzmQRqgdzQ0Mr2kgZtGxa5/yBLcX2BoixMb5JNmqY7nhu+monX1qTmSsdorc6y0rKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754696156; c=relaxed/simple;
	bh=RVqLSb5Wus76vi2wWeT+TKa7Ra1loEE3/4mGROWKk0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqRijy7TbxFsl0lYLSOQCtJDe6Y9XMgVdR/5RFBqJWfunwv6c5K8vwinEtwsAejuLkiBML84KsxpGA+DsNxEraAQ0viGL5LkyUzVRCh2/2Cw791YYHzHX2F7fHAP1NRbKHTYarNv0XBn7GAPabkDV7UHcwS4l8zwEN73VWmKLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGa68hSC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754696155; x=1786232155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RVqLSb5Wus76vi2wWeT+TKa7Ra1loEE3/4mGROWKk0s=;
  b=hGa68hSCyI7YvPsdexfgi4UUF66sDcI3kcaaN2HScyrUjfVyI9AVnNVx
   YAfYG7Lwn7zmIhR+kJvEqwAapFDJzIfvF/bBDWCTt10pc+PnF4dCrI26A
   YZFHYfXSQn6ADjpE66S+WCCK4U6mFYpCxpkh3LoNZiB1MUwP+Y2B7qWwR
   kksFwk7ZpO1IZdJKVl379HxDEDckusecnERSdZ1DY6mdZ0DQ5+XsreFSv
   LOc9wdYZCnRY9wlvlUtnSWGxZVEChkpqW0ow7+5mPXPQnNd4I2Sjz0ikp
   eNgQQizc9eGrtqnD0ouStG3VBEmLyvOIEnUyRLkmraDdueKcrBML1/zre
   Q==;
X-CSE-ConnectionGUID: 41+QxxDnS3ix3xUf4xTyig==
X-CSE-MsgGUID: OLuCFZ4gRpa7AvO7h/n64Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="44639732"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="44639732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:35:54 -0700
X-CSE-ConnectionGUID: cFlSZ0XbQGGVgdFO5f+hsA==
X-CSE-MsgGUID: YluiCMFMRVKJ3Po2psw5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164941598"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 08 Aug 2025 16:35:50 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukWcm-0004PQ-0i;
	Fri, 08 Aug 2025 23:35:48 +0000
Date: Sat, 9 Aug 2025 07:35:13 +0800
From: kernel test robot <lkp@intel.com>
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, mani@kernel.org, robh@kernel.org,
	kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Zhang <hans.zhang@cixtech.com>
Subject: Re: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into common
 and specific functions
Message-ID: <202508090739.3RYjIgG3-lkp@intel.com>
References: <20250808072929.4090694-5-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808072929.4090694-5-hans.zhang@cixtech.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 37816488247ddddbc3de113c78c83572274b1e2e]

url:    https://github.com/intel-lab-lkp/linux/commits/hans-zhang-cixtech-com/PCI-cadence-Split-PCIe-controller-header-file/20250808-154018
base:   37816488247ddddbc3de113c78c83572274b1e2e
patch link:    https://lore.kernel.org/r/20250808072929.4090694-5-hans.zhang%40cixtech.com
patch subject: [PATCH v6 04/12] PCI: cadence: Split PCIe RP support into common and specific functions
config: sparc-randconfig-001-20250809 (https://download.01.org/0day-ci/archive/20250809/202508090739.3RYjIgG3-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250809/202508090739.3RYjIgG3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508090739.3RYjIgG3-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "cdns_pcie_host_start_link" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>> ERROR: modpost: "cdns_pcie_host_dma_ranges_cmp" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>> ERROR: modpost: "bar_max_size" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>> ERROR: modpost: "cdns_pcie_host_find_min_bar" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!
>> ERROR: modpost: "cdns_pcie_host_find_max_bar" [drivers/pci/controller/cadence/pcie-cadence-host.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

