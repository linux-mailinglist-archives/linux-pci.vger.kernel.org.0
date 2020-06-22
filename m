Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7FE203C97
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFVQbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 12:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgFVQba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 12:31:30 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 815C420767;
        Mon, 22 Jun 2020 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592843489;
        bh=jrPTuOC3k/t/ZEJkt9ApRFgCKVnnuXPTscMU+uUNKJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WMMmhPX92aRuHb+5XabOGlW0P5GYtQGQWK9pm8PQzKjlDE2sjaqKPat20HxKcscfN
         79vXqsIvdeEUKFttQ9SPX3uYNQjJgOts4f06h0LP9JR3fhNUpsBhWMT6p/MFj/lho3
         vmlMl7eFOus8OwxJH4ZHnuB+1mqmw1Zm89uTUc54=
Date:   Mon, 22 Jun 2020 11:31:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, kernel-team@android.com
Subject: Re: [PATCH] PCI/IOV: Plug VF bus creation race
Message-ID: <20200622163127.GA2275649@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622141820.7675d07d@why>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 02:18:20PM +0100, Marc Zyngier wrote:
> On Sun,  7 Jun 2020 10:43:48 +0100
> Marc Zyngier <maz@kernel.org> wrote:
> 
> Hi Bjorn,
> 
> > On a system that creates VFs for multiple PFs in parallel (in
> > this case, network bringup at boot time), and when these VFs
> > end-up on the same bus, bad things sometimes happen:
> > 
> > [   12.755534] sysfs: cannot create duplicate filename '/devices/platform/soc/fc000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:04'
> > [   12.755700] pci 0000:04:10.1: [8086:10ca] type 00 class 0x020000
> > [   12.763785] CPU: 1 PID: 581 Comm: vfs Tainted: G            E     5.7.0-00033-g002d24ebd695 #1119
> > [   12.770402] igb 0000:03:00.1: 1 VFs allocated
> > [   12.778493] Hardware name: amlogic w400/w400, BIOS 2020.01-rc5 03/12/2020
> > [   12.778496] Call trace:
> > [   12.778506]  dump_backtrace+0x0/0x1d0
> > [   12.778511]  show_stack+0x20/0x30
> > [   12.778516]  dump_stack+0xb8/0x100
> > [   12.778520]  sysfs_warn_dup+0x6c/0x88
> > [   12.778530]  sysfs_create_dir_ns+0xe8/0x100
> > [   12.778535]  kobject_add_internal+0xe0/0x3a0
> > [   12.778541]  kobject_add+0x94/0x100
> > [   12.817654]  device_add+0x104/0x7b8
> > [   12.821100]  device_register+0x28/0x38
> > [   12.824810]  pci_add_new_bus+0x1f8/0x488
> > [   12.828692]  pci_iov_add_virtfn+0x2c8/0x360
> > [   12.832830]  sriov_enable+0x200/0x458
> > [   12.836452]  pci_enable_sriov+0x20/0x38
> > [   12.840282]  igb_enable_sriov+0x148/0x290 [igb]
> > [   12.844745]  igb_pci_sriov_configure+0x40/0x80 [igb]
> > [   12.849650]  sriov_numvfs_store+0xb0/0x1a0
> > [   12.853703]  dev_attr_store+0x20/0x38
> > [   12.857327]  sysfs_kf_write+0x4c/0x60
> > [   12.860947]  kernfs_fop_write+0x104/0x220
> > [   12.864916]  __vfs_write+0x24/0x50
> > [   12.868279]  vfs_write+0xec/0x1d8
> > [   12.871556]  ksys_write+0x74/0x100
> > [   12.874919]  __arm64_sys_write+0x24/0x30
> > [   12.878802]  el0_svc_common.constprop.0+0x7c/0x1f8
> > [   12.883544]  do_el0_svc+0x2c/0x98
> > [   12.886824]  el0_svc+0x18/0x48
> > [   12.889841]  el0_sync_handler+0x120/0x290
> > [   12.893808]  el0_sync+0x158/0x180
> > [   12.897143] kobject_add_internal failed for 0000:04 with -EEXIST, don't try to register things with the same name in the same directory.
> > [   12.897634] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> > 
> > It turns out that virtfn_add_bus() doesn't hold any lock, which
> > means there is a potential race between checking that the bus
> > exists already, and adding it if it doesn't.
> > 
> > A per-device lock wouldn't help, as this happens when multiple
> > PFs insert their respective VFs concurrently.
> > 
> > Instead, let's introduce new mutex, private to the IOV subsystem,
> > that gets taken when dealing with a virtfn bus (either creation
> > or destruction). This ensures that these operations get serialized.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Did you have a chance to look into this? I can reliably trigger it on
> one of my boxes. Happy to help debugging it further if you think this
> hack isn't the right fix.

Haven't had a chance yet; thanks for the ping.

Bjorn
