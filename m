Return-Path: <linux-pci+bounces-10849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057193D865
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973711C20F6A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA707383A1;
	Fri, 26 Jul 2024 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FhPhHtSY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696E36B11
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018910; cv=none; b=IVElAwn3AZ2UFQOZbXIXI+tReRYdJXPyACRYLI6hWijAZJq2/rx2uIjuK6phfmYJiUmkNNWvxg7/TQPzBLvv59YM5bQmEIYIJAuvn0F9XctUpbUW2aDx1FmSdUsYxIrQdhAqnwhjX/Jgjfe5YBdGNk6KcvxCvGAvaJf+LBf2tgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018910; c=relaxed/simple;
	bh=sxFmuOyn7EV1aoChNcg9W/9eqDTC7Nv10nHW3xutZ44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djlR0nImNeiEqQr3U2kX3Kan7xHryK0i2+5ofJHH/cGQKzC+jMvWz9+GzRB+/whe2Tp6Hlz3ffSIzlo0V7qy462WlqrnQe/M4rD0JHniWClMGXc/IfEDCIHtKXNvXGKUHPA76ju6x5bJUc6VMKONel1mqL1Aimi9vrKBBXBzlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FhPhHtSY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso1998746e87.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722018907; x=1722623707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ5jegaQFQAgIZsrLjOuwY6D2R+7qXtsnI/EJcwFhKE=;
        b=FhPhHtSYug7ebG7mis3raA9w6KibnwUePn0oO8pt8P+Jc8Z4AmTBeu2vxmqKDwpK/z
         iitMh8lrthVsR38/wx08xjOmoYM3x+rgaWx8y6geM3ZONwNRVibEg3ZNaooCbjwGuez7
         lO/GW/TM49l/8meRcv12g2QAGbqoA6gLw0Jqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018907; x=1722623707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQ5jegaQFQAgIZsrLjOuwY6D2R+7qXtsnI/EJcwFhKE=;
        b=Py356Slxxjgq09D6vWOYZiOFe2ylxAT1AmS6JGUlxPGEsN61Lxhvkp902PTIXG23T9
         6N+G9hhr6ztiWiDGMDBz4AUXDvnY3hi6Zvst24hzn/LCdcGQppAoB4DkKNI3L8oyhyeM
         Mp6HYiWjxTeHwmm6wpWB223864Uftb2B6Hbh24RYfJeTnXMYdZTxvqQM7KKvQCDyvMi3
         mZ8V8MS/eZdIHmWUV57fwyjtrqwL5xxcD2V5ncSLELe+a721WHjNy7wdYbqxug556AG2
         myo0sLd86RTzvI2IEgbNSqH8GIN2QyR78RhS2X0Ue/zRS2kJgHFDmDBuIqdAL68UjUTf
         wp4A==
X-Gm-Message-State: AOJu0YxmvhGXEKI570/56NlD9eLBpYSNWLwjal3HPMge4lK+c1kKoZH0
	bP2AUQJ+hC8CnaskaQWginLXENtBQaw+VqxMfeV7PP+HQsIolp8066pvzxXgcJ/LjGtTfeaHdvI
	Efl4HegYAydRrP7rMv9xgJE1+/X9vv7ElmnRl
X-Google-Smtp-Source: AGHT+IEbgJ14TM04t5gLjRe+UpYBB4YU4vQ+M/sK7yhVHORwhDBaUiHtDXx+lP6/YaX5tbkBl/fUpC0VCWpMQlYsIo0=
X-Received: by 2002:ac2:548c:0:b0:52e:a721:497b with SMTP id
 2adb3069b0e04-5309b2bcc59mr423378e87.38.1722018906590; Fri, 26 Jul 2024
 11:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com> <20240725043111.GD2317@thinkpad>
 <CA+-6iNz9R5uMogd6h+BkgRvKrsmyH2VXsGO_5e=6yqC=JzjigA@mail.gmail.com> <20240726050423.GB2628@thinkpad>
In-Reply-To: <20240726050423.GB2628@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 26 Jul 2024 14:34:54 -0400
Message-ID: <CA+-6iNzpfh7_rXUEXNjZLCLQKu-e_bYMAO6PdKaxqReJRKjuAQ@mail.gmail.com>
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
	boundary="00000000000042a774061e2ac52d"

