Return-Path: <linux-pci+bounces-10973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B205B93F94A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AA81C219A3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70B156669;
	Mon, 29 Jul 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B53MDOMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3A13C9A7
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266664; cv=none; b=NHuT6z+Yp1oJnLL/fcK7HSGueMN7KChZCFqRd69Itk/R/lUQhLkDCgSHz26W4O57E2ZP8y88qKYzU1Fc5tub7IOjUByBeSclefeLH5b1rIrcnNr7+7uqLi7nTX8RqppbH6hnxAZbhslhZ5epAERq0DOsDFAhfViMPzc5gegaeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266664; c=relaxed/simple;
	bh=+5jgNVVweCfvtasU26HTIekxF07BevkiA0hGiNuxclk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy17hf0bgFZLM3yEKadYpxJcFXMl8Rz87iHqytlsP9Z3tJKeUKx2k06xfwHRljTc0EfEd2zfZCySuI3ngCDvb9gBsADBU91NODnBLcx2k4S+iAdYGqeE5ShcPoX+uIsVxk7IuAi4lrrvJHAIvJwA0S/XMLzhmncss9Tw15WU+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B53MDOMR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so29193981fa.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722266660; x=1722871460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uypyab18/Tk9ghN9C1+zgNq9FOnNpr6Y9ZpF09LuBMI=;
        b=B53MDOMRqKwRVv2oPV33H7KhdF3MJ+KFEIFgwYcmrlcI4+JyXsZM4Q+5yQs2oljv+e
         yRIArXjyMHcyWwT18NfLfOvbBmL2bg7kCqnFSKsata1lsT2c+0eQF7PMJ2F7ChNGXPiD
         VKfpV1of7GFT4UYeErIuirvkxHGgqjp4q4wSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266660; x=1722871460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uypyab18/Tk9ghN9C1+zgNq9FOnNpr6Y9ZpF09LuBMI=;
        b=Ya4WUKuQVErvc5jQBXKC1mv9gIotOz/2GLY187aUUSldwph6R4pkKPCqul4RBcqYNN
         Y3+TeJNznPvEOvlrXmSMiIn8UFx+IaTfXRcIxHLQHVptYWxdKjUGzLeh9n5u6z6h1XNa
         xOMVaxsBVg1OtIfvaJ0JNTsJBcCdPEd/Dg4PrfhXs+KeSaLmTlm7AaAinGzY1wpbQMJn
         SuncD8H6v8swxm3KZXCqZwmGzWGEpwNd5j8W+DjN9Bn5sphlau3OTWVbRt8jVme2UthH
         Nw+WO9aCuRYkE8ulrxzwntnPn6XJ7DaTus3hrn+rKvqme6piTfR851R9E3bKk5ojIzZo
         sV+A==
X-Gm-Message-State: AOJu0YydmSi/1Gz9rH/LN0sqD1PJWwIZtgMI17b6jt8bUaPm1M2qwWJL
	MX5g88kMzAFF07LsddaAK0awNKr1wUy1jhO82EYKf6LrWT2QaJm7lJ09pweSo6upCkBnh7j9OWp
	BX4tFMbSM2RNiNiMzqIe9l0uTFODNGD3eCQidBjdHh+AL5yc=
X-Google-Smtp-Source: AGHT+IH0vpbCw0jo7vxBObrl1wvldYLE88ZP5DcaeGMMDQBuLmQRFG3gjcASk2kXHJC1vgYuNwMfaKH7HOaQMe+q6E0=
X-Received: by 2002:ac2:4c56:0:b0:52e:9558:167c with SMTP id
 2adb3069b0e04-5309b6e1d9emr2381647e87.10.1722266660055; Mon, 29 Jul 2024
 08:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com> <20240725043111.GD2317@thinkpad>
 <CA+-6iNz9R5uMogd6h+BkgRvKrsmyH2VXsGO_5e=6yqC=JzjigA@mail.gmail.com>
 <20240726050423.GB2628@thinkpad> <CA+-6iNzpfh7_rXUEXNjZLCLQKu-e_bYMAO6PdKaxqReJRKjuAQ@mail.gmail.com>
 <20240727064013.GA2974@thinkpad>
In-Reply-To: <20240727064013.GA2974@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 29 Jul 2024 11:24:07 -0400
Message-ID: <CA+-6iNwz5PD__OhDrOZWws8i-3uWELxk1hBb-xFt31gp0bi4Bg@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000851252061e6474f8"

