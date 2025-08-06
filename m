Return-Path: <linux-pci+bounces-33471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B4B1CC02
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAC4176E64
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670329A9C3;
	Wed,  6 Aug 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eqFKAKzr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE544259C94
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505510; cv=none; b=GA6mBrWbQfwx5PfE+5sMxT2J9nbbGbD48ovrNAeIF2JRQ7bfVrQM10VpbErGwi3M3lua01/gey7ZiEQpXLlvHPf9UpJfocXfeSIk9KAoOgXR/KCsn7rzVhujcQBNKyFBYSZzOZMPl7D+Phg/iI7gAr4vEmJqzJO9UO6P0b9vpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505510; c=relaxed/simple;
	bh=8uM54x1vBoU9GFWm7DPoU4gKhVArps83CJogiAKrWj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RovHCU7am+jdMgo5wPtyqeAKSlWYOvG1ZdKdPEEQGGK2DuLUKrEl77XGrhwHb9iVIZy6l/dHO3WJMeWRNeJD9i2c62Vjgud7SEYc6oHjdTfHlBkR0f/vQmv4owHAq27myQ7CR8fSQm6dogmJpmpV12XwQTlRN0p3AvgSj6PYjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eqFKAKzr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so190598e87.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754505507; x=1755110307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYs04boTg8adkN2/yRygsSRxxm/y7x8APbAfDmT3xr4=;
        b=eqFKAKzrtt2imirPJAwv0JEwJlUYwtyArP7oYEklYmIgjmbgBEAPemnLHrWlhbQdiR
         m30J/hLro0wK9V2ECNBUdXdxdLebyGFdkblagv7psxpJcQeRud8yNPMGReCsxXyuANNK
         6K0wDuq2TpfnCbPPv5/26agr4FWbRRMYXiGmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505507; x=1755110307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYs04boTg8adkN2/yRygsSRxxm/y7x8APbAfDmT3xr4=;
        b=g4bBv7Y+ObLaluv0uwxMj6Jb2OHexSrSnXEQOKd4aA7tOuRRjC+730/QZZfzFI85Me
         pBG8dw0vWgJkWsknOgTQYdnzyNMNeRcWFd/Tl5DweaHxe7RnC4My876+FdFq8ujsdhIU
         /orHoYsiQnPRzI7enmGURX2rdufyzt+9dx2bUPTs8ebm+fB/koUIwagoyWw2Hm7/mS95
         7ExFdjNwEJApwhHhO+bH4pPsEh5YIf4JYB02Ya1/yWB4vtsf1zPLKuf1K6Iz6s4kXT/G
         +etl8G5bnCpryc2l/RJt7CidVqo0Y/Gz6/gQZWu+fYcGLcLnayxOOKBW4/cuefvfkyol
         DDjA==
X-Gm-Message-State: AOJu0Yxtj8qcaGPs/DUJd+WwZJTAPg9SKGm7nbE0qqKWxyTJuwRu/VFo
	xR2TfpKJGSG7V78FllchSTJ9MNCtADveku37Pnyekvp0y8xfKt9SAfDWtvfTZNU2DRCQUTD9ZNM
	FDfmG/qDpH2775SJ3dzNX+smR1XjIk/sgIWNptcR9
X-Gm-Gg: ASbGnctWoDKyA/c1Ph5AVzoABRsejRF/+xiolJi4cUBH2VU0eSxZEBSuCS+Fveo1Ck6
	OaYw/mVjrEESDuQo4izkXYs574x0Ya3haEeIvAh7dwcjSd5HBARy+K97UOFiH2ekRC6eSzU55IS
	jwl9IncoQbVK0d+X+b5j6lfYyeW+iogRGlASSqgS3LpBQGpbX2VE9uB7BXot+vPIEhKZBIhBQXJ
	3mRwgtw
