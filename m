Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAFE13D720
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 10:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgAPJmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 04:42:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgAPJmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 04:42:31 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B2D7A16DC7BAF3768560;
        Thu, 16 Jan 2020 17:42:29 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 Jan 2020
 17:41:59 +0800
Subject: Re: [PATCH] PCI: Improve link speed presentation process
To:     kbuild test robot <lkp@intel.com>
References: <1578989494-20583-1-git-send-email-yangyicong@hisilicon.com>
 <202001161542.CdWrJ2ZG%lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <35f30246-693a-ac44-d0a1-9573a5d2bd7e@hisilicon.com>
Date:   Thu, 16 Jan 2020 17:42:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <202001161542.CdWrJ2ZG%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, 
It seems like we have met the problem you indicated, that using pci_bus_speed_strings[] in
PCIE_BUS_SPEED2STR macro is only available when CONFIG_SYSFS=y.

I have moved the string array to probe.c in the new patch set according to the suggestions.
I hope it has not been buried in the mail list.
https://lore.kernel.org/linux-pci/1579079063-5668-1-git-send-email-yangyicong@hisilicon.com/

On 2020/1/16 15:45, kbuild test robot wrote:
> Hi Yicong,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on v5.5-rc6 next-20200110]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Yicong-Yang/PCI-Improve-link-speed-presentation-process/20200114-163536
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: ia64-allnoconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/pci/pci-sysfs.o: In function `max_link_speed_show':
>>> pci-sysfs.c:(.text+0x1e01): undefined reference to `pci_bus_speed_strings'
>    pci-sysfs.c:(.text+0x1e10): undefined reference to `pci_bus_speed_strings'
>    drivers/pci/pci-sysfs.o: In function `current_link_speed_show':
>    pci-sysfs.c:(.text+0x2070): undefined reference to `pci_bus_speed_strings'
>    pci-sysfs.c:(.text+0x2080): undefined reference to `pci_bus_speed_strings'
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


