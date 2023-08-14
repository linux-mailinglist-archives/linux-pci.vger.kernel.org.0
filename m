Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B8D77C36F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 00:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjHNW2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 18:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjHNW2l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 18:28:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975B171A;
        Mon, 14 Aug 2023 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692052119; x=1723588119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9oOBn1v8SHtGrgH+6GcV/nLem9oDmQtlr+e36iqVfw4=;
  b=T3nlBuZDDThmwVhU19+JsiumYSL6c8c+p1/5iv0FqgPhbmKyxt5Pl+ia
   fD3Qj5ixhJ/3R3DwyhK5qXPUkb6/YXoy72gx9ujQ6lcPT+VkfCmIT1jKY
   ox4tpp/Mjf7CwPcJ6rGdp99RJ6WAGUQGs9Nob+tTeT4SiULZDqWIHpAqC
   NY8TVVzi2vKbdTV9LYQaf/kCPMUpXTQdoJx3t8CaykD9xX04GZdgG3yEm
   ovvWiHK/7tXH7gTINzcoj+pbduSVMum2rfcyyI6kIXWjStBxG8FdeXSCQ
   Gy2zPwjZQ2BJDbAdJ14tJQ8xTwDcV7lgQ+4U3kz15zqx09SgFYIyCGmLv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374919687"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374919687"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 15:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803602476"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803602476"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 15:28:36 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVg39-0000Sp-2W;
        Mon, 14 Aug 2023 22:28:35 +0000
Date:   Tue, 15 Aug 2023 06:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Lizhi Hou <lizhi.hou@amd.com>,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V12 5/5] of: unittest: Add pci_dt_testdrv pci driver
Message-ID: <202308150643.iteeGiQb-lkp@intel.com>
References: <1690564018-11142-6-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690564018-11142-6-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/of-dynamic-Add-interfaces-for-creating-device-node-dynamically/20230729-010934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1690564018-11142-6-git-send-email-lizhi.hou%40amd.com
patch subject: [PATCH V12 5/5] of: unittest: Add pci_dt_testdrv pci driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230815/202308150643.iteeGiQb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150643.iteeGiQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150643.iteeGiQb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/unittest.c:3737:5: sparse: sparse: symbol 'of_unittest_pci_dev_num' was not declared. Should it be static?
>> drivers/of/unittest.c:3738:5: sparse: sparse: symbol 'of_unittest_pci_child_num' was not declared. Should it be static?

vim +/of_unittest_pci_dev_num +3737 drivers/of/unittest.c

  3736	
> 3737	int of_unittest_pci_dev_num;
> 3738	int of_unittest_pci_child_num;
  3739	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
