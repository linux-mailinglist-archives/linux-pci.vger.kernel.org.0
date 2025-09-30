Return-Path: <linux-pci+bounces-37305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C17BAECB2
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD771942BC7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7B280023;
	Tue, 30 Sep 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfhmdW8J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AC34BA50
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275715; cv=none; b=PuBHdfgnrhENnEZrqSxg/C7/LVzn2Ow8wd/brklHLyN301+FKhEXBKgoiNnID3SQn7AV+gALq3Jz9P7gXwF1uO9xznqJBEJBcPyLz+WTEwwLNuU5elLAz9soiQNFKNLElPHUSH7qEcUfX5NrdH7IfWQ/OjsKyQWkTWsU2/sOx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275715; c=relaxed/simple;
	bh=setGPAaMl0szg+/+RCRHRq/BssOrcSKuvvbT1Y7tiuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HET3aYYkF0UTUz1LfkSKgxjyoa+zUAEUQ3pFdlGC6YFcFXF/JkPxe0jUCtjviata9//R9PnOegYPJtDcfNs/KrcurdmmOKhJVtUQW0BMhUWHEDHC7dt9EQzFzwurg+7gtxNvTU198k8F7G1SdCyJCI2HpQQ3uZz4g9dUur1D9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfhmdW8J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759275714; x=1790811714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=setGPAaMl0szg+/+RCRHRq/BssOrcSKuvvbT1Y7tiuU=;
  b=DfhmdW8J4yMFZiNt23wJBCihtfsEfubaQZv/t+ssxs9fsC1yghBjm54i
   eYIdEYRsS1idsFCDV35ZuUeDwdvXCnh6MUsrf5fklKiS2dVzamFbgB6FZ
   ypoCG7ttufJgK3Ha77X5nvMRGeCw3hsod07kuA4yrxRQPUis66ooRhtEu
   n/5vAZax1OUo9RXS+saTjQX05Rn5qFrunevuWsAbEfEaOaTCvt/NyVw20
   JJAosV+nppHr34DZAN5q3MJ3APlShEWjG+y/3KUkXwBe18F7VGFa/QDAh
   iCCP5HijtPgqQ+DqR0JSQfH8HygGjbN3N7hAc5bwB1TVGgLin2ikhdRq/
   g==;
X-CSE-ConnectionGUID: o7GMcpAmRUuonXQo004Cbw==
X-CSE-MsgGUID: s4SQrU5tSO2NknznC2iAUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60758062"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="60758062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:41:54 -0700
X-CSE-ConnectionGUID: 0EJbzPGIRFal3AHNlcA5pQ==
X-CSE-MsgGUID: IDpywVhfTau8MBoN+bkSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="183053337"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2025 16:41:52 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3jyg-0002Z9-17;
	Tue, 30 Sep 2025 23:41:50 +0000
Date: Wed, 1 Oct 2025 07:41:34 +0800
From: kernel test robot <lkp@intel.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [pci:controller/keystone 3/3] WARNING: modpost: vmlinux: section
 mismatch in reference: ks_pcie_host_init+0x148c (section:
 .text.ks_pcie_host_init) -> hook_fault_code (section: .init.text)
Message-ID: <202510010726.GPljD7FR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/keystone
head:   860daf4ba3c034995bafa4c3756942262a9cd32d
commit: 860daf4ba3c034995bafa4c3756942262a9cd32d [3/3] PCI: keystone: Remove the __init macro from non-initialization functions
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20251001/202510010726.GPljD7FR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251001/202510010726.GPljD7FR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510010726.GPljD7FR-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: ks_pcie_host_init+0x148c (section: .text.ks_pcie_host_init) -> hook_fault_code (section: .init.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

