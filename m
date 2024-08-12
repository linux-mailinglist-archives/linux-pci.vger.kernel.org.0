Return-Path: <linux-pci+bounces-11595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C630894F201
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 17:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B3AB22515
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB01474C3;
	Mon, 12 Aug 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UdBCQx8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63C186E5B
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477610; cv=none; b=GGaZdzX5YnCnpTJQZ93ewsjpm3gCTzAMJ5dGN0a1GG+Iq5wDuZv6ihA+F2erVYRoAGiLPg6+7X/+Vflkn6CW0ScVlWhGBHo5d4nttMcksLp5IxjvRpHAlSNq8vLOu27BvWlUBDaJGU5K/K9K8rJsYrAX/B1r7pTpAN+GZzdxBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477610; c=relaxed/simple;
	bh=Yv3VhDFF9yvcXiikEqj+ENCiNAeb3HHnhs8PdPPuEmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2jnnzHxGZRHHVJDLPk6JCIUCEiOg8UxGpeHaGYmCdotM/YPZwkFUrElnH1jRtKJrgvO49V/9ulkTUC6cpSvbA2rtPbEtsqlGWbhnO24eGBqyTAnO6bva2tRdaU77/OWzoYoBpdSSi0hp7H+SjFW+4WUpKWB6FUmjSANosce4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UdBCQx8X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7d26c2297eso517241966b.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723477607; x=1724082407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FKXGP7ctO3hh+6lB+eJGSz+KEghKNiocjdq5M3Dq6wU=;
        b=UdBCQx8XNeJXeCUOg7U+Ub2AV0GFeJuf7jQijQe+liXHtBmMS9Dssk1ReMcxotep5+
         4xJ6EVhIXHfv2koHCq0JQ9qNxRq2mlTA+dUpIlYP4TpEEQtUHZYNrwD/XXvuk6Xki3vz
         8Vhf7Lm/uFN5PQmbsLAXY8w3zeQiSYsnle6Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477607; x=1724082407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKXGP7ctO3hh+6lB+eJGSz+KEghKNiocjdq5M3Dq6wU=;
        b=VnBxlavYzgTnTFNcBS3AKcBWJhhp8pFPi9ITsTYqgsXEmll/2wP8fc5j1xMUYBaLUW
         aBHTDn1XcC36gV8VCnUHN028sFPiQzhqdnL84k3OqugH+pKsla+nbqZ6Bv8oH6un9um5
         aN1k2UriCbZUMskCZWcEuisLfNpd6E3X+NEnvVNno97YDK2RKVkmq9NHcX07dit3Q6o7
         3rU++42jKhNlyKpG6mV6Cn1wNaomHgGZRzSTU2a2/6dPj43CNdKoQ2xLR4ogUTnH1foN
         IC/48vu+ZnUATF3qmX7tu7RlwfeFBODMr+/zBgccVr2f6yJns6oEe8Dv+z2QobSRZFf9
         DXKg==
X-Gm-Message-State: AOJu0YzEmgQOp1uGrxbnFX6Xjy7vXSqKsdiMUP4y0eu6uUzBkQJRVGdp
	4TOt+P+2ivoZGiXDN6N9/wsBuVDaVJcxOCIFtsMeX4OXOR4sb82GUFCbRx5pk3br6QxfslPWlUp
	uDMu07VVqHVwqVhrRfEr5boaf8djXmdAnE39h
X-Google-Smtp-Source: AGHT+IEKYMxDjZpA4ugql0q25haDMG9of3iEjyR/9J5O5gQHUxbbAlTphHF0z0O4yvsgnJiQItnvd4OSHTEmrglB6OI=
X-Received: by 2002:a17:907:d14:b0:a7a:a5ae:11bd with SMTP id
 a640c23a62f3a-a80ed2d3189mr47121366b.67.1723477607030; Mon, 12 Aug 2024
 08:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-5-james.quinlan@broadcom.com> <9c22a495-7b89-4df6-b57b-cb0f39b09c30@suse.de>
In-Reply-To: <9c22a495-7b89-4df6-b57b-cb0f39b09c30@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 12 Aug 2024 11:46:34 -0400
Message-ID: <CA+-6iNy2f3zNsSZcFBHnEoTSqDHx34+ijZrLWhnC5bfF=S3nQg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
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
	boundary="00000000000095ecf1061f7e66b8"

