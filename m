Return-Path: <linux-pci+bounces-9933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6292A4DD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135C4B20A22
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97B7E56C;
	Mon,  8 Jul 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y5ZTEQiJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE941C06
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449527; cv=none; b=ndVapmPu+DsmyvX5DubJckEUga20BIcGyHS78GT20Qzv2jgqwZqHLMq1e+QFBK7PzlfMpp0NuW3L21w0jV6msbIlO4cSDcdfH8N11u2AF4Xz4mvRL1M1QDODnjtHKBbOroS+z8ldueiTob+ACXDJVygGdz7E7kSRnLkzDW4khJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449527; c=relaxed/simple;
	bh=z7NJJceZUY3lQp80s4sxivGDl9cG5KKYHjfH5sj3dv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njn5MIwFyFdQv05xQdmHxOrqwL2mrb81gy2unsAOkdla4g18a2BrMoExQzGAvghdSN1/tOwKtDzYPR2C7OX2kV2UWNkcmuW2NSnAKLif++QZvryllhfQ0k50P1UUw2a/QdmH/o8Dnt0L19iXB6IMdOstHXcDbDVrmZHiwRo+GyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y5ZTEQiJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so4156346e87.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720449523; x=1721054323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dHgEjK7Jul7gt+7c00A5IfP1fCC8T/s8HGOOo3AeXi4=;
        b=Y5ZTEQiJtdmR/7rf2IY8W2aXCx8HnMPIrBptE5sK1G+SBjHy6E96f2FlODXCLZKHjk
         SvfTdo4naQYsiD/UVX7ov4IgS9RSvxHjamlFqmbgWjxpYp0ueTOyxZqjewDpOVFX7BxS
         EuXsy16AemByGlnFV6zYwQT49vU9Dax1qpVw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449523; x=1721054323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHgEjK7Jul7gt+7c00A5IfP1fCC8T/s8HGOOo3AeXi4=;
        b=RCtHrS0bA8y6HoKrYOBYEHEKmacKsfdemIW1jMP81Z92EUjfclRim67c3WzKEgG4CR
         YlkCIbLx39BS814nwYZ9f9tFe1ID05q0/cPzpeMGSki9KYOaE/QsiPnoveL5zXODA4Bc
         cGKD+uVTQXkCMDvGO2d46cl8Yj09CsAjGLhjqWLadf0LcIFYsTYRCjhD8674wIfDbJFu
         7xQ69nKp68/n2LWyGx5hqYdgEREbeEMxHDbS+uPkAPXLwgrpWG4SEieASN9a96k/fxys
         7e9rISmz1XME04Knf3Vp0Elni5ME53L0xbpTPNty7+H2bzwUTN/sfTrY+rC1ykLNSstM
         uz6A==
X-Forwarded-Encrypted: i=1; AJvYcCXmJAP5X2BUV+qQJ/HZaRJqdItQbLVk8GHNFh3Cjbg10AhoeJLBlNn8wjO9frnz6QTtWMD+XoDc3gGiC1uzKZI6lCkxWtoBzP3Y
X-Gm-Message-State: AOJu0Yxg2jQsmvwc/p/wdZOChUO61nH2ipJjjub5qp37X+6i0gNFDog0
	c0sL2MLylEe/QT5iEhgSqCOzwoES7vcfzdQOt3pMBnj0t0hlGLlq9J5RONckm8Fq2vdX2zXtdLi
	Xv+CJvsYXItFpxVzF4QvTQ4c3Vp7RJ8Vh0Mu2
X-Google-Smtp-Source: AGHT+IFcSPILMhghRpL6i2daNPsKNgeaZT6tK+kpJLAPAw01EVsQ5XBjWbh3Z6yMI92hoLVfP2kIALjOs3Ru8U2BK4w=
X-Received: by 2002:ac2:555b:0:b0:52c:9413:d02f with SMTP id
 2adb3069b0e04-52ea0632accmr8234824e87.17.1720449522996; Mon, 08 Jul 2024
 07:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-5-james.quinlan@broadcom.com> <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
 <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
 <7b03c38f44f295a5484d0162a193f41b39039b85.camel@pengutronix.de>
 <f89d7f45-5d2b-4d8b-9d6a-2d83cd584756@suse.de> <39583bdf7e79d33240e7dd5f09123b94cab4147c.camel@pengutronix.de>
In-Reply-To: <39583bdf7e79d33240e7dd5f09123b94cab4147c.camel@pengutronix.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 8 Jul 2024 10:38:31 -0400
Message-ID: <CA+-6iNzGP3E7xkSk2N4=ms5TR4ozMPUf-KAstD9CBjpA=HoyHQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-pci@vger.kernel.org, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Cyril Brulebois <kibi@debian.org>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b295eb061cbd5eb3"

