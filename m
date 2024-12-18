Return-Path: <linux-pci+bounces-18719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F999F6AEE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA5166BD2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8601A1EF0A5;
	Wed, 18 Dec 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hsXDcYFp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E731E9B1E
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538843; cv=none; b=deT4DP59nHeyPCmsxvXRmrrwlcFdswxRrGWC1Cc5atDCj+dQK++uOCyD0cq0kNWSEoT4D5hY5QdPCj5XDTtn82hCkrxTwQAYa02Redzo3wTlOtwUfaiBu4D0lBboq2Vbtad4kKTdl1SfJfJ2I8bxgBxyT2yrsH9Yoepk4FbJGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538843; c=relaxed/simple;
	bh=P5wnK9AZaSpSjA3tPtlHGdecE8DW1DE+F0G5JMcZanw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY2qdLTlkbtfYE9jhEtPGVrwhsMSKSOLchWgI4ZiPh9HA9Ns+FEc5Q55uZyc2/ZM6CN8mmL3cB9AbrymWOPdlbENNv0PCC7DW2gnro1avnl5JWiSQ++Dt+vMzixUulUWH4RipnuZbMkBsTVCUhHxxPzrOEfF7tNoFkHZzyltvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hsXDcYFp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-540254357c8so6001780e87.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734538840; x=1735143640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l45pgJs/4MqdenyBlcp8ZntWnRoNTuWBaDCKkdk1XQw=;
        b=hsXDcYFpFvGoIOLvuJ4pt//xNcYqqTmnw+Cr78gOOWPmuWEeboARezgWu+Qc5LpJbD
         04SdDf2Mlp1G3g/HXt5kSJfwZ+XnO0J32UhZ1JKfxQ72R4vVT1L4NPQQ+7BipU1T2/LB
         d2T1d0ZDCXwjZLiYAkbnrdC8ddjyOCsmoSzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734538840; x=1735143640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l45pgJs/4MqdenyBlcp8ZntWnRoNTuWBaDCKkdk1XQw=;
        b=ti3rtCpdr6XDOfe4Thh10tbnyVZQ22akr0VJg9X4vyK5oecI7dep3Dm7CCylD7/Pxk
         qBpHeZlZwkYgy+aGk5YN+48kfK4oocoSqgr4XDTIfMC2P+7p+p6KbkwUKoWYhD6QS7RO
         jdoOD0goJjjcEjDoxX2TFc1MHm1zVlIypYN2uSiW/zZZ6Kg9m8Mftn9qrnI5pH1eWxmt
         ocr4+aiFfwrcCwfzPVSvgwLaTZ89iVt26LR3lKbvOuCigpgSyH2zPdZ+Sywal3r7oebr
         wypoF+argIF5Rjkqel50KiLZaDKlcH4KKLoHbt3W9Ich3wmGRvPQxAKDaaMdSUzrrv0t
         XpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpBjG5RStr2dWVuZ7Z9a1SlKAMYkikR7SpUld9O2PAeZUAI/VKltvk5zBYar7ej7c08riuMVtNFco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpgQ/BgsDd44VLUCguGozZAFHlxquPFLYudWx9PSXWvW0iPzu
	taGNp4elYMkS2/lh5ZaXz7Y3p4iiC9dTLYKQ9WV53rumFjtXmQO71vii/5lIgvA18PU9tP/6IJ8
	sZ7QWZw8/+rm5jHL3+2NuaFDkO8RbY4WDK4m1
X-Gm-Gg: ASbGnctTkYljvhV7HOA227vJ4/LATy9H8zL4eHZEgCqbtl83E9ERbkbpZXgNlzoWrau
	6PN5RPGNgFZPQPTI/wzIsOjp9M3uLsbc3M0fV1uk=
X-Google-Smtp-Source: AGHT+IHPR12/buKMZ0hHVlYG+m7Psb/jp38L07d6lQgBRaffV8bsiA/VtiLkBrTXSIr1xkOGNxKVNTd4vBeI9TVWsiw=
X-Received: by 2002:a05:6512:3996:b0:540:5253:966e with SMTP id
 2adb3069b0e04-541ed901567mr1278594e87.44.1734538839568; Wed, 18 Dec 2024
 08:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025124515.14066-1-svarbanov@suse.de> <20241025124515.14066-7-svarbanov@suse.de>
 <f0a734d9-6bf6-4d28-b30b-99b6be9f62dc@broadcom.com> <ab136131-a306-4344-adaf-904e3b32326e@suse.de>
