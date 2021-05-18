Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ECB3876D4
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhERKpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 06:45:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:31560 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhERKpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 May 2021 06:45:51 -0400
IronPort-SDR: 193v1hvtmGJq0DV4ywdvw4DKn5KyuZUwRtwCVbdcmqvwDDR0RcZBH0YNJV13PK08Dn1UMlq74H
 rUx9PQVzRNyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180283154"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="180283154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:44:32 -0700
IronPort-SDR: hjIGpdXi3LMZc7zURqkTHxre7gM5jYWhE8080X2d4e/JZak5C5Tqt8pyYFFWbHrVqgyNpNvnR7
 QjEYt5f1bDBQ==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="411211843"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:44:28 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 18 May 2021 13:44:25 +0300
Date:   Tue, 18 May 2021 13:44:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI/PM: Target PM state is D3cold if the upstream bridge
 is power manageable
Message-ID: <20210518104425.GA290141@lahna.fi.intel.com>
References: <20210510102647.40322-1-mika.westerberg@linux.intel.com>
 <CACK8Z6E=4Eeo-hAdXOxJLxUr57hGZbAf-YL6e6XZmoyfj2XGfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6E=4Eeo-hAdXOxJLxUr57hGZbAf-YL6e6XZmoyfj2XGfQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, May 17, 2021 at 03:33:56PM -0700, Rajat Jain wrote:
> [+Kai]
> 
> Hi,
> 
> I don't understand the power management very well, so pardon my
> ignorance but I have a question.
> 
> On Mon, May 10, 2021 at 3:30 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > ASMedia xHCI controller only supports PME from D3cold:
> >
> > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> >   ...
> >   Capabilities: [78] Power Management version 3
> >           Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >           Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >
> > Now, if the controller is part of a Thunderbolt device for instance, it
> > is connected to a PCIe switch downstream port. When the hierarchy then
> > enters D3cold as a result of s2idle cycle pci_target_state() returns D0
> > because the device does not support PME from the default target_state
> > (D3hot). So what happens is that the whole hierarchy is left into D0
> > breaking power management.at suspend time or resume time
> 
> Can you please provide a small call stack, when this issue is seen?
> (I'm primarily trying to understand whether the issue is breaking
> suspend, or the suspend is fine, but resume is broken?)

It is on suspend path. I added WARN_ON() to log the whole chain:

[   37.820164] RIP: 0010:pci_target_state+0x7f/0x100
[   37.820172] Code: 9d 00 00 00 01 19 c0 f7 d0 83 e0 03 83 bb 98 00 00 00 04 74 1b 40 84 ed 74 e1 0f b6 93 9e 00 00 00 f6 c2 1f 74 3d 85 c0 75 1c <0f> 0b 31 c0 eb cb b8 04 00 00 00 40 84 ed 74 c1 0f b6 93 9e 00 00
[   37.820180] RSP: 0018:ffff9e6bc037bd40 EFLAGS: 00010246
[   37.820188] RAX: 0000000000000000 RBX: ffff8a5984da4000 RCX: 0000000000000000
[   37.820194] RDX: 0000000000000010 RSI: 0000000000000001 RDI: 0000000000000000
[   37.820199] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   37.820203] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   37.820208] R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000000
[   37.820213] FS:  0000000000000000(0000) GS:ffff8a5d1f600000(0000) knlGS:0000000000000000
[   37.820221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.820243] CR2: 00007fe0fc96e1c8 CR3: 00000002a3012001 CR4: 0000000000770ee0
[   37.820249] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.820253] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   37.820256] PKRU: 55555554
[   37.820260] Call Trace:
[   37.820265]  pci_prepare_to_sleep+0x2e/0xc0
[   37.820275]  hcd_pci_suspend_noirq+0x58/0x130
[   37.820281]  ? find_held_lock+0x32/0x90
[   37.820289]  pci_pm_suspend_noirq+0x6d/0x290
[   37.820297]  ? lock_release+0x14f/0x430
[   37.820306]  ? pci_pm_suspend_late+0x30/0x30
[   37.820315]  dpm_run_callback+0x61/0x1d0
[   37.820330]  __device_suspend_noirq+0x84/0x270
[   37.820340]  async_suspend_noirq+0x16/0x90
[   37.820348]  async_run_entry_fn+0x2e/0x120
[   37.820360]  process_one_work+0x27c/0x540
[   37.820378]  worker_thread+0x4d/0x3f0
[   37.820387]  ? rescuer_thread+0x390/0x390
[   37.820396]  kthread+0x14c/0x170
[   37.820403]  ? __kthread_bind_mask+0x60/0x60
[   37.820413]  ret_from_fork+0x1f/0x30


> > For this reason choose target_state to be D3cold if there is a upstream
> > bridge that is power manageable.
> 
> It seems to me that the goal of pci_target_state() is to find the
> lowest power state that a device can be put into, from which device
> can still generate PME (if needed). So I'm curious why it starts with
> target_state = PCI_D3hot in the first place? Wouldn't starting with
> PCI_D3cold will always be better (regardless of parent bridge
> capabilities)?

That one is not my code but I suspect that for two reasons: one is historic
(older devices did not have proper D3cold support), the other is that typically
with S3/S4 it is the BIOS that in the end configures wakes (which of course
does not work with s2idle and especially devices that are not-onboard to begin
with).

I may be wrong too.

> And then I came across the commit 8feaec33b986 ("PCI / PM: Always
> check PME wakeup capability for runtime wakeup support"), which
> addresses the same device that this patch addresses, and 1 excerpt
> from the commit log that stood out:
> ============================================================
>     In addition, change wakeup flag passed to pci_target_state() from false
>     to true, because we want to find the deepest state *different from D3cold*
>     that the device can still generate PME#. In this case, it's D0 for the
>     device in question.
> ============================================================
> 
> So, does returning D3Cold from this function break any other
> assumption somewhere?

I can't be 100% sure but effectively the device is in D3cold once the parent
bridge is in D3hot as the device config space is not accessible anymore.
