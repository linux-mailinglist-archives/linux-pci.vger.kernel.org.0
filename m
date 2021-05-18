Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6757387707
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348706AbhERLCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 07:02:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348705AbhERLCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 07:02:00 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lixSq-0004kO-QJ
        for linux-pci@vger.kernel.org; Tue, 18 May 2021 11:00:40 +0000
Received: by mail-lj1-f199.google.com with SMTP id s4-20020a2eb8c40000b02900bbf0cb2373so4323930ljp.18
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 04:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ic13UiSZU2nyUlZkJTy1bjQfZg8VJYMWh3ov72IPYaE=;
        b=JS/bUHm+IJ2OjepbtI+rcONn4j1+TujkYqYaHFc41AFCA767oxxFfLsTsE8A8lL1on
         cGPUkQS+Am7+tyXouVMtDIOR2r2ViRM+cNKn18gUZLAualnfFLoaz0JdrI7WzzEasMqB
         326jXlMVMmVvCoc120Kreh+DePbngIJo7vYoFjoXSenhjnFGGMZTClBJVvm+wBp05Y/E
         TNCyxNFX/gzhaB3oPdSR8a/rodvsT7A4OQ3DKt2aOdnzL3UbS9SNVCggk5SpITbArNMb
         FRsBBjajHonIIxkwJ8C/f4fMeSuaMNiuycxvFOuuygLaEFLh5F62LOK92lXbBmr+/KYX
         DopQ==
X-Gm-Message-State: AOAM5304lyCaXUr+gLrMc7zAY+zKHv58ZO/Y9Mwv9t+R4xXcc7YQiWcl
        WJgPi87aqbW+4EUfXLSKeLJDyVS+WhHhVcd5nC+YnnYZ1ZRMbcRiJfAmXvtlMcVtI4UAo3DUNsH
        B/0eucx3fK/0+wKcvv1lzY12SlHDRpIuegIy8Z28Yv1e95eNGQXwRgg==
X-Received: by 2002:a2e:9b4d:: with SMTP id o13mr3568561ljj.403.1621335640038;
        Tue, 18 May 2021 04:00:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCH9BTSxTTiG/edqt4V0m0GSYIakzYv43AcR6i/NvFFwtRHA/R/h/a9q6jut4XiNkhzpHxFh7vVt51xrFh9u4=
X-Received: by 2002:a2e:9b4d:: with SMTP id o13mr3568539ljj.403.1621335639677;
 Tue, 18 May 2021 04:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
 <CACK8Z6E=4Eeo-hAdXOxJLxUr57hGZbAf-YL6e6XZmoyfj2XGfQ@mail.gmail.com> <20210518104425.GA290141@lahna.fi.intel.com>
In-Reply-To: <20210518104425.GA290141@lahna.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 18 May 2021 19:00:27 +0800
Message-ID: <CAAd53p4+9UznP+B=6TodcYrWvp1ffFmDV4rZynmVd_EUsHeEqA@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge
 is power manageable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 6:44 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, May 17, 2021 at 03:33:56PM -0700, Rajat Jain wrote:
