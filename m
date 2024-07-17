Return-Path: <linux-pci+bounces-10433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCC933D87
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B537E281A39
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC41802A7;
	Wed, 17 Jul 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O1OA0cr2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FA17E91B
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222461; cv=none; b=ON0sdQeI1uGDzNEwBPkcSV3ZzEqr4fnSny8USfN8NpmzLRVDzkf/9yBT1Bfk/6cXzmoRKAHni8YhvskXpL33dxwpaFrhb+lfuuVKz5zQ+nrg9dxBE1am+bmY+E3SbgeljwqbjL6hb012TJdIb9ZgGdGUi/3P/yM8g6L4SfjBf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222461; c=relaxed/simple;
	bh=yZPGJaFgun9jg8XO0sM0ewQasZUmS8PBqjamtMg17u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djllOvq/wjbeqZD1xdT9bZyv/eIlIvoQlj6QJ/LHY25YgWaW8GCKr1eYH7hR5OiGUGiqxfmaCVBMoeBcFPdYTJA5WdW13treXysGVRmy5UGsh0guErAD3Yxiwcoo+okfrq7Nacg8d0sms49128V+IOnR88XKcIzH1pYShzVyitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O1OA0cr2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso7353171e87.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721222458; x=1721827258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVc8VJThWVASnXaSpbLPXc/zdhooTEtoIHyIjZYVrMA=;
        b=O1OA0cr2luJ3td5P4foqjlx2Z/GSAzNw2yaZzX4lP3nCclorHhlp01RqM3hYUtdWI2
         +gwDUkR8/Z+0RJAPwlHP0ZMyJyqoDM5q1uiKVss5GGKo4jkINKmuXj+6j3qKjoeCDL++
         WinWbDG8KVIKxV5FMMoannLM90nOnUD+i+W0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222458; x=1721827258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVc8VJThWVASnXaSpbLPXc/zdhooTEtoIHyIjZYVrMA=;
        b=CGfmbeeNRhmSlespWrzXazw0A9JekrQcs9aLfZPr/wD5tLJkLw61Isc6q5sqVL0lr5
         J3ozTGHkJDfv6XcP94WYmzxxjQuUMeeNFVEekukkAk2es1Ng8bWwup8YfJq3mdY2UDYL
         EHilWUljpaK6TTMSKoK2cDc/v2yoFH06SiN6TCvfReRUh9Y5lJjJ5qg4xaKzYRHyaVTk
         FR2M1LngIcNnCSipOW1+3Tj0CRqYcKcUoBdoJgVKKDeYFj3zOTo9+pmvXWuI/m6S6E3Q
         7CUYG+AnZFg1t4n+TUzwIAd3HGDuMTF//Dsx/W67PsGVA84DG/WYCuk5BC3pLObmJ8OA
         B9KQ==
X-Gm-Message-State: AOJu0YxymWtpTxRWV5kPNCVqJTNOQ7hT7L406EptWd7x6ajX5lpzgS85
	MkTCAYA9OyjDlcV8I6/Z2GttNAgYDW21mrB8v7anMGzLe/L+Ry4nsJfMGtlfQWOMBxpunQcNJzp
	BdDsbFqBrYLgqrCnvml22B/Q5Uv0X0U22OG8p
X-Google-Smtp-Source: AGHT+IGw07aGQMyH20Cg08i8dwwUzV0NWThSiIPvPyPALpbVw+jawTEYniJ9SRqqx3LMsYwTDJT3q16wnw9NG/XNLFU=
X-Received: by 2002:a05:6512:304f:b0:52c:def3:44b with SMTP id
 2adb3069b0e04-52ee53f5fbamr1148892e87.31.1721222457998; Wed, 17 Jul 2024
 06:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-2-james.quinlan@broadcom.com> <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
In-Reply-To: <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 17 Jul 2024 09:20:45 -0400
Message-ID: <CA+-6iNwvShkUwgQ5iTqa53gX1RtOMcDACPOJtqKm6zWCXN6Rtg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: PCI: Cleanup of brcmstb YAML and
 add 7712 SoC
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
	boundary="000000000000375b7b061d715548"

--000000000000375b7b061d715548
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 2:51=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/07/2024 23:31, Jim Quinlan wrote:
> > o Change order of the compatible strings to be alphabetical
> >
> > o Describe resets/reset-names before using them in rules
> >
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
> </form letter>

I'm sorry Krzysztof, but AFAICT I paid attention to all of your comments an=
d
tried to answer them as best as I could.  Please do not resort to a
form letter; if
you think I missed something(s) please oblige me and say what it is rather =
than
having  me search for something that you know and I do not.

>
> > o Add minItems/maxItems where needed.
> >
> > o Change maintainer: Nicolas has not been active for a while.  It also
> >   makes sense for a Broadcom employee to be the maintainer as many of t=
he
> >   details are privy to Broadcom.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 26 ++++++++++++++-----
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 11f8ea33240c..692f7ed7c98e 100644
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
> > @@ -16,11 +16,11 @@ properties:
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
> >
> >    reg:
> >      maxItems: 1
> > @@ -95,6 +95,18 @@ properties:
> >        minItems: 1
> >        maxItems: 3
> >
> > +  resets:
> > +    minItems: 1
> > +    items:
> > +      - description: reset for external PCIe PERST# signal # perst
> > +      - description: reset for phy reset calibration       # rescal
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    items:
> > +      - const: perst
> > +      - const: rescal
>
> There are no devices with two resets. Anyway, this does not match one of
> your variants which have first element as rescal.

The 4908 chip exclusively uses the "perst" reset, and the  7216 chip
exclusively uses the "rescal" reset.   The rest of the chips use zero
resets.   All together, there are two resets.

You are the one that wanted me to first list all resets at the top,
and refer to them by the conditional rules.

What am I missing here?

Regards,
Jim Quinlan
Broadcom STB/CM
>
> Best regards,
> Krzysztof
>

--000000000000375b7b061d715548
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDbpvhRIJcG+QRFkfRqEOU5/rkIkS9Q
wufC6S0dhQvcpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTcxMzIwNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAC1QfLGkC/xEg52wFD0fQ+JcjB+Vrgl2aImvvtNH9iZbtZ40n
ybqcvYghsXyEgbmLSwuHPElGbRdYe5AOQpB9X9Doj0aMK+Sfy0O3EK/hNBblGFvq5ocmdDyhyDZr
1EYdv3Qlb9cej6cEh8jfDeT0hhhbeM2MgbMT+0nmIJLs1s826syXlqRdDIGbPQ30JQdN8l978n2h
FUYsFqj9twRVDBvDSMwcbGJH5jsgU0dRGmvJWjQMDvkR7dJx8gtfUGvOJ0heaHLeVz4b/c/GfFmK
fC47bhtGQ35Hal85r3+9WgEfiVT2zuPhphi1hSYXjMFRU2svblnOx9LwcKcqfWiDBA==
--000000000000375b7b061d715548--

