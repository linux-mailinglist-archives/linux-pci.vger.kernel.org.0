Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2D7873F1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjHXPUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbjHXPTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:19:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185819B7
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 08:19:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so108811491fa.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692890390; x=1693495190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fOCKwQH9CRnsJk09hYL2WjfWpjZooogdJb4bk2XLs8E=;
        b=LiaL8K/KHzDkwz0hmE2q8+O6bxkgAj+OPAIX8F2nTeP/aqe0XlzlDmHX+SIxETYsYV
         A+c+mOUtrBLbmt/7n+3Zd0zfkUAR4GXHjtzU+oy/9xxjXjvDDg+l2OlaJZU/VoIuoEp4
         98tgI1wKD0QRVahSGyjT/oopMiRi6Y7pXIufE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890390; x=1693495190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOCKwQH9CRnsJk09hYL2WjfWpjZooogdJb4bk2XLs8E=;
        b=IH5AXVvY017qSQz2FSv3unlgOeodHFstb5Xdkv54/I3s1vhadhW6fB6Lh9YKx5LXFH
         1hSSd+X15YXJytyA1ZKRxDexo+ik5OZ72/UIaqta9NCJLOFDwBjO5p2AfZfcRfm0B/8a
         XQX93PXoXR36e+WET8FgjNMjGC4nZLXDBUX704RdBGkVY+gvvhG7YcZW8uXI90DorDRL
         4bAPQtH5NvveorhkcRmzET8XtF9z/ial/rAu1ZFEK0tkZAHiKnui6IuYDX5HVBvw6HL/
         M7f8jW/qWSDKnANzKXjwPU1ATXw7Nmxmjb4QeCxkvAip9rAdtn5o54PXRxgmCh31ApsS
         LGtQ==
X-Gm-Message-State: AOJu0YxXlNxGVnDH1w0a2SFEMLU4jBy+Q6/FH/8SoQVsirenQ0S5JtKn
        MaQSfATD0q7IAzvM9ncniH776LQv6FpBhOBLdb1Ysg==
X-Google-Smtp-Source: AGHT+IEzVPJxw3s9jnpvO1c8I2AE1vJa7MGwjTxjoMEFDMbzAYFaulfI6m8NEGyrrNv3mRJWn/+Fw0XQIBuxDbsrRKY=
X-Received: by 2002:a05:651c:1027:b0:2b6:bc30:7254 with SMTP id
 w7-20020a05651c102700b002b6bc307254mr11362163ljm.13.1692890389999; Thu, 24
 Aug 2023 08:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com> <ZON43rPGJGzjTTj/@lpieralisi>
 <CA+-6iNwRGsnRsT9R=iEzaJNCTLu_pQNG4x+noE8bqLYCRm_PHQ@mail.gmail.com>
 <ZOOFrqkAdW5d6WIj@lpieralisi> <CA+-6iNzZCFs_gQGqa8KAcBM6etFc=vAFoqFmde=xru2-O+F3_w@mail.gmail.com>
 <ZOW1qDmTdy+8KODt@lpieralisi> <CAL_JsqJSfKa=9nqzpdv0TVcik73_xTJ-LtBycDfFZiGkz2mDNQ@mail.gmail.com>
 <ZOYz1BSwSb6NTPUr@lpieralisi> <20230823182628.GM3737@thinkpad>
In-Reply-To: <20230823182628.GM3737@thinkpad>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 24 Aug 2023 11:19:38 -0400
Message-ID: <CA+-6iNznDk8G-0WvNpTJ56Ueh0GdNZBySdHPXFCwngzw9grFNg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005e76110603acc285"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000005e76110603acc285
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 2:26=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Aug 23, 2023 at 06:29:08PM +0200, Lorenzo Pieralisi wrote:
> > On Wed, Aug 23, 2023 at 09:48:40AM -0500, Rob Herring wrote:
> > > On Wed, Aug 23, 2023 at 2:30=E2=80=AFAM Lorenzo Pieralisi <lpieralisi=
@kernel.org> wrote:
> > > >
> > > > On Mon, Aug 21, 2023 at 12:01:50PM -0400, Jim Quinlan wrote:
> > > > > On Mon, Aug 21, 2023 at 11:41=E2=80=AFAM Lorenzo Pieralisi
> > > > > <lpieralisi@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 21, 2023 at 11:25:11AM -0400, Jim Quinlan wrote:
> > > > > > > On Mon, Aug 21, 2023 at 10:47=E2=80=AFAM Lorenzo Pieralisi
> > > > > > > <lpieralisi@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote=
:
> > > > > > > > > This commit adds the boolean "brcm,enable-l1ss" property:
> > > > > > > > >
> > > > > > > > >   The Broadcom STB/CM PCIe HW -- a core that is also used=
 by RPi SOCs --
