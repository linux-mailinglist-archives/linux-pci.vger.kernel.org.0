Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4754DD0A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbiFPIkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 04:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPIkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 04:40:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C925D64F
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 01:40:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z17so370003wmi.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jun 2022 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvVSjwu55o8X8egWZU4iWsZIHVlVa9bVPksJ+MBzn7k=;
        b=DgBiI+XAcThHX852u8IueujWgMvjgWOkE+ITD5jJYPNcVMp/rTnZ5dD3tibcaFiaUx
         VkzBl9dsE4Hiu/z/fg8ZSjFHqAJ+NwN9uZAwRAQkoLJ+yLTU5+YFXQH1MLOLtBXYFjK7
         c5XfrAPyQhlWqM0sYwv5/z05LpUIyVcAoxWt6pAQfxPkWR/MMo3pkv72+AF5JtCHJqiL
         Lruy+U+6Dm+2Phm+QyD8jifRIcdGkxFWWmuDbANyb0wrY5r5ir1+RN6mMCJgC5vjJnJJ
         MBPITJHIvBz5xUWuxd1cjYSq5JiNWoE7HOmipuKOi1fBpVBES0Pg2sVwDzk1ylMYPWaM
         IJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvVSjwu55o8X8egWZU4iWsZIHVlVa9bVPksJ+MBzn7k=;
        b=BOzJ4d3skePhaZcTtZ4HuG3APZPX60gPeaetcu17VDAnvdXFLIdAY0R4S89Go3b20Y
         FSYDPmK/F8P51gBc6RIgdrZjXjfA7Jsl9wXzzYe365jj8S8dy48q0UZ5PM3g3cK0Runq
         mACulRQBiuzOHTD/DMnhrmDm5dExHBn0TfVeQ3YbP5an62ZTOzoWwlGa/hdci1/IGx26
         Zw7rvFs3FZcUOkUqqY9SktQaJQAQjMNW61mBUFBfP65Jei09pJl81llPFgKHJAkhviuI
         eYcDRoxfDtQt2spnmEE4DwVOPfqCJG5xXxrd31BEJX9VwO8EHTOQDA/9KEpYK8lyyOMA
         0hAg==
X-Gm-Message-State: AJIora9F3FoRcOqLdXT5CWyE2Tox9d2JbM7ftQ4O4qn+tkuCdDLYSiiN
        LX8qEH8tw24uzS+ei1wSMDlseMtVfhiCcUE1Wh0=
X-Google-Smtp-Source: AGRyM1tD1Dmf9qbZ+itBVwWjX6u5/l97xRcLp23MLiO9Dmwu6Jn29GwDN5/EEPU0pGcQfinqJAf9MXhMOKT66Ryrj5g=
X-Received: by 2002:a7b:c95a:0:b0:39c:4daa:4cdb with SMTP id
 i26-20020a7bc95a000000b0039c4daa4cdbmr3731298wml.31.1655368798420; Thu, 16
 Jun 2022 01:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H6CpeEWw2VNv5eaMwbyvGTxzvuJzXzjJ8Wg3iggOM=DcQ@mail.gmail.com>
 <20220608193135.GA413879@bhelgaas>
In-Reply-To: <20220608193135.GA413879@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 16 Jun 2022 16:39:46 +0800
Message-ID: <CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com>
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

