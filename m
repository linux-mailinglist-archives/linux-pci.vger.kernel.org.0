Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0346ED590
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 21:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjDXTuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjDXTuC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 15:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B655F6A6E
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682365745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTI1tu6cWoeELfwi4AxmEKHbRrCJTiIALxNCecP7Nmc=;
        b=VsKFOeLeJOrZfbvawlQkwUgfKGbpXFP6w53a+RLqvaNFw9SH0ysZHLj+HHpb0YiGTnyLhn
        p9s6hxB07APCqBS5JLUwMjwuQp57XX9sipgQju6Ke3dbe1hukX+DN/BcMQSsQqu9cCdOvh
        pxiZZ8rYlG2ECdvN/Dz3qBTAy2ANaq4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-FK0O3NN-PECa3PpJPSd-WQ-1; Mon, 24 Apr 2023 15:49:04 -0400
X-MC-Unique: FK0O3NN-PECa3PpJPSd-WQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f18b63229bso41333465e9.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365743; x=1684957743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTI1tu6cWoeELfwi4AxmEKHbRrCJTiIALxNCecP7Nmc=;
        b=Di8WPlFIogUc8wZYm7tfwj8bqQ4FcV2FjqfSYPNV347z/Ll250TnlEmpu+6K4YkOMb
         j5rRjVp+gWvKy5yRNWYMP76x9IsG2oNeZT8qs2i/gIVkoq0N8J13H3reuMV4vDHc+GRE
         X46UtkRg5g72Pv2rEwoHJybVBqfpm157GkduKZOPJxUaQaMpTspiVfWQwn3o9vcwkt7E
         WcfF/gLOgDQcX5RUoB+NNBjjXbuJ8VPYGxw0Ol4OeieH7BgLwxQLMyymEEA57z0BZ9Wk
         JtdARnMSHOYdSzvDlZvZSELwvuG+L1/uTuFjwnj7nZHOmun0toPKmhBhEAtk06ni7ZUb
         bN6A==
X-Gm-Message-State: AAQBX9dyMbbcIkfPxIG9JkX/Ru9wC+XUubquLjMpi6NuKqGRFjaSW2Zt
        EJp4nRX+wHaUF9NKG4amJoA/hrc5sut5YZIaSXF6S/TtCWzOTHARdJ/yHbJ/iOls2RazewGLi4E
        7fGWFWhgnzuKpQi7uQ0PU
X-Received: by 2002:a5d:414c:0:b0:2fa:d00d:cab8 with SMTP id c12-20020a5d414c000000b002fad00dcab8mr10439525wrq.18.1682365743121;
        Mon, 24 Apr 2023 12:49:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPveYCMa7kATcvv9vSpA2vS67OKhPUDEUxq7mo61b3Yx1+RK6Frca9v+7zTM4GLMtLsn/OjQ==
X-Received: by 2002:a5d:414c:0:b0:2fa:d00d:cab8 with SMTP id c12-20020a5d414c000000b002fad00dcab8mr10439510wrq.18.1682365742740;
        Mon, 24 Apr 2023 12:49:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5043000000b002c70ce264bfsm11380287wrt.76.2023.04.24.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:49:02 -0700 (PDT)
Date:   Mon, 24 Apr 2023 21:49:01 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, mst@redhat.com, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        imammedo@redhat.com
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230424214901.0488ec26@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230424205014.2c213437@imammedo.users.ipa.redhat.com>
References: <CAJZ5v0gWKwOiACmK9=ru5W15Kydv6JqKJ8d4ngzKC7jqAjjcpQ@mail.gmail.com>
        <20230418163114.GA134491@bhelgaas>
        <20230424205014.2c213437@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Apr 2023 20:50:14 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 18 Apr 2023 11:31:14 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