X-Google-Smtp-Source: AGHT+IFIkIZFqb2tIH6xpoXX+ss5FGfVojoniuDIJok2epTHtRmEHuUYWL5UtNVu/MhGWC6ZWhGBKGoyLQCS5kSngqQ=
X-Received: by 2002:a05:6512:308e:b0:55b:830c:b62b with SMTP id
 2adb3069b0e04-55caf2cdc58mr1404043e87.7.1754505506737; Wed, 06 Aug 2025
 11:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613220843.698227-3-james.quinlan@broadcom.com> <20250806181540.GA8692@bhelgaas>
In-Reply-To: <20250806181540.GA8692@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 6 Aug 2025 14:38:12 -0400
X-Gm-Features: Ac12FXzptWVV8zxm0qYf-fSoQ2BgaWGFBpKJPTrS9QUD5eVFQCdD6iKxB7Y66Fc
Message-ID: <CA+-6iNzq_BV_fK9T4LK0ncZuufqp9E9+DUyFU3jKCnSCjN8n-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000083bd50063bb6a51a"

--00000000000083bd50063bb6a51a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the lik=
e,
> > by default Broadcom's STB PCIe controller effects an abort.  Some SoCs =
--
> > 7216 and its descendants -- have new HW that identifies error details.
>
> What's the long term plan for this?  This abort is a huge problem that
> we're seeing across arm64 platforms.  Forcing a panic and reboot for
> every uncorrectable error is pretty hard to deal with.


Hello Bjorn,
Are you referring to STB/CM systems, Rpi, or something else altogether?

>
> Is there a plan to someday recover from these aborts?  Or change the
> hardware so it can at least be configured to return ~0 data after
> logging the error in the hardware registers?

Some of our upcoming chips will have the ability to do nothing on
errant PCIe writes and return 0xffffffff on errant PCIe reads.   But
none of our STB/CM chips do this currently.   I've been asking for
this behavior for years but I have limited influence on what happens
in HW.

>
>
> > This simple handler determines if the PCIe controller was the cause of =
the
> > abort and if so, prints out diagnostic info.  Unfortunately, an abort s=
till
> > occurs.
> >
> > Care is taken to read the error registers only when the PCIe bridge is
> > active and the PCIe registers are acceptable.  Otherwise, a "die" event
> > caused by something other than the PCIe could cause an abort if the PCI=
e
> > "die" handler tried to access registers when the bridge is off.
>
> Checking whether the bridge is active is a "mostly-works" situation
> since it's always racy.

I'm not sure I understand the "racy" comment.  If the PCIe bridge is
off, we do not read the PCIe error registers.  In this case, PCIe is
probably not the cause of the panic.   In the rare case the PCIe
bridge is off  and it was the PCIe that caused the panic, nothing gets
reported, and this is where we are without this commit.  Perhaps this
is what you mean by "mostly-works".  But this is the best that can be
done with SW given our HW.

Regards,
Jim Quinlan
Broadcom STB/CM
>
>
> > Example error output:
> >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> >   brcm-pcie 8b20000.pcie:  Type: TO=3D0 Abt=3D0 UnspReq=3D1 AccDsble=3D=
0 BadAddr=3D0

--00000000000083bd50063bb6a51a
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBp/vFNImW7Vr6hm3XbiFlOesZNCkCZ
2fl9D0stn9cGeDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4
MDYxODM4MjdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQCcEPCcK+1txycpUu0+y/UdLh3Y3WYHjPboo8of93QI3oabJUtSd3NK7f65Q5xPpQh5
pVqOKtffEgIN6ngj7IFlIjj6QurVubvbFwYpUviLsdKaRXZHVRWgL9hAbfDy/rfknEECINhKFGdJ
SW9d+c2V1achZ+qZ6fW3vPllTc1p2XbNchdqKopuY45ELhqsAxps15NKk5ipW7lEpHTqcVxvcu2Z
Evmy2s3C9Cd2HqPeMfBuO5WPJhOd9lLUKTWSqXKRUCBYOUFlMW0ldHRobS6cYjQs3LtzPgzC0m9e
M4D84Zxlb8H3nNkLqsaXKo1edW32PIncl2ZN5FdBmU79FcCH
--00000000000083bd50063bb6a51a--

