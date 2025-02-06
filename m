Return-Path: <linux-pci+bounces-20831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61EA2B269
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 20:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB7A188A996
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0F1A7044;
	Thu,  6 Feb 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KYHDdawx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972114B080
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870799; cv=none; b=WzoTkj4n6/NxwbpgtFPLRWVCwR+HlY1Ojv1LCMNN5urCD+/Kd7RZnODV0FKh8o6sd6jV7PurGlZdoIXVInD9471Sk1uoOrTvtcfK63oLwmB8T/SCnvUXDYclzrYv+Y8LpVJhlptSVE/3LKWYWuW3dZF8nQG0ujR7otnPB0k77YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870799; c=relaxed/simple;
	bh=IcBVv7uogk3Gcq7lC4MKBHYZmcMW52Y4C+9kMluoJ/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcQFVu6BGSBI9Nhqi/8KctW3BwGwBFzzJ/ViF1xJ0Xq8lXomdFRLWGD336LjCyR2YmLSXKPNbO2HNnSN1iqyGH5HBjOyqnF8VMW6xXZPzR8a54KgNNDEFtIlFYZOp5vIy0tBSOqiVL2VCiD0hDAaqNxt4/Pic/mQmO6DqwaLrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KYHDdawx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401be44b58so1459579e87.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738870796; x=1739475596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GOuVogMY0RFo7mw6uHOmIMK2eA8OnPPaUqKxSSUgxbo=;
        b=KYHDdawxolUb7qvUqVlnZo2rIJEvFxdirxy5116A0pAGw2hzHwLTUrDt7J1hKvHvOc
         Urt+wt28TX6wA/uhjp4QlqWX3Obe/wpj+RpfUFxIW+gTNo9PYgG/7JaErLmGxff93WKz
         HE+7Lwe3RVKJlbn50bUP2ubUrOWRUMWTepFAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870796; x=1739475596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOuVogMY0RFo7mw6uHOmIMK2eA8OnPPaUqKxSSUgxbo=;
        b=hl9GW2rRlMEF1kHAsxyLvQaF87paXZqtWZJ7j2Ext/bEb81gwQpKIXhTweNhP36lfa
         ULbEqOIRZY3TKlSI/TX4lNgkxRTKURrsXGFA8uWFK2nvulC1iz7YYedfXNqsZbnLB2YX
         6f8KcRGMWbe6ofHmdThXL3vAFQn7OGvAVlm0nCE8cfmBYG5MMpTSKNIRBno3nFehAOpR
         4KU3F92qbNF/HUSqbM6h2EDqmFCTlHK/x4N7q2EIAwdv1ynplavhEmSZzMb8wPUTc2aq
         PX0T9j2AsSVZz72Rnj1JNX5y+WeJX8yzd66YeqdD6AtLK9l4dipGxQmiD3jUD5c38t45
         694w==
X-Gm-Message-State: AOJu0Yx0ld3TJqQ08jhmcZtIzLsdT++WQkO3fQ2qcIBn91pqUN5dmbYU
	BbOYslW4HB8EuBWcZs0dhuFQMCSHyv6CCNjoJkANUuiul8UK779SosNGzAhFinwD1KPVoexkp9N
	z7tHOdYR2SWvMbTb32QHCkJC/yy4Ao3IZa9Gc
X-Gm-Gg: ASbGncvuUB+3FpmsIBy258EVByKtHGzs0MBRvIjqnRvIX51lkfs/Bhb6N6zvKBrLM7h
	hhO5BVDhWfW5+KZzQqcLbzmRUnprOdyyEoJrbuYMb9ReuXzLG31akJAYY0XFzE4wVZPPI8mfF9A
	==
X-Google-Smtp-Source: AGHT+IEcLjm//BRgdSvW6BdZVtXln0kkGrDo5VDCw6zizTEiDrZsnTY6/xpZnzEp0UWLsdq/tQ4o0WfZNT4rm70r4hg=
X-Received: by 2002:a05:6512:b9b:b0:544:ed0:b686 with SMTP id
 2adb3069b0e04-54414a9cbe8mr51784e87.15.1738870795950; Thu, 06 Feb 2025
 11:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNwws3On9-VJ-vF55o5LwKYpOHtfRYLtoQ5=bh7uGTfYkg@mail.gmail.com>
 <20250206183455.GA994612@bhelgaas>
