Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E9782D2F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbjHUPZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 11:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHUPZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 11:25:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E99F1
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 08:25:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5080496e87.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692631523; x=1693236323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E0sz3cRRpYeYgp9Wfhd4OZBNA7lkRBy6XkHlrSTuJ1Y=;
        b=P81849KCnVmP7DNKlx75H70pq3HCGVEJGhAtegQwJd5ZXTpmY3tzUUs87PQUmOHaU5
         2+c1gDI0u3qOpP2h5qIvuCtRULKEh8w2p2ngoIZZMxBd+eDZpTXG39Tyof6umLNvHCUb
         7CYRf82q4FXCb3nPmmwD7aRFEdqOMSaag5MLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631523; x=1693236323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0sz3cRRpYeYgp9Wfhd4OZBNA7lkRBy6XkHlrSTuJ1Y=;
        b=i4pWz603faYC6xGcFdoCbUdZQjIj5niTjzDniSTOZ7I8uVBw4nrddMTG+nThYa5PhS
         F1ZqfYxjifxLeihexfKnTjI37MXCvya852lUjBQqCqCIULZ7bQrwjuVzkGBQXS9C3JkA
         IdtZqYxw5mSt+CkBbhxHcPFYdzKoTULekp6L7BlHtKloDYzvJxIIVXkJeRPjeJrW7R52
         5gSkPygsYXZbYOk11JC6mDx3lGNBQ+SX4f9mCSBqG66cCN/16/8yElEzGktDCnAiIHVi
         DzaYe6llyapO4okNy+cJmNonPR/7pfFGKKlbFsnnaQakgwyWSu1Z4WBJHqfYhRLfh6gF
         99Pw==
X-Gm-Message-State: AOJu0Yz5CwkmqFuytVAHAGmx76bxZtans7GqFD/pdGVKz4Z7jHZD7JmB
        DOzx3gJfv0uaeM1KNPu23ezGtd2PFYcRopxzGYVqUw==
X-Google-Smtp-Source: AGHT+IFNhzfolpmxqzMalcvm35gkAt2n9Mapht2JCd050Jjl/rb4ewNLjyuRd8FV62MPAolIdLzXcZoftB8gBrFW3y8=
X-Received: by 2002:a05:651c:97:b0:2b9:d7b7:36de with SMTP id
 23-20020a05651c009700b002b9d7b736demr5353682ljq.20.1692631523517; Mon, 21 Aug
 2023 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
 <20230623144100.34196-2-james.quinlan@broadcom.com> <ZON43rPGJGzjTTj/@lpieralisi>
In-Reply-To: <ZON43rPGJGzjTTj/@lpieralisi>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 21 Aug 2023 11:25:11 -0400
Message-ID: <CA+-6iNwRGsnRsT9R=iEzaJNCTLu_pQNG4x+noE8bqLYCRm_PHQ@mail.gmail.com>
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
        boundary="000000000000b76bbc0603707cba"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000b76bbc0603707cba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 10:47=E2=80=AFAM Lorenzo Pieralisi
<lpieralisi@kernel.org> wrote:
>
> On Fri, Jun 23, 2023 at 10:40:54AM -0400, Jim Quinlan wrote:
> > This commit adds the boolean "brcm,enable-l1ss" property:
> >
> >   The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs -=
-
> >   requires the driver probe() to deliberately place the HW one of three
> >   CLKREQ# modes:
> >
> >   (a) CLKREQ# driven by the RC unconditionally
> >   (b) CLKREQ# driven by the EP for ASPM L0s, L1
> >   (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> >
> >   The HW+driver can tell the difference between downstream devices that
> >   need (a) and (b), but does not know when to configure (c).  All devic=
es
> >   should work fine when the driver chooses (a) or (b), but (c) may be
> >   desired to realize the extra power savings that L1SS offers.  So we
> >   introduce the boolean "brcm,enable-l1ss" property to inform the drive=
r
> >   that (c) is desired.  Setting this property only makes sense when the
> >   downstream device is L1SS-capable and the OS is configured to activat=
e
> >   this mode (e.g. policy=3D=3Dpowersupersave).
> >
> >   This property is already present in the Raspian version of Linux, but=
 the
> >   upstream driver implementation that follows adds more details and
> >   discerns between (a) and (b).
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 7e15aae7d69e..8b61c2179608 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -64,6 +64,15 @@ properties:
> >
> >    aspm-no-l0s: true
> >
> > +  brcm,enable-l1ss:
> > +    description: Indicates that PCIe L1SS power savings
> > +      are desired, the downstream device is L1SS-capable, and the
> > +      OS has been configured to enable this mode.  For boards
>
> What does this mean ? I don't think DT properties are supposed
> to carry information related to how the OS is configured.

The DT setting in question is unrelated to the statement "and the OS
has been configured to
enable this mode".

This is merely saying that even if you enable "brcm,l1ss-enable"
that you may not get L1SS power savings w/o setting
"CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy".
I mentioned that exact term but a reviewer nakked it because
apparently DT descriptions should not be OS specific.

I am actually open for this to be a command-line option but I wanted to hon=
or
what the Raspian OS folks have already done.  RaspianOS already has
"brcm,enable-l1ss"
set in their DTS files.

Regards,
Jim

> Again - it depends on what DT should be used for, I am not claiming to
> have any authority on that, just asking.
>
> Thanks,
> Lorenzo
>
> > +      using a mini-card connector, this mode may not meet the
> > +      TCRLon maximum time of 400ns, as specified in 3.2.5.2.2
> > +      of the PCI Express Mini CEM 2.0 specification.
> > +    type: boolean
> > +
> >    brcm,scb-sizes:
> >      description: u64 giving the 64bit PCIe memory
> >        viewport size of a memory controller.  There may be up to
> > --
> > 2.17.1
> >
>
>

--000000000000b76bbc0603707cba
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBrRGDtcAiX4EyviQdTvkbLpOMvnr8x
zHqkF7zxLW4z0jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MjExNTI1MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAo3yIOGPstokMF2KM3zs9bTnljpayk29X8UwKzlDY7cdgQXO2
9B0MxHZ4939EUc6sjWB/ZoYebDL0qhHZeXAxw6wIlPAC4/aDAitBfQVG0ONw2co4Vx58iCrMWELu
cHWhGF7IlXLfoGnYSFOgrLU9pgVHO8NTGY4wqEF2T2TB21yJTv8nRNB3ILO22S9hhjVhMVxqBQR1
5Wx9aYkdo7aQkffmxuFf7+FWpjFwLsK0ams77E1SCqBKiMlSBpX80zQMydUG3ckB8yGo83Atjwkr
7tlZZWC5WfqboaNKyndi4UFrJFVNo55Tm8j+3b82EzF3vEbgnK0BX/WEjg8mwkX3yQ==
--000000000000b76bbc0603707cba--
