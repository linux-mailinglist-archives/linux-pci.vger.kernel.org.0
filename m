Return-Path: <linux-pci+bounces-9852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010B928D25
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E51F22D52
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0714A4C1;
	Fri,  5 Jul 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yzvdw+R1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271F73518
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720201588; cv=none; b=I696A+EJHId7JX8GWEPVngFnwS0zvD7mQ9xK55vCF1wOUKev6MB1+Rv33i5qTRfv5L32iIVn5MjH3/QzjZ7nPxiHr/nKQV6XWZN/+3GtuamUefyAhSP+rLyTl/UsVhIAVduAGFRLdt/3PFFWHxlEWVBPJ4q9ZCDuOhFFEpJicTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720201588; c=relaxed/simple;
	bh=84NpfXVTQ9W/8Yj/NYhAFmzOFXTLIfkjVJ0RrDMPvmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRnRGspW3iEvAHLLfwy3q1+ovrODszjQzMj2NLMH0zeMxq6tOAqCBVR36HLV4EXaOyl4SDSMSA5dP+c7pKnHCdgnqxECU4/vOET4VMJD9ao7icjYC3NMgGNkhSGuRXwkEXk2LENF3nSzracmsr41CsJc1qcRpgrbsGl8zSUh1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yzvdw+R1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so1597481e87.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2024 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720201585; x=1720806385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lXaPNo4n6VlsgYPkqoDy23qPeu8kLd9iLzvYoYqnRp4=;
        b=Yzvdw+R1/Y7skfy19LDyF3zJTNwQUgEz9b3n1/l8rNAxSz9k8sg58UQANlBdyPNv78
         ANs34GkpLpTJBTomCqVsfDRQaYmayg9+nLKzoJ+f35iQqyuTnrk3xRY22DZhlz00rU0p
         R1n1VF+8CeJ+nC5TaPxu0JdgexKHVjoNgtk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720201585; x=1720806385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXaPNo4n6VlsgYPkqoDy23qPeu8kLd9iLzvYoYqnRp4=;
        b=K9U7f/ntYnjKI2XCb+MtGoCLRfz2vmrvS5DCyKrI/a/AagBfFrjzYGr87lrIWf4Kqf
         levW3yZsHOkSsJSnmV8tAfFM+WWjrEboiFZS84jis9gJ++XA2rHm+AhfvVglUdBnk9OI
         Adj3xCFj7ygFZpZ0PCIDJSlaEschSeKRBaEIic1R7eogP0GkCGqE7NeLBoWSCdCIfCUs
         5wpezICElwW0ppwFtmTbx2tPg22EeP+75j+qJs5Buiedeyg/TbHuGKLReZKtNmaFBA4P
         s8+3EPI9UHt4lVYYxZiuAdblr9LX1uyy6aoWt2NR6kI1XaJbWSQAT//sOsi945urwPxB
         bOjw==
X-Gm-Message-State: AOJu0Yyfj76G6VSqMvCv+SJarC3hoNqhzAN+dmgSYSoveUtoy+fZAlcL
	s4BBLArXBVRD3BLh6i9HL2YKPbIuGIiXjuUNP4+TqYczuOvmCPOje+M/35T7cvjLMnhib7N3KQe
	rb6pS/L+gN1WLyav2RfrKNtZhhug3XTXTq5gV
X-Google-Smtp-Source: AGHT+IF4QofgfsHGNulPin5j9vSmFwW/MPiICsmjTVGRD95QtbOW39DLmRRaP+P50VJQX1fJdC/WzVH+W1BhoxQVwAM=
X-Received: by 2002:ac2:410d:0:b0:52c:d5b3:1a6a with SMTP id
 2adb3069b0e04-52ea0636fcbmr3778176e87.28.1720201584620; Fri, 05 Jul 2024
 10:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-1-james.quinlan@broadcom.com>
 <20240703180300.42959-5-james.quinlan@broadcom.com> <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