--00000000000095ecf1061f7e66b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 7:16=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.de=
> wrote:
>
> Hi Jim,
>
> On 8/1/24 01:28, Jim Quinlan wrote:
> > The 7712 SOC has a bridge reset which can be described in the device tr=
ee.
> > Use it if present.  Otherwise, continue to use the legacy method to res=
et
> > the bridge.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 7595e7009192..4d68fe318178 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -265,6 +265,7 @@ struct brcm_pcie {
> >       enum pcie_type          type;
> >       struct reset_control    *rescal;
> >       struct reset_control    *perst_reset;
> > +     struct reset_control    *bridge_reset;
> >       int                     num_memc;
> >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >       u32                     hw_rev;
> > @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct=
 pci_bus *bus,
> >
> >  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pci=
e, u32 val)
> >  {
> > -     u32 tmp, mask =3D  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > -     u32 shift =3D RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > +     if (val)
> > +             reset_control_assert(pcie->bridge_reset);
> > +     else
> > +             reset_control_deassert(pcie->bridge_reset);
> >
> > -     tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > -     tmp =3D (tmp & ~mask) | ((val << shift) & mask);
> > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +     if (!pcie->bridge_reset) {
> > +             u32 tmp, mask =3D  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> > +             u32 shift =3D RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> > +
> > +             tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +             tmp =3D (tmp & ~mask) | ((val << shift) & mask);
> > +             writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +     }
> >  }
> >
> >  static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, =
u32 val)
> > @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_devi=
ce *pdev)
> >       if (IS_ERR(pcie->perst_reset))
> >               return PTR_ERR(pcie->perst_reset);
> >
> > +     pcie->bridge_reset =3D devm_reset_control_get_optional_exclusive(=
&pdev->dev, "bridge");
>
> Shouldn't this be devm_reset_control_get_optional_shared? See more below.
>
> > +     if (IS_ERR(pcie->bridge_reset))
> > +             return PTR_ERR(pcie->bridge_reset);
> > +
> >       ret =3D clk_prepare_enable(pcie->clk);
> >       if (ret)
> >               return dev_err_probe(&pdev->dev, ret, "could not enable c=
lock\n");
> >
> > +     pcie->bridge_sw_init_set(pcie, 0);
>
> According to reset_control_get_shared description looks like this
> .deassert is satisfying the requirements for _shared reset-control API
> variant.
> Is that the intention to call reset_control_deassert() here?

Hi Stan,
Now I'm not sure I understand you.  All of the resets (bridge, perst,
swinit) are exclusive, except for the "rescal" reset, which is shared.

On the exclusive resets I am using reset_control_assert() and
reset_control_deasssert().  On the shared reset I am using
reset_control_rearm() and reset_control_reset().   Why do
you think the calls I am using are incongruent with the shard/exclusive
status?

Regards,
Jim Quinlan
Broadcom STB/CM

>
> > +
> >       ret =3D reset_control_reset(pcie->rescal);
> >       if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n=
"))
> >               goto clk_disable_unprepare;
>
> ~Stan

--00000000000095ecf1061f7e66b8
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCLAB2aCM7o9X9EHbztLLa5cLuaaRxR
B7R8xpE5IbKLSzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIxNTQ2NDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAapgzgsPC4c7llJ9i8Cz/Rdxyotf8k2VKiS2sbwlKjmuvxfOZ
FlM5boUgoBdD6pWLjwsQxI+jCYQPMcGloPkFJJmX9UHOADcsdyih6EMdOOL6RzxJQB+ghk+vWtHw
10qpKCnVcGlOr8JoAqm4ImLxIMzrj95eBDgLIjoKQXoRlfjel3PkxfqY7AftZspSYOi7xnQJQXg5
hbFeWLwXlqUOVRMeOTo0b5jPdK15TncU2rYSXfBqL3RFyE1Ek+Ysx0KO4F8GHN+PTI4mUfiRLvS+
rjzOu2KOLUkSIF3AwoZ0vff3uu8vUBoKvu7tNTR023uC1VpYShKDVaWUNxLj1+YYTQ==
--00000000000095ecf1061f7e66b8--

