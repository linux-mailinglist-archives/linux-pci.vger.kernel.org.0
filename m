Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1920354AFC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 04:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbhDFCl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Apr 2021 22:41:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16341 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhDFCl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Apr 2021 22:41:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FDsDm70Yfz9wSf;
        Tue,  6 Apr 2021 10:39:36 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 10:41:42 +0800
Subject: Re: [PATCH 4/4] PCI: Enable 10-Bit tag support for PCIe RP devices
To:     kernel test robot <lkp@intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1617440059-2478-5-git-send-email-liudongdong3@huawei.com>
 <202104032041.7KejD0wG-lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <clang-built-linux@googlegroups.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <2c074283-3822-18ec-4907-4eef6247f065@huawei.com>
Date:   Tue, 6 Apr 2021 10:41:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <202104032041.7KejD0wG-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Thnaks for your report. I made a mistake.
Maybe I need to move these functions implementation
to drivers/pci/pcie/portdrv_pci.c. No need to
define in drivers/pci/pci.h

Thanks,
Dongdong
On 2021/4/3 20:33, kernel test robot wrote:
> Hi Dongdong,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on v5.12-rc5 next-20210401]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Dongdong-Liu/PCI-Enable-10-Bit-tag-support-for-PCIe-devices/20210403-171726
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: x86_64-randconfig-a004-20210403 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 0fe8af94688aa03c01913c2001d6a1a911f42ce6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/c1497e514c78375b8c9e9e074e5b84c62eaef20f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Dongdong-Liu/PCI-Enable-10-Bit-tag-support-for-PCIe-devices/20210403-171726
>         git checkout c1497e514c78375b8c9e9e074e5b84c62eaef20f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/pci/probe.c:2096:6: error: redefinition of 'pci_configure_rp_10bit_tag'
>    void pci_configure_rp_10bit_tag(struct pci_dev *dev)
>         ^
>    drivers/pci/pci.h:468:20: note: previous definition is here
>    static inline void pci_configure_rp_10bit_tag(struct pci_dev *dev) {}
>                       ^
>    1 error generated.
>
>
> vim +/pci_configure_rp_10bit_tag +2096 drivers/pci/probe.c
>
>   2095	
>> 2096	void pci_configure_rp_10bit_tag(struct pci_dev *dev)
>   2097	{
>   2098		u8 support = 1;
>   2099		u32 cap;
>   2100		int ret;
>   2101	
>   2102		if (!pci_is_pcie(dev))
>   2103			return;
>   2104	
>   2105		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
>   2106			return;
>   2107	
>   2108		if (dev->subordinate == NULL)
>   2109			return;
>   2110	
>   2111		pci_10bit_tag_comp_support(dev, &support);
>   2112		if (!support)
>   2113			return;
>   2114	
>   2115		/*
>   2116		 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
>   2117		 * In configurations where a Requester with 10-Bit Tag Requester capability
>   2118		 * needs to target multiple Completers, one needs to ensure that the
>   2119		 * Requester sends 10-Bit Tag Requests only to Completers that have 10-Bit
>   2120		 * Tag Completer capability. So we enable 10-Bit Tag Requester for root port
>   2121		 * only when the devices under the root port support 10-Bit Tag Completer.
>   2122		 */
>   2123		pci_walk_bus(dev->subordinate, pci_10bit_tag_comp_support, &support);
>   2124		if (!support)
>   2125			return;
>   2126	
>   2127		ret = pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
>   2128		if (ret)
>   2129			return;
>   2130	
>   2131		if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ))
>   2132			return;
>   2133	
>   2134		pci_info(dev, "enabling 10-Bit Tag Requester\n");
>   2135		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>   2136					 PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN);
>   2137	}
>   2138	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
