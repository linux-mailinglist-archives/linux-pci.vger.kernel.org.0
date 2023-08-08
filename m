Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DD774BF1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHHVAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjHHVAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D12132;
        Tue,  8 Aug 2023 13:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB2862CE4;
        Tue,  8 Aug 2023 20:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CEAC433C8;
        Tue,  8 Aug 2023 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691528283;
        bh=mYemYrP7GxRXt1G2n3VYbCmt+/S/G4zndMYQnQVP8Ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nsogyuLBgUkJ0Yqi3ufuq76tQCvCd4aRz5PRxcLx2mNmnAOFuJuV6lSDO2jUuJCXf
         qA/Kcgza+wEAauOSKITfIC9IffWs4bHG6n8g1HDn1pkrNf1TCypMqJK00ILaPLlc2g
         7O3kgGQxEluLXn7jOxSiy/L/5UlpBX0wtAaIOYgZWfteN5bzStcFIvytflBN6k1WkY
         +VGLRGkq0kv9Opy5nkJh/rLKrqPPbhDeA/Cvap4l37Trhp6G3nV7MbDo8s/OQGdGZt
         G2pVOodYUJ5l/J1sMdR7wBc53hgcmhY7Tk/IM8csLCNeI/0/3/FDwSTsvVJDxYdKTR
         GsLRWCcjTs1QA==
Date:   Tue, 8 Aug 2023 15:58:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: acpiphp: Log more slot and notification details
Message-ID: <20230808205800.GA332785@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jc5dn+6WtH6O30EeJfGDLewiLaAY9YJEAO6d_n+Uv7ig@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 09:39:22PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 8, 2023 at 9:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > When registering an acpiphp slot, log the slot name in the same style as
> > pciehp and include the PCI bus/device and whether a device is present or
> > the slot is empty.
> >
> > When handling an ACPI notification, log the PCI bus/device and notification
> > type.
> >
> > Sample dmesg log diff:
> >
> >     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >   - acpiphp: Slot [3] registered
> >   - acpiphp: Slot [4] registered
> >     PCI host bridge to bus 0000:00
> >     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> >     <ACPI Device Check notification>
> >     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> >
> >     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >   + acpiphp: pci 0000:00:03 Slot(3) registered (enabled)
> >   + acpiphp: pci 0000:00:04 Slot(4) registered (empty)
> >     PCI host bridge to bus 0000:00
> >     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> >     <ACPI Device Check notification>
> >   + acpiphp: pci 0000:00:04 Slot(4) Device Check
> >     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> > ...

> > @@ -793,6 +804,14 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> >
> >         pci_lock_rescan_remove();
> >
> > +       pr_info("pci %04x:%02x:%02x Slot(%s) %s\n",
> > +               pci_domain_nr(slot->bus), slot->bus->number,
> > +               slot->device, slot_name(slot->slot),
> > +               type == ACPI_NOTIFY_BUS_CHECK ? "Bus Check" :
> > +               type == ACPI_NOTIFY_DEVICE_CHECK ? "Device Check" :
> > +               type == ACPI_NOTIFY_EJECT_REQUEST ? "Eject Request" :
> > +               "Notification");
> 
> pr_debug() perhaps?
> 
> On systems that don't have any hotplug problems these messages will
> just be filling the kernel log unnecessarily.

If these notifications are really common, pr_debug() sounds like the
right thing.  I assumed that they would not be common, e.g., they
would happen for user-time things like dock/undock, plug/unplug,
suspend/resume, etc.

In pciehp, we use _info for attention button presses, presence detect
changes, link up/down, and I assumed the ACPI notify events would
roughly correspond to those.  No?

Bjorn
