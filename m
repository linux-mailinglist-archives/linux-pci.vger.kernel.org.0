Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9438050123F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiDNOWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbiDNNpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 09:45:11 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D8140DE;
        Thu, 14 Apr 2022 06:42:45 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 047581BF20C;
        Thu, 14 Apr 2022 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649943763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uf/NUgWHuhWSypo4uHHoAgWnaBAtZS72tioBfXir5rw=;
        b=RH9+J969PE/jWaLdsCV+Jg1ttNMgnWmL2DqDCmlGulbszBjD9NE52I2J8RVKtHvaLsECs9
        S8j67gnG0CdrH/urV5Uw8cdGR4XfehozZgFSA6Eg7ukBmemeWcBtEsm45Q6wloI5KV7rbX
        Fy1xTIHQyDpWpZ7/AthMJAEHBuy4ptwTA4uoeVdplikQzQx5jG5FeLj+uPWcStSohLc28N
        KAAWjoFcxPN+HmjvfAAD+dE+5eo8GyyKzsL/4WqsfD4BjmhB6//KozDJPHWWWcoYawa3FI
        wwZPzGot1uDZ4YL894ldPzkehTWSGlL7VU3yYbmpYpXogF/aXiFowNMKUC6JKQ==
Date:   Thu, 14 Apr 2022 15:42:32 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 1/8] PCI: rcar-gen2: Add support for clocks
Message-ID: <20220414154232.098a4451@bootlin.com>
In-Reply-To: <CAMuHMdUCvJ6rAwnV=w9iFqnm=c0U_BpGiYEw109shsrWAeUJCA@mail.gmail.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-2-herve.codina@bootlin.com>
        <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
        <20220414132534.35467781@bootlin.com>
        <CAMuHMdUCvJ6rAwnV=w9iFqnm=c0U_BpGiYEw109shsrWAeUJCA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Thu, 14 Apr 2022 13:48:22 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Thu, Apr 14, 2022 at 1:29 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > On Thu, 14 Apr 2022 10:45:54 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote: =20
> > > On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.co=
m> wrote: =20
> > > > The PCI rcar-gen2 does not call any clk_prepare_enable(). =20
> > >
> > > Correct, this driver manages the clocks indirectly through Runtime PM.
> > > =20
> > > > This lead to an access failure when the driver tries to access
> > > > the IP (at least on a RZ/N1D platform). =20
> > >
> > > I expect adding
> > >
> > >     power-domans =3D <&sysctrl>;
> > >
> > > to the pci_usb node makes this patch redundant. =20
> >
> > Seems not enough.
> > I tried what you suggest :
> >  - Added 'power-domains =3D <&systrl>;' to the pci_usb node
> >  - Added missing '#power-domain-cells =3D <0>;' to sysctrl node
> >  - Reverted my patch.
> >
> > The system crashed at boot: =20
>=20
> > [    0.832958] Unhandled fault: external abort on non-linefetch (0x1008=
) at 0x90b5f848 =20
>=20
> That's indeed a typical symptom of accessing a module's registers
> while the module's clock is disabled.
>=20
> > I also added a trace printk in r9a06g032-clocks.c and
> > r9a06g032_attach_dev() was never called.
> >
> > Did I miss to set something ? =20
>=20
> Do you have CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS
> enabled?
> Apparently ARCH_RZN1 does not select these options yet.
>=20

Thanks a lot for pointing this.

I added select CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS
in ARCH_RZN1 and it works.

I will remove my patch calling clk_bulk_prepare_enable() and
add some new patches to enable power domains in the v3 series.

Regards,
Herv=C3=A9

