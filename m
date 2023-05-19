Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D6709033
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjESHNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 03:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESHNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 03:13:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC77310D0;
        Fri, 19 May 2023 00:13:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cx_eqXIWdkChkKAA--.17539S3;
        Fri, 19 May 2023 15:13:27 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxX+SQIWdk0IVpAA--.48203S3;
        Fri, 19 May 2023 15:13:20 +0800 (CST)
Subject: Re: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
To:     kernel test robot <lkp@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
 <202305190105.O6ycxCti-lkp@intel.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <933c829f-0d27-f3b9-3db6-f2211495b086@loongson.cn>
Date:   Fri, 19 May 2023 15:13:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202305190105.O6ycxCti-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxX+SQIWdk0IVpAA--.48203S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw13AFW5ZFWkZFWUCw13twb_yoW5Jw4xpa
        yUZrZFkr1Fqr18GayxGa4Uu3WYgrs5Ja4Ygr98Gw45ZrZrZa42qrs2kFy5trnrK3Z7GFy7
        AFyfXrWv9a48Ja7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYnmiUUUUU=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/5/19 上午1:52, kernel test robot 写道:
> Hi Yinbo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus westeri-thunderbolt/next linus/master v6.4-rc2 next-20230518]
> [cannot apply to usb/usb-testing usb/usb-next usb/usb-linus]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/usb-dwc2-add-pci_device_id-driver_data-parse-support/20230518-173721
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20230518092240.8023-1-zhuyinbo%40loongson.cn
> patch subject: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
> config: powerpc-allmodconfig
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/3ff56448e1442fe8b1e72651a8d4d6e1086ece32
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yinbo-Zhu/usb-dwc2-add-pci_device_id-driver_data-parse-support/20230518-173721
>          git checkout 3ff56448e1442fe8b1e72651a8d4d6e1086ece32
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305190105.O6ycxCti-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "dwc2_pci_ids" [drivers/usb/dwc2/dwc2_pci.ko] undefined!


I test it was set dwc2 pci driver as built-in, so no error, this compile
error was that dwc2_pci_ids not export when driver as module and I will
add EXPORT_SYMBOL_GPL(dwc2_pci_ids) to fix that compile issue.

Thanks.
> 