In-Reply-To: <362a728f-5487-47da-b7b9-a9220b27d567@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 5 Jul 2024 13:46:12 -0400
Message-ID: <CA+-6iNynwxcBAbRQ18TfJXwCctf+Ok7DnFyjgv4wNasX9MjV1Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] PCI: brcmstb: Use swinit reset if available
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006b8074061c83a4bb"

--0000000000006b8074061c83a4bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 8:56=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.de=
> wrote:
>
> Hi Jim,
>
> On 7/3/24 21:02, Jim Quinlan wrote:
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
> > index 4104c3668fdb..69926ee5c961 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -266,6 +266,7 @@ struct brcm_pcie {
> >       struct reset_control    *rescal;
> >       struct reset_control    *perst_reset;
> >       struct reset_control    *bridge;
> > +     struct reset_control    *swinit;
> >       int                     num_memc;
> >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >       u32                     hw_rev;
> > @@ -1626,6 +1627,13 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >               dev_err(&pdev->dev, "could not enable clock\n");
> >               return ret;
> >       }
> > +
> > +     pcie->swinit =3D devm_reset_control_get_optional_exclusive(&pdev-=
>dev, "swinit");
> > +     if (IS_ERR(pcie->swinit)) {
> > +             ret =3D dev_err_probe(&pdev->dev, PTR_ERR(pcie->swinit),
> > +                                 "failed to get 'swinit' reset\n");
> > +             goto clk_out;
> > +     }
> >       pcie->rescal =3D devm_reset_control_get_optional_shared(&pdev->de=
v, "rescal");
> >       if (IS_ERR(pcie->rescal)) {
> >               ret =3D PTR_ERR(pcie->rescal);
> > @@ -1637,6 +1645,17 @@ static int brcm_pcie_probe(struct platform_devic=
e *pdev)
> >               goto clk_out;
> >       }
> >
> > +     ret =3D reset_control_assert(pcie->swinit);
> > +     if (ret) {
> > +             dev_err_probe(&pdev->dev, ret, "could not assert reset 's=
winit'\n");
> > +             goto clk_out;
> > +     }
> > +     ret =3D reset_control_deassert(pcie->swinit);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "could not de-assert reset 'swinit' a=
fter asserting\n");
> > +             goto clk_out;
> > +     }
>
> why not call reset_control_reset(pcie->swinit) directly?
Hi Stan,

There is no reset_control_reset() method defined for reset-brcmstb.c.
The only reason I can
think of for this is that it allows the callers of assert/deassert to
insert a delay if desired.

Regards,
Jim Quinlan
Broadcom STB/CM
>
> ~Stan
> > +
> >       ret =3D reset_control_reset(pcie->rescal);
> >       if (ret) {
> >               dev_err(&pdev->dev, "failed to deassert 'rescal'\n");

--0000000000006b8074061c83a4bb
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB2pIZc0u2yOxEN56qUi3caAvuARi7U
XNtoOERiuSpt7zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDUxNzQ2MjVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAJsZmlJZlCW98xC45xtFmRjg9p/kBAjHUuXTT3x6OFdtfYqMc
lWXVlysGd3UQA5/idMfvXZXslWzxjGJk5j4UGHlKVjJJqWAgCUpjOPIofstqATymEjDVmEwmls7a
0h0yhHE67yx5Px69X000tqXLWGzaM2bPV2hanY4vEQftZd8Umdmsw86S0LmqjJSnC6jisiZTGSq0
Fg/3btRdIuKsbPkTeH5WeCMZLs7BwhKjCezUYaVfx6Eq08EV8yplZY/T212uXCFLRs0OMzTrNxGd
V2AxVMUp9R/MBVycAaFaZ48O02tV+X44JFozg8wyl6rNsbDwB2Ijgn3udH6BrTfvqg==
--0000000000006b8074061c83a4bb--

