Return-Path: <linux-pci+bounces-20826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5CA2B12A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22656188BC9A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C09239582;
	Thu,  6 Feb 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FYijBbcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07419C546
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866479; cv=none; b=L1xGyMAajKyRIMvyK0nqqF5bLcSU+qyyyYH4FhvggDKBwbBg1X4HagL2ll97nLfQbfVrWEO4CCjHYTCMbZQVh5eCdvAGdFkbNUoWvJ2y5k2SDGq9zdzz1GBggTFL8YU5TLGZcOVQgZSHlmFjvzLd5WAuWpAyUQcAAQ8R+uOtRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866479; c=relaxed/simple;
	bh=RDxshFrGGqUncF3jbW8WFrk01NHy6KEdHDVoPC1P3aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBIXEWiYC4ZfhwSVgF2TiOiKyuuQTWO56iFpVxntkByqV1cjIUexGDe9U1FEx4CQtFlLsMUmLf47gCp1kyzeAEttWjxFgyK2U7CBzfQG1eIoZXXEN+wx7nPvYqTCfBmnj0rJvzeSjDoy+x0pOFK6BnUSBcKS79wL7/fCYSfiwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FYijBbcO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-543e47e93a3so1336978e87.2
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738866476; x=1739471276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5SN17pm/qBGhBIPCl3UfJe6k5kUMuMslIH03Bk9ST0o=;
        b=FYijBbcOeVwJ9w8lJUTdDRT8lLnOBP8RlR+8KGslcofW6vbwgUhLJ+0pK5TmyBfMg9
         PF3nd8NWzCuCbTevnbTUHv9Rpf32UaDkoOYB6IvdtYfvLYyOSreXGrCLEHmitl+dmHag
         cYk7TUKBC0cfhWp6a/CunL8Ekn9+BKIRWV/Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738866476; x=1739471276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SN17pm/qBGhBIPCl3UfJe6k5kUMuMslIH03Bk9ST0o=;
        b=VNRLtG6WNZ4FGTx2MytxZwIms/N9CEu2viI0EnSKDjDfXJ3wcSxNEvoXU6vxhecN13
         y/NicZafliavn+jAuifMRBG6GLDiF5eZTpdd48X1yXi1bgRVFCkyB3InxxE5iW2PjFXN
         WwzSq+owioL2ZaV0ipdmsN8Vl//zofz+DUGwCNJ8Kp5rbbYL4yqmDC5WXUaDvzUg0qCn
         aewn+Wxc8PiLd9GSdVPgz9bPYWWWkX5MK+ilLGbdA1zrp92nUCsgD69T3nT3CKj69wkp
         WywvkvC7pbudzySnKIpzE+PkH4OuiqlC42DxC0uZvN1us3vn301YUHNHLAcMiok90rFn
         VCTg==
X-Gm-Message-State: AOJu0Yz0A1QxbHas9gbL+2U9sHIfDawc3EZNjIDmIPrceSHAZwBWOL+t
	Liug08ydXbrk6KiRtSA4nhPLfV1NcH0VbT7bdabf6xF2CNuKCsCvCtfQGX8zsQ7zgXcuzAWxe1l
	FYOLipKXUrX/FmPSzdd5o2T+iX6Gy8OrL4pZe
X-Gm-Gg: ASbGncu52oVqnOE3TE9NlTy5zA/NE09TWIMbcR/qgVJU8DNYJR+qb2u33+mMtb57zpE
	Ht9B7wggeK5jUqPveD8xKCColYdeMchncDyI9+ZjBYVk3kjNgbFG8fgKFD+iaF1LLlmPi6aMxVQ
	==
X-Google-Smtp-Source: AGHT+IHIwsA+HwY8ulNZvcSdBQxkzlbi4o6HBlkMOETgMCnwsDth9saknsyrOUq1Z6JJqEXzkC2yxek+n9BEtEH4kSo=
X-Received: by 2002:a05:6512:b20:b0:543:9a5c:1906 with SMTP id
 2adb3069b0e04-54405a23143mr2890762e87.17.1738866475817; Thu, 06 Feb 2025
 10:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205191213.29202-2-james.quinlan@broadcom.com> <20250206170417.GA989059@bhelgaas>
