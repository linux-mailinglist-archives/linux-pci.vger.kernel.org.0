Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEF70BC62
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 13:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjEVLxU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 22 May 2023 07:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjEVLxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 07:53:18 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4AB9;
        Mon, 22 May 2023 04:52:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96f66fbd770so64006766b.1;
        Mon, 22 May 2023 04:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684756368; x=1687348368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FPeo127aNEneYS/+N/CPU60LUgRtnsXFwUreJ7fb7k=;
        b=jz3PdrrCQfFvnqYya0g6pH1JIMvX2e2TyNVBJA27VLxJarUNbA09kYZ0OYos0xmaQr
         xA5tdaNLwoXI2Da+eEgGqtpgaguSvA86Ire2+JiM46f1EIdU0/6wcHXQF672PqRRIJeU
         vrX0gHLPlhxTor/m9/lb4eseDlGbmwVrKTrZxENLMlCj37bEzKybAOZu46M7OUGP3D4B
         0op9A6nLxul24lcbD49nm+RZnq/5DNzHEBQ7d8X9qrXe02Q9v5iJP0sRqOIBLdzDjGb6
         aR5p6yUjToQ1VLqb3tUZUB6eClTU9KS7uRRQl58RJ5XXX9gUB/R0ojdK++tVRpBbGcVv
         xozA==
X-Gm-Message-State: AC+VfDyUo5GHI7MJHwV/FsvF/IsIg2eATQvH2nTKRHNFQnaUwIFYMFtQ
        PCMCZUbqn1Q7eW3c4u596wgfzPRO868JhLOCfAFaXXly
X-Google-Smtp-Source: ACHHUZ7ay0sDw93PbatWpSuJjrVDcBSB58TJboeKwJrei0jiFWOncTr6FVqIaSmaVs0GDMnfXGEijnILFjvyFyMdQe8=
X-Received: by 2002:a17:906:7495:b0:94e:9efa:a9ed with SMTP id
 e21-20020a170906749500b0094e9efaa9edmr9837725ejl.7.1684756368268; Mon, 22 May
 2023 04:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230424191557.2464760-1-imammedo@redhat.com> <20230522130635.5e3f8771@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230522130635.5e3f8771@imammedo.users.ipa.redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 13:52:33 +0200
Message-ID: <CAJZ5v0jcap1Qe=PeZ98csqN9DxwZLPRontGkbvMuah6XrtbT4A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if necessary
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, mst@redhat.com,
        lenb@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mika.westerberg@linux.intel.com
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

On Mon, May 22, 2023 at 1:06 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 24 Apr 2023 21:15:57 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
>
> Rafael,
>
> Since there was no more comments for a while,
> can you merge this patch through your tree?

I need an ACK from Bjorn on this, as the PCI maintainer, or it can go
in via the PCI tree as far as I'm concerned.

Thanks!

> > Reproducer:
> >   $ qemu-kvm -monitor stdio -M q35  -m 4G \
> >       -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=on \
> >       -device id=rp1,pcie-root-port,bus=pcie.0,chassis=4 \
> >       disk_image
> >
> >  wait till linux guest boots, then hotplug device
> >    (qemu) device_add qxl,bus=rp1
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
> >   '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off'
> > it works fine, since kernel attempts to reassign unused resources.
> > Use the same machinery as native PCIe hotplug to (re)assign resources.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > tested in QEMU with Q35 machine on PCIE root port and also
> > with nested conventional bridge attached to root port.
> >
> > v2:
> >   * fixup subject to match expected style
> >   * drop no longer needed __pci_bus_size_bridges() to avoid
> >     memory leak (Bjorn Helgaas <helgaas@kernel.org>)
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 5b1f271c6034..328d1e416014 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -498,7 +498,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >                               acpiphp_native_scan_bridge(dev);
> >               }
> >       } else {
> > -             LIST_HEAD(add_list);
> >               int max, pass;
> >
> >               acpiphp_rescan_slot(slot);
> > @@ -512,12 +511,10 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >                               if (pass && dev->subordinate) {
> >                                       check_hotplug_bridge(slot, dev);
> >                                       pcibios_resource_survey_bus(dev->subordinate);
> > -                                     __pci_bus_size_bridges(dev->subordinate,
> > -                                                            &add_list);
> >                               }
> >                       }
> >               }
> > -             __pci_bus_assign_resources(bus, &add_list, NULL);
> > +             pci_assign_unassigned_bridge_resources(bus->self);
> >       }
> >
> >       acpiphp_sanitize_bus(bus);
>
