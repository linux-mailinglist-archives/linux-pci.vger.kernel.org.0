Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE549E4F5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiA0OqZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 09:46:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:38463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242643AbiA0OqX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 09:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643294783; x=1674830783;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/jq9vACHWJwLDheExQJOYCVhe0TuS3hd6gaFyO4Eio=;
  b=P+HsTRDrSwTt9m8YWFjmGZyoXqQRI5Jlb5Ek7JeIZbBS96Gh5u/cKGkQ
   PtHW6pptVRIPgXUNyv26V0rAGxI6/PVVBinADr3P4apfj+78yJQus7bSH
   vvmXxIrGdq685NkyAp4ckiP79pXzjJuAqdEUHafl4mZ4WJw4nGjgLEREo
   MSNGpINsFPQHcz/x/bhXUKvD+aICsZA7GJfa3c0MPfUXIJEbZ1qpkeVEb
   nLQnvPp1DpqtqDRh+1p9jEjieP+zJgmG6j+86S2/9NFexvEFwAk4Kre7a
   TwFn2bzOI0uCg3SsHMRTh2PXETN+72cWWYGfo7o5ItQbHr3glf/9a+6mD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="227546419"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="227546419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:46:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="535683854"
Received: from mtkaczyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.28.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 06:46:20 -0800
Date:   Thu, 27 Jan 2022 15:46:15 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220127154615.00003df8@linux.intel.com>
In-Reply-To: <20220124214635.GA1553164@bhelgaas>
References: <bug-215525-41252@https.bugzilla.kernel.org/>
        <20220124214635.GA1553164@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jan 2022 15:46:35 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc linux-pci, Hans, Lukas, Naveen, Keith, Nirmal, Jonathan]
> 
> On Mon, Jan 24, 2022 at 11:46:14AM +0000,
> bugzilla-daemon@bugzilla.kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=215525
> > 
> >             Bug ID: 215525
> >            Summary: HotPlug does not work on upstream kernel
> > 5.17.0-rc1 Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 5.17.0-rc1 upstream
> >           Hardware: x86-64
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: blazej.kucman@intel.com
> >         Regression: No
> > 
> > Created attachment 300308  
> >   -->
> > https://bugzilla.kernel.org/attachment.cgi?id=300308&action=edit
> > dmesg
> > 
> > While testing on latest upstream
> > kernel(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/)
> > we noticed that with the merge commit
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0a231f01e5b25bacd23e6edc7c979a18a517b2b)
> > hotplug and hotunplug of nvme drives stopped working.
> > 
> > Rescan PCI does not help.
> > echo "1" > /sys/bus/pci/rescan
> > 
> > Issue does not reproduce on a kernel built on an antecedent
> > commit(88db8458086b1dcf20b56682504bdb34d2bca0e2).
> > 
> > 
> > During hot-remove device does not disappear, however when we try to
> > do I/O on the disk then there is an I/O error, and the device
> > disappears.
> > 
> > Before I/O no logs regarding the disk appeared in the dmesg, only
> > after I/O the entries appeared like below:
> > [  177.943703] nvme nvme5: controller is down; will reset:
> > CSTS=0xffffffff, PCI_STATUS=0xffff
> > [  177.971661] nvme 10000:0b:00.0: can't change power state from
> > D3cold to D0 (config space inaccessible)
> > [  177.981121] pcieport 10000:00:02.0: can't derive routing for PCI
> > INT A [  177.987749] nvme 10000:0b:00.0: PCI INT A: no GSI
> > [  177.992633] nvme nvme5: Removing after probe failure status: -19
> > [  178.004633] nvme5n1: detected capacity change from 83984375 to 0
> > [  178.004677] I/O error, dev nvme5n1, sector 0 op 0x0:(READ) flags
> > 0x0 phys_seg 1 prio class 0
> > 
> > 
> > OS: RHEL 8.4 GA
> > Platform: Intel Purley
> > 
> > The logs are collected on a non-recent upstream kernel, but a issue
> > also occurs on the newest upstream
> > kernel(dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0)  
> 
> Apparently worked immediately before merging the PCI changes for
> v5.17 and failed immediately after:
> 
>   good: 88db8458086b ("Merge tag 'exfat-for-5.17-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat") bad:
>  d0a231f01e5b ("Merge tag 'pci-v5.17-changes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci")
> 
> Only three commits touch pciehp:
> 
>   085a9f43433f ("PCI: pciehp: Use down_read/write_nested(reset_lock)
> to fix lockdep errors") 23584c1ed3e1 ("PCI: pciehp: Fix infinite loop
> in IRQ handler upon power fault") a3b0f10db148 ("PCI: pciehp: Use
> PCI_POSSIBLE_ERROR() to check config reads")
> 
> None seems obviously related to me.  Blazej, could you try setting
> CONFIG_DYNAMIC_DEBUG=y and booting with 'dyndbg="file pciehp* +p"' to
> enable more debug messages?
> 

Hi Bjorn,

Thanks for your suggestions. Blazej did some tests and results were
inconclusive. He tested it on two same platforms. On the first one it
didn't work, even if he reverted all suggested patches. On the second
one hotplugs always worked.

He noticed that on first platform where issue has been found initally,
there was boot parameter "pci=nommconf". After adding this parameter
on the second platform, hotplugs stopped working too.

Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two dmesg
logs to bugzilla with boot parameter 'dyndbg="file pciehp* +p" as
requested. One with "pci=nommconf" and one without.

Issue seems to related to "pci=nommconf" and it is probably caused
by change outside pciehp.

He is currently working on email client setup to answer himself.

Thanks,
Mariusz


