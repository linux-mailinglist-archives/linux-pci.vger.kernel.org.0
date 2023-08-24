Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE97872A2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbjHXOzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbjHXOzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 10:55:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340219AD
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 07:55:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so106605401fa.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692888915; x=1693493715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzQfaxWKor5XYpPWiombsiXfp2BWU87Acm4Yvt7gS0k=;
        b=WtJufP+OcsiWxDCutvAK2Teedne3sS5Wv9yVdqU8AYC0UbHMdAANLVdDn6W7SWlhlT
         yx3v42ItaEphbN8U6mycGmyz8nglRaNmwhRbRzqAyvGz5orAcUoqTpSijai+NKvfoXLD
         CPN5nwazT5Eh0I0gKCdETonMDP2IxW1SCiKXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692888915; x=1693493715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzQfaxWKor5XYpPWiombsiXfp2BWU87Acm4Yvt7gS0k=;
        b=EuaCy9gWgZLOgLTnA2YPt7Ffje+7u+xOUZygKoIayW+0LnVTJAzYxbzgMScw/cw4QV
         g1pD4fmNPUFPESwTrL7NsjHxO+mE0GKe5Id0O6vFenJUqgdctg8lhBbMj8SRzAU34DZ6
         JWEUoJT+CSXbFgwldfJiUeccHfGi3OYc/VbVuA2IloCqq1IgRnZNu1KB7qZuvp3Mos2C
         kkV/BIZQKwTXHlBTnbgSe5FOXq4jC6FxCiiszDO7H9pitBwlxRHe3HcXv3Scd5HMqYSA
         tNuS+CtAIQQEX4O0cgrUF7nlrWY7ZzYk6B2Bkm9plWBB/rg8r+/9Klr7mkmAiZBAvGWB
         qm4A==
X-Gm-Message-State: AOJu0YzCcuJO3uM9n/CXuq8sZ5LzJ472rRJ8xsSc7VH2HrA4M9NKBj2J
        +KyqbUcRSU0ocM9b9MpHkNGEU7/IGPQyCColjYyTvyo24dLaVaO1NAo=
X-Google-Smtp-Source: AGHT+IFQ0wH5Nggy/TvFwKoI+aqPdUzLT7fK7WqUAIIav/xfz02YF+iBSEGa7dXyJjGsFg3mswjgUEM/F9exnEwMf6A=
X-Received: by 2002:a2e:b0db:0:b0:2bc:e470:1412 with SMTP id
 g27-20020a2eb0db000000b002bce4701412mr2167442ljl.43.1692888914923; Thu, 24
 Aug 2023 07:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230508220126.16241-1-jim2101024@gmail.com> <20230508220126.16241-2-jim2101024@gmail.com>
 <20230823074330.GF3737@thinkpad> <CA+-6iNwP+NbAdm0kNxZ5GwyPdTQyOjq7E2O-+mCU4fG-94BKBA@mail.gmail.com>
 <20230823181650.GL3737@thinkpad>
In-Reply-To: <20230823181650.GL3737@thinkpad>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 24 Aug 2023 10:55:02 -0400
Message-ID: <CA+-6iNzdYDJqwFofqkdS+iUK4w_s3eY_qa8JpbisyDn+fYg8XA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000072f32d0603ac6a94"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000072f32d0603ac6a94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 2:17=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Aug 23, 2023 at 09:09:25AM -0400, Jim Quinlan wrote:
> > On Wed, Aug 23, 2023 at 3:43=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Mon, May 08, 2023 at 06:01:21PM -0400, Jim Quinlan wrote:
> > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > >
> > > >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SO=
Cs --
> > > >   requires the driver probe() to deliberately place the HW one of t=
hree
> > > >   CLKREQ# modes:
> > > >
> > > >   (a) CLKREQ# driven by the RC unconditionally
> > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> > > >
> > > >   The HW+driver can tell the difference between downstream devices =
that
> > > >   need (a) and (b), but does not know when to configure (c).  All d=
evices
> > > >   should work fine when the driver chooses (a) or (b), but (c) may =
be
> > > >   desired to realize the extra power savings that L1SS offers.  So =
we
> > > >   introduce the boolean "brcm,enable-l1ss" property to inform the d=
river
> > > >   that (c) is desired.  Setting this property only makes sense when=
 the
