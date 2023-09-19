Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9227A6ABD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 20:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjISScl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 19 Sep 2023 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISSck (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 14:32:40 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978297
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 11:32:34 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5733d11894dso979474eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 11:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695148353; x=1695753153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrgbXkVRXj9thX7Tkf7Heh2HSLmbCp5DxrBfFbH29rQ=;
        b=gv+XNCNwzQTaWBqyQii35RfPAS315jMqxIazZomfq6cw0Y9vW6tgELzhOiH7zqib3w
         XPRCgclIjn4B1uE2uEoUnd58PikcG2E3u67ctYCjNbnyQRy7kJ0w2i9RtDZ7v9bpj3FP
         MiN9jYU+1Pa13lG4/2R8btV6ZULitY57b3zY4MYa1hyUi4cPdLtIV5yRU25Pu8tHAW5K
         RloYXJyGbitbXd04I22asXZiyuqTTNeWQCVOw4wfVB+NhSMYBJB3ogoqNFO+uWQFXJDE
         d+2WkK8zvESp6xBU4UgXCQYKLNOJIpoaUFpD9Il33Pu2TnJwL3zPPyXHrYqOXuJstnDS
         8w0A==
X-Gm-Message-State: AOJu0YxrUpA/ENe+2+On31oTiVzEBg0zcQW/z7CyxBpSdgA03ZoAZ9Ib
        wy/QKO0cS0jJ7DjuDBSaioi5eHm5aZhNTt9WUyI=
X-Google-Smtp-Source: AGHT+IEg6QEPgkQB1QHY7+py462eGRwd4jXmP+u8mE991T5zQePBWIyf8o7qVxn18gstPqUjGh06ID/m8MjTJPASM6s=
X-Received: by 2002:a4a:2a4e:0:b0:573:3a3b:594b with SMTP id
 x14-20020a4a2a4e000000b005733a3b594bmr373995oox.1.1695148353341; Tue, 19 Sep
 2023 11:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jCrYA8UX8OXLgv1NLZGRevYHdOBu8FN0i+HHi8+XDuxw@mail.gmail.com>
 <20230919173318.GA235394@bhelgaas>
In-Reply-To: <20230919173318.GA235394@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Sep 2023 20:32:22 +0200
Message-ID: <CAJZ5v0hDm-B9zAMcf0aYXDjTaOnvgGNsaPYX=yc5kVy9YR1cdQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 19, 2023 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 05:52:33PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
> > > > On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > [snipped]
> > > > > Hmm.  In some ways the VMD device acts as a Root Port, since it
> > > > > originates a new hierarchy in a separate domain, but on the upstream
> > > > > side, it's just a normal endpoint.
> > > > >
> > > > > How does AER for the new hierarchy work?  A device below the VMD can
> > > > > generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> > > > > assuming those messages would terminate at the VMD, and the VMD could
> > > > > generate an AER interrupt just like a Root Port.  But that can't be
> > > > > right because I don't think VMD would have the Root Error Command
> > > > > register needed to manage that interrupt.
> > > >
> > > > VMD itself doesn't seem to manage AER, the rootport that "moved" from
> > > > 0000 domain does:
> > > > [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
> > > > 10000:e1:00.0
> > > > [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
> > > > type=Physical Layer, (Receiver ID)
> > > > [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
> > > > status/mask=00000001/0000e000
> > > > [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
> > >
> > > Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
> > > that is logically below the VMD, e.g., (from
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215027):
> > >
> > >   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
> > >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> > >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
> > >   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
> > >   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
> > >   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
> > >   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
> > >
> > > So ERR_* messages from the e1:00.0 Samsung device would terminate at
> > > the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
> > > Error Command/Status/Error Source registers.
> > >
> > > > > But if VMD just passes those messages up to the Root Port, the source
> > > > > of the messages (the Requester ID) won't make any sense because
> > > > > they're in a hierarchy the Root Port doesn't know anything about.
> > > >
> > > > Not sure what's current status is but I think Nirmal's patch is valid
> > > > for both our cases.
> > >
> > > So I think the question is whether that PNP0A08:00 _OSC applies to
> > > domain 10000.  I think the answer is "no" because the platform doesn't
> > > know about the existence of domain 10000, and it can't access config
> > > space in that domain.
> >
> > Well, the VMD device itself is there in domain 0000, however, and sure
> > enough, the platform firmware can access its config space.
> >
> > > E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
> > > don't think it would make sense for that to mean the platform *also*
> > > owned AER in domain 10000, because the platform doesn't know how to
> > > configure AER or handle AER interrupts in that domain.
> >
> > I'm not sure about this.
> >
> > AFAICS, domain 10000 is not physically independent of domain 0000, so
> > I'm not sure to what extent the above applies.
>
> Domain 10000 definitely isn't physically independent of domain 0000
> since all TLPs to/from 10000 traverse the domain 0000 link to the VMD
> at 0000:00:0e.0.
>
> The platform can access the VMD endpoint (0000:00:0e.0) config space.
> But I don't think the platform can access config space of anything in
> domain 10000, which in my mind makes it *logically* independent.
>
> IIUC, config access to anything below the VMD (e.g., domain 10000) is
> done by the vmd driver itself using BAR 0 of the VMD device
> (vmd_cfg_addr(), vmd_pci_read(), vmd_pci_write(), see [1]).
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/vmd.c?id=v6.5#n378

I know, but the platform firmware may not need to go through the VMD
BAR in order to change the configuration of the devices in the "VMD
segment".

The question is whether or not the OS should attempt to control the
_OSC features on the VMD segment if the firmware has not allowed it to
control those features on the primary "parent" segment and the way the
config space on the VMD segment is accessed may not be entirely
relevant in that respect.

Note that VMD may want to impose additional restrictions on the OS
control of those features, but it is not clear to me whether or not it
should attempt to override the refusal to grant control of them on the
primary host bridge.
