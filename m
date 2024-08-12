Return-Path: <linux-pci+bounces-11602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5094F688
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1195B20ED3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DD1898F3;
	Mon, 12 Aug 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJsxaMic"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59916EB7A
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486827; cv=none; b=cRCD04CZ2CJpDC59hd73hImnWJaGrRtEg2Nu/CJ36MD8BbVJe0RW4QRbw64vMaia+P2aFdiN89xVSRJ1/olLjIHLHjAwr8AyyzQ93Ybf+GucEJ44DCLkqq1PfN+19XYc8ueZ08rZtkEu6qBnCTAikIyDJVzd1o6pxeETrhfg0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486827; c=relaxed/simple;
	bh=rArC0baWENHv/jxYDmdE3Mo9xk/o7+IJQj3xqoBtoCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgdVJSWMynK34qs5P4BJcZT9+OJDr8PDLIXljonSyvaSd0Vyq/5kU/xCQcr9DjuifhOYFCDj+GzBO6TNqJqQ5V3jnpLny6XRJt8RK7yvxoHl34IQDscdb+oiMw16syXa/eEVxlTkf5yKisXGyTLNDCzmsfj6wLEo+ntGATOxSFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HJsxaMic; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so9357987e87.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723486824; x=1724091624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMGvGgHmXXp/UnuzxA5CQe6odzq4R2lTHL5np/dJEVw=;
        b=HJsxaMicNRokz3+eIE23s4asv4VxvqAy3z4IR8m5lHOfXtg0R6xHjktjCREXWdz8dY
         mFippD4glHMmkMWzmqTauqHVXC1KTf1xiCjTWiiaMKkadOeovgvsUQLGX88R++alkAtc
         MnGmZyqqR9ra4Fnd8+0X0bb4XlHhyLMsBtZcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486824; x=1724091624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMGvGgHmXXp/UnuzxA5CQe6odzq4R2lTHL5np/dJEVw=;
        b=uMPTp45zyfAlr4ajvjv0Dkzhlhi0ke/Vdyprzbx/paPbWsN37xLaDgv8nYrmOOR/HH
         INStNyHjKM8HBADmqXK101YCY0iCj3U0MK5iCI2jB6zpEMdoVV8Q4r+4eDDV83atf8W5
         99oi/NbNijMuE2s/hBEMAwaSdUC3OlM6hOyY7lCv0EVG0rKz9PMfTx1EHzzmPmiWq5ZQ
         n/dS5+Ap4EWgycqa51QqZFt2wTjf9NitAd7jePi3CP+SONPdOdWxeDec7H1InSktw+f8
         CmfxZ9Oe9tD80nLyqdoTxyiV5bQbMDYmidtq7OgT64AwIF6h9wu0Rx/fYK4dx7zcseVr
         IJDQ==
X-Gm-Message-State: AOJu0YwVmW7y/F+K0rS//kL021eIMGH5MBKb4R7S1N1aM9gY3fU6uQmE
	o9xfSTZDqOjKgtrFXGWi7L5WIEHg6eW4JPRDfsisVjtRGoWmnvAWf0VvtWdTvryOWvXWvtX7cp+
	T8jrDKM9HluXTdouyQAV5RZh/ee5AhugZ2F3g
X-Google-Smtp-Source: AGHT+IEEVoY71P6fmiW/X2j2ziaQ+gsKVaQfDTTPL3dWtGXIWVAcvZUsLGbDdQ/tJioNgOc3tZ11wLvOjU68jmDsGDU=
X-Received: by 2002:a05:6512:15a5:b0:52c:e05f:9052 with SMTP id
 2adb3069b0e04-53213681999mr882415e87.47.1723486823453; Mon, 12 Aug 2024
 11:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-11-james.quinlan@broadcom.com> <20240807141117.GK3412@thinkpad>
In-Reply-To: <20240807141117.GK3412@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 12 Aug 2024 14:20:11 -0400
Message-ID: <CA+-6iNxpFXAyEMri=30kDu8irZeUoJ7iVO6P_PfV4br1=GEigA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ec9dc9061f808bf2"

--000000000000ec9dc9061f808bf2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:11=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 31, 2024 at 06:28:24PM -0400, Jim Quinlan wrote:
> > Always check the return value for invocations of reset_control_xxx() an=
d
> > propagate the error to the next level.  Although the current functions
> > in reset-brcmstb.c cannot fail, this may someday change.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>
> One comment below. With that addressed,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
> >  1 file changed, 73 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 0ecca3d9576f..c4ceb1823a79 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
>
> [...]
>
> >  static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
> > @@ -1478,9 +1514,12 @@ static int brcm_pcie_suspend_noirq(struct device=
 *dev)
> >  {
> >       struct brcm_pcie *pcie =3D dev_get_drvdata(dev);
> >       struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(pcie=
);
> > -     int ret;
> > +     int ret, rret;
> > +
> > +     ret =3D brcm_pcie_turn_off(pcie);
> > +     if (ret)
> > +             return ret;
> >
> > -     brcm_pcie_turn_off(pcie);
> >       /*
> >        * If brcm_phy_stop() returns an error, just dev_err(). If we
> >        * return the error it will cause the suspend to fail and this is=
 a
> > @@ -1509,7 +1548,10 @@ static int brcm_pcie_suspend_noirq(struct device=
 *dev)
> >                                                    pcie->sr->supplies);
> >                       if (ret) {
> >                               dev_err(dev, "Could not turn off regulato=
rs\n");
> > -                             reset_control_reset(pcie->rescal);
> > +                             rret =3D reset_control_reset(pcie->rescal=
);
> > +                             if (rret)
> > +                                     dev_err(dev, "failed to reset 'ra=
scal' controller ret=3D%d\n",
> > +                                             rret);
>
> I don't think it is really necessary to capture the return value in err p=
ath.
> Unable to turn off the regulator itself is fatal, so we could just assert=
 reset
> and hope for the best.

Hi Mani,

I'm not sure what you would like changed.  Failure to turn off the
regulators isn't  necessarily fatal, it's when they cannot be turned
on that is fatal.

There can be two failures here: failure to turn off regulators and
failure to reset the "rascal" reset.  Since I can only return one
error value, I print the other value via dev_err().

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

--000000000000ec9dc9061f808bf2
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAWW8gZqJtRyhMl7qxJ4JnBj5sYYilG
95hwJlq6H/5dYDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIxODIwMjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEATgZDgY//p9goH4dZ3K19LxNjPMjEEMYsxvUWEW8MwD/YurT5
+5Glea3XbOX/tHCxFXR1CHkYBw3TD+J9OgISsanHM3siyE4XyAt7QwIrqy2zwYa3tI8+0kdRu6Dq
Bzs4nK2XU6LeL56wEqNzGerzS7i6YxjkFIjDsFYYe2XklwzLLMekYseHpff3I5G26WwZxAO+TdZX
zXI6yiqGVnzq9o9lQBXNdkcWmKrfJ3/e3E0vtuTLexXRq4053bGFFnoQCcRd/qfkj7RvtpUVlF1H
jQ6dQus012QsgOtPbgnwBRz72olDRbjjPoH6e0L91D0E+Rl78o+JWEQgt796J2IsRQ==
--000000000000ec9dc9061f808bf2--

