Return-Path: <linux-pci+bounces-9602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4819246C7
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03879B21172
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB951C005C;
	Tue,  2 Jul 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YhHf9+kY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9321BE233
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943214; cv=none; b=ODrqKCt79b4udP42p1ZIizwdQX9Wk74HccOOrpx3IBFG0or3SWWq/RMLbEiZomCqsjvN5/jLZoHdpA6E0M/twski/DwrF0nzS1jB1hnVjjwn3eZ61mGekB2LrTE5G/dRiBkb60R8Y0TOTzIlI5uLrB3qY6GZ48kpaodPNogYFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943214; c=relaxed/simple;
	bh=1UUzKw+NIx5KAJfQO4KpoB9MqwRXKBYm81arMqJQZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYUOxiyD5p8EFk+q9T1XGOAnro5rjfRZ3nrOrXgwgbB2TyZzjOubCYE7qN47LBH2d9EeBvVFsT/st5bUx1HG3ofDHMw6ZlZwPL33o8WacTD6wFhcVeNd438pV3QzXUB8Z9bCion+vbQ8CW5ScjDHobRHbG6ZPbu2M3AXfoVZec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YhHf9+kY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee7885ac1cso9447891fa.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2024 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719943210; x=1720548010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+EYO/Fof5ytQK089xUZu+BwZD7BqTc9anvut30xQ4eU=;
        b=YhHf9+kYl2KqLFm54WWnGBTdJYRmwZe7eLjcocxWLgxER9TvukSokkQ3rh3YLgamiJ
         TpvkuEoLzTVwyST/9dLgorNvNvh2sJK/145/CRrTHRZscEaXt7opAVWNRe2AUgxQ6VTZ
         aMRGP/PguuHJcqIWUBWYJ73bQ9aJMJitrRtfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943210; x=1720548010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EYO/Fof5ytQK089xUZu+BwZD7BqTc9anvut30xQ4eU=;
        b=VcRZRoH5FHa8xZ6TldrK7nTtSgTECX6/ac2/NfHQWNQrU4XVQUzGulpwI6huSeoKa2
         inkDRcj5mEZp0+1otLA4hwybHmRI61jUmq+uK+9BgJlw1vqhy2gN6CCtHntE4mE403pW
         /GCI+zBTpLaN23i2/I+xHwcW7ztgrMz2MakfR4tCv1WYBXSh+0bBAzW6G0nXACyIHiyZ
         Q5cpTtOJB9ORTkYh1CQcpmITHPLhuq9NgqhtYpJPqszPE1fySRdeXfL2g/TqazQw6eOv
         6ldcFDJj9H4eeOI2sAIZqVn974OiMNttYfYH06mgePEMj8TBof7sWjsF4gwgEsPpQvWh
         jmlg==
X-Gm-Message-State: AOJu0YwKoXpwQkwJycw36NcYGrYhLNa03kpFQLrIl6s7XVapEKwSuVFr
	LDY3WGYyim9DSQIJPDdyn47pqN/awlFzHW3Kbj79hJNj5pRQ3j19FKZIMSMB5hNV/POPJMfvDXT
	TeThvnWdKWO248c5c65KHPng102+bdFUHCSO4
X-Google-Smtp-Source: AGHT+IGSIBg/kb6Zc1hpW5+Nn3cINYiHVwnBqzvPouevQiqHZGBw9UidxB430o0el45WXLGKJZ71NE1m6+GRZGz2U5k=
X-Received: by 2002:a05:6512:3d08:b0:52c:dec1:4578 with SMTP id
 2adb3069b0e04-52e82730c73mr6942021e87.60.1719943210355; Tue, 02 Jul 2024
 11:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628205430.24775-1-james.quinlan@broadcom.com>
 <20240628205430.24775-7-james.quinlan@broadcom.com> <c4633d7a-11a4-4c1c-954b-45f631cb2563@suse.de>
In-Reply-To: <c4633d7a-11a4-4c1c-954b-45f631cb2563@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 2 Jul 2024 13:59:57 -0400
Message-ID: <CA+-6iNwmqq1YnmzeD0=kniPSmKLDwY_KZ322ZUM7GpTvE9Zv6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] PCI: brcmstb: Don't conflate the reset rescal with
 phy ctrl
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001cc2bd061c477cce"

--0000000000001cc2bd061c477cce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:10=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.de=
> wrote:
>
>
>
> On 6/28/24 23:54, Jim Quinlan wrote:
> > We've been assuming that if an SOC has a "rescal" reset controller that=
 we
