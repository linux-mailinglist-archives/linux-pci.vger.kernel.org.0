Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EC6E66EC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjDRORy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDRORx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 10:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C3A9C
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681827426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7E0f97enKWeGm4kBxYLE/5HBvfl7WhJLhN+ZbF/ZnM=;
        b=YHwBtmWDCDAEeMCenO+KB3jbauEDIoRNOYMQ585aSVwouDc/4lwZ/Qc36l+ypfxSxgD2ct
        n/0IuJnZXhoyU6yJlL4A9IVWwJJokxLODAyxDnome4rh/UoqcEazHoAEUAm6WGr4u+XrYO
        mS+QIh8j66+fvSv02VE83p4mypAC3k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-LbOaIvzZOU2n8ttU-fTgTQ-1; Tue, 18 Apr 2023 10:17:05 -0400
X-MC-Unique: LbOaIvzZOU2n8ttU-fTgTQ-1
Received: by mail-wm1-f72.google.com with SMTP id p3-20020a05600c358300b003f175c338d6so1548304wmq.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827423; x=1684419423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7E0f97enKWeGm4kBxYLE/5HBvfl7WhJLhN+ZbF/ZnM=;
        b=UTCDE7M83LwYOXdcx/nlxCkBw/OvBjVeYX0PhxcFUTQargbo5QwqpU4afnDbACFU+F
         4z74NnKckoIUmswfWsemYB4wFCDy13TLAJ5l68RhsAGRKZQxQMU5XJpNDqby8Z2onxpc
         /mwj82PwxrpqZ5lgT1S5LvLUC4g82hay2sl5SGK9jabSG6fi11zcTIsQin/ooVmK4Gt1
         qxEn7ws8XvxE0zgv5KpHhuj5Ck4eDII5EWaUQ5Ex2cjqxGZbBihhYS5YDs5NN6qrLh4U
         QBD6/VFSuyTK4Nx/n8xufJmUOixX/pzARys+G1EkfUbsgsPgquDK5JxF4LzgLVswP6OF
         IVuA==
X-Gm-Message-State: AAQBX9cigiijzr2Ot+yG31zHNAxLkzbrV3DQusCvFTbrWb4/KIj6JI5Z
        TK/dkAswWx2XegZ0cA6CTACjiWJr9FkeNwEd1Q5+p62i5eimCve8YZzsglSkL8Nby814zP2Ho9H
        aSVEHLRj90Ge9QLfZX335
X-Received: by 2002:a05:600c:24e:b0:3ef:71d5:41d8 with SMTP id 14-20020a05600c024e00b003ef71d541d8mr14882512wmj.32.1681827423682;
        Tue, 18 Apr 2023 07:17:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z4k5mZUQ0YlvrUPDg3GmVXRk4kB6wqO8dr86TybU23pVcwkwl7iUHnmRW6t9oXDtel+NfwTA==
X-Received: by 2002:a05:600c:24e:b0:3ef:71d5:41d8 with SMTP id 14-20020a05600c024e00b003ef71d541d8mr14882495wmj.32.1681827423366;
        Tue, 18 Apr 2023 07:17:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm18904809wms.35.2023.04.18.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:17:02 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:17:02 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: acpiphp: try to reassign resources on bridge if
 necessary
Message-ID: <20230418161702.0945fc67@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
References: <20230418085030.2154918-1-imammedo@redhat.com>
        <CAJZ5v0geYujyXKv9mG_i+2rjcdrMVh+jmE1ffJ79_oFr8GNoMg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 18 Apr 2023 14:55:29 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 18, 2023 at 10:50=E2=80=AFAM Igor Mammedov <imammedo@redhat.c=
om> wrote:
> >
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
> >
> > Reproducer:
> >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Don \
> >       -device id=3Drp1,pcie-root-port,bus=3Dpcie.0,chassis=3D4 \
> >       disk_image
> >
> >  wait till linux guest boots, then hotplug device
> >    (qemu) device_add qxl,bus=3Drp1
> >
> >  hotplug on guest side fails with:
> >    pci 0000:01:00.0: [1b36:0100] type 00 class 0x038000
> >    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x03ffffff]
> >    pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00001fff]
> >    pci 0000:01:00.0: reg 0x1c: [io  0x0000-0x001f]
> >    pci 0000:01:00.0: BAR 0: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: no space for [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 1: failed to assign [mem size 0x04000000]
> >    pci 0000:01:00.0: BAR 2: assigned [mem 0xfe800000-0xfe801fff]
> >    pci 0000:01:00.0: BAR 3: assigned [io  0x1000-0x101f]
> >    qxl 0000:01:00.0: enabling device (0000 -> 0003)
> >    Unable to create vram_mapping
> >    qxl: probe of 0000:01:00.0 failed with error -12
> >
> > However when using native PCIe hotplug
> >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff'
> > it works fine, since kernel attempts to reassign unused resources.
> > Use the same machinery as native PCIe hotplug to (re)assign resources.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> or please let me know if you want me to pick this up.

It would be nice if you could pick it up.
Thanks!

>=20
> > ---
> > tested in QEMU with Q35 machine on PCIE root port and also
> > with nested conventional bridge attached to root port.
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/a=
cpiphp_glue.c
> > index 5b1f271c6034..9aebde28a92f 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -517,7 +517,7 @@ static void enable_slot(struct acpiphp_slot *slot, =
bool bridge)
> >                                 }
> >                         }
> >                 }
> > -               __pci_bus_assign_resources(bus, &add_list, NULL);
> > +               pci_assign_unassigned_bridge_resources(bus->self);
> >         }
> >
> >         acpiphp_sanitize_bus(bus);
> > --
> > 2.39.1
> > =20
>=20

