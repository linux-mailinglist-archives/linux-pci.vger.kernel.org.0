Return-Path: <linux-pci+bounces-4207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8136C86B89C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219011F291BA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1A5E081;
	Wed, 28 Feb 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5aNSxrE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF95E063
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149935; cv=none; b=Iwn/JCAN4j54JBSwvwqm+bt9laauJ+0iQGAbIY9XTv2VQgF8W6bRUozn3eRJXEGWTEec1/GD6CCUR+BVK+RptNMwP6ueJdh3+PsuxHABFUwYHADw8RO1+Fd5V2k+2G5tJr1sEDdZzuy9q3c/5piSmJypgcod0kdIZsoM8TIsA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149935; c=relaxed/simple;
	bh=K3qgz/u3p9iFTsfNzdD4LzVHFhsvppg27jeS6tzkNpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gq5cGd7fYt+g68rFsr6UCJBz2U+hCJJsr55iAV+X0if5brbI95QXSIapDBP6uHAy2GlRCqdR4wUim2R7GSySlGKtxHu12HqWN3ST6s6cz/FPsGQipy+36iTxwUa5ZGTEP2kpYJSuJgubg/i3NCPsZQ1VgdwZECJaLATCrZZcpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5aNSxrE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149933; x=1740685933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K3qgz/u3p9iFTsfNzdD4LzVHFhsvppg27jeS6tzkNpo=;
  b=G5aNSxrEKdmjwCB9MYzAQmPjAQ9samc0aQcJhly3ceWBIWNrUEi+xEU+
   r1GPx7b7nwGzUpYRTu5T0B0HD3yjfODte51HPmaSVU1PTGDM0Iw/mstWW
   pAZtnsUehwO/MTXwcRtb3f7rtYQEAqAC5Fv0aOYRbUCDCCIE7RQBt/A8H
   muS/zCJbtiZPW/y9BH9kawVUQHuSqmsZcrbD3l+xOAM39Jq9NqqWwzNZF
   aGzPzEew6/5X2XJQ6bKGvFYHvFIMeRbTZLC2LFoOBy0h83OIUcqz2VQEd
   PKx5I799L0lFPJtjFvnv5o/USj6LViu13I2dMoEsbxx76zCVevhaAou8L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7358940"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7358940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="38579308"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2024 11:52:07 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfPyG-000CMF-1d;
	Wed, 28 Feb 2024 19:52:04 +0000
Date: Thu, 29 Feb 2024 03:51:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: [pci:wip/2402-bjorn-osc-dpc 3/3] pci-acpi.c:undefined reference to
 `pci_acpi_add_edr_notifier'
Message-ID: <202402290357.5h9Npoa3-lkp@intel.com>
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
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20240229/202402290357.5h9Npoa3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402290357.5h9Npoa3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402290357.5h9Npoa3-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/pci-acpi.o: in function `.L441':
>> pci-acpi.c:(.text+0x1680): undefined reference to `pci_acpi_add_edr_notifier'
   loongarch64-linux-ld: drivers/pci/pci-acpi.o: in function `pci_acpi_cleanup':
>> pci-acpi.c:(.text+0x17e0): undefined reference to `pci_acpi_remove_edr_notifier'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

