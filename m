Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C983F221E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 23:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhHSVNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 17:13:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:6213 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235498AbhHSVNU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 17:13:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213527777"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="gz'50?scan'50,208,50";a="213527777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 14:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="gz'50?scan'50,208,50";a="489895181"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2021 14:12:38 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGpL4-000UHX-4I; Thu, 19 Aug 2021 21:12:38 +0000
Date:   Fri, 20 Aug 2021 05:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2] mei: improve Denverton HSM & IFSI support
Message-ID: <202108200531.Alvrkkw9-lkp@intel.com>
References: <20210819150459.21545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20210819150459.21545-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lukas,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on pci/next soc/for-next v5.14-rc6 next-20210819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lukas-Bulwahn/mei-improve-Denverton-HSM-IFSI-support/20210819-230718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git b2159182dd498fdb0f49e371ccc94efbc12d1f8e
config: x86_64-randconfig-r015-20210818 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d2b574a4dea5b718e4386bf2e26af0126e5978ce)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2b98fe0ded99ab7eaf389fa1c91b3d9aad7c93a3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lukas-Bulwahn/mei-improve-Denverton-HSM-IFSI-support/20210819-230718
        git checkout 2b98fe0ded99ab7eaf389fa1c91b3d9aad7c93a3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/mei/pci-me.c:80:39: error: use of undeclared identifier 'MEI_ME_PCH8_SPS_CFG'
           {MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
                                                ^
>> drivers/misc/mei/pci-me.c:195:31: warning: shift count >= width of type [-Wshift-count-overflow]
           if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
                                        ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/misc/mei/pci-me.c:196:40: warning: shift count >= width of type [-Wshift-count-overflow]
               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
                                                 ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.


vim +195 drivers/misc/mei/pci-me.c

2703d4b2e673cc Tomas Winkler     2013-02-06   25  
2703d4b2e673cc Tomas Winkler     2013-02-06   26  /* mei_pci_tbl - PCI Device ID Table */
a05f8f86e49749 Tomas Winkler     2014-03-16   27  static const struct pci_device_id mei_me_pci_tbl[] = {
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   28  	{MEI_PCI_DEVICE(MEI_DEV_ID_82946GZ, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   29  	{MEI_PCI_DEVICE(MEI_DEV_ID_82G35, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   30  	{MEI_PCI_DEVICE(MEI_DEV_ID_82Q965, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   31  	{MEI_PCI_DEVICE(MEI_DEV_ID_82G965, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   32  	{MEI_PCI_DEVICE(MEI_DEV_ID_82GM965, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   33  	{MEI_PCI_DEVICE(MEI_DEV_ID_82GME965, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   34  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_82Q35, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   35  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_82G33, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   36  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_82Q33, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   37  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_82X38, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   38  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_3200, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   39  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   40  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_6, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   41  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_7, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   42  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_8, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   43  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_9, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   44  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9_10, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   45  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9M_1, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   46  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9M_2, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   47  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9M_3, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   48  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH9M_4, MEI_ME_ICH_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   49  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   50  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH10_1, MEI_ME_ICH10_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   51  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH10_2, MEI_ME_ICH10_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   52  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH10_3, MEI_ME_ICH10_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   53  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICH10_4, MEI_ME_ICH10_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   54  
f8204f0ddd6296 Alexander Usyskin 2019-10-04   55  	{MEI_PCI_DEVICE(MEI_DEV_ID_IBXPK_1, MEI_ME_PCH6_CFG)},
f8204f0ddd6296 Alexander Usyskin 2019-10-04   56  	{MEI_PCI_DEVICE(MEI_DEV_ID_IBXPK_2, MEI_ME_PCH6_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   57  	{MEI_PCI_DEVICE(MEI_DEV_ID_CPT_1, MEI_ME_PCH_CPT_PBG_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   58  	{MEI_PCI_DEVICE(MEI_DEV_ID_PBG_1, MEI_ME_PCH_CPT_PBG_CFG)},
f8204f0ddd6296 Alexander Usyskin 2019-10-04   59  	{MEI_PCI_DEVICE(MEI_DEV_ID_PPT_1, MEI_ME_PCH7_CFG)},
f8204f0ddd6296 Alexander Usyskin 2019-10-04   60  	{MEI_PCI_DEVICE(MEI_DEV_ID_PPT_2, MEI_ME_PCH7_CFG)},
f8204f0ddd6296 Alexander Usyskin 2019-10-04   61  	{MEI_PCI_DEVICE(MEI_DEV_ID_PPT_3, MEI_ME_PCH7_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   62  	{MEI_PCI_DEVICE(MEI_DEV_ID_LPT_H, MEI_ME_PCH8_SPS_4_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   63  	{MEI_PCI_DEVICE(MEI_DEV_ID_LPT_W, MEI_ME_PCH8_SPS_4_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   64  	{MEI_PCI_DEVICE(MEI_DEV_ID_LPT_LP, MEI_ME_PCH8_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   65  	{MEI_PCI_DEVICE(MEI_DEV_ID_LPT_HR, MEI_ME_PCH8_SPS_4_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   66  	{MEI_PCI_DEVICE(MEI_DEV_ID_WPT_LP, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   67  	{MEI_PCI_DEVICE(MEI_DEV_ID_WPT_LP_2, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   68  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   69  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   70  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
2f79d3d1f7f088 Alexander Usyskin 2020-07-28   71  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_ITOUCH_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   72  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_4_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   73  	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   74  	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_4_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   75  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   76  	{MEI_PCI_DEVICE(MEI_DEV_ID_BXT_M, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   77  	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   78  
f7ee8ead151f9d Tomas Winkler     2019-01-13   79  	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
2b98fe0ded99ab Lukas Bulwahn     2021-08-19  @80  	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE_2, MEI_ME_PCH8_SPS_CFG)},
f7ee8ead151f9d Tomas Winkler     2019-01-13   81  
688cb67839e852 Tomas Winkler     2017-09-24   82  	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
688cb67839e852 Tomas Winkler     2017-09-24   83  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   84  	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
f5ac3c49ff0b36 Tomas Winkler     2017-06-14   85  	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
4afc339ef0d259 Tomas Winkler     2020-06-19   86  	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_3, MEI_ME_PCH8_CFG)},
ac182e8abc6f93 Alexander Usyskin 2016-09-12   87  
1dbfe7f23bdb72 Alexander Usyskin 2018-11-22   88  	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH12_CFG)},
2f79d3d1f7f088 Alexander Usyskin 2020-07-28   89  	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
f76d77f50b343b Tomas Winkler     2020-06-19   90  	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH12_SPS_CFG)},
2f79d3d1f7f088 Alexander Usyskin 2020-07-28   91  	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_3, MEI_ME_PCH12_SPS_ITOUCH_CFG)},
f8f4aa68a8ae98 Alexander Usyskin 2018-02-18   92  
4d86dfd38285c8 Tomas Winkler     2019-10-02   93  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP, MEI_ME_PCH12_CFG)},
2f79d3d1f7f088 Alexander Usyskin 2020-07-28   94  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
82b29b9f72afdc Alexander Usyskin 2019-11-05   95  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_V, MEI_ME_PCH12_CFG)},
559e575a8946a6 Tomas Winkler     2020-01-19   96  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H, MEI_ME_PCH12_CFG)},
2f79d3d1f7f088 Alexander Usyskin 2020-07-28   97  	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG)},
4d86dfd38285c8 Tomas Winkler     2019-10-02   98  
efe814e90b98ae Tomas Winkler     2019-01-24   99  	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
efe814e90b98ae Tomas Winkler     2019-01-24  100  
52f6efdf809244 Alexander Usyskin 2019-11-07  101  	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
8c289ea0641652 Alexander Usyskin 2020-06-19  102  	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_H, MEI_ME_PCH15_SPS_CFG)},
587f17407741a5 Tomas Winkler     2019-08-19  103  
0db4a15d4c2787 Tomas Winkler     2020-01-24  104  	{MEI_PCI_DEVICE(MEI_DEV_ID_JSP_N, MEI_ME_PCH15_CFG)},
0db4a15d4c2787 Tomas Winkler     2020-01-24  105  
52f6efdf809244 Alexander Usyskin 2019-11-07  106  	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC, MEI_ME_PCH15_CFG)},
1be8624a0cbef7 Alexander Usyskin 2019-07-12  107  	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC_4, MEI_ME_PCH8_CFG)},
1be8624a0cbef7 Alexander Usyskin 2019-07-12  108  
99397d33b763dc Alexander Usyskin 2020-03-24  109  	{MEI_PCI_DEVICE(MEI_DEV_ID_CDF, MEI_ME_PCH8_CFG)},
99397d33b763dc Alexander Usyskin 2020-03-24  110  
372726cb3957db Tomas Winkler     2021-01-29  111  	{MEI_PCI_DEVICE(MEI_DEV_ID_EBG, MEI_ME_PCH15_SPS_CFG)},
372726cb3957db Tomas Winkler     2021-01-29  112  
f7545efaf7950b Alexander Usyskin 2021-01-29  113  	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_S, MEI_ME_PCH15_CFG)},
930c922a987a02 Alexander Usyskin 2021-01-29  114  	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_LP, MEI_ME_PCH15_CFG)},
0df74278faedf2 Tomas Winkler     2021-04-14  115  	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_P, MEI_ME_PCH15_CFG)},
f7545efaf7950b Alexander Usyskin 2021-01-29  116  
2703d4b2e673cc Tomas Winkler     2013-02-06  117  	/* required last entry */
2703d4b2e673cc Tomas Winkler     2013-02-06  118  	{0, }
2703d4b2e673cc Tomas Winkler     2013-02-06  119  };
2703d4b2e673cc Tomas Winkler     2013-02-06  120  
b68301e9acd30f Tomas Winkler     2013-03-27  121  MODULE_DEVICE_TABLE(pci, mei_me_pci_tbl);
2703d4b2e673cc Tomas Winkler     2013-02-06  122  
bbd6d050754731 Rafael J. Wysocki 2014-12-04  123  #ifdef CONFIG_PM
e13fa90ce42d8e Tomas Winkler     2014-03-18  124  static inline void mei_me_set_pm_domain(struct mei_device *dev);
e13fa90ce42d8e Tomas Winkler     2014-03-18  125  static inline void mei_me_unset_pm_domain(struct mei_device *dev);
e13fa90ce42d8e Tomas Winkler     2014-03-18  126  #else
e13fa90ce42d8e Tomas Winkler     2014-03-18  127  static inline void mei_me_set_pm_domain(struct mei_device *dev) {}
e13fa90ce42d8e Tomas Winkler     2014-03-18  128  static inline void mei_me_unset_pm_domain(struct mei_device *dev) {}
bbd6d050754731 Rafael J. Wysocki 2014-12-04  129  #endif /* CONFIG_PM */
e13fa90ce42d8e Tomas Winkler     2014-03-18  130  
261e071acd9bcb Tomas Winkler     2019-11-07  131  static int mei_me_read_fws(const struct mei_device *dev, int where, u32 *val)
261e071acd9bcb Tomas Winkler     2019-11-07  132  {
261e071acd9bcb Tomas Winkler     2019-11-07  133  	struct pci_dev *pdev = to_pci_dev(dev->dev);
261e071acd9bcb Tomas Winkler     2019-11-07  134  
261e071acd9bcb Tomas Winkler     2019-11-07  135  	return pci_read_config_dword(pdev, where, val);
261e071acd9bcb Tomas Winkler     2019-11-07  136  }
261e071acd9bcb Tomas Winkler     2019-11-07  137  
2703d4b2e673cc Tomas Winkler     2013-02-06  138  /**
ce23139c6c2ee9 Alexander Usyskin 2014-09-29  139   * mei_me_quirk_probe - probe for devices that doesn't valid ME interface
393b148f9d0e70 Masanari Iida     2013-04-05  140   *
2703d4b2e673cc Tomas Winkler     2013-02-06  141   * @pdev: PCI device structure
c919951d940f28 Tomas Winkler     2014-05-13  142   * @cfg: per generation config
2703d4b2e673cc Tomas Winkler     2013-02-06  143   *
a8605ea2c20c2b Alexander Usyskin 2014-09-29  144   * Return: true if ME Interface is valid, false otherwise
2703d4b2e673cc Tomas Winkler     2013-02-06  145   */
b68301e9acd30f Tomas Winkler     2013-03-27  146  static bool mei_me_quirk_probe(struct pci_dev *pdev,
c919951d940f28 Tomas Winkler     2014-05-13  147  				const struct mei_cfg *cfg)
2703d4b2e673cc Tomas Winkler     2013-02-06  148  {
c919951d940f28 Tomas Winkler     2014-05-13  149  	if (cfg->quirk_probe && cfg->quirk_probe(pdev)) {
c919951d940f28 Tomas Winkler     2014-05-13  150  		dev_info(&pdev->dev, "Device doesn't have valid ME Interface\n");
c919951d940f28 Tomas Winkler     2014-05-13  151  		return false;
2703d4b2e673cc Tomas Winkler     2013-02-06  152  	}
5e6533a6f52f1a Tomas Winkler     2014-03-25  153  
2703d4b2e673cc Tomas Winkler     2013-02-06  154  	return true;
2703d4b2e673cc Tomas Winkler     2013-02-06  155  }
c919951d940f28 Tomas Winkler     2014-05-13  156  
2703d4b2e673cc Tomas Winkler     2013-02-06  157  /**
ce23139c6c2ee9 Alexander Usyskin 2014-09-29  158   * mei_me_probe - Device Initialization Routine
2703d4b2e673cc Tomas Winkler     2013-02-06  159   *
2703d4b2e673cc Tomas Winkler     2013-02-06  160   * @pdev: PCI device structure
2703d4b2e673cc Tomas Winkler     2013-02-06  161   * @ent: entry in kcs_pci_tbl
2703d4b2e673cc Tomas Winkler     2013-02-06  162   *
a8605ea2c20c2b Alexander Usyskin 2014-09-29  163   * Return: 0 on success, <0 on failure.
2703d4b2e673cc Tomas Winkler     2013-02-06  164   */
b68301e9acd30f Tomas Winkler     2013-03-27  165  static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
2703d4b2e673cc Tomas Winkler     2013-02-06  166  {
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  167  	const struct mei_cfg *cfg;
2703d4b2e673cc Tomas Winkler     2013-02-06  168  	struct mei_device *dev;
52c34561415b42 Tomas Winkler     2013-02-06  169  	struct mei_me_hw *hw;
1fa55b4e0e161b Alexander Usyskin 2015-08-02  170  	unsigned int irqflags;
2703d4b2e673cc Tomas Winkler     2013-02-06  171  	int err;
2703d4b2e673cc Tomas Winkler     2013-02-06  172  
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  173  	cfg = mei_me_get_cfg(ent->driver_data);
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  174  	if (!cfg)
f5ac3c49ff0b36 Tomas Winkler     2017-06-14  175  		return -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  176  
c919951d940f28 Tomas Winkler     2014-05-13  177  	if (!mei_me_quirk_probe(pdev, cfg))
c919951d940f28 Tomas Winkler     2014-05-13  178  		return -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  179  
2703d4b2e673cc Tomas Winkler     2013-02-06  180  	/* enable pci dev */
f8a096059fc5f7 Tomas Winkler     2017-01-26  181  	err = pcim_enable_device(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  182  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  183  		dev_err(&pdev->dev, "failed to enable pci device.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  184  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  185  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  186  	/* set PCI host mastering  */
2703d4b2e673cc Tomas Winkler     2013-02-06  187  	pci_set_master(pdev);
f8a096059fc5f7 Tomas Winkler     2017-01-26  188  	/* pci request regions and mapping IO device memory for mei driver */
f8a096059fc5f7 Tomas Winkler     2017-01-26  189  	err = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
2703d4b2e673cc Tomas Winkler     2013-02-06  190  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  191  		dev_err(&pdev->dev, "failed to get pci regions.\n");
f8a096059fc5f7 Tomas Winkler     2017-01-26  192  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  193  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  194  
3ecfb168a51ddf Tomas Winkler     2013-12-17 @195  	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
3ecfb168a51ddf Tomas Winkler     2013-12-17  196  	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
3ecfb168a51ddf Tomas Winkler     2013-12-17  197  
3ecfb168a51ddf Tomas Winkler     2013-12-17  198  		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
3ecfb168a51ddf Tomas Winkler     2013-12-17  199  		if (err)
3ecfb168a51ddf Tomas Winkler     2013-12-17  200  			err = dma_set_coherent_mask(&pdev->dev,
3ecfb168a51ddf Tomas Winkler     2013-12-17  201  						    DMA_BIT_MASK(32));
3ecfb168a51ddf Tomas Winkler     2013-12-17  202  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  203  	if (err) {
3ecfb168a51ddf Tomas Winkler     2013-12-17  204  		dev_err(&pdev->dev, "No usable DMA configuration, aborting\n");
f8a096059fc5f7 Tomas Winkler     2017-01-26  205  		goto end;
3ecfb168a51ddf Tomas Winkler     2013-12-17  206  	}
3ecfb168a51ddf Tomas Winkler     2013-12-17  207  
2703d4b2e673cc Tomas Winkler     2013-02-06  208  	/* allocates and initializes the mei dev structure */
907b471ca228a5 Tomas Winkler     2019-11-07  209  	dev = mei_me_dev_init(&pdev->dev, cfg);
2703d4b2e673cc Tomas Winkler     2013-02-06  210  	if (!dev) {
2703d4b2e673cc Tomas Winkler     2013-02-06  211  		err = -ENOMEM;
f8a096059fc5f7 Tomas Winkler     2017-01-26  212  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  213  	}
52c34561415b42 Tomas Winkler     2013-02-06  214  	hw = to_me_hw(dev);
f8a096059fc5f7 Tomas Winkler     2017-01-26  215  	hw->mem_addr = pcim_iomap_table(pdev)[0];
261e071acd9bcb Tomas Winkler     2019-11-07  216  	hw->read_fws = mei_me_read_fws;
f8a096059fc5f7 Tomas Winkler     2017-01-26  217  
2703d4b2e673cc Tomas Winkler     2013-02-06  218  	pci_enable_msi(pdev);
2703d4b2e673cc Tomas Winkler     2013-02-06  219  
fec874a81b3ec2 Benjamin Lee      2020-04-17  220  	hw->irq = pdev->irq;
fec874a81b3ec2 Benjamin Lee      2020-04-17  221  
2703d4b2e673cc Tomas Winkler     2013-02-06  222  	 /* request and enable interrupt */
1fa55b4e0e161b Alexander Usyskin 2015-08-02  223  	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;
1fa55b4e0e161b Alexander Usyskin 2015-08-02  224  
2703d4b2e673cc Tomas Winkler     2013-02-06  225  	err = request_threaded_irq(pdev->irq,
06ecd645980096 Tomas Winkler     2013-02-06  226  			mei_me_irq_quick_handler,
06ecd645980096 Tomas Winkler     2013-02-06  227  			mei_me_irq_thread_handler,
1fa55b4e0e161b Alexander Usyskin 2015-08-02  228  			irqflags, KBUILD_MODNAME, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  229  	if (err) {
2703d4b2e673cc Tomas Winkler     2013-02-06  230  		dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
2703d4b2e673cc Tomas Winkler     2013-02-06  231  		       pdev->irq);
f8a096059fc5f7 Tomas Winkler     2017-01-26  232  		goto end;
2703d4b2e673cc Tomas Winkler     2013-02-06  233  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  234  
c4d589be4405d4 Tomas Winkler     2013-03-27  235  	if (mei_start(dev)) {
2703d4b2e673cc Tomas Winkler     2013-02-06  236  		dev_err(&pdev->dev, "init hw failure.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  237  		err = -ENODEV;
2703d4b2e673cc Tomas Winkler     2013-02-06  238  		goto release_irq;
2703d4b2e673cc Tomas Winkler     2013-02-06  239  	}
2703d4b2e673cc Tomas Winkler     2013-02-06  240  
180ea05bcedbd6 Tomas Winkler     2014-03-18  241  	pm_runtime_set_autosuspend_delay(&pdev->dev, MEI_ME_RPM_TIMEOUT);
180ea05bcedbd6 Tomas Winkler     2014-03-18  242  	pm_runtime_use_autosuspend(&pdev->dev);
180ea05bcedbd6 Tomas Winkler     2014-03-18  243  
f3d8e8788b4efb Alexander Usyskin 2014-06-23  244  	err = mei_register(dev, &pdev->dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  245  	if (err)
1f7e489a285c8b Alexander Usyskin 2016-02-07  246  		goto stop;
2703d4b2e673cc Tomas Winkler     2013-02-06  247  
2703d4b2e673cc Tomas Winkler     2013-02-06  248  	pci_set_drvdata(pdev, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  249  
557909e195aea2 Alexander Usyskin 2017-08-03  250  	/*
557909e195aea2 Alexander Usyskin 2017-08-03  251  	 * MEI requires to resume from runtime suspend mode
557909e195aea2 Alexander Usyskin 2017-08-03  252  	 * in order to perform link reset flow upon system suspend.
557909e195aea2 Alexander Usyskin 2017-08-03  253  	 */
e07515563d010d Rafael J. Wysocki 2020-04-18  254  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
557909e195aea2 Alexander Usyskin 2017-08-03  255  
e13fa90ce42d8e Tomas Winkler     2014-03-18  256  	/*
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  257  	 * ME maps runtime suspend/resume to D0i states,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  258  	 * hence we need to go around native PCI runtime service which
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  259  	 * eventually brings the device into D3cold/hot state,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  260  	 * but the mei device cannot wake up from D3 unlike from D0i3.
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  261  	 * To get around the PCI device native runtime pm,
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  262  	 * ME uses runtime pm domain handlers which take precedence
b42dc0635bf0a6 Alexander Usyskin 2017-09-26  263  	 * over the driver's pm handlers.
e13fa90ce42d8e Tomas Winkler     2014-03-18  264  	 */
e13fa90ce42d8e Tomas Winkler     2014-03-18  265  	mei_me_set_pm_domain(dev);
e13fa90ce42d8e Tomas Winkler     2014-03-18  266  
cc365dcf0e5627 Tomas Winkler     2018-01-02  267  	if (mei_pg_is_enabled(dev)) {
180ea05bcedbd6 Tomas Winkler     2014-03-18  268  		pm_runtime_put_noidle(&pdev->dev);
cc365dcf0e5627 Tomas Winkler     2018-01-02  269  		if (hw->d0i3_supported)
cc365dcf0e5627 Tomas Winkler     2018-01-02  270  			pm_runtime_allow(&pdev->dev);
cc365dcf0e5627 Tomas Winkler     2018-01-02  271  	}
180ea05bcedbd6 Tomas Winkler     2014-03-18  272  
c4e87b525936da Alexander Usyskin 2013-10-21  273  	dev_dbg(&pdev->dev, "initialization successful.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  274  
2703d4b2e673cc Tomas Winkler     2013-02-06  275  	return 0;
2703d4b2e673cc Tomas Winkler     2013-02-06  276  
1f7e489a285c8b Alexander Usyskin 2016-02-07  277  stop:
1f7e489a285c8b Alexander Usyskin 2016-02-07  278  	mei_stop(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  279  release_irq:
dc844b0d99b853 Tomas Winkler     2013-11-11  280  	mei_cancel_work(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  281  	mei_disable_interrupts(dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  282  	free_irq(pdev->irq, dev);
2703d4b2e673cc Tomas Winkler     2013-02-06  283  end:
2703d4b2e673cc Tomas Winkler     2013-02-06  284  	dev_err(&pdev->dev, "initialization failed.\n");
2703d4b2e673cc Tomas Winkler     2013-02-06  285  	return err;
2703d4b2e673cc Tomas Winkler     2013-02-06  286  }
2703d4b2e673cc Tomas Winkler     2013-02-06  287  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3aWLWzIKwedrEf8Br6mWfHlkAgA=

--PNTmBPCT7hxwcZjr--
