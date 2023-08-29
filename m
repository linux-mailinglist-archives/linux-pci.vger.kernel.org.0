Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3D78C42E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjH2MXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjH2MWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0A1AD;
        Tue, 29 Aug 2023 05:22:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B128D60CEB;
        Tue, 29 Aug 2023 12:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CA1C4339A;
        Tue, 29 Aug 2023 12:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693311753;
        bh=uQuaYIB4sU5KwDNBNkA9c04Xl27HjpPIxCCpei4eg7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gAp1ImS6zakziOlcVcii0p7SK+9R2sa6F7DDbDkHwXlqMI5ZmhzmoYp1dqTXzGKQs
         d3T68KZ5ZFoiISAO94SfOXN0mv7+E0nK8tPr3ST+9YeWqCC0UvGo0ETCaky+6JuZvn
         RF+0B4x99xXlN3wPW+DNjkorbUAJM3/cBJcsgrRQ28zGLHVU0ZqzPz7R8WeXuNQYGW
         gpIVuJyTnlRgtgPUS+28ayMf0HY9e8eTxJjmODE++hyDL8OExykJ7f6QECzYA8NjnX
         vF1kuXX5eGDhbx7GT83HaRznE1qVpAOIs0CujFRT9bamZo3TccYAtoynU/eE9XVMjm
         7wUQlrVLV9GPQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso63839421fa.1;
        Tue, 29 Aug 2023 05:22:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxar3I7krMjVpA/2Euvp2+BE2arlfqpPCuHohKv+6hj5dXp60Zk
        RUwCuE6AGHk50Gvk+y/KPFM5w/Osi+J0LLZBtg==
X-Google-Smtp-Source: AGHT+IHTt12qfjnBh6YpSohgrKh3Mpwx5E9gfGxlMWfSA05Iwyx3ix65QZdIGF2dpi8KG3hvkypQi5vkQ16ycL4VuyM=
X-Received: by 2002:a2e:aaa7:0:b0:2bd:124a:23d5 with SMTP id
 bj39-20020a2eaaa7000000b002bd124a23d5mr3174909ljb.11.1693311750978; Tue, 29
 Aug 2023 05:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230508220126.16241-1-jim2101024@gmail.com> <20230508220126.16241-2-jim2101024@gmail.com>
 <20230823074330.GF3737@thinkpad> <CA+-6iNwP+NbAdm0kNxZ5GwyPdTQyOjq7E2O-+mCU4fG-94BKBA@mail.gmail.com>
 <20230823181650.GL3737@thinkpad> <CA+-6iNzdYDJqwFofqkdS+iUK4w_s3eY_qa8JpbisyDn+fYg8XA@mail.gmail.com>
 <20230825064505.GA6005@thinkpad>
In-Reply-To: <20230825064505.GA6005@thinkpad>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Aug 2023 07:22:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK7LBLVrw9mF6ksrc70gikbjQe7EAYfLytoVySKxvTd=w@mail.gmail.com>
Message-ID: <CAL_JsqK7LBLVrw9mF6ksrc70gikbjQe7EAYfLytoVySKxvTd=w@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
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

On Fri, Aug 25, 2023 at 1:45=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, Aug 24, 2023 at 10:55:02AM -0400, Jim Quinlan wrote:
> > On Wed, Aug 23, 2023 at 2:17=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 09:09:25AM -0400, Jim Quinlan wrote:
> > > > On Wed, Aug 23, 2023 at 3:43=E2=80=AFAM Manivannan Sadhasivam <mani=
@kernel.org> wrote:
> > > > >
> > > > > On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
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
> > > > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
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
> > > > > > +      using a mini-card connector, this mode may not meet the
> > > > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > > > +      of the PCI Express Mini CEM 2.0 specification.
> > > > >
> > > > > As Lorenzo said, this property doesn't belong in DT. DT is suppos=
ed to specify
> > > > > the hardware capability and not system/OS behavior.
> > > >
> > > > The "brcm,enable-l1ss" does NOT configure the OS behavior.
> > > > It sets or not a mode bit to enable l1SS HW, whether or not the OS =
is
> > > > configured for L1SS.
> > > > It compensates for a problem in the PCIe core: the HW is not capabl=
e
> > > > of dynamically
> > > > switching between ASPM modes powersave and superpowersave.  I am ac=
tively
> > > > advocating for our HW to change but that will take years.
> > > >
> > >
> > > Okay, then I would say that the property name and commit message were=
 a bit
> > > misleading.
> > >
> > > I had briefly gone through the driver patch now. As per my understand=
ing, you
> > > have 2 modes in hw:
> > >
> > > 1. Clock PM - Refclk will be turned off by the host if CLKREQ# is dea=
sserted by
> > > the device (driving high) when the link is in L1.
> > >
> > > 2. L1SS - CLKREQ# will be used to decide L1SS entry and exit by the h=
ost.
> >
> > No, there are three, as enumerated in the commit message of
> > "PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream dev=
ice"
> >
>
> Yeah, another one is refclk always on.
>
> > >
> > > Till now the driver only supported Clock PM through mode (1) but for =
supporting
> > > L1SS you need to enable mode (2). And you are using this property to =
select mode
> > > (2) when the L1SS supported devices are connected to the slot. Also, =
by
> > > selecting this mode, you are loosing the benefit of mode (1) as both =
are not
> > > compatible.
> > >
> > > My suggestion would be to just drop mode (1) and use mode (2) in the =
driver as
> > > most of the recent devices should support L1SS (ofc there are exempti=
ons).
> > The disadvantage of this, as stated by the PCIe core HW designer, was
> > that "doing so means
> > we cannot enable the Cock Power Management capability since it may run =
afoul of
> > the Tclron requirement."
> >
>
> Ok.
>
> > I will attempt to press him on exactly what configurations and form
> > factors would be
> > vulnerable to this -- he was so convinced that it was a danger that he
> > is against
> > making L1SS mode the default.
> >
>
> Hmm. After looking at this problem in detail, it looks to me that you can=
 still
> use DT but not with the property you proposed. Since these are hardware m=
odes,
> you can have a single DT property that specifies the mode that the driver=
 can
> use to configure the hw. It is similar to "phy-mode" property we have for=
 the
> network controllers.
>
> So you should have the property defined as below in binding:
>
> brcm,clkreq-mode:
>   $ref: /schemas/types.yaml#/definitions/uint32
>   enum: [ 0, 1, 2 ]

Is this really Broadcom specific?

Rob
