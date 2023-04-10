Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D9C6DC3C9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDJHZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDJHZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 03:25:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271B3AB3;
        Mon, 10 Apr 2023 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681111521; x=1712647521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8FC/BfVa04LNe6x9xGRVjTagWe8e1Y6VfA8cIDMTxKo=;
  b=F++Dpp7/Zs8HUOpIzsMl3t3d4sIbYKddVlYdC2DEoEZA2qkyrLoN5i0A
   J3M0FwOM15e4HzyGmNMg0Z3cMpTjBBktwVWrsHLZydaw+IHv0bclACs/B
   sZhvxJCMhcis7ukzibNHE6dmVv2WmVTPm3Yn7r8vXtnefiR5wTmHzjVWo
   Qf01eKGioGKwftPMIx3d/0Vx02qgcRuqgVpj77crDPcmY1e6SHG7PVSqS
   RiIKhm2adlUvcGxwnnaAtzfQR9p7LSotNvu+OIjvxWOPRrA2qbXZ/KKFQ
   oOb71G/lf+GhoR25McxXnsWQlJcBU0F8FFs7+1u/khYSi4pE072tkpaYf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="322937895"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="322937895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 00:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="799420882"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799420882"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 00:25:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pllts-000VCr-1m;
        Mon, 10 Apr 2023 07:25:16 +0000
Date:   Mon, 10 Apr 2023 15:25:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org, Jonathan.Cameron@huawei.com
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: Re: [PATCH v2 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <202304101501.5weSAuW5-lkp@intel.com>
References: <20230410031702.68355-3-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410031702.68355-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shuai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.3-rc6 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/drivers-perf-add-DesignWare-PCIe-PMU-driver/20230410-121727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230410031702.68355-3-xueshuai%40linux.alibaba.com
patch subject: [PATCH v2 2/3] drivers/perf: add DesignWare PCIe PMU driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230410/202304101501.5weSAuW5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/279673b15957e3ea9c14fded1e41a861a6d8b2d9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shuai-Xue/drivers-perf-add-DesignWare-PCIe-PMU-driver/20230410-121727
        git checkout 279673b15957e3ea9c14fded1e41a861a6d8b2d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304101501.5weSAuW5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/dwc_pcie_pmu.c:195:9: warning: no previous prototype for 'dwc_pcie_event_show' [-Wmissing-prototypes]
     195 | ssize_t dwc_pcie_event_show(struct device *dev,
         |         ^~~~~~~~~~~~~~~~~~~


vim +/dwc_pcie_event_show +195 drivers/perf/dwc_pcie_pmu.c

   194	
 > 195	ssize_t dwc_pcie_event_show(struct device *dev,
   196					struct device_attribute *attr, char *page)
   197	{
   198		struct dwc_pcie_event_attr *eattr;
   199	
   200		eattr = container_of(attr, typeof(*eattr), attr);
   201	
   202		if (eattr->type == DWC_PCIE_LANE_EVENT)
   203			return sprintf(page, "eventid=0x%lx, type=0x%lx, lane=0x%lx\n",
   204				       (unsigned long)eattr->eventid,
   205				       (unsigned long)eattr->type,
   206				       (unsigned long)eattr->lane);
   207		else
   208			return sprintf(page, "eventid=0x%lx, type=0x%lx",
   209				       (unsigned long)eattr->eventid,
   210				       (unsigned long)eattr->type);
   211	}
   212	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
