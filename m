Return-Path: <linux-pci+bounces-39331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD9C0A227
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 04:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BF03B30E3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 03:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36C1DE8BF;
	Sun, 26 Oct 2025 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhlX70SR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E451547EE
	for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761448785; cv=none; b=dlQeRH6Lz7kSq3uVubwAg0J75mrHUgurQcFR6Azg2YEytcUKOqT5600BpEjrrpLOce7VlXLFwV23RTP83/ImUZ0CnUjUE7CUGSYqtOXyUKqURq8rITaRMQaeHB8LMdB6zTzwqvnAQZuPbyh6Hydi/7KKLmTks6VH6U5sWz7HGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761448785; c=relaxed/simple;
	bh=jhvetm3H87iUHHYE09iE2tTkdfLH4FBYut7SC7D/hOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Phu+fW7UxiADrzLDuSeTTQ4BCY/oi1jG1E9TbG8eVL9aeOxr/8s/BQEqg8hqfqiCsEEiFLb4xnOBEHvwogPtPOEhgz37a7x0byC68bV6XUeXqKgZD8e9qZ2LQf5ID8ysihNeKc92ZR1qKant8ozUwy3uSfuFGQ9k3wtuo+NqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhlX70SR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761448784; x=1792984784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhvetm3H87iUHHYE09iE2tTkdfLH4FBYut7SC7D/hOE=;
  b=AhlX70SRHkLhBf+JLkFKU5pZ7evyXw6cbrwgat8fObxse7Iu0BnwLVxl
   YQrB7eNMuRgoehQT5QRS2UwbY5IZm9qf3aqV4ChCBj7QS3XztTFzvPF7a
   1eppVHSzsZdINqUbIcQ5zd1RhfeMT02hui0sQmUiWpS8C3RMxgpMxcShd
   VEVnWEMyH1JCMI2PKLjbxVqSpY2kU4jJQwaRa/hey1FdNsNKCNAnuJ9CJ
   LGNDkXmI/5QzP+wdhyHBOX7OqLED5pXWEAYZV9C8SvdPKExt5gmW5sp/l
   S+PrLVUrO2asLPzk3ZMizUBBVal21Fdrk+8HB08lY8MWqooaU9Stcbiw4
   Q==;
X-CSE-ConnectionGUID: iH8U1mxCRceXH7k+rILu8Q==
X-CSE-MsgGUID: 2Mc1mf8PSeuDc7LxruQ68g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63721831"
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="63721831"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 20:19:43 -0700
X-CSE-ConnectionGUID: WMg552D4S/69sqbZS06q2g==
X-CSE-MsgGUID: Ehc/Y636SfmRDkXjhYQwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="183960472"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 25 Oct 2025 20:19:40 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCrIA-000Fqv-0e;
	Sun, 26 Oct 2025 03:19:38 +0000
Date: Sun, 26 Oct 2025 11:18:35 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, aik@amd.com,
	yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, gregkh@linuxfoundation.org,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
Subject: Re: [PATCH v7 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
Message-ID: <202510261309.SZsIB3mq-lkp@intel.com>
References: <20251024020418.1366664-5-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024020418.1366664-5-dan.j.williams@intel.com>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 211ddde0823f1442e4ad052a2f30f050145ccada]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/coco-tsm-Introduce-a-core-device-for-TEE-Security-Managers/20251024-100622
base:   211ddde0823f1442e4ad052a2f30f050145ccada
patch link:    https://lore.kernel.org/r/20251024020418.1366664-5-dan.j.williams%40intel.com
patch subject: [PATCH v7 4/9] PCI/TSM: Establish Secure Sessions and Link Encryption
config: i386-randconfig-005-20251025 (https://download.01.org/0day-ci/archive/20251026/202510261309.SZsIB3mq-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261309.SZsIB3mq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510261309.SZsIB3mq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: find_tsm_dev
   >>> referenced by tsm.c:257 (drivers/pci/tsm.c:257)
   >>>               drivers/pci/tsm.o:(connect_store) in archive vmlinux.a
   >>> did you mean: find_dsm_dev
   >>> defined in: vmlinux.a(drivers/pci/tsm.o)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for TSM
   Depends on [n]: VIRT_DRIVERS [=n]
   Selected by [y]:
   - PCI_TSM [=y] && PCI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

