Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCE6C2B76
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 08:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCUHga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUHg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 03:36:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FF34F55;
        Tue, 21 Mar 2023 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679384185; x=1710920185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w1ZF+W0g9hbiFuEgTu+ASaGNsyVN6bbhz9c5OcOHljI=;
  b=Pwj5ZsXsYbFS7fMBcNSYqqObURjWzrdbk1b9SdhaybNIscqDYHunFy9O
   OwwM781O/xShcl6yravOhd9Ahm4mlbM0ZRvS92e0Ou4beK9vRsCvp5rlq
   +dB3lRLx4xGapamYfj0YOcnEu2+EnSwR9GMYnVQZsq3RT45aAf2LY16gM
   Y/qZGKHAXOWzz72zxRmXs+094G50A+kFZRT64cMlliCaQritQUn4qhxNy
   c+XFtDJ5HpKM35cgvJsCHuE3i1VUPZX5l911xhDck4yefUIh6I1JGDFfs
   QXsb+HpftLsKNO6hrvdbd28O3vAcr6gae1tCJde4cyO7IlWcFcZ+Js8pD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322714459"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="322714459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 00:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711700213"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="711700213"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Mar 2023 00:36:19 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peWXa-000Bj8-17;
        Tue, 21 Mar 2023 07:36:18 +0000
Date:   Tue, 21 Mar 2023 15:36:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, lpieralisi@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, kw@linux.com, bhelgaas@google.com,
        vidyas@nvidia.com, sanjayc@nvidia.com, ksitaraman@nvidia.com,
        ishah@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
Subject: Re: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set
 bandwidth
Message-ID: <202303211551.eBLRqnv0-lkp@intel.com>
References: <20230320182441.11904-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320182441.11904-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sumit,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-mem-ctrl/for-next pci/next pci/for-linus]
[cannot apply to tegra/for-next rafael-pm/linux-next linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230320182441.11904-8-sumitg%40nvidia.com
patch subject: [Patch v3 07/11] cpufreq: tegra194: add OPP support and set bandwidth
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303211551.eBLRqnv0-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fa31f117302fc7c15b5d9deeefb8c650554f503d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sumit-Gupta/firmware-tegra-add-function-to-get-BPMP-data/20230321-024112
        git checkout fa31f117302fc7c15b5d9deeefb8c650554f503d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211551.eBLRqnv0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/tegra194-cpufreq.c:397:5: warning: no previous prototype for 'tegra_cpufreq_init_cpufreq_table' [-Wmissing-prototypes]
     397 | int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/tegra_cpufreq_init_cpufreq_table +397 drivers/cpufreq/tegra194-cpufreq.c

   396	
 > 397	int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
   398					     struct cpufreq_frequency_table *bpmp_lut,
   399					     struct cpufreq_frequency_table **opp_table)
   400	{
   401		struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
   402		struct cpufreq_frequency_table *freq_table = NULL;
   403		struct cpufreq_frequency_table *pos;
   404		struct device *cpu_dev;
   405		struct dev_pm_opp *opp;
   406		unsigned long rate;
   407		int ret, max_opps;
   408		int j = 0;
   409	
   410		cpu_dev = get_cpu_device(policy->cpu);
   411		if (!cpu_dev) {
   412			pr_err("%s: failed to get cpu%d device\n", __func__, policy->cpu);
   413			return -ENODEV;
   414		}
   415	
   416		/* Initialize OPP table mentioned in operating-points-v2 property in DT */
   417		ret = dev_pm_opp_of_add_table_indexed(cpu_dev, 0);
   418		if (!ret) {
   419			max_opps = dev_pm_opp_get_opp_count(cpu_dev);
   420			if (max_opps <= 0) {
   421				dev_err(cpu_dev, "Failed to add OPPs\n");
   422				return max_opps;
   423			}
   424	
   425			/* Disable all opps and cross-validate against LUT later */
   426			for (rate = 0; ; rate++) {
   427				opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
   428				if (IS_ERR(opp))
   429					break;
   430	
   431				dev_pm_opp_put(opp);
   432				dev_pm_opp_disable(cpu_dev, rate);
   433			}
   434		} else {
   435			dev_err(cpu_dev, "Invalid or empty opp table in device tree\n");
   436			data->icc_dram_bw_scaling = false;
   437			return ret;
   438		}
   439	
   440		freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_KERNEL);
   441		if (!freq_table)
   442			return -ENOMEM;
   443	
   444		/*
   445		 * Cross check the frequencies from BPMP-FW LUT against the OPP's present in DT.
   446		 * Enable only those DT OPP's which are present in LUT also.
   447		 */
   448		cpufreq_for_each_valid_entry(pos, bpmp_lut) {
   449			opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * KHZ, false);
   450			if (IS_ERR(opp))
   451				continue;
   452	
   453			ret = dev_pm_opp_enable(cpu_dev, pos->frequency * KHZ);
   454			if (ret < 0)
   455				return ret;
   456	
   457			freq_table[j].driver_data = pos->driver_data;
   458			freq_table[j].frequency = pos->frequency;
   459			j++;
   460		}
   461	
   462		freq_table[j].driver_data = pos->driver_data;
   463		freq_table[j].frequency = CPUFREQ_TABLE_END;
   464	
   465		*opp_table = &freq_table[0];
   466	
   467		dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
   468	
   469		return ret;
   470	}
   471	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
