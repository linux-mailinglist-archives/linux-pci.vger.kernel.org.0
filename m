Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BF6770F43
	for <lists+linux-pci@lfdr.de>; Sat,  5 Aug 2023 12:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjHEK2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Aug 2023 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEK2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2023 06:28:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD84689;
        Sat,  5 Aug 2023 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691231309; x=1722767309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ZDkkCoUDWx4/s8HsGY+04UsKtUjmmFhstQgDKpEhmg=;
  b=nQhOwHQ2ryJGZm8ujDDPa7SNjlWK+XWxdjTj5AAeaACNQ/jB8lpDQCfz
   7OZ15jtAySepc30vCbKOeWSYk6a4dSychTkABWOgLBBAw0msdC2FsK59M
   ah5Dvd3XONTSA5ApTDHm9LUXQQAURvKB4pZQSrMS6g1o3CIrktIRot0IX
   zduDiAgkZjO8B44R2JbbDA8bSRlCDqayj6F0t5gpSsT7vgfexivhqzFlE
   JU5Wp75mJveSiTKeshHwnNEskP9txuBn686IMrKadvIPQ/K1wxlw/J81z
   x0pw1rZgilNjYGfW2L7P8AqWMMeOl4uXTQtyt9JeceRha35CYyW6ZfgIy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367762433"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="367762433"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 03:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="1061070412"
X-IronPort-AV: E=Sophos;i="6.01,257,1684825200"; 
   d="scan'208";a="1061070412"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2023 03:28:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSEWG-0003Rt-1B;
        Sat, 05 Aug 2023 10:28:24 +0000
Date:   Sat, 5 Aug 2023 18:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target
 state fallback policy
Message-ID: <202308051803.x00umDzn-lkp@intel.com>
References: <20230804210129.5356-8-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804210129.5356-8-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on pci/next pci/for-linus westeri-thunderbolt/next linus/master v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-Add-comments-to-clarify-some-ifdef-statements/20230805-050559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230804210129.5356-8-mario.limonciello%40amd.com
patch subject: [PATCH v10 7/7] PCI: Use device constraints to decide PCI target state fallback policy
config: x86_64-randconfig-r013-20230731 (https://download.01.org/0day-ci/archive/20230805/202308051803.x00umDzn-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308051803.x00umDzn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308051803.x00umDzn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: acpi_get_lps0_constraint
   >>> referenced by pci.c:1090 (drivers/pci/pci.c:1090)
   >>>               vmlinux.o:(pci_target_state)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
