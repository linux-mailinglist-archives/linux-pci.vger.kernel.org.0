Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252C6140E9
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 23:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJaWxd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 18:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaWxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 18:53:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29321120B8;
        Mon, 31 Oct 2022 15:53:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so11909985pgb.13;
        Mon, 31 Oct 2022 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8tdLudMN3YggMh4aeH+ycxFhI/pCELi7bzTmwhADkFE=;
        b=FHDJhmrN2A88HStVzW85W2zIcOXn7E9dnmI90tKytH/ZGBp5zBn9dZqTGskyihKRJn
         gum5GFedpJKG6DsDBz4NwyKcTjLhwgxlWonlD5sPZjB+ZRReBoi1aqN1tEvZK3dboCtf
         bPZvMvljPzbeK2m56ZZpDT16fHqmoNlSmoid+g4ATV5MAmFDf7G/BeZXI0G2ty3tIfvk
         tl6PdTEGDxlxMWaX5lsqS6ZpBAPze6p+aZJ4BYPvsgtdHGLxyl+MbisjxJqZTzSpGYll
         6Tc70cDyuwFXqB0dc4k1TRX9djqPajLOS1rIrOXAMMY6AxpWQSAmrfeuA8+JSlm8hJkp
         auwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tdLudMN3YggMh4aeH+ycxFhI/pCELi7bzTmwhADkFE=;
        b=Wp42OJTyfPiUg2OahCKiQODPEvr33uL8gQOJZpDPGOI1itIlcGXN0LKhmdOmK10KPw
         3exBxMyluBAjuZe19jidyFEnDpKqAiPocVk3DaW7lvv9TrKkKlb344+wL4byDk9+7rCs
         6ip/EXFSocxex65pjl23d8PKHNLpRrOmOY4+xVwY3nnD8gkNL8v5dqEsasjOaGSDvq+l
         kX5+xC75oT3VyB9r0ffKIaucLNup1NBP7d7iZZrujJjCyIv0ndUFdzHoLMwJ0sGDnjhj
         IgY0ztCx40dBrynwnS+6gM8NJvVSHq8Jypamd+Wt7TdatZjYUPoTPUudEcT0yfoVazDB
         YyCg==
X-Gm-Message-State: ACrzQf2FTJ9skA/7vjlSFZVv17u0ZzPpqavX0ila/wx/uesOjt4u7yN4
        uqnHg3mh97RwkXy9RDdri3LUrepTzQuJ6Zy77w8=
X-Google-Smtp-Source: AMsMyM6KMQ70L92GO/j4skIG5lj+U10qmAvPS/CuJ3pM/4aDrVAzh8pWDRAA/6k48+CdWxlqXyB7QUhZBgJ+UnBciSs=
X-Received: by 2002:a63:4517:0:b0:464:4f06:a0f1 with SMTP id
 s23-20020a634517000000b004644f06a0f1mr14107055pga.509.1667256810431; Mon, 31
 Oct 2022 15:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAP03XeoDZvocZczcOJfM5L7mwH-W050zye7UXq29AhG6dm4Qug@mail.gmail.com>
 <CAErSpo73E9ZF+NdA+ZC9+JPhhhC=1o=Z9zAGP33ZgZzYwjj=-Q@mail.gmail.com>
In-Reply-To: <CAErSpo73E9ZF+NdA+ZC9+JPhhhC=1o=Z9zAGP33ZgZzYwjj=-Q@mail.gmail.com>
From:   Christopher Obbard <obbardc@gmail.com>
Date:   Mon, 31 Oct 2022 22:53:19 +0000
Message-ID: <CAP03XeoKZgS5YmWZrOUAz-D5nF9aj=HrJfZ0ELJKk72RT4F_Xg@mail.gmail.com>
Subject: Re: linux: System doesn't resume from suspend anymore with "PCI/PM:
 Do not call pci_update_current_state() from pci_power_up()"
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Mon, 31 Oct 2022 at 16:35, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> On Fri, Oct 28, 2022 at 6:40 PM Christopher Obbard <obbardc@gmail.com> wrote:
> >
> > Hi!
> >
> > With recent kernels, my machine no longer wakes from suspend properly.
> > It wakes from e.g. a USB keyboard but then just hangs.
> > Once hung, the numlock key on the keyboard is illuminated but doesn't
> > react to changes, no errors are recorded in the journal and the SSH
> > server no longer works.
>
> It's best if you can cc: linux-pci@vger.kernel.org and
> linux-pm@vger.kernel.org.  I didn't do it for you in case you don't
> want to expose your email address.

