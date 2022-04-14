Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67889500C2B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 13:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbiDNLcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 07:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiDNLcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 07:32:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD637A94;
        Thu, 14 Apr 2022 04:29:45 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E669440008;
        Thu, 14 Apr 2022 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649935784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRrX/8Jotzsy6iQLV5tj4FOuDifcieScWpPwj2D0dac=;
        b=Ezoe77V7SQHGJDbVcnEt0HG8gxn+9iEz6lNCCthfy5D53f0EFtzsqwJd6xaEKLw9QePM/S
        +/dkqi+0dtSzYL9yuYR0m/sUTqofMra1AxS+tSt5xu+yswTI47FnjzE2XkdZ6FMupgyWbO
        5aHhklzsz6+jRFFnuWj4+H303C8WBiwiT70X6vwy+nBKZpNl1fNDP/Al97g0CHkfpw/9Du
        fbupqg8hO7QjWBQOm3Z+Uvr+iN6oWiqeUwKSTy5sKv7hukSRRGOvXQIZ+3JxeJzzvtYCyw
        nER4JqUUWhAdfgTbUfs1nwTMXyNLrf7JxbuORGjRKIlnDMqZPsyl7GmO+7d8qA==
Date:   Thu, 14 Apr 2022 13:29:34 +0200
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
Message-ID: <20220414132534.35467781@bootlin.com>
In-Reply-To: <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-2-herve.codina@bootlin.com>
        <CAMuHMdW8q5AjDtTE83yVPfmgnQy02UgLSns33z06WMFBUULWEw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Thu, 14 Apr 2022 10:45:54 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> Thanks for your patch!
>=20
> On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > The PCI rcar-gen2 does not call any clk_prepare_enable(). =20
>=20
> Correct, this driver manages the clocks indirectly through Runtime PM.
>=20
> > This lead to an access failure when the driver tries to access
> > the IP (at least on a RZ/N1D platform). =20
>=20
> I expect adding
>=20
>     power-domans =3D <&sysctrl>;
>=20
> to the pci_usb node makes this patch redundant.

Seems not enough.
I tried what you suggest :
 - Added 'power-domains =3D <&systrl>;' to the pci_usb node
 - Added missing '#power-domain-cells =3D <0>;' to sysctrl node
 - Reverted my patch.

The system crashed at boot:
--- 8< ---
...
[    0.705309] loop: module loaded
[    0.709597] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.716804] ehci-pci: EHCI PCI platform driver
[    0.721716] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.728522] ohci-pci: OHCI PCI platform driver
[    0.733581] usbcore: registered new interface driver usb-storage
[    0.740458] ThumbEE CPU extension supported.
[    0.745093] Registering SWP/SWPB emulation handler
[    0.797518] rzn1-pinctrl 40067000.pinctrl: probed
[    0.803311] pci-rcar-gen2 40030000.pci: host bridge /soc/pci@40030000 ra=
nges:
[    0.811255] pci-rcar-gen2 40030000.pci:      MEM 0x0040020000..0x004002f=
fff -> 0x0040020000
[    0.820373] pci-rcar-gen2 40030000.pci:   IB MEM 0x0080000000..0x00bffff=
fff -> 0x0080000000
[    0.829609] 8<--- cut here ---
[    0.832958] Unhandled fault: external abort on non-linefetch (0x1008) at=
 0x90b5f848
[    0.841259] [90b5f848] *pgd=3D82149811, *pte=3D40030653, *ppte=3D40030453
[    0.848093] Internal error: : 1008 [#1] SMP ARM
[    0.853024] Modules linked in:
[    0.856398] CPU: 0 PID: 31 Comm: kworker/u4:1 Not tainted 5.18.0-rc2-000=
09-g803ee9fd9fa5-dirty #5
[    0.865998] Hardware name: Generic DT based system
[    0.871176] Workqueue: events_unbound deferred_probe_work_func
[    0.877539] PC is at rcar_pci_probe+0x15c/0x2f8
[    0.882454] LR is at _raw_spin_unlock_irqrestore+0x24/0x2c
[    0.888434] pc : [<803ea428>]    lr : [<804dc9b0>]    psr: 60000013
[    0.895193] sp : 90aa5e40  ip : 8217c4e0  fp : 00000000
[    0.900857] r10: 80e7bd30  r9 : 80000000  r8 : 40000000
[    0.906532] r7 : 80000000  r6 : 8217c410  r5 : 821d3400  r4 : 90b5f000
[    0.913580] r3 : 00000009  r2 : 5c120fb6  r1 : 60000013  r0 : 00000000
[    0.920646] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[    0.928365] Control: 10c5387d  Table: 8000406a  DAC: 00000051
...
--- 8< ---

I also added a trace printk in r9a06g032-clocks.c and
r9a06g032_attach_dev() was never called.

Did I miss to set something ?

Regards,
Herv=C3=A9
