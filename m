Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7A782DB1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHUQCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHUQCG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 12:02:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C91DB
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 09:02:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so60872751fa.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692633723; x=1693238523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sU1yQ4F8ylbe+4+a+p5YYmrleqj/vk+bVGtJilHpjYw=;
        b=HGiG1fXxKHHYZfc1rEIHEnsmPV6XDCSV27QQCrk0ZO7gieIGIR51Or5HA6Oom4KWbm
         lkTDSP7fekAZldXKC90eVicj1ZR8gWEC9jM/IW0IZMBScJjXmBuFWTBJJVWWwyYDADqF
         xQ+REaXVRkIN+NCZfCtGnVSF6OV0KBsvYM5Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692633723; x=1693238523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU1yQ4F8ylbe+4+a+p5YYmrleqj/vk+bVGtJilHpjYw=;
        b=gFmpVH0QYAa1RRMsCV3HkmgFnH2jFNcyXn5kRfzQayNptHO+dFCTgyls6zmpGsS5t/
         zNRmpxSWISsuO4JRtnpQpbcAkTaFUb6tYctkcX7JyC8SNQsA8JYxpWj5X7jEdnlRWwIZ
         XyrgqcC8ii+7Cp+qPxv+fkUEO702+8c7Zsfa/b1c70C5KTjJdUudEFLgsP1nzAbM5IO1
         LSrcMkzynh1xd44zlcVGwup9azeMggydn3MDYOwMv8nVZaNF76RNzo3t/ayqyh5DT187
         8K2y57gIec4JbbWMFmIPUU8ccZGaaljBYzrvowSzfjQzOA+GEoP9ODGsLxaxzUKvcS/l
         UBgg==
X-Gm-Message-State: AOJu0YzgwkSdEIow6xK3F5uMc9Nkqi49AOYccCiI+uVVSiWCGh1+I4tn
        IvMVnZsWkPBplMrL62UuQPQ8HNCFioMe9VaNdqTUWQ==
X-Google-Smtp-Source: AGHT+IHziMQLa/YiGp9HUcsEiZ+jqXGmgyAaGl+P4xeOfF8QGERn1P9FV9hy1XxJmSN2njvW02SJsSyn0lW6a25cEKM=
X-Received: by 2002:a2e:988d:0:b0:2b9:4413:864e with SMTP id
 b13-20020a2e988d000000b002b94413864emr5171554ljj.53.1692633722992; Mon, 21
 Aug 2023 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com> <ZON43rPGJGzjTTj/@lpieralisi>
 <CA+-6iNwRGsnRsT9R=iEzaJNCTLu_pQNG4x+noE8bqLYCRm_PHQ@mail.gmail.com> <ZOOFrqkAdW5d6WIj@lpieralisi>
In-Reply-To: <ZOOFrqkAdW5d6WIj@lpieralisi>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 21 Aug 2023 12:01:50 -0400
Message-ID: <CA+-6iNzZCFs_gQGqa8KAcBM6etFc=vAFoqFmde=xru2-O+F3_w@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: PCI: brcmstb: Add brcm,enable-l1ss property
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
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
        boundary="000000000000d26438060370ff84"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000d26438060370ff84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 11:41=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Mon, Aug 21, 2023 at 11:25:11AM -0400, Jim Quinlan wrote:
> > On Mon, Aug 21, 2023 at 10:47=E2=80=AFAM Lorenzo Pieralisi
> > <lpieralisi@kernel.org> wrote:
> > >
> > > On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
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
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
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
> > >
> > > What does this mean ? I don't think DT properties are supposed
> > > to carry information related to how the OS is configured.
> >
> > The DT setting in question is unrelated to the statement "and the OS
> > has been configured to
> > enable this mode".
> >
> > This is merely saying that even if you enable "brcm,l1ss-enable"
> > that you may not get L1SS power savings w/o setting
> > "CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy".
> > I mentioned that exact term but a reviewer nakked it because
> > apparently DT descriptions should not be OS specific.
> >
> > I am actually open for this to be a command-line option but I wanted to=
 honor
> > what the Raspian OS folks have already done.  RaspianOS already has
> > "brcm,enable-l1ss"
> > set in their DTS files.
>
> This is about the mainline kernel, I don't have any visibility into
> downstream kernels (where that property management was added without DT
> and PCI maintainers supervision).
>
> Raspian OS folks' choice is theirs but it can't and it shouldn't override
> the mainline review process even though I understand the position you
> are in.

Understood, but using the command line has its warts as well; I now recall =
the
discussion Bjorn and I  had regarding this option.  I'm pretty sure
that upstreaam will not allow the following
possible command line kernel params:

    brcm,enable-l1ss
    pci=3Dbrcm,entable-l1ss

Bjorn suggested using the  documented but (IMO) obscure  and  rarely
used  format

    pci=3D[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*pci:<vendor>:<device=
>[:<subvendor>:<subdevice>]

but this is just going in the wrong direction; here's why.  Using the
above iformat s completely dependent on the
PCI "linux-domaiin"  property,  a non-HW related DT property I  might
add.  Since "linux-domain" is already
a valid and well-used  DT property, and the value of  the above
command line format is dependent
on the value of the "linux-domain", why not be consistent and let
"brcm,enable-l1ss" be a Broadcom specific property?

Regards,
Jim Quinlan
Broadcom STB/CM


>
> Thanks,
> Lorenzo
>
> >
> > Regards,
> > Jim
> >
> > > Again - it depends on what DT should be used for, I am not claiming t=
o
> > > have any authority on that, just asking.
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > +      using a mini-card connector, this mode may not meet the
> > > > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > > > +      of the PCI Express Mini CEM 2.0 specification.
> > > > +    type: boolean
> > > > +
> > > >    brcm,scb-sizes:
> > > >      description: u64 giving the 64bit PCIe memory
> > > >        viewport size of a memory controller.  There may be up to
> > > > --
> > > > 2.17.1
> > > >
> > >
> > >
>
>

--000000000000d26438060370ff84
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB6Y8rsMs471BJ1KZtmMdSkOkLtDHUz
AHiEm3obf0iHRjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjExNjAyMDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEABAK7VWQuf0Gfv5YmIboqhEMvHGhnzuS1sL0mBpTA+Y98ATYn
XvkYk+CzrhCe73oBHl0KkNthbEmg4cBVmR0UK9qSo9wD4Ww2l9ouQWIIelYURSsc3BTCDTvXyk3t
1ahjernGV+EuYAy5V4yQpF86RWl5Me43bNwDqQrQdwHJX0RjNDr2yXiUfTUqCJJoeCUQO/YK5/p/
9iwwCQjBHxorvAKNKSOpOvcA0kT/rn/RaC/jbEJWba8DuTAPcdk8I9wXz7D8H+vEEn8OaH1AlKKq
BsSNmeSZta6pGHq6g74abHVBhfNoHkHFrPTqTC6Bo5nnc8Rjidd5xkmDbyLA9HicNA==
--000000000000d26438060370ff84--
