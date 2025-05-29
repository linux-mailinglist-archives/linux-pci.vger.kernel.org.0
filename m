Return-Path: <linux-pci+bounces-28680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF75AC828C
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C251BA5F4B
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795AE22F749;
	Thu, 29 May 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dRhejdib"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EF4685
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546625; cv=none; b=ZiSr2YjKmtPDkJGXGc13nNnNIk8eapXeRUk8G+GQqHTFLlosRyZ6FUyiCEQe/bsDPNL22Z15JB24QmOaOHkLo3RsaVc2qwTiK7pIKM4+xAWEm1H/psLbjAegtAqErwpVdxJYOJoKtO6gSCDmXVMyc1jB3rnlZfNpHlGy1eHimes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546625; c=relaxed/simple;
	bh=BfLMTjWAWoTC9sKNURs9OAS5QVxrwrwIUW3VEOpbkuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZpR9UbCT6SpdUTTzTGS+AIxhGi44EARys25ABC/+DN4/0h+L1G+7ww2voktIAcIR9Uw2Vyffr4iDHn3vFg70lU15Kl/zay6wYzBMggWQUsvU3UaBgW4Rn1GeEOmV+sFyQ5kXu4tmNstgV+OaUs+DKLfc+G+8iW4iPDaX5vLG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dRhejdib; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3106217268dso10945871fa.1
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748546622; x=1749151422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cur//Q5wt3ilWl83lFSXe08v9Umk2FTBkYeEPHEuQx0=;
        b=dRhejdibQOJhjXMkMYrDI3SzEmt9r8NnKqqiemlyRaDQzRaOnQoBRc7C5td8wtuHs9
         qjLAisdZv90jEKMFmX3HaXtxYVtly091Qe7+ElG0UZiZjrMzK4lBIB30yBcO0rydBXB2
         l+pkkphQnnkav7TFh3SRGkpL5dhbZ+6PqMVAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748546622; x=1749151422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cur//Q5wt3ilWl83lFSXe08v9Umk2FTBkYeEPHEuQx0=;
        b=BaLe++uV+69AFN4WRZThYiB1vh+KPwufdHJWNok+ZdJBCV6yvfwBMI//K8JoON/3e8
         lNUiIPuPKF4+0IQ1C/wFDOI9ZeY3CDHT8Z+F66ep6NxL/DF8K/hpBF4oME6zE5A2oPx3
         WEgUTYycJiLsK7XwtstW5MPxf3KtM8G+QaY/GTgCjRpO2Uu9cEmnD7f55HQ1mvnwxi6m
         2wkCZFNBKkAhApovJyQHt+sYWLKLX2mOM7V3NtevvYsQzK7np1pVrTYCqoYny9bzwgdB
         LZVvDRbqu8TbeYXoshQxKyhJymUxwVhQlGQn+0THGb9Q+0US8oA5fe4yGaV/hHy8fdSB
         yruw==
X-Forwarded-Encrypted: i=1; AJvYcCWuPWXHqunuyQuFv24EzvqWN2Ac+Wc4GRgob07LiXeG9BRreuW+tXlU5GVgHiIZoBZfrjnrveKPjYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9XM8ZzmqaeB8Zk7MmuhrZ+bKD+FfJ2dwxS6ZeQBUSQQWFoE5
	lOlZxuWOdiuUTPlvFtRH3FYzpKArXEKWEEPwi8quj5PguziwXy7ZnWDo3VCHt5YOMUkvbBaPLml
	raYmMs3c63IliO+AKvhLQkTWQ/m7cgSUpvNDvb0gF
X-Gm-Gg: ASbGncvoUuH10Ca/RWTGLFfRmpVlWThYc9Z7d9YaULLXWUqepbNXvO3FzIXENDLy7w5
	F4ECsSglN3/QQbS/GkUxhZHxJF+aUoMNxJGVmMwhzcH/bxoUEUXhNoeoQ4KcBgt9a2vtXMqhvP8
	VJf04Kvcp25terRckct3849KQyF/7dwHGEVPXvZDm8nhLt