On Thu, Jun 9, 2022 at 3:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 08, 2022 at 05:34:21PM +0800, Huacai Chen wrote:
> > On Fri, Jun 3, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> > > > On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > > > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services
> > > > > > during shutdown") causes poweroff/reboot failure on systems with
> > > > > > LS7A chipset.  We found that if we remove "pci_command &=
> > > > > > ~PCI_COMMAND_MASTER;" in do_pci_disable_device(), it can work
> > > > > > well. The hardware engineer says that the root cause is that CPU
> > > > > > is still accessing PCIe devices while poweroff/reboot, and if we
> > > > > > disable the Bus Master Bit at this time, the PCIe controller
> > > > > > doesn't forward requests to downstream devices, and also doesn't
> > > > > > send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > > > > > deadlock). This behavior is a PCIe protocol violation (Bus
> > > > > > Master should not be involved in CPU MMIO transactions), and it
> > > > > > will be fixed in new revisions of hardware (add timeout
> > > > > > mechanism for CPU read request, whether or not Bus Master bit is
> > > > > > cleared).
> > > > >
> > > > > LS7A might have bugs in that clearing Bus Master Enable prevents the
> > > > > root port from forwarding Memory or I/O requests in the downstream
> > > > > direction.
> > > > >
> > > > > But this feels like a bit of a band-aid because we don't know exactly
> > > > > what those requests are.  If we're removing the Root Port, I assume we
> > > > > think we no longer need any devices *below* the Root Port.
> > > > >
> > > > > If that's not the case, e.g., if we still need to produce console
> > > > > output or save state to a device, we probably should not be removing
> > > > > the Root Port at all.
> > > >
> > > > Do you mean it is better to skip the whole pcie_port_device_remove()
> > > > instead of just removing the "clear bus master" operation for the
> > > > buggy hardware?
> > >
> > > No, that's not what I want at all.  That's just another band-aid to
> > > avoid a problem without understanding what the problem is.
> > >
> > > My point is that apparently we remove a Root Port (which means we've
> > > already removed any devices under it), and then we try to use a device
> > > below the Root Port.  That seems broken.  I want to understand why we
> > > try to use a device after we've removed it.
> >
> > I agree, and I think "why we try to use a device after remove it" is
> > because the userspace programs don't know whether a device is
> > "usable", so they just use it, at any time. Then it seems it is the
> > responsibility of the device drivers to avoid the problem.
>
> How is userspace able to use a device after the device is removed?
> E.g., if userspace does a read/write to a device that has been
> removed, the syscall should return error, not touch the missing
> device.  If userspace mmaps a device, an access after the device has
> been removed should fault, not do MMIO to the missing device.
To give more details, let's take the graphics driver (e.g. amdgpu) as
an example again. The userspace programs call printf() to display
"shutting down xxx service" during shutdown/reboot. Or we can even
simplify further, the kernel calls printk() to display something
during shutdown/reboot. You know, printk() can happen at any time,
even after we call pcie_port_device_remove() to disable the pcie port
on the graphic card.

The call stack is: printk() --> call_console_drivers() -->
con->write() --> vt_console_print() --> fbcon_putcs()

I think this is a scenario of "userspace programs (or kernel itself)
don't know whether a device is 'usable', so they just use it, at any
time"

And why does the graphic driver call .suspend() in its .shutdown() can
fix the problem?
One of the key operations in .suspend() is drm_fb_helper_set_suspend()
--> fb_set_suspend() --> info->state = FBINFO_STATE_SUSPENDED;
This operation will cause fbcon_is_inactive() to return true, then
refuse fbcon_putcs() to really write to the framebuffer.

Huacai


>
> > Take radeon/amdgpu driver as an example, the .shutdown() of the
> > callback can call suspend() to fix.
> >
> > But..., another problem is: There are many drivers "broken", not just
> > radeon/amdgpu drivers (at least, the ahci driver is also "broken").
> > Implementing the driver's .shutdown() correctly is nearly impossible
> > for us, because we don't know the hardware details of so many devices.
> > On the other hand, those drivers "just works" on most platforms, so
> > the driver authors don't think they are "broken".
>
> It sounds like you have analyzed this and have more details about
> exactly how this happens.  Can you please share those details?  There
> are a lot of steps in the middle that I don't understand yet.
>
> Without those details, "userspace programs don't know whether a device
> is 'usable', so they just use it, at any time" is kind of hand-wavey
> and not very convincing.
>
> > So, very sadly, we can only use a band-aid now. :(
> >
> > > If the scenario ends up being legitimate and unavoidable, fine -- we
> > > can figure out a quirk to work around the fact the LS7A doesn't allow
> > > that access after we clear Bus Master Enable.  But right now the
> > > scenario smells like a latent bug, and leaving bus mastering enabled
> > > just avoids it without fixing it.
> > >
> > > Bjorn
