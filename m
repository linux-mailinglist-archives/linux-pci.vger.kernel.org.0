Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930BF6B5836
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 05:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCKElq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 23:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKElp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 23:41:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357291A64F;
        Fri, 10 Mar 2023 20:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678509704; x=1710045704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSQSlE/+vXBkfkITnkBpbAE3poVuW/J///aE8MnPULY=;
  b=WIMR0qXxN+xLKVcpj7Th8rYUtio7ZC2nA3oTxZe1lksCCpZJfX14wZq/
   3CBVS/83VEb6S1AZhkQyYjcNBMTAwgeCov8GxLEhPIbjYaSGHoZGD8N5t
   UYpiahwNqQtHw4yicEOZI7b9pNwZzfmSSc4PqNCTnoxOCw8bVyVVj8bzH
   v0r205dSL/mPGFDu7JU0NhLy/fvXSHmVnLzKW0hx2/tjZ7nr1KbRoTUht
   imACXFmIw/A7aqSoqT1517S9IQPQSincGBakfL0gdGR1TJYqPqptibcvM
   Hd/yxAg3sXeNHwtThDWU8aU6k3JB5PsqeoZE1VFpaKOfoD1Mj0LIaLjwv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316522277"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="316522277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 20:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680435839"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="680435839"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2023 20:41:40 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1par35-0004Kb-2g;
        Sat, 11 Mar 2023 04:41:39 +0000
Date:   Sat, 11 Mar 2023 12:40:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mani@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v2 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
Message-ID: <202303111226.ITclm8Vw-lkp@intel.com>
References: <1678277993-18836-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678277993-18836-4-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rohit,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes pci/next pci/for-linus linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Agarwal/dt-bindings-mfd-qcom-tcsr-Add-compatible-for-sdx65/20230308-202140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1678277993-18836-4-git-send-email-quic_rohiagar%40quicinc.com
patch subject: [PATCH v2 3/6] ARM: dts: qcom: sdx65: Add support for PCIe PHY
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230311/202303111226.ITclm8Vw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ca67929d838c65d39536e65c284da94928f55786
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rohit-Agarwal/dt-bindings-mfd-qcom-tcsr-Add-compatible-for-sdx65/20230308-202140
        git checkout ca67929d838c65d39536e65c284da94928f55786
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303111226.ITclm8Vw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-sdx65.dtsi:306.6-7 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