--00000000000042a774061e2ac52d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:04=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Jul 25, 2024 at 03:45:59PM -0400, Jim Quinlan wrote:
> > On Thu, Jul 25, 2024 at 12:31=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> > > > o Move the clk_prepare_enable() below the resource allocations.
> > > > o Add a jump target (clk_out) so that a bit of exception handling c=
an be
> > > >   better reused at the end of this function implementation.
> > > >
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> > > > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++--------=
----
> > > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/co=
ntroller/pcie-brcmstb.c
> > > > index c08683febdd4..c257434edc08 100644
> > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platform_=
device *pdev)
> > > >
> > > >       pcie->ssc =3D of_property_read_bool(np, "brcm,enable-ssc");
> > > >
> > > > -     ret =3D clk_prepare_enable(pcie->clk);
> > > > -     if (ret) {
> > > > -             dev_err(&pdev->dev, "could not enable clock\n");
> > > > -             return ret;
> > > > -     }
> > > >       pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev=
->dev, "rescal");
> > > > -     if (IS_ERR(pcie->rescal)) {
> > > > -             clk_disable_unprepare(pcie->clk);
> > > > +     if (IS_ERR(pcie->rescal))
> > > >               return PTR_ERR(pcie->rescal);
> > > > -     }
> > > > +
> > > >       pcie->perst_reset =3D devm_reset_control_get_optional_exclusi=
ve(&pdev->dev, "perst");
> > > > -     if (IS_ERR(pcie->perst_reset)) {
> > > > -             clk_disable_unprepare(pcie->clk);
> > > > +     if (IS_ERR(pcie->perst_reset))
> > > >               return PTR_ERR(pcie->perst_reset);
> > > > +
> > > > +     ret =3D clk_prepare_enable(pcie->clk);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev, "could not enable clock\n");
> > > > +             return ret;
> > > >       }
> > > >
> > > >       ret =3D reset_control_reset(pcie->rescal);
> > > > -     if (ret)
> > > > +     if (ret) {
> > > >               dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > > > +             goto clk_out;
> > >
> > > Please use a descriptive name for the err labels. Here this err path =
disables
> > > and unprepares the clk, so use 'clk_disable_unprepare'.
> > ack
> > >
> > > > +     }
> > > >
> > > >       ret =3D brcm_phy_start(pcie);
> > > >       if (ret) {
> > > >               reset_control_rearm(pcie->rescal);
> > > > -             clk_disable_unprepare(pcie->clk);
> > > > -             return ret;
> > > > +             goto clk_out;
> > > >       }
> > > >
> > > >       ret =3D brcm_pcie_setup(pcie);
> > > > @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platform_d=
evice *pdev)
> > > >
> > > >       return 0;
> > > >
> > > > +clk_out:
> > > > +     clk_disable_unprepare(pcie->clk);
> > > > +     return ret;
> > > > +
> > >
> > > This is leaking the resources. Move this new label below 'fail'.
> > What resources is it leaking?  At "clk_out" the return value will be ne=
gative
> > and only managed resources have been allocated at that juncture.
> >
>
> Right, but what about the err path below this one? If that path is taken,=
 then
> clks won't be released, right?
No, that is the same situation.  The clock is originally allocated
with "devm_clk_get_optional()", i.e. it is a managed resource.
 If the probe fails, and it does in both of these error paths,
Linux deallocates the newly formed device structure and all of its resource=
s.
Perhaps I am missing something?

>
> It is not a good design to return from each err labels. There should be o=
nly one
> return for all err labels at the end and those labels need to be in rever=
se
> order w.r.t the actual code.

Agreed.

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

--00000000000042a774061e2ac52d
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCenPxyWO7KXw8o3HXf0rLW38lulHTR
R7MQuYYGfaK1JTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MjYxODM1MDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEADpYiPqZzxeQNtLOkQs4POJdOUPKWmsjT7lEo3iuybcwCSX18
ub/P3ulwfpcFsjLOT2ZINL3CNhTtQ+eVhaeJ6KCmeLqRifw6RxjQHHBhu89vnTnkbG1ejuuHOUru
+tUYYYOv3mHTUtS2oKosfxVBnPSsp1XviMZxwJbvRgug8rTJWGEieSzyjuWQR/WhFsJNE/7hgncZ
8hQ8iT7fK+I4XPgaA6gs/3jmevwn7/b1y8si9ObsYT9DxC/RYp6hpie9Q85CK9D1zaUZt6Zh2gnO
VQWixktMNarJllj+0HPHM7gdGVdwuH2ul9LZn9nhyo+iDL9CykHUkDDQ8hxeqDFQsw==
--00000000000042a774061e2ac52d--