X-Google-Smtp-Source: AGHT+IFU0LiRV9mduSfE3PR4aRK5bofXn9ifiIvhBugdGNNPAgIQSIdYOij+L+yLfsmiilJ3AThd1kNUHDF7On0NAek=
X-Received: by 2002:a05:651c:1103:b0:32a:7e4c:e915 with SMTP id
 38308e7fff4ca-32a8ce408d1mr3492621fa.29.1748546621659; Thu, 29 May 2025
 12:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nt2e4gqhefkqqhce62chepz7atytai2anymrn6ce47vcgubwsq@a6baualpdmty> <20250527222522.GA12969@bhelgaas>
In-Reply-To: <20250527222522.GA12969@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 29 May 2025 15:23:29 -0400
X-Gm-Features: AX0GCFsXm4jiw3FIwYBqmdjKyrwhBvYxJAhJfSeTVOmzvLf0JA8I65wjPQ6b84Y
Message-ID: <CA+-6iNwo54tp4pvUGHXYjbV8sT6FWhSrd2k4pDJgtUGQWYhGXg@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-pci@vger.kernel.org, Cyril Brulebois <kibi@debian.org>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	"Krzysztof Wilczy??ski" <kwilczynski@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000048349706364b3ca9"

--00000000000048349706364b3ca9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:25=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Sat, May 24, 2025 at 02:21:04PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
> > > On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> > > > What I would prefer is something like the first paragraph in that
> > > > section: the #ifdef in a header file that declares the function and
> > > > defines a no-op stub, with the implementation in some pwrctrl file.
> > >
> > > pci_pwrctrl_create_device() is static, but it is possible to #ifdef
> > > the whole function in the .c file and provide the stub in an #else
> > > branch.  That's easier to follow than #ifdef'ing portions of the
> > > function.
> > >
> >
> > +1
>
> I dropped the ball here and didn't get any fix for this in v6.15.

:-(

>
>
> Why do we need pci_pwrctrl_create_device() in drivers/pci/probe.c?
> The obvious thing would have been to put the implementation in
> drivers/pci/pwrctrl with a stub in drivers/pci/pci.h, so I assume
> there's some reason we can't do that?

I was wondering if we could confine PWRCTL/_SLOT to work on a per PCIe
controller basis.  For example, if we allow the port DT node to have
boolean "pwrctrl;" property, it would direct the PWRCTL code to
operate on the regulators within that node.  This would allow
CONFIG_PWRCTL/_SLOT and the pcie-brcmstb.c way of controlling
regulators to happily coexist.

One could argue that "pwrctrl;" does not describe the HW as a DT
property should, but I think it should be considered nevertheless.

Regards,
Jim Quinlan
Broadcom STB

--00000000000048349706364b3ca9
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCgRixlGaSf7bCIPZfapNP3zfRMfvki
csXY3T1XdmxBNTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MjkxOTIzNDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAkH6WUgINS2xaxZiy5d7UJ2chm4eQBCIiK7F4lprDpamsPe8TQj2P80I/zK9t6ZNFt
VR4dbQk/qhzZLS18/qlOeXJuMG5JI0+hF5/6XwfMczw3vLf2PI6OnXrXbjWcVvk4ovxQuVC6A90K
IKWPwm7V39ZhWOTVnlLneVVB0L7JGIrQN4ujA9Jvtro+Z3verKBkp/Ctgl8eVy9mlJAIQQw/ZIq7
QJdnQczW4BTqSemHXXHqz55wFHBP205sW6URr6R2YdNsCLfcCSTcmbkpLt4BBeCKbrk0IJmFnSbG
8KRLkmebRndkMgj/SFHOerdzX4MTQu+i5gykXSJVD0POdTxz
--00000000000048349706364b3ca9--

