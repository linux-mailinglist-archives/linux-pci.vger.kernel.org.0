Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634D76A9D8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjHAHRf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjHAHRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 03:17:34 -0400
Received: from out-64.mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A321173F
        for <linux-pci@vger.kernel.org>; Tue,  1 Aug 2023 00:17:32 -0700 (PDT)
Message-ID: <207c6a5b-8a20-ba1c-5ea1-09959b9d6a15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690874250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fRkD2fAQoApB99hdiZ4/Ry51mJ87TiAaRY+bhVa0E4=;
        b=dfxd1uWv2Do2ERoaR6KcJ06Iqll8Ugd9SXQL+592jlaGI1DciB9Nj6guRecREAV3Dnifkd
        tUKYQeO19QY+9Qc0U5QzechPHu5wslso43sbB4JVZ/pNNvOjBlPhFXQl2JhCRQj7utra/t
        mzeRAIWUmVc1rAm4erPr/un74USeviM=
Date:   Tue, 1 Aug 2023 15:17:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        loongson-kernel@lists.loongnix.cn, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230725214928.GA666846@bhelgaas>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20230725214928.GA666846@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/7/26 05:49, Bjorn Helgaas wrote:
> On Sat, Jul 22, 2023 at 04:11:07PM +0800, suijingfeng wrote:
>> ...
>> In the future, we may want to expand VGAARB to deal all PCI display class
>> devices, with another patch.
>>
>> if (pdev->class >> 16 == PCI_BASE_CLASS_DISPLAY)
>>
>>           // accept
>>
>> else
>>
>>        // return immediately.
>>
>>
>> Then, we will have a more good chance to clarify the programmer interface.
> I would prefer not to expand vgaarb to deal with all display devices
> unless they actually need the legacy resources like [pci 0xa0000-0xbffff].

What if a system have multiple non VGA-compatible GPU while all of them can display?
We still need to select a default for for user-space executable program (X server).

What if the VGA goes away someday?
I means that hardware vendors may abandon the old VGA standard.
After all, snooping a fixed address aperture is not absolute necessary for modern graphic card.
Modern graphic have dedicated VRAM Bar, the occupied address range can be relocatable.
Thus avoid the address overlap (or occlusion).


> But maybe the consumer of these interfaces relies on vgaarb even for
> devices that don't need those resources? If so, please mention
> examples of where they depend on vgaarb.

Yes, there do exist some PCI*NON*  VGA-compatible display controllers,
Strictly speaking, there are not VGA-compatible in the sense that
they don't respond the fixed legacy VGA aperture.
Such a display controller also don't cares about the extension ROM (option ROM).
Loongson display controllers are one of the various examples.

Besides, Intel integrate GPU is capable switch to*NON*  VGA-compatible.
especially in a multiple GPU co-exist hardware environment.
Old BIOS of Intel platform will change its class code from 0x0300 to 0x0380.
Newer BIOS do allow us to choose which one should be the primary GPU,
but if a user don't choose the Intel integrate GPU as primary,
the BIOS still will alter its PCI class code from 0x0300 to 0x0380.


By listing examples as above, I means that a PCI(e) GPU device do not
need to be VGA-compatible to display something on screen.
This is a very important point, I think,
which lead me to consider expand vgaarb.

I'm not sure if we should handle the programming interface thing here,
there are a lot of places where just ignore the programming interface.

> I expect the vgaarb interfaces are used by things that need to emulate
> the option ROM to initialize the device.  If the device has a
> programming interface other than 0000 0000b, the option ROM should not
> be using the [pci 0xa0000-0xbffff] resource, so vgaarb should not be
> needed.

Also, I have another thought for this question.
The vga_set_default_device() function interface exported by vgaarb
is not ensure the restriction either.
I means that it does not check if a device is VGA-compatible,
it does not examine if the programming interface is 00000000b or 00000001b either.
In theory, a programmer could set a display device via the vga_set_default_device() interface.
Maybe this function is intentionally leave some space to workaround.

So, my idea is that leave programming interface related problems to the future.
I don't want to worry about a non-exist thing(programming interface == 0x01 for an example).


Back to my patch set, is this patch acceptable?
Or I still need to refine this series?
My other patches are queued up with this.


> Bjorn
