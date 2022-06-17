Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62554EF4A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379429AbiFQCV3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 22:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbiFQCV2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 22:21:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9372664D08
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 19:21:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so4872716lfa.6
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 19:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzNWVzjQeAnwYzqrUdkh9vUCGaZtU9wdrkILoRN06x8=;
        b=bui5lyeQTPfqPIBUmd78bpGz3M7Eb3D7flg+xQwSaKu9zZbbI5Vs7tm6sbUSZfgnIT
         UDUua2NiCEkc3dWZ5ij1eOaIdxYD7DPtEgn5lOta2PaBiyltJe9PpCooqwil4IFC0Txk
         sS3of7C+tj8BEoVHmMywD5SpRtlFxDjW5ehjjS2uQmSwbn5gUJct1n8Fs/7Y4k6juDii
         Cs3QNg60Vx6zQqv35y8gsXsm8IpZLo1P6S6moCLz4b0pU3GPX+LYE011R+vnbQ+k5opq
         FFaI8g0zr5fYWn6yXuXA2vV9/mWn+AMBFITAW0Y9tCdm7Rz5HtTpaY1jSR2nBTy9681s
         S5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzNWVzjQeAnwYzqrUdkh9vUCGaZtU9wdrkILoRN06x8=;
        b=D8f9VXG+/hA5+v6PpVFav2iT8P1UUcGu7hphBLCHNUgslN8FXr8cDB3ckDGr1B0BHF
         8ZlmlodAedf1OH5kPO+QNxcIo0gnmBdDCrEAvkv52WSwCmENy2k1H3KC0KHGoUvvDbW+
         WyU+pgf/fM+hulSS5Nm9G29Oa7QTnMZmbVfkLAPYLGRgmomZqdGY8d826emk1/SMCffS
         Vn2C1XgKHz9EOJ1EoT4wxBO15zLEc+3o85hDe5ozP7FSvB6lOigi3r6xeOCMl1OixIoA
         KJPwZaDp8HFfRtcWpMYkEsy4tQMQghAmmIKn3CO+4jjfSYhTul2vDUOISgcqp0iwixv8
         8ArQ==
X-Gm-Message-State: AJIora8hxWPbVXfBqok1i2xbffErrML2xtYnrcIV93EhUniZ4/HTs5Qd
        6jm/RWr+oHyQE/2dd/jxiWfw/yiwuxvegyjb6GwzANL/JNh+IQpB
X-Google-Smtp-Source: AGRyM1t8rr22/cQLAhfFlDzpuIQOCi+/YDnOTCs7KGfe+trsaj4ixIBZP2o3hclLMFk3UJ56X05R9mehK2LamacY9SU=
X-Received: by 2002:a05:6512:3094:b0:479:47ae:a7c4 with SMTP id
 z20-20020a056512309400b0047947aea7c4mr4444802lfd.518.1655432485729; Thu, 16
 Jun 2022 19:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com>
 <20220616225740.GA1138506@bhelgaas>
