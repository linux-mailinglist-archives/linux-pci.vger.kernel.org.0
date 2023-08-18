Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116E27809E6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 12:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjHRKUv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358987AbjHRKUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 06:20:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B9741706;
        Fri, 18 Aug 2023 03:20:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxbOr9Rd9kL9gZAA--.25769S3;
        Fri, 18 Aug 2023 18:20:45 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHCP8Rd9kYIpdAA--.13478S3;
        Fri, 18 Aug 2023 18:20:44 +0800 (CST)
Message-ID: <fb242a7e-b1ee-7be0-cbc4-be710e246279@loongson.cn>
Date:   Fri, 18 Aug 2023 18:20:44 +0800
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
X-CM-TRANSID: AQAAf8BxHCP8Rd9kYIpdAA--.13478S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWrGr4fCF15Jr4DCF1xZwc_yoW5XryfpF
        yfua93tF4kWrs8KanFvw18WF47urZ7Aa9xArnxJry0kr43W34FgrZIkr4Yya47JFsaqFyS
        va9Fq348t3WDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/8/18 06:08, Bjorn Helgaas wrote:
>> Please note that before apply this patch, vgaarb can not select the
>> right boot vga due to weird logic introduced with the commit
>> 57fc7323a8e7c ("LoongArch: Add PCI controller support")
> If we need this reference to 57fc7323a8e7c, we need more specifics
> about what the "weird logic" is.  pci_fixup_vgadev() is the only
> obvious VGA connection, so I suppose it's related to that.
>
Yes, you are right.

The pci_fixup_vgadev() function will set the last VGA device enumerated as the default boot device.
By "the last" VGA device, I mean that this device has the largest PCI bus, domain, and function triple.
Thus, it is added to vgaarb in the end of all VGA device.
So that logic expresses that the last one added will be the default.
This probably is not what we want.


On the LS3A5000+LS7A1000 platform, the last VGA device is a S3 graphics 
(08:00.0). This GPU has two cores. Say the log below:


$ lspci | grep VGA

  00:06.1 VGA compatible controller: Loongson Technology LLC DC (Display Controller) (rev 01)
  03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
  07:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)
  08:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)

[    0.361781] vgaarb: loaded
[    0.367838] pci 0000:00:06.1: Overriding boot device as 1002:6778
[    0.367841] pci 0000:00:06.1: Overriding boot device as 5333:9070
[    0.367843] pci 0000:00:06.1: Overriding boot device as 5333:9070

1) The "weird" logic completely overrides whatever decision VGAARB ever made.

It seems to say that the decision ever made by VGAARB is useless.
Well, I think VGAARB shouldn't endure this; VGAARB has to be small.

  

2) The results it gives are not correct either.

In the first testing example in my commit message,
it overrides the S3 graphics as the default boot VGA instead of the AMD/ATI GPU.
Actually, the firmware chooses the AMD/ATI GPU as the "frimware default".

  

3) It tries to make the decision for the end user instead of the firmware.

Therefore, that function is always wrong. Again, it's a policy, not a mechanism.


Since that already have been merge, I'm fine.
Maybe Huacai is busy, he might don't has the time to carry on a deep thinking.
But I think we should correct the mistake ever made,
let's merge this patch to make vgaarb great again ?


Well, that commit is not a dependency, I don't mind delete the referencing
to that commit. After all, I think my patch will be effective on other architectures.
Is additional testing on ARM64 and X86 is needed, if so I have to find the machine to
carry on the testing.

