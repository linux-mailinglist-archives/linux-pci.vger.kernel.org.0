Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38711271FE
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLTAEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 19:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfLTAEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Dec 2019 19:04:01 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C760222C2;
        Fri, 20 Dec 2019 00:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576800240;
        bh=sWq+9KSTwARofQnWsAgQYWAF/MTYTslzXC2YUL9YOUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=y+50dcG+enUsbey/BuOFRBNPTJ0WXZMkKA4w3HQR8Zq9UY4xlF9eE9X9r3HB83JsG
         YXU+8e9uE7GM/4pbXGCwANX9kLhlNTxzRvHiO+5KKzDk1ZDS/LL4uxhHBgplVK70tr
         kxQ4OhrPB7NEa333uI4sMwoH07mSCW/ACcbQ6EYc=
Date:   Thu, 19 Dec 2019 18:03:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Message-ID: <20191220000358.GA126443@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043840E2DE9B81AC8797F63A80530@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 18, 2019 at 12:54:25AM +0000, Nicholas Johnson wrote:
> On Tue, Dec 17, 2019 at 09:12:48AM -0600, Bjorn Helgaas wrote:
> > On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> > > Hi all,
> > > 
> > > Since last time:
> > > 	Reverse Christmas tree for a couple of variables
> > > 
> > > 	Changed while to whilst (sounds more formal, and so that 
> > > 	grepping for "while" only brings up code)
> > > 
> > > 	Made sure they still apply to latest Linux v5.5-rc1
> > > 
> > > Kind regards,
> > > Nicholas
> > > 
> > > Nicholas Johnson (4):
> > >   PCI: Consider alignment of hot-added bridges when distributing
> > >     available resources
> > >   PCI: In extend_bridge_window() change available to new_size
> > >   PCI: Change extend_bridge_window() to set resource size directly
> > >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> > 
> > I have tentatively applied these to pci/resource for v5.6, but I need
> > some kind of high-level description for why we want these changes.
> I could not find these in linux-next (whereas it was almost immediate 
> last time), so this must be why.
> 
> > The commit logs describe what the code does, and that's good, but we
> > really need a little more of the *why* and what the user-visible
> > benefit is.  I know some of this was in earlier postings, but it seems
> > to have gotten lost along the way.
>
> Is this explanation going into the commit notes, or is this just to get 
> it past reviewers, Greg K-H and Linus Torvalds?

This is for the commit log of the merge commit, i.e., it should answer
the question of "why should we merge this branch?"  Typically this is
short, e.g., here's the merge commit for the pci/resource branch that
was merged for v5.5:

  commit 774800cb099f ("Merge branch 'pci/resource'")
  Author: Bjorn Helgaas <bhelgaas@google.com>
  Date:   Thu Nov 28 08:54:36 2019 -0600

    Merge branch 'pci/resource'

      - Protect pci_reassign_bridge_resources() against concurrent
        addition/removal (Benjamin Herrenschmidt)

      - Fix bridge dma_ranges resource list cleanup (Rob Herring)

      - Add PCI_STD_NUM_BARS for the number of standard BARs (Denis Efremov)

      - Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters to control the
        MMIO and prefetchable MMIO window sizes of hotplug bridges
        independently (Nicholas Johnson)

      - Fix MMIO/MMIO_PREF window assignment that assigned more space than
        desired (Nicholas Johnson)

      - Only enforce bus numbers from bridge EA if the bridge has EA devices
        downstream (Subbaraya Sundeep)

    * pci/resource:
      PCI: Do not use bus number zero from EA capability
      PCI: Avoid double hpmemsize MMIO window assignment
      PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters
      PCI: Add PCI_STD_NUM_BARS for the number of standard BARs
      PCI: Fix missing bridge dma_ranges resource list cleanup
      PCI: Protect pci_reassign_bridge_resources() against concurrent addition/removal

The logs for individual commits are obviously longer but should answer
the same question in more detail.

Basically, I'm not comfortable asking Linus to pull material unless I
can explain what the benefit is.  I'm still struggling to articulate
the benefit in this case.  I think it makes hotplug work better in
some cases where we need more alignment than we currently have, but
that's pretty sketchy.

Bjorn
