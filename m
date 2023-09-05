Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A6792C8E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjIERjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbjIERjd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 13:39:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8311387923;
        Tue,  5 Sep 2023 10:14:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxfOp8UPdkQbUfAA--.36894S3;
        Tue, 05 Sep 2023 23:59:56 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTSN6UPdk3iVtAA--.47347S3;
        Tue, 05 Sep 2023 23:59:54 +0800 (CST)
Message-ID: <3eced3f5-622f-31a6-f8a0-ff0812be74ff@loongson.cn>
Date:   Tue, 5 Sep 2023 23:59:54 +0800
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
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <151c0429-dbc2-e987-1491-6c733ca159ac@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSN6UPdk3iVtAA--.47347S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw4rXF17JFykZFWkAr47trc_yoW7Xr15pF
        Z0gay3Kr4kGr48C340v3WruFWfu3yrJayfJrn7t34j9an8KryjvFZrtr45Ka47Ar1fXF1Y
        qF9xt34xt3W3AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/9/5 18:49, Thomas Zimmermann wrote:
> Hi
>
> Am 04.09.23 um 21:57 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> On a machine with multiple GPUs, a Linux user has no control over which
>> one is primary at boot time. This series tries to solve above mentioned
>> problem by introduced the ->be_primary() function stub. The specific
>> device drivers can provide an implementation to hook up with this 
>> stub by
>> calling the vga_client_register() function.
>>
>> Once the driver bound the device successfully, VGAARB will call back to
>> the device driver. To query if the device drivers want to be primary or
>> not. Device drivers can just pass NULL if have no such needs.
>>
>> Please note that:
>>
>> 1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
>>     like to mount at least three video cards.
>>
>> 2) Typically, those non-86 machines don't have a good UEFI firmware
>>     support, which doesn't support select primary GPU as firmware stage.
>>     Even on x86, there are old UEFI firmwares which already made 
>> undesired
>>     decision for you.
>>
>> 3) This series is attempt to solve the remain problems at the driver 
>> level,
>>     while another series[1] of me is target to solve the majority of the
>>     problems at device level.
>>
>> Tested (limited) on x86 with four video card mounted, Intel UHD Graphics
>> 630 is the default boot VGA, successfully override by ast2400 with
>> ast.modeset=10 append at the kernel cmd line.
>
> FYI: per-driver modeset parameters are deprecated and not to be used. 
> Please don't promote them.


Well, please wait, I want to explain.



drm/nouveau already promote it a little bit.

Despite no code of conduct or specification guiding how the modules parameters should be.
Noticed that there already have a lot of DRM drivers support the modeset parameters,
for the modeset parameter, authors of various device driver try to make the usage not
conflict with others. I believe that this is good thing for Linux users.
It is probably the responsibility of the drm core maintainers to force various drm
drivers to reach a minimal consensus. Probably it pains to do so and doesn't pay off.
But reach a minimal consensus do benefit to Linux users.


> You can use modprobe.blacklist or initcall_blacklist on the kernel 
> command line.
>
There are some cases where the modprobe.blacklist doesn't works,
I have come cross several time during the past.
Because the device selected by the VGAARB is device-level thing,
it is not the driver's problem.

Sometimes when VGAARB has a bug, it will select a wrong device as primary.
And the X server will use this wrong device as primary and completely crash
there, due to lack a driver. Take my old S3 Graphics as an example:

$ lspci | grep VGA

  00:06.1 VGA compatible controller: Loongson Technology LLC DC (Display Controller) (rev 01)
  03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
  07:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)
  08:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)

Before apply this patch:

[    0.361748] pci 0000:00:06.1: vgaarb: setting as boot VGA device
[    0.361753] pci 0000:00:06.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.361765] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.361773] pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.361779] pci 0000:08:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.361781] vgaarb: loaded
[    0.367838] pci 0000:00:06.1: Overriding boot device as 1002:6778
[    0.367841] pci 0000:00:06.1: Overriding boot device as 5333:9070
[    0.367843] pci 0000:00:06.1: Overriding boot device as 5333:9070


For known reason, one of my system select the S3 Graphics as primary GPU.
But this S3 Graphics not even have a decent drm upstream driver yet.
Under such a case, I begin to believe that only the device who has a
driver deserve the primary.

Under such a condition, I want to reboot and enter the graphic environment
with other working video cards. Either platform integrated and discrete GPU.
This don't means I should compromise by un-mount the S3 graphics card from
the motherboard, this also don't means that I should update my BIOS setting.
As sometimes, the BIOS is more worse.

With this series applied, all I need to do is to reboot the computer and
pass a command line. By force override another video card (who has a
decent driver support) as primary, I'm able to do the debugging under
graphic environment. I would like to examine what's wrong with the vgaarb
on a specific platform under X server graphic environment.

Probably try compile a driver for this card and see it works, simply reboot
without the need to change anything. It is so efficient. So this is probably
the second usage of my patch. It hand the right of control back to the
graphic developer.


