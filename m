Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E292178374C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 03:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjHVBTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 21:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjHVBTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 21:19:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AECD19B;
        Mon, 21 Aug 2023 18:19:44 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxXOovDeRkgMIaAA--.27554S3;
        Tue, 22 Aug 2023 09:19:43 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM4gDeRkSe1fAA--.37428S3;
        Tue, 22 Aug 2023 09:19:43 +0800 (CST)
Message-ID: <bc1e31ca-eb54-9696-792c-9749c0582167@loongson.cn>
Date:   Tue, 22 Aug 2023 09:19:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI/VGA: Make the vga_is_firmware_default() less
 arch-dependent
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-riscv@lists.infradead.org
References: <20230821173320.GA362442@bhelgaas>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230821173320.GA362442@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxvM4gDeRkSe1fAA--.37428S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1xAw1ruFy8ury3uFWfWFX_yoW8CFWxpa
        yfWFn8Cr4DAwnrArn2v3W8XF9avayrXrWUGrs8tr1rAF98uryF9r1rJw15Cwn3Z39rJa1j
        vrs8Jw1kGrs0qagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeQ6JUUUUU=
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/8/22 01:33, Bjorn Helgaas wrote:
> On Fri, Aug 18, 2023 at 09:48:46AM +0800, suijingfeng wrote:
>> On 2023/8/18 06:08, Bjorn Helgaas wrote:
>>>> +		if (resource_type(res) != IORESOURCE_MEM)
>>>> +			continue;
>>>> +
>>>> +		if (!res->start || !res->end)
>>>> +			continue;
>>>> +
>>>> +		if (res->start <= fb_start && fb_end <= res->end) {
>>>> +			pdev_boot_vga = pdev;
>>>> +
>>>> +			vgaarb_info(&pdev->dev,
>>>> +				    "BAR %d contains firmware FB\n", i);
>>> Print the BAR with %pR and include the framebuffer region from
>>> screen_info in the same format.
>> I do remember that you already told me to do this in V3, sorry for not
>> replying to you at V3. Most of the time, what you tell me is right.But here,
>> I think I need to explain. Because doing it that way will make the code line
>> too long,and it will exceed 80 characters in the column if we print too
>> much.
>> I believe that the vgaarb_info() at here is already the most compact and
>> simplest form. Printing the BAR with %pR is not absolute necessary, because
>> we can get the additional information by: $ lspci | grep VGA
>>
>> $ dmesg | grep 05:00.0
>> $ dmesg | grep 0000:03:00.0
>> $ dmesg | grep PCI
> Fair enough.  The BAR info is already there.  But I don't think the
> screen_info framebuffer data is in the dmesg log anywhere, and I think
> that would be useful.
>
> It's fine if dmesg lines or kernel printk lines exceed 80 columns.
>
>> Actually, I only add something that is absolute necessary.
>> Printing BAR with %pR and/or Printing the framebuffer region
>> is consider to only for *debugging* purpose.
> I think printing the framebuffer region is important because it makes
> it clear *why* we're selecting the device as the default VGA device.
> It's more than just debugging; it helps make the system more
> transparent and more understandable.

OK, I'm clear what to do next.
The printing will be added at the next version.

> Bjorn

