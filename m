Return-Path: <linux-pci+bounces-14441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04A99C646
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCDD2849CB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9361591F0;
	Mon, 14 Oct 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="faIvUe3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C15154C0F
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899069; cv=none; b=eUk+r4Pnc8jhqUzwkvPR2kEk7kDBSI0/EOWGD6zuPX0pr5njkB64pfWvWzn9SodVuTcZCakDgrT+o0HXJUC94wwMTI+A/7UljlPQhSVllPFIugnsV2FoqgfqkAXwW84hJemOvJYaTG+lsEFUM+ABrpl3w592g8ry0q8Eupa9RB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899069; c=relaxed/simple;
	bh=CtXA4LomrnbA1czHj6Tf2YbOjZrzJKHb+I9oiYm0G8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVW8ecKoXzb3vTWYtLr0WoapOC7uitaEoggZC7yCiHFfN/tu141mpVQJh1ceWpTZVSpStFrUujSPa3biQdQS0/fC8V9q6N05+vGDm+TM1UjJFEFL/PAqkBdSJjHcjIVFdGqqfqjzeqvYopF7aAwC4xV8IiYeM9KSqiSMKn5dc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=faIvUe3P; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a994ecf79e7so643618966b.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728899064; x=1729503864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/rgs9g3BLMGrL1kevamXAXuAcbaE9/MyFdT3pBVTRbM=;
        b=faIvUe3PdmGz8SyRb35sByMsygcbMH1u5/Daa/fxS643y9xaNTbFUsUpbJim5fUR//
         lkwZMBBEJz1shUofjTgwkXxwy7pNaczonwkYLWYrPLFanAY8WI96OLcC3b0C9HQRUteR
         yuoqyZqJN0fbbifR+r49fNaKC4J0pGa1rWI8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899064; x=1729503864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rgs9g3BLMGrL1kevamXAXuAcbaE9/MyFdT3pBVTRbM=;
        b=v1dOxtKhN5Pxsry+lj6+oiOkygEwpv1AJI0v6ek96IytyFM1A+NwiCYHNOeXQl2Tje
         HxcV6ehv5s//6t+NAwi2J2FQ/AL+FdRllE22daQ7NjRExpCIbRXIgIm5nM1Mcm4k/t1j
         Rsx65F2oAybVFpIJ8sSgW/aLvpPTEzZgQ0LCvyU3E0fDSqGPr702MB8FcJjTXMBKG6+r
         hTun3LodpqtbbljgF14J+sSdEZxmqtk4ZsALL5M8q9NcE5Q0GInH+YyuUDKvKvZwkGTJ
         qOQGXlu4yhViBaz7CVcL4/XGWvD6rvclSdFgXYe2XtE2d8HT/jp3tSAtc7X5yoe0gAnx
         CFmw==
X-Gm-Message-State: AOJu0YzAVVMFbf0NoPUJt2I1dE0beaX8oyxGlZLqDS9cd5/iV3ZadDQw
	AFt1ypkqpXOEfAghK6Am8oQWhS2lUn1YCmePIEW5CMfWKYlkr5Zdvkd6XFYwrpPtu5fMN2pDgOA
	vToc8kdJ54peJzJ3btft60VXa4N5ek2HnnX1s
X-Google-Smtp-Source: AGHT+IGmNVCTFBRtszDuViOsU6A92o8syey2CWa//Mny8FL9Ib7R1oF38rssJ2YwNpU2kn8tFadhzwyEfpMAnOfDmHQ=
X-Received: by 2002:a17:907:7e9e:b0:a9a:bed:e564 with SMTP id
 a640c23a62f3a-a9a0bede949mr269814766b.48.1728899063964; Mon, 14 Oct 2024
 02:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com> <20240924160827.000049dd@Huawei.com>
In-Reply-To: <20240924160827.000049dd@Huawei.com>
From: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Date: Mon, 14 Oct 2024 15:14:11 +0530
Message-ID: <CAOHJnDuNT9ZRg1g0sBHw5ytsWTf3USCboh3=q3XdJCEyqyNYKA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] PCI/P2PDMA: Modify p2p_dma_distance to detect P2P links
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
	manivannan.sadhasivam@linaro.org, logang@deltatee.com, 
	linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com, 
	sathya.prakash@broadcom.com, sjeaugey@nvidia.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009691ec06246caed3"

--0000000000009691ec06246caed3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:38=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 19 Sep 2024 01:13:44 -0700
> Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
>
> > Update the p2p_dma_distance() to determine inter-switch P2P links exist=
ing
> > between two switches and use this to calculate the DMA distance between
> > two devices.
> >
> > Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > ---
> >  drivers/pci/p2pdma.c       | 17 ++++++++++++++++-
> >  drivers/pci/pcie/portdrv.c | 34 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/pcie/portdrv.h |  2 ++
> >  3 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> > index 4f47a13cb500..eed3b69e7293 100644
> > --- a/drivers/pci/p2pdma.c
> > +++ b/drivers/pci/p2pdma.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/seq_buf.h>
> >  #include <linux/xarray.h>
> >
> > +extern bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct =
pci_dev *b);
>
> That's nasty.  Include the header so you get a clean stub if
> this support is not built in etc.
>
Will move this to the new header file that will be added.
> > +
>
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index c940b4b242fd..2fe1598fc684 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -104,6 +104,40 @@ static bool pcie_port_is_p2p_supported(struct pci_=
dev *dev)
> >       return false;
> >  }
> >
> > +/**
> > + * pcie_port_is_p2p_link_available: Determine if a P2P link is availab=
le
> > + * between the two upstream bridges. The serial number of the two devi=
ces
> > + * will be compared and if they are same then it is considered that th=
e P2P
> > + * link is available.
> > + *
> > + * Return value: true if inter switch P2P is available, return false o=
therwise.
> > + */
> > +bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev=
 *b)
