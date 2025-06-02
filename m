Return-Path: <linux-pci+bounces-28813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD0CACB8A6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBC14A08E0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE011C245C;
	Mon,  2 Jun 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YxKhCmUA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F813D2B2
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878621; cv=none; b=M4PRV6Afjk7sthFQ1cUN26ECmiSpgkYu7tvI7C+xOkl8KsAQ9lnTlVWvG7A4VGI0KRh5iPngUfJDDjEzI337xmFO7GfmOy5YpH82GvWh8J3PlSW0KV9W0eIu236e+VnLDnXdd4A4qVvZnuNZa4/CrMvqaQhk1mCANMixqSloKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878621; c=relaxed/simple;
	bh=46awchPSedqTPgpRrSUtfyWehi5YGz3Mb4cGAP+zrjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmrTa1Q3bMTo+8TyMCiK7ETdZvwo4nohYCWc6oEvlvJcVCLr6MkndBRl6N4EzyiU1o1aZYp2znLdLpiurwUJ5VnDP8TdW7spm5oapmLlO7x7SeUd37gSxD2mE6pSPsRA5O4BJcA+DJejjSO2OD8RRC/K/QRyACmSbxR4GWUFkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YxKhCmUA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3105ef2a071so52235061fa.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748878618; x=1749483418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpyua58bHx7LuQA9SLc/cduTBsL1sfVI5A9Bc9qEjSU=;
        b=YxKhCmUA+0GIaPLSArGP9xulQYZx4tQJkGMYNbOq7lmfcH+KBh1BrMSHe2jUOEIk+D
         bqySHETZD8DRkTuRiy6fDyj+89aixqGXiKDWZIPI5/2UuPAifcBGdP5Yi9BISmFEvj5B
         FnartXmzLUGhtN1KHWvzqACaoyZUjiz8MRWI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878618; x=1749483418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpyua58bHx7LuQA9SLc/cduTBsL1sfVI5A9Bc9qEjSU=;
        b=Jn0RJVpPxCr420B1EaqQ7PsaAGMFnyKCenjMQR6o0veMI39tlejUoBhzp1XS6OME5c
         pqooeQDHhEtJOvTHvzeGZrhRTOgsy3PIuXZck2lEuXgq/izeeysBb/GymByN9Dcy3plV
         G55ISL4DmV/xyosjy5v+ZzhBdXD9yxU0sl6e0PqTLuqhP+5z6B+dseuqAmQ3ZmhJIROt
         dAaK+zzDVIwLDF6GSMNIdvdyCDEkMJxIZzBLs6VYAXFJyNUuxigb121SyX3TUmESAnb8
         +9WdBydrupbFyXNqRRfwrVaPfzkN7wrMrgwLVUuqbZym758l1PxhZaGpvWdO5j1lCBvp
         6n2Q==
X-Gm-Message-State: AOJu0Yz9/8fVS6jXoDbKtSGEcRIRVUDZI8byHyT8Gxvu3cPbycPEFT7d
	0rhenKQYAd8PQ9Ni4pNZ0ntr9Jwe9jb0u1jbkybGrqXx7aoafzRHcsO8xeYNqoaCL24J3VodjUS
	YnlQgfljgrHqA8fRGrjKvWIdLVA358TQHgYYRhn1m
X-Gm-Gg: ASbGnct58IYHJbPPnwLmuTAfpm7RcUeqJ0KOc+0HVLZlevo/mfT8vYlUf99yjahcFpZ
	TfPCirO8MT+H3Sg6KPFRrnNse0of+Gb+V/NJ9bp3KDnegfnLmDAjMmTwreOHGnoUbP4uOVbnw3u
	8pIhvztnKIWcpmSOtn9jLP+AXt1DWgPmBXMg==
X-Google-Smtp-Source: AGHT+IGVdqEkKnUyCTSFT+9+5Aa03z5mtKupyjnf1plFynTemOAfSu/8mZNsQ15tprQhbCLpstHUfH+3BYqpCdCELEM=
X-Received: by 2002:a2e:a9a7:0:b0:32a:885b:d0f with SMTP id
 38308e7fff4ca-32a907b5ffemr33324241fa.24.1748878617891; Mon, 02 Jun 2025
 08:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
 <20250530224035.41886-3-james.quinlan@broadcom.com> <g5rhfbvlx77imub6nn2bx2q6zest3hgsmssjdjrpwqhs2wuan5@uo2ca5asxbpe>
