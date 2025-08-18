Return-Path: <linux-pci+bounces-34230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B3B2B50A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 01:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440DA188D6BF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BF25BEE8;
	Mon, 18 Aug 2025 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2/pq3f2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218D1F63CD;
	Mon, 18 Aug 2025 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560897; cv=none; b=KHlEopaTxtM+zshyBNDr5W2jugPwuC3OuV8fX5WQoihAi7fzJ29EsegX64KhnM0UutDIwmQohgwETluQL9ypPX2QehydsctpI5ghEMo5Zb5ph298tKNgcTrS/dlIhzm4La7D0C/pP3Y6bpsKn6A0jfx7hdCXjFy5WG/+KiMTbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560897; c=relaxed/simple;
	bh=5QJHXbNfM4211hVWMn02LsMiHN+HyA2tvURmDFJHMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNNIhuqWaHFAeJ+9JwODa7Xe7hZlRDoUqNXUyLBw+MB93uDE8HeSbExAtbRqQ2yvg05Jjk9tw0s97nqODMBknqv63BQ+B5UV+Rv32oGJvoqsgfa9abwOYExKUpxD6k42ZaK9RHyjX1as0foSnnIaNlxQSBm7bab8qxvdn+mNFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2/pq3f2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755560896; x=1787096896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5QJHXbNfM4211hVWMn02LsMiHN+HyA2tvURmDFJHMnk=;
  b=E2/pq3f20kz/lBgGfReCVZgHxDk3C2kgSQ0cdlo5rQSmlzztrDjJ+1T+
   bdX7XHT6zswXHuhGU1ZwnHIyU/cRVRb/lhPJQ2tyCxK6De9M/0sJhEi61
   dCnX1ygAq/HW5ZmOIKkGu2Nj3T+NQBOQLZ4Weu+evybOXZK57ctQvQ0ju
   i2CQ93KyxiK3o1CnKJcorJcTPj4L+CRLOXUUU0JORekCdFuoB4EfrfrIn
   CDwDbeRwLw2n+BZQz2jUZrKE8PWUuwyrHKSXm43YSLbjrcr2S2Z725iuq
   dME8ngNIkRc+DFPhGVw28uXWc2rd3vOHWyYg3FleCianN2qfumqZ9fNH+
   g==;
X-CSE-ConnectionGUID: c5P2Rh7IT5CZ//ceuDb6rA==
X-CSE-MsgGUID: aeGqJKDsS6C/bGDPAgRxWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57753016"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57753016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:48:14 -0700
X-CSE-ConnectionGUID: +pHZXG2DQViaQfHtzdVKMQ==
X-CSE-MsgGUID: E+2tP5IsQ6esRMDfksxtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="198715296"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Aug 2025 16:48:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uo9Zd-000GJ9-2N;
	Mon, 18 Aug 2025 23:47:48 +0000
Date: Tue, 19 Aug 2025 07:46:43 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <202508190712.5L4VOrmr-lkp@intel.com>
References: <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PM-OPP-Support-to-match-OPP-based-on-both-frequency-and-level/20250818-162759
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250818-opp_pcie-v2-1-071524d98967%40oss.qualcomm.com
patch subject: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both frequency and level.
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20250819/202508190712.5L4VOrmr-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508190712.5L4VOrmr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508190712.5L4VOrmr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:18,
                    from include/trace/events/power.h:8,
                    from kernel/cpu.c:42:
>> include/linux/pm_opp.h:297:20: warning: no previous prototype for 'dev_pm_opp_find_freq_level_exact' [-Wmissing-prototypes]
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   hppa-linux-ld: kernel/sched/core.o: in function `dev_pm_opp_find_freq_level_exact':
>> (.text+0xba4): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: kernel/sched/fair.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x50ac): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: kernel/sched/build_policy.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x4d44): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: kernel/sched/build_utility.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x2b44): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: kernel/power/qos.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x188): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: kernel/time/tick-common.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x164): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: fs/proc/cpuinfo.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x24): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: drivers/base/core.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0x5348): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here
   hppa-linux-ld: drivers/base/syscore.o: in function `dev_pm_opp_find_freq_level_exact':
   (.text+0xb8): multiple definition of `dev_pm_opp_find_freq_level_exact'; kernel/cpu.o:(.text+0x6a0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

