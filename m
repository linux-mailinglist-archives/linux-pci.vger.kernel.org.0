Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9F6063CF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJTPHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJTPHh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 11:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E1BE05;
        Thu, 20 Oct 2022 08:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20CC3B826A2;
        Thu, 20 Oct 2022 15:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD5CC433D6;
        Thu, 20 Oct 2022 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666278452;
        bh=rk4FkyTj63SqjU/doWeGOOjxnw9Z66lex5OFbxvboaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sdxCERJblo0QG0GrtZ7yNTFcOmznqbm5pyuIU6DeQbXsLVWAHBxCtmkVx4dhU8ITY
         DRiZC+TTV5nRKxaIcv7JxpZsJMFkNKkYNgiAd6Ewf2ucq73OeCc379PlMsVa0yLOET
         m0t0PH6oy//zs7NK2hg6BUkYu0lc/vF17DUo7tgT+UE7eA2wi4z+35BPalepsK/KvQ
         1gQ+1WZ4haNBpW1SqDj/RYdcjRoHIqbhU/0rsgvdlemG0AH78b2atshNKoaoL4A4lg
         TXnutMAL0I8rZT7kX+Nm4PlwBY+ATOEVQUUvPRHq/E2EAqVfJ+0UqhVPEsfLOZV2sf
         EmpP3TjySOGbg==
Date:   Thu, 20 Oct 2022 10:07:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <20221020150731.GA121202@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210202204.u22wJti3-lkp@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 10:13:10PM +0800, kernel test robot wrote:
> Hi Bjorn,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on helgaas-pci/next]
> [also build test ERROR on xilinx-xlnx/master rockchip/for-next linus/master v6.1-rc1 next-20221020]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> patch link:    https://lore.kernel.org/r/20221019195452.37606-1-helgaas%40kernel.org
> patch subject: [PATCH] PCI: Remove unnecessary of_irq.h includes
> config: s390-randconfig-r044-20221019
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>         git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/

Maybe more user error?

  $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/
  Compiler will be installed in /home/bjorn/0day
  make --keep-going HOSTCC=/home/bjorn/0day/clang/bin/clang CC=/home/bjorn/0day/clang/bin/clang OBJCOPY=/usr/s390x-linux-gnu/bin/objcopy AR=llvm-ar NM=llvm-nm STRIP=llvm-strip OBJDUMP=llvm-objdump OBJSIZE=llvm-size READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar CROSS_COMPILE=s390x-linux-gnu- --jobs=16 W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/pci/controller/
  make[1]: Entering directory '/home/bjorn/linux/build_dir'
    SYNC    include/config/auto.conf.cmd
    GEN     Makefile
  scripts/Kconfig.include:40: linker 's390x-linux-gnu-ld' not found
  make[3]: *** [../scripts/kconfig/Makefile:77: syncconfig] Error 1
  make[2]: *** [../Makefile:697: syncconfig] Error 2
  make[1]: *** [/home/bjorn/linux/Makefile:798: include/config/auto.conf.cmd] Error 2
  make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
  make[1]: Failed to remake makefile 'include/config/auto.conf'.
    GEN     Makefile
  Error: kernelrelease not valid - run 'make prepare' to update it
  ../scripts/mkcompile_h: 19: s390x-linux-gnu-ld: not found
  make[1]: Target 'drivers/pci/controller/' not remade because of errors.
  make[1]: Leaving directory '/home/bjorn/linux/build_dir'
  make: *** [Makefile:231: __sub-make] Error 2
  make: Target 'drivers/pci/controller/' not remade because of errors.

