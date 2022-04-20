Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783645089AB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379129AbiDTNtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379127AbiDTNtD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:49:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A421E0D;
        Wed, 20 Apr 2022 06:46:15 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 930D14000D;
        Wed, 20 Apr 2022 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650462374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gu9XIPDQFJtF5X1LIwJgSFyBvY1NGDGQ+pRrZhn5KiY=;
        b=GeLia+C9QE8jie0TY69D9ZmjKetBmS0vJX/CXbcYhUD/5S8pnohoodLfUas21s2Xk40UGB
        GP8EODtmGOitGKtwEXC5VUGV1Hw8wTthv7zqLTZmQkMpPrc/v8tJwiwe7XLqcpA+ronfv/
        ix3jrqhvJX1EBYP3aMTFTfn1xfqTh/lsWDY8OC/l8sarpeyA/MBTqDIChKcA+Q6p6xLTfX
        vlGtYPICVNJMIivU0TS/QCDws6rUaUCvenJeqwx3H6Jwji9zmZ2isYF7w8IQBDAO58wi8p
        Us0mcCq7cFLJPH8AC9ZGD2igjVA4R1KJ04bPpsM4CrNND5iacJT5+wEyucCyxQ==
Date:   Wed, 20 Apr 2022 15:46:11 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRz?= =?UTF-8?B?a2k=?= 
        <kw@linux.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <20220420154611.7dd34c24@bootlin.com>
In-Reply-To: <YmAIOt1vAEzHGvBP@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-3-herve.codina@bootlin.com>
        <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
        <20220420144411.2d369b49@bootlin.com>
        <YmAIOt1vAEzHGvBP@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Wed, 20 Apr 2022 08:18:50 -0500
Rob Herring <robh@kernel.org> wrote:

...

> > > > +  bus-range:
> > > > +    description: |
> > > > +      The PCI bus number range; as this is a single bus, the range
> > > > +      should be specified as the same value twice.   =20
> > >=20
> > > items:
> > >   const: 0 =20
> >=20
> > Well, some other values are present in some dtsi files such as
> > 'bus_range =3D <1 1>;' or 'bus_range =3D <2 2>;' in r8a7742.dtsi.
> >=20
> > The constraint is to have the same value twice. Is there a way
> > to specify this constraint ? =20
>=20
> Yes, but probably not worthwhile. Just drop it as pci-bus.yaml already=20
> defines it.

Instead of fully dropping the property, don't you think that keeping
the given description here can be a way to express that the same value
is needed twice ?

>=20
> > > > +
> > > > +  "#address-cells":
> > > > +    const: 3
> > > > +
> > > > +  "#size-cells":
> > > > +    const: 2
> > > > +
> > > > +  "#interrupt-cells":
> > > > +    const: 1   =20
> > >=20
> > > All these are defined by pci-bus.yaml =20
> >=20
> > Right.
> > Replaced by:
> >=20
> > "#address-cells": true
> > "#size-cells": true
> > "#interrupt-cells": true
> >=20
> > Is that correct ? =20
>=20
> You can just drop them completely.

Ok for #address-cells and #size-cells but not for #interrupt-cells.

Dropping #interrupt-cells makes 'make dtbindings_check' unhappy:
--- 8< ---
$ make dt_binding_check DT_SCHEMA_FILES=3Drenesas,pci-rcar-gen2.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/home/hcodina/xxx/Documentation/devicetree/bindings/pci/renesas,pci-rcar-ge=
n2.yaml: properties: '#interrupt-cells' is a dependency of 'interrupt-map'
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/hcodina/xxx/Documentation/devicetree/bindings/pci/renesas,pci-rcar-ge=
n2.yaml: ignoring, error in schema: properties
  DTEX    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.examp=
le.dts
  DTC     Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.examp=
le.dtb
  CHECK   Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.examp=
le.dtb
$=20
--- 8< ---

So I keep=20
"#interrupt-cells": true

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
