Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4D4FE5F8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351032AbiDLQjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbiDLQju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 12:39:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2858D1BEAE;
        Tue, 12 Apr 2022 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649781452; x=1681317452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wj0yrMFXTVEP2FQ3yo1uRXtjbGOZh1hRn5IaONNHOKY=;
  b=iDsMBCyprQZapmfQFZ6MXDTEj1gjASnDZMMGdWsugUeZluMEjXuhKISA
   bCcJiGqaYHwq4510OobNV3QSmj8MXLd1k7U61waT0P98v7gRSGb9p0yEq
   cWPY8znIfY0oAIAC8JrtqtmQNhTS0etfEAMNVobJ2r0rVQf5pRpRxVMlE
   L/5BUiueoY/URQI+2rMjOyXusAZ0lPdJy58Nndv3vVKiDu9yb7zMnl74n
   OBu9ut5Xv4b77EI8ggXasoppU0yl0YAXJOLzuX4K4RSWma4oaTFs9WnTP
   7WI2Mv0KfkzocuQaXspJpaHpgvBA/dWz0+Md3PvPIxkWVzF0eK0cmjzSt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249715223"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="249715223"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="854434666"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2022 09:29:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neJOR-0002zn-2b;
        Tue, 12 Apr 2022 16:29:27 +0000
Date:   Wed, 13 Apr 2022 00:28:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: Move jailhouse's isolated function handling
 to pci_scan_slot()
