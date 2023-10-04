Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCB7B811A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjJDNiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 09:38:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE76AB;
        Wed,  4 Oct 2023 06:38:05 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Axjuu7ah1lXRgvAA--.21847S3;
        Wed, 04 Oct 2023 21:38:03 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxXNy5ah1lzTEYAA--.50898S3;
        Wed, 04 Oct 2023 21:38:03 +0800 (CST)
Message-ID: <59d609eb-e52c-7e81-073c-3e2f61e04583@loongson.cn>
Date:   Wed, 4 Oct 2023 21:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH pci-next v6 1/2] PCI/VGA: Make the
 vga_is_firmware_default() less arch-dependent
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231003155420.GA674372@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20231003155420.GA674372@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxXNy5ah1lzTEYAA--.50898S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry5ZFWDur4xXFyxKr4rWFX_yoW5XFyUpF
        4rtFWaya1DGr1fCr9Fvr4jqrWrZ3WkWFWYk3sYkr1kAr15Cr92qFyF9w4q9347Jrs7X3WY
        9F47G3WxJFWDGagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
        wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/10/3 23:54, Bjorn Helgaas wrote:
> PCI/VGA: Match firmware framebuffer before BAR reassignment
>
> vga_is_firmware_default() decides a device is the firmware default VGA
> device if it has a BAR that contains the framebuffer described by
> screen_info.
>
> Previously this was unreliable because the screen_info framebuffer address
> comes from firmware, and the Linux PCI core may reassign device BARs before
> vga_is_firmware_default() runs.  This reassignment means the BAR may not
> match the screen_info values, but we still want to select the device as the
> firmware default.
>
> Make vga_is_firmware_default() more reliable by running it as a quirk so it
> happens before any BAR reassignment.


On a specific architecture, the kernel have its own copy of screen_info.
We may choose to rely on the global screen_info, but I don't hope vgaarb
should completely depend on the firmware which without any flexibility.
After all, there are always have the old BIOS with the newer Kernel or
new graphics card combinations. That is to say that the BIOS(firmware)
is released first, then the new graphics comes after. So, we can't rely
on the BIOS know all of the graphics card in the world at the time of
BIOS release. If a BIOS don't know a specific video card, then then BIOS
is unlikely initialize a firmware framebuffer(UEFI GOP or something like
that) on it successfully.

I hope vgaarb can work without fully rely on the firmware, don't mention
the word 'firmware' as less as possible. Because, we can even modify the
kernel's screen_info by hardcode or fill it by parsing DT. We are only
rely on the global screen_info here. while how does the global screen_info
being filled is a kernel side and arch specific thing. The global screen_info
may rely on the BIOS, but this is a thing of the kernel side, vgaarb belong
to drivers directory.

Beside, the word 'firmware' have multiple meanings, for the patch at here,
it refer to the UEFI or uboot or something similar. But for the GPU domain,
it may refer to any binary executable on the macro-controller embedded in
the GPU IP. So I think the names 'is_firmware_default' and 'vga_is_firmware_default'
are putting *too much emphasis* the firmware. So I want to remove it.

vgaarb already have been exposed to userspace via sysfs interface (/sys/class/misc/vga_arbiter).
So the original spirit is actually allow user to tune or control. I hope vgaarb become more
standalone and more flexible so that there are some ways to rescue even in the worse case.
If someone (who have a better background or have better understanding toward a specific case only)
don't see this as a problem, then it is not my problem. I'm not good at debating with English.


  