In-Reply-To: <g5rhfbvlx77imub6nn2bx2q6zest3hgsmssjdjrpwqhs2wuan5@uo2ca5asxbpe>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 2 Jun 2025 11:36:45 -0400
X-Gm-Features: AX0GCFvQM320POU3IkAr8ibVY9VrUJrRaRz6J6JSXGjCiwYnJUu3TuOgVjnkxwo
Message-ID: <CA+-6iNxioAQH8vsdPxhjP6gHzhzy3EAKtgOCMncCqgMSMZNRPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000cd249406369888df"

--000000000000cd249406369888df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 2:34=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, May 30, 2025 at 06:40:33PM -0400, Jim Quinlan wrote:
> > By default, we use automatic HW negotiation to ascertain the number of
> > lanes of the PCIe connection.  If the "num-lanes" DT property is presen=
t,
> > assume that the chip's built-in capability information is incorrect or
> > undesired, and use the specified value instead.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index e19628e13898..79fc6d00b7bc 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -46,6 +46,7 @@
> >  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK   0xffffff
> >
> >  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY                    0x04dc
> > +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK       0=
x1f0
> >  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK 0xc00
> >
> >  #define PCIE_RC_CFG_PRIV1_ROOT_CAP                   0x4f8
> > @@ -55,6 +56,9 @@
> >  #define PCIE_RC_DL_MDIO_WR_DATA                              0x1104
> >  #define PCIE_RC_DL_MDIO_RD_DATA                              0x1108
> >
> > +#define PCIE_RC_PL_REG_PHY_CTL_1                     0x1804
> > +#define  PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK   0=
x8
> > +
> >  #define PCIE_RC_PL_PHY_CTL_15                                0x184c
> >  #define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK               0x400000
> >  #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK    0xff
> > @@ -1072,7 +1076,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie=
)
> >       void __iomem *base =3D pcie->base;
> >       struct pci_host_bridge *bridge;
> >       struct resource_entry *entry;
> > -     u32 tmp, burst, aspm_support;
> > +     u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
> >       u8 num_out_wins =3D 0;
> >       int num_inbound_wins =3D 0;
> >       int memc, ret;
> > @@ -1180,6 +1184,26 @@ static int brcm_pcie_setup(struct brcm_pcie *pci=
e)
> >               PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> >       writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> >
> > +     /* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */
> > +     num_lanes_cap =3D u32_get_bits(tmp, PCIE_RC_CFG_PRIV1_LINK_CAPABI=
LITY_MAX_LINK_WIDTH_MASK);
> > +     num_lanes =3D 0;
> > +     /*
> > +      * Use automatic num-lanes HW negotiation by default.  If the
>
> "Use hardware negotiated Max Link Width value by default."
>
> > +      * "num-lanes" DT property is present, assume that the chip's
> > +      * built-in link width capability information is
> > +      * incorrect/undesired and use the specified value instead.
> > +      */
> > +     if (!of_property_read_u32(pcie->np, "num-lanes", &num_lanes) &&
> > +         num_lanes && num_lanes <=3D 4 && num_lanes_cap !=3D num_lanes=
) {
>
> I think you should drop the 'num_lanes && num_lanes <=3D 4' check since t=
he DT
> binding should take care of that. Otherwise, once link width gets increas=
ed, you
> need to update both binding and the driver, which is redundant.
Not all Linux release configuration systems run a comprehensive DT
validator  before execution.  Our bootloader modifies the DT blob on
the fly and also permits -- with restrictions -- customers to modify
the DT at the bootloader command line.  Yes, we can do partial a
priori DT validation, but there is still value to checking the params
in the driver code, at least for us.

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000cd249406369888df
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB7fVqOARSYGFt2JOOBULuds9u54j59
wPH4/m0Ve3sFcTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA2
MDIxNTM2NThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAcSVt7SZZrW+HiQeZds/0lPTeAtCri8ow40DfjvJbKFB1/fjYMndPw4T/ZnxD5tfeI
aFVUUta6+mKhmy6lUr/q94j9tZYnwtDOjy85kH+C3HqvSCgwia+gcDaWqrbitA1rcCO9Yga+8oXV
0nITDsnxVcaMDQjJDk8JBsPW+XBITPk7KKo5WA6+zgB6UWEihgnp458SJuc7zsu28sEVHX2cuKS8
R8CtOELzXAlvn3Ge0Et9isrNGpLd6eMMgSn9NhuI3fm/DzH5Sm5nSO2vlBqGQKr8td1hI2pazqPp
LzlVN6EvXb9toNIu7AwvADS1BgdSWGiPfbJy+Mc7IfI4NULN
--000000000000cd249406369888df--

