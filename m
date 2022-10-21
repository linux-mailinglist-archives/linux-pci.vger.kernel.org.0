Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01587606CA4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 02:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJUAuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 20:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJUAuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 20:50:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999F3ED66;
        Thu, 20 Oct 2022 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666313398; x=1697849398;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EouB8ThNo2sWMhfV1Mcpy1sEPBvn+PIid4ogFAJ3BJg=;
  b=kbsu/iwhe5IzV5x7ONS+sx/lbg+zeKUYoopcb2da8Cy+BOll2nLBq1KB
   sJ7EJznZGqH8iAE75Ops40puxLYxqOMU9qx2FRfDB+yZfT6cNdpt7H6B1
   4MqoXPFhRbY8AGd/YkOVv9CBo8oR1cG4OD0dSfynz54OlGOXCVMr+5ptT
   jBRq3rq4BMISqbjZBLD0cAgg8odvG/5X3yGEmyEgxiMsg2OwIZJ+ZsGaZ
   Z7O4oy/kPJ0wt3ixfBvFMcTWJ8emXcdAuwtEdWRqkn+I40qPKA3gHkbtA
   XomxxJUvE670smv0KPtnDLlRgho/WaLM853OFJN7zHFyS0PNR2RtVB/WE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287278715"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287278715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:49:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661274898"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661274898"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.222]) ([10.249.172.222])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:49:49 -0700
Subject: Re: [kbuild-all] Re: [PATCH] PCI: Remove unnecessary of_irq.h
 includes
To:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, kbuild-all@lists.01.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
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
        linux-pci@vger.kernel.org, "linux-ar m-kernel"@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221020134101.GA90102@bhelgaas>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7e7d18e2-17a2-9b61-4b3c-252556f8b6be@intel.com>
Date:   Fri, 21 Oct 2022 08:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221020134101.GA90102@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/20/2022 9:41 PM, Bjorn Helgaas wrote:
> On Thu, Oct 20, 2022 at 04:09:37PM +0800, kernel test robot wrote:
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
>> config: ia64-randconfig-r026-20221020
>> compiler: ia64-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>>          git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/
> 
> FYI, the instructions above didn't work for me.  Missing "config".
> 
>    $ git remote add linux-review https://github.com/intel-lab-lkp/linux
>    $ git fetch --no-tags linux-review Bjorn-Helgaas/PCI-Remove-unnecessary-of_irq-h-includes/20221020-100633
>    $ git checkout 273a24b16a40ffd6a64c6c55aecbfae00a1cd996
>    HEAD is now at 273a24b16a40 PCI: Remove unnecessary of_irq.h includes
>    $ mkdir build_dir && cp config build_dir/.config
>    cp: cannot stat 'config': No such file or directory
> 
>    $ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/
>    Compiler will be installed in /home/bjorn/0day
>    Cannot find ia64-linux under https://download.01.org/0day-ci/cross-package check /tmp/0day-ci-crosstool-files

Hi Bjorn,

Sorry for the inconvenience, the 01.org website is unstable recently, 
could you try 
"URL=https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64 
COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 
O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/pci/controller/"?

Best Regards,
Rong Chen

>    Please set new url, e.g. export URL=https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64
>    gcc crosstool install failed
>    Install gcc cross compiler failed
>    setup_crosstool failed
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
