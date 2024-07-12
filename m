Return-Path: <linux-pci+bounces-10221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61B930137
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29428410C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976333B1A4;
	Fri, 12 Jul 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YpsYo5el"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A83B1BC
	for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815210; cv=none; b=NeeITVsWgsPcVxHd+BfLgYFH5LuUce8GaffWLePhOmkrlr/20LT2Jx0mi2IR4yITNA+gybqEMHFCLu6c75eqBCit5vcUWzr4EIPS2LEkjyd7v5M6afAkI+q83jDWUz4tnwmOwD1Zdmkh+g7VmEOh+cJ5W9Hpw6KKN/yfbMlZ0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815210; c=relaxed/simple;
	bh=MD/dx5zBG/sxtUfD1ugFRqGWssy8umlq12IU9xLCwbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2PSvI9N3JxPHH5fKuEc39pgOR7erUQuho5yBPheCtrNXx0fmimHa/lDvxyyyta5AohNBsu9gXe8xuOaxEkQ7JUGzRgrDvp/H2Pqb8qz7rDaZVZaLFWc+RAD07TUGFreQea1ScNGg7i3ZT782rStAWd4YVGO75a055ZmkdF7y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YpsYo5el; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so3073611fa.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jul 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720815207; x=1721420007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kGMLNdifmCVZfgyiOn8TGvix/ie1jBF30HsnXZRKsXI=;
        b=YpsYo5elVIDrg6yFVHXYR5UdALY7HUTuYxWzINkFIN2jPDJnnQeblKxJu6E8+G7lko
         4Ka7+RunB4oG+Nniuh6Pdmttqt85OipWA1kGIvhAIE/E2m1t8vGiP9pj6RQ6JeocjFfL
         JyJLKOV6OvPJHndByI9QpCuK4zbE1CUr4PvrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815207; x=1721420007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGMLNdifmCVZfgyiOn8TGvix/ie1jBF30HsnXZRKsXI=;
        b=t8AEgHICFrwPUa8MVKNC9OmxhX7/iEHeXqbttWQu5afXegK/icWyphUFlPWsFDKfIg
         iVQeHiq6wOf76y7mANC6y8tqtGYwktspnik8eUh0I6DyVjkmw2ceaaRqLAw5EK/F0Mjh
         3PVlz+XQuPUYCcQtPlt4rDvAQ3wpTWIZcIB2XhYtvMX9BoS35TGrbOeOlCjnfr90TReh
         4F+mB80+sKhAPRAVb4WW4CbVPeKGPWQTwu9/r7GA7un/HpXt5Z1LQowbzEMP3+m+e4in
         cADhlbKVsMzPGdl+aFBVr47hdrc6B6bjMEb9dXlWnrr5MegDMf2sKebYkOnjfZgsoigX
         F2Zw==
X-Gm-Message-State: AOJu0YxI6xu6t8zWOCEdTY6fVu93XXRxHCvkmjohLYqGFeblOAVNeuOh
	T9lrNStYIRt5KePUVpklyWrxkywD9YqqXs/agLrcemiHAq75eZhIa/ZVBHA/yllUzREQIocbNTd
	rTe8i5P1gEEUqQh1yH09IwEXVwHJWAGXPOkAy
X-Google-Smtp-Source: AGHT+IE57BZGL6UUOfC/s6HKDIw6QB6AjtdcfugVSb5hMU4zLcZnTTdLQIU9GKCNRsiLP2rRd1KYU4FivkrC2CBmKQI=
X-Received: by 2002:a2e:9b57:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2eeb30b9a2amr89089711fa.11.1720815206680; Fri, 12 Jul 2024
 13:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-2-james.quinlan@broadcom.com> <df291860-cbbe-4f94-a18d-00ae9cf905b1@kernel.org>
 <CA+-6iNwSk9-k=BZLbmPtwHHgqWs4ZB9OPGfF3Ruy4883dSTH7A@mail.gmail.com> <b71cb924-7f63-4141-97da-319d8c840465@kernel.org>
In-Reply-To: <b71cb924-7f63-4141-97da-319d8c840465@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 12 Jul 2024 16:13:15 -0400
Message-ID: <CA+-6iNxcmkd9O9y6=2By7pm+dAiyZt7GwYSMM++AUzLFF7yC4g@mail.gmail.com>
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
	boundary="000000000000245e1f061d12835e"

--000000000000245e1f061d12835e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 7:58=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/07/2024 22:02, Jim Quinlan wrote:
> > On Thu, Jul 4, 2024 at 2:40=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On 03/07/2024 20:02, Jim Quinlan wrote:
> >>> - Update maintainer; Nicolas hasn't been active and it
> >>>   makes more sense to have a Broadcom maintainer
> >>> - Add a driver compatible string for the new STB SOC 7712
> >>
> >> You meant device? Bindings are for hardware.
> >>
> >>> - Add two new resets for the 7712: "bridge", for the
> >>>   the bridge between the PCIe core and the memory bus;
> >>>   "swinit", the PCIe core reset.
> >>> - Order the compatible strings alphabetically
> >>> - Restructure the reset controllers so that the definitions
> >>>   appear first before any rules that govern them.
> >>
> >> Please split cleanups from new device support.
> >>
> >>>
> >>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>> ---
> >>>  .../bindings/pci/brcm,stb-pcie.yaml           | 44 +++++++++++++++--=
--
> >>>  1 file changed, 36 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml=
 b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> index 11f8ea33240c..a070f35d28d7 100644
