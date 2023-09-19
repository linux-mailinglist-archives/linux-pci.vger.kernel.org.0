Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919337A69A7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjISRd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjISRd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 13:33:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD7A6
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 10:33:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDEC433CC;
        Tue, 19 Sep 2023 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695144800;
        bh=4rIDMOQNkbTuCY0px/4/EP5Tl9VgecKTa0bgp+PFtDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V/Oa7mMBCkPkZY4zjU+Aa+70r3qfjNuT9qof/KOJi1L7VHm+8OKG8eb8IJ3bUFTOy
         ITxT8jsG3LIJI0PfHsUO1NeNsU0vRLhElfDqPPbuFZjlX8X2jP5+VS1JdF7XCYTRqJ
         x9XhxeUZOAuIOJ4FIHqak8YY/tY4sQP5boOS+iSoGPBpMVOIsoIO2m2UXUg6/ShFo9
         YCGqjLZwXdBzEIbZq549laf+jO18r+FrlhbGCgwNgPLicaUXMZcr11gg0geAQzcPT3
         bzADYAVghAXetZoM25M0VZne1jo7dbIruBgptoGv7ztuyAdWUy54j68JnYrTMtKeJ9
         Mq161pmdIA33A==
Date:   Tue, 19 Sep 2023 12:33:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <20230919173318.GA235394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jCrYA8UX8OXLgv1NLZGRevYHdOBu8FN0i+HHi8+XDuxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 05:52:33PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
> > > On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > [snipped]
> > > > Hmm.  In some ways the VMD device acts as a Root Port, since it
> > > > originates a new hierarchy in a separate domain, but on the upstream
> > > > side, it's just a normal endpoint.
> > > >
> > > > How does AER for the new hierarchy work?  A device below the VMD can
> > > > generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> > > > assuming those messages would terminate at the VMD, and the VMD could
> > > > generate an AER interrupt just like a Root Port.  But that can't be
> > > > right because I don't think VMD would have the Root Error Command
> > > > register needed to manage that interrupt.
> > >
> > > VMD itself doesn't seem to manage AER, the rootport that "moved" from
> > > 0000 domain does:
> > > [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
> > > 10000:e1:00.0
> > > [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
> > > type=Physical Layer, (Receiver ID)
> > > [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
> > > status/mask=00000001/0000e000
> > > [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
> >
> > Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
> > that is logically below the VMD, e.g., (from
> > https://bugzilla.kernel.org/show_bug.cgi?id=215027):
> >
> >   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
> >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
> >   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
> >   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
> >   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
> >   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
> >
> > So ERR_* messages from the e1:00.0 Samsung device would terminate at
> > the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
> > Error Command/Status/Error Source registers.
> >
> > > > But if VMD just passes those messages up to the Root Port, the source
> > > > of the messages (the Requester ID) won't make any sense because
> > > > they're in a hierarchy the Root Port doesn't know anything about.
> > >
> > > Not sure what's current status is but I think Nirmal's patch is valid
> > > for both our cases.
> >
> > So I think the question is whether that PNP0A08:00 _OSC applies to
> > domain 10000.  I think the answer is "no" because the platform doesn't
> > know about the existence of domain 10000, and it can't access config
> > space in that domain.
> 
> Well, the VMD device itself is there in domain 0000, however, and sure
> enough, the platform firmware can access its config space.
> 
> > E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
> > don't think it would make sense for that to mean the platform *also*
> > owned AER in domain 10000, because the platform doesn't know how to
> > configure AER or handle AER interrupts in that domain.
> 
> I'm not sure about this.
> 
> AFAICS, domain 10000 is not physically independent of domain 0000, so
> I'm not sure to what extent the above applies.

Domain 10000 definitely isn't physically independent of domain 0000
since all TLPs to/from 10000 traverse the domain 0000 link to the VMD
at 0000:00:0e.0.

The platform can access the VMD endpoint (0000:00:0e.0) config space.
But I don't think the platform can access config space of anything in
domain 10000, which in my mind makes it *logically* independent.

IIUC, config access to anything below the VMD (e.g., domain 10000) is
done by the vmd driver itself using BAR 0 of the VMD device
(vmd_cfg_addr(), vmd_pci_read(), vmd_pci_write(), see [1]).

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/vmd.c?id=v6.5#n378
