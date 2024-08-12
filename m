Return-Path: <linux-pci+bounces-11606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD71B94F7FB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 22:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9CA1C21C6B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34963193062;
	Mon, 12 Aug 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GFpKMEBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852C192B9D
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493558; cv=none; b=oLLWEEm+ugGM1nZkRxYhi6Gho1rab5HlKUdr329yEOiyNUBcxQ1JUUAMgJZPT/nlS/mPyNv9lm80tNqSWVouSPCZJzqIN22KDerxbkZ+lrueGFo8iT5RKmiYpGrZ152vvHmZnyuZKSzMX4fdcjtUt7nK7+NbneJQHi3PSLfENXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493558; c=relaxed/simple;
	bh=On2BWlIt9ceNL4ILuqJ5vCOqXZoqokBTqxfadtDCOyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUScd11JGRa2o+1MkPPfJJM+F2P1SHgi6Rj5DToeCoR9w7w85zSjIxPSlnHC4Cb53jxy9GhNfAyGRh6+ljzerdqBAcgrybiK6Os0bvARHPVq9bWb5OKZbAKVfKf2YvoB80/vgSle7fWOuda/GJjQ06JNA64BpIEhIRKA4zts88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GFpKMEBq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15790b472so59808011fa.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723493554; x=1724098354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OkNmC+g+amKK67pd334YVpmhhciIHduYDDLay2KJWak=;
        b=GFpKMEBqvKmGICDVLREwQBwirw8SWQhTTzIrBMMj0i+lCrGuYyZJeV48bMOk+3tovw
         imtLc0N6wl2WQSaIcJPOo39SdFa+FcOk14a18D/5lBRRZVDTvkXSmUx6DmXyUwVFYJyo
         pey3zPnpEVvx2poCOPF/pyrq3YEWPeTR0y8o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493554; x=1724098354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkNmC+g+amKK67pd334YVpmhhciIHduYDDLay2KJWak=;
        b=tnS4ESp00nbWclsjiSCZV748kwXMpEFccrgB834R+7rOWvRJyIhSZNJFs56cqtim4Y
         GnVkR3QSntU/fmdvQzUBoAhaX8IoWlzjcFE+US0GMuzxmXLl4bvUu7fAuO0e2mm556WI
         vjd1Avp7h+hsOyoGLqzrrHk9bc8DRTc6gGc8AXeIYLRTQY6t/1nryx0ckynGVxzPAV6b
         ISvJE5EoeHEEA+xpTxEIEqGLp2WZbOVwmwm/kv5FNa1Rlca2E58iAe5pmzrckrV3RGWF
         83U6VpYAHsZTHX0lSKqcXiLsTvHThgmTD4Lc6A7YQ0Xo1r0uQr7SZJsDZw+xX3Ui1vWY
         UczQ==
X-Gm-Message-State: AOJu0Yy8SN/xjIAqkNa5JacjXIesTLAorAZe8Yq03eKVQI3li5rSGYUB
	EXGv1oDPP0FZB7Xk24tk0iL3MBWvQZQRwHGkw/oq7S8cyYoGZgVpXtRZsaUxbI4lwO+U/FZwJSw
	uLWKVpJ1GhlKefSySFILHNeR4PV39LoxTCmfN
X-Google-Smtp-Source: AGHT+IF2hNEc/qwFaerc0vvpnCV4GfAwoIExYc/qDRomDFxcFCrh2Tnk//YcgWOvaI5f5+aiixp8+L41jv1x4gX6q/Y=
X-Received: by 2002:a2e:9dc6:0:b0:2ef:25ab:9881 with SMTP id
 38308e7fff4ca-2f2b7279a27mr8742281fa.46.1723493553913; Mon, 12 Aug 2024
 13:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-4-james.quinlan@broadcom.com> <20240807025252.GE3412@thinkpad>
In-Reply-To: <20240807025252.GE3412@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 12 Aug 2024 16:12:21 -0400
Message-ID: <CA+-6iNx5cAUZK5JBCd-xHtkgzztbFCZcEQ1yf85JkrpDgH83iQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
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
	boundary="00000000000017a2b8061f821d43"