> > > >   downstream device is L1SS-capable and the OS is configured to act=
ivate
> > > >   this mode (e.g. policy=3D=3Dpowersupersave).
> > > >
> > > >   This property is already present in the Raspian version of Linux,=
 but the
> > > >   upstream driver implementation that follows adds more details and
> > > >   discerns between (a) and (b).
> > > >
> > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++=
++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > @@ -64,6 +64,15 @@ properties:
> > > >
> > > >    aspm-no-l0s: true
> > > >
> > > > +  brcm,enable-l1ss:
> > > > +    description: Indicates that PCIe L1SS power savings
> > > > +      are desired, the downstream device is L1SS-capable, and the
> > > > +      OS has been configured to enable this mode.  For boards
> > > > +      using a mini-card connector, this mode may not meet the
> > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > +      of the PCI Express Mini CEM 2.0 specification.
> > >
> > > As Lorenzo said, this property doesn't belong in DT. DT is supposed t=
o specify
> > > the hardware capability and not system/OS behavior.
> >
> > The "brcm,enable-l1ss" does NOT configure the OS behavior.
> > It sets or not a mode bit to enable l1SS HW, whether or not the OS is
> > configured for L1SS.
> > It compensates for a problem in the PCIe core: the HW is not capable
> > of dynamically
> > switching between ASPM modes powersave and superpowersave.  I am active=
ly
> > advocating for our HW to change but that will take years.
> >
>
> Okay, then I would say that the property name and commit message were a b=
it
> misleading.
>
> I had briefly gone through the driver patch now. As per my understanding,=
 you
> have 2 modes in hw:
>
> 1. Clock PM - Refclk will be turned off by the host if CLKREQ# is deasser=
ted by
> the device (driving high) when the link is in L1.
>
> 2. L1SS - CLKREQ# will be used to decide L1SS entry and exit by the host.

No, there are three, as enumerated in the commit message of
"PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device"

>
> Till now the driver only supported Clock PM through mode (1) but for supp=
orting
> L1SS you need to enable mode (2). And you are using this property to sele=
ct mode
> (2) when the L1SS supported devices are connected to the slot. Also, by
> selecting this mode, you are loosing the benefit of mode (1) as both are =
not
> compatible.
>
> My suggestion would be to just drop mode (1) and use mode (2) in the driv=
er as
> most of the recent devices should support L1SS (ofc there are exemptions)=
.
The disadvantage of this, as stated by the PCIe core HW designer, was
that "doing so means
we cannot enable the Cock Power Management capability since it may run afou=
l of
the Tclron requirement."

I will attempt to press him on exactly what configurations and form
factors would be
vulnerable to this -- he was so convinced that it was a danger that he
is against
making L1SS mode the default.

>
> But moving that decision to DT still doesn't seem right to me as the hard=
ware
> supports both modes and you are (ab)using DT to choose one or the other.

May be true, but there does not appear to be a Linux upstream-acceptable
way of doing this on the command line either; please see my recent post
on why this is so.

There will be cases where we want to override the default setting, either b=
y
command line or DT, but you folks have to give me a viable path on
how to do this with it actually being accepted.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> - Mani
>
> > If this flag specifies
> > > whether the PCIe controller supports L1SS or not, then it is fine but=
 apparantly
> > > this specifies that all downstream devices are L1SS capable which you=
 cannot
