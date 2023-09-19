Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45097A6C14
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjISUJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISUJP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 16:09:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB89F
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 13:09:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA713C433CB;
        Tue, 19 Sep 2023 20:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695154149;
        bh=2jG3aeYBG58mFAFvURV5l54U7XKna1cBO6NGMzgfa5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c57PlCCRNGNdyQWUZA3o3JM/KdUH3obT7v99ouI7VYP/YkmyZmKMX12jmT3wjLXGK
         wKwdtDbDHpipM7HNXfjOLeBVae1BBeWQVhSl1e5a/IQN/7HABtpgnRR0v8ZoGGV8ks
         +2ZkRdWY8Znp2vntUjfATu9gz/+8WjmZjWZNa2gxdaTUYl2fO0fgU61vshFfVeT1LA
         kHUe6TlffRFylB5EY6rF558+E+PGNxRe3FhefIRDGoAsir3okikdGv3XITlm0jiGiX
         C36TsfAtwxW9rSAAfaYei6bRSJ31zFCLTeUxhp4uOjacYBz7N2bmINCdDVQWTlMWKY
         ALgETJbpaVKgw==
Date:   Tue, 19 Sep 2023 15:09:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Message-ID: <20230919200907.GA241545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hDm-B9zAMcf0aYXDjTaOnvgGNsaPYX=yc5kVy9YR1cdQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 08:32:22PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 19, 2023 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Sep 19, 2023 at 05:52:33PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
> > > > > On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > [snipped]
> > > > > > Hmm.  In some ways the VMD device acts as a Root Port, since it
> > > > > > originates a new hierarchy in a separate domain, but on the upstream
> > > > > > side, it's just a normal endpoint.
> > > > > >
> > > > > > How does AER for the new hierarchy work?  A device below the VMD can
> > > > > > generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> > > > > > assuming those messages would terminate at the VMD, and the VMD could
> > > > > > generate an AER interrupt just like a Root Port.  But that can't be
> > > > > > right because I don't think VMD would have the Root Error Command
> > > > > > register needed to manage that interrupt.
> > > > >
> > > > > VMD itself doesn't seem to manage AER, the rootport that "moved" from
> > > > > 0000 domain does:
> > > > > [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
> > > > > 10000:e1:00.0
> > > > > [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
> > > > > type=Physical Layer, (Receiver ID)
> > > > > [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
> > > > > status/mask=00000001/0000e000
> > > > > [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
> > > >
> > > > Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
> > > > that is logically below the VMD, e.g., (from
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=215027):
> > > >
> > > >   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
> > > >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
> > > >   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
> > > >   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
> > > >   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
> > > >   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
> > > >
> > > > So ERR_* messages from the e1:00.0 Samsung device would terminate at
> > > > the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
> > > > Error Command/Status/Error Source registers.
> > > >
> > > > > > But if VMD just passes those messages up to the Root Port, the source
> > > > > > of the messages (the Requester ID) won't make any sense because
> > > > > > they're in a hierarchy the Root Port doesn't know anything about.
> > > > >
> > > > > Not sure what's current status is but I think Nirmal's patch is valid
> > > > > for both our cases.
> > > >
> > > > So I think the question is whether that PNP0A08:00 _OSC applies to
> > > > domain 10000.  I think the answer is "no" because the platform doesn't
> > > > know about the existence of domain 10000, and it can't access config
> > > > space in that domain.
> > >
> > > Well, the VMD device itself is there in domain 0000, however, and sure
> > > enough, the platform firmware can access its config space.
> > >
> > > > E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
> > > > don't think it would make sense for that to mean the platform *also*
> > > > owned AER in domain 10000, because the platform doesn't know how to
> > > > configure AER or handle AER interrupts in that domain.
> > >
> > > I'm not sure about this.
> > >
> > > AFAICS, domain 10000 is not physically independent of domain 0000, so
> > > I'm not sure to what extent the above applies.
> >
> > Domain 10000 definitely isn't physically independent of domain 0000
> > since all TLPs to/from 10000 traverse the domain 0000 link to the VMD
> > at 0000:00:0e.0.
> >
> > The platform can access the VMD endpoint (0000:00:0e.0) config space.
> > But I don't think the platform can access config space of anything in
> > domain 10000, which in my mind makes it *logically* independent.
> >
> > IIUC, config access to anything below the VMD (e.g., domain 10000) is
> > done by the vmd driver itself using BAR 0 of the VMD device
> > (vmd_cfg_addr(), vmd_pci_read(), vmd_pci_write(), see [1]).
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/vmd.c?id=v6.5#n378
> 
> I know, but the platform firmware may not need to go through the VMD
> BAR in order to change the configuration of the devices in the "VMD
> segment".

I'm assuming that firmware can only access "VMD segment" config space
if it has its own VMD driver.  It sounds like there might be another
way that I don't know about?  Is there some way to do things via AML
and _REG?

> The question is whether or not the OS should attempt to control the
> _OSC features on the VMD segment if the firmware has not allowed it to
> control those features on the primary "parent" segment and the way the
> config space on the VMD segment is accessed may not be entirely
> relevant in that respect.

All these features are managed via config space.  I don't know how to
interpret "firmware has no way to read the AER Capability of a Root
Port in the VMD segment, but firmware still owns AER".  That sounds to
me like "nobody can do anything with AER".

> Note that VMD may want to impose additional restrictions on the OS
> control of those features, but it is not clear to me whether or not it
> should attempt to override the refusal to grant control of them on the
> primary host bridge.

In practical terms, I think you're saying vmd_copy_host_bridge_flags()
could CLEAR vmd_bridge->native_* flags (i.e., restrict the OS from
using features even if the platform has granted control of them), but
it's not clear that it should SET them (i.e., override platform's
refusal to grant control)?  Is that right?

I've been assuming config space access is the critical piece, but it
sounds like maybe it's not?

Bjorn
