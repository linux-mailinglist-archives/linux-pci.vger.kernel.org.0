Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A285E5195A7
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiEDC6Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 22:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbiEDC6P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 22:58:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4171A3AD;
        Tue,  3 May 2022 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651632881; x=1683168881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsWFIBdCiaIZnDpi6aLAm3yjd4bu5P5ackQ3H9N6o+U=;
  b=LyuBzcbt/VRsVKbrombq5Xd7yIRL0C+KNyhdqhk88NFsoACw7KKRqyvb
   e0eOOvCdMK5lkYfTedkITQMYsiw2mt+D1yPbcBpXrAk/Pvv+hifCtOCUA
   AXWGmjLDFPuZD4Ww6PdlvPIi6HEC2YCyPDssiBy8iJGiFQKjAzQwZMmHT
   0h28pPUrez/W/MlvFYiTqkqxzA246mYnf3d2hGrR9eVRHFCdxxWf0FJQ7
   hKzsUxXvkeB1+tNCJXfKh1Bj9qYyz8jsmnr855HrhtgtAvDL94EQ9QSzj
   rcRnfFfXqDHX9yUpuUM3RUzTf3KFA3anw9j0GCcT3ahyjLSxZpXPyuH2k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267528048"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="267528048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="548155712"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2022 19:54:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm59u-000AzT-FF;
        Wed, 04 May 2022 02:54:34 +0000
Date:   Wed, 4 May 2022 10:53:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, Tim Harvey <tharvey@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kbuild-all@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/1] of: overlay: rename overlay source files from
 .dts to .dtso
Message-ID: <202205041054.U5pUx0xQ-lkp@intel.com>
References: <20220503211954.1428919-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503211954.1428919-1-frowand.list@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on next-20220503]
[cannot apply to masahiroy-kbuild/for-next v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/frowand-list-gmail-com/of-overlay-rename-overlay-source-files-from-dts-to-dtso/20220504-052106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-m031-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041054.U5pUx0xQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/53969d905002b16289e1524e691435a64652db0d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review frowand-list-gmail-com/of-overlay-rename-overlay-source-files-from-dts-to-dtso/20220504-052106
        git checkout 53969d905002b16289e1524e691435a64652db0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/of/unittest-data/static_base_1.dtb', needed by 'drivers/of/unittest-data/static_test_1.dtb'.
>> make[4]: *** No rule to make target 'drivers/of/unittest-data/static_base_2.dtb', needed by 'drivers/of/unittest-data/static_test_2.dtb'.
   make[4]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
