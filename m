Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BA499CC5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380150AbiAXWId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 17:08:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35150 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354273AbiAXVqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 16:46:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C90612E5
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 21:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E4EC340E4;
        Mon, 24 Jan 2022 21:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643060797;
        bh=94EHg9NcGXERmJBWkRSHw5FQBuRuJAERjT8d/fJMeQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R3g+beBGv9x5rpiSXy9UDJw4e3EEzMSWYd5YdmICeigfYsM2a3WpRlNB/Rkxg9fEZ
         RC8itfant+OzNbscllOU0FUKc6yynMXtCeI5o7Vfd+qJV7ZB3n+GwpDBpVen9zeMYI
         zeDkziBEsn1OsGU1+ZlLNNJQciLS0o8aF7KXXTRhL9nKQqv3DJ2KpPIvyp5czzvzpH
         Ri1MMtoEzo0H89DVMyo57/ZtfWx4gr+UXv7mRSQskMmhEgCYB8hGpevLuh6cjcQvMo
         WPSidXCFxb601Bf9msqPvv7mQ4tASpwvIZ/cGkZVn4TomErqwAPPh4ZTT/D75vfmF5
         hF+/JFMMycQjg==
Date:   Mon, 24 Jan 2022 15:46:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220124214635.GA1553164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215525-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, Hans, Lukas, Naveen, Keith, Nirmal, Jonathan]

On Mon, Jan 24, 2022 at 11:46:14AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215525
> 
>             Bug ID: 215525
>            Summary: HotPlug does not work on upstream kernel 5.17.0-rc1
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.17.0-rc1 upstream
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: blazej.kucman@intel.com
>         Regression: No
> 
> Created attachment 300308
>   --> https://bugzilla.kernel.org/attachment.cgi?id=300308&action=edit
> dmesg
> 
> While testing on latest upstream
> kernel(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/) we
> noticed that with the merge commit
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0a231f01e5b25bacd23e6edc7c979a18a517b2b)
> hotplug and hotunplug of nvme drives stopped working.
> 
> Rescan PCI does not help.
> echo "1" > /sys/bus/pci/rescan
> 
> Issue does not reproduce on a kernel built on an antecedent
> commit(88db8458086b1dcf20b56682504bdb34d2bca0e2).
> 
> 
> During hot-remove device does not disappear, however when we try to do I/O on
> the disk then there is an I/O error, and the device disappears.
> 
> Before I/O no logs regarding the disk appeared in the dmesg, only after I/O the
> entries appeared like below:
> [  177.943703] nvme nvme5: controller is down; will reset: CSTS=0xffffffff,
> PCI_STATUS=0xffff
> [  177.971661] nvme 10000:0b:00.0: can't change power state from D3cold to D0
> (config space inaccessible)
> [  177.981121] pcieport 10000:00:02.0: can't derive routing for PCI INT A
> [  177.987749] nvme 10000:0b:00.0: PCI INT A: no GSI
> [  177.992633] nvme nvme5: Removing after probe failure status: -19
> [  178.004633] nvme5n1: detected capacity change from 83984375 to 0
> [  178.004677] I/O error, dev nvme5n1, sector 0 op 0x0:(READ) flags 0x0
> phys_seg 1 prio class 0
> 
> 
> OS: RHEL 8.4 GA
> Platform: Intel Purley
> 
> The logs are collected on a non-recent upstream kernel, but a issue also occurs
> on the newest upstream kernel(dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0)

Apparently worked immediately before merging the PCI changes for
v5.17 and failed immediately after:

  good: 88db8458086b ("Merge tag 'exfat-for-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat")
  bad:  d0a231f01e5b ("Merge tag 'pci-v5.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")

Only three commits touch pciehp:

  085a9f43433f ("PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors")
  23584c1ed3e1 ("PCI: pciehp: Fix infinite loop in IRQ handler upon power fault")
  a3b0f10db148 ("PCI: pciehp: Use PCI_POSSIBLE_ERROR() to check config reads")

None seems obviously related to me.  Blazej, could you try setting
CONFIG_DYNAMIC_DEBUG=y and booting with 'dyndbg="file pciehp* +p"' to
enable more debug messages?

Bjorn
