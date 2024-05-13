Return-Path: <linux-pci+bounces-7409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE188C3A43
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 04:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDCD3B20C37
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9463C7;
	Mon, 13 May 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb8LXO2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1B8562C
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715568668; cv=none; b=b3iqRVnif+57nLiKG6mB627CqhcohmvUacYpjEqiDH0RzpYTcGmkeIYmy8kbqVF3DZJGNedK+y4y+8neXKFjWUfR7MOQpeygwsaRWbaefHb4VnM1ORRJtECd6iRcpyLl7weoC1fYbiaZaSSCYAUwaVd7vMjeyHCLzzg74J7Jd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715568668; c=relaxed/simple;
	bh=UjuC+cUD87z+htKM8aE8qC2gJ6ow9sHMwN6FUXAtm60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r8EAVOotINRIbeQzXicR+an/eIjMEtwBBf4qiFDdAUu8UaPHe0gxTU4OngPpJAMYVoZBYQzporrYIEyOnE62l6K68+urTuxRwE3XFwpyFeASCvt5EEoljIYuzmt/WxWPCGlMkhC0K/koxEdxDXynmOPgTpuUR3QgoSW6YgpvOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb8LXO2b; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715568667; x=1747104667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UjuC+cUD87z+htKM8aE8qC2gJ6ow9sHMwN6FUXAtm60=;
  b=mb8LXO2bOzf66CH7+ZoTYxoa4QEAJxw6GMCwGe/0xHZHQM4SrtaEACmt
   QvQ9Hft9vDfNYYamQInE5jJ6BsK8IihFQOBvqr2dzIOQBmDb4+NCnWxXQ
   BA8dz5lR70q3wQjOEg1LRdKaO2X4qwtyZRvcZXvcQUdol3mZYhso0ev1k
   CwB/669Bk8xEIXumswY8MlD3WKy5zNpu/nYkNSTh5D/kWA8J+u3G3xhJV
   Udp7AzEsr6vJLCWvM9hceK2L/cg4Fy0/Qr+pe3DnAWdyka/Aun/gP7H3I
   a7Eg39RIi7P/R2y09cCpwEqWAjHFOmweQNo2Y/IcVG+kVM4jYO7jMFQfu
   A==;
X-CSE-ConnectionGUID: Nx+2ptnbR4mKND7MLUhI+w==
X-CSE-MsgGUID: tGWu9ITwQIa04HWSjfcZ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11704591"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11704591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 19:49:51 -0700
X-CSE-ConnectionGUID: iWrst+VjRH6eq2TAT8FPuA==
X-CSE-MsgGUID: 0hSvXpixSTW5Z0a7GMbCwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="34615029"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 May 2024 19:49:49 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6Ll5-0009Sl-0V;
	Mon, 13 May 2024 02:49:47 +0000
Date: Mon, 13 May 2024 10:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [pci:controller/dwc 24/28] ld.lld: error: undefined symbol:
 pci_epc_deinit_notify
Message-ID: <202405131026.c0eAXgnt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc
head:   8edb2b8795b3c0496b7f2c42dc2ca7dd1ac4a76d
commit: e9f0f3b8a2e42884ca065829efe6ca93c292de22 [24/28] PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers
config: arm64-randconfig-003-20240513 (https://download.01.org/0day-ci/archive/20240513/202405131026.c0eAXgnt-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405131026.c0eAXgnt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405131026.c0eAXgnt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_epc_deinit_notify
   >>> referenced by pcie-tegra194.c
   >>>               drivers/pci/controller/dwc/pcie-tegra194.o:(pex_ep_event_pex_rst_assert) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

