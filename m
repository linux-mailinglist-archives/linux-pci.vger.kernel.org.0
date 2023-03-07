Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7E6AD9C0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 09:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGI7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 03:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCGI7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 03:59:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23D5CC3E;
        Tue,  7 Mar 2023 00:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678179542; x=1709715542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3umUm4ahFVMYfF3/FeLculY9PKxRgx3vNRzzbJ6yOzU=;
  b=TMMvdFMiX5NfeQVBtwrp0c8GuZIbHlGIcxGC0LOT4LO3uL/QeaX42IMC
   VlgcLevCgk4GUtl9/3GouvZLVaaVOk/I4Lxz9jkX4O3Dxy4BMwzEEeMHO
   mqSA+v+tAXX4M2erlQRICPo9KaI95R4tbM9/9YjrzS2EWkpyExwAeTXom
   FdrMorhJJBT1SRa5I/EVNjQ3OkiFEAlY37n/GYSeN3febQLieklXC/9YD
   fFo5ex8aJvYkLAsaaLoK7SY+gRV3z7/CZRudidqcxPT4SP2DmAkFUroGk
   YjexWvc3ORMesrTKbDEMBbA4P+5w8S/hIYTQr4cGloRD6PjQYY77DA3am
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="400624120"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="400624120"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626464657"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="626464657"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 00:58:58 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZT9t-00019L-1R;
        Tue, 07 Mar 2023 08:58:57 +0000
Date:   Tue, 7 Mar 2023 16:58:01 +0800
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
Subject: Re: [PATCH 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
Message-ID: <202303071612.HZ9bDCp7-lkp@intel.com>
References: <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678080302-29691-7-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rohit,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes pci/next pci/for-linus linus/master v6.3-rc1 next-20230306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rohit-Agarwal/dt-bindings-mfd-qcom-tcsr-Add-compatible-for-sdx65/20230306-132618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1678080302-29691-7-git-send-email-quic_rohiagar%40quicinc.com
patch subject: [PATCH 6/6] ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230307/202303071612.HZ9bDCp7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/51b8272710554bf9cbee6604f73951179e85ffa7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rohit-Agarwal/dt-bindings-mfd-qcom-tcsr-Add-compatible-for-sdx65/20230306-132618
        git checkout 51b8272710554bf9cbee6604f73951179e85ffa7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303071612.HZ9bDCp7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-sdx65-mtp.dts:287.1-2 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