> > [+cc Mika, who made previous changes in this area]
> >=20
> > On Tue, Apr 18, 2023 at 05:38:15PM +0200, Rafael J. Wysocki wrote: =20
> > > On Tue, Apr 18, 2023 at 4:17=E2=80=AFPM Igor Mammedov <imammedo@redha=
t.com> wrote:   =20
> > > > On Tue, 18 Apr 2023 14:55:29 +0200
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:   =20
> > > > > On Tue, Apr 18, 2023 at 10:50=E2=80=AFAM Igor Mammedov <imammedo@=
redhat.com> wrote:   =20
> > > > > >
> > > > > > When using ACPI PCI hotplug, hotplugging a device with
> > > > > > large BARs may fail if bridge windows programmed by
> > > > > > firmware are not large enough.
> > > > > >
> > > > > > Reproducer:
> > > > > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > > > > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Do=
n \
> > > > > >       -device id=3Drp1,pcie-root-port,bus=3Dpcie.0,chassis=3D4 \
> > > > > >       disk_image
> > > > > >
> > > > > >  wait till linux guest boots, then hotplug device
> > > > > >    (qemu) device_add qxl,bus=3Drp1
> > > > > >
> > > > > >  hotplug on guest side fails with:
> > > > > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > > > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > > > > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > > > > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > > > > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > > > > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > > > > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x040000=
00]
> > > > > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > > > > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x040000=
00]
> > > > > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > > > > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > > > > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > > > > >    Unable to create vram_mapping
> > > > > >    qxl: probe of 0000:01:00.0 failed with error -12
> > > > > >
> > > > > > However when using native PCIe hotplug
> > > > > >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff'
> > > > > > it works fine, since kernel attempts to reassign unused resourc=
es.
> > > > > > Use the same machinery as native PCIe hotplug to (re)assign res=
ources.   =20
> >=20
> > Thanks for the nice reproducer and logs!
> >  =20
> > > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>   =20
> > > > >
> > > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > or please let me know if you want me to pick this up.   =20
> > > >
> > > > It would be nice if you could pick it up.   =20
> > >=20
> > > OK, I'll do that unless Bjorn tells me that he prefers to take it via
> > > the PCI tree.   =20
> >=20
> > It's OK with me if you pick this up, but please update the subject to
> > use the style of previous commits, e.g.,
> >=20
> >   PCI: acpiphp: Reassign resources on bridge if necessary
> >=20
> > Previous changes involving pci_assign_unassigned_bridge_resources() in
> > enable_slot() (these are from Mika, so I cc'd him in case he wants to
> > comment):
> >=20
> >   84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by na=
tive hotplug")
> >   77adf9355304 ("ACPI / hotplug / PCI: Allocate resources directly unde=
r the non-hotplug bridge")
> >  =20
> > > > > > ---
> > > > > > tested in QEMU with Q35 machine on PCIE root port and also
> > > > > > with nested conventional bridge attached to root port.
> > > > > > ---
> > > > > >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/h=
otplug/acpiphp_glue.c
> > > > > > index 5b1f271c6034..9aebde28a92f 100644
> > > > > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > > > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > > > > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot=
 *slot, bool bridge)   =20
> >=20
> > Previous context:
> >=20
> >                                              __pci_bus_size_bridges(dev=
->subordinate,
> >                                                                     &ad=
d_list);
> >  =20
> > > > > >                                 }
> > > > > >                         }
> > > > > >                 }
> > > > > > -               __pci_bus_assign_resources(bus, &add_list, NULL=
);
> > > > > > +               pci_assign_unassigned_bridge_resources(bus->sel=
f);   =20
> >=20
> > "add_list" is now used only for __pci_bus_size_bridges(), which
> > *looks* unnecessary unless there's some obscure side-effect of that
> > path when that parameter is non-NULL.
> >=20
> > If "add_list" is unnecessary, you would probably use
> > pci_bus_size_bridges() above instead of __pci_bus_size_bridges(). =20
>=20
> pci_assign_unassigned_bridge_resources() calls __pci_bus_size_bridges()
> so original one is not needed anymore, in addition it might leak entries
> added to add_list.
> I'll remove __pci_bus_size_bridges() and respin patch (incl. updated subj=
ect)
>=20
> =20
> > After this patch, we have:
> >=20
> >   if (bridge && bus->self && hotplug_is_native(bus->self)) {
> >     for_each_pci_bridge(dev, bus)
> >       acpiphp_native_scan_bridge(dev);
> >   } else {
> >     ...
> >     pci_assign_unassigned_bridge_resources(bus->self);
> >   }
> >=20
> > We do not do pci_assign_unassigned_bridge_resources() in the "then"
> > part of the "if".  Per the comment, that case may be used for adding
> > Thunderbolt controllers.  Is there a reason we do not want
> > pci_assign_unassigned_bridge_resources() in that path,
> > or should it be
> > in both cases? =20
> acpiphp_native_scan_bridge() looks very similar to 'else'
> branch modulo skip native hp bridge condition.
> Otherwise both branches look similar,=20
> but I don't have means to test that usecase,
> so I'd avoid touching something nobody complains about.

I gave some more testing to the case with hotplugged sub-bridges,
and this patch doesn't help much with that, meaning that
pci_assign_unassigned_bridge_resources() when re-sizing goes
only to parent for extra resources. So case:
   1. hotplug SHPC bridge first & then hotplug a device into
      hotplugged SHPC bridge, may still fail as SHPC calling
      its own pci_assign_unassigned_bridge_resources(), will reach
      only to its parent (root port) which in turn might not have enough
      resources.
   2. hotplugging compound bridge+device attached to it in one go,
      works as expected since pci_assign_unassigned_bridge_resources()
      on root port accounts for all needed resources and asks for them
      from host-bridge.
=20
So basically patch fixes reassignment in case of hotplug into root port
(it brings acpiphp on root port on par with native hotplug).

It doesn't work for nested bridges, but the same applies to native
hotplug as well.
Perhaps we should make pci_assign_unassigned_bridge_resources() ask for
more resources all the way down to host bridge (crude but might be sufficie=
nt).

PS:
I've found an attempt to make reassignment work properly (dating to 2012)
https://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git/l=
og/
but it doesn't look like it's been merged.

> > > > > >         }
> > > > > >
> > > > > >         acpiphp_sanitize_bus(bus);   =20
> >  =20
>=20