In-Reply-To: <20250206170417.GA989059@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 6 Feb 2025 13:27:44 -0500
X-Gm-Features: AWEUYZk-ZLpZaP6sZppE42gBAP8u6jWeeP564q0Ft05oiQwjuzu8e_bosC0DpdE
Message-ID: <CA+-6iNwY-Fc-nfawc_EtDRBvYht_491v80THW=4F-iY7Nqa81w@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] PCI: brcmstb: Refactor max speed limit functionality
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
	boundary="000000000000a080aa062d7d6612"

--000000000000a080aa062d7d6612
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 12:04=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Feb 05, 2025 at 02:12:01PM -0500, Jim Quinlan wrote:
> > Make changes to the code that limits the PCIe max speed.
> >
> > (1) Do the changes before link-up, not after.  We do not want
> >     to temporarily rise to a higher speed than desired.
>
> This is a functional change that should be split into its own patch.
> That will also make it obvious that this is not simple refactoring as
> the subject line advertises.
ack
>
> > (2) Use constants from pci_reg.h when possible
> > (3) Use uXX_replace_bits(...) for setting a register field.
>
> > (4) Use the internal link capabilities register for writing
> >     the max speed, not the official config space register
> >     where the speed field is RO.  Updating this field is
> >     not necessary to limit the speed so this mistake was
> >     harmless.
>
> Also a bug fix (though harmless in this case) that deserves to be
> split out so the distinction between the internal and the architected
> paths to the register is highlighted and may help prevent the same
> mistake in the future.
ack
>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 546056f7f0d3..f8fc3d620ee2 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -47,6 +47,7 @@
> >
> >  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY                    0x04dc
> >  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK 0xc00
> > +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_SPEED_MASK       0=
xf
>
> If the format of this internal register is different, of course we
> need a new #define for this.  But if this is just a different path to
> LNKCAP, and both paths read the same bits in the same format, I don't
> see the point of a new #define.
ack
>
> >  #define PCIE_RC_CFG_PRIV1_ROOT_CAP                   0x4f8
> >  #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK   0xf8
> > @@ -413,12 +414,12 @@ static int brcm_pcie_set_ssc(struct brcm_pcie *pc=
ie)
> >  static void brcm_pcie_set_gen(struct brcm_pcie *pcie, int gen)
> >  {
> >       u16 lnkctl2 =3D readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_L=
NKCTL2);
> > -     u32 lnkcap =3D readl(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LN=
KCAP);
> > +     u32 lnkcap =3D readl(pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILI=
TY);
> >
> > -     lnkcap =3D (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> > -     writel(lnkcap, pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> > +     u32p_replace_bits(&lnkcap, gen, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY=
_MAX_LINK_SPEED_MASK);
> > +     writel(lnkcap, pcie->base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> >
> > -     lnkctl2 =3D (lnkctl2 & ~0xf) | gen;
> > +     u16p_replace_bits(&lnkctl2, gen, PCI_EXP_LNKCTL2_TLS);
>
>
> OK.  I am not really a fan of the uXX_replace_bits() thing because
> it's not widely used (I found 341 instances tree-wide, compared to
> 14000+ for FIELD_PREP()), grep can't find the definition easily, and
> stylistically it doesn't fit with GENMASK(), FIELD_PREP(), etc.
>
> But it's already used throughout brcmstb.c, so we should be
> consistent.

And here I thought that uXX_replace_bits()  was the up-and-coming
solution to be used :-)

Regards,
Jim Quinlan
Broadcom STB/CM

--000000000000a080aa062d7d6612
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCANktrH1vDidhFBB/uzZZo/sajJ5dAg
TVfuzucy0mSZSjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTAy
MDYxODI3NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAj1cEfUeU2VC4QQUIb81R06nzsZgB5SsGR7sfsCVtiD/ZFoSV
57gvTRaeG1407mgBMX568JFURoVFBZYTVQtkZw35TG0p0ASu9siVoPmGQ29KmDi/mZ7CorAlZb+P
YHD1pw8OR8YW4d5ovoJkC7tz7Kw0mQ40FbgqUaNyy2aVK8yZua+/XMTVvCDqs/p+ze4R3GklfCsf
rNmxKIt2vSZTF9Us7s/MXLjFfXavYFMpGRV2Jm2DrBQ5SYl2LxoGdAIHjgtaAekMJujtBxIjjIeR
psWD0wrh+v76j3Louv/H3SDJsGBfrZzSS0B5skNdSzH8bbtDznLtfOHtOWgNwc/4Hg==
--000000000000a080aa062d7d6612--

