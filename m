Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE067816C2
	for <lists+linux-pci@lfdr.de>; Sat, 19 Aug 2023 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbjHSCkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 22:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244235AbjHSCke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 22:40:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 056273ABC;
        Fri, 18 Aug 2023 19:40:31 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxLOudK+BkdQ0aAA--.48059S3;
        Sat, 19 Aug 2023 10:40:29 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uScK+BksBReAA--.33767S3;
        Sat, 19 Aug 2023 10:40:29 +0800 (CST)
Message-ID: <ed87b8de-9fb6-fbee-2c6d-cebf712ccda5@loongson.cn>
Date:   Sat, 19 Aug 2023 10:40:28 +0800
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
        dri-devel@lists.freedesktop.org
References: <20230817220853.GA328159@bhelgaas>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230817220853.GA328159@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Ax8uScK+BksBReAA--.33767S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr48uw4xGw17Zr43Xry3WrX_yoW8CF48pr
        4YganrGF4kG3Z7A3sxAws5XF45uayvyFZ8Gry5Ar18ur45Gr1aqrnrKrZ0gwnrCrnxt3WS
        krn8Kr4IkFyDZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/8/18 06:08, Bjorn Helgaas wrote:
> I guess the point here is that:
>
>    - 03:00.0 BAR 0 is [mem 0xe0050000000-0xe005fffffff]
>
>    - screen_info says the framebuffer is
>      [mem 0xe0050000000-0xe005fffffff] (or part of it)
>
>    - Therefore, we want 03:00.0 to be the default VGA
>
>    - PCI core reassigns 03:00.0 BAR 0 to
>      [mem 0xe0030000000-0xe003fffffff]
>
>    - PCI core assigns a 00:06.1 BAR to contain
>      [mem 0xe0050000000-0xe005fffffff]
>
>    - vga_is_firmware_default() incorrectly decides 00:06.1 should be
>      the default VGA because it has a BAR that contains the screen_info
>      address range
>
> Is that right?

Yes, The 00:06.1 is loongson integrated display controller, integrated in LS7A1000 North bridge.


On loongarch, before apply apply any patch, VGAARB always select 00:06.1 as the default boot device.
because it is enumerated first. It is always the first VGA compatible device found on our system.
Because its PCI domain, bus, function number is smallest. And it own IO and MEM, so the 00:06.1 will
always be selected as the default boot device. Even you plug a discrete GPU on the mother board.


Therefore we need help the vga_is_firmware_default() to overriding previous.
On a multiple GPU co-exist case (on loongson platform), if no "overriding previous" being printed.
then there something wrong. On normal case, we need the discrete GPU overriding the integrated one.
Because the discrete GPU is more powerful than the platform integrated.

But what we want is let the VGAARB determine the primary GPU by referencing the firmware.

If firmware put the firmware framebuffer in the VRAM of the integrated display card(00:06.1).
then the integrated display card should be the primary GPU.

If firmware put the firmware framebuffer in the VRAM of the discrete display card,
then the discrete display card should be the primary GPU.

