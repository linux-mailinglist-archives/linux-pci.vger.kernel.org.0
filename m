Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3370CD01
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 23:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEVVzY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 22 May 2023 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjEVVzX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 17:55:23 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D09100;
        Mon, 22 May 2023 14:55:18 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94ea38c90ccso74205866b.1;
        Mon, 22 May 2023 14:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792517; x=1687384517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkCW6XGWf4P7NqQSR0WGoTlQ1C0GrKu4B0WVO7jeN6o=;
        b=Vyqtg8rwHSNQPaEd2kvEt1vBSV1kp+Rz+LcMfdNp7h2TwoQENF11at6CDWwu0iJHc3
         CLo6JZWjY3d5vmSrGmTPfBggQ3VlJYdw+2o/cFf5o5K66lrYW+VE4kIReAtPZu5Q/bzt
         Dz7FfhN34S42Juk1iI9+E6p736+qy8WfMkWOOX1U0C0NHT4GO6GiZ/8a8md0jyqasMWb
         /ZOUSqcCAEAYYktJHUWj62IGCXBTUtRvkPMO5h/aO4tpCJm9GEOMEbEFd2N2ptaZwEEo
         cN2Nh1PTPaZd7YaDOj/5JlpSkFXXzC97qw751M1vGgeOXr2inqWAIY3zyur1mlFyGKUx
         xA/w==
X-Gm-Message-State: AC+VfDxDXz9CJOiBtjRQ9J/XlxxWDOwyDLfptqpyUdaX22nSmPh4uIrm
        S6pCIzpXRl62/1S4I7iYlmOTdd+ON1liWcGSZmQ=
X-Google-Smtp-Source: ACHHUZ7Evizi4JfCltD7zaub20aCJcg98/e9oS+xbgo2kLSRBqeh3ZVFAeAgGk7df9mr8FMrUM6TIFhOAKvTFukZCHo=
X-Received: by 2002:a17:906:5199:b0:965:9602:3ee1 with SMTP id
 y25-20020a170906519900b0096596023ee1mr10513995ejk.2.1684792516874; Mon, 22
 May 2023 14:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230424191557.2464760-1-imammedo@redhat.com> <ZGvj7aqaY3InNqun@bhelgaas>
In-Reply-To: <ZGvj7aqaY3InNqun@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 23:55:05 +0200
Message-ID: <CAJZ5v0g3w115Uv+FnrgomuTaxVWxfzhjJo400iji4P-HT5eo2w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: acpiphp: Reassign resources on bridge if necessary
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com
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

On Mon, May 22, 2023 at 11:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Apr 24, 2023 at 09:15:57PM +0200, Igor Mammedov wrote:
> > When using ACPI PCI hotplug, hotplugging a device with
> > large BARs may fail if bridge windows programmed by
> > firmware are not large enough.
> >
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
>
> Tentatively applied to pci/hotplug for v6.5.
>
> Tentative only because I'm hoping for your ack or review, Rafael (I
> see you acked v1, but this one is a little different).

This one is fine with me too, so please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to it.

> And I think you'd like a stable tag, Michael?  I'm happy to add one,
> but wasn't sure if you wanted a separate ack for that.
>
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
> > --
> > 2.39.1
> >
