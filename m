Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69161188B9A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCQRHB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 13:07:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgCQRHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 13:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2BoGGEdNQTv247lOoGQWSuvht20oQxr110Feea+TlWs=; b=q/CW7wqCHqnFnpmJV+W5tVWP4e
        QCWw6HRa29pZio3fs1qQwZn6DwftNjCAEoEpckv8LNzYmwsLLvL7Z10FJuhVCKvuuu20J9yReNFGr
        be4yOdRpocDxxoA6qxamS0Pk5E+pf841lrJN+vrkzFyseQOxWl5Ch0VD6CJ8B5gTMVj3re1ocF4fT
        R3qw+ty5i7fofRDHRmqBGJ6GrtH+NLeOeZNn8v0UPQ3zXfEqAvOINV0CuQg+adyZiFuYN5TUWi3yA
        UlQfJQlMAXu/BjFtbUwesx8L21ixKlHym8Vc6BRHBf1Xnq+T1gTW5FhNUL9aXxEIURAbTtYWmbpz4
        J3Dhw+eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFg6-00010h-7t; Tue, 17 Mar 2020 17:06:54 +0000
Date:   Tue, 17 Mar 2020 10:06:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     bjorn@helgaas.com
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v17 06/12] Documentation: PCI: Remove reset_link
 references
Message-ID: <20200317170654.GA23125@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a46938d227f6a11c010943800450a10aac39b7d3.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200317144203.GE23471@infradead.org>
 <ebb79d02-53f5-cc23-0b38-72a351a05097@linux.intel.com>
 <20200317150735.GA653@infradead.org>
 <CABhMZUUn2RJWRTGc7xa1XcV3ozBOV24jjwhf6k08sP7XC1ETkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUUn2RJWRTGc7xa1XcV3ozBOV24jjwhf6k08sP7XC1ETkw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 17, 2020 at 11:03:36AM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 17, 2020 at 10:09 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 17, 2020 at 08:05:50AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > >
> > > >
> > > > This should be folded into the patch removing the method.
> > > This is also folded in the mentioned patch.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=review/edr&id=7a18dc6506f108db3dc40f5cd779bc15270c4183
> >
> > I can't find that series anywhere on the list.  What did I miss?
> 
> We've still been discussing other issues (access to AER registers,
> synchronization between EDR and hotplug, etc) in other parts of this
> thread.  The git branch Sathy pointed to above is my local branch.
> I'll send it to the list before putting it into -next, but I wanted to
> make progress on some of these other issues first.

A few nitpicks:

PCI/ERR: Update error status after reset_link():

 - there are two "if (state == pci_channel_io_frozen)"
   right after each other now, merging them would make the code a little
   easier to read.

PCI/DPC: Move DPC data into struct pci_dev:

 - dpc_rp_extensions probable should be a "bool : 1"

PCI/ERR: Remove service dependency in pcie_do_recovery():

 - as mentioned to Kuppuswamy the reset_cb is never NULL, and thus
   a lot of dead code in reset_link can be removed.  Also reset_link
   should be merged into pcie_do_recovery.  That would also enable
   to call the argument reset_link, which might be a bit more
   descriptive than reset_cb.

PCI/DPC: Cache DPC capabilities in pci_init_capabilities():

 - I think the pci_dpc_init could be cleaned up a bit to:

	...
	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
		return;
	pdev->dpc_rp_extensions = true;
	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
	...
