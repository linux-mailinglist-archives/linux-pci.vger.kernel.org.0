Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19A780506
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 06:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352909AbjHREKI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 00:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357865AbjHREJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 00:09:36 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D987D3A80;
        Thu, 17 Aug 2023 21:09:33 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxbOr77t5kqscZAA--.25644S3;
        Fri, 18 Aug 2023 12:09:31 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCP67t5kQlxdAA--.13538S3;
        Fri, 18 Aug 2023 12:09:30 +0800 (CST)
Message-ID: <31ceb1b8-52e8-f57b-0e76-ea768242e26e@loongson.cn>
Date:   Fri, 18 Aug 2023 12:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI/VGA: Make the vga_is_firmware_default() less
 arch-dependent
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        loongson-kernel@lists.loongnix.cn, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <20230817220853.GA328159@bhelgaas>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230817220853.GA328159@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxPCP67t5kQlxdAA--.13538S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF1UKr1xGr18Aw4DuF4rJFc_yoW5AFyUp3
        yrCF1FkF4kArnakrnrGw4kXF1rAws7Xa4FkFn0y34DA343Zrn2qrySkrWqgFyUZrs7X3W2
        vF40gwn5GayqvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
        UU=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/8/18 06:08, Bjorn Helgaas wrote:
> On Wed, Aug 16, 2023 at 06:05:27AM +0800, Sui Jingfeng wrote:
>> Currently, the vga_is_firmware_default() function only works on x86 and
>> ia64, it is a no-op on ARM, ARM64, PPC, RISC-V, etc. This patch completes
>> the implementation for the rest of the architectures. The added code tries
>> to identify the PCI(e) VGA device that owns the firmware framebuffer
>> before PCI resource reallocation happens.
> As far as I can tell, this is basically identical to the existing
> vga_is_firmware_default(), except that this patch funs that code as a
> header fixup, so it happens before any PCI BAR reallocations happen.


Yes, what you said is right in overall.
But I think I should mention a few tiny points that make a difference.

1) My version is *less arch-dependent*


Again, since the global screen_info is arch-dependent.
The vga_is_firmware_default() mess up the arch-dependent part and arch-independent part.
It's a mess and it's a bit harder to make the cleanup on the top of it.

While my version is my version split the arch-dependent part and arch-independent part clearly.
Since we decide to make it less arch-dependent, we have to bear the pain.
Despite all other arches should always export the screen_info like the X86 and IA64 arch does,
or at least a arch should give a Kconfig token (for example, CONFIG_ARCH_HAS_SCREEN_INFO) to
demonstrate that an arch has the support for it.
While currently, the fact is that the dependence just populated to everywhere.
I think this is the hard part, you have to investigate how various arches defines and set up
the screen_info. And then process dependency and the linkage problem across arch properly.


2) My version focus on the address in ranges, weaken the size parameter.

Which make the code easy to read and follow the canonical convention to
express the address range. while the vga_is_firmware_default() is not.


3) A tiny change make a big difference.


The original vga_is_firmware_default() only works with the assumption
that the PCI resource reallocation won't happens. While I see no clue
that why this is true even on X86 and IA64. The original patch[1] not
mention this assumption explicitly.
  
[1] 86fd887b7fe3 ('vgaarb: Don't default exclusively to first video device with mem+io')


> That sounds like a good idea, because this is all based on the
> framebuffer in screen_info, and screen_info was initialized before PCI
> enumeration, and it certainly doesn't account for any BAR changes done
> by the PCI core.


Yes.


> So why would we keep vga_is_firmware_default() at all?  If the header
> fixup has already identified the firmware framebuffer, it seems
> pointless to look again later.
>

It need another patch to do the cleanup work, while my patch just add code to solve the real problem.
It focus on provide a solution for the architectures which have a decent way set up the screen_info.
Other things except that is secondary.

