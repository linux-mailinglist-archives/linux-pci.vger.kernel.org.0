Return-Path: <linux-pci+bounces-10220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26736930125
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 21:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C7DB221CC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD143A8F7;
	Fri, 12 Jul 2024 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gFkkfBKy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01F381A4
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814068; cv=none; b=IQB2DHxr7ugE9tXHw+dWof3Cx84RPVkSSqwYEFoxy4qJhTm9jtP483MYsudYJjEdyjS7CUK5DYKwpnVjBzdzqF2SYiKP8CT9JsXIEZmubktIkmlcgJEPjQv6gf2Z5xfjHU2tR7H4ySoZNS19JfoPjB7sA55Y4andu3tDO1TR5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814068; c=relaxed/simple;
	bh=XeNLAjtJemrHe8gWdJCHe4/TmZcmt3aCJnKQJBgdVUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEA2Zh1Ur2zMBdEbGYqv2HVbXx3VM3eXah3+yvP+n7cqhQYDVaOsxo1+Ok1v02NbPdNK4tLxfgFjk2HJ5L8Xbv11Cr3dUYoa1MiG+KHvx+wGSw7LuxjUjvZAbdHYIp55mBFj10CM9xlj87q9M3cWjHCra+/u8wDlbf6dDI5bo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gFkkfBKy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e96d4986bso2435569e87.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720814063; x=1721418863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4/ngcGZOUlv2g+pqP0qZ+P94MpN9p5eXZQFViqHO+g=;
        b=gFkkfBKy/g0ZvMjdZxOjTE/bLFvtclZq+vmhMi734RrIaeDomFENWw4xBQeFeIneuC
         s1l9F/HZr9DELLRuf4bxAmAzKrhATYfn5Y3BWyCylqsVWp1ywgxCjZDPgjU/6EwQcMZY
         WalNxq8n2dxNVY2F9lKEqdfJQWMw8VDnHIkto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720814063; x=1721418863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4/ngcGZOUlv2g+pqP0qZ+P94MpN9p5eXZQFViqHO+g=;
        b=gTbtTgcKg/mbZqKO4DAJdUZxODWksfgEAHDO5q5wJCO32cDyTKOZkTT2+3X/1dbw79
         9VSzHQxrDiGihykOXELHmnslxzv9VKUTspALP1yzqxpSLVFLbZA0mWcj3jDg50SYdEnF
         dOoUCfI8DDjxSJQwoo+br06PoBDCJmMl9ydX8DPo0VbYrTBONMEeuv030Wm6kkLISZdz
         bELbkWXhi2FaPkJN/KijxKDJMU0OJlVD1HEbtzB7iGJmWSeUBpsfXGjYJYLoD/3aXiA8
         SQZw8/AvSWzwi1XjllvS0r17xyeJFihAql89JQ71Vg9FGL4gUTQS+ifZIGwkWvLvZ233
         h0EQ==
X-Gm-Message-State: AOJu0Yz9c6pr75ABFVYwyG2Bsa1UbWaTIrf+kIFEqFyQGdIp/TvJ4i0B
	SJn7ApkT3JnRIbZ+CjmOo4vUJmjq9qY1yZiNfLeHsI75+d83QHVlbiHd+nQCpFoQScEDg3oob+y
	z4e0tSJdUiyQEgUHhMGKSamFh28tq8TgKdFD3
X-Google-Smtp-Source: AGHT+IGJuM1c7+e270c4HHeAdZ6qyvrnZgiURFgBr33k7YX1eBlG7UqjyAgHgpZY63G/27Gs+JdxfRb9SXuQc0Ck3pE=
X-Received: by 2002:ac2:5448:0:b0:52c:e0fb:92c0 with SMTP id
 2adb3069b0e04-52eb99a2750mr6352658e87.34.1720814063237; Fri, 12 Jul 2024
 12:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-2-james.quinlan@broadcom.com> <df291860-cbbe-4f94-a18d-00ae9cf905b1@kernel.org>
In-Reply-To: <df291860-cbbe-4f94-a18d-00ae9cf905b1@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 12 Jul 2024 15:54:11 -0400
Message-ID: <CA+-6iNzZXF+yTmjMZ0SU0jO4L0ZzETZ-VvQpe4txv=SNTyo_bA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] dt-bindings: PCI: Add Broadcom STB 7712 SOC,
 update maintainer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fd6d96061d123e1a"

--000000000000fd6d96061d123e1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 2:40=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/07/2024 20:02, Jim Quinlan wrote:
> > - Update maintainer; Nicolas hasn't been active and it
> >   makes more sense to have a Broadcom maintainer
> > - Add a driver compatible string for the new STB SOC 7712
>
> You meant device? Bindings are for hardware.

Hello Krzysztof,

I should have replied to this before sending out V3.  Since your form
letter says I did not address previous comments, I will address them
here and now (your v2 review of the bindings commit).