> > [+Kai]
> >
> > Hi,
> >
> > I don't understand the power management very well, so pardon my
> > ignorance but I have a question.
> >
> > On Mon, May 10, 2021 at 3:30 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > ASMedia xHCI controller only supports PME from D3cold:
> > >
> > > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> > >   ...
> > >   Capabilities: [78] Power Management version 3
> > >           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > >           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > Now, if the controller is part of a Thunderbolt device for instance, it
> > > is connected to a PCIe switch downstream port. When the hierarchy then
> > > enters D3cold as a result of s2idle cycle pci_target_state() returns D0
> > > because the device does not support PME from the default target_state
> > > (D3hot). So what happens is that the whole hierarchy is left into D0
> > > breaking power management.at suspend time or resume time
> >
> > Can you please provide a small call stack, when this issue is seen?
> > (I'm primarily trying to understand whether the issue is breaking
> > suspend, or the suspend is fine, but resume is broken?)
>
> It is on suspend path. I added WARN_ON() to log the whole chain:
>
> [   37.820164] RIP: 0010:pci_target_state+0x7f/0x100
> [   37.820172] Code: 9d 00 00 00 01 19 c0 f7 d0 83 e0 03 83 bb 98 00 00 00 04 74 1b 40 84 ed 74 e1 0f b6 93 9e 00 00 00 f6 c2 1f 74 3d 85 c0 75 1c <0f> 0b 31 c0 eb cb b8 04 00 00 00 40 84 ed 74 c1 0f b6 93 9e 00 00
> [   37.820180] RSP: 0018:ffff9e6bc037bd40 EFLAGS: 00010246
> [   37.820188] RAX: 0000000000000000 RBX: ffff8a5984da4000 RCX: 0000000000000000
> [   37.820194] RDX: 0000000000000010 RSI: 0000000000000001 RDI: 0000000000000000
> [   37.820199] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> [   37.820203] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   37.820208] R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000000
> [   37.820213] FS:  0000000000000000(0000) GS:ffff8a5d1f600000(0000) knlGS:0000000000000000
> [   37.820221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.820243] CR2: 00007fe0fc96e1c8 CR3: 00000002a3012001 CR4: 0000000000770ee0
> [   37.820249] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   37.820253] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   37.820256] PKRU: 55555554
> [   37.820260] Call Trace:
> [   37.820265]  pci_prepare_to_sleep+0x2e/0xc0
> [   37.820275]  hcd_pci_suspend_noirq+0x58/0x130
> [   37.820281]  ? find_held_lock+0x32/0x90
> [   37.820289]  pci_pm_suspend_noirq+0x6d/0x290
> [   37.820297]  ? lock_release+0x14f/0x430
> [   37.820306]  ? pci_pm_suspend_late+0x30/0x30
> [   37.820315]  dpm_run_callback+0x61/0x1d0
> [   37.820330]  __device_suspend_noirq+0x84/0x270
> [   37.820340]  async_suspend_noirq+0x16/0x90
> [   37.820348]  async_run_entry_fn+0x2e/0x120
> [   37.820360]  process_one_work+0x27c/0x540
> [   37.820378]  worker_thread+0x4d/0x3f0
> [   37.820387]  ? rescuer_thread+0x390/0x390
> [   37.820396]  kthread+0x14c/0x170
> [   37.820403]  ? __kthread_bind_mask+0x60/0x60
> [   37.820413]  ret_from_fork+0x1f/0x30
>
>
> > > For this reason choose target_state to be D3cold if there is a upstream
> > > bridge that is power manageable.
> >
> > It seems to me that the goal of pci_target_state() is to find the
> > lowest power state that a device can be put into, from which device
> > can still generate PME (if needed). So I'm curious why it starts with
> > target_state = PCI_D3hot in the first place? Wouldn't starting with
> > PCI_D3cold will always be better (regardless of parent bridge
> > capabilities)?
>
> That one is not my code but I suspect that for two reasons: one is historic
> (older devices did not have proper D3cold support), the other is that typically
> with S3/S4 it is the BIOS that in the end configures wakes (which of course
> does not work with s2idle and especially devices that are not-onboard to begin
> with).
>
> I may be wrong too.
>
> > And then I came across the commit 8feaec33b986 ("PCI / PM: Always
> > check PME wakeup capability for runtime wakeup support"), which
> > addresses the same device that this patch addresses, and 1 excerpt
> > from the commit log that stood out:
> > ============================================================
> >     In addition, change wakeup flag passed to pci_target_state() from false
> >     to true, because we want to find the deepest state *different from D3cold*
> >     that the device can still generate PME#. In this case, it's D0 for the
> >     device in question.
> > ============================================================
> >
> > So, does returning D3Cold from this function break any other
> > assumption somewhere?
>
> I can't be 100% sure but effectively the device is in D3cold once the parent
> bridge is in D3hot as the device config space is not accessible anymore.

The patch is to fix a regression that ASmedia is runtime-suspended to
D3cold and PME stops working.
D3cold PME in general requires platform firmware support, so that
commit will prevent D3cold being the target state for _runtime_
suspend.

For system-wide suspend I think this patch is doing the correct thing
as Mika mentioned above.

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
