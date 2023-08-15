Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA977CDC3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjHOOES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbjHOOED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 10:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB91199A;
        Tue, 15 Aug 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692108242; x=1723644242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izWgYyGZvbclOsqOoh8da70BMbSJcA4xvR918o81ihw=;
  b=AlXviWrYxP9m1sl1b6df1I03oq2CfUwMi74fRuZASsfQFjd9qAHhDCa4
   PenirDCQ+KN8InBK23jEdfzMMyMxSlAe3lH4f2wqRUIYVhSLbTKok8UdR
   NKX78Y8hosEvo0GQqaLL60HBuF7EE6hRN9e76m1q4TtiX/riMn6FiBeSw
   pqZSVVV2nB3h96X+tcMR9DiXNmEn7eKpKc+hIlbXkCGH99p+fbhaLmln6
   xdevjkjE6KY2JXIleNGJwl+nqqwTp518YtcRF806AyuQjtiBSRExRqtfv
   lUOdIqGfHRKiSAY4Ax4Mo2fPR+VlO5YotQ0mUcmsy1mcC2z0y15IZIxsz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371191779"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="371191779"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848076379"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="848076379"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 07:03:10 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVuda-00010n-04;
        Tue, 15 Aug 2023 14:03:10 +0000
Date:   Tue, 15 Aug 2023 22:03:08 +0800
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
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add OPP suuport for speed based
 performance state of RPMH
Message-ID: <202308152125.sU1aQfAd-lkp@intel.com>
References: <1692102408-7010-4-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692102408-7010-4-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/for-linus]
[also build test WARNING on robh/for-next linus/master v6.5-rc6 next-20230809]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/dt-bindings-pci-qcom-Add-binding-for-operating-points-v2/20230815-203103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/1692102408-7010-4-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v1 3/3] PCI: qcom: Add OPP suuport for speed based performance state of RPMH
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230815/202308152125.sU1aQfAd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308152125.sU1aQfAd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308152125.sU1aQfAd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_opp_update':
>> drivers/pci/controller/dwc/pcie-qcom.c:1368:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1368 |         int ret = 0;
         |             ^~~


vim +/ret +1368 drivers/pci/controller/dwc/pcie-qcom.c

  1360	
  1361	static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
  1362	{
  1363		struct dw_pcie *pci = pcie->pci;
  1364		struct dev_pm_opp *opp;
  1365		u32 offset, status;
  1366		uint32_t freq;
  1367		int speed;
> 1368		int ret = 0;
  1369	
  1370		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
  1371		status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
  1372	
  1373		/* Only update constraints if link is up. */
  1374		if (!(status & PCI_EXP_LNKSTA_DLLLA))
  1375			return;
  1376	
  1377		speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
  1378	
  1379		switch (speed) {
  1380		case 1:
  1381			freq = 2500000;
  1382			break;
  1383		case 2:
  1384			freq = 5000000;
  1385			break;
  1386		case 3:
  1387			freq = 8000000;
  1388			break;
  1389		default:
  1390			WARN_ON_ONCE(1);
  1391			fallthrough;
  1392		case 4:
  1393			freq = 16000000;
  1394			break;
  1395		}
  1396	
  1397		opp = dev_pm_opp_find_freq_exact(pci->dev, freq, true);
  1398	
  1399		if (!IS_ERR(opp)) {
  1400			ret = dev_pm_opp_get_voltage(opp);
  1401			dev_pm_opp_put(opp);
  1402		}
  1403	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