--000000000000b295eb061cbd5eb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix.d=
e> wrote:
>
> Hi Stanimir,
>
> On Mo, 2024-07-08 at 14:14 +0300, Stanimir Varbanov wrote:
> > Hi Philipp,
> >
> > On 7/8/24 12:37, Philipp Zabel wrote:
> > > On Fr, 2024-07-05 at 13:46 -0400, Jim Quinlan wrote:
> > > > On Thu, Jul 4, 2024 at 8:56=E2=80=AFAM Stanimir Varbanov <svarbanov=
@suse.de> wrote:
> > > > >
> > > > > Hi Jim,
> > > > >
> > > > > On 7/3/24 21:02, Jim Quinlan wrote:
> > > > > > The 7712 SOC adds a software init reset device for the PCIe HW.
> > > > > > If found in the DT node, use it.
> > > > > >
> > > > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/pcie-brcmstb.c | 19 +++++++++++++++++++
> > > > > >  1 file changed, 19 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pc=
i/controller/pcie-brcmstb.c
> > > > > > index 4104c3668fdb..69926ee5c961 100644
> > > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > > @@ -266,6 +266,7 @@ struct brcm_pcie {
> > > > > >       struct reset_control    *rescal;
> > > > > >       struct reset_control    *perst_reset;
> > > > > >       struct reset_control    *bridge;
> > > > > > +     struct reset_control    *swinit;
> > > > > >       int                     num_memc;
> > > > > >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > > > > >       u32                     hw_rev;
> > > > > > @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platfo=
rm_device *pdev)
> > > > > >               dev_err(&pdev->dev, "could not enable clock\n");
> > > > > >               return ret;
> > > > > >       }
> > > > > > +
> > > > > > +     pcie->swinit =3D devm_reset_control_get_optional_exclusiv=
e(&pdev->dev, "swinit");
> > > > > > +     if (IS_ERR(pcie->swinit)) {
> > > > > > +             ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pcie->s=
winit),
> > > > > > +                                 "failed to get 'swinit' reset=
\n");
> > > > > > +             goto clk_out;
> > > > > > +     }
> > > > > >       pcie->rescal =3D devm_reset_control_get_optional_shared(&=
pdev->dev, "rescal");
> > > > > >       if (IS_ERR(pcie->rescal)) {
> > > > > >               ret =3D PTR_ERR(pcie->rescal);
> > > > > > @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platfo=
rm_device *pdev)
> > > > > >               goto clk_out;
> > > > > >       }
> > > > > >
> > > > > > +     ret =3D reset_control_assert(pcie->swinit);
> > > > > > +     if (ret) {
> > > > > > +             dev_err_probe(&pdev->dev, ret, "could not assert =
reset 'swinit'\n");
> > > > > > +             goto clk_out;
> > > > > > +     }
> > > > > > +     ret =3D reset_control_deassert(pcie->swinit);
> > > > > > +     if (ret) {
> > > > > > +             dev_err(&pdev->dev, "could not de-assert reset 's=
winit' after asserting\n");
> > > > > > +             goto clk_out;
> > > > > > +     }
> > > > >
> > > > > why not call reset_control_reset(pcie->swinit) directly?
> > > > Hi Stan,
> > > >
> > > > There is no reset_control_reset() method defined for reset-brcmstb.=
c.
> > > > The only reason I can
> > > > think of for this is that it allows the callers of assert/deassert =
to
> > > > insert a delay if desired.
> > >
> > > The main reason for the existence of reset_control_reset() is that
> > > there are reset controllers that can only be triggered (e.g. by writi=
ng
> > > a bit to a self-clearing register) to produce a complete reset pulse,
> > > with assertion, delay, and deassertion all handled by the reset
> > > controller.
> >
> > Got it. Thank you for explanation.
> >
> > But, IMO that means that the consumer driver should have knowledge of
> > low-level reset implementation, which is not generic API?
>
> Kind of. If the reset controller hardware has self-clearing resets, it
> is impossible to implement manual reset_control_assert/deassert() on
> top. So if a reset consumer requires that level of control, it just
> can't work with a self-deasserting controller. The other way around, a
> reset controller driver can emulate self-deasserting resets, iff it
> knows the timing requirements of all consumers.
>
> If the reset consumer only needs to see a pulse on the reset line, and
> there are no ordering requirements with other resets or clocks, and the
> device either doesn't care about timing or the reset controller knows
> how to produce the required delay, then using reset_control_reset()
> would be semantically correct.
>
> > Otherwise, I don't see a problem to implement asset/deassert sequence i=
n
> > .reset op in this particular reset-brcmstb.c low-level driver.
>
> When reset_control_reset() is used, every reset controller that can be
> paired with this consumer needs to implement the .reset method,
> requiring to know the delay requirements for all of their consumers.
> The reset-simple driver implements this with a configurable worst-case
> delay, for example. As far as I can see, that has never been used.
>
> So yes, in this particular case, pcie-brcmstb only ever being paired
> with reset-brcmstb, it might be no problem to implement .reset in
> reset-brcmstb correctly, if all its consumers and their required delays
> are known.

This will not work.  reset-brcmstb.c is a reset provider; it provides
resets for dozens of different HW blocks.  Forcing  dozens of the
resets  to operate at the worst-case delay of the slowest one of them
is unacceptable, especially if a particular HW block uses its reset
often  and/or requires timely execution.

Regards,
Jim Quinlan
Broadcom STB/CM


>
> regards
> Philipp

--000000000000b295eb061cbd5eb3
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDTpDyKGp6WN4Vr9+9rNpQIhDPbj834
2i9E/lWxJ0h2gDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDgxNDM4NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAfBku4bZC0rFoNLf/rlv0pFLzsM8Lbwvxv3Z5qo6hmW6BIWxy
70EG80CfKS9MF6Wrzscw8aS4IAx0rTz5qadAFmll0j/xMZ6ha+XUNwJA4qYT5NC/gPlrNkJP+hGO
88B63GQz05p9tw4ywvhmIQHIxQZ9sfjmCFK1rGc5wcxo9o34EaxyvvMeyrXgiVQsskLMpjEV+JIL
JC0HynBRtlVY+rKPL7vQ2t+OnJwiW/ONivE5Oh2IremH7rYcEwXs8/TbSrgCZnhRuL3cqfPx5y+M
KcYK39LmR6v9TGHA2D1hlHsVACeaxO5qth0pQiAYhX506g/IPOZwHom53Eipf2xWrQ==
--000000000000b295eb061cbd5eb3--