> > > > > > > > >   requires the driver probe() to deliberately place the H=
W one of three
> > > > > > > > >   CLKREQ# modes:
> > > > > > > > >
> > > > > > > > >   (a) CLKREQ# driven by the RC unconditionally
> > > > > > > > >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> > > > > > > > >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1=
SS).
> > > > > > > > >
> > > > > > > > >   The HW+driver can tell the difference between downstrea=
m devices that
> > > > > > > > >   need (a) and (b), but does not know when to configure (=
c).  All devices
> > > > > > > > >   should work fine when the driver chooses (a) or (b), bu=
t (c) may be
> > > > > > > > >   desired to realize the extra power savings that L1SS of=
fers.  So we
> > > > > > > > >   introduce the boolean "brcm,enable-l1ss" property to in=
form the driver
> > > > > > > > >   that (c) is desired.  Setting this property only makes =
sense when the
> > > > > > > > >   downstream device is L1SS-capable and the OS is configu=
red to activate
> > > > > > > > >   this mode (e.g. policy=3D=3Dpowersupersave).
> > > > > > > > >
> > > > > > > > >   This property is already present in the Raspian version=
 of Linux, but the
> > > > > > > > >   upstream driver implementation that follows adds more d=
etails and
> > > > > > > > >   discerns between (a) and (b).
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml=
 | 9 +++++++++
> > > > > > > > >  1 file changed, 9 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,s=
tb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > > > > > index 7e15aae7d69e..8b61c2179608 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie=
.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie=
.yaml
> > > > > > > > > @@ -64,6 +64,15 @@ properties:
> > > > > > > > >
> > > > > > > > >    aspm-no-l0s: true
> > > > > > > > >
> > > > > > > > > +  brcm,enable-l1ss:
> > > > > > > > > +    description: Indicates that PCIe L1SS power savings
> > > > > > > > > +      are desired, the downstream device is L1SS-capable=
, and the
> > > > > > > > > +      OS has been configured to enable this mode.  For b=
oards
> > > > > > > >
> > > > > > > > What does this mean ? I don't think DT properties are suppo=
sed
> > > > > > > > to carry information related to how the OS is configured.
> > > > > > >
> > > > > > > The DT setting in question is unrelated to the statement "and=
 the OS
> > > > > > > has been configured to
> > > > > > > enable this mode".
> > > > > > >
> > > > > > > This is merely saying that even if you enable "brcm,l1ss-enab=
le"
> > > > > > > that you may not get L1SS power savings w/o setting
> > > > > > > "CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy".
> > > > > > > I mentioned that exact term but a reviewer nakked it because
> > > > > > > apparently DT descriptions should not be OS specific.
> > >
> > > Yeah, probably the OS part should be dropped.
> >
> > I will drop it - if you don't mind.
> >
> > > > > > > I am actually open for this to be a command-line option but I=
 wanted to honor
