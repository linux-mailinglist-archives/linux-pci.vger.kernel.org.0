Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78AF0163
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 16:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbfKEP2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 10:28:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:20980 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389546AbfKEP2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 10:28:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 07:28:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212559786"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 07:28:33 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Nov 2019 17:28:32 +0200
Date:   Tue, 5 Nov 2019 17:28:32 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191105152832.GC2552@lahna.fi.intel.com>
References: <20191105095428.GR2552@lahna.fi.intel.com>
 <20191105150013.GA202873@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105150013.GA202873@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 09:00:13AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 05, 2019 at 11:54:28AM +0200, Mika Westerberg wrote:
> > On Mon, Nov 04, 2019 at 06:00:00PM -0600, Bjorn Helgaas wrote:
> 
> > > > If you think it is fine to do the delay before we have restored
> > > > everything I can move it inside pci_power_up() or call it after
> > > > pci_pm_default_resume_early() as above. I think at least we should make
> > > > sure all the saved registers are restored before so that the link
> > > > activation check actually works.
> > > 
> > > What needs to be restored to make pcie_wait_for_link_delay() work?
> > 
> > I'm not entirely sure. I think that pci_restore_state() at least should
> > be called so that the PCIe capability gets restored. Maybe not even
> > that because Data Link Layer Layer Active always reflects the DL_Active
> > or not and it does not need to be enabled separately.
> > 
> > > And what event does the restore need to be ordered with?
> > 
> > Not sure I follow you here.
> 
> You're suggesting that we should restore saved registers first so
> pcie_wait_for_link_delay() works.  If the link activation depends on
> something being restored and we don't enforce an ordering, the
> activation might succeed or fail depending on whether it happens
> before or after the restore.  So if there is a dependency, we should
> make it explicit to avoid a race like that.

OK thanks. By explicit you mean document it in the code, right?

> But I'm not saying we *shouldn't* do the restore before the wait; only
> that any dependency should be explicit.  Even if there is no actual
> dependency it probably makes sense to do the restore first so it can
> overlap with the hardware link training, which may reduce the time
> pcie_wait_for_link_delay() has to wait when we do call it, e.g.,
> 
>   |-----------------|          link activation
>      |-----|                   restore state
>            |--------|          pcie_wait_for_link_delay()
> 
> whereas if we do the restore after waiting for the link to come up, it
> probably takes longer:
> 
>   |-----------------|          link activation
>      |--------------|          pcie_wait_for_link_delay()
>                     |-----|    restore state
> 
> I actually suspect there *is* a dependency -- we should respect the
> Target Link Speed and and width so the link resumes in the same
> configuration it was before suspend.  And I suspect that may require
> an explicit retrain after restoring PCI_EXP_LNKCTL2.

According the PCIe spec the PCI_EXP_LNKCTL2 Target Link Speed is marked
as RWS (S for sticky) so I suspect its value is retained after reset in
the same way as PME bits. Assuming I understood it correctly.
