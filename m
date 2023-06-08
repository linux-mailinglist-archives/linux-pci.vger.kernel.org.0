Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2674728B68
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjFHWzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHWyx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 18:54:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7B62D74;
        Thu,  8 Jun 2023 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686264891; x=1717800891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dd0u2N723fxNFuDaKsE3otcHiK0R6lSa4aGmdjcByVU=;
  b=QRT81HlAlK892k+x7Cc1yNiythGi1EkDW2Wq4koxy0Qf77hAsN7aPfaz
   hxetCbM2duYnMVHxvbYu+VDZGTVCu43mD/eqcPrHuZm06fDRZ8275LBIC
   Ar/V4fVweXENhnm3ycjJNkkEdl6SZYnYXLYV18NCqzbwvrAJZPV4X5nDv
   BTVOhYmqOjlFcE8M3RzC8Xupe+zxms7IThTsRI7/wXYDzoCdUmH7o0HWI
   jF9zvoPMYuqPHmGeZygchsO5iZ3tQbVdxdT7up9sdJMDKWryDOon2kn2+
   QSRvGFV3KAl7YHGeyx4F45YifrbJcfoUwoMR8zV7Lqp6P4ni18dvEHfWl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347100901"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347100901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:54:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956914069"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956914069"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:54:46 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7OWk-0008KC-0g;
        Thu, 08 Jun 2023 22:54:46 +0000
Date:   Fri, 9 Jun 2023 06:54:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rrichter@amd.com, terry.bowman@amd.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
        bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 25/26] PCI/AER: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <202306090637.9E2ezbR4-lkp@intel.com>
References: <20230607221651.2454764-26-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-26-terry.bowman@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on a70fc4ed20a6118837b0aecbbf789074935f473b]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-acpi-Probe-RCRB-later-during-RCH-downstream-port-creation/20230608-062818
base:   a70fc4ed20a6118837b0aecbbf789074935f473b
patch link:    https://lore.kernel.org/r/20230607221651.2454764-26-terry.bowman%40amd.com
patch subject: [PATCH v5 25/26] PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
config: x86_64-randconfig-r005-20230607 (https://download.01.org/0day-ci/archive/20230609/202306090637.9E2ezbR4-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a70fc4ed20a6118837b0aecbbf789074935f473b
        b4 shazam https://lore.kernel.org/r/20230607221651.2454764-26-terry.bowman@amd.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090637.9E2ezbR4-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module cxl_core uses symbol pci_print_aer from namespace CXL, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