> >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml=
#
> >>>  title: Brcmstb PCIe Host Controller
> >>>
> >>>  maintainers:
> >>> -  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >>> +  - Jim Quinlan <james.quinlan@broadcom.com>
> >>>
> >>>  properties:
> >>>    compatible:
> >>> @@ -16,11 +16,12 @@ properties:
> >>>            - brcm,bcm2711-pcie # The Raspberry Pi 4
> >>>            - brcm,bcm4908-pcie
> >>>            - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> >>> -          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >>>            - brcm,bcm7216-pcie # Broadcom 7216 Arm
> >>> -          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> >>> +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> >>>            - brcm,bcm7425-pcie # Broadcom 7425 MIPs
> >>>            - brcm,bcm7435-pcie # Broadcom 7435 MIPs
> >>> +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> >>> +          - brcm,bcm7712-pcie # STB sibling SOC of Raspberry Pi 5
> >>>
> >>>    reg:
> >>>      maxItems: 1
> >>> @@ -95,6 +96,20 @@ properties:
> >>>        minItems: 1
> >>>        maxItems: 3
> >>>
> >>> +  resets:
> >>> +    items:
> >>> +      - description: reset for phy calibration
> >>> +      - description: reset for PCIe/CPU bus bridge
> >>> +      - description: reset for soft PCIe core reset
> >>> +      - description: reset for PERST# PCIe signal
> >>
> >> This won't work and I doubt you tested your code. You miss minItems.
> >
> > I did test my code and there were no errors.  I perform the following t=
est:
> >
> > make ARCH=3Darm64 dt_binding_check DT_CHECKER_FLAGS=3D-m
> > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/brcm,stb-pcie.y=
aml
> >
> > Is this incorrect?
>
> That's correct and you are right - it passes the checks. Recent dtschema
> changed the logic behind this. I am not sure if the new approach will
> stay, I would find explicit minItems here more obvious and readable, so:
> resets:
>   minItems: 1
>   items:
>     - .........
>     - .........
>     - .........
>     - .........
>
>
> >
> >>
> >>> +
> >>> +  reset-names:
> >>> +    items:
> >>> +      - const: rescal
> >>> +      - const: bridge
> >>> +      - const: swinit
> >>> +      - const: perst
> >>
> >> This does not match what you have in conditional, so just keep min and
> >> max Items here.
> >
> > I'm not sure what you mean.  One chips uses a single reset, another
> > chip uses a different single reset,
> > and the third (7712) uses three of the four resets.
>
> Your conditional in allOf:if:then has different order.
Different order then what, and ordering by chip or by reset name?

>
> >
> > I was instructed to separate the descriptions from the rules, or at
> > least that's what I thought I was asked.
> >>
> >>
> >>> +
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>> @@ -118,13 +133,10 @@ allOf:
> >>>      then:
> >>>        properties:
> >>>          resets:
> >>> -          items:
> >>> -            - description: reset controller handling the PERST# sign=
al
> >>> -
> >>> +          minItems: 1
> >>
> >> maxItems instead. Why three resets should be valid?
> >
> > See above.  Note that I was just instructed to separate the rules from
> > the descriptions.
> > In doing so I placed all of the reset descripts on the top and then
> > the rules below.
> > There are four possible resets but no single chip uses all of them and
> > three chips
> > use one or three of them.
> >
> > Please advise.
>
> I don't understand that explanation. Why this particular variant works
> with 1, 2, 3 or 4 resets in the same time?

What do you mean in the "same time"?  The resets are just not present
in most of our PCIe HW.  In two chips there is only 1 reset in the HW,
and in the 7712 there are 3 resets in the HW.   You asked me to
describe all of the resets first at the top level and I have done
that.  But none of our chips ever use all four.

Regards,
Jim Quinlan
Broadcom STB/CM


>
> Constraints are supposed to be precise / exact.
>
> Best regards,
> Krzysztof
>

--000000000000245e1f061d12835e
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB4hXQzzs02PkdS3jE7+mARjROx3mbP
RtRbA87CmKQ5gTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTIyMDEzMjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAborR7bvGr/E6jZM8hYZy8/MYtJqvmT1R7S/3hlJV6xUkQ2OZ
jzJvqtbGCkcpkX/D5QijnlS1yzBHqHw1dK0wUVbKOFXEhG1HU91WZsiwVLy8HCRJRVwutYiSInB/
slF3g1xzbSWEU7zB0wo3w9HVcGK6Gi7wCnLfA3GFnL8N8Gayzau6U39WRviV0UCJG5CjqKAIKI7H
UyMmMOB0GLf0uAJqhiZYYBb7gVdTjp4njXtCj9zYNE8JP2lNM3xW2KPiJCjNuFAfgNBAjVHeyYEX
WouXAy57ho9VaV2WRoS93j1UyZmsSQ504nQzGg+pHL0dVKSHgzfMYbNBA9pTjvAczw==
--000000000000245e1f061d12835e--

