Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24E796EF6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIGCax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjIGCau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 22:30:50 -0400
Received: from out-228.mta0.migadu.com (out-228.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D519A6
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 19:30:27 -0700 (PDT)
Message-ID: <a9af88c5-4509-96ff-a7fd-a0f72d2f1e6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694053816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWKuDI3UfELqoaKOu5alhaGYIMfDF3Uc/CsxX8KNpcw=;
        b=GgeP92P4/naoXz26vwG4GdsQK6IicmdS3p/1rSEio3gSFjQdIr414+XfvCVmk/THfA7ZKv
        4z62dV1LCO5X2T+9nr7deC3FDvEwA8Rt+pc1TYHpt6j3guxm7EdgbMKutPbEWqVZwt5ffu
        P1CoPAj1PHHuBRbiwyeoXcKFjbqv6Jk=
Date:   Thu, 7 Sep 2023 10:30:05 +0800
MIME-Version: 1.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <2adfa653-ac35-d560-be52-c92848a1eef5@gmail.com>
 <b51d49f3-e3de-6b8d-9cb4-df5c03f3cdc0@loongson.cn>
 <10509692-ce04-e225-5a27-abc955554bdc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <10509692-ce04-e225-5a27-abc955554bdc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/9/6 17:40, Christian König wrote:
> Am 06.09.23 um 11:08 schrieb suijingfeng:
>> Well, welcome to correct me if I'm wrong.
>
> You seem to have some very basic misunderstandings here.
>
> The term framebuffer describes some VRAM memory used for scanout.
>
> This framebuffer is exposed to userspace through some framebuffer 
> driver, on UEFI platforms that is usually efifb but can be quite a 
> bunch of different drivers.
>
> When the DRM drivers load they remove the previous drivers using 
> drm_aperture_remove_conflicting_pci_framebuffers() (or similar 
> function), but this does not mean that the framebuffer or scanout 
> parameters are modified in any way. It just means that the framebuffer 
> is just no longer exposed through this driver.
>
> Take over is the perfectly right description here because that's 
> exactly what's happening. The framebuffer configuration including the 
> VRAM memory as well as the parameters for scanout are exposed by the 
> newly loaded DRM driver.
>
> In other words userspace can query through the DRM interfaces which 
> monitors already driven by the hardware and so in your terminology 
> figure out which is the primary one.
>
I'm a little bit of not convinced about this idea, you might be correct.
But there cases where three are multiple monitors and each video card
connect one.

It also quite common that no monitors is connected, let the machine boot
first, then find a monitors to connect to a random display output. See
which will display. I don't expect the primary shake with.
The primary one have to be determined as early as possible, because of
the VGA console and the framebuffer console may directly output the primary.
Get the DDC and/or HPD involved may necessary complicated the problem.

There are ASpeed BMC who add a virtual connector in order to able display remotely.
There are also have commands to force a connector to be connected status.


> It's just that as Thomas explained as well that this completely 
> irrelevant to any modern desktop. Both X and Wayland both iterate the 
> available devices and start rendering to them which one was used 
> during boot doesn't really matter to them.
>
You may be correct, but I'm still not sure.
I probably need more times to investigate.
Me and my colleagues are mainly using X server,
the version varies from 1.20.4 and 1.21.1.4.
Even this is true, the problems still exist for non-modern desktops.

> Apart from that ranting like this and trying to explain stuff to 
> people who obviously have much better background in the topic is not 
> going to help your patches getting upstream.
>

Thanks for you tell me so much knowledge,
I'm realized where are the problems now.
I will try to resolve the concerns at the next version.


> Regards,
> Christian.
>