>
> > - Add two new resets for the 7712: "bridge", for the
> >   the bridge between the PCIe core and the memory bus;
> >   "swinit", the PCIe core reset.
> > - Order the compatible strings alphabetically
> > - Restructure the reset controllers so that the definitions
> >   appear first before any rules that govern them.
>
> Please split cleanups from new device support.
Okay.
>
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 44 +++++++++++++++----
> >  1 file changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 11f8ea33240c..a070f35d28d7 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Brcmstb PCIe Host Controller
> >
> >  maintainers:
> > -  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > +  - Jim Quinlan <james.quinlan@broadcom.com>
> >
> >  properties:
> >    compatible:
> > @@ -16,11 +16,12 @@ properties:
> >            - brcm,bcm2711-pcie # The Raspberry Pi 4
> >            - brcm,bcm4908-pcie
> >            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > -          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > -          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >            - brcm,bcm7425-pcie # Broadcom 7425 MIPs
> >            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
> > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > +          - brcm,bcm7712-pcie # STB sibling SOC of Raspberry Pi 5
> >
> >    reg:
> >      maxItems: 1
> > @@ -95,6 +96,20 @@ properties:
> >        minItems: 1
> >        maxItems: 3
> >
> > +  resets:
> > +    items:
> > +      - description: reset for phy calibration
> > +      - description: reset for PCIe/CPU bus bridge
> > +      - description: reset for soft PCIe core reset
> > +      - description: reset for PERST# PCIe signal
>
> This won't work and I doubt you tested your code. You miss minItems.
>
> > +
> > +  reset-names:
> > +    items:
> > +      - const: rescal
> > +      - const: bridge
> > +      - const: swinit
> > +      - const: perst
>
> This does not match what you have in conditional, so just keep min and
> max Items here.

I do not understand.  There are four possible resets, but any one chip
uses only 0, 1, or 3 of them:

    CHIP            NUM_RESETS    NAMES
    =3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=
=3D
    4908            1             perst
    7216            1             rescal
    7712            3             rescal, bridge, swinit
    Other_Chips     0             -

Although I list four "reset-names", I have, in the rule for 7712,
maxItems=3D3 because it only uses rescal, bridge, and swinit.  So I
don't know what you mean when you say "this does not match what you
have in your conditional".  AFAICT, they are not supposed to match.


>
>
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -118,13 +133,10 @@ allOf:
> >      then:
> >        properties:
> >          resets:
> > -          items:
> > -            - description: reset controller handling the PERST# signal
> > -
> > +          minItems: 1
>
> maxItems instead. Why three resets should be valid?
For the "4908" conditional, minItems=3D=3DmaxItems=3D=3D1.  I do not
understand your question "Why three resets should be valid" -- can you
please elaborate?

>
>
> >          reset-names:
> >            items:
> >              - const: perst
> > -
> >        required:
> >          - resets
> >          - reset-names
> > @@ -136,12 +148,28 @@ allOf:
> >      then:
> >        properties:
> >          resets:
> > +          minItems: 1
> > +        reset-names:
> >            items:
> > -            - description: phandle pointing to the RESCAL reset contro=
ller
> > +            - const: rescal
> > +      required:
> > +        - resets
> > +        - reset-names
>
> Why?

I do not know what you are questioning.  The 7216 device uses one
reset: the "rescal".  Again, maxItems=3D=3DminItems=3D=3D1.  Please see the
summary note below.

>
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: brcm,bcm7712-pcie
> > +    then:
> > +      properties:
> > +        resets:
> > +          minItems: 3
>
> Again, you do not have 4 items here.

I do not want to have 4 items here; I want to have 3 for "rescal",
"bridge," and "swinit".  In this case, maxItems=3D=3DminItems=3D=3D3.

Now , for V1 you requested that I define all resets at the top; I've
done that and there are 4 of them.  But no chip uses all 4; each
individual chip only uses 0, 1, or 3 resets.

So there is no way that each chip's conditional rule can define
minItems and maxItems to match the description list of 4 resets,
unless you want me to undo your V1 request of describing the resets at
the top level instead of describing them in the rules.

Please advise,

Regards,
Jim Quinlan
Broadcom STB/CM




>
> >
> >          reset-names:
> >            items:
> >              - const: rescal
> > +            - const: bridge
> > +            - const: swinit
> >
> >        required:
> >          - resets
>
> Best regards,
> Krzysztof
>

--000000000000fd6d96061d123e1a
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD4eqSx89iB24GzTtViyTkO9/pnn4iF
WHv4/RqZL/3TPDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTIxOTU0MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAgGZik5zWCU9Ka9L6RUnOxktoxMtwuNPq0USYaxntvHGA4SNC
fVfLI/uKhNup+/qCGc8VHU5HAb3S3xqm272Pl5zMpYWMfD6F+j+hIHgopNFvZXR6W98rHRpTOKYT
66zMmRL4zBkDjljhYgvZE7RLMhCK+TjkOW+tUtOXFRYjTEZZIafpA+Kg4VlVV9udzm2az3pwep9G
6yjknwfidgJbrhLs4UhtCEp5bBzW1bJC9EXve8s52xjqgJGORsl4k9fsCsKj0oPqrQvLr3ven8c4
9P37hxTGMiI70HUy6UYFIjI81tUoDeexw9sF7bZxSPkewUENjKv+Fh+0i+4/sMHzsA==
--000000000000fd6d96061d123e1a--

