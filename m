Return-Path: <linux-pci+bounces-11594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311EF94F16F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7ACE1F22D04
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5F18309C;
	Mon, 12 Aug 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c/Ybk+F0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633517C7CB
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475627; cv=none; b=dO5dULb75d0d+jiNW7VZxvC4HTUzv7dVmI8HSvDTIICti11FtwQk0LwZo77ezp0ivvsm6GV/PYLNFvBLeXkb0YFzBzh+l7efdbh83q9P3g5khh1NICbq/Jy8MRPX/g+HMZJlF4F1FOttQNFtM/fFBcUVkJcmMIHKA+pLVWyqNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475627; c=relaxed/simple;
	bh=rpmWrEedWY3QNGB3PIWFg+/D5Yc/ncvBQ+qjDo4zBfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETiKf+n/ukEZy7d/vDCHlW1T9w5i9RecXqvqlRFiCqNywW9dfeiyCVb0hwTFhkh9PfN19jzgVsqxrBzZBju9evo6xohaSk4yHdrJGLJa0PJPYe+T8ElDv9JmyX4i8mp2EZilA5pHxoRkgxrch4Qu5OPCxs+uN1gmnLeUCpLo/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c/Ybk+F0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso5391527a12.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723475624; x=1724080424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZPxaF048Nim5DF8Aukw6dtsU3LGJ/HOCAjyougnF1Q=;
        b=c/Ybk+F02l5XfrU3znsqSsphSQc9VxCbtnSv/nSYiv4di3kxNhl9OkjX139p2zCiCv
         c9InwPM5x723k5Xnha7yKXWJqgQiuIzXusV+Bsymxc7sP32c0zDl0gYZpzwK0CL0euoy
         BcaVZHkJ36SfV+68iYsVhvaHX5IrehIrFc6Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475624; x=1724080424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZPxaF048Nim5DF8Aukw6dtsU3LGJ/HOCAjyougnF1Q=;
        b=auho6VhBgwFbbdD2FOEsCOkc6WX8kj4cIFnnj1Bo7oVGlFyTgEA1Ofygp3f/WOfXyL
         ea5xxW+oHLzfNpHb2QaDcRqxts+j6pfLjvfYe6sC5EGlOfZE1x6gjCsaHPIArDJT0GX6
         2HlBV5OaLYuQVGNIm9ckmdacZSQNF1k8hSOKja6Uaww3Jp2Hl2Sj7OktzZ7vd/6paD+d
         i3QI8D/e2VV9J5P0aB0b//SAnn2nkg71Hcvhg8rbvRzjq+FIQ+15rgo0pDX61nlr+hwf
         zsceCUBytPRt4ixnsSySnGp/N/W50h/1m9EVj9ygDj8t4CaAs/Ko0uf2YoIu6WMhxiy7
         e/4w==
X-Gm-Message-State: AOJu0Yx46IGmnWbxLOdOtU0bCl5zHgBz7anx5OFpzxk0VLBWbRMocjR+
	AdIwjJ3wRMyNROsnOkzHRAZTgMzQfc5mHY+M/7OXKHcwOaSJv4GK45x59Aab1g/xFWCPgSQqtF8
	fyk012fsyrla5H9zk+YMFxiTrScKQVoOl6jOW
X-Google-Smtp-Source: AGHT+IHniSrKt4svGrlgWGMcN74jBNJUagHUo+4pIK5NYT1VKOSt5ZsnS6EjfqBfqjGT1wp0JJips8VHibVShuAxmx4=
X-Received: by 2002:a17:907:f1c3:b0:a7d:a28d:8cd1 with SMTP id
 a640c23a62f3a-a80ed1efe16mr50410766b.26.1723475623833; Mon, 12 Aug 2024
 08:13:43 -0700 (PDT)
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
Date: Mon, 12 Aug 2024 11:13:31 -0400
Message-ID: <CA+-6iNw3HP1oZj_Z3h5DwaxOVfv4OeY=NFZf62Qk3ewu76QXDw@mail.gmail.com>
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
	boundary="0000000000005fc698061f7df0eb"

--0000000000005fc698061f7df0eb
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

Hi Stan,
Yes you are correct, thank you.  It is shared with the driver in
drivers/ata/ahci_brcm.c.  I don't know how this got changed
to exclusive.  Will fix.

Regards,
Jim Quinlan
Broadcom STB/CM

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
>
> > +
> >       ret =3D reset_control_reset(pcie->rescal);
> >       if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n=
"))
> >               goto clk_disable_unprepare;
>
> ~Stan

--0000000000005fc698061f7df0eb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbgYJKoZIhvcNAQcCoIIQXzCCEFsCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3FMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU0wggQ1oAMCAQICDEjuN1Vuw+TT9V/ygzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE3MTNaFw0yNTA5MTAxMjE3MTNaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFDASBgNVBAMTC0ppbSBRdWlubGFuMSkwJwYJKoZIhvcNAQkB
FhpqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAKtQZbH0dDsCEixB9shqHxmN7R0Tywh2HUGagri/LzbKgXsvGH/LjKUjwFOQwFe4EIVds/0S
hNqJNn6Z/DzcMdIAfbMJ7juijAJCzZSg8m164K+7ipfhk7SFmnv71spEVlo7tr41/DT2HvUCo93M
7Hu+D3IWHBqIg9YYs3tZzxhxXKtJW6SH7jKRz1Y94pEYplGQLM+uuPCZaARbh+i0auVCQNnxgfQ/
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC2cB5tkgeVLDmonKZaVFkhNbTwB9AN
+4M3YOUi4Wa8VjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTIxNTEzNDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAkgvhP1YFapt9A8rSs+c+45Ooa88HjLF30av1c5fBkMeDTFkM
ovEE6NpHpaedVrMQ/2GscfJDsbXbclKUq77GDidpKDsMdjbO+Hqs7SeSToCZPa8MwBz0HtvRcT6s
Kk1lQ/E7Edi27bvxBpucEf8vJTB26R2O8LzQPzdNKeeBbYKGiDbUXtLbi+/58pMFRNHMlj1TbL25
ysjp7951KqgWQSf6cmp7zs1ldbFyrBUao7+QU9+AK4yoXd6TSMBRdJ2RbJokItYJAcbVZjt6l8rU
SqKSHit3M7UkcLoYh4Pbg1XNX21eX0fb2g7YF/EPVPQoHgR6rAfbKprj3KOGEVrbMw==
--0000000000005fc698061f7df0eb--