In-Reply-To: <20220616225740.GA1138506@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 17 Jun 2022 10:21:14 +0800
Message-ID: <CAAhV-H7G5BN4n-jRnfVYOikkk0pCt=ZLB0MW=iKu+s07gieKXg@mail.gmail.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Fri, Jun 17, 2022 at 6:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 16, 2022 at 04:39:46PM +0800, Huacai Chen wrote:
> > On Thu, Jun 9, 2022 at 3:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Jun 08, 2022 at 05:34:21PM +0800, Huacai Chen wrote:
> > > > On Fri, Jun 3, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> > > > > > On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > > > > > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe
> > > > > > > > services during shutdown") causes poweroff/reboot
> > > > > > > > failure on systems with LS7A chipset.  We found that if
> > > > > > > > we remove "pci_command &= ~PCI_COMMAND_MASTER;" in
> > > > > > > > do_pci_disable_device(), it can work well. The hardware
> > > > > > > > engineer says that the root cause is that CPU is still
> > > > > > > > accessing PCIe devices while poweroff/reboot, and if we
> > > > > > > > disable the Bus Master Bit at this time, the PCIe
> > > > > > > > controller doesn't forward requests to downstream
> > > > > > > > devices, and also doesn't send TIMEOUT to CPU, which
> > > > > > > > causes CPU wait forever (hardware deadlock). This
> > > > > > > > behavior is a PCIe protocol violation (Bus Master should
> > > > > > > > not be involved in CPU MMIO transactions), and it will
> > > > > > > > be fixed in new revisions of hardware (add timeout
> > > > > > > > mechanism for CPU read request, whether or not Bus
> > > > > > > > Master bit is cleared).
> > > > > > >
> > > > > > > LS7A might have bugs in that clearing Bus Master Enable
> > > > > > > prevents the root port from forwarding Memory or I/O
> > > > > > > requests in the downstream direction.
> > > > > > >
> > > > > > > But this feels like a bit of a band-aid because we don't
> > > > > > > know exactly what those requests are.  If we're removing
> > > > > > > the Root Port, I assume we think we no longer need any
> > > > > > > devices *below* the Root Port.
> > > > > > >
> > > > > > > If that's not the case, e.g., if we still need to produce
> > > > > > > console output or save state to a device, we probably
> > > > > > > should not be removing the Root Port at all.
> > > > > >
> > > > > > Do you mean it is better to skip the whole
> > > > > > pcie_port_device_remove() instead of just removing the
> > > > > > "clear bus master" operation for the buggy hardware?
> > > > >
> > > > > No, that's not what I want at all.  That's just another
> > > > > band-aid to avoid a problem without understanding what the
> > > > > problem is.
> > > > >
> > > > > My point is that apparently we remove a Root Port (which means
> > > > > we've already removed any devices under it), and then we try
> > > > > to use a device below the Root Port.  That seems broken.  I
> > > > > want to understand why we try to use a device after we've
> > > > > removed it.
> > > >
> > > > I agree, and I think "why we try to use a device after remove
> > > > it" is because the userspace programs don't know whether a
> > > > device is "usable", so they just use it, at any time. Then it
> > > > seems it is the responsibility of the device drivers to avoid
> > > > the problem.
> > >
> > > How is userspace able to use a device after the device is removed?
> > > E.g., if userspace does a read/write to a device that has been
> > > removed, the syscall should return error, not touch the missing
> > > device.  If userspace mmaps a device, an access after the device
> > > has been removed should fault, not do MMIO to the missing device.
> >
> > To give more details, let's take the graphics driver (e.g. amdgpu)
> > as an example again. The userspace programs call printf() to display
> > "shutting down xxx service" during shutdown/reboot. Or we can even
> > simplify further, the kernel calls printk() to display something
> > during shutdown/reboot. You know, printk() can happen at any time,
> > even after we call pcie_port_device_remove() to disable the pcie
> > port on the graphic card.
>
> I've been focusing on the *remove* path, but you said the problem
> you're solving is with *poweroff/reboot*.  pcie_portdrv_remove() is
> used for both paths, but if there's a reason we need those paths to be
> different, we might be able to split them.
I'm very sorry for that. I have misunderstood before because I suppose
the "remove path" is the pcie_portdrv_remove() function, but your
meaning is the .remove() callback in pcie_portdriver. Am I right this
time?

>
> For remove, we have to assume accesses to the device may already or
> will soon fail.  A driver that touches the device, or a device that
> performs DMA, after its drv->remove() method has been called would be
> seriously broken.  The remove operation also unbinds the driver from
> the device.
Then what will happen about the "remove path"? If we still take the
graphics driver as an example, "rmmod amdgpu" always fails with
"device is busy" because the graphics card is always be used once
after the driver is loaded. So the "remove path" has no chance to be
executed. But if we take a NIC driver as an example, "rmmod igb" can
mostly succeed, and there will be no access on the device after
removing, at least in our observation. I think there is nothing broken
about the "remove path".

>
> The semantics of device_shutdown(), pci_device_shutdown(), and any
> drv->shutdown() methods are not documented very well.  This path is
> only used for halt/poweroff/reboot, so my guess is that not very much
> is actually required, and it doesn't do anything at all with respect
> to driver binding.
>
> I think we mainly want to disable things that might interfere with
> halt/poweroff/reboot, like interrupts and maybe DMA.  We disable DMA
> in this path to prevent devices from corrupting memory, but I'm more
> open to a quirk in the shutdown path than in the remove path.  So how
> about if you clone pcie_port_device_remove() to make a separate
> pcie_port_device_shutdown() and put the quirk there?
Hmm, I think this is better. So I will clone
pcie_portdrv_remove()/pcie_port_device_remove() to make a separate
pcie_portdrv_shutdown()/pcie_port_device_shutdown() and only apply the
quirk on the shutdown path.

Huacai
>
> > The call stack is: printk() --> call_console_drivers() -->
> > con->write() --> vt_console_print() --> fbcon_putcs()
> >
> > I think this is a scenario of "userspace programs (or kernel itself)
> > don't know whether a device is 'usable', so they just use it, at any
> > time"
> >
> > And why does the graphic driver call .suspend() in its .shutdown() can
> > fix the problem?
> >
> > One of the key operations in .suspend() is drm_fb_helper_set_suspend()
> > --> fb_set_suspend() --> info->state = FBINFO_STATE_SUSPENDED;
> >
> > This operation will cause fbcon_is_inactive() to return true, then
> > refuse fbcon_putcs() to really write to the framebuffer.
>
> > > > Take radeon/amdgpu driver as an example, the .shutdown() of the
> > > > callback can call suspend() to fix.
> > > >
> > > > But..., another problem is: There are many drivers "broken", not just
> > > > radeon/amdgpu drivers (at least, the ahci driver is also "broken").
> > > > Implementing the driver's .shutdown() correctly is nearly impossible
> > > > for us, because we don't know the hardware details of so many devices.
> > > > On the other hand, those drivers "just works" on most platforms, so
> > > > the driver authors don't think they are "broken".
> > >
> > > It sounds like you have analyzed this and have more details about
> > > exactly how this happens.  Can you please share those details?  There
> > > are a lot of steps in the middle that I don't understand yet.
> > >
> > > Without those details, "userspace programs don't know whether a device
> > > is 'usable', so they just use it, at any time" is kind of hand-wavey
> > > and not very convincing.
> > >
> > > > So, very sadly, we can only use a band-aid now. :(
> > > >
> > > > > If the scenario ends up being legitimate and unavoidable, fine -- we
> > > > > can figure out a quirk to work around the fact the LS7A doesn't allow
> > > > > that access after we clear Bus Master Enable.  But right now the
> > > > > scenario smells like a latent bug, and leaving bus mastering enabled
> > > > > just avoids it without fixing it.
> > > > >
> > > > > Bjorn
