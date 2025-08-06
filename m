Return-Path: <linux-pci+bounces-33475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B537B1CC68
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A263C7AC4BB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6817A305;
	Wed,  6 Aug 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V2xK/y/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BE482EB
	for <linux-pci@vger.kernel.org>; Wed,  6 Aug 2025 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507784; cv=none; b=tMXwZ1wJgmCPPlbqyZI1QptjCuLtU8Kd40PF8IEafVuspIcX1djnUFwsUUD1Vk/2cNBZUWZR3FSJ78EjkyTFQdqlSG9lF9lbrZGFjQtKW9yeKLLiR2HhJaHheOh4QzgAAR+dnCJTzRhxZWG/nweD9OqKzeK0lbFdseBmj7elyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507784; c=relaxed/simple;
	bh=Jno/pigUcHL+P6KsBd5NivjsLRkWdzp0he1yjru2MyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUrZNrcH72Jr00umECiCtJ9dqBO4fROq9DuHyrWTMOlNKX0tPSF86A2qZLWvRuALbgoq0gU89/IlhkF6mZdCJpIuAXuxPK0DWcEfGoUiRCAjep+QL19OWL8gsv/daQhLKTbkWW7P+h59E+TPr+N1Zd/FPhP9zAS4Uzv9LJcO6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V2xK/y/c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af93c3bac8fso27822266b.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2025 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754507781; x=1755112581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VsPZbF8sF7pvrJCBq2LfmIztFZld6xqBBxvxFHfV0FU=;
        b=V2xK/y/cKTEn05euagry9MqY6oSUc+rLK0FU5zx7DpXmX/wAU/jey0JrnZllpArshd
         MOo3qw6+irHqG1/fgsPsni0/mU+k7KBnXUgIVA8uNcx7A9s60eqsatUgf/+P0v3gil+T
         VAW8PlyfO/A8BAvJ+D0+PSBYhKMmjEKOHcH7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754507781; x=1755112581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsPZbF8sF7pvrJCBq2LfmIztFZld6xqBBxvxFHfV0FU=;
        b=v6QmXv2YqFdhww7+nLExHc6bDbmBMKpxo3kU332IW3Zxg+8+qBx4L3OdUiOK3bWvVv
         n2AKRYW1qFCxl7n/rO1sVtcxxCyN50NYxjjB1S5axRAHw7fGN5aT0WJwHLLEWovlLGVS
         FHwM0I2WSjxosx4Gu/JikQCQ3oI0Qac/8TRZbNOyy4b13ZMQeXwku+7jA3BPcQti42Rm
         aqrxxaygYEb0xW8n17XAMB2o051ogzg2i6d1R+SaGf5SdoLP2V3aWuP2LGNjSEKWaw7N
         4Y1YX68t43FJj4B1Ihs/dU0ePvF+rgAvXHT91anLuP/QwuQaNIDMlvLRvbVDVGF/SYnC
         tm+g==
X-Gm-Message-State: AOJu0YyvY7vS2fShfDA6thMfEqaXs+terc1gBC5CmXKB/DC9qOHpD/ic
	aa88pt4uRqQukjuYLuHOb4XNGm5B6tdtv4qT7BgFchGUqD1rP/U9qhByt/jLtCPmIrSCDGvu7Oq
	zbUNxYisjQLUJ2qdf9+WTtBs5uxeYzh/VrdY4akZJ
X-Gm-Gg: ASbGnctT6I9L5gzqdAnvJqNCDWhV/0ePtHDgBcq9oByL5zx+QXjikpXxyg/SdTmogif
	mFXeM4KtT2dujs74Gqlq178XPU0i6226Dq25mtoRZeB5KX8dWaURz97wB7M4M9Y/Hn6t9n7X0t6
	scxujiPrryvPE0/u6WOvQ/PCv+OLn/4En+xhCu5Cv8Rn+4BAG6hfrGECVqnfey56Zfyexr85+oo
	Y+vNLO9
X-Google-Smtp-Source: AGHT+IG5PgMiPi5vTsTJMpsSD9exe2HPclqAjzu7clyfZBo+ywIxmAmWVqAXxbQw2TJXnXncFsVAt6+lEBs9JVJhcuY=
X-Received: by 2002:a17:907:6096:b0:af4:148:e51f with SMTP id
 a640c23a62f3a-af992a37d1fmr341409266b.2.1754507781367; Wed, 06 Aug 2025
 12:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNzq_BV_fK9T4LK0ncZuufqp9E9+DUyFU3jKCnSCjN8n-w@mail.gmail.com>
 <20250806185051.GA10150@bhelgaas>