> > +{
> > +     u64 dsn_a, dsn_b;
> > +
> > +     /*
> > +      * Check if the devices support Inter switch P2P.
> > +      */
>
> Single line comment syntax fine here.  However it's kind
> of obvious, so I'd just drop the comment.
>
>
Will do.

> > +     if (!pcie_port_is_p2p_supported(a) ||
> > +         !pcie_port_is_p2p_supported(b))
>
> Don't wrap this. I think it's under 80 chars anyway.
>
Will do.

> > +             return false;
> > +
> > +     dsn_a =3D pci_get_dsn(a);
> > +     if (!dsn_a)
> > +             return false;
> If we assume that dsn is the only right way to detect this
> (I'm fine with that for now) then we know the supported tests
> above would only pass if this is true. Hence
>
> return pci_get_dsn(a) =3D=3D pci_get_dsn(b);
>
> should be fine.
>
Agreed. Will rework this as suggested and update in the next
patch.

> > +
> > +     dsn_b =3D pci_get_dsn(b);
> > +     if (!dsn_b)
> > +             return false;
> > +
> > +     if (dsn_a =3D=3D dsn_b)
> > +             return true;
>
>         return dsn_a =3D=3D dsn_b;
>
Above changes will take care of this as well.

> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pcie_port_is_p2p_link_available);
> > +
> >  /*
> >   * Traverse list of all PCI bridges and find devices that support Inte=
r switch P2P
> >   * and have the same serial number to create report the BDF over sysfs=
.
>
>

--0000000000009691ec06246caed3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQlwYJKoZIhvcNAQcCoIIQiDCCEIQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3uMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
XzCCBXYwggReoAMCAQICDFr9U6igf1QRzoaH1TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTMyNDhaFw0yNTA5MTAwOTMyNDhaMIGq
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIzAhBgNVBAMTGlNoaXZhc2hhcmFuIFNyaWthbnRlc2h3YXJh
MTYwNAYJKoZIhvcNAQkBFidzaGl2YXNoYXJhbi5zcmlrYW50ZXNod2FyYUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDulAFNbtc+tsB1JubfhUwbq5745iWy0PqA
tUlf8OsSpnKZPtpZ/P9TJL8MrXyDJN5GdKeVAvh1YAvXb2S0i90gW5qWZtFQ4MRMQwXKHvwdVCTj
NBVuju4wvuIk8TWSSWryDIa/KUmQEFgRethHXcwAGKVM2LV19E+RJxjbqcqBXqT20XVYJ+86q3gC
pKeDdMqs49aS4NkFAulUXfKMvwayi1/al6l6H6NjkYI9V+VAhd2Pw5dVGT1UGNnGenU1ASxrICxB
p1may//a5w+WwgjNTKaKkyc6n0c4ds/TIbS/qi/G87n1VXSpcJHiebcJy8WZCbvo6g9j0Ipsx9mZ
ZyjVAgMBAAGjggHoMIIB5DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsG
AQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAuY3JsMDIGA1UdEQQrMCmBJ3NoaXZhc2hhcmFuLnNyaWthbnRlc2h3
YXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOXk95+zAtIGGWGU9q37iyIJKcYMwDQYJKoZIhvcNAQEL
BQADggEBABd5fRmxw/2mYuimst/fZaHYCHDoiYauRKIOm2YcV+s/4xhvXJx0fFit4LzpW8EgTXQv
GQCCaJeSArd/ad3NUOhuQtVB5xOO5cHcCYpdb9gvRPzSZss4mN5OrQsOD6iH0lyg9zIQfhReghMc
Y0C0m8ndFGSil396kqXLgxfPWJ8LChptV9z3iLmGoxJa/gqhi4xu+Ql3ZcQqcP6YItbGOmGjXF/p
uwxVuxQ2ZLaLPPZF5H6t1UPCJRYZXbcjPQHXqFTijI0/1PIUtJy3gUmAsxZe+1n/rCqqCHE4rM+q
Xm1kxB5u/2AMUovVed0IK1+1PFQLP47vY8PfDbSkU4UXH0YxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxa/VOooH9UEc6Gh9UwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIAAtC8RAVzSbDfEuBpt5/foMt6AWwCUB3F/O5UDCqfcyMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAxNDA5NDQyNFowaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQAXTHyUALJSBls/xdehkGEavQr9V5w6Wn15tjGIT/DvtHeu1Y7lo+4ole2ZpN8AFnbOKE7j
n+blMQ0xLENDEivJrcxF5TIKlpAqEW2dk/TtCqdcRw5qdZp6qiyjrNPqHT/8jmYHWwkfcZ1DR7V9
G5su5ESyVs8GOuc1XQFC5fM4x+vQl8wwYcKLJTzQcKBaFH9lef2JGvso3rmpcgl7G2o93GM0bQQA
l03U4WJ5jkvdMOQkEC9q/SShI5NS6OdjU81rRbSYwMXkw86ES1meU/2tSOyY9mlI5X4QHEHc5nlj
o7AtQupjglyyDezLLhWkPmQ5aN9ydnR+5GFtuYA7WQ9s
--0000000000009691ec06246caed3--

