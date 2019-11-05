Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B92F025E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfKEQKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 11:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389907AbfKEQKU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 11:10:20 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6985E214B2;
        Tue,  5 Nov 2019 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572970219;
        bh=3rYnlvzuKtYKdxK2uL8463vEILCkV2bc0KCoHjG4rOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AUgdAJyWEH4jSZMdcNYsS+U6qdrmOkZv5GqemhXlRuuax1I6SsMFqTQoJLIV602WS
         q/LvLBU6oP2DsikeiDPG2a57SCUF6MKz2V7pF1eM2GuTIwQw7zoYfSxDGjtsWsHhFr
         pbXurPTMm9MQUw7tA+z0I2DgNwk3LHOKDZVC8S9I=
Date:   Tue, 5 Nov 2019 10:10:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20191105161017.GA219591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105152832.GC2552@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 05:28:32PM +0200, Mika Westerberg wrote:
> On Tue, Nov 05, 2019 at 09:00:13AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 05, 2019 at 11:54:28AM +0200, Mika Westerberg wrote:
> > > On Mon, Nov 04, 2019 at 06:00:00PM -0600, Bjorn Helgaas wrote:
> > 
> > > > > If you think it is fine to do the delay before we have restored
> > > > > everything I can move it inside pci_power_up() or call it after
> > > > > pci_pm_default_resume_early() as above. I think at least we should make
> > > > > sure all the saved registers are restored before so that the link
> > > > > activation check actually works.
> > > > 
> > > > What needs to be restored to make pcie_wait_for_link_delay() work?
> > > 
> > > I'm not entirely sure. I think that pci_restore_state() at least should
> > > be called so that the PCIe capability gets restored. Maybe not even
> > > that because Data Link Layer Layer Active always reflects the DL_Active
> > > or not and it does not need to be enabled separately.
> > > 
> > > > And what event does the restore need to be ordered with?
> > > 
> > > Not sure I follow you here.
> > 
> > You're suggesting that we should restore saved registers first so
> > pcie_wait_for_link_delay() works.  If the link activation depends on
> > something being restored and we don't enforce an ordering, the
> > activation might succeed or fail depending on whether it happens
> > before or after the restore.  So if there is a dependency, we should
> > make it explicit to avoid a race like that.
> 
> OK thanks. By explicit you mean document it in the code, right?

So far all we have is a feeling that maybe we ought to restore before
waiting, but I don't really know why.  If there's an actual
dependency, we should chase down specifically what it is and add a
comment or code (e.g., a link retrain) as appropriate.

> > I actually suspect there *is* a dependency -- we should respect the
> > Target Link Speed and and width so the link resumes in the same
> > configuration it was before suspend.  And I suspect that may require
> > an explicit retrain after restoring PCI_EXP_LNKCTL2.
> 
> According the PCIe spec the PCI_EXP_LNKCTL2 Target Link Speed is marked
> as RWS (S for sticky) so I suspect its value is retained after reset in
> the same way as PME bits. Assuming I understood it correctly.

This patch is about coming from D3cold, isn't it?  I don't think we
can assume sticky bits are preserved in D3cold (except maybe when
auxiliary power is enabled).
