Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2931D785B0A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjHWOs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjHWOs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 10:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC36E69;
        Wed, 23 Aug 2023 07:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7C5635B5;
        Wed, 23 Aug 2023 14:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB62C43397;
        Wed, 23 Aug 2023 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692802135;
        bh=/mIR/BoeNsGIQ35vEJiMSnGRE9NkIijQbN8TMPht8lA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JBv45U/ckigIhCoTgbnPxY3Ny4JXMfYMJCeyqcKL7v+4wHcK/eJQ9W+ASwoffbDAh
         spSkMl0KWiaQ6cPaocfiphUqOrcmQ7vSO2Ej39BAIP0+vH/R22Go282M7Ey8r3tWHv
         e3aa6Fjmlb1Ki1fJ2MCLJePdWG2gdv5kwfQPoKhbRJbyygnUwfb/eXr6BTyDTnvQ+Y
         PwuKQBDRYU+JMnhe7ZoI89O4xb7Q6sFGHsm68tsuvX4Ddx1bp1aRq5ZRqE0plciE+i
         Cggq1nw3xI4wQpGBYT3vXwj92L878Dfahl8lIf2gzZ5Pr9YC8whpYgA87LqaXoYdeL
         SKgVCvl3TrrHQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso87672951fa.0;
        Wed, 23 Aug 2023 07:48:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyvc/SE3nMCj82UfZIxXqFcYiA2y16rRgrDk7AnZ6EBUtowYXwS
        3drAU9fN8QmmeGwi9ECGZ52Brv7CIfPYmj5BrQ==
X-Google-Smtp-Source: AGHT+IHMstTvKJFQFHSGfZa/sGOrQBVC6gBZtEcBjOgKF3HFClPHqsTsD0J+JzNdiJCbkccX59siSGCFrcffdxYYF1A=
X-Received: by 2002:a2e:978c:0:b0:2bc:bb3e:1abe with SMTP id
 y12-20020a2e978c000000b002bcbb3e1abemr7588725lji.41.1692802133206; Wed, 23
 Aug 2023 07:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com> <ZON43rPGJGzjTTj/@lpieralisi>
 <CA+-6iNwRGsnRsT9R=iEzaJNCTLu_pQNG4x+noE8bqLYCRm_PHQ@mail.gmail.com>
 <ZOOFrqkAdW5d6WIj@lpieralisi> <CA+-6iNzZCFs_gQGqa8KAcBM6etFc=vAFoqFmde=xru2-O+F3_w@mail.gmail.com>
 <ZOW1qDmTdy+8KODt@lpieralisi>
In-Reply-To: <ZOW1qDmTdy+8KODt@lpieralisi>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Aug 2023 09:48:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSfKa=9nqzpdv0TVcik73_xTJ-LtBycDfFZiGkz2mDNQ@mail.gmail.com>
Message-ID: <CAL_JsqJSfKa=9nqzpdv0TVcik73_xTJ-LtBycDfFZiGkz2mDNQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 2:30=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Mon, Aug 21, 2023 at 12:01:50PM -0400, Jim Quinlan wrote:
> > On Mon, Aug 21, 2023 at 11:41=E2=80=AFAM Lorenzo Pieralisi
> > <lpieralisi@kernel.org> wrote:
> > >
> > > On Mon, Aug 21, 2023 at 11:25:11AM -0400, Jim Quinlan wrote:
> > > > On Mon, Aug 21, 2023 at 10:47=E2=80=AFAM Lorenzo Pieralisi
> > > > <lpieralisi@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
> > > > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > > > >
> > > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RP=
i SOCs --
> > > > > >   requires the driver probe() to deliberately place the HW one =
of three
> > > > > >   CLKREQ# modes:
> > > > > >
> > > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > > > >
> > > > > >   The HW+driver can tell the difference between downstream devi=
ces that
> > > > > >   need (a) and (b), but does not know when to configure (c).  A=
ll devices
> > > > > >   should work fine when the driver chooses (a) or (b), but (c) =
may be
> > > > > >   desired to realize the extra power savings that L1SS offers. =
 So we
