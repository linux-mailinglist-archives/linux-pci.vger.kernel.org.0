Return-Path: <linux-pci+bounces-22875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93FEA4E76B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE757ABC10
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B477259CB5;
	Tue,  4 Mar 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KawdGnaM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B208995
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106252; cv=none; b=HWiZ4NkGDYFC3+c9aRPmarcZOvnXPGN6JW3t3eBFFuO5Ju/H62LtlaKp8X2iyGAnfvsz4cNJGk5Kdn3lHJzzWF2mTSanIeZA+D4up/6Y05A17jHOI+xCtWymINcuaIfpLPZmQElU1NWKcbjZE2RiSw+dI3O9SONZgBqutAKAvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106252; c=relaxed/simple;
	bh=Ylz8Bn9bCciJH37tnVnyJS/veyl8qxYVWYjnfb2nH2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sR0mgi73s0zxKBQD4qo2/1+RDoTDmWcF2F/xpBho5lYrWZ/AjPakf6SM2+uos9g6qQSWaFy1//J+hBb1zAbJ5v2qhg61MqqB8dGvyZ7sNhQuX3GjCp/0DqhRqunFE3OsKwes17d/dYaGwkdeQNekgNLFBGbFLBF1DUAbH6rAR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KawdGnaM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5495078cd59so4627866e87.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741106247; x=1741711047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EOjTrFqITQFuKoVHbxpJDPaFmJWlreNF301hHp5VCoE=;
        b=KawdGnaM0dBl6uwtvYFo5IQyBguGV/4V5+Ni/aKqFMiDf3uIUi5joDY9gvBe7efRQP
         NpIqgKUPp68sln0Fsm/3k7LgyAwEVZ2CvJJgSHrSWM/CbUGxgpfo3MlEYOQsf2v3ngty
         fri7kmTQhYnUA98f4D/zzkKh81VW2wVsBxZA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106247; x=1741711047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOjTrFqITQFuKoVHbxpJDPaFmJWlreNF301hHp5VCoE=;
        b=FYYMIUhWAlEq9DJRBguWSwgYcA1GaQgXVwAQvH/OUaWeom1DwsEWFtu5g2q6g/+nE9
         usdE3el64/IFXZs+MYW/2e9If0P1udp4oANzCFxHVdC/xMUGAElR2b0LQd9/gDA28S3e
         +Q03rF01WNhD1jM/yasdhL3WAGglAgsqVjbjDN51Z868KfwOfO1brYrC3YRYUy7JMVUs
         UhOZI3Ahe3t3Prayi7lQsTik4Y2Gen5hDIFJe7skx2/7rpdHRphnJ9xhn0/8kHMm2jLt
         nomra6y93J41mwBc5x2DXc5fLhLFysq2JYbGZ3pH2SC9j9gkyGWDRXO1xrv2N3lJYbp9
         nr8A==
X-Gm-Message-State: AOJu0YyTgo/SjN2RRvjgh5ZkTauW86TuIQau82GHrHbKLCT+y/BTFz+j
	hv5+9ExS36FaUwwlOC5SVOkpwoCImiiAo2Dh4zLVRrlXWe5geTGxnsqwdEIMaNPLn//wVk5nixP
	Zfjioia+iZDXySz7ry0AmGvODiMjIMBl0wZFH
X-Gm-Gg: ASbGnctmXAv6oetWOu+puU58WXRzOivL0J0hEuRexnsFAa4dnhbifFj2/Mw1GHDjsXP
	lC0/mVS8nFlcIyOqSLeuG/NJ1OMr2NS8kW7IlUAilM7+35krLK+w993W5uyNKmzbhlyioSZsXQT
	FDlH2OPyT/Og2OC1jif4T5r5V6irI=
X-Google-Smtp-Source: AGHT+IHEb3b277xqRqJp1ckXeMWGDMg96uWTLb8EGKjCHmqIIwAU2IJecSHrorpEE4OQnRbhgkR81FtwP8+B3es+W0U=
X-Received: by 2002:ac2:499d:0:b0:549:5769:6adc with SMTP id
 2adb3069b0e04-54957696d10mr3992327e87.2.1741106247262; Tue, 04 Mar 2025
 08:37:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com> <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
In-Reply-To: <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 4 Mar 2025 11:37:14 -0500
X-Gm-Features: AQ5f1JoW5XA69R5P5HEW4xQGcq_X8yLC_V13WSo-ryXSh-szOfdBDP--_8F-yck
Message-ID: <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000691f96062f86e393"

