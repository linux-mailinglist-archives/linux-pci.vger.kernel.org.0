Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413A1512F49
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiD1JLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiD1JLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:11:37 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB453E19;
        Thu, 28 Apr 2022 02:08:21 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BD0C824000C;
        Thu, 28 Apr 2022 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651136900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZaVxd+2WjygVQXWswdisAkNx+oA7fl9OUz2pidyb4k=;
        b=M9NQEgqxVS+N0oyyjs4W4Whgk+JUc7I5Mfy1xvbtI9cZ6obYaEXP6mqwwDvcbuwULXvquQ
        7mwoiCOmTjWbeoYn8PQKndMWvWDBVUdlb+5ezUH26//GxEhuBCZn5VswA09Kw0xhGNxA4J
        9jCKV/zOSETAqDJQbqmEFBnRm9YcdSjqhbU6ozCZzBRWz6vEuIB2B8qMWmvt4jug2XL2c3
        mUNTarLAOxOATtEo/qk6AuwGbrelDf5RhXS1awQqX4wo0H/IW3jwucBaXR9TeWztDdDkfv
        8f/W7ARWVQR+kx9IjVZsNw/xHaL5Cdjzx5xZ24Sz3MdlaZ57cmswJxjmhoHgBg==
Date:   Thu, 28 Apr 2022 11:08:17 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v3 2/8] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <20220428110817.07ce92a6@bootlin.com>
In-Reply-To: <CAMuHMdVB2-Sv1AWFr43erOioui0me5A4TfvazKHp9hTF3gJCwg@mail.gmail.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-3-herve.codina@bootlin.com>
        <CAMuHMdVB2-Sv1AWFr43erOioui0me5A4TfvazKHp9hTF3gJCwg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

On Wed, 27 Apr 2022 17:15:15 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Add internal PCI bridge support for the r9a06g032 SOC. The Renesas
> > RZ/N1D (R9A06G032) internal PCI bridge is compatible with the one
> > present in the R-Car Gen2 family.
> > Compared to the R-Car Gen2 family, it needs three clocks instead of
> > one.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> > @@ -113,6 +113,37 @@ required:
> >    - "#size-cells"
> >    - "#interrupt-cells"
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - renesas,pci-rzn1
> > +
> > +then:
> > +  properties:
> > +    clocks:
> > +      items:
> > +        - description: Internal bus clock (AHB) for HOST
> > +        - description: Internal bus clock (AHB) Power Management
> > +        - description: PCI clock for USB subsystem
> > +    clock-names:
> > +      items:
> > +        - const: hclk_usbh
> > +        - const: hclk_usbpm
> > +        - const: clk_pci_usb =20
>=20
> These are the provider names.
> I think they should use the consumer names: usb_hclkh, usb_hclkpm,
> and usb_pciclk.

Yes, it makes sense.
I will changed in v4.

>=20
> The rest looks good to me.

Perfect.

Thanks for the review,
Herv=C3=A9


--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