In-Reply-To: <ab136131-a306-4344-adaf-904e3b32326e@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 18 Dec 2024 11:20:26 -0500
Message-ID: <CA+-6iNytvANeUb3ugW0q3B18MTNwnJps_yggonKRjXh_sTWHmA@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000068396406298dcb99"

--00000000000068396406298dcb99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 9:54=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Hi Jim,
>
> Thanks for comments!
>
> On 12/11/24 10:01 PM, James Quinlan wrote:
> > On 10/25/24 08:45, Stanimir Varbanov wrote:
> >> On RPi5 there is an external MIP MSI-X interrupt controller
> >> which can handle up to 64 interrupts.
> >>
> >> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> >> ---
> >> v3 -> v4:
> >>   - no changes.
> >>
> >>   drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++=
--
> >>   1 file changed, 59 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/
> >> controller/pcie-brcmstb.c
> >> index c01462b07eea..af01a7915c94 100644
> >> --- a/drivers/pci/controller/pcie-brcmstb.c
> >> +++ b/drivers/pci/controller/pcie-brcmstb.c
> >> @@ -1318,6 +1318,52 @@ static int brcm_pcie_start_link(struct
> >> brcm_pcie *pcie)
> >>       return 0;
> >>   }
> >>   +static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
> >> +                      struct device_node *msi_np)
> >> +{
> >> +    struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
> >> +    u64 msi_pci_addr, msi_phys_addr;
> >> +    struct resource r;
> >> +    int mip_bar, ret;
> >> +    u32 val, reg;
> >> +
> >> +    ret =3D of_property_read_reg(msi_np, 1, &msi_pci_addr, NULL);
> >> +    if (ret)
> >> +        return ret;
> >> +
> >> +    ret =3D of_address_to_resource(msi_np, 0, &r);
> >> +    if (ret)
> >> +        return ret;
> >> +
> >> +    msi_phys_addr =3D r.start;
> >> +
> >> +    /* Find free inbound window for MIP access */
> >> +    mip_bar =3D brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> >> +    if (mip_bar < 0)
> >> +        return mip_bar;
> >> +
> >> +    mip_bar +=3D 1;
> >> +    reg =3D brcm_bar_reg_offset(mip_bar);
> >> +
> >> +    val =3D lower_32_bits(msi_pci_addr);
> >> +    val |=3D brcm_pcie_encode_ibar_size(SZ_4K);
> >> +    writel(val, pcie->base + reg);
> >> +
> >> +    val =3D upper_32_bits(msi_pci_addr);
> >> +    writel(val, pcie->base + reg + 4);
> >> +
> >> +    reg =3D brcm_ubus_reg_offset(mip_bar);
> >> +
> >> +    val =3D lower_32_bits(msi_phys_addr);
> >> +    val |=3D PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
> >> +    writel(val, pcie->base + reg);
> >> +
> >> +    val =3D upper_32_bits(msi_phys_addr);
> >> +    writel(val, pcie->base + reg + 4);
> >
> > Hi Stan,
> >
> > It looks like all this is doing is setting up an identity-mapped inboun=
d
> > window, is that correct?  If so, couldn't you get the same effect by
> > adding an identity-mapped dma-range in the PCIe DT node?
>
> Yes, that approach could work, I verified it.
>
> Do you want me to drop this patch from the series and make the relevant
> changes in PCIe dma-ranges properties?
>
Hi Stan,

Yes please, that was what I was hoping for -- the less code the
better, assuming everything still works :-)

Thanks & regards,
Jim Quinlan
Broadcom STB/CM

> ~Stan
>
>
>

--00000000000068396406298dcb99
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBFED7/qjrkPTzucAY7hjTJNrRD+6+F
nyPLFdKyQbzBOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDEy
MTgxNjIwNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAcL5nW3j7McrTrwLnVFCNqj0JPbjzTEBlo3oMFk6EEL4o41MC
yURD/0xnl6G0cDb4NTCX1/uIaCSD+zWOVzPm+NABhkYepgDA82CSDd2ip08w7wuM6paOA97mep0g
CSHXGLttSdoqGmSKnJsurJ+VfXaGmSKynTkBTq2sp3kUMapwObjrToj2OtMT12PIIT6jWy764Yv1
SdPC3c0woFRcDI1nnRe3SW2FzdIK7W5USaf08uICc30KNRIuXzZYol8ZWSrOV+rlsAef7K1O/Xzc
kpkdmliwxmMFK+V5GyswfGP5zHtm/KOzZEC/NpUVfAjJZWMT7DCm1+H9ru4dZi76MA==
--00000000000068396406298dcb99--