--00000000000017a2b8061f821d43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:53=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 31, 2024 at 06:28:17PM -0400, Jim Quinlan wrote:
> > o Move the clk_prepare_enable() below the resource allocations.
> > o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
> >   add it to the end of brcm_pcie_remove().
> > o Add a jump target (clk_disable_unprepare) so that a bit of exception
> >   handling can be better reused at the end of this function implementat=
ion.
> > o Use dev_err_probe() where it makes sense.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
> >  1 file changed, 15 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index c08683febdd4..7595e7009192 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *=
pcie)
> >               dev_err(pcie->dev, "Could not stop phy\n");
> >       if (reset_control_rearm(pcie->rescal))
> >               dev_err(pcie->dev, "Could not rearm rescal reset\n");
> > -     clk_disable_unprepare(pcie->clk);
> >  }
> >
> >  static void brcm_pcie_remove(struct platform_device *pdev)
> > @@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_devi=
ce *pdev)
> >       pci_stop_root_bus(bridge->bus);
> >       pci_remove_root_bus(bridge->bus);
> >       __brcm_pcie_remove(pcie);
> > +     clk_disable_unprepare(pcie->clk);
> >  }
> >
> >  static const int pcie_offsets[] =3D {
> > @@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_devi=
ce *pdev)
> >
> >       pcie->ssc =3D of_property_read_bool(np, "brcm,enable-ssc");
> >
> > -     ret =3D clk_prepare_enable(pcie->clk);
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "could not enable clock\n");
> > -             return ret;
> > -     }
> >       pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->de=
v, "rescal");
> > -     if (IS_ERR(pcie->rescal)) {
> > -             clk_disable_unprepare(pcie->clk);
> > +     if (IS_ERR(pcie->rescal))
> >               return PTR_ERR(pcie->rescal);
> > -     }
> > +
> >       pcie->perst_reset =3D devm_reset_control_get_optional_exclusive(&=
pdev->dev, "perst");
> > -     if (IS_ERR(pcie->perst_reset)) {
> > -             clk_disable_unprepare(pcie->clk);
> > +     if (IS_ERR(pcie->perst_reset))
> >               return PTR_ERR(pcie->perst_reset);
> > -     }
> >
> > -     ret =3D reset_control_reset(pcie->rescal);
> > +     ret =3D clk_prepare_enable(pcie->clk);
> >       if (ret)
> > -             dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> > +             return dev_err_probe(&pdev->dev, ret, "could not enable c=
lock\n");
> > +
> > +     ret =3D reset_control_reset(pcie->rescal);
> > +     if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n=
"))
> > +             goto clk_disable_unprepare;
> >
> >       ret =3D brcm_phy_start(pcie);
> >       if (ret) {
> >               reset_control_rearm(pcie->rescal);
> > -             clk_disable_unprepare(pcie->clk);
> > -             return ret;
> > +             goto clk_disable_unprepare;
> >       }
> >
> >       ret =3D brcm_pcie_setup(pcie);
> > @@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >       msi_np =3D of_parse_phandle(pcie->np, "msi-parent", 0);
> >       if (pci_msi_enabled() && msi_np =3D=3D pcie->np) {
> >               ret =3D brcm_pcie_enable_msi(pcie);
> > -             if (ret) {
> > -                     dev_err(pcie->dev, "probe of internal MSI failed"=
);
> > +             if (dev_err_probe(pcie->dev, ret, "probe of internal MSI =
failed"))
> >                       goto fail;
> > -             }
> >       }
> >
> >       bridge->ops =3D pcie->type =3D=3D BCM7425 ? &brcm7425_pcie_ops : =
&brcm_pcie_ops;
> > @@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >
> >  fail:
> >       __brcm_pcie_remove(pcie);
> > +clk_disable_unprepare:
> > +     clk_disable_unprepare(pcie->clk);
> > +
>
> TBH, this is not improving the code readability. __brcm_pcie_remove() use=
d to
> free all the resources and now you just moved clk_disable_unprepare() out=
 of it
> to save 2 lines in probe(). And you ended up calling clk_disable_unprepar=
e()
> separately in brcm_pcie_remove().

Actually it saves more lines than that; the "swinit reset" commit adds
two more "goto clk_disable_unprepare" instances.

Nonetheless I will  make the change


Regards,
Jim Quinlan
Broadcom STB/CM




>
> So please remove the label and call clk_disable_unprepare() in the error =
path
> (just 2 instances) and continue to use __brcm_pcie_remove() to free all
> resources (I would've preferred to have separate error labels instead of =
calling
> __brcm_pcie_remove() though, but not this).
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--00000000000017a2b8061f821d43
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDrFV5wBrO4A/Ycu+Xe5h5Fjn2mo2sz
imXCgSXxXXaMeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIyMDEyMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAfPNKexvWL/1MjW89YjtWTH5cgMuYv07wOlSzQDvEl8GlxbKr
UMaIlZuDz2MOAhh7YCYS2hhcYRmEeza5z2rq3IP5APko0tQ/6g9IaHRHC4A5wXDNs9O2aKQKknGc
gmM8OMm0Am3rBDD6Pau++ldDtv5KUZb7SOCvISbc7EqQkxJwlkcJfBOYpb12SULEJj2Hm5BnXfBO
gPJTCZQKFyr+P5Z7n9f6Du9QIoTJnMPy2Rw28LkIUuUP+pEl12xj4eSJncqppj7HTHZFI/2EykCO
oqGhxAHwbMUpeB1VHwWSrPf9foOduFk5o0sVtkGF/9ze1t/COH6AQinKgvfA1Oel+A==
--00000000000017a2b8061f821d43--

