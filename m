Return-Path: <linux-pci+bounces-29858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F362ADB01A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A116DE38
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418A2E427F;
	Mon, 16 Jun 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrDVamlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00503800;
	Mon, 16 Jun 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750076527; cv=none; b=KZm5IoQ4i9kM6bBt+ezJq26C9qRlgSY8D3NstQaFn0mi8kYSMJFBgyJNg1dHI3Mcu+SKNXiU297YrJMnxGWWO1jgO7UKkYxTiEl8EpUDhFxpNyU51ElaXgQZwB09xiBkGP6qZ2ZSms1D6NMhTXTise6PpCrLUsekLyn+PozElL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750076527; c=relaxed/simple;
	bh=mlk51EUaFTM60JuowPd7x+Uze/JnxYqKzWvV92wf+a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUqHVfcbEJRT3knOZkqufzlee41d0QkISJxDy8eO/cwVpaF5nV96rHXADZVYUAar5gtytq5mg2EZaiQqQdm8vFUbcwIRiqiqi6XopWbHGgaiZXNASySll2YTCk43Vs5GlIMTFSzl4N2sR0qwsueJ9aTzQ7cNvXGbknxfcV4KUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrDVamlS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750076524; x=1781612524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mlk51EUaFTM60JuowPd7x+Uze/JnxYqKzWvV92wf+a8=;
  b=YrDVamlStZhruQUfrA8oXBxThFqGz3s9wPA6QEHVkW5HsYsa5i85VuM9
   8l7mVRpUx09ebBkrF5VIc+oWsnk/zNWdNEm9N/Q6DWAFs0DKACgUS/+oV
   8F9LyUi13KfoZhLV/YuO5vDeS/PzPko7doVVFd0yZytm9JPRr0Lf3EPK3
   cM+9kfvp61pk3sTcV7Fd6mGqUSzp3ECvHTC35RSwmsdpYYC7XGbi43GaF
   EEJi4Ice8yTtvPnN9VvIRRx0sCm2UALZlfOGPjckQarWzXYSOHd6m2gbl
   EVlzWQlIOfCVcOKgiMoH+vnA0eSk7hrnzC3oGZDvQA3IF/m09j0BKuqs5
   g==;
X-CSE-ConnectionGUID: ZfcNp8fGTkOmqlAXtNwv1g==
X-CSE-MsgGUID: Qd/6Z16PTKmRryDb/vm53g==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63566996"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="63566996"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 05:22:03 -0700
X-CSE-ConnectionGUID: yg6Y5f6KQHy9iP2vfGCZXA==
X-CSE-MsgGUID: KxVsMkQqQ0KgpYB+zIg9GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="153224360"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Jun 2025 05:22:01 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uR8qd-000F0e-06;
	Mon, 16 Jun 2025 12:21:59 +0000
Date: Mon, 16 Jun 2025 20:21:20 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	brgl@bgdev.pl
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lukas@wunner.de,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <202506162013.go7YyNYL-lkp@intel.com>
References: <20250616053209.13045-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616053209.13045-1-mani@kernel.org>

Hi Manivannan,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.16-rc2 next-20250616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/PCI-pwrctrl-Move-pci_pwrctrl_create_device-definition-to-drivers-pci-pwrctrl/20250616-133314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20250616053209.13045-1-mani%40kernel.org
patch subject: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device() definition to drivers/pci/pwrctrl/
config: i386-buildonly-randconfig-001-20250616 (https://download.01.org/0day-ci/archive/20250616/202506162013.go7YyNYL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250616/202506162013.go7YyNYL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506162013.go7YyNYL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/probe.o: in function `pci_scan_single_device':
>> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

