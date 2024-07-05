Return-Path: <linux-pci+bounces-9859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23221928E0B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 22:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB89B214F6
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 20:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C9144D16;
	Fri,  5 Jul 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FOB91NbQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7549656
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209777; cv=none; b=BuAsIOSh6fS7jnxofYY0EYAA6PlB06VqcXfcWe/Xj8b0gJEuvJlDcF6lLEiq5p/Zi9ZkY8tUffvNwbDGkV491eq9doeoutMEw1xIU8vuL7QrAdmehs/2kocRQqYZNm+DEc5piGJcr/5sQFqToh9SM+nUff/yiusgDP3r2gBmxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209777; c=relaxed/simple;
	bh=r503CHI6YncQzLBoj8JsQDNCdqGAE/+XmJ2cSvpi1B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxQGxuiKL1PijUrOz1CmvlLi6AmoiwtWv5qrne7PGxyBBJTjL92gRpuoGLCnhZUtc7R39b8N1wzCOkYJIwRPul7GnuHlSQNLnAG/LqxOihthoEV/YuNN1tSTytWwpFIetkMQHtQJlzje4I0QMb5tBfOQAoN9KqyA3ArgVs3IxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FOB91NbQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c2d89af8so192062466b.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2024 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720209774; x=1720814574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whHps81mWz306NqpkSmFQTEyg2M/kmpeuq0lhutKi3U=;
        b=FOB91NbQ/ozFE9JRgrwANBKOq0Ot+2qujpDw9PKohk/INsz7Qm7QzlgAo5S0GpRS9J
         UpEeGyHRNTIV4n6OyqVM0bL7we8tnMTZfBjSiNx+GtL2jRa2vCZF0t/h/+5VnZjvaooB
         6dVLgiFcYte+e2sPfzPdl2r155qHV4LFp264s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720209774; x=1720814574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whHps81mWz306NqpkSmFQTEyg2M/kmpeuq0lhutKi3U=;
        b=kw9czhBru4bdumbm1OQp/b7SKc3JrdRYFYMu3/lYLIkudnYTmIW+m9P8beTC/ez1QO
         yQYlOW9F20N5R/UhfdFd+yDJGdBdDgs/Kotr1mpBOXDhM/bMeP0QaUcrzxpOaRtyy0vy
         VynBmJPh+Vkaka67GUb75uWMIv+DogBJYDFUZYtaUttl2aey4TO+Ax1lpBjWgeHThpbe
         k1EerPhX5f9ryjdfSdXkKvK47vtgyqM0Rys+BbDT7VWylG6PkShDjF16u9dOae1pORsV
         Y/Q2d+lkvYArBLa+wwY5gMn6FQ7V8QiJKNMiw0iqf4qHkpmpTduUkEJO0U4hnXgkp0Cp
         dVMg==
X-Gm-Message-State: AOJu0YzvrligYka24vET6afWqtRkUGDZlLTwLdVI7Z4eWufnokeWR//Y
	HdIYF1xvGBgRjbZPISQKsxtQR8zvZ0R6K3jnYiwSmekfgWbWn2ydCkoJrPdllYUciTjW18z/X7i
	eoEUnf9y6nIoK0mfAPaf3edI2JrSk7Tqs6VGX
X-Google-Smtp-Source: AGHT+IFrULNTwotrvD8JYlwnzGN3SAhVHpkMigbwFwyyEeBRC5VkGbCr/Ml+I5oqCEuVSqjjFiojgt68aGlmsaI7rNs=
X-Received: by 2002:a17:906:6bc6:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a77db361df6mr108496466b.42.1720209773817; Fri, 05 Jul 2024
 13:02:53 -0700 (PDT)
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
Date: Fri, 5 Jul 2024 16:02:39 -0400
Message-ID: <CA+-6iNwSk9-k=BZLbmPtwHHgqWs4ZB9OPGfF3Ruy4883dSTH7A@mail.gmail.com>
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
	boundary="000000000000897951061c858c99"

--000000000000897951061c858c99
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
>
> > - Add two new resets for the 7712: "bridge", for the
> >   the bridge between the PCIe core and the memory bus;
> >   "swinit", the PCIe core reset.
> > - Order the compatible strings alphabetically
> > - Restructure the reset controllers so that the definitions
> >   appear first before any rules that govern them.
>
> Please split cleanups from new device support.
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

I did test my code and there were no errors.  I perform the following test:

make ARCH=3Darm64 dt_binding_check DT_CHECKER_FLAGS=3D-m
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/brcm,stb-pcie.yaml

Is this incorrect?

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

I'm not sure what you mean.  One chips uses a single reset, another
chip uses a different single reset,
and the third (7712) uses three of the four resets.

I was instructed to separate the descriptions from the rules, or at
least that's what I thought I was asked.
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

See above.  Note that I was just instructed to separate the rules from
the descriptions.
In doing so I placed all of the reset descripts on the top and then
the rules below.
There are four possible resets but no single chip uses all of them and
three chips
use one or three of them.

Please advise.

Thanks,
Jim Quinlan
Broadcom STB/CM
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

--000000000000897951061c858c99
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB/96qkq1qjbvMQxRKTXuKckS4Bd7Ra
gv5WyZhpiY3yKDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDUyMDAyNTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAPDeR1jdyfmWPjb7noeLbl14RfvieM4eRUWVeC7T6JeM7Gftc
82EDWGVKss2OZ3qNhL0QujB+mKdr22BNkJqjVwrAq4WQ7kGjQrN8+tTHymOGVVpwluYAHfxkJpFG
IjKREIuLLl9Cjyg+RETECfetbv5XlzxuJhzYtofVmggO6ppiq389eO1Yfg/Ukjh0WDYsuiTx0BuG
D8AWaE1gbx2a3165CHFCIF0PAyLXLAb7+280MzaaVOCL6t5SiHaIHrSeyUBvTboHMzFjw2GeNgpX
hoZxiqCAO9O4jqD+iJbdUhBeSZNVx/t++s6IGZhREp7RodJRwBQCjQEQqU9DXHJnvQ==
--000000000000897951061c858c99--