--000000000000851252061e6474f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 2:40=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Jul 26, 2024 at 02:34:54PM -0400, Jim Quinlan wrote:
> > On Fri, Jul 26, 2024 at 1:04=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, Jul 25, 2024 at 03:45:59PM -0400, Jim Quinlan wrote:
> > > > On Thu, Jul 25, 2024 at 12:31=E2=80=AFAM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> > > > > > o Move the clk_prepare_enable() below the resource allocations.
> > > > > > o Add a jump target (clk_out) so that a bit of exception handli=
ng can be
> > > > > >   better reused at the end of this function implementation.
> > > > > >
> > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > > > > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++----=
--------
> > > > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pc=
i/controller/pcie-brcmstb.c
> > > > > > index c08683febdd4..c257434edc08 100644
> > > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > > @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platf=
orm_device *pdev)
> > > > > >
> > > > > >       pcie->ssc =3D of_property_read_bool(np, "brcm,enable-ssc"=
);
> > > > > >
> > > > > > -     ret =3D clk_prepare_enable(pcie->clk);
> > > > > > -     if (ret) {
> > > > > > -             dev_err(&pdev->dev, "could not enable clock\n");
> > > > > > -             return ret;
> > > > > > -     }
> > > > > >       pcie->rescal =3D devm_reset_control_get_optional_shared(&=
pdev->dev, "rescal");
> > > > > > -     if (IS_ERR(pcie->rescal)) {
> > > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > > +     if (IS_ERR(pcie->rescal))
> > > > > >               return PTR_ERR(pcie->rescal);
> > > > > > -     }
> > > > > > +
> > > > > >       pcie->perst_reset =3D devm_reset_control_get_optional_exc=
lusive(&pdev->dev, "perst");
> > > > > > -     if (IS_ERR(pcie->perst_reset)) {
> > > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > > +     if (IS_ERR(pcie->perst_reset))
> > > > > >               return PTR_ERR(pcie->perst_reset);
> > > > > > +
> > > > > > +     ret =3D clk_prepare_enable(pcie->clk);
> > > > > > +     if (ret) {
> > > > > > +             dev_err(&pdev->dev, "could not enable clock\n");
> > > > > > +             return ret;
> > > > > >       }
> > > > > >
> > > > > >       ret =3D reset_control_reset(pcie->rescal);
> > > > > > -     if (ret)
> > > > > > +     if (ret) {
> > > > > >               dev_err(&pdev->dev, "failed to deassert 'rescal'\=
n");
> > > > > > +             goto clk_out;
> > > > >
> > > > > Please use a descriptive name for the err labels. Here this err p=
ath disables
> > > > > and unprepares the clk, so use 'clk_disable_unprepare'.
> > > > ack
> > > > >
> > > > > > +     }
> > > > > >
> > > > > >       ret =3D brcm_phy_start(pcie);
> > > > > >       if (ret) {
> > > > > >               reset_control_rearm(pcie->rescal);
> > > > > > -             clk_disable_unprepare(pcie->clk);
> > > > > > -             return ret;
> > > > > > +             goto clk_out;
> > > > > >       }
> > > > > >
> > > > > >       ret =3D brcm_pcie_setup(pcie);
> > > > > > @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platfo=
rm_device *pdev)
> > > > > >
> > > > > >       return 0;
> > > > > >
> > > > > > +clk_out:
> > > > > > +     clk_disable_unprepare(pcie->clk);
> > > > > > +     return ret;
> > > > > > +
> > > > >
> > > > > This is leaking the resources. Move this new label below 'fail'.
> > > > What resources is it leaking?  At "clk_out" the return value will b=
e negative
> > > > and only managed resources have been allocated at that juncture.
> > > >
> > >
> > > Right, but what about the err path below this one? If that path is ta=
ken, then
> > > clks won't be released, right?
> > No, that is the same situation.  The clock is originally allocated
> > with "devm_clk_get_optional()", i.e. it is a managed resource.
> >  If the probe fails, and it does in both of these error paths,
> > Linux deallocates the newly formed device structure and all of its reso=
urces.
> > Perhaps I am missing something?
> >
>
> No, I missed the fact that __brcm_pcie_remove() is freeing all resources.=
 But
> grouping all release functions in a single helper and using it in multipl=
e err
> paths even when the err path need not release everything the helper is
> releasing, warrants trouble.

Got it, I will address this.

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

--000000000000851252061e6474f8
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAWWPMFo9nBpPBz4RmGiQntDOAmXZdZ
yUKy8LQpVWe//DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MjkxNTI0MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAmaygnzqh1ai5dqtbXgK8qxyhLGNjXCAf1J4j1EyLYS3MWQOJ
qsAcBByBKM6bLfSOTpKqSyRzUGLpsjcv+ggfvgK2g8W4VS+okuvVxhaNzSdoWf+dtlKDygkXPhDQ
Hvdy1pNH33IXPmCDku2MElg4aFTyeWYyZXN+yZc6G7Av9yIm/5Rp5OTY1wT05VGSrKq2pOLK5q6B
QY+ns7euMpGogN9+F+AlO+4svvt4o8VKFk/y/qstJDOuT/6glh36ydvwwB6OapTPzzmneLekJVsK
nEEn9rjp6/ZzVhag/4fXCMliWjwVf/HXNJYClRKSQKgs0/vw3+eMTeYQ1AZizr6NSQ==
--000000000000851252061e6474f8--

