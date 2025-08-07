Return-Path: <linux-pci+bounces-33561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393ECB1DA07
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B8B7282A2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBFE25DAEA;
	Thu,  7 Aug 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hSgAWWri"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358A25A2A5
	for <linux-pci@vger.kernel.org>; Thu,  7 Aug 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577636; cv=none; b=aOzO4XZu7Qlc1wsQWf8S+BI/BCv1RbLFSYnk/KJbIzAEaT4MovyTGLhV/BYYH58Yp6PwfXj+MGwJoKZyl+RqPKNj4P0TWTsiDatOm6CFEG48ccTNzZkZvFs8FbxOSwVOtYmeeqpd+9NTyT19pv3DYUhRl4jPST59ciAm9N/3d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577636; c=relaxed/simple;
	bh=p2YEHQNj4LoXnilxyQubf+syKfALDsjPNXZ8aAM5ppM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3kG55sVRzjYgkxhMcLdkE5dSr6HsbsTHzOijEY2vzO4khhjjRCCIBnddPJxOsaKIhZ3ActUSRvw1Flxy99XYgSM4hhnVITUlw7+3+N0lcCwhq06zlr4gMyXBznWnRNEbXnhgrTSrmXOWv6XqJyNyGkK6Hiauwfbt/grzuUCkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hSgAWWri; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b9a23d633so1158820e87.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Aug 2025 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754577633; x=1755182433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kD5I64plBtmtrZx/pR7QCNLPpA076WLWcH2KUu1iaHY=;
        b=hSgAWWrijj4zxUxKQyePT89DTIW6ijbh4zyqMwDrYDzLCup7XMbsfdLPzTq7197kqc
         eFJRd/6YXSeqaSE6jErPSkHeUx5sWY6bwzHm590XT8iyX/bXUEu3GM4tOduAkvNQsGlZ
         TGfdj/Q5lSIGdv4QHJaD0x41+bn8brmPiq+UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754577633; x=1755182433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kD5I64plBtmtrZx/pR7QCNLPpA076WLWcH2KUu1iaHY=;
        b=QUQqgySAEfjVZyduzFqdgop4J0e7TIExX3RFYJElSX661QiKIOQ87qe1KjTUq6wRON
         8u16IA3fwVoQdYarlnrsAhwk0eZtF0Kkc95MaqkyebXJC253n8aeyfNh3d65Ar/4659d
         1P+ufGhAcx7U7bvBpMMfVnQP8q9DTaeWGSuA2vZiiXQUehBWv2xrwjhMpNgaG9p3TS5v
         9gVQIaq4Q+4+dzWB9LMFJGJoYEn9y30ZGgZF0fNTcLNV4RONnZj8yTub7S/ipgLzlH+y
         1F617O2MmihuM8V68bHh+QbUlBff4wueRr6Jwh+XC0NRm2WRIYGmPJrdWTNniAUocP83
         qeXg==
X-Forwarded-Encrypted: i=1; AJvYcCWodkTEheAeVixEjQl3llIX5BHNRQomVKePfxr2Sl/BUzGS4yfQJKgkg2WX0fh9PMQkZGyuKE9vqDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSGh0CTXJfqI8/bABYwUjLs2G2XJIllVN7qhPPRf+Gl8/IYjy
	hkzFg7mHCP12WjJTRPVTIr/RRQZmnMsee43OqEgwuxjD1nsRWwmWMxMWz29d9eKIUDVImDQkp63
	0xz4HSQwmOrg47S+dX5Zjz1a1BjzlEOPZ+MzKx1X+
X-Gm-Gg: ASbGnctqIDewHLoOwgE1vz5RXSwXoDl+LjQwOI+jwL3aF8tGaLnuIFOQgC5fLUM30np
	82VjK6nqq7iIWY5llVcUwrEBsv8IITGZmr3YZ86++6X2Cp6vSckvU8vK6cIA/EGKrEEMMZSbbIf
	8y2wU661kjmNDCF2sfJ98xloPoaZh0KRaG8XGzQpyBfLDtJczYE17tXcWJVrbfrpMdt9YBBxv0j
	0LfGFWC
