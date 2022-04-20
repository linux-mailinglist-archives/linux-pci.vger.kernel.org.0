Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDBE508B4D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiDTO73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTO72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 10:59:28 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC723BFA4;
        Wed, 20 Apr 2022 07:56:40 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 696F940003;
        Wed, 20 Apr 2022 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650466599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2t76+K9/ufuuUqXnbJnz0ta26ZIOGtfR+N8Pj3Hoeqw=;
        b=E2gnkhahRyJW3qrFkTmcybpsRxoiG1YSyg+T6tCRXOshC8me6CX1EG9Hric3dInxtpVJQ9
        GBhRPYEl731GNFiN/tJvvBUQBn7kQ7kFjPqkT3aA87mNK16MuCwp51A+RIwC37j/ifuCG/
        yU3Fu33ln/dbixooeK7JdSaxkAxRdkWTyvJcqFv1N//d1yWqopb8HFIYwd1097T3uivvT3
        up2ZjgGrIChICjjsZmSJfvh3WBX7a5jVXNTWTse/HvdrqucPdQt60UfPoUbmSLRRTI4H9C
        vJuXFN5luZdSR36zXJCqlH49wvigIxYlTgNRcWpHqRCvcAm0924lij7xAPyvYg==
Date:   Wed, 20 Apr 2022 16:56:35 +0200
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
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas-pci-usb: Allow
 multiple clocks
Message-ID: <20220420165635.0d221ee6@bootlin.com>
In-Reply-To: <CAMuHMdWqVDwdyNuB3tBrWNGt7tuNOXQwqB_Un9sZYCS-6P99bA@mail.gmail.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-4-herve.codina@bootlin.com>
        <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
        <20220420150759.713fcd02@bootlin.com>
        <CAMuHMdWqVDwdyNuB3tBrWNGt7tuNOXQwqB_Un9sZYCS-6P99bA@mail.gmail.com>
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

Hi Geert,

On Wed, 20 Apr 2022 15:32:27 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Wed, Apr 20, 2022 at 3:08 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Is there a way to have the clocks description depending on the compatib=
le value. =20
>=20
> Rob already replied.
> For an example, check out the various bindings for RZ/G2L devices,
> e.g. Documentation/devicetree/bindings/net/renesas,etheravb.yaml

Yes, thanks.

>=20
> > I mean something like:
> > --- 8< ---
> > properties:
> >   clocks:
> >     maxItems: 1
> >
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - renesas,pci-r9a06g032
> >           - renesas,pci-rzn1 =20
>=20
> Checking only for the second compatible value should be sufficient.

Ok, changed.

Regards,
Herv=C3=A9
