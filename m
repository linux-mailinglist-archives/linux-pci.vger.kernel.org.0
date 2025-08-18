Return-Path: <linux-pci+bounces-34231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76DDB2B511
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB9188F259
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CF2765CA;
	Mon, 18 Aug 2025 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D89er1kI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194D26F2BE;
	Mon, 18 Aug 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560926; cv=none; b=Vs9lf6tcVa96B0dt+L3M2FpMj3krdafB16AvU5olYlJULYqX8P3eQgO2h039N9O5WW4209I7AssVOzT0XVwXoH1xVtwe1uj15DFqfKcPriWuEEvYkFyZic60UY4av1rFHURJvPQQ4sSpluB8m3dLJHBpEFzh/Hs++/lU53tRtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560926; c=relaxed/simple;
	bh=cpMG6ZE8d/ixzozIJD/dW51ppkyWuFdKh2Dd/Jc1AZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0eXCPU+RKlRMlYo3fD7/tR5Xes5PUzFCoGthquk+q93P6BTac2Sml5+rXAvAnvLECmWCiJXyR4oKuUhNFB7/6y2vB66JDyXZUcTfaaovbXarTLlRd48SBavq9wWqToOkft8Xytcy+qIur9RLGwQwUqlLHhvuvNp1lMQSb4t/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D89er1kI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755560925; x=1787096925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpMG6ZE8d/ixzozIJD/dW51ppkyWuFdKh2Dd/Jc1AZo=;
  b=D89er1kIYeKdEdPDt89ht/l+2LyUVrWsuJUEzl/IjYgpuDjOXQXB+DNE
   PsqoibBK5HmZJfcN3bn58eGTpOItpbYBwiS/PprtHK9csYtCRka7rFbQh
   cOKW1lRijl92WXV8LSMDFe1V/knA+rAZP/WgaYLO0D1FieK8xVB+zHw8/
   JaVQL4OI9nEVV8m48vSCzB7H07N6H2aiw0/7sLoY743ELgFUKE1929AtK
   BpMNNdoQ8cjFnMhJGMhnPbvqSRGWckfoeK76nMzVXwISj+T7iVwAhkmtP
   VGzl5Cn1nErh4+vBvotEi1TTTsM0gPJfKLOmXh2Xici8YzJAelkponDYT
   g==;
X-CSE-ConnectionGUID: dXGChdZeTjem4xyS+J2FUg==
X-CSE-MsgGUID: xhDxws5bRcGPxFEEktAZLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61629998"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="61629998"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 16:48:44 -0700
X-CSE-ConnectionGUID: O/eCKKPCQcm5hf6lM6MwSQ==
X-CSE-MsgGUID: ZYHv1rlXQeye6Dehu85Rqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="171942094"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2025 16:48:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uo9aB-000GJB-36;
	Mon, 18 Aug 2025 23:48:12 +0000
Date: Tue, 19 Aug 2025 07:46:58 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <202508190743.lszMYiro-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PM-OPP-Support-to-match-OPP-based-on-both-frequency-and-level/20250818-162759
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250818-opp_pcie-v2-1-071524d98967%40oss.qualcomm.com
patch subject: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both frequency and level.
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250819/202508190743.lszMYiro-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508190743.lszMYiro-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508190743.lszMYiro-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:89:
   In file included from kernel/sched/sched.h:31:
   In file included from include/linux/cpufreq.h:18:
>> include/linux/pm_opp.h:297:20: warning: no previous prototype for function 'dev_pm_opp_find_freq_level_exact' [-Wmissing-prototypes]
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         |                    ^
   include/linux/pm_opp.h:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         | ^
         | static 
   kernel/sched/core.c:2445:20: warning: unused function 'rq_has_pinned_tasks' [-Wunused-function]
    2445 | static inline bool rq_has_pinned_tasks(struct rq *rq)
         |                    ^~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:5795:20: warning: unused function 'sched_tick_stop' [-Wunused-function]
    5795 | static inline void sched_tick_stop(int cpu) { }
         |                    ^~~~~~~~~~~~~~~
   kernel/sched/core.c:6514:20: warning: unused function 'sched_core_cpu_deactivate' [-Wunused-function]
    6514 | static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:6515:20: warning: unused function 'sched_core_cpu_dying' [-Wunused-function]
    6515 | static inline void sched_core_cpu_dying(unsigned int cpu) {}
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8305:20: warning: unused function 'balance_hotplug_wait' [-Wunused-function]
    8305 | static inline void balance_hotplug_wait(void)
         |                    ^~~~~~~~~~~~~~~~~~~~
   6 warnings generated.
--
   In file included from kernel/sched/fair.c:57:
   In file included from kernel/sched/sched.h:31:
   In file included from include/linux/cpufreq.h:18:
>> include/linux/pm_opp.h:297:20: warning: no previous prototype for function 'dev_pm_opp_find_freq_level_exact' [-Wmissing-prototypes]
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         |                    ^
   include/linux/pm_opp.h:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         | ^
         | static 
   kernel/sched/fair.c:482:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
     482 | static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:503:19: warning: unused function 'tg_is_idle' [-Wunused-function]
     503 | static inline int tg_is_idle(struct task_group *tg)
         |                   ^~~~~~~~~~
   kernel/sched/fair.c:3997:20: warning: unused function 'load_avg_is_decayed' [-Wunused-function]
    3997 | static inline bool load_avg_is_decayed(struct sched_avg *sa)
         |                    ^~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6640:20: warning: unused function 'sync_throttle' [-Wunused-function]
    6640 | static inline void sync_throttle(struct task_group *tg, int cpu) {}
         |                    ^~~~~~~~~~~~~
   kernel/sched/fair.c:6664:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
    6664 | static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
         |                                     ^~~~~~~~~~~~~~~~
   kernel/sched/fair.c:6668:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
    6668 | static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:9991:20: warning: unused function 'check_misfit_status' [-Wunused-function]
     9991 | static inline bool check_misfit_status(struct rq *rq)
          |                    ^~~~~~~~~~~~~~~~~~~
   8 warnings generated.
--
   In file included from kernel/sched/build_policy.c:41:
   In file included from kernel/sched/sched.h:31:
   In file included from include/linux/cpufreq.h:18:
>> include/linux/pm_opp.h:297:20: warning: no previous prototype for function 'dev_pm_opp_find_freq_level_exact' [-Wmissing-prototypes]
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         |                    ^
   include/linux/pm_opp.h:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     297 | struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
         | ^
         | static 
   1 warning generated.


vim +/dev_pm_opp_find_freq_level_exact +297 include/linux/pm_opp.h

   296	
 > 297	struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
   298							    unsigned long freq,
   299							    unsigned int level,
   300							    bool available)
   301	{
   302		return ERR_PTR(-EOPNOTSUPP);
   303	}
   304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

