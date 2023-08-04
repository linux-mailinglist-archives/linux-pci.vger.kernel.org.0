Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44676F845
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 05:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHDDNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHDDNK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 23:13:10 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F12C049E9;
        Thu,  3 Aug 2023 20:11:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cxc_BtbMxkowEQAA--.37082S3;
        Fri, 04 Aug 2023 11:11:41 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ81QbMxkdMpHAA--.52126S3;
        Fri, 04 Aug 2023 11:11:34 +0800 (CST)
Message-ID: <8e51eb50-aa7b-f771-e53b-499bf899e22e@loongson.cn>
Date:   Fri, 4 Aug 2023 11:11:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PCI/VGA: Make the vga_is_firmware_default()
 arch-independent
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230803081758.968742-1-suijingfeng@loongson.cn>
 <202308032022.yiZngbbk-lkp@intel.com>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <202308032022.yiZngbbk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxJ81QbMxkdMpHAA--.52126S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFWDCryktr47tw15AFW3CFX_yoW5tFWkpF
        W8JF1ayF4kGr4fK392gryUur1Yvws8XFy3WrsxC3sruFyDZry0qr4SkrZ0gr9Ikr4xCF1j
        yrnxtry0ka4kAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/8/3 20:25, kernel test robot wrote:
> Hi Sui,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on pci/next]
> [also build test ERROR on pci/for-linus linus/master v6.5-rc4 next-20230803]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/PCI-VGA-Make-the-vga_is_firmware_default-arch-independent/20230803-161838
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/20230803081758.968742-1-suijingfeng%40loongson.cn
> patch subject: [PATCH] PCI/VGA: Make the vga_is_firmware_default() arch-independent
> config: arm64-randconfig-r026-20230731 (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230803/202308032022.yiZngbbk-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308032022.yiZngbbk-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> ld.lld: error: undefined symbol: screen_info
>     >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
>     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
>     >>> referenced by vgaarb.c:86 (drivers/pci/vgaarb.c:86)
>     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
>     >>> referenced by vgaarb.c:88 (drivers/pci/vgaarb.c:88)
>     >>>               drivers/pci/vgaarb.o:(vga_arb_firmware_fb_addr_tracker) in archive vmlinux.a
>     >>> referenced 3 more times
>
This is a more like arch-specific problem, It will be pain at many places on platforms
that do not export the screen_info symbol. Not only here.

I have already explained that screen_info is arch-dependent many times, but no one cares about me.
By using (looking at) screen_info, vgaarb gets infected, and becomes arch-dependent as well.
vgaarb deals with VGA class (pdev->class == 0x0300XX) devices only, This makes it device-dependent.
Hence, It only works correctly for a small set of PCIe devices on x86.

arch-dependent, device-dependent, subsystem-dependent (part of it rely on ACPI) and
loading order dependent, those dependent itself are the problems.
It results in various undefined (uncertain) behaviors on non-x86 architectures.

Even on x86, some platform choose to relay on the firmware to solve the multiple GPU coexist problem.
so it is also firmware-dependent.

This patch solves part of the above problems listed, target at the *device level*, as early as possible.
while they still a few problems could be only solved at the *driver level*.
For an example, The display controller in Intel N2000 and d2000 series don't has a dedicated VRAM bar.
they use the "stolen memory", which is carve out by somebody (either bios or kernel?).


