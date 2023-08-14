Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBE977AF3A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 03:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHNBoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Aug 2023 21:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjHNBob (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Aug 2023 21:44:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C40E52;
        Sun, 13 Aug 2023 18:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691977470; x=1723513470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1bYfTn7A/qFI7qE6WjuM6lA5WEd0AWnwsOlRd3Pq2A=;
  b=E7hGrmM5Wr3DO9uzkhNxUBRx11k877dkIUXMTbB5qjddRtMGwroq1Uuu
   uIykL2TuUroSSm+CdDmLDlV93bQxdCP7AyETz/YKfkh77AK8ywMwgZfYD
   39NqhHtlwzvunST8VKZHqG2LG5xIN0CYZj939ELERypMJHLk0F41rI2g0
   XEB3w/NrbLpt8SZtG9z2MtWl6dBPHOy8QHyXLnoEtotVhJllZb7uzyfn0
   fhXowuway4rKGUSaAPqndDazYXSvb/WKzR6shyBXwPLld9YukXMtD3/P4
   sG9WzjzdfJtdolMRslUIai3te0X2lzVfFpD5JHMhD3qdQ5+DI0F110My+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356904804"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="356904804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 18:44:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="907061650"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="907061650"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2023 18:44:27 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVMd8-0009It-2c;
        Mon, 14 Aug 2023 01:44:26 +0000
Date:   Mon, 14 Aug 2023 09:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Lizhi Hou <lizhi.hou@amd.com>,
        max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com
Subject: Re: [PATCH V12 5/5] of: unittest: Add pci_dt_testdrv pci driver
Message-ID: <202308140955.QY7JaDK3-lkp@intel.com>
References: <1690564018-11142-6-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690564018-11142-6-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230814/202308140955.QY7JaDK3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230814/202308140955.QY7JaDK3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308140955.QY7JaDK3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/unittest.c:3737:5: sparse: sparse: symbol 'of_unittest_pci_dev_num' was not declared. Should it be static?
>> drivers/of/unittest.c:3738:5: sparse: sparse: symbol 'of_unittest_pci_child_num' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