> > should automatically invoke brcm_phy_cntl(...).  This will not be true =
in
> > future SOCs, so we create a bool "has_phy" and adjust the cfg_data
> > appropriately (we need to give 7216 its own cfg_data structure instead =
of
> > sharing one).
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 4e0848e1311f..e740e2966a5c 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -227,6 +227,7 @@ enum pcie_type {
> >  struct pcie_cfg_data {
> >       const int *offsets;
> >       const enum pcie_type type;
> > +     const bool has_phy;
> >       void (*perst_set)(struct brcm_pcie *pcie, u32 val);
> >       void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> >  };
> > @@ -277,6 +278,7 @@ struct brcm_pcie {
> >       void                    (*bridge_sw_init_set)(struct brcm_pcie *p=
cie, u32 val);
> >       struct subdev_regulators *sr;
> >       bool                    ep_wakeup_capable;
> > +     bool                    has_phy;
> >  };
> >
> >  static inline bool is_bmips(const struct brcm_pcie *pcie)
> > @@ -1316,12 +1318,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie=
, const int start)
> >
> >  static inline int brcm_phy_start(struct brcm_pcie *pcie)
> >  {
> > -     return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> > +     return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
> >  }
> >
> >  static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> >  {
> > -     return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> > +     return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
> >  }
> >
> >  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> > @@ -1564,12 +1566,20 @@ static const struct pcie_cfg_data bcm2711_cfg =
=3D {
> >       .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_generic,
> >  };
> >
> > +static const struct pcie_cfg_data bcm7216_cfg =3D {
> > +     .offsets        =3D pcie_offset_bcm7278,
> > +     .type           =3D BCM7278,
>
> This "type" field is confusing, maybe it would be good to rename it to
> "family"? For example BCM72XX family.

Hi Stanimir,

I'm open for another name but "family" would present problems with Broadcom=
 STB.
For example, we call 7216b0 a "family" as there are a number of
derivative products based off
of this general design.  Second, having something like "BCM72XX" won't work=
;
we have 7211 which is something altogether different from the 7216.
Note that we only
introduce a new "type" when we need to; if the behavior is the same as
a previously declared
"type" we do not introduce new ones.

But if you wanted to change "type" to "model" then I have no problem with t=
hat.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> > +     .perst_set      =3D brcm_pcie_perst_set_7278,
> > +     .bridge_sw_init_set =3D brcm_pcie_bridge_sw_init_set_7278,
> > +     .has_phy        =3D true,
> > +};
> > +
> >  static const struct of_device_id brcm_pcie_match[] =3D {
> >       { .compatible =3D "brcm,bcm2711-pcie", .data =3D &bcm2711_cfg },
> >       { .compatible =3D "brcm,bcm4908-pcie", .data =3D &bcm4908_cfg },
> >       { .compatible =3D "brcm,bcm7211-pcie", .data =3D &generic_cfg },
> >       { .compatible =3D "brcm,bcm7278-pcie", .data =3D &bcm7278_cfg },
> > -     { .compatible =3D "brcm,bcm7216-pcie", .data =3D &bcm7278_cfg },
> > +     { .compatible =3D "brcm,bcm7216-pcie", .data =3D &bcm7216_cfg },
> >       { .compatible =3D "brcm,bcm7445-pcie", .data =3D &generic_cfg },
> >       { .compatible =3D "brcm,bcm7435-pcie", .data =3D &bcm7435_cfg },
> >       { .compatible =3D "brcm,bcm7425-pcie", .data =3D &bcm7425_cfg },
> > @@ -1617,6 +1627,7 @@ static int brcm_pcie_probe(struct platform_device=
 *pdev)
> >       pcie->type =3D data->type;
> >       pcie->perst_set =3D data->perst_set;
> >       pcie->bridge_sw_init_set =3D data->bridge_sw_init_set;
> > +     pcie->has_phy =3D data->has_phy;
> >
> >       pcie->base =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(pcie->base))
>
> ~Stan

--0000000000001cc2bd061c477cce
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC1Smgidr+OepwWNUO6KOwclblzzXEs
RLMbBcCPn1FXGjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDIxODAwMTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAFihaVreDpTLwNwqtRxILfRD75Na4yerL/ZQvIjZaBc/eNHmN
+iNTfoi5mRnOs0ZLs1JZymUYb4qmog2Akuqb+icBjk9R9mabpRebRbj8m/peOBZIZj6e8KK6E2Gl
9B3s9EOC4eYb/NKvBI3IMFW16Y0tUqBg+wt2QgZ5yy4jjJ5beKRt7zW0XyehQ2P8wqON/e4gJcLX
L54Wr0UMGZYsZd3qunTTvNyVYCO8U27CGDveT+InuKlvhObuOt/8LpvSG1KgUZs2eic1cg2SRLg4
bhs9DBqLSsMsB3na5Lh574ZB8jeD0bAKPOiC2Q7nzopFvgkmInolpIHlwtHWTeM08Q==
--0000000000001cc2bd061c477cce--

