Return-Path: <linux-pci+bounces-4208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A486B938
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 21:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520651C21BE9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119422334;
	Wed, 28 Feb 2024 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2RHHOez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598725E083
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153058; cv=none; b=MeFgti76Q618vOn7VM/7HnhN4eL1DckZSCGxRrsmb7I86gCfAjrutzZ22AqgyFnC0re7q09gWHQ/IBPMSGX5gvJlTVxQoZreoCooeHap54/78JESnNIdOFXK+0H84eMhUwIjl7ZVpUcXuBBfmDpILlNXZek5e6AnYOpGicGpcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153058; c=relaxed/simple;
	bh=KEtPRdS3UUm4AL6ebHiaDXrG+76oSsyiuM+cus6ru9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RVr+YO/IBw14148/jp5Hs127YKjnxs3aKlaTQS7wIjDGrLrIvqXAWXc2/tuNCNPmmFe/ECrAiVV/xjJibi+nirSBmaUzQSX0kbQu4nTeGBqViGRzRjl1UiPUA6m4WIFuIWJzUUTbJf3lqGkH8zzqLkmrhT0tqvgIw9X0ztLECbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2RHHOez; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153055; x=1740689055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KEtPRdS3UUm4AL6ebHiaDXrG+76oSsyiuM+cus6ru9c=;
  b=F2RHHOez/CjCTa3E+uPLsydqrkB0HPIbtYgQQiM5bobN8XBvlnSdZe6o
   IXPCdmdkM+lYW2hUVnIGOzyz3ODg/cvbiMy/rhZHVM8gpCq4WEAkRPqVF
   r1HmcJuAxc7gduVAFFQ3TlPnUt7AtEOVUIoTQwftQOfDQOhh1JN7zpcvi
   yk6kE1C35qDeIuXQw0eHmdWsKtdc5Ol7Yq5pV6YjPL8+Kf8dgnYZsrhQK
   rb9aJoed6T6OJzTox0jfg8SB2HtyJyqLO14ABuRFCHLfNVyT/VQGWzRhD
   0eT0n1PavIDtnBnXQuLMsl6uIxYgWMAZRVXa6QEks7oyQzsBDhHXV36jb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14730674"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14730674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12125952"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 28 Feb 2024 12:44:13 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfQmh-000CO2-0g;
	Wed, 28 Feb 2024 20:44:11 +0000
Date: Thu, 29 Feb 2024 04:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [pci:wip/2402-bjorn-osc-dpc 3/3] ld.lld: error: undefined symbol:
 pci_acpi_add_edr_notifier
Message-ID: <202402290406.HWSl4Gpp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git wip/2402-bjorn-osc-dpc
head:   d2707364343e58265d6770512fce6a3949e7c2b5
commit: d2707364343e58265d6770512fce6a3949e7c2b5 [3/3] PCI/DPC: Encapsulate pci_acpi_add_edr_notifier()
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240229/202402290406.HWSl4Gpp-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402290406.HWSl4Gpp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402290406.HWSl4Gpp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_acpi_add_edr_notifier
   >>> referenced by pci-acpi.c
   >>>               drivers/pci/pci-acpi.o:(pci_acpi_setup) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: pci_acpi_remove_edr_notifier
   >>> referenced by pci-acpi.c
   >>>               drivers/pci/pci-acpi.o:(pci_acpi_cleanup) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

