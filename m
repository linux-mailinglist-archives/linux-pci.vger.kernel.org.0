Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BCC589A65
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbiHDKZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Aug 2022 06:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiHDKZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Aug 2022 06:25:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7E97;
        Thu,  4 Aug 2022 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659608710; x=1691144710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TMv41kPjFNwEES+IgD1kd1GmqY4KLGHdI4MsZyeLejA=;
  b=AazTVLbsvW4NY5ZF2w32Gr0m9LQ5XQ87ZyJWl4DvlMUUanJxOskjsYMk
   UMz52mV84ZRfudicXmhSFR/1qOO2wQTTvZmOHS5PC6IJwi9hRdg16ituB
   kqgO9kdd4RoUXOGJ92j3/cCUQvWlLYLf6qH9gT3T52RXcFeckT04r93Ne
   wirWD2VSLr56hcSuwQSbydyqrGQsbGwApjPMTJu69E8gO3DYefjEzrraj
   xApq0RG3/PtSgUDRQt+KW8mGz9UrT7Xd902kvZtvzQcLwutFYM4UxXrpp
   jX7Qpq5QP8CmijU979i3fVXdkIDpQZWZr2xFWsNFUzk28bYdQ3B4ftHJv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="269672283"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="269672283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 03:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="779316253"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2022 03:25:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJY2J-000IIL-13;
        Thu, 04 Aug 2022 10:25:03 +0000
Date:   Thu, 4 Aug 2022 18:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci
 suspend
Message-ID: <202208041800.BLHfNzzW-lkp@intel.com>
References: <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on next-20220803]
[cannot apply to linus/master v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: s390-randconfig-r044-20220804 (https://download.01.org/0day-ci/archive/20220804/202208041800.BLHfNzzW-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9e799ab52db3245911b15a8903977d99554d900d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-chaitanya-chundru/PCI-Restrict-pci-transactions-after-pci-suspend/20220803-193033
        git checkout 9e799ab52db3245911b15a8903977d99554d900d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pci/controller/dwc/pcie-designware-host.c:11:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/pci/controller/dwc/pcie-designware-host.c:11:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/pci/controller/dwc/pcie-designware-host.c:11:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/pci/controller/dwc/pcie-designware-host.c:33:24: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct pcie_port, struct dw_pcie_rp) || __builtin_types_compatible_p(struct pcie_port, void)': pointer type mismatch in container_of()
           struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.h:327:34: note: expanded from macro 'to_dw_pcie_from_pp'
   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
           static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                           ^              ~~~~
   drivers/pci/controller/dwc/pcie-designware-host.c:44:24: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct pcie_port, struct dw_pcie_rp) || __builtin_types_compatible_p(struct pcie_port, void)': pointer type mismatch in container_of()
           struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-designware.h:327:34: note: expanded from macro 'to_dw_pcie_from_pp'
   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:2: note: expanded from macro 'container_of'
           static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:41: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                           ^              ~~~~
   12 warnings and 2 errors generated.


vim +33 drivers/pci/controller/dwc/pcie-designware-host.c

    29	
    30	static void dw_msi_mask_irq(struct irq_data *d)
    31	{
    32		struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
  > 33		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
    34	
    35		if (dw_pcie_link_up(pci))
    36			pci_msi_mask_irq(d);
    37	
    38		irq_chip_mask_parent(d);
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
