Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD046ED4D3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjDXSwZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjDXSwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 14:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244A93C0
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682362219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3CNX2aOVkNKHxmzM3EcBfwm75Q+knaGdRtV6fFpBLg=;
        b=ehq386tbDeHoT7wKiqMeA1Th/YZDwYnkPIyetRJjuHnp5InX4K0I//iI9chpwBey9c9+U4
        WaxvuEYtaSCa3UDi7huqUmFz+89XAnbxJTiWiSuGx95rLcdDx8mdEBhxZMBiHVyHuxhyGY
        aOWXLy8tjgxEiKzh9JcJHyCbC3zbvL4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-hlPN0QbMNJqceatzXHELlg-1; Mon, 24 Apr 2023 14:50:18 -0400
X-MC-Unique: hlPN0QbMNJqceatzXHELlg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30479b764f9so527155f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 11:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682362217; x=1684954217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3CNX2aOVkNKHxmzM3EcBfwm75Q+knaGdRtV6fFpBLg=;
        b=ODyaTnUGcTDjyo0DIKNdPJ+K45HAO1na7VPnhhpXwn4YdCqI1aaMuDLd8WCkJyONe1
         jfQrFZxtqVjGodMP0FQsD38TRbLLW+clzvr44nh3EpgW2c9P+LC/mLm07quFNkB6ExKt
         iYyxKvgoPf0Tc7pv+JCRBv1JSJ4Wj8m6TQXZkzWm/vhWibhp/qJCvjX36FfhNWPe2qFS
         RMqfSOLgCgzrprUauc8//NalG0QnHP64ud/yepn8ZnRBs5LN+zyOx2O2Q09FYxPLeM0w
         DCZpupZ971VsudaAGy/nF3Bjbg4cejv2/7sEhCFlsezD3WTTeawQ4TXcdxPnMCETCaJE
         6jvw==
X-Gm-Message-State: AAQBX9cHiP8fKF5/7i0uVfEm8IaYxe6ZArIkaCXf5Zx3jknQ0dpGMpja
        zuNo8ZDaXA+ikfv6FfO4GH2GPhY/hDLs40RSQjHiTDgco73xLbzfMrEvUhZwgVsyiARJjSB+pws
        QDJ70bYja6RYBnqlmNQzT
X-Received: by 2002:a5d:6211:0:b0:304:6e2a:65d9 with SMTP id y17-20020a5d6211000000b003046e2a65d9mr4437829wru.30.1682362217080;
        Mon, 24 Apr 2023 11:50:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEB4F6cqM8vX0/81CUhAiX9Ki6G9vcl8j92FLznL9W4Ur5aEuQ1ttWPOXIs6Vadqbmtjw6/Q==
X-Received: by 2002:a5d:6211:0:b0:304:6e2a:65d9 with SMTP id y17-20020a5d6211000000b003046e2a65d9mr4437815wru.30.1682362216723;
        Mon, 24 Apr 2023 11:50:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003f0aefcc457sm16324008wmo.45.2023.04.24.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:50:15 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:50:14 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, mst@redhat.com, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230424205014.2c213437@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230418163114.GA134491@bhelgaas>
References: <CAJZ5v0gWKwOiACmK9=ru5W15Kydv6JqKJ8d4ngzKC7jqAjjcpQ@mail.gmail.com>
        <20230418163114.GA134491@bhelgaas>
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

