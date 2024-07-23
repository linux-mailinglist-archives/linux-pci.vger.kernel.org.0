Return-Path: <linux-pci+bounces-10667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CE93A768
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BA91F22CA2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02C13CA8D;
	Tue, 23 Jul 2024 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OyjUtslt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3060A13C67C
	for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760599; cv=none; b=gxGI+F0TX++pki/SiZLkynGKn/p8N5Q8KQ2TBlucAOw7cy/nCkYYukN7YZVqsxKKGVKbCKpQvA1QwnquzJsvqWk2GK3SF98eRwm0A9uUZBfKRB2350WUTPYSzbKR3B7fO+PwY9GQB/q2NhPbmJh6OrJ9IAxoHTxKXkbiAWhysjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760599; c=relaxed/simple;
	bh=5o2Pq1Zi7BgL9VhRaACjQerBSYcD2/qBz5OU5ELfsD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLJySPuHZUyY08kn7hj1iNXJPd5IjjvE4zuvz79Hx9peuWC8zZ+ZGvPQKonHE7fXXmMKoqagJX5cylS+wdOnRf0dnnQ6xjGtnqaemDjPQWleqNWd1aKB1B3qh6HPk9T2qb+jzMkbbKyAXTb66Y6FyzkdqnU8UEtXD3VRiRLzpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OyjUtslt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01613acbso137818e87.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2024 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721760595; x=1722365395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxLUV6d231nshIUFIpIOuL1wvZ0alC2j3bgTNYh4kCM=;
        b=OyjUtslt2Dn2oyboATGReJeUTUBJreXqCU5sFoLUzcHsa5qKW8U/v1ahiKUn6OvUeO
         xFWVRFpC5WVeHjmnbxdwfgelDauwF2wNyi9NohXl83wdwenBUkh/64aj34jfgUQ7bGVA
         61YaTI9o3uo+4haz2SuRPYwrnO7fPhctkwzKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721760595; x=1722365395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxLUV6d231nshIUFIpIOuL1wvZ0alC2j3bgTNYh4kCM=;
        b=cqjm6Uf3OBp+X8fCH9Xdqh7qOVjzWUOE4Ui3dA/2a4B6V4FKCj/opEvYbgb634lY+h
         mFucUMKTv6ABbMJaf7fuoUWHHGq2uYnOU9CRWSLmsrFRVyH8//wxFCPlFSbnRkXUMWof
         8DmeVdm1Pa3VjksZ7DQT8ZzemCxLusIDdwwABUo59LUb62hF/XevdQFJxzr9EtzpAvdK
         rNSgcxHr9pl+P8YSH32nxV5KgUOsSqYSyqLUv6fJG+5vW3r7jty8Fm+rgyuXv/1rVVPk
         0uW7HZOx3xjY8wtyU23s6lg28vFIgH8QceK+K4gyF1CETN6IYD7YAm0B1/cn+eLAQch1
         ICHw==
X-Gm-Message-State: AOJu0Yw87ru7I6m+B9tp+5IFcsNuGrOujFF1+Lnv905P27TdT0KGGGn6
	eXc1ksD2wuzjzGeOYavJApzIQAe48rNLT+CcGpEtwRxrnNIn7VhjBecPp/x1vR2YEx5AMOQnxCJ
	NpF0ZTUIbUeu9Czdp5zBPNwuXY7Huqy//wt2Z
X-Google-Smtp-Source: AGHT+IFN8g3iXTryQ+8Uy3bO3xLLZU2m1O7PBXXthWW9Bm9iwL9Ou3dzuN//ywjE6lZdchAH6pT9z7ApP0Bg7vtI3MU=
X-Received: by 2002:a05:6512:3f06:b0:52c:dc56:ce62 with SMTP id
 2adb3069b0e04-52fc66f0d20mr903091e87.12.1721760595167; Tue, 23 Jul 2024
 11:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-2-james.quinlan@broadcom.com> <d20be2d3-4fdd-48ca-b73e-80e8157bd5b2@kernel.org>
 <CA+-6iNwvShkUwgQ5iTqa53gX1RtOMcDACPOJtqKm6zWCXN6Rtg@mail.gmail.com> <8e260164-cce2-4153-9f9c-0330c76408ef@kernel.org>
In-Reply-To: <8e260164-cce2-4153-9f9c-0330c76408ef@kernel.org>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 23 Jul 2024 14:49:43 -0400
Message-ID: <CA+-6iNy5U6XG-sSjoBH4pAhFhP4=KDcKRVbD3dXZdsM2WCkd-w@mail.gmail.com>
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
	boundary="000000000000b1822d061deea0b0"