> > > > > >   introduce the boolean "brcm,enable-l1ss" property to inform t=
he driver
> > > > > >   that (c) is desired.  Setting this property only makes sense =
when the
> > > > > >   downstream device is L1SS-capable and the OS is configured to=
 activate
> > > > > >   this mode (e.g. policy=3D=3Dpowersupersave).
> > > > > >
> > > > > >   This property is already present in the Raspian version of Li=
nux, but the
> > > > > >   upstream driver implementation that follows adds more details=
 and
> > > > > >   discerns between (a) and (b).
> > > > > >
> > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +=
++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pci=
e.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > @@ -64,6 +64,15 @@ properties:
> > > > > >
> > > > > >    aspm-no-l0s: true
> > > > > >
> > > > > > +  brcm,enable-l1ss:
> > > > > > +    description: Indicates that PCIe L1SS power savings
> > > > > > +      are desired, the downstream device is L1SS-capable, and =
the
> > > > > > +      OS has been configured to enable this mode.  For boards
> > > > >
> > > > > What does this mean ? I don't think DT properties are supposed
> > > > > to carry information related to how the OS is configured.
> > > >
> > > > The DT setting in question is unrelated to the statement "and the O=
S
> > > > has been configured to
> > > > enable this mode".
> > > >
> > > > This is merely saying that even if you enable "brcm,l1ss-enable"
> > > > that you may not get L1SS power savings w/o setting
> > > > "CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy".
> > > > I mentioned that exact term but a reviewer nakked it because
> > > > apparently DT descriptions should not be OS specific.

Yeah, probably the OS part should be dropped.

> > > >
> > > > I am actually open for this to be a command-line option but I wante=
d to honor
> > > > what the Raspian OS folks have already done.  RaspianOS already has
> > > > "brcm,enable-l1ss"
> > > > set in their DTS files.
> > >
> > > This is about the mainline kernel, I don't have any visibility into
> > > downstream kernels (where that property management was added without =
DT
> > > and PCI maintainers supervision).
> > >
> > > Raspian OS folks' choice is theirs but it can't and it shouldn't over=
ride
> > > the mainline review process even though I understand the position you
> > > are in.

Sure, but we shouldn't change things just to be different from
downstream. If we're only discussing the color of the shed, then no
point changing it.

> >
> > Understood, but using the command line has its warts as well; I now rec=
all the
> > discussion Bjorn and I  had regarding this option.  I'm pretty sure
> > that upstreaam will not allow the following
> > possible command line kernel params:
> >
> >     brcm,enable-l1ss
> >     pci=3Dbrcm,entable-l1ss
> >
> > Bjorn suggested using the  documented but (IMO) obscure  and  rarely
> > used  format
> >
> >     pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<de=
vice>[:<subvendor>:<subdevice>]
> >
> > but this is just going in the wrong direction; here's why.  Using the
> > above iformat s completely dependent on the
> > PCI "linux-domaiin"  property,  a non-HW related DT property I  might
> > add.  Since "linux-domain" is already
> > a valid and well-used  DT property, and the value of  the above
> > command line format is dependent
> > on the value of the "linux-domain", why not be consistent and let
> > "brcm,enable-l1ss" be a Broadcom specific property?
>
> I am just asking to add a module_param to the host controller driver.

FWIW, gregkh pretty much always nacks new module parameters.

>
> Anyway - time is running out for v6.6, I need Rob's feedback, if I don't
> hear from him today I will merge the last three patches and postpone the
> discussion.

You've already got my reviewed-by. If you aren't happy with this, then
fine. I don't know enough about L1SS to comment further. Is it
normally always supported or discoverable? If so, then I'd think we'd
want it default enabled with a disable override flag. Maybe it should
be generic?

Rob
