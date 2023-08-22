Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0FB78465C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjHVP4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjHVP4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 11:56:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB910C1;
        Tue, 22 Aug 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692719738; x=1724255738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40Mvzn1ll4ExpoBioTZRPiAzse/XM+Dhq7IZWLopB5I=;
  b=QQ9ocMXeY4chliJkR7WCg0eB0GkBuStNH3dDNX5Hen7hZ2nGJEWHEa1N
   zgw2plAm7tkxfBpXXFtwXzD/5BgrI6yfF8K7a78hAuJU1tN3Pq5kPdSOR
   N7aI8mQZ/qfe2EE0elmZAMVTXEP6YFd4xsccfktPsjKDzizuG6H6GcZOr
   B1uFNNGI8xAUlorIeQs3QDK8L1FjFPifRUE7uTfDoT28IlcuMe9VAP6M4
   8dHwLIrhha8xybbc2FHWEI0enuBdQqlNmDU2XcTUjNjO8s94Hj0kVvKgk
   StXhxLGbVOz6PVVZeRMxJjzRc30Gbr2dv5owe9kqG8j8+DSunrZzHDODb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358907056"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358907056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729849565"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="729849565"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2023 08:55:33 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYTjA-0000JH-1l;
        Tue, 22 Aug 2023 15:55:32 +0000
Date:   Tue, 22 Aug 2023 23:54:32 +0800
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
Message-ID: <202308222302.9EPeENqh-lkp@intel.com>
References: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-qcom-Add-sysfs-entry-to-change-link-speed-dynamically/20230817-103734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1692239684-12697-1-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed dynamically
config: loongarch-randconfig-r005-20230822 (https://download.01.org/0day-ci/archive/20230822/202308222302.9EPeENqh-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308222302.9EPeENqh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308222302.9EPeENqh-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/pci/controller/dwc/pcie-qcom.o: in function `qcom_pcie_speed_change_store':
>> drivers/pci/controller/dwc/pcie-qcom.c:375:(.text+0xc14): undefined reference to `qcom_pcie_opp_update'


vim +375 drivers/pci/controller/dwc/pcie-qcom.c

   303	
   304	static ssize_t qcom_pcie_speed_change_store(struct device *dev,
   305				       struct device_attribute *attr,
   306				       const char *buf,
   307				       size_t count)
   308	{
   309		unsigned int current_speed, target_speed, max_speed;
   310		struct qcom_pcie *pcie = dev_get_drvdata(dev);
   311		struct pci_bus *child, *root_bus = NULL;
   312		struct dw_pcie_rp *pp = &pcie->pci->pp;
   313		struct dw_pcie *pci = pcie->pci;
   314		struct pci_dev *pdev;
   315		u16 offset;
   316		u32 val;
   317		int ret;
   318	
   319		list_for_each_entry(child, &pp->bridge->bus->children, node) {
   320			if (child->parent == pp->bridge->bus) {
   321				root_bus = child;
   322				break;
   323			}
   324		}
   325	
   326		pdev = root_bus->self;
   327	
   328		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
   329	
   330		val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
   331		max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
   332	
   333		val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
   334		current_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
   335	
   336		ret = kstrtouint(buf, 10, &target_speed);
   337		if (ret)
   338			return ret;
   339	
   340		if (target_speed > max_speed)
   341			return -EINVAL;
   342	
   343		if (current_speed == target_speed)
   344			return count;
   345	
   346		pci_walk_bus(pp->bridge->bus, qcom_pcie_disable_l0s, pcie);
   347	
   348		/* Disable L1 */
   349		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
   350		val &= ~(PCI_EXP_LNKCTL_ASPM_L1);
   351		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
   352	
   353		/* Set target GEN speed */
   354		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
   355		val &= ~PCI_EXP_LNKCTL2_TLS;
   356		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, val | target_speed);
   357	
   358		ret = pcie_retrain_link(pdev, true);
   359		if (ret)
   360			dev_err(dev, "Link retrain failed %d\n", ret);
   361	
   362		/* Enable L1 */
   363		val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
   364		val |= (PCI_EXP_LNKCTL_ASPM_L1);
   365		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
   366	
   367		pcie->l0s_supported = true;
   368		pci_walk_bus(pp->bridge->bus, qcom_pcie_check_l0s_support, pcie);
   369	
   370		if (pcie->l0s_supported)
   371			pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_l0s, pcie);
   372	
   373		qcom_pcie_icc_update(pcie);
   374	
 > 375		qcom_pcie_opp_update(pcie);
   376	
   377		return count;
   378	}
   379	static DEVICE_ATTR_WO(qcom_pcie_speed_change);
   380	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
