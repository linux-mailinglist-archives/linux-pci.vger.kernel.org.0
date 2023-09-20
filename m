Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835847A789B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjITKIr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 20 Sep 2023 06:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjITKIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Sep 2023 06:08:47 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66124AD
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 03:08:40 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5711d5dac14so1628892eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Sep 2023 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695204519; x=1695809319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFk8cOkBtXf6GdFpZQjU8xRcQd6OHXlF44v8bsWvVPE=;
        b=PzSQASTDOv2Z4GsY6cxMT3FCl3SB7PyLB2l/gplsqx7+vTjkwvmBqYbgbfpq/OWuog
         6zc/sgfY56lXMu1nSOkn4vH+Lp97UocFXZ3jau/X6/LOVN3PyAenjrcDsoZu/XoIr4lT
         uoVyBGqfW4bew5MZrj2/836iXypSmp5F692Y+DLmCBPO2zmuO3xu2WhQ2Re0shdXzd4x
         zj7gt5BXnY51dv6/OKErhJP9P0wNslAwHkbZ+16wg6qsL3hKTO2zxl5JmeOjJcNwA/zX
         WBvsksFiQL0N1CYaMV+Ro9UiW5EQ9/96+MfX+rTbaai5/l/lKNvLzBKoQX4qaF8aFU+i
         2qxA==
X-Gm-Message-State: AOJu0YzHDX+FouMD5cH2PhpRh47SSGQ+FldaAx1ec/QMvSXe4eE3q/cd
        y3fl7XYMpP7w82GGY6CQ/8b9ffFWjTULj2rKX/w=
X-Google-Smtp-Source: AGHT+IGT7rC0nlFOD40x/HoWmFTms/EdFEaMekrjGToKAsZeT7dj1Yi45EZMxlbK509YfdSWVorlkTTCef6vxkL5C4M=
X-Received: by 2002:a4a:d859:0:b0:57b:3b64:7ea5 with SMTP id
 g25-20020a4ad859000000b0057b3b647ea5mr608856oov.1.1695204519566; Wed, 20 Sep
 2023 03:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hDm-B9zAMcf0aYXDjTaOnvgGNsaPYX=yc5kVy9YR1cdQ@mail.gmail.com>
 <20230919200907.GA241545@bhelgaas>
In-Reply-To: <20230919200907.GA241545@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 12:08:28 +0200
Message-ID: <CAJZ5v0jjj+0sasfMd5Vd9oPV6uD2nP3Zo34h0fBR02GcWMYJ_Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
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

