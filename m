Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1C774D17
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHHVbx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 8 Aug 2023 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHHVbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:31:52 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562A91;
        Tue,  8 Aug 2023 14:31:52 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6bb1133b063so980114a34.1;
        Tue, 08 Aug 2023 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691530311; x=1692135111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dar5Gf1UmWSsQg1cGFlHubc+7wJ03BPupNvzSWN3N8E=;
        b=AEUTKNCJEJgm5HPDFVmLUeJeK4kWnCDKMU/kmaOU8XNcahqUJePV6RjlAUymQ3NLwC
         oUSQ7jV+AWr5p4WQNxXjgiROHKINIevaKNe8L2/qPvP/x8yWcMUf2YI/e0Xz6fbwvjE+
         gODCl8PPfVJnON4YocuKo2zlhuM5odZqD5XOaqc63wFT8ltkNqAbnNUqbcKZo0pdAxCV
         kWuXZE5/UXs/taMpelYAoJVWemnPSoObklV7NYGFpYmTcHjQjMJh6OeA71entQEkjGos
         nudaYP+ctNGzAgthPjTuN+QHiOlihBIBMy6fTPgpj8FgdvRl0k0YIVmIUZq6J24Zl4CU
         ZjnQ==
X-Gm-Message-State: AOJu0Yxn6HSLtvHHBuRg+CqjymWCg7Gm9jUUDPPc+W86WmtbpF08M+rB
        QL/CC1aX49CvaZqORytH/CQu6Y4M3mIgkhtZifA=
X-Google-Smtp-Source: AGHT+IEkRkhKAJcwy7Kiik7KrKGEdSp2I18CQ+jsoYeeevPtkp6gtO3VhqUn+lyy0exbEBZwmVe+tJVq1hpGx0aCR7o=
X-Received: by 2002:a4a:2c42:0:b0:560:b01a:653d with SMTP id
 o63-20020a4a2c42000000b00560b01a653dmr1006343ooo.0.1691530311356; Tue, 08 Aug
 2023 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jc5dn+6WtH6O30EeJfGDLewiLaAY9YJEAO6d_n+Uv7ig@mail.gmail.com>
 <20230808205800.GA332785@bhelgaas>
In-Reply-To: <20230808205800.GA332785@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Aug 2023 23:31:40 +0200
Message-ID: <CAJZ5v0gFQsidEJyfN8oj+=gXjw7kwJwewmAAAEQkeO0vDnTusg@mail.gmail.com>
Subject: Re: [PATCH] PCI: acpiphp: Log more slot and notification details
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Tue, Aug 8, 2023 at 10:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 08, 2023 at 09:39:22PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 8, 2023 at 9:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > When registering an acpiphp slot, log the slot name in the same style as
> > > pciehp and include the PCI bus/device and whether a device is present or
> > > the slot is empty.
> > >
> > > When handling an ACPI notification, log the PCI bus/device and notification
> > > type.
> > >
> > > Sample dmesg log diff:
> > >
> > >     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > >   - acpiphp: Slot [3] registered
> > >   - acpiphp: Slot [4] registered
> > >     PCI host bridge to bus 0000:00
> > >     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> > >     <ACPI Device Check notification>
> > >     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> > >
> > >     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > >   + acpiphp: pci 0000:00:03 Slot(3) registered (enabled)
> > >   + acpiphp: pci 0000:00:04 Slot(4) registered (empty)
> > >     PCI host bridge to bus 0000:00
> > >     pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
> > >     <ACPI Device Check notification>
> > >   + acpiphp: pci 0000:00:04 Slot(4) Device Check
> > >     pci 0000:00:04.0: [8086:100e] type 00 class 0x020000
> > > ...
>
> > > @@ -793,6 +804,14 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> > >
> > >         pci_lock_rescan_remove();
> > >
> > > +       pr_info("pci %04x:%02x:%02x Slot(%s) %s\n",
> > > +               pci_domain_nr(slot->bus), slot->bus->number,
> > > +               slot->device, slot_name(slot->slot),
> > > +               type == ACPI_NOTIFY_BUS_CHECK ? "Bus Check" :
> > > +               type == ACPI_NOTIFY_DEVICE_CHECK ? "Device Check" :
> > > +               type == ACPI_NOTIFY_EJECT_REQUEST ? "Eject Request" :
> > > +               "Notification");
> >
> > pr_debug() perhaps?
> >
> > On systems that don't have any hotplug problems these messages will
> > just be filling the kernel log unnecessarily.
>
> If these notifications are really common, pr_debug() sounds like the
> right thing.  I assumed that they would not be common, e.g., they
> would happen for user-time things like dock/undock, plug/unplug,
> suspend/resume, etc.
>
> In pciehp, we use _info for attention button presses, presence detect
> changes, link up/down, and I assumed the ACPI notify events would
> roughly correspond to those.  No?

Depending on how often the system gets suspended and resumed, they may
end up in the log quite often and if there are no problems related to
them, they are just noise.

IMHO in that case the users are taught to ignore stuff that lands in
the log which is not fantastic.
