Return-Path: <linux-pci+bounces-11592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3481C94EE86
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 15:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06CB282009
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D0B17C7C3;
	Mon, 12 Aug 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EdiE3gzo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4F17A92F
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470244; cv=none; b=hRD7BpNagvp+qOh2Fg1cfq6U2STxKaatTl+D+EKASuxzo2EO2FNZbsKlM0jXQ9XfwgGSYNH4TmTSu6ALjWBqQ4ZLboamhRCjBUvI5pEdaTNn5e5iElCWdJji+ooWLtlB3N/i1p2xJml20m5l13BEPPrKkJ0i2ihB2Z6JUuQ61VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470244; c=relaxed/simple;
	bh=FKv8lNjvifU0GZ1GhAiXKNbHL3R1Gwb86nmd7TK3zdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDMbsd/Rnp40mQk4LMCOPp++RHfBEXDISYf5C+gHRuqv9uXAZrmU2WfgkSs4BXEPsEAD6kxvU+ctg6CVSALfS8FfqP4Pq+0ytbP2ThFzEe1SgfkxMJ6L7VjhbOkk2oRmBY+Wi0OvcSvt+/t+dxtML2kfg8Im8SpbcDRYkzEr+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EdiE3gzo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so54929211fa.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723470239; x=1724075039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNfLMl6MP/AuufZbEvtFw7rPnc5fNV+RfkfYnN9vCbk=;
        b=EdiE3gzokv9A8DG27nKagru/0doeTPXbO+Y+S2xiK4+oVvdL8cXXvlIGVOPFm/mdmf
         7p6aFSHSzMdsBTiF1jdiNv67xNAbjXhjL6sQr0bt56gYZtnxti5d4Q5srI3a2n5w8THO
         FiljZHYag6pcJ6sFmbPNe2e0gtdROgUt3fr0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470239; x=1724075039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNfLMl6MP/AuufZbEvtFw7rPnc5fNV+RfkfYnN9vCbk=;
        b=L7yJ9txf0nUJ1wGUjpg8LlZ3PEKnxYv//q+DG3PGR5IAKO7lyAt6j15U9GKMNkDq4i
         kZwiXjZSAM1Geh3Pf7JYAm3R0KXBUX1OxLZVrP+/pfCr0oae739cpP/BzjEt9G8xgVtr
         4Xu7fS0sLd3im7ro/uRhFccfY4LbskSMkT60slh85RHMHB5QCMbCfjL52xp+RMFdZJjD
         fgNy4bP9P1UBrdHPlDgh+SD8RNE65LSnvVo1xfxNg01niOOmpiu0EPx/5C3OEXrGjCSh
         ocEHwTu/hE9CCka7n+rgYOejBzPi0wlilSo0Ijmd3uMSsRXYlR1DUsf8GHLjRO3EF+Cs
         MSTg==
X-Gm-Message-State: AOJu0YyXv1hSa3oxRtxgYTVwmpcg3NuWRR8eH9GuA6RZb66aKOwX7/QU
	krWAw3781eLpq6KiCR0+gmg2jRVO22Jd/gqQgfG36w2X3BbPnRZPmXH6nrpE7bFgUnqIC0nM8HI
	zseJ0xQAolB/8/PMJ1TohnCopvmdjhWb6cE0p
X-Google-Smtp-Source: AGHT+IFEDaxGmHckxf11hocjZwl56wyHApr0+8GbPBZpHIYlwi6qSKp6NVxj3XeElCy5N1jBcw8TZ3rY4fNgJgN+o1M=
X-Received: by 2002:a05:651c:543:b0:2f0:1ead:b72d with SMTP id
 38308e7fff4ca-2f2b714bd25mr2431051fa.12.1723470239336; Mon, 12 Aug 2024
 06:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-6-james.quinlan@broadcom.com> <57f11aff-95f8-41fd-b35e-a9e5a85c68e3@suse.de>
In-Reply-To: <57f11aff-95f8-41fd-b35e-a9e5a85c68e3@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 12 Aug 2024 09:43:46 -0400
Message-ID: <CA+-6iNxd2txYOoeww3yPTPHRvZE_tVT+37Htkq=NUzbtzLkMRA@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] PCI: brcmstb: Use swinit reset if available
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e444e061f7caf22"

