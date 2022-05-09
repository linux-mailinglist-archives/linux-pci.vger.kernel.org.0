Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F704520617
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiEIUpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiEIUpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 16:45:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F062AC7A;
        Mon,  9 May 2022 13:40:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh6so29141918ejb.0;
        Mon, 09 May 2022 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ugeMprRoxrWREeg1RKkYPg4Z7RTTPYWXOFWFyXLKJkY=;
        b=bl59jxYva+k74U5PvkEkc3+zrF+rXUFUom1CtW2SBk31foyF2caMrx2GZYSVp38Keu
         309gf5i1sU0v4N0Zup5BKrps+hK6oT1nru9MgDjdcTAC5LeHlQsdXLk/NAJCSg6Zu5Wk
         Mb/MwkIqd5nHl/omlbTVlZmwHYNyfBmxo1zek0IbrZzgEAGwmPKzsR7xRxsqxrtPTUr/
         juWDnnAapif2AvymdLXREB14vBTkntOx4dvxFxuJVxv6gbyqqxWqwdaJm+eDa0RSHc9F
         ZMOmFgsHdKrWLwB/HQRu3PdK4sR5QfeuNN7GiV9GG1yY0wp6fVkhWdAyyCXxKvt4uQWG
         0nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ugeMprRoxrWREeg1RKkYPg4Z7RTTPYWXOFWFyXLKJkY=;
        b=Kl4OCKXFVs2XwqibUfYdsDrNxkbN3ezbeMO1tPqXDsFUWMEfBuhhEb+DTaaFwV9G4d
         p+B1xQB0NB1WU/FIpYXjK3wbmHT2jX/6bywS0JQYJ/nMGE+yG1o566qT7HYzrXBuiLtg
         aPXuHz3sTC4c38E4TDsASl3sWgEotp17M+96kXrIJjmkUnMCTCVmbC0g4KE+9mlmq49p
         oo3LguL9dTUdFPvv3o4sgMB2RnQsbGB6lFMIGzmS+gBOKuVLQkmMT8Rr4zymI23tjdvi
         I4FCOqBaYO3h3MKar7VJg2sSVg0myUkQ6tiWRkNdvb3VgnDb38mXOKpkD+t9dbkNfBAj
         s2uw==
X-Gm-Message-State: AOAM5304i3HcKgZzLIZGdJ6nsUZTPKdQXElhX6PDyalNh5NLXchEkkLP
        06NK3z496NoJ8Rk5o8uEqURv50ndh89kG0VAEGjIZQbA6r4nue6+
X-Google-Smtp-Source: ABdhPJzXi5SdTvvpc5c8vT3NNNzWo6Cr8z0PXYIhbP3f/ag+dxrEWJge/uMGAdlCnjopMvzTkVtBvaZhJb6ChQO/ERs=
X-Received: by 2002:a17:907:868e:b0:6fa:2fe2:92d6 with SMTP id
 qa14-20020a170907868e00b006fa2fe292d6mr6920008ejc.639.1652128849246; Mon, 09
 May 2022 13:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com> <20220509141634.16158c38@xps-bootlin>
 <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com> <20220509180917.0f0ae851@xps-bootlin>
 <YnlIs312R4Temgu3@smile.fi.intel.com> <b476913d-896d-309c-f304-3ab37b81b4a9@gmail.com>
In-Reply-To: <b476913d-896d-309c-f304-3ab37b81b4a9@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 May 2022 22:40:12 +0200
Message-ID: <CAHp75VedNAG4EqPkCp-mCSUNJiKPNgaJEtsHQkWimyaYh0Nueg@mail.gmail.com>
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 9, 2022 at 10:36 PM Frank Rowand <frowand.list@gmail.com> wrote=
:
>
> On 5/9/22 12:00, Andy Shevchenko wrote:
> > On Mon, May 09, 2022 at 06:09:17PM +0200, Cl=C3=A9ment L=C3=A9ger wrote=
:
> >> Le Mon, 9 May 2022 10:56:36 -0500,
> >> Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >
> > ...
> >
> >>> On the surface, it appears that your need might be well met by having
> >>> a base devicetree that describes all of the pcie nodes, but with each
> >>> node having a status of "disabled" so that they will not be used.
> >>> Have a devicetree overlay describing the pcie card (as you proposed),
> >>> where the overlay also includes a status of "ok" for the pcie node.
> >>> Applying the overlay, with a method of redirecting the target to a
> >>> specific pcie node would change the status of the pcie node to enable
> >>> its use.  (You have already proposed a patch to modify
> >>> of_overlay_fdt_apply() to allow a modified target, so not a new
> >>> concept from me.)  My suggestion is to apply the overlay devicetree
> >>> to the base devicetree before the combined FDT devicetree is passed
> >>> to the kernel at boot.  The overlay apply could be done by several
> >>> different entities.  It could be before the bootloader executes, it
> >>> could be done by the bootloader, it could be done by a shim between
> >>> the bootloader and the kernel.  This method avoids all of the issues
> >>> of applying an overlay to a running system that I find problematic.
> >>> It is also a method used by the U-boot bootloader, as an example.
> >>
> >> Ok, that is actually possible on a system that is given a device-tree
> >> by the bootloader. But on a system that is desrcibed using ACPI (such
> >> as the x86), this is much more difficult (at least to my knowledge)...
> >> We want this feature to be easy to use for the end user. Adding such
> >> configuration which also differs between various architecture is
> >> clearly not so easy to setup.
> >>
> >> Moreover, since the PCI is meant to be "Plug and Play", such
> >> configuration would completely break that. If the user switches the
> >> PCIe card from one slot to another, the bootloader configuration will
> >> need to be modified. This seems a big no way for me (and for the user)=
.
> >
> > The main problem here is that Linux does not support hotplugging for th=
e
> > devices behind non-hotpluggable buses. You need to develop something to
> > say that the device tree (in terms of hardware) can morph at run-time
> > transparently to the user. I think the closest one is what FPGA does,
> > or at least should do.
>
> That is something I was not aware of yet.  Is the card in question a
> hotpluggable card?  Do the systems that you anticipate plugging the
> card into support hotplug?

Any PCIe card is potentially hotpluggable (seems nobody actually cares
in 90%+ drivers in the Linux kernel). But what I have heard in a
thread (not this one IIRC) is that the card may have pluggable modules
and it would be nice to change configuration and notify OS somehow. I
might be mistaken if it's the case here or not.

--=20
With Best Regards,
Andy Shevchenko