In-Reply-To: <20250806185051.GA10150@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 6 Aug 2025 15:16:07 -0400
X-Gm-Features: Ac12FXyBLfo1yVe-yTHEhU5KFOqY5PdlkvhxinBq3xRZvzWmEfqkV1u6Ov1u_vQ
Message-ID: <CA+-6iNzAUpMfP8z=zXbQsz=4=YMYgxdSbpDucchECieqpzAzwg@mail.gmail.com>
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
	boundary="000000000000185bff063bb72d20"

--000000000000185bff063bb72d20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Aug 06, 2025 at 02:38:12PM -0400, Jim Quinlan wrote:
> > On Wed, Aug 6, 2025 at 2:15=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > >
> > > On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> > > > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the=
 like,
> > > > by default Broadcom's STB PCIe controller effects an abort.  Some S=
oCs --
> > > > 7216 and its descendants -- have new HW that identifies error detai=
ls.
> > >
> > > What's the long term plan for this?  This abort is a huge problem tha=
t
> > > we're seeing across arm64 platforms.  Forcing a panic and reboot for
> > > every uncorrectable error is pretty hard to deal with.
> >
> > Are you referring to STB/CM systems, Rpi, or something else altogether?
>
> Just in general.  I saw this recently with a Nuvoton NPCM8xx PCIe
> controller.  I'm not an arm64 guy, but I've been told that these
> aborts are basically unrecoverable from a kernel perspective.  For
> some reason several PCIe controllers intended for arm64 seem to raise
> aborts on PCIe errors.  At the moment, that means we can't recover
> from errors like surprise unplugs and other things that *should* be
> recoverable (perhaps at the cost of resetting or disabling a PCIe
> device).
FWIW, our original RC controller was paired with MIPs, so it could be
that a number of non-x86 camps just went with the panic-y behavior.

I believe that the PCIe spec allows this rude behavior, or doesn't
specifically disallow it.  I also remember that there is an ARM
standard initiative for ARM-based systems that requires the PCIe
error-gets-0xffffffff behavior.  We obviously don't conform.   At any
rate, I will send an email now to the HW folks I know to remind them
that we need this behavior, at least as a configurable option.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> > > Is there a plan to someday recover from these aborts?  Or change the
> > > hardware so it can at least be configured to return ~0 data after
> > > logging the error in the hardware registers?
> >
> > Some of our upcoming chips will have the ability to do nothing on
> > errant PCIe writes and return 0xffffffff on errant PCIe reads.   But
> > none of our STB/CM chips do this currently.   I've been asking for
> > this behavior for years but I have limited influence on what happens
> > in HW.
>
> Fingers crossed for either that or some other way to make these things
> recoverable.
>
> > > > This simple handler determines if the PCIe controller was the
> > > > cause of the abort and if so, prints out diagnostic info.
> > > > Unfortunately, an abort still occurs.
> > > >
> > > > Care is taken to read the error registers only when the PCIe
> > > > bridge is active and the PCIe registers are acceptable.
> > > > Otherwise, a "die" event caused by something other than the PCIe
> > > > could cause an abort if the PCIe "die" handler tried to access
> > > > registers when the bridge is off.
> > >
> > > Checking whether the bridge is active is a "mostly-works"
> > > situation since it's always racy.
> >
> > I'm not sure I understand the "racy" comment.  If the PCIe bridge is
> > off, we do not read the PCIe error registers.  In this case, PCIe is
> > probably not the cause of the panic.   In the rare case the PCIe
> > bridge is off  and it was the PCIe that caused the panic, nothing
> > gets reported, and this is where we are without this commit.
> > Perhaps this is what you mean by "mostly-works".  But this is the
> > best that can be done with SW given our HW.
>
> Right, my fault.  The error report registers don't look like standard
> PCIe things, so I suppose they are on the host side, not the PCIe
> side, so they're probably guaranteed to be accessible and non-racy
> unless the bridge is in reset.
>
> Bjorn

--000000000000185bff063bb72d20
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCkGeYeIHmyIv+2G9CO8ooLbCNTgqYA
UtRwlgVUD/MWyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA4
MDYxOTE2MjFaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAEAI1ZkIT6Lu5PsxJrIWKb/MLYzg2fXvl3fDLACcuGtYg5EQFMpBkPNWxqya3bfOw8
wyIUWatND/rQRjFBzXNeQzF9LwdqnbEhYdX4tClJh1Ysh+EBDwsfUPnXX0W4pbWNkfEDN8vz7LkU
sJAkkgurBOAe2uBizQSx76zwFZEcwRvPUhkAwfABi9G3qstpTRe7+yavpCMuu2iC3/MuFGlaFlmu
AXo9o8yYJ4M5QHdM7cJlOBb1FmpZ/XSK+Pz55JqBDa5hHe23YD2Hog8zHbzkLUlczlcEnfIWtZmn
xDnc2R4SKzoObQIB3RmKeexewUbm8NaouI4Nq2HnUrgUZ1JX
--000000000000185bff063bb72d20--

