Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE477EFA7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 05:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbjHQDv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbjHQDvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 23:51:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1326A8;
        Wed, 16 Aug 2023 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692244276; x=1723780276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xwI3wmGXcs0Evg0bbeV61o6vXuck4y6AiG6Pb05I7Qw=;
  b=R+aqwDL3I7WVp2gFIFijYWh3RnDkRw33xVBsCD/JVEkAdNftMqnonZ52
   6W/+ZaijgawHtNBXNUDMm2EPJip4AV5gzfUD2GFZ7X5YalhFjc7lDyrx5
   2r7iRka/CvgO6wrHzmqFxQED1Nds/yNqkXir6SpfzgtUWZ2RdvgxcL1o5
   YOv/Bu+AJwSh5C0oJk0dTCbmHsML2Q0duNoRXMROxhReal+RP+/ytFNz2
   yNj4q4GfJ5OBlqUrCELSWL58Jg81mHXLqV3uP0go1h9LDGzq3NPGgfEcz
   ImdAoIQjqZz7ZNCdgpouPrf/xgVnebcjnZIguy9Zde0puDldch0LtflnS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="353020864"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="353020864"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 20:51:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763875568"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="763875568"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 20:51:11 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWU2R-0000lx-0m;
        Thu, 17 Aug 2023 03:51:11 +0000
Date:   Thu, 17 Aug 2023 11:50:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed
 dynamically
Message-ID: <202308171155.o5viLJ3O-lkp@intel.com>
References: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.5-rc6 next-20230816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-qcom-Add-sysfs-entry-to-change-link-speed-dynamically/20230817-103734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1692239684-12697-1-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed dynamically
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308171155.o5viLJ3O-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171155.o5viLJ3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171155.o5viLJ3O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:249:13: warning: 'qcom_pcie_opp_update' used but never defined
     249 | static void qcom_pcie_opp_update(struct qcom_pcie *pcie);
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/qcom_pcie_opp_update +249 drivers/pci/controller/dwc/pcie-qcom.c

   247	
   248	static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
 > 249	static void qcom_pcie_opp_update(struct qcom_pcie *pcie);
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