--0000000000006e444e061f7caf22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:53=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.de=
> wrote:
>
> Hi Jim,
>
> On 8/1/24 01:28, Jim Quinlan wrote:
> > The 7712 SOC adds a software init reset device for the PCIe HW.
> > If found in the DT node, use it.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 4d68fe318178..948fd4d176bc 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -266,6 +266,7 @@ struct brcm_pcie {
> >       struct reset_control    *rescal;
> >       struct reset_control    *perst_reset;
> >       struct reset_control    *bridge_reset;
> > +     struct reset_control    *swinit_reset;
> >       int                     num_memc;
> >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >       u32                     hw_rev;
> > @@ -1633,12 +1634,30 @@ static int brcm_pcie_probe(struct platform_devi=
ce *pdev)
> >       if (IS_ERR(pcie->bridge_reset))
> >               return PTR_ERR(pcie->bridge_reset);
> >
> > +     pcie->swinit_reset =3D devm_reset_control_get_optional_exclusive(=
&pdev->dev, "swinit");
> > +     if (IS_ERR(pcie->swinit_reset))
> > +             return PTR_ERR(pcie->swinit_reset);
> > +
> >       ret =3D clk_prepare_enable(pcie->clk);
> >       if (ret)
> >               return dev_err_probe(&pdev->dev, ret, "could not enable c=
lock\n");
> >
> >       pcie->bridge_sw_init_set(pcie, 0);
> >
> > +     if (pcie->swinit_reset) {
> > +             ret =3D reset_control_assert(pcie->swinit_reset);
> > +             if (dev_err_probe(&pdev->dev, ret, "could not assert rese=
t 'swinit'\n"))
> > +                     goto clk_disable_unprepare;
> > +
> > +             /* HW team recommends 1us for proper sync and propagation=
 of reset */
> > +             udelay(1);
>
> Hmm, shouldn't this delay be part of .assert/.deassert reset_control
> driver?  I think this detail is reset-control hw specific and the
> consumers does not need to know it.

This was discussed previously.  I pointed out that we use a reset
provider that governs dozens of devices.  The only thing that the
provider could do is to employ a  worst case delay used for all
resets.  This is unacceptable; we have certain devices that may have
to invoke
reset often and require timely action, and we do not want them having
to wait the same amount of worst case delay as for example, a UART device r=
eset.

Further, if I do a "grep reset_control_assert -A 10 drivers"  I see
plenty of existing drivers that use usleep/msleep/udelay after the call to
reset_control_assert, just as I am doing now.

As far as my opinion goes (FWIW) I think the delay is more apt to
be present in the consumer driver and not the provider driver.  To
ascertain this specific delay I had to consult with the PCIe HW team,
not the HW team that implemented the reset controller.

Regards,
Jim Quinlan
Broadcom

>
> > +
> > +             ret =3D reset_control_deassert(pcie->swinit_reset);
> > +             if (dev_err_probe(&pdev->dev, ret,
> > +                               "could not de-assert reset 'swinit' aft=
er asserting\n"))
> > +                     goto clk_disable_unprepare;
> > +     }
> > +
> >       ret =3D reset_control_reset(pcie->rescal);
> >       if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n=
"))
> >               goto clk_disable_unprepare;
>
> ~Stan

--0000000000006e444e061f7caf22
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCbQIJba+jA6RGOiiLWnJImZSeuC2XJ
iuttGLXomlso3zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIxMzQzNTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAmW081eUAcJdkDqGHHLU/Rif1ahwp4WT1zDi39KAbvR6gIAZR
dOqHxZqVy6bHvEmGJiVrLVHj8tbvfVwP6xEWTnb6+kk6PPP5OqfC7AJwOdvPjnbNOihytQ6pUPW/
Sy3uSE8lEh4iHbDHco25CgTHEPiPgsrvQW248dT10IY156D9TSl4G/dYPWNYsArl8hTA6yQgWryi
XM1JecEMesxIw9ky0m+4TrPngzdz51OhmhpWpInQ1Ajg9llLqsGFUa8vbvnMvaPeQIllmH2qQKov
3H3lMwRnIx51WBBz/KuOKHreTZux54grRHPA15/0MWZaK9wlVORsoX04/956Su65uQ==
--0000000000006e444e061f7caf22--