--000000000000691f96062f86e393
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:08=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> > The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> > map_bus methods used these constants, the other used different constant=
s.
> > Fortunately there was no problem because the SoCs that used the latter
> > map_bus method all had the same register constants.
> >
> > Remove the redundant constants and adjust the code to use them.  In
> > addition, update EXT_CFG_DATA to use the 4k-page based config space acc=
ess
> > system, which is what the second map_bus method was already using.
> >
>
> What is the effect of this change? Why is it required? Sounds like it got
> sneaked in.

Hello,
There is no functional difference with this commit -- the code will
behave the same.  A previous commit set up the "EXT_CFG_DATA" and
"EXT_CFG_INDEX" constants in the offset table but one of the map_bus()
methods did not use them, instead it relied on old generic #define
constants.  This commit uses them and gets rid of the old #defines.

I didn't add a "Fixes" line because there is no functional change but
I can if you want.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index e1059e3365bd..923ac1a03f85 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -150,9 +150,6 @@
> >  #define  MSI_INT_MASK_SET            0x10
> >  #define  MSI_INT_MASK_CLR            0x14
> >
> > -#define PCIE_EXT_CFG_DATA                            0x8000
> > -#define PCIE_EXT_CFG_INDEX                           0x9000
> > -
> >  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK                      0x1
> >  #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT             0x0
> >
> > @@ -727,8 +724,8 @@ static void __iomem *brcm_pcie_map_bus(struct pci_b=
us *bus,
> >
> >       /* For devices, write to the config space index register */
> >       idx =3D PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> > -     writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> > -     return base + PCIE_EXT_CFG_DATA + PCIE_ECAM_REG(where);
> > +     writel(idx, base + IDX_ADDR(pcie));
> > +     return base + DATA_ADDR(pcie) + PCIE_ECAM_REG(where);
> >  }
> >
> >  static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
> > @@ -1711,7 +1708,7 @@ static void brcm_pcie_remove(struct platform_devi=
ce *pdev)
> >  static const int pcie_offsets[] =3D {
> >       [RGR1_SW_INIT_1]        =3D 0x9210,
> >       [EXT_CFG_INDEX]         =3D 0x9000,
> > -     [EXT_CFG_DATA]          =3D 0x9004,
> > +     [EXT_CFG_DATA]          =3D 0x8000,
> >       [PCIE_HARD_DEBUG]       =3D 0x4204,
> >       [PCIE_INTR2_CPU_BASE]   =3D 0x4300,
> >  };
> > @@ -1719,7 +1716,7 @@ static const int pcie_offsets[] =3D {
> >  static const int pcie_offsets_bcm7278[] =3D {
> >       [RGR1_SW_INIT_1]        =3D 0xc010,
> >       [EXT_CFG_INDEX]         =3D 0x9000,
> > -     [EXT_CFG_DATA]          =3D 0x9004,
> > +     [EXT_CFG_DATA]          =3D 0x8000,
> >       [PCIE_HARD_DEBUG]       =3D 0x4204,
> >       [PCIE_INTR2_CPU_BASE]   =3D 0x4300,
> >  };
> > @@ -1733,8 +1730,9 @@ static const int pcie_offsets_bcm7425[] =3D {
> >  };
> >
> >  static const int pcie_offsets_bcm7712[] =3D {
> > +     [RGR1_SW_INIT_1]        =3D 0x9210,
> >       [EXT_CFG_INDEX]         =3D 0x9000,
> > -     [EXT_CFG_DATA]          =3D 0x9004,
> > +     [EXT_CFG_DATA]          =3D 0x8000,
> >       [PCIE_HARD_DEBUG]       =3D 0x4304,
> >       [PCIE_INTR2_CPU_BASE]   =3D 0x4400,
> >  };
> > --
> > 2.43.0
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000691f96062f86e393
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCClhG6MzNY6mGOktkUm/RNVlbGvThVK
IK6zb+Hm5tgnZzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAz
MDQxNjM3MjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEASgxgNllxtglxds2W0y4hiS1iyUqcdT57Abpo2FAHg4IQFpwP
d31QIR7HvbwWUzGaUQ3MHdSFixYZ3+zXJ6ILztZ2DA2jooV88spLsS9RNTzHbPlCHDQICbw2FJg8
rugJbIq2crRE2ZdT0pOQXttMpN8iEobOARwaBNbYi5WHOPQ5xj12jAcJkXjexisjNohvo97KL260
kZ248gy+zI08MEyQCM4+yWk8o619TBZXdreiCiQOfGcVgm3NRUI26GkGz0XQRFWnL2CFjFC99oM/
/cPQQsv47lJr18gzEKK6qWnbdeLgi2AueRlwdTY2jpi97XPox9rEZ9Ewnq5zWgPFVw==
--000000000000691f96062f86e393--

