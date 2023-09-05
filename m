Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAA79289D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbjIEQXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354678AbjIENbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 09:31:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4474191;
        Tue,  5 Sep 2023 06:31:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx5_GgLfdkLJwfAA--.63566S3;
        Tue, 05 Sep 2023 21:31:12 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPCOQLfdkY_hsAA--.46601S3;
        Tue, 05 Sep 2023 21:31:12 +0800 (CST)
Message-ID: <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
Date:   Tue, 5 Sep 2023 21:30:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPCOQLfdkY_hsAA--.46601S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFy5CFWxGryftF48tr1fuFX_yoWrAFWUpF
        WFqFWjkrWkGa18Jry7Aw1FvFyrXws5Jay5Kr1kCF98Zrs8Gr40vry2qw4q9a4UJr4rZ3WY
        qrWagw17uFyDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/9/5 18:45, Thomas Zimmermann wrote:
> Hi
>
> Am 04.09.23 um 21:57 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> On a machine with multiple GPUs, a Linux user has no control over which
>> one is primary at boot time. This series tries to solve above mentioned
>
> If anything, the primary graphics adapter is the one initialized by 
> the firmware. I think our boot-up graphics also make this assumption 
> implicitly.
>

Yes, but by the time of DRM drivers get loaded successfully,the boot-up graphics already finished.
Firmware framebuffer device already get killed by the drm_aperture_remove_conflicting_pci_framebuffers()
function (or its siblings). So, this series is definitely not to interact with the firmware framebuffer
(or more intelligent framebuffer drivers).  It is for user space program, such as X server and Wayland
compositor. Its for Linux user or drm drivers testers, which allow them to direct graphic display server
using right hardware of interested as primary video card.

Also, I believe that X server and Wayland compositor are the best test examples.
If a specific DRM driver can't work with X server as a primary,
then there probably have something wrong.


> But what's the use case for overriding this setting?
>

On a specific machine with multiple GPUs mounted,
only the primary graphics get POST-ed (initialized) by the firmware.
Therefore, the DRM drivers for the rest video cards, have to choose to
work without the prerequisite setups done by firmware, This is called as POST.

One of the use cases of this series is to test if a specific DRM driver could works properly,
even though there is no prerequisite works have been done by firmware at all.
And it seems that the results is not satisfying in all cases.

drm/ast is the first drm drivers which refused to work if not being POST-ed by the firmware.

Before apply this series, I was unable make drm/ast as the primary video card easily. On a
multiple video card configuration, the monitor connected with the AST2400 not light up.
While confusing, a naive programmer may suspect the PRIME is not working.

After applied this series and passing ast.modeset=10 on the kernel cmd line,
I found that the monitor connected with my ast2400 video card still black,
It doesn't display and doesn't show image to me.

While in the process of study drm/ast, I know that drm/ast driver has the POST code shipped.
See the ast_post_gpu() function, then, I was wondering why this function doesn't works.
After a short-time (hasty) debugging, I found that the the ast_post_gpu() function
didn't get run. Because it have something to do with the ast->config_mode.

Without thinking too much, I hardcoded the ast->config_mode as ast_use_p2a to
force the ast_post_gpu() function get run.

```

--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -132,6 +132,8 @@ static int ast_device_config_init(struct ast_device 
*ast)
                 }
         }

+       ast->config_mode = ast_use_p2a;
+
         switch (ast->config_mode) {
         case ast_use_defaults:
                 drm_info(dev, "Using default configuration\n");

```

Then, the monitor light up, it display the Ubuntu greeter to me.
Therefore, my patch is helpful, at lease for the Linux drm driver tester and developer.
It allow programmers to test the specific part of the specific drive
without changing a line of the source code and without the need of sudo authority.
It helps to improve efficiency of the testing and patch verification.

I know the PrimaryGPU option of Xorg conf, but this approach will remember the setup
have been made, you need modify it with root authority each time you want to switch
the primary. But on rapid developing and/or testing multiple video drivers, with
only one computer hardware resource available. What we really want probably is a
one-shoot command as this series provide.

So, this is the first use case. This probably also help to test full modeset,
PRIME and reverse PRIME on multiple video card machine.


> Best regards
> Thomas
>

