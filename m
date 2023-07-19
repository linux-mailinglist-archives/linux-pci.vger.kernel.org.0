Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6675A05E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGSVNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSVNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 17:13:15 -0400
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com [IPv6:2001:41d0:1004:224b::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62D1FC0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jul 2023 14:13:13 -0700 (PDT)
Message-ID: <1a10cb43-7c96-069a-bdd2-3a8cdb7727e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689801191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsT5fBh8KwnUgUCpgN0LIT64s0RQIMJgl5uyUvT45hU=;
        b=onl9tgCTxyWZS4mjI/YjCwX2bDOLsgCA+ISxwXBqf+mKSgHVlK/fYzNmGvtF4NA4SrazBc
        kBA9R1hBsWYb8TEpWhBanuhWyYSEzs6MaENojEpZivIyXmyoqGyVN/eQDHOjtvSWb2USi9
        +WJeGIgLdpDUwGRijlEDkt46oUuzP3w=
Date:   Thu, 20 Jul 2023 05:13:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sui@freedesktop.org,
        Jingfeng@loongson.cn, Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230719182617.GA509912@bhelgaas>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20230719182617.GA509912@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/7/20 02:26, Bjorn Helgaas wrote:
> On Tue, Jul 11, 2023 at 09:43:50PM +0800, Sui Jingfeng wrote:
>> From: Sui Jingfeng<suijingfeng@loongson.cn>
>>
>> Currently, vgaarb only cares about PCI VGA-compatible class devices.
>>
>> While vga_arbiter_del_pci_device() gets called unbalanced when some PCI
>> device is about to be removed. This happens even during the boot process.
> The previous code calls vga_arbiter_add_pci_device() for every device
> (every device present at boot and also every hot-added device).  It
> only allocates a vga_device if pdev->class is 0x0300XX.
>
> It calls vga_arbiter_del_pci_device() for every device removal.  It
> does nothing unless it finds a vga_device.
> This seems symmetric and reasonable to me.  Did you observe a problem
> with it?
>
Not big deal, but the vgaarb does do some useless work there.


Right,  it calls vga_arbiter_del_pci_device() for every device removal.

And it can not finds a vga_device at the most time. (Because on normal 
case, a user only have one or two GPU device in the system.)

But even it can not finds a vga_device, vga_arbiter_del_pci_device() 
still brings

additional(and it is unnecessary) overheads.


For an example, on my i3-8100 (the motherboard model is H110 D4L) machine,

The PCI device(0000:00:1f.1) will trigger the call to 
vga_arbiter_del_pci_device().


Even though it can not finds a vga_device,

vga_arbiter_del_pci_device() is *NOT* a no-op still.


```

static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
{
     struct vga_device *vgadev;
     unsigned long flags;
     bool ret = true;

     spin_lock_irqsave(&vga_lock, flags);
     vgadev = vgadev_find(pdev);
     if (vgadev == NULL) {
         ret = false;
         goto bail;
     }

     // omit ...


bail:
     spin_unlock_irqrestore(&vga_lock, flags);
     kfree(vgadev);
     return ret;
}

```


1) It call spin_lock_irqsave() and  spin_unlock_irqrestore() pair for 
complete irrelevant PCI devices

2) It try to find a vgadev with pdev pointer, which have to search the 
whole list (All nodes in the list got accessed), because it can not find.

3) It call kfree() to free NULL pointer, it's just that kfree() will 
just return if you pass a NULL, so no bug happen.


It is not efficient.

While the major contribution of my patch is to filter irrelevant PCI device.

Otherwise there 30+ noisy(useless) events got snooped. See below:


```

[    0.246077] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.246077] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.246077] pci 0000:01:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.246077] vgaarb: loaded
[    0.294169] skl_uncore 0000:00:00.0: vgaarb: pci_notify: action=3
[    0.294182] skl_uncore 0000:00:00.0: vgaarb: pci_notify: action=4
[    0.301297] pcieport 0000:00:01.0: vgaarb: pci_notify: action=3
[    0.301482] pcieport 0000:00:01.0: vgaarb: pci_notify: action=4
[    0.301488] pcieport 0000:00:1c.0: vgaarb: pci_notify: action=3
[    0.301705] pcieport 0000:00:1c.0: vgaarb: pci_notify: action=4
[    1.806445] xhci_hcd 0000:00:14.0: vgaarb: pci_notify: action=3
[    1.810976] ahci 0000:00:17.0: vgaarb: pci_notify: action=3
[    1.824383] xhci_hcd 0000:00:14.0: vgaarb: pci_notify: action=4
[    1.857470] ahci 0000:00:17.0: vgaarb: pci_notify: action=4
[    4.692700] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify: action=3
[    4.693110] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify: action=4
[    4.746712] i801_smbus 0000:00:1f.4: vgaarb: pci_notify: action=3
[    4.747212] pci 0000:00:1f.1: vgaarb: pci_notify: action=0
[    4.747227] pci 0000:00:1f.1: vgaarb: pci_notify: action=1
[    4.747250] pci 0000:00:1f.1: vgaarb: pci_notify: action=2
[    4.749098] i801_smbus 0000:00:1f.4: vgaarb: pci_notify: action=4
[    4.799217] mei_me 0000:00:16.0: vgaarb: pci_notify: action=3
[    4.802503] mei_me 0000:00:16.0: vgaarb: pci_notify: action=4
[    4.874880] intel-lpss 0000:00:15.0: vgaarb: pci_notify: action=3
[    4.881227] intel-lpss 0000:00:15.0: vgaarb: pci_notify: action=4
[    4.881240] intel-lpss 0000:00:15.1: vgaarb: pci_notify: action=3
[    4.887578] intel-lpss 0000:00:15.1: vgaarb: pci_notify: action=4
[    4.985796] r8169 0000:02:00.0: vgaarb: pci_notify: action=3
[    4.991862] r8169 0000:02:00.0: vgaarb: pci_notify: action=4
[    5.404835] snd_hda_intel 0000:00:1f.3: vgaarb: pci_notify: action=3
[    5.405175] snd_hda_intel 0000:00:1f.3: vgaarb: pci_notify: action=4
[    5.405401] snd_hda_intel 0000:01:00.1: vgaarb: pci_notify: action=3
[    5.405973] snd_hda_intel 0000:01:00.1: vgaarb: pci_notify: action=4
[   10.793665] i915 0000:00:02.0: vgaarb: pci_notify: action=3
[   11.201384] i915 0000:00:02.0: vgaarb: pci_notify: action=4
[   16.135842] amdgpu 0000:01:00.0: vgaarb: pci_notify: action=3
[   16.140458] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
[   16.638564] amdgpu 0000:01:00.0: vgaarb: pci_notify: action=4

```




