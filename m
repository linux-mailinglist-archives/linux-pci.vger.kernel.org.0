Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A947852EC5B
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347584AbiETMlc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349483AbiETMlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 08:41:05 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264016444;
        Fri, 20 May 2022 05:40:59 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8527FF813;
        Fri, 20 May 2022 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653050457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GABvmK7x6IZrbpyIge9zdiMR5X//miDJAFxM5vKP/m8=;
        b=DMu2i747HBDEsQQJ4uIGtlwYM9XVMHJ9zbat2Zc2t45+VtHl8O4HR/uqnksJze2iQvgvzb
        d8CgOheHLgT70aYZTZE54fZ78wrgS2aj4S4VEN2oDuu5WOx3TOmK8UOB1ag12dTtqA6STW
        rF75ba4wIw+pjF28BRt7jNCGxQmG25CMObXWCnVcI8lsGAjSNs+ymlWF7cUKu1WTTN0PVk
        qbbqIcFtX7EWmO7tLgWyxwM4uVginN8pAS35EDnbXsbq8Mhe6RQanZI80d8wY0fVXIeWxi
        7ZlPUvZSn2zuE1dNA169OO3Q1yVv9wYGu/Pe6jKtz7yrlQX//iOcUQCJEDTsLQ==
Date:   Fri, 20 May 2022 14:40:52 +0200
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
Subject: Re: [PATCH v6 0/6] RZN1 USB Host support
Message-ID: <20220520144052.2f7ba2ca@bootlin.com>
In-Reply-To: <CAMuHMdWc2W1YY=EP49bQ07bO4-WqQh-MbAPr7s153VqSCxmk2w@mail.gmail.com>
References: <20220520094155.313784-1-herve.codina@bootlin.com>
        <CAMuHMdWc2W1YY=EP49bQ07bO4-WqQh-MbAPr7s153VqSCxmk2w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
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

On Fri, 20 May 2022 14:12:10 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Fri, May 20, 2022 at 11:42 AM Herve Codina <herve.codina@bootlin.com> =
wrote:
> > This series add support for the USB Host controllers available on
> > RZN1 (r9a06g032) SOC.
> >
> > These USB Host controllers are PCI OHCI/EHCI controllers located
> > behind a bridge. =20
>=20
> Thanks for your series!
>=20
> > Herve Codina (6):
> >   dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
> >   dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
> >     r9a06g032
> >   PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
> >   ARM: dts: r9a06g032: Add internal PCI bridge node
> >   ARM: dts: r9a06g032: Add USB PHY DT support
> >   ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY =20
>=20
> As I had applied v5 of the last 3 patches to renesas-devel, and they
> are already present in soc/for-next, there is no need to resend them.

Thanks. I note that for the next version of this series if needed.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