> > > guarantee unless you poke into their LNKCAP during runtime.
> > Not true at all.  This setting affects only RC and whatever device is
> > connected to its single downstream
> > port.
> >
> > >
> > > You should handle this in the driver itself.
> >
> > The driver has no way of knowing if the PCI subsystem is going from pow=
er_save
> > to power_supersave or vice-versa -- there is no notification chain for =
this.  So
> > what you say is not currently possible from the driver's perspective.
> >
> > Perhaps you would be happy if we changed it to "l1ss-support" in the
> > spirit of the
> > existing "clkreq-support" PCI parameter?
> >
> > Regards,
> > Jim Quinlan
> > Broadcom STB/CMi
> >
> > >
> > > - Mani
> > >
> > > > +    type: boolean
> > > > +
> > > >    brcm,scb-sizes:
> > > >      description: u64 giving the 64bit PCIe memory
> > > >        viewport size of a memory controller.  There may be up to
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
>
> > Date: Tue, 22 Aug 2023 21:01:47 +0000 (UTC)
> > From: Florian Fainelli <messenger@webex.com>
> > To: james.quinlan@broadcom.com
> > Subject: Join me now in my Personal Room
> >
> > Hello,
> >
> > Join me now in my Personal Room.
> >
> > JOIN WEBEX MEETING
> > https://broadcom.webex.com/join/florian.fainelli  |  490 282 179
> >
> >
> > JOIN FROM A VIDEO CONFERENCING SYSTEM OR APPLICATION
> > Dial sip:florian.fainelli@broadcom.webex.com
> > You can also dial 173.243.2.68 and enter your meeting number.
> >
> >
> >
> > Can't join the meeting?
> > https://help.webex.com/docs/DOC-5412
> >
> > PHONE DIALING GUIDELINES:
> >         - Use Call Me when you are using office phone or Jabber.
> >         - Use Call Using Computer when you are at home or traveling.
> >
> > In Office Calls:
> >       - From Broadcom Office: 1-MEETING (1-6338464)
> >
> > Offsite Numbers Toll (Local) Calls:
> >       - Canada, Richmond: +1-778-308-4007
> >       - China: +86-400-819-1044
> >       - Germany, Munich: +49-892-312-9611
> >         - Germany, Regensburg: +49-(9)419-923-5940
> >         - India: 00-080-0050-1631
> >       - Israel: +97-239-786-477
> >         - Japan, Tokyo: +81-366-344-937
> >         - Malaysia: +603-2053-5189
> >       - Singapore: +65-6349-2439
> >       - South Korea, Seoul: +82-70-4732-0218
> >       - Taiwan, Taipei: +886-277-047-765
> >       - US, Denver: +1-720-726-9995
> >         - US, Los Angeles: +1-310-616-5312
> >         - US, Philadelphia: +1-215-305-7603
> >       - UK, London: +44-207-660-8897
> >         - UK, Manchester: +44-161-619-8089
> >
> > IMPORTANT NOTICE: Please note that this Webex service allows audio and =
other information sent during the session to be recorded, which may be disc=
overable in a legal matter. By joining this session, you automatically cons=
ent to such recordings. If you do not consent to being recorded, discuss yo=
ur concerns with the host or do not join the session.
>
>
>
>
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--00000000000072f32d0603ac6a94
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBJruPs6cljr1CaRjdcCsXlV572hxCt
+8NugtT/qzsbazAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjQxNDU1MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAQ4+qyQ3kyX2Yq7Glw2u26Y0R3goKIxhCdpJVtgQWl642KjIZ
4nelRRh7dp7Ub3GINZ+UCnWPf8/sJ2dvYxcFuiIM743hd7AXEPcS2R57hcyjzKZYRiW/j5YXDCex
dRrkz5YcqU7mXKn9yOWh1ikhlMaGTHAv3EpsCeODQCyhPGpVIPwD0/nulx8ba4fvo4iCDFINLj3n
C3dshIZILOf1g3tx/ZdYMlknfOkh8h+v+5LgKRb5sCBFEyeXUdKYjkGm6KNBlKMmLQ6/xSFf8X/r
BrCU8ACu5qnKMZQHXV7nGaQ8xMBWovfZ0BKbnUJiNA+7JClaMhwQYtn2IroQkFx4Ig==
--00000000000072f32d0603ac6a94--