In-Reply-To: <20250206183455.GA994612@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 6 Feb 2025 14:39:44 -0500
X-Gm-Features: AWEUYZmJV49J_V5lCzC8oSRhkYqAedlRPse_RFiaEYA4qurfDTZPYmCNEGGz38I
Message-ID: <CA+-6iNxz-==Ws-EZTBbSzqmEApAX=bsq9=x=3=Z9G3kqxD53Hg@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020f4d3062d7e68b8"

--00000000000020f4d3062d7e68b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 1:34=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Feb 06, 2025 at 01:22:54PM -0500, Jim Quinlan wrote:
> > On Thu, Feb 6, 2025 at 12:29=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Wed, Feb 05, 2025 at 02:12:02PM -0500, Jim Quinlan wrote:
> > > > If regulator_bulk_get() returns an error, no regulators are
> > > > created and we need to set their number to zero.  If we do
> > > > not do this and the PCIe link-up fails, regulator_bulk_free()
> > > > will be invoked and effect a panic.
> > > >
> > > > Also print out the error value, as we cannot return an error
> > > > upwards as Linux will WARN on an error from add_bus().
>
> > > > Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulat=
ors from DT")
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/co=
ntroller/pcie-brcmstb.c
> > > > index f8fc3d620ee2..bf919467cbcd 100644
> > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > @@ -1417,7 +1417,8 @@ static int brcm_pcie_add_bus(struct pci_bus *=
bus)
> > > >
> > > >               ret =3D regulator_bulk_get(dev, sr->num_supplies, sr-=
>supplies);
> > > >               if (ret) {
> > > > -                     dev_info(dev, "No regulators for downstream d=
evice\n");
> > > > +                     dev_info(dev, "Did not get regulators; err=3D=
%d\n", ret);
> > > > +                     sr->num_supplies =3D 0;
> > > >                       goto no_regulators;
> > >
> > > I think it might have been better if we could do the
> > > regulator_bulk_get() separately, before pci_host_probe(), so that if
> > > this error happens, we can deal with it more easily.
> >
> > Keep in mind that brcm_pcie_add_bus() cannot return a non-zero error
> > code, as it will get a WARN() from the caller if it does.
> >
> > Would you  accept deallocating the "sr" array and setting it to NULL
> > like the following error condition does?  In that way we would not be
> > invoking any regulator_bulk_xxxx() functions with nr=3D=3D0.  I'm reall=
y
> > wary of moving things around...
>
> Yeah, don't move anything around right now.  My wondering is just
> about whether the alloc and bulk_get() could be done earlier, leaving
> only the bulk_enable() to be done in brcm_pcie_add_bus().
>
> The alloc and bulk_get() depend on DT things and it's nice to catch
> those errors earlier.

IIRC, I believe the reason that this code is in
brcm_pcie_{add,remove}_bus() is because the reviewers wanted the code
outside of the RC driver, as it was the port driver that "owned'  the
regulator.  I also vaguely recall one of my submissions that had
generic pci_subdev_regulators_{add,remove}_bus()  calls in pcie/bus.c,
but  was  later redirected back to the brcmstb RC driver.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> Bjorn

--00000000000020f4d3062d7e68b8
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAHXCadyti7wrHNm0RaYE58d9lufGDA
rpDfVD/f0wT5UTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAy
MDYxOTM5NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAp/SsdJlI4AzqdMYTvmdQDTNHS+DdQnMN7GkLqf2R16n/ycFa
NVOb05deVoMqimoJxG0BJgwlgIdEYiw55tmEgjDmKcoNnlVxpmar8u/jrtCub4DqYOmwRqcO8Awz
VNz88W05eAt9Am9haTYqKPR3eBAfRbVYYSHDEzHDl+rDY8HvEmyRl1TuSW+kp+KFsdXlolJ9f7/N
8L95PVWhERX5Fky/BUm4xFhbsW0gAddFx2DRIv0I2V3+L54lKcGGPzKcC9zEI4cT+gjbNoFmzD+w
5iUrX9/BXty5Dmh0qBiluLtsnFqQ+E9JaAy06Gjw8wQoFYyRr/wFf078XaoKHyVmnA==
--00000000000020f4d3062d7e68b8--

