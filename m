Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71EDF170C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 14:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKFN3L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 08:29:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:35175 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731876AbfKFN3L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 08:29:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 05:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="212773427"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 05:29:05 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 15:29:04 +0200
Date:   Wed, 6 Nov 2019 15:29:04 +0200
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
Message-ID: <20191106132904.GL2552@lahna.fi.intel.com>
References: <20191105152832.GC2552@lahna.fi.intel.com>
 <20191105161017.GA219591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105161017.GA219591@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 10:10:17AM -0600, Bjorn Helgaas wrote:
> > > I actually suspect there *is* a dependency -- we should respect the
> > > Target Link Speed and and width so the link resumes in the same
> > > configuration it was before suspend.  And I suspect that may require
> > > an explicit retrain after restoring PCI_EXP_LNKCTL2.
> > 
> > According the PCIe spec the PCI_EXP_LNKCTL2 Target Link Speed is marked
> > as RWS (S for sticky) so I suspect its value is retained after reset in
> > the same way as PME bits. Assuming I understood it correctly.
> 
> This patch is about coming from D3cold, isn't it?  I don't think we
> can assume sticky bits are preserved in D3cold (except maybe when
> auxiliary power is enabled).

Indeed, good point. I see some GPU drivers are programming Target Link
Speed which will not be retained after the hierarchy is put into D3cold
and back. I think this potential problem is not related to the missing
link delays this patch is addressing, though. It has been existing in
pci_restore_pcie_state() already (where it restores PCI_EXP_LNKCTL2).

I think this can be solved as a separate patch by doing something
like:

  1. In pci_restore_pcie_state() check if the saved Target Link Speed
     differs from what is in the register currently.

  2. Restore the value as we already do now.

  3. If there the speed differs then trigger link retrain.

  4. Restore rest of the root/downstream port state.

It is not clear if we need to do anything for upstream ports (PCIe 5.0
sec 6.11 talks about doing this on upstream component e.g downstream
port). After this there will be the link delay (added by this patch)
which takes care of waiting for the downstream component to be
accessible (even after retrain).

However, I'm not sure how this can be properly tested. Maybe hacking
some downstream port to lower the speed, enter D3cold and then resume it
and see if the Target Link Speed gets updated correctly.
