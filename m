Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E47606CAF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 02:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJUAw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 20:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJUAw4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 20:52:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C6230AB2;
        Thu, 20 Oct 2022 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666313571; x=1697849571;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t8eukQQRNGfAZeDiwMZwSJzWT294/JgXyPrPo/qNp6g=;
  b=ZtK6dDj5xf+TztAflG22tT3twX9N2MOfJNYt9kLPReA22KyumiiCZL0+
   dLvl3N84uoPnESmxTok4D14AoGegrz6byJF2ERX9bljD+Mecda458TqjS
   9aOLT7ltQxfaGxsizcACSwc5pc+/vOMg0WFslwGeXehMjC1D0efbNoU03
   6Qy3qFFvjEpHQBad6HTZ3Nx6mSaKWQ/Wluc1msHXnlMEd+hIQ22wMNvcF
   jN+1KHmFBRGMEgD2uHOc2wPG3XPX8Eepfn4MowSNn1dK/PKsisQdcLfJx
   OBHTt38hFHowgOFIRIbcanptldJX57WmgJ2ojPWhzovO/+C5MnAzjLd9W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294275824"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="294275824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:52:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608037424"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608037424"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.222]) ([10.249.172.222])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:52:42 -0700
Subject: Re: [kbuild-all] Re: [PATCH] PCI: Remove unnecessary of_irq.h
 includes
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, llvm@lists.linux.dev,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Toan Le <toan@os.amperecomputing.com>,
        linux-riscv@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>, Joyce Ooi <joyce.ooi@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ray Jui <rjui@broadcom.com>, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Michal Simek <monstr@monstr.eu>,
        kbuild-all@lists.01.org, Scott Branden <sbranden@broadcom.com>,
        Daire McNa mara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20221020150731.GA121202@bhelgaas>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <9ac1f194-cef3-68bf-25e2-4bc6c0dbefce@intel.com>
Date:   Fri, 21 Oct 2022 08:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221020150731.GA121202@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/20/2022 11:07 PM, Bjorn Helgaas wrote:
> On Thu, Oct 20, 2022 at 10:13:10PM +0800, kernel test robot wrote:
>> Hi Bjorn,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on helgaas-pci/next]
>> [also build test ERROR on xilinx-xlnx/master rockchip/for-next linus/master v6.1-rc1 next-20221020]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> patch link:    https://lore.kernel.org/r/20221019195452.37606-1-helgaas%40kernel.org
>> patch subject: [PATCH] PCI: Remove unnecessary of_irq.h includes
>> config: s390-randconfig-r044-20221019
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install s390 cross compiling tool for clang build
>>          # apt-get install binutils-s390x-linux-gnu
>>          # https://github.com/intel-lab-lkp/linux/commit/273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>>          git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/
> 
> Maybe more user error?
> 
>    $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/
>    Compiler will be installed in /home/bjorn/0day
>    make --keep-going HOSTCC=/home/bjorn/0day/clang/bin/clang CC=/home/bjorn/0day/clang/bin/clang OBJCOPY=/usr/s390x-linux-gnu/bin/objcopy AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=s390x-linux-gnu- --jobs=16 W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/
>    make[1]: Entering directory '/home/bjorn/linux/build_dir'
>      SYNC    include/config/auto.conf.cmd
>      GEN     Makefile
>    scripts/Kconfig.include:40: linker 's390x-linux-gnu-ld' not found


Hi Bjorn,

You may need to install the below package, or similar package for other OS:

$ dpkg -S /usr/bin/s390x-linux-gnu-ld
binutils-s390x-linux-gnu: /usr/bin/s390x-linux-gnu-ld

 >>          # install s390 cross compiling tool for clang build
 >>          # apt-get install binutils-s390x-linux-gnu

Best Regards,
Rong Chen

>    make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
>    make[2]: *** [../Makefile:697: syncconfig] Error 2
>    make[1]: *** [/home/bjorn/linux/Makefile:798: include/config/auto.conf.cmd] Error 2
>    make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
>    make[1]: Failed to remake makefile 'include/config/auto.conf'.
>      GEN     Makefile
>    Error: kernelrelease not valid - run 'make prepare' to update it
>    ../scripts/mkcompile_h: 19: s390x-linux-gnu-ld: not found
>    make[1]: Target 'drivers/pci/controller/' not remade because of errors.
>    make[1]: Leaving directory '/home/bjorn/linux/build_dir'
>    make: *** [Makefile:231: __sub-make] Error 2
>    make: Target 'drivers/pci/controller/' not remade because of errors.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
