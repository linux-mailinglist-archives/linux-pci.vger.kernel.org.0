Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8970876E4C5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHCJmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjHCJlt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 05:41:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040673C3F;
        Thu,  3 Aug 2023 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691055684; x=1722591684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsjynlJwoyqFJ3adCtTUmQ0RI0ykyDi4RIv6/UmcrSI=;
  b=MBgP8GmlBSDlZxKuMDOjtmG85atrnh7YizxsOhQtkv6kT3ET+cmf27p3
   cH9a/OaDxoqkR3RI+jn5oqJFnEPLXc1N/mPcAP6Bp2ZvuQRRYhdfEijWZ
   f0A1w6fdQjVa6JPnNiCtdtSn609kljhdy9FicctTHzZXIazMrfVyd2y/Z
   /G7EroivbENUsP96Wk2u66r/prL/Qacsrr/zKukuRTemgOufN2f2VJHyg
   1xZdy34Oyrwy56VrbmUBHKUirOVGUFOLV5KX9+4yLfaWIl62hQNG/JXD3
   PxtmA7WRutZ1kpId5lrlxJTYpIt1b1/1XUxH2wHezP/s2DWKSShOPplf3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="350120172"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="350120172"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 02:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976002493"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="976002493"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 02:41:18 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRUpZ-00020B-14;
        Thu, 03 Aug 2023 09:41:17 +0000
Date:   Thu, 3 Aug 2023 17:40:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates
 to opt devices into D3
Message-ID: <202308031702.maQwVjYc-lkp@intel.com>
References: <20230802201013.910-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201013.910-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on pci/next pci/for-linus westeri-thunderbolt/next linus/master v6.5-rc4 next-20230803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Add-comments-to-clarify-some-ifdef-statements/20230803-041214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230802201013.910-3-mario.limonciello%40amd.com
patch subject: [PATCH v8 2/2] PCI/ACPI: Use device constraints instead of dates to opt devices into D3
config: x86_64-randconfig-x003-20230731 (https://download.01.org/0day-ci/archive/20230803/202308031702.maQwVjYc-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308031702.maQwVjYc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308031702.maQwVjYc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: acpi_get_lps0_constraint
   >>> referenced by pci-acpi.c:1055 (drivers/pci/pci-acpi.c:1055)
   >>>               vmlinux.o:(pci_bridge_d3_possible)
   >>> referenced by pci-acpi.c:1055 (drivers/pci/pci-acpi.c:1055)
   >>>               vmlinux.o:(acpi_pci_device_constraint_d3)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