Apologies, I will make sure to CC the list next time.
In any case, I have CC'd the lists in my reply here, which includes
the original submission and your reply above. If that is not
acceptable and you think I should post another mail please let me
know.


> It sounds like you may have bisected this issue to 0b59193548e6.  If
> so, that's incredibly helpful, thank you!  Can you also verify that
> reverting 0b59193548e6 resolves the problem?

Right, I bisected the issue to that commit. Unfortunately the patch
didn't revert cleanly; I can't really revert it without modifying the
other parts of the code. Your help would be appreciated; I can test
any patches.


> If I understand correctly, there's no obvious problem with suspend.
> When you attempt resume by pressing a key on a USB keyboard, you do
> see a change (numlock indicator illuminates), but the machine is
> otherwise hung and does not resume.

Exactly that. I only tried waking up by pressing a key on the USB
keyboard (that will become important later...)


> Right?  If it is hung, how can
> you tell that no errors are recorded in the journal?

Unfortunately after spending far too long looking in the manual and at
the motherboard itself, there appears to be no onboard serial port for
a console.
I've enabled persistent journal flushing to disk, but unfortunately I
think the disk is also offline or systemd misses the flush when the
system hangs.

I re-seated the PCI graphics card and generally inspected inside the case too.
I enabled the onboard VGA (rather than the PCI graphics card) and I
got a console on the screen after the resume, where I could print the
dmesg output.
Something very odd happened this time: when it was in suspend I woke
it up by pressing the power button (rather than pressing a key on the
USB keyboard), and the machine seemed to hang for a few seconds but
eventually recovered.

Now it seems to always recover even by pressing a key on the USB
keyboard. I can't explain why it now works...
I attached a snippet of the kernel log (from a recent mainline) below,
if it's of any use. I will keep stress testing and report back in a
week or so in case there are further issues.


Thanks,

Chris

> > I did a rebase from 5.17 (which worked) and latest linux release, and
s/rebase/bisect/ (please blame too much wine)



> > found that the regression was introduced with "PCI/PM: Do not call
> > pci_update_current_state() from pci_power_up()"
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b59193548e63957101aae5e4fc47151fce4a629
> >
> > My machine is running latest debian unstable, but this also happens
> > with a fedora install.
> > The machine is quite old, with a BIOS from 2015, but this shouldn't
> > matter when running linux, right? :-)
> >
> > Specs:
> > Asus H81I-Plus motherboard
> > Intel Core i5-4460 3.20GHz
> > AMD RX 580 Graphics card
> >
> > chris@nemesis:~$ lspci
> > 00:00.0 Host bridge: Intel Corporation 4th Gen Core Processor DRAM
> > Controller (rev 06)
> > 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v3/4th Gen Core
> > Processor PCI Express x16 Controller (rev 06)
> > 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> > Family USB xHCI (rev 05)
> > 00:16.0 Communication controller: Intel Corporation 8 Series/C220
> > Series Chipset Family MEI Controller #1 (rev 04)
> > 00:1a.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> > Family USB EHCI #2 (rev 05)
> > 00:1b.0 Audio device: Intel Corporation 8 Series/C220 Series Chipset
> > High Definition Audio Controller (rev 05)
> > 00:1c.0 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> > Family PCI Express Root Port #1 (rev d5)
> > 00:1c.1 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> > Family PCI Express Root Port #2 (rev d5)
> > 00:1c.2 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
> > Family PCI Express Root Port #3 (rev d5)
> > 00:1d.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset
> > Family USB EHCI #1 (rev 05)
> > 00:1f.0 ISA bridge: Intel Corporation H81 Express LPC Controller (rev 05)
> > 00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series
> > Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05)
> > 00:1f.3 SMBus: Intel Corporation 8 Series/C220 Series Chipset Family
> > SMBus Controller (rev 05)
> > 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590] (rev e7)
> > 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> > HDMI Audio [Radeon RX 470/480 / 570/580/590]
> > 03:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
> > 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)

