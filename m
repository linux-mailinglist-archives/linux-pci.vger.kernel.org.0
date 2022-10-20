Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC906061FB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJTNlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJTNla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 09:41:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE051A7A0E;
        Thu, 20 Oct 2022 06:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC9CBB82661;
        Thu, 20 Oct 2022 13:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D035C433D6;
        Thu, 20 Oct 2022 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666273263;
        bh=YsFcTa55ZQFPp0hOeLu/vtpfvJF13IE3dXu8sPusS9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hU++4MKiV/tZw08OHjSB/oNvjhtwTriYLPcXmwNHrx6ihtwizIERxo4J4tQEN8tgX
         v9P9FZeP7pJVvvhPp4mMLX6+xLZFjPxd1mwHaVC3PSR0A2Xu1V1undmXZUzEZ7VspG
         2L+wHLz33YyRgaTWoo5qCOv6EZ2xKsGz3sVmnvKypMPxB/PweR1DkK0sJDol7K9csR
         d0Ts5e8L9ueAV+RKCpLMpWqI00I6HMGeE9n8cDPjZl3lwCEeir7Iq79yJk6hebfEc+
         i9pSIPC2g9AiGCJ3u0ln5kSGw7fmSunAOAsr1r++MsYawyYPNdg/ynUHjWOnPkyR+6
         +gqMZktB2QLWQ==
Date:   Thu, 20 Oct 2022 08:41:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, kbuild-all@lists.01.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Joyce Ooi <joyce.ooi@intel.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
        Michal Simek <monstr@monstr.eu>,
        bcm-kernel-feedback-list@broadcom.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] PCI: Remove unnecessary of_irq.h includes
Message-ID: <20221020134101.GA90102@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210201618.NsgGYbMI-lkp@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 04:09:37PM +0800, kernel test robot wrote:
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
> config: ia64-randconfig-r026-20221020
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>         git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/

FYI, the instructions above didn't work for me.  Missing "config".

  $ git remote add linux-review https://github.com/intel-lab-lkp/linux
  $ git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
  $ git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
  HEAD is now at 273a24b16a40 PCI: Remove unnecessary of_irq.h includes
  $ mkdir build_dir && cp config build_dir/.config
  cp: cannot stat 'config': No such file or directory

  $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/
  Compiler will be installed in /home/bjorn/0day
  Cannot find ia64-linux under https://download.01.org/0day-ci/cross-package check /tmp/0day-ci-crosstool-files
  Please set new url, e.g. export URL=https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64
  gcc crosstool install failed
  Install gcc cross compiler failed
  setup_crosstool failed

