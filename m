Return-Path: <linux-pci+bounces-42141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E8C8B530
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEF6335CACC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3922330EF67;
	Wed, 26 Nov 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEUZNiIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF430BF67;
	Wed, 26 Nov 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179058; cv=none; b=cd9JIjIstwMZHKn8cjTtxaEM1W1gxYyAiCELOsogoY2pkTiF1Dqi9dtdjhPIUoYkiqb9M7seqncjEtbFJsmgK2PcCKHwtxmIh4PbX1zQl0+la9p2iZbwNm1feZ7MGUeIK88pKdWsGiBQXAqLtoql8lcbjz6+r2mxSE+kiOlMJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179058; c=relaxed/simple;
	bh=AfU72dzoQEIN05MEic99nCWprMePE4jWVDyflLUgKkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G049hvk6M0VGAKgwjQaWoUQzYgWrBqDcRKpQwt4vdfD1/Iy74vU6yom3WStkW76p28ycvbaEAJH3zUK1GTMfAkz9wlCNka3P09mMs6aeD1wcuwwqYREfTeAAuMXrJa6bb8wR8n6H4cuJRCWMGqer3KfOzEtimlMDAxEyWTsG+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEUZNiIG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764179056; x=1795715056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AfU72dzoQEIN05MEic99nCWprMePE4jWVDyflLUgKkk=;
  b=gEUZNiIGlpp8uQ5VddtDLax1xhYwsN88gOsw/w381W4csrSG4CLIKckL
   h8mGda3Hic/canRXl1IH0w8PJSMHCbbRFNPn/LUgTcl8VOSBPfyT0JSmG
   K3Qt6es94KdNOW4A5Qco993OT8LY9Ms4ljaVWY3bbMrbhMlFJb5lHHKxp
   LzeCXlHIc5+0PUnmxI6LSef8znJANkO01nUMY4dHwxWUqmQWQqkIk8Wd/
   qqibWhrw00jSPVm77TUUZiGBrpVqtqlamztkGApyBkIdphFCjbbelJNes
   J9MwgWZCz+8S5gMq9ezjPMKjKuojDQfU3GCtdsfvg9Uy4SZSn7VfeWhU0
   w==;
X-CSE-ConnectionGUID: u0Et37u0Q+aRrlYXemP90w==
X-CSE-MsgGUID: kkPh+CU+Qs+Dx7pRlcW5Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66264058"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66264058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:44:15 -0800
X-CSE-ConnectionGUID: opP1pdLNTO64iIk/2cdoTw==
X-CSE-MsgGUID: IWP9lX+tR9+QiQePNNUPKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="198113466"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2025 09:44:12 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOJYn-000000003CX-1COV;
	Wed, 26 Nov 2025 17:44:09 +0000
Date: Thu, 27 Nov 2025 01:44:03 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
Message-ID: <202511270103.uCCr0RCQ-lkp@intel.com>
References: <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam-via-B4-Relay/PCI-qcom-Parse-PERST-from-all-PCIe-bridge-nodes/20251125-002444
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251124-pci-pwrctrl-rework-v1-3-78a72627683d%40oss.qualcomm.com
patch subject: [PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
config: loongarch-randconfig-r121-20251126 (https://download.01.org/0day-ci/archive/20251127/202511270103.uCCr0RCQ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511270103.uCCr0RCQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511270103.uCCr0RCQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "of_pci_supply_present" [drivers/pci/pwrctrl/pci-pwrctrl-core.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