[  165.979399] PM: suspend entry (deep)
[  165.992100] Filesystems sync: 0.012 seconds
[  165.992270] Freezing user space processes ... (elapsed 0.022 seconds) done.
[  166.014460] OOM killer disabled.
[  166.014461] Freezing remaining freezable tasks ... (elapsed 1.792
seconds) done.
[  167.807460] printk: Suspending console(s) (use no_console_suspend to debug)
[  167.822466] sd 5:0:0:0: [sdc] Synchronizing SCSI cache
[  167.822527] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  167.822569] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  167.822644] sd 1:0:0:0: [sdb] Stopping disk
[  167.822661] sd 0:0:0:0: [sda] Stopping disk
[  167.823179] sd 5:0:0:0: [sdc] Stopping disk
[  168.134479] amdgpu 0000:01:00.0: amdgpu: PCI CONFIG reset
[  168.174469] ACPI: PM: Preparing to enter system sleep state S3
[  168.175702] ACPI: PM: Saving platform NVS memory
[  168.175868] Disabling non-boot CPUs ...
[  168.177960] smpboot: CPU 1 is now offline
[  168.181184] smpboot: CPU 2 is now offline
[  168.184122] smpboot: CPU 3 is now offline
[  168.187647] ACPI: PM: Low-level resume complete
[  168.187663] ACPI: PM: Restoring platform NVS memory
[  168.188070] Enabling non-boot CPUs ...
[  168.188112] x86: Booting SMP configuration:
[  168.188112] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  168.189911] CPU1 is up
[  168.189945] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  168.191771] CPU2 is up
[  168.191795] smpboot: Booting Node 0 Processor 3 APIC 0x6
[  168.193660] CPU3 is up
[  168.194504] ACPI: PM: Waking up from system sleep state S3
[  168.195400] pcieport 0000:00:1c.0: Enabling MPC IRBNCE
[  168.195403] pcieport 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[  168.195418] pcieport 0000:00:1c.1: Enabling MPC IRBNCE
[  168.195421] pcieport 0000:00:1c.1: Intel PCH root port ACS workaround enabled
[  168.195427] pcieport 0000:00:1c.2: Enabling MPC IRBNCE
[  168.195430] pcieport 0000:00:1c.2: Intel PCH root port ACS workaround enabled
[  168.196557] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
[  168.196937] sd 0:0:0:0: [sda] Starting disk
[  168.196949] sd 1:0:0:0: [sdb] Starting disk
[  168.196966] sd 5:0:0:0: [sdc] Starting disk
[  168.329792] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[  168.623385] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  168.623476] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  168.623657] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  168.624202] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.SAT0.SPT5._GTF.DSSP], AE_NOT_FOUND (20220331/psargs-330)
[  168.624207] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT5._GTF
due to previous error (AE_NOT_FOUND) (20220331/psparse-529)
[  168.625118] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.SAT0.SPT5._GTF.DSSP], AE_NOT_FOUND (20220331/psargs-330)
[  168.625123] ACPI Error: Aborting method \_SB.PCI0.SAT0.SPT5._GTF
due to previous error (AE_NOT_FOUND) (20220331/psparse-529)
[  168.625844] ata6.00: configured for UDMA/133
[  168.627065] ata1.00: configured for UDMA/133
[  168.632236] ata2.00: configured for UDMA/133
[  169.249068] [drm] Fence fallback timer expired on ring sdma0
[  169.761067] [drm] Fence fallback timer expired on ring sdma0
[  170.273065] [drm] Fence fallback timer expired on ring sdma0
[  170.397071] pcieport 0000:00:1c.0: pciehp: Slot(0): No link
[  170.785067] [drm] Fence fallback timer expired on ring sdma0
[  171.297067] [drm] Fence fallback timer expired on ring sdma0
[  171.809065] [drm] Fence fallback timer expired on ring sdma0
[  172.321066] [drm] Fence fallback timer expired on ring sdma0
[  172.833067] [drm] Fence fallback timer expired on ring sdma0
[  173.345066] [drm] Fence fallback timer expired on ring sdma0
[  173.857066] [drm] Fence fallback timer expired on ring sdma0
[  174.369067] [drm] Fence fallback timer expired on ring sdma0
[  174.881066] [drm] Fence fallback timer expired on ring sdma0
[  175.393065] [drm] Fence fallback timer expired on ring sdma0
[  175.905067] [drm] Fence fallback timer expired on ring sdma0
[  176.417067] [drm] Fence fallback timer expired on ring sdma0
[  176.929067] [drm] Fence fallback timer expired on ring sdma0
[  177.441066] [drm] Fence fallback timer expired on ring sdma0
[  177.953065] [drm] Fence fallback timer expired on ring sdma0
[  178.465066] [drm] Fence fallback timer expired on ring sdma0
[  178.605683] [drm] UVD and UVD ENC initialized successfully.
[  178.705717] [drm] VCE initialized successfully.
[  178.747462] OOM killer enabled.
[  178.747464] Restarting tasks ... done.
[  178.759450] random: crng reseeded on system resumption
[  178.759541] PM: suspend exit
[  178.901090] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY
driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
[  179.101213] r8169 0000:04:00.0 enp4s0: Link is Down
[  181.722347] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full -
flow control rx/tx
[  181.722355] IPv6: ADDRCONF(NETDEV_CHANGE): enp4s0: link becomes ready

> > Thanks for any help...
> > Chris
