Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAC9F008D
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 16:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfKEPAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 10:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbfKEPAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 10:00:15 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC0521929;
        Tue,  5 Nov 2019 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572966015;
        bh=FOHqMxJfsqatCaBk5cjmzjcWwDv6YlqidixM8TSm1sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rPr4oAtsDMazf4gNUTAq7OoXfOY7x5pgPzLVoEBrlo6KTlcZDdQP6qJZa/1OyIVG4
         7sjzCJzxTGjE4mX3MYmjDU2jAMT0KNjoknSMVJ8xoQHxvZ4GvxdVrJtYUumiFz+DB9
         OF9qiA537sHjVxU7daZKQuqhIYnvpr5ix4gNdRVU=
Date:   Tue, 5 Nov 2019 09:00:13 -0600
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
Message-ID: <20191105150013.GA202873@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105095428.GR2552@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:54:28AM +0200, Mika Westerberg wrote:
> On Mon, Nov 04, 2019 at 06:00:00PM -0600, Bjorn Helgaas wrote:

> > > If you think it is fine to do the delay before we have restored
> > > everything I can move it inside pci_power_up() or call it after
> > > pci_pm_default_resume_early() as above. I think at least we should make
> > > sure all the saved registers are restored before so that the link
> > > activation check actually works.
> > 
> > What needs to be restored to make pcie_wait_for_link_delay() work?
> 
> I'm not entirely sure. I think that pci_restore_state() at least should
> be called so that the PCIe capability gets restored. Maybe not even
> that because Data Link Layer Layer Active always reflects the DL_Active
> or not and it does not need to be enabled separately.
> 
> > And what event does the restore need to be ordered with?
> 
> Not sure I follow you here.

You're suggesting that we should restore saved registers first so
pcie_wait_for_link_delay() works.  If the link activation depends on
something being restored and we don't enforce an ordering, the
activation might succeed or fail depending on whether it happens
before or after the restore.  So if there is a dependency, we should
make it explicit to avoid a race like that.

But I'm not saying we *shouldn't* do the restore before the wait; only
that any dependency should be explicit.  Even if there is no actual
dependency it probably makes sense to do the restore first so it can
overlap with the hardware link training, which may reduce the time
pcie_wait_for_link_delay() has to wait when we do call it, e.g.,

  |-----------------|          link activation
     |-----|                   restore state
           |--------|          pcie_wait_for_link_delay()

whereas if we do the restore after waiting for the link to come up, it
probably takes longer:

  |-----------------|          link activation
     |--------------|          pcie_wait_for_link_delay()
                    |-----|    restore state

I actually suspect there *is* a dependency -- we should respect the
Target Link Speed and and width so the link resumes in the same
configuration it was before suspend.  And I suspect that may require
an explicit retrain after restoring PCI_EXP_LNKCTL2.

Bjorn
