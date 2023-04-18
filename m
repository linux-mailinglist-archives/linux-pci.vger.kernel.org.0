Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4E6E6865
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjDRPia convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 18 Apr 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 11:38:29 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CACD8A7C;
        Tue, 18 Apr 2023 08:38:28 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94a342f4c8eso123033766b.0;
        Tue, 18 Apr 2023 08:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832306; x=1684424306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX5JtbWnAvg+crNo/UlGoA1FN4ablS2htBjudS2jtMo=;
        b=GDUvhDaHPSnMxziI3jNN156QyI3HNTNgboUKhtMCog4kI5IUbhm+XNkkTrZO/EhtV5
         tklNdK1hn/KUvQ01pj2OrTq18CQeTWfxFq84eHx9Ap6TK262xiJhm2V/dPlsIHhTRBEw
         UXp2BnGXK/2IVsWKT94PpAJtwqE6kwZhFgWMgNLs2tttnyjCJZgAoZWT1EBKfqB5lpza
         EPqLnLnXzPoe5Q13AJJANNNR5eA5KF/V77tsa/IJoEbleCnthr/qpsCaNX0yPy0PmGdK
         k30cMz7u/aIB27obmn+90j4Tguo4yYKltt7IUQx/uDKCz7hXYkSGbawBUEEjvSWt8TvF
         CfJA==
X-Gm-Message-State: AAQBX9er/ZdHYM1jZ2SwMqA3+gQWIiP9i6TAI2S1Mhcg+wJWH4pAkOH6
        qJLo66TIXrpz5sfSpTJh4WGGRSkPraLhtR4W3uI=
X-Google-Smtp-Source: AKy350bOR+SkKVHFACawhYxJyGdkhcr5ebtHYNhLwYmkmp/x3f4p9QSi7Bor8nUNJ+sPa7CYzQ1UqhTQTK7VhoVK4GM=
X-Received: by 2002:a17:906:7a45:b0:94e:9235:d77e with SMTP id
 i5-20020a1709067a4500b0094e9235d77emr10972251ejo.3.1681832306558; Tue, 18 Apr
 2023 08:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230418085030.2154918-1-imammedo@redhat.com> <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
 <20230418161702.0945fc67@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230418161702.0945fc67@imammedo.users.ipa.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 17:38:15 +0200
Message-ID: <CAJZ5v0gWKwOiACmK9=ru5W15Kydv6JqKJ8d4ngzKC7jqAjjcpQ@mail.gmail.com>
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if necessary
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, mst@redhat.com, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 4:17 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue, 18 Apr 2023 14:55:29 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Apr 18, 2023 at 10:50 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > When using ACPI PCI hotplug, hotplugging a device with
> > > large BARs may fail if bridge windows programmed by
> > > firmware are not large enough.
> > >
> > > Reproducer:
> > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> > >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> > >       disk_image
> > >
> > >  wait till linux guest boots, then hotplug device
> > >    (qemu) device_add qxl,bus=rp1
> > >
> > >  hotplug on guest side fails with:
> > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > >    Unable to create vram_mapping
> > >    qxl: probe of 0000:01:00.0 failed with error -12
> > >
> > > However when using native PCIe hotplug
> > >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> > > it works fine, since kernel attempts to reassign unused resources.
> > > Use the same machinery as native PCIe hotplug to (re)assign resources.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > or please let me know if you want me to pick this up.
>
> It would be nice if you could pick it up.

OK, I'll do that unless Bjorn tells me that he prefers to take it via
the PCI tree.

Thanks!

> >
> > > ---
> > > tested in QEMU with Q35 machine on PCIE root port and also
> > > with nested conventional bridge attached to root port.
> > > ---
> > >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > index 5b1f271c6034..9aebde28a92f 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> > >                                 }
> > >                         }
> > >                 }
> > > -               __pci_bus_assign_resources(bus, &add_list, NULL);
> > > +               pci_assign_unassigned_bridge_resources(bus->self);
> > >         }
> > >
> > >         acpiphp_sanitize_bus(bus);
> > > --
> > > 2.39.1
> > >
> >
>
