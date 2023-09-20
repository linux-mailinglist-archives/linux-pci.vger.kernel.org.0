Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78007A70C2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 05:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjITDAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 23:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjITDAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 23:00:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C1C6;
        Tue, 19 Sep 2023 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695178843; x=1726714843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSL99h1syLWVif7Chcbad4B1xPqXmzezMeLKDzPTmvM=;
  b=FkcZEP17vH+JQO1NngYOQq+Feimniydz/rtZuOhzX+WSvJzua7hswEd+
   o3U2y2Sl7ivjoVrW/6HAo54/KN0jbSWKOFhM0wLKVQ2KA4/P84mpgYqxs
   PDBp0RdDL67o0awKQAiZKsN0VZTsRRMRtGo5AidT7QokWw+gn+ltCdxN7
   M+EHPxyLWvQMVgKo+xBi4JAdc3UfA195E2ob7IL/hCIlTYNbkYVJHp9RW
   FR6/XrmmExKOSKug/BDVJAs4WANquXDWXe0sWbcEYAMoTm8Pmzbw9vvmm
   N3oNK51AnO+SM88IHa8g/RJF8R6fn2ObmCp/nmJMXH7XSMmas8hvX+kyn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="378999145"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="378999145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 20:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="889737344"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="889737344"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2023 19:59:52 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qinS9-0008Co-08;
        Wed, 20 Sep 2023 03:00:37 +0000
Date:   Wed, 20 Sep 2023 10:59:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     shiju.jose@huawei.com, helgaas@kernel.org, rafael@kernel.org,
        lenb@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        bp@alien8.de, ying.huang@intel.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        prime.zeng@hisilicon.com, shiju.jose@huawei.com
Subject: Re: [PATCH v2 1/1] ACPI / APEI: Fix for overwriting AER info when
 error status data has multiple sections
Message-ID: <202309201046.jwWoGRvA-lkp@intel.com>
References: <20230919091543.794-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919091543.794-1-shiju.jose@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on pci/next pci/for-linus linus/master v6.6-rc2 next-20230919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/ACPI-APEI-Fix-for-overwriting-AER-info-when-error-status-data-has-multiple-sections/20230919-171718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230919091543.794-1-shiju.jose%40huawei.com
patch subject: [PATCH v2 1/1] ACPI / APEI: Fix for overwriting AER info when error status data has multiple sections
config: i386-buildonly-randconfig-006-20230920 (https://download.01.org/0day-ci/archive/20230920/202309201046.jwWoGRvA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201046.jwWoGRvA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201046.jwWoGRvA-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pci/pcie/aer.o: in function `aer_recover_work_func':
>> aer.c:(.text+0xec5): undefined reference to `ghes_estatus_pool_region_free'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