--000000000000b1822d061deea0b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:30=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/07/2024 15:20, Jim Quinlan wrote:
> > On Wed, Jul 17, 2024 at 2:51=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 16/07/2024 23:31, Jim Quinlan wrote:
> >>> o Change order of the compatible strings to be alphabetical
> >>>
> >>> o Describe resets/reset-names before using them in rules
> >>>
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It seems my or other reviewer's previous comments were not fully
> >> addressed. Maybe the feedback got lost between the quotes, maybe you
> >> just forgot to apply it. Please go back to the previous discussion and
> >> either implement all requested changes or keep discussing them.
> >>
> >> Thank you.
> >> </form letter>
> >
> > I'm sorry Krzysztof, but AFAICT I paid attention to all of your comment=
s and
> > tried to answer them as best as I could.  Please do not resort to a
> > form letter; if
> > you think I missed something(s) please oblige me and say what it is rat=
her than
> > having  me search for something that you know and I do not.
>
> I do not see your response at all to my comments on patch #2.
>
> >
> >>
> >>> o Add minItems/maxItems where needed.
> >>>
> >>> o Change maintainer: Nicolas has not been active for a while.  It als=
o
> >>>   makes sense for a Broadcom employee to be the maintainer as many of=
 the
> >>>   details are privy to Broadcom.
> >>>
> >>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>> ---
> >>>  .../bindings/pci/brcm,stb-pcie.yaml           | 26 ++++++++++++++---=
--
> >>>  1 file changed, 19 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml=
 b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> index 11f8ea33240c..692f7ed7c98e 100644
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
> >>> @@ -16,11 +16,11 @@ properties:
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
> >>>
> >>>    reg:
> >>>      maxItems: 1
> >>> @@ -95,6 +95,18 @@ properties:
> >>>        minItems: 1
> >>>        maxItems: 3
> >>>
> >>> +  resets:
> >>> +    minItems: 1
> >>> +    items:
> >>> +      - description: reset for external PCIe PERST# signal # perst
> >>> +      - description: reset for phy reset calibration       # rescal
> >>> +
> >>> +  reset-names:
> >>> +    minItems: 1
> >>> +    items:
> >>> +      - const: perst
> >>> +      - const: rescal
> >>
> >> There are no devices with two resets. Anyway, this does not match one =
of
> >> your variants which have first element as rescal.
> >
> > The 4908 chip exclusively uses the "perst" reset, and the  7216 chip
> > exclusively uses the "rescal" reset.   The rest of the chips use zero
> > resets.   All together, there are two resets.
>
> This is not enum, but a list. What you do mean overall two resets? You
> have a chip which is both 4908 and 7216 at the same time? How is this
> possible?
>
> >
> > You are the one that wanted me to first list all resets at the top,
> > and refer to them by the conditional rules.
>
> No, I wanted widest constraints at the top.
Can you explain what you mean by "widest constraint"?  I did not see
the word "wide" in any of the Linux YAML documentation.

>
> My comment at v2 was already saying this:
>
> "This does not match what you have in conditional, so just keep min and
> max Items here."
>
Okay, what I was referring to was your V1 response:

"Fix the binding first - properties should be defined in top level
"properties:" and then customized."

I think this is correct but I have not been describing the
reset/reset-names properties properly at the top level; i.e.  I have
been giving a full list instead of using "oneOf".

Regards,
Jim Quinlan
Broadcom STB/CM

> and you have numerous examples in the code for this.
>
> Best regards,
> Krzysztof
>

--000000000000b1822d061deea0b0
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCkensSROmUAhbnwUmygmgFBGpU2Dus
XDg89I0iOb5JSjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MjMxODQ5NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAaO63AjdO1ncFQmmasEfxaKJwAPVayZHaf/jYK6kbwmXDI0Xp
EmLX3aOuNplfGXxJqf7pPEeIE/SvRUVKGeb+tMj2tLgGI6LaB65jMNrvioh5X8fRUE7O078Culo+
kby6FFApxjEWSJKSxqM6GBp4jJrYU8SRm35QWvueZx1eXLSfQRyYhLgdikKO2/kechzJcEEJ4l+m
E+K2ysS+m8Af4CtMBZ5OVeziW81NiHpUlJ5MCQqpTCrAuErrbk3fQI8/CvHALxlah60e29mRgPvG
cQzpIie8SX+BKUltEo/DJ+yeKTJg341utnQTsTM8zi3C9xQMMBl2LdUwCQFIz611pw==
--000000000000b1822d061deea0b0--

