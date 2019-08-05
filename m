Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997E081A21
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 15:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfHENA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 09:00:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:45596 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHENA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 09:00:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 05:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="192414268"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 05:59:49 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 15:59:48 +0300
Date:   Mon, 5 Aug 2019 15:59:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20190805125948.GO2640@lahna.fi.intel.com>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
 <20190618125051.2382-2-mika.westerberg@linux.intel.com>
 <20190805111854.al5bj3q2gdng5ai6@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805111854.al5bj3q2gdng5ai6@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 01:18:54PM +0200, Lukas Wunner wrote:
> On Tue, Jun 18, 2019 at 03:50:51PM +0300, Mika Westerberg wrote:
> > If there are more than one PCIe switch with hotplug downstream ports
> > hot-removing them leads to a following deadlock:
> [...]
> > What happens here is that the whole hierarchy is runtime resumed and the
> > parent PCIe downstream port, who got the hot-remove event, starts
> > removing devices below it taking pci_lock_rescan_remove() lock. When the
> > child PCIe port is runtime resumed it calls pciehp_check_presence()
> > which ends up calling pciehp_card_present() and pciehp_check_link_active().
> > Both of these read their parts of PCIe config space by calling helper
> > function pcie_capability_read_word(). Now, this function notices that
> > the underlying device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND
> > with the capability value set to 0. When pciehp gets this value it
> > thinks that its child device is also hot-removed and schedules its IRQ
> > thread to handle the event.
> > 
> > The deadlock happens when the child's IRQ thread runs and tries to
> > acquire pci_lock_rescan_remove() which is already taken by the parent
> > and the parent waits for the child's IRQ thread to finish.
> > 
> > We can prevent this from happening by checking the return value of
> > pcie_capability_read_word() and if it is PCIBIOS_DEVICE_NOT_FOUND stop
> > performing any hot-removal activities.
> 
> IIUC this patch only avoids the deadlock if the child hotplug port happens
> to be runtime suspended when it is surprise removed.  The deadlock isn't
> avoided if is runtime resumed.
> 
> This patch I posted last year should cover both cases:
> 
> https://patchwork.kernel.org/patch/10468065/
> 
> However, as I've noted in this follow-up to the patch, I don't consider
> my solution a proper fix either:
> 
> https://patchwork.kernel.org/patch/10468065/#22206721
> 
> Rather, the problem should be addressed by unbinding PCI drivers without
> holding pci_lock_rescan_remove().
> 
> I'm truly sorry but I haven't been able to make much progress on this
> as I got caught up with other things.  Part of the problem is that this
> is volunteer work.  Maybe someone's interested in hiring me to work on it?
> Resume available on request.  (But I'll get to it sooner or later whether
> paid or not, unless someone else beats me to it. :-) )

In any case we should do something about this sooner rather than later
as this is really annoying issue and starts to affect more and more
people.

This patch avoids touching the hardware as soon as we detect it is gone
already preventing the issue so I think it is the right thing to do
regardless. Having "perfect" fix sounds good but in the meantime I think
we should have a fix that at least prevents the most common case from
happening which here means unplugging 2 or more devices.

Up to Bjorn of course :)
