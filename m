Return-Path: <linux-pci+bounces-7406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A228C39AC
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 02:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F291280E5C
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860C5258;
	Mon, 13 May 2024 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6YLxkgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934733F9
	for <linux-pci@vger.kernel.org>; Mon, 13 May 2024 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715560950; cv=none; b=Tijj26rsyQGgkyRNoR0DKzmpDq4NMHVUsY+A9w2MRlfnlQUxVBUXthJq4Fu6pZRnOkgtKWC/SRm9KqOW0cm9w5vx4g1uDIXPhtQet4HYccbdc889tevtMOLTagtbeOnwJhoqX/asHQpOyL0P+i6vInE4gasdKBsL8I1R8ITOalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715560950; c=relaxed/simple;
	bh=RkEd0iIBFLV4QpA3WpnBVFbF+ACeM5QGih3L+fEpxF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eL6YxouJmX68fU7S+i8yYJ3SsF1vospKiJweddeEF2g09oJlEl1bMdCKFnbGsm4lHjROHN5RpVcjymf0CWgLlTjZMWnESzMTjK8Bn7Rq8+ILHMZGD+k/pEVpCgrAvlIlknhtziMdIkdHU3y4Rnso39xqYSzcLYai1yh/Te01YQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6YLxkgL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715560947; x=1747096947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RkEd0iIBFLV4QpA3WpnBVFbF+ACeM5QGih3L+fEpxF8=;
  b=R6YLxkgL2lyF4UVY787G4PqKiyb9r9wnDRj9s6YRlCzncn0fw0bHvCsi
   qWIKITv3S1Q6MJSkZFeiKiJcBTpNbBiNQSplHmg0OALsTuA6H8iWKTNmT
   /iDHrBpxnvbR8JG3vAaEten8eCeZL5gGcFPBZdDTPBMZcKOLroVambHZQ
   pS+WqcrcXXQQeex4UI70knyYgG0ifInPTcSn89bA/eQObHvHpbo6g9sJT
   /74G7LgzKGPmgLnBBy+XJQB2K9u21I3I+th5SFiaPCeYU9VR5yjLY3t+2
   hHj9YX3f78X+fo4abb5wOIhu7G0rpg/C+xpeKw555U7slddwkByoCKXSM
   Q==;
X-CSE-ConnectionGUID: ugp7L2awRTK6GWhaEtKgDg==
X-CSE-MsgGUID: ABt/reH3RSGlgUHDQf6tQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11652840"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11652840"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 17:42:27 -0700
X-CSE-ConnectionGUID: 9sAxgc+dSa+vxbUosy/ZDw==
X-CSE-MsgGUID: eDiX1TaCRgaID011z73Okw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="60993491"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2024 17:42:25 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6Jlm-0009LT-1P;
	Mon, 13 May 2024 00:42:22 +0000
Date: Mon, 13 May 2024 08:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [pci:controller/dwc 24/28] pcie-tegra194.c:undefined reference to
 `pci_epc_deinit_notify'
Message-ID: <202405130815.BwBrIepL-lkp@intel.com>
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
config: arm64-randconfig-001-20240513 (https://download.01.org/0day-ci/archive/20240513/202405130815.BwBrIepL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405130815.BwBrIepL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405130815.BwBrIepL-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/pci/controller/dwc/pcie-tegra194.o: in function `pex_ep_event_pex_rst_assert.part.0':
>> pcie-tegra194.c:(.text+0x3148): undefined reference to `pci_epc_deinit_notify'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