> > > > > > > what the Raspian OS folks have already done.  RaspianOS alrea=
dy has
> > > > > > > "brcm,enable-l1ss"
> > > > > > > set in their DTS files.
> > > > > >
> > > > > > This is about the mainline kernel, I don't have any visibility =
into
> > > > > > downstream kernels (where that property management was added wi=
thout DT
> > > > > > and PCI maintainers supervision).
> > > > > >
> > > > > > Raspian OS folks' choice is theirs but it can't and it shouldn'=
t override
> > > > > > the mainline review process even though I understand the positi=
on you
> > > > > > are in.
> > >
> > > Sure, but we shouldn't change things just to be different from
> > > downstream. If we're only discussing the color of the shed, then no
> > > point changing it.
> >
> > Sure, no problem.
> >
> > > > > Understood, but using the command line has its warts as well; I n=
ow recall the
> > > > > discussion Bjorn and I  had regarding this option.  I'm pretty su=
re
> > > > > that upstreaam will not allow the following
> > > > > possible command line kernel params:
> > > > >
> > > > >     brcm,enable-l1ss
> > > > >     pci=3Dbrcm,entable-l1ss
> > > > >
> > > > > Bjorn suggested using the  documented but (IMO) obscure  and  rar=
ely
> > > > > used  format
> > > > >
> > > > >     pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendo=
r>:<device>[:<subvendor>:<subdevice>]
> > > > >
> > > > > but this is just going in the wrong direction; here's why.  Using=
 the
> > > > > above iformat s completely dependent on the
> > > > > PCI "linux-domaiin"  property,  a non-HW related DT property I  m=
ight
> > > > > add.  Since "linux-domain" is already
> > > > > a valid and well-used  DT property, and the value of  the above
> > > > > command line format is dependent
> > > > > on the value of the "linux-domain", why not be consistent and let
> > > > > "brcm,enable-l1ss" be a Broadcom specific property?
> > > >
> > > > I am just asking to add a module_param to the host controller drive=
r.
> > >
> > > FWIW, gregkh pretty much always nacks new module parameters.
> >
> > Fine by me.
> >
> > > > Anyway - time is running out for v6.6, I need Rob's feedback, if I =
don't
> > > > hear from him today I will merge the last three patches and postpon=
e the
> > > > discussion.
> > >
> > > You've already got my reviewed-by. If you aren't happy with this, the=
n
> > > fine. I don't know enough about L1SS to comment further. Is it
> > > normally always supported or discoverable? If so, then I'd think we'd
> > > want it default enabled with a disable override flag. Maybe it should
> > > be generic?
> >
> > It is not that I am not happy with it - we asked questions to understan=
d
> > what this property was for, I think that's normal.
> >
> > I will merge this series as-is.
> >
>
> There is a discussion ongoing here: https://lore.kernel.org/linux-pci/202=
30823181650.GL3737@thinkpad/T/#u
>
> Can you please hold on to merging this series until we've reached a concl=
usion?
 (2) There are odd boards out there which

TL;DR:  I'm okay with postponing the two clkreq# commits.

Sigh.  I really wish we had this discussion months ago when this
series was submitted.

I do think the best -- but not perfect -- way to do this is with a DT
param.  AFAICT there
is no way to do this with a command line param with it being accepted,
module_param or otherwise; please see
my reasons from this thread.  Also, Rob just said that GregH will
probably reject a new module_param
anyway.

That being said, the recent discussions are insightful and have me
reconsidering having
the "l1ss mode" be the default -- it has certainly worked well for the
RaspianOS folks.
That being said, the RaspianOS folks do not experience the flavor of
form-factors and devices
as Broadcom STB, and the admonitions of our HW designer are of great
concern to me.

In light of the above I am okay with postponing the two clkreq-related
commits to avoid any missteps.

Regards,
Jim

>
> - Mani
>
> > Lorenzo
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--0000000000005e76110603acc285
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBOoYPHfF00uhZHbDhPUsnZhNYxv3k0
jhCMqGhMGCsQtDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjQxNTE5NTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAg5MffSbOMZAIX5FjBLfhb0kiifoV0mVGOy4jyNv+HS6A955Z
Ai7S8APLFIr1F2IxgaXYc3uYCvOeRdeP8xAPzSvikBz2WLzx97vhVRP1SS1l1NZlgGK1foWtyTpf
npqirtzwZJy7oVwaKFWMvXE7GBwhLgVVTeMcYeIqcrAOMkKTlVkpP9B83R/dB3PDFKc7JwQeF7+U
H+PlRYHsfvGm+lsqB1irEo7xYqCRsG3TvXAKm12Z6OnXUS4vZXn1w2FU1gpnxLE7sLgspYdXhnaB
SV6ARhcqlNYli6uwqUYFy0Ui2ZTnSnRrmX0UM1QQ61kty2IcsTUCiJ4R+qlzrcgDSA==
--0000000000005e76110603acc285--