On Tue, Sep 19, 2023 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 19, 2023 at 08:32:22PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 19, 2023 at 7:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Sep 19, 2023 at 05:52:33PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Sep 19, 2023 at 4:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Tue, Sep 19, 2023 at 11:31:57AM +0800, Kai-Heng Feng wrote:
> > > > > > On Wed, Sep 13, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > [snipped]
> > > > > > > Hmm.  In some ways the VMD device acts as a Root Port, since it
> > > > > > > originates a new hierarchy in a separate domain, but on the upstream
> > > > > > > side, it's just a normal endpoint.
> > > > > > >
> > > > > > > How does AER for the new hierarchy work?  A device below the VMD can
> > > > > > > generate ERR_COR/ERR_NONFATAL/ERR_FATAL messages.  I guess I was
> > > > > > > assuming those messages would terminate at the VMD, and the VMD could
> > > > > > > generate an AER interrupt just like a Root Port.  But that can't be
> > > > > > > right because I don't think VMD would have the Root Error Command
> > > > > > > register needed to manage that interrupt.
> > > > > >
> > > > > > VMD itself doesn't seem to manage AER, the rootport that "moved" from
> > > > > > 0000 domain does:
> > > > > > [ 2113.507345] pcieport 10000:e0:06.0: AER: Corrected error received:
> > > > > > 10000:e1:00.0
> > > > > > [ 2113.507380] nvme 10000:e1:00.0: PCIe Bus Error: severity=Corrected,
> > > > > > type=Physical Layer, (Receiver ID)
> > > > > > [ 2113.507389] nvme 10000:e1:00.0:   device [144d:a80a] error
> > > > > > status/mask=00000001/0000e000
> > > > > > [ 2113.507398] nvme 10000:e1:00.0:    [ 0] RxErr                  (First)
> > > > >
> > > > > Oh, I forgot how VMD works.  It sounds like there *is* a Root Port
> > > > > that is logically below the VMD, e.g., (from
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=215027):
> > > > >
> > > > >   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
> > > > >   acpi PNP0A08:00: _OSC: platform does not support [AER]
> > > > >   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR]
> > > > >   pci  0000:00:0e.0: [8086:467f] type 00         # VMD
> > > > >   vmd  0000:00:0e.0: PCI host bridge to bus 10000:e0
> > > > >   pci 10000:e0:06.0: [8086:464d] type 01         # Root Port to [bus e1]
> > > > >   pci 10000:e1:00.0: [144d:a80a] type 00         # Samsung NVMe
> > > > >
> > > > > So ERR_* messages from the e1:00.0 Samsung device would terminate at
> > > > > the e0:06.0 Root Port.  That Root Port has an AER Capability with Root
> > > > > Error Command/Status/Error Source registers.
> > > > >
> > > > > > > But if VMD just passes those messages up to the Root Port, the source
> > > > > > > of the messages (the Requester ID) won't make any sense because
> > > > > > > they're in a hierarchy the Root Port doesn't know anything about.
> > > > > >
> > > > > > Not sure what's current status is but I think Nirmal's patch is valid
> > > > > > for both our cases.
> > > > >
> > > > > So I think the question is whether that PNP0A08:00 _OSC applies to
> > > > > domain 10000.  I think the answer is "no" because the platform doesn't
> > > > > know about the existence of domain 10000, and it can't access config
> > > > > space in that domain.
> > > >
> > > > Well, the VMD device itself is there in domain 0000, however, and sure
> > > > enough, the platform firmware can access its config space.
> > > >
> > > > > E.g., if _OSC negotiated that the platform owned AER in domain 0000, I
> > > > > don't think it would make sense for that to mean the platform *also*
> > > > > owned AER in domain 10000, because the platform doesn't know how to
> > > > > configure AER or handle AER interrupts in that domain.
> > > >
> > > > I'm not sure about this.
> > > >
> > > > AFAICS, domain 10000 is not physically independent of domain 0000, so
> > > > I'm not sure to what extent the above applies.
> > >
> > > Domain 10000 definitely isn't physically independent of domain 0000
> > > since all TLPs to/from 10000 traverse the domain 0000 link to the VMD
> > > at 0000:00:0e.0.
> > >
> > > The platform can access the VMD endpoint (0000:00:0e.0) config space.
> > > But I don't think the platform can access config space of anything in
> > > domain 10000, which in my mind makes it *logically* independent.
> > >
> > > IIUC, config access to anything below the VMD (e.g., domain 10000) is
> > > done by the vmd driver itself using BAR 0 of the VMD device
> > > (vmd_cfg_addr(), vmd_pci_read(), vmd_pci_write(), see [1]).
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/vmd.c?id=v6.5#n378
> >
> > I know, but the platform firmware may not need to go through the VMD
> > BAR in order to change the configuration of the devices in the "VMD
> > segment".
>
> I'm assuming that firmware can only access "VMD segment" config space
> if it has its own VMD driver.  It sounds like there might be another
> way that I don't know about?  Is there some way to do things via AML
> and _REG?

I would need to ask the VMD people about this TBH.

> > The question is whether or not the OS should attempt to control the
> > _OSC features on the VMD segment if the firmware has not allowed it to
> > control those features on the primary "parent" segment and the way the
> > config space on the VMD segment is accessed may not be entirely
> > relevant in that respect.
>
> All these features are managed via config space.

As far as the OS is concerned.

> I don't know how to
> interpret "firmware has no way to read the AER Capability of a Root
> Port in the VMD segment, but firmware still owns AER".  That sounds to
> me like "nobody can do anything with AER".

This assumes that the config space access method used by Linux is the
only one available, but I'm not sure that this is the case.  It would
be nice if someone could confirm or deny this.  Nirmal?

Also, I know for a fact that the firmware running on certain tiny
cores included in the SoC may talk to the PCI devices on it via I2C or
similar (at least on servers).  This communication channel can be used
to control the features in question AFAICS.

> > Note that VMD may want to impose additional restrictions on the OS
> > control of those features, but it is not clear to me whether or not it
> > should attempt to override the refusal to grant control of them on the
> > primary host bridge.
>
> In practical terms, I think you're saying vmd_copy_host_bridge_flags()
> could CLEAR vmd_bridge->native_* flags (i.e., restrict the OS from
> using features even if the platform has granted control of them), but
> it's not clear that it should SET them (i.e., override platform's
> refusal to grant control)?  Is that right?

Yes, it is.

> I've been assuming config space access is the critical piece, but it
> sounds like maybe it's not?

It may not be in principle, so it would be good to have more
information regarding this.  I would like the VMD people to tell us
what exactly the expectations are.