On Tue, 18 Apr 2023 11:31:14 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Mika, who made previous changes in this area]
>=20
> On Tue, Apr 18, 2023 at 05:38:15PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 18, 2023 at 4:17=E2=80=AFPM Igor Mammedov <imammedo@redhat.=
com> wrote: =20
> > > On Tue, 18 Apr 2023 14:55:29 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote: =20
> > > > On Tue, Apr 18, 2023 at 10:50=E2=80=AFAM Igor Mammedov <imammedo@re=
dhat.com> wrote: =20
> > > > >
> > > > > When using ACPI PCI hotplug, hotplugging a device with
> > > > > large BARs may fail if bridge windows programmed by
> > > > > firmware are not large enough.
> > > > >
> > > > > Reproducer:
> > > > >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> > > > >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Don \
> > > > >       -device id=3Drp1,pcie-root-port,bus=3Dpcie.0,chassis=3D4 \
> > > > >       disk_image
> > > > >
> > > > >  wait till linux guest boots, then hotplug device
> > > > >    (qemu) device_add qxl,bus=3Drp1
> > > > >
> > > > >  hotplug on guest side fails with:
> > > > >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> > > > >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> > > > >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> > > > >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> > > > >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> > > > >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> > > > >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> > > > >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> > > > >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> > > > >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> > > > >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> > > > >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> > > > >    Unable to create vram_mapping
> > > > >    qxl: probe of 0000:01:00.0 failed with error -12
> > > > >
> > > > > However when using native PCIe hotplug
> > > > >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff'
> > > > > it works fine, since kernel attempts to reassign unused resources.
> > > > > Use the same machinery as native PCIe hotplug to (re)assign resou=
rces. =20
>=20
> Thanks for the nice reproducer and logs!
>=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> > > >
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > or please let me know if you want me to pick this up. =20
> > >
> > > It would be nice if you could pick it up. =20
> >=20
> > OK, I'll do that unless Bjorn tells me that he prefers to take it via
> > the PCI tree. =20
>=20
> It's OK with me if you pick this up, but please update the subject to
> use the style of previous commits, e.g.,
>=20
>   PCI: acpiphp: Reassign resources on bridge if necessary
>=20
> Previous changes involving pci_assign_unassigned_bridge_resources() in
> enable_slot() (these are from Mika, so I cc'd him in case he wants to
> comment):
>=20
>   84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by nati=
ve hotplug")
>   77adf9355304 ("ACPI / hotplug / PCI: Allocate resources directly under =
the non-hotplug bridge")
>=20
> > > > > ---
> > > > > tested in QEMU with Q35 machine on PCIE root port and also
> > > > > with nested conventional bridge attached to root port.
> > > > > ---
> > > > >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hot=
plug/acpiphp_glue.c
> > > > > index 5b1f271c6034..9aebde28a92f 100644
> > > > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > > > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *=
slot, bool bridge) =20
>=20
> Previous context:
>=20
>                                              __pci_bus_size_bridges(dev->=
subordinate,
>                                                                     &add_=
list);
>=20
> > > > >                                 }
> > > > >                         }
> > > > >                 }
> > > > > -               __pci_bus_assign_resources(bus, &add_list, NULL);
> > > > > +               pci_assign_unassigned_bridge_resources(bus->self)=
; =20
>=20
> "add_list" is now used only for __pci_bus_size_bridges(), which
> *looks* unnecessary unless there's some obscure side-effect of that
> path when that parameter is non-NULL.
>=20
> If "add_list" is unnecessary, you would probably use
> pci_bus_size_bridges() above instead of __pci_bus_size_bridges().

pci_assign_unassigned_bridge_resources() calls __pci_bus_size_bridges()
so original one is not needed anymore, in addition it might leak entries
added to add_list.
I'll remove __pci_bus_size_bridges() and respin patch (incl. updated subjec=
t)

=20
> After this patch, we have:
>=20
>   if (bridge && bus->self && hotplug_is_native(bus->self)) {
>     for_each_pci_bridge(dev, bus)
>       acpiphp_native_scan_bridge(dev);
>   } else {
>     ...
>     pci_assign_unassigned_bridge_resources(bus->self);
>   }
>=20
> We do not do pci_assign_unassigned_bridge_resources() in the "then"
> part of the "if".  Per the comment, that case may be used for adding
> Thunderbolt controllers.  Is there a reason we do not want
> pci_assign_unassigned_bridge_resources() in that path,
> or should it be
> in both cases?
acpiphp_native_scan_bridge() looks very similar to 'else'
branch modulo skip native hp bridge condition.
Otherwise both branches look similar,=20
but I don't have means to test that usecase,
so I'd avoid touching something nobody complains about.

>=20
> > > > >         }
> > > > >
> > > > >         acpiphp_sanitize_bus(bus); =20
>=20