X-Google-Smtp-Source: AGHT+IFfXBau/vkdFXzt1rI+u+8KdsVnMNnBJ3n6/2FZheJxalpCRtfPgU6x2DrNronh67hxDTpFDmCMdX2Rps+cXrA=
X-Received: by 2002:a05:6512:1282:b0:553:2912:cfdc with SMTP id
 2adb3069b0e04-55cb61d942amr1029433e87.9.1754577632786; Thu, 07 Aug 2025
 07:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806185051.GA10150@bhelgaas> <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>
 <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
In-Reply-To: <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 7 Aug 2025 10:40:20 -0400
X-Gm-Features: Ac12FXw4Zz9zrMglWbi8yAVhox7Ad4M4bjdjZsEOBJhhu0nV8rV8uesuvfcCRwM
Message-ID: <CA+-6iNyK+A38AWm_j61UdVth2nTSpp2CH6fZX+8oKif3dUdifQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009214ca063bc7704a"

--0000000000009214ca063bc7704a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 1:26=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Wed, Aug 06, 2025 at 01:41:35PM GMT, Florian Fainelli wrote:
> > On 8/6/25 11:50, Bjorn Helgaas wrote:
> > > > I'm not sure I understand the "racy" comment.  If the PCIe bridge i=
s
> > > > off, we do not read the PCIe error registers.  In this case, PCIe i=
s
> > > > probably not the cause of the panic.   In the rare case the PCIe
> > > > bridge is off  and it was the PCIe that caused the panic, nothing
> > > > gets reported, and this is where we are without this commit.
> > > > Perhaps this is what you mean by "mostly-works".  But this is the
> > > > best that can be done with SW given our HW.
> > >
> > > Right, my fault.  The error report registers don't look like standard
> > > PCIe things, so I suppose they are on the host side, not the PCIe
> > > side, so they're probably guaranteed to be accessible and non-racy
> > > unless the bridge is in reset.
> >
> > To expand upon that part, the situation that I ran in we had the PCIe l=
ink
> > down and therefore clock gated the PCIe root complex hardware to conser=
ve
> > power. Eventually I did hit a voluntary panic, and since all panic noti=
fiers
> > registered are invoked in succession, the one registered for the PCIe R=
C was
> > invoked as well and accessing clock gated registers would not work and
> > trigger another fault which would be confusing and mingle with the pani=
c I
> > was trying to debug initially. Hence this check, and a clock gated PCIe=
 RC
> > would not be logging any errors anyway.
>
> May I ask how you are recovering from link down? Can the driver detect li=
nk down
> using any platform IRQ?

We do have link up/down interrupts on most of our SoCs but we once
implemented a handler and the interrupts were unreliable.  We informed
HW but I do not think they implemented any changes.  We will try again
at some point to ascertain the extent of the issue.

AFAICT such a handler is not a panacea.  Having a link-down handler
may be able to immediately prevent panics for config space accesses by
intercepting them but not incoming memory accesses from the host or
endpoint device.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--0000000000009214ca063bc7704a
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
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA9tHvgjXaeOmc0RdmtldLb2ub0QVbZ
EXMc6jAC/X/xDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4
MDcxNDQwMzNaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAFoD03tHBg9K1pOzlc7IPwqWfid6ZEjIK/UCjYg3hTXQdOukJOeRoi1hE42VnmcJXE
6FFLyTjuxmW6EKDRCJp9bcttbb0Q8TSzhOR81Wkk7VT4csfOY+MDdvZYsSHTwOxCTdCZoQLYQZvy
gIPKv/czkXjDqMOtGti2njfRZTbrcPn16TL5vR+yAHzySB42Kqibd4yZkz2U7aHKRrATAwRYn0Iz
PqAIhCUNZIOWswiIL90LNbOwG5NIvnecHt4BjHnUtDUjk+qONBI3mLYGLYZegFoMZBH/HmgKvXB3
KUkwoUS9VLKLE4WZNKZ5SPS1AmvxE6AxN70kfsrAZHFFMPM2
--0000000000009214ca063bc7704a--