Message-ID: <202204130045.AeSigvk8-lkp@intel.com>
References: <20220412143040.1882096-3-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412143040.1882096-3-schnelle@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on helgaas-pci/next]
[also build test WARNING on s390/features tip/x86/core v5.18-rc2 next-20220412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Niklas-Schnelle/PCI-Rework-pci_scan_slot-and-isolated-PCI-functions/20220412-223307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220413/202204130045.AeSigvk8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5cac6729750b7434ff5d6ae99469e9e54bc9fb6e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Niklas-Schnelle/PCI-Rework-pci_scan_slot-and-isolated-PCI-functions/20220412-223307
        git checkout 5cac6729750b7434ff5d6ae99469e9e54bc9fb6e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pci/probe.c: In function 'pci_scan_child_bus_extend':
>> drivers/pci/probe.c:2861:13: warning: variable 'nr_devs' set but not used [-Wunused-but-set-variable]
    2861 |         int nr_devs;
         |             ^~~~~~~


vim +/nr_devs +2861 drivers/pci/probe.c

bccf90d6e063d2 Palmer Dabbelt  2017-06-23  2841  
1c02ea81006548 Mika Westerberg 2017-10-13  2842  /**
1c02ea81006548 Mika Westerberg 2017-10-13  2843   * pci_scan_child_bus_extend() - Scan devices below a bus
1c02ea81006548 Mika Westerberg 2017-10-13  2844   * @bus: Bus to scan for devices
1c02ea81006548 Mika Westerberg 2017-10-13  2845   * @available_buses: Total number of buses available (%0 does not try to
1c02ea81006548 Mika Westerberg 2017-10-13  2846   *		     extend beyond the minimal)
1c02ea81006548 Mika Westerberg 2017-10-13  2847   *
1c02ea81006548 Mika Westerberg 2017-10-13  2848   * Scans devices below @bus including subordinate buses. Returns new
1c02ea81006548 Mika Westerberg 2017-10-13  2849   * subordinate number including all the found devices. Passing
1c02ea81006548 Mika Westerberg 2017-10-13  2850   * @available_buses causes the remaining bus space to be distributed
1c02ea81006548 Mika Westerberg 2017-10-13  2851   * equally between hotplug-capable bridges to allow future extension of the
1c02ea81006548 Mika Westerberg 2017-10-13  2852   * hierarchy.
1c02ea81006548 Mika Westerberg 2017-10-13  2853   */
1c02ea81006548 Mika Westerberg 2017-10-13  2854  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
1c02ea81006548 Mika Westerberg 2017-10-13  2855  					      unsigned int available_buses)
1c02ea81006548 Mika Westerberg 2017-10-13  2856  {
1c02ea81006548 Mika Westerberg 2017-10-13  2857  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
1c02ea81006548 Mika Westerberg 2017-10-13  2858  	unsigned int start = bus->busn_res.start;
5cac6729750b74 Niklas Schnelle 2022-04-12  2859  	unsigned int devfn, cmax, max = start;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2860  	struct pci_dev *dev;
690f4304104f37 Jan Kiszka      2018-03-07 @2861  	int nr_devs;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2862  
0207c356ef0e2b Bjorn Helgaas   2009-11-04  2863  	dev_dbg(&bus->dev, "scanning bus\n");
^1da177e4c3f41 Linus Torvalds  2005-04-16  2864  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2865  	/* Go find them, Rover! */
5cac6729750b74 Niklas Schnelle 2022-04-12  2866  	for (devfn = 0; devfn < 256; devfn += 8)
690f4304104f37 Jan Kiszka      2018-03-07  2867  		nr_devs = pci_scan_slot(bus, devfn);
690f4304104f37 Jan Kiszka      2018-03-07  2868  
3e466e2d3a04c7 Bjorn Helgaas   2017-11-30  2869  	/* Reserve buses for SR-IOV capability */
1c02ea81006548 Mika Westerberg 2017-10-13  2870  	used_buses = pci_iov_bus_range(bus);
1c02ea81006548 Mika Westerberg 2017-10-13  2871  	max += used_buses;
a28724b0fb909d Yu Zhao         2009-03-20  2872  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2873  	/*
^1da177e4c3f41 Linus Torvalds  2005-04-16  2874  	 * After performing arch-dependent fixup of the bus, look behind
^1da177e4c3f41 Linus Torvalds  2005-04-16  2875  	 * all PCI-to-PCI bridges on this bus.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2876  	 */
74710ded8e16fc Alex Chiang     2009-03-20  2877  	if (!bus->is_added) {
0207c356ef0e2b Bjorn Helgaas   2009-11-04  2878  		dev_dbg(&bus->dev, "fixups for bus\n");
^1da177e4c3f41 Linus Torvalds  2005-04-16  2879  		pcibios_fixup_bus(bus);
74710ded8e16fc Alex Chiang     2009-03-20  2880  		bus->is_added = 1;
74710ded8e16fc Alex Chiang     2009-03-20  2881  	}
74710ded8e16fc Alex Chiang     2009-03-20  2882  
1c02ea81006548 Mika Westerberg 2017-10-13  2883  	/*
1c02ea81006548 Mika Westerberg 2017-10-13  2884  	 * Calculate how many hotplug bridges and normal bridges there
1c02ea81006548 Mika Westerberg 2017-10-13  2885  	 * are on this bus. We will distribute the additional available
1c02ea81006548 Mika Westerberg 2017-10-13  2886  	 * buses between hotplug bridges.
1c02ea81006548 Mika Westerberg 2017-10-13  2887  	 */
1c02ea81006548 Mika Westerberg 2017-10-13  2888  	for_each_pci_bridge(dev, bus) {
1c02ea81006548 Mika Westerberg 2017-10-13  2889  		if (dev->is_hotplug_bridge)
1c02ea81006548 Mika Westerberg 2017-10-13  2890  			hotplug_bridges++;
1c02ea81006548 Mika Westerberg 2017-10-13  2891  		else
1c02ea81006548 Mika Westerberg 2017-10-13  2892  			normal_bridges++;
1c02ea81006548 Mika Westerberg 2017-10-13  2893  	}
1c02ea81006548 Mika Westerberg 2017-10-13  2894  
4147c2fd9b12ae Mika Westerberg 2017-10-13  2895  	/*
4147c2fd9b12ae Mika Westerberg 2017-10-13  2896  	 * Scan bridges that are already configured. We don't touch them
4147c2fd9b12ae Mika Westerberg 2017-10-13  2897  	 * unless they are misconfigured (which will be done in the second
4147c2fd9b12ae Mika Westerberg 2017-10-13  2898  	 * scan below).
4147c2fd9b12ae Mika Westerberg 2017-10-13  2899  	 */
1c02ea81006548 Mika Westerberg 2017-10-13  2900  	for_each_pci_bridge(dev, bus) {
1c02ea81006548 Mika Westerberg 2017-10-13  2901  		cmax = max;
1c02ea81006548 Mika Westerberg 2017-10-13  2902  		max = pci_scan_bridge_extend(bus, dev, max, 0, 0);
3374c545c27c53 Mika Westerberg 2018-05-28  2903  
3374c545c27c53 Mika Westerberg 2018-05-28  2904  		/*
3374c545c27c53 Mika Westerberg 2018-05-28  2905  		 * Reserve one bus for each bridge now to avoid extending
3374c545c27c53 Mika Westerberg 2018-05-28  2906  		 * hotplug bridges too much during the second scan below.
3374c545c27c53 Mika Westerberg 2018-05-28  2907  		 */
3374c545c27c53 Mika Westerberg 2018-05-28  2908  		used_buses++;
3374c545c27c53 Mika Westerberg 2018-05-28  2909  		if (cmax - max > 1)
3374c545c27c53 Mika Westerberg 2018-05-28  2910  			used_buses += cmax - max - 1;
1c02ea81006548 Mika Westerberg 2017-10-13  2911  	}
4147c2fd9b12ae Mika Westerberg 2017-10-13  2912  
4147c2fd9b12ae Mika Westerberg 2017-10-13  2913  	/* Scan bridges that need to be reconfigured */
1c02ea81006548 Mika Westerberg 2017-10-13  2914  	for_each_pci_bridge(dev, bus) {
1c02ea81006548 Mika Westerberg 2017-10-13  2915  		unsigned int buses = 0;
1c02ea81006548 Mika Westerberg 2017-10-13  2916  
1c02ea81006548 Mika Westerberg 2017-10-13  2917  		if (!hotplug_bridges && normal_bridges == 1) {
3e466e2d3a04c7 Bjorn Helgaas   2017-11-30  2918  
1c02ea81006548 Mika Westerberg 2017-10-13  2919  			/*
1c02ea81006548 Mika Westerberg 2017-10-13  2920  			 * There is only one bridge on the bus (upstream
1c02ea81006548 Mika Westerberg 2017-10-13  2921  			 * port) so it gets all available buses which it
1c02ea81006548 Mika Westerberg 2017-10-13  2922  			 * can then distribute to the possible hotplug
1c02ea81006548 Mika Westerberg 2017-10-13  2923  			 * bridges below.
1c02ea81006548 Mika Westerberg 2017-10-13  2924  			 */
1c02ea81006548 Mika Westerberg 2017-10-13  2925  			buses = available_buses;
1c02ea81006548 Mika Westerberg 2017-10-13  2926  		} else if (dev->is_hotplug_bridge) {
3e466e2d3a04c7 Bjorn Helgaas   2017-11-30  2927  
1c02ea81006548 Mika Westerberg 2017-10-13  2928  			/*
1c02ea81006548 Mika Westerberg 2017-10-13  2929  			 * Distribute the extra buses between hotplug
1c02ea81006548 Mika Westerberg 2017-10-13  2930  			 * bridges if any.
1c02ea81006548 Mika Westerberg 2017-10-13  2931  			 */
1c02ea81006548 Mika Westerberg 2017-10-13  2932  			buses = available_buses / hotplug_bridges;
3374c545c27c53 Mika Westerberg 2018-05-28  2933  			buses = min(buses, available_buses - used_buses + 1);
1c02ea81006548 Mika Westerberg 2017-10-13  2934  		}
1c02ea81006548 Mika Westerberg 2017-10-13  2935  
1c02ea81006548 Mika Westerberg 2017-10-13  2936  		cmax = max;
1c02ea81006548 Mika Westerberg 2017-10-13  2937  		max = pci_scan_bridge_extend(bus, dev, cmax, buses, 1);
3374c545c27c53 Mika Westerberg 2018-05-28  2938  		/* One bus is already accounted so don't add it again */
3374c545c27c53 Mika Westerberg 2018-05-28  2939  		if (max - cmax > 1)
3374c545c27c53 Mika Westerberg 2018-05-28  2940  			used_buses += max - cmax - 1;
1c02ea81006548 Mika Westerberg 2017-10-13  2941  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2942  
e16b46605960bd Keith Busch     2016-07-21  2943  	/*
e16b46605960bd Keith Busch     2016-07-21  2944  	 * Make sure a hotplug bridge has at least the minimum requested
1c02ea81006548 Mika Westerberg 2017-10-13  2945  	 * number of buses but allow it to grow up to the maximum available
1c02ea81006548 Mika Westerberg 2017-10-13  2946  	 * bus number of there is room.
e16b46605960bd Keith Busch     2016-07-21  2947  	 */
1c02ea81006548 Mika Westerberg 2017-10-13  2948  	if (bus->self && bus->self->is_hotplug_bridge) {
1c02ea81006548 Mika Westerberg 2017-10-13  2949  		used_buses = max_t(unsigned int, available_buses,
1c02ea81006548 Mika Westerberg 2017-10-13  2950  				   pci_hotplug_bus_size - 1);
1c02ea81006548 Mika Westerberg 2017-10-13  2951  		if (max - start < used_buses) {
1c02ea81006548 Mika Westerberg 2017-10-13  2952  			max = start + used_buses;
a20c7f36bd3d20 Mika Westerberg 2017-10-13  2953  
a20c7f36bd3d20 Mika Westerberg 2017-10-13  2954  			/* Do not allocate more buses than we have room left */
a20c7f36bd3d20 Mika Westerberg 2017-10-13  2955  			if (max > bus->busn_res.end)
a20c7f36bd3d20 Mika Westerberg 2017-10-13  2956  				max = bus->busn_res.end;
1c02ea81006548 Mika Westerberg 2017-10-13  2957  
1c02ea81006548 Mika Westerberg 2017-10-13  2958  			dev_dbg(&bus->dev, "%pR extended by %#02x\n",
1c02ea81006548 Mika Westerberg 2017-10-13  2959  				&bus->busn_res, max - start);
1c02ea81006548 Mika Westerberg 2017-10-13  2960  		}
e16b46605960bd Keith Busch     2016-07-21  2961  	}
e16b46605960bd Keith Busch     2016-07-21  2962  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2963  	/*
^1da177e4c3f41 Linus Torvalds  2005-04-16  2964  	 * We've scanned the bus and so we know all about what's on
^1da177e4c3f41 Linus Torvalds  2005-04-16  2965  	 * the other side of any bridges that may be on this bus plus
^1da177e4c3f41 Linus Torvalds  2005-04-16  2966  	 * any devices.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2967  	 *
^1da177e4c3f41 Linus Torvalds  2005-04-16  2968  	 * Return how far we've got finding sub-buses.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2969  	 */
0207c356ef0e2b Bjorn Helgaas   2009-11-04  2970  	dev_dbg(&bus->dev, "bus scan returning with max=%02x\n", max);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2971  	return max;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2972  }
1c02ea81006548 Mika Westerberg 2017-10-13  2973  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
