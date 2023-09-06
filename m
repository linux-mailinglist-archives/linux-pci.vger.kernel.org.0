Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB38A7938D3
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbjIFJs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjIFJsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 05:48:55 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F8041994;
        Wed,  6 Sep 2023 02:48:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxpPDxSvhkEkggAA--.64746S3;
        Wed, 06 Sep 2023 17:48:33 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yPvSvhkg2huAA--.28402S3;
        Wed, 06 Sep 2023 17:48:31 +0800 (CST)
Message-ID: <3f41eea5-d441-304d-f441-eaf7ce63d3e1@loongson.cn>
Date:   Wed, 6 Sep 2023 17:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <151c0429-dbc2-e987-1491-6c733ca159ac@suse.de>
 <3eced3f5-622f-31a6-f8a0-ff0812be74ff@loongson.cn>
 <6035cf27-1506-dda7-e1ca-d83ce5cb5340@suse.de>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <6035cf27-1506-dda7-e1ca-d83ce5cb5340@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yPvSvhkg2huAA--.28402S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF4UuFWxWr17Gw47JryrAFc_yoWxJw17pF
        ykuay5KF4kJrn5C340v3WUuFWFq3y8JFWfJrn3G345ua90kryUZFZFgw4Y9asrCr4fXF15
        tF4Ut3429343AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7pnQUU
        UUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/9/6 16:05, Thomas Zimmermann wrote:
> Hi
>
> Am 05.09.23 um 17:59 schrieb suijingfeng:
> [...]
>>> FYI: per-driver modeset parameters are deprecated and not to be 
>>> used. Please don't promote them.
>>
>>
>> Well, please wait, I want to explain.
>>
>>
>>
>> drm/nouveau already promote it a little bit.
>>
>> Despite no code of conduct or specification guiding how the modules 
>> parameters should be.
>> Noticed that there already have a lot of DRM drivers support the 
>> modeset parameters,
>
> Please look at the history and discussion around this parameter. To my 
> knowledge, 'modeset' got introduced when modesetting with still done 
> in userspace. It was an easy way of disabling the kernel driver if the 
> system's Xorg did no yet support kernel mode setting.
>
> Fast forward a few years and all Linux' use kernel modesetting, which 
> make the modeset parameters obsolete. We discussed and decided to keep 
> them in, because many articles and blog posts refer to them. We didn't 
> want to invalidate them. BUT modeset is deprecated and not allowed in 
> new code. If you look at existing modeset usage, you will eventually 
> come across the comment at [1].
>

OK, no problem. I agree what you said.


> There's 'nomodeset', which disables all native drivers. It's useful 
> for debugging or as a quick-fix if the graphics driver breaks. If you 
> want to disable a specific driver, please use one of the options for 
> blacklisting.
>
Yeah, the 'nomodeset' disables all native drivers,
this is a good point of it, but this is also the weak point of it.

Sometimes, when you are developing a drm driver for a new device.
You will see the pain. Its too often a programmer's modification
make the entire Linux kernel hang there. The problematic drm
driver kernel module already in the initrd. Then, the real
need to disable the ill-functional drm driver kernel module
only. While what you recommend to disable them all. There
are subtle difference.

Another limitation of the 'nomodeset' parameter is that
it is only available on recent upstream kernel. Low version
downstream kernel don't has this parameter supported yet.
So this create inconstant developing experience. I believe that
there always some people need do back-port and upstream work
for various reasons.

While (kindly, no offensive) debating, since we have the modprobe.blacklist
why we still need the 'nomodeset' parameter ?
why not try modprobe.blacklist="amdgpu,radeon,i915,ast,nouveau,gma500_gfx, ..."

:-/


But OK in overall, I will listen to your advice.


> Best regards
> Thomas
>
> [1] 
> https://elixir.bootlin.com/linux/v6.5/source/include/drm/drm_module.h#L83
>
>
>> for the modeset parameter, authors of various device driver try to 
>> make the usage not
>> conflict with others. I believe that this is good thing for Linux users.
>> It is probably the responsibility of the drm core maintainers to 
>> force various drm
>> drivers to reach a minimal consensus. Probably it pains to do so and 
>> doesn't pay off.
>> But reach a minimal consensus do benefit to Linux users.
>>
>>
>>> You can use modprobe.blacklist or initcall_blacklist on the kernel 
>>> command line.
>>>
>> There are some cases where the modprobe.blacklist doesn't works,
>> I have come cross several time during the past.
>> Because the device selected by the VGAARB is device-level thing,
>> it is not the driver's problem.
>>
>> Sometimes when VGAARB has a bug, it will select a wrong device as 
>> primary.
>> And the X server will use this wrong device as primary and completely 
>> crash
>> there, due to lack a driver. Take my old S3 Graphics as an example:
>>
>> $ lspci | grep VGA
>>
>>   00:06.1 VGA compatible controller: Loongson Technology LLC DC 
>> (Display Controller) (rev 01)
>>   03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
>> [AMD/ATI] Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
>>   07:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 
>> (rev 01)
>>   08:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 
>> (rev 01)
>>
>> Before apply this patch:
>>
>> [    0.361748] pci 0000:00:06.1: vgaarb: setting as boot VGA device
>> [    0.361753] pci 0000:00:06.1: vgaarb: VGA device added: 
>> decodes=io+mem,owns=io+mem,locks=none
>> [    0.361765] pci 0000:03:00.0: vgaarb: VGA device added: 
>> decodes=io+mem,owns=none,locks=none
>> [    0.361773] pci 0000:07:00.0: vgaarb: VGA device added: 
>> decodes=io+mem,owns=none,locks=none
>> [    0.361779] pci 0000:08:00.0: vgaarb: VGA device added: 
>> decodes=io+mem,owns=none,locks=none
>> [    0.361781] vgaarb: loaded
>> [    0.367838] pci 0000:00:06.1: Overriding boot device as 1002:6778
>> [    0.367841] pci 0000:00:06.1: Overriding boot device as 5333:9070
>> [    0.367843] pci 0000:00:06.1: Overriding boot device as 5333:9070
>>
>>
>> For known reason, one of my system select the S3 Graphics as primary 
>> GPU.
>> But this S3 Graphics not even have a decent drm upstream driver yet.
>> Under such a case, I begin to believe that only the device who has a
>> driver deserve the primary.
>>
>> Under such a condition, I want to reboot and enter the graphic 
>> environment
>> with other working video cards. Either platform integrated and 
>> discrete GPU.
>> This don't means I should compromise by un-mount the S3 graphics card 
>> from
>> the motherboard, this also don't means that I should update my BIOS 
>> setting.
>> As sometimes, the BIOS is more worse.
>>
>> With this series applied, all I need to do is to reboot the computer and
>> pass a command line. By force override another video card (who has a
>> decent driver support) as primary, I'm able to do the debugging under
>> graphic environment. I would like to examine what's wrong with the 
>> vgaarb
>> on a specific platform under X server graphic environment.
>>
>> Probably try compile a driver for this card and see it works, simply 
>> reboot
>> without the need to change anything. It is so efficient. So this is 
>> probably
>> the second usage of my patch. It hand the right of control back to the
>> graphic developer.
>>
>>
>

