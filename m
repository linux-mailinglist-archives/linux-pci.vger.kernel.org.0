Return-Path: <linux-pci+bounces-9851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0362E928CE8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 19:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8104A1F2219A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A116D9DA;
	Fri,  5 Jul 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BtBPuJpV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244016D9CF
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199276; cv=none; b=X00jYrdRmYi39QROOG/WePtJ6es07UImUy5hvpfhbpGSi2ZETstBHk3lJwkLOLuC7DetjwWLKyB8fQdvkCNcUV4bbwkXMyLuUZsoher9K2sGxqdZE+Cm+cxz9Wr1bBO4deCIAfjktxD34EVrGLKKfwqVhVpAdZ3nkFXPSPsipVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199276; c=relaxed/simple;
	bh=YOk8DFhBKi2HylkyQzuZ/IkOOZL9OpaAqbGcEt77hnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pg3OITiZfnLOXxrNZZQS2bMM4seBssabIiQDu7n53Ie3kOttLoHcWBNKSZDTbt0RHGUL9u6BH0jvXYPUJhXdwaVbT6ORV9rLgxpnzYT27WSxfTaCvBql9bgK0/hq4EYl22+BnJCDjr2dWsizAZuwzU9XcTf1BhtHqiuOw8fZwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BtBPuJpV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e976208f8so2094734e87.2
        for <linux-pci@vger.kernel.org>; Fri, 05 Jul 2024 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720199273; x=1720804073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaSNIxjk/I/j/xuzTjnlojSV/QvYqC2sV4DQUk3Q+pU=;
        b=BtBPuJpVxv+e4Hl0uAFeVDka1h5mNs2tNa6mwkzuVdsb23TvyIaS1ykYtL8LqkPbxL
         6YGUD+WNxvtDNzN6ORIO/2VezwB0cxC/8oGiWkNAB0oO9dm63FHWEJp5kQlDx0QJYZ6y
         QGIPp+ot3cdwdZ6v+SuzqzjjLgiuyQI0EzkVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199273; x=1720804073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaSNIxjk/I/j/xuzTjnlojSV/QvYqC2sV4DQUk3Q+pU=;
        b=qPWiC3tFIdGgfYIt5cyKSpngOWQ0IFNRyKSa48i18UV0QaitQaPMHFQcyB+rHiBWKk
         XT0jX11Qa1ECmwQZgE6Y3UbaICWlgIC47GwJIC0HnqPo4FdVWkHOeysFZI5vmRVWmNFv
         cLDEjbHVWv719MjT8nPoG/BD3hRKAecC+khZD5nzf/qTevjZZC/FoivCfW+gx6Sq7WBz
         H78ll6ikdxO+0qmlf4pDZMtatO2TBfMByPGNPpjWM0VsonCSRylhfxkl853FM+/lzAWu
         Ot1PggoCJ536Ori4ePELEvDnfQJXy2Diq6mXvEZd9/TkrANHOKtgRatxVRlyi8+T69yc
         8zmA==
X-Gm-Message-State: AOJu0YwDBgTdbjjOOUUjF8YJsVyQ9s5pBTVKaWxdQ4GdB4SXE6Ig0b6G
	p8r6kt1SgjoxxjzipCSqOvs3rU8tT6cLtV/tpn6hwzuNk3AGDQswcCkedCRo97bvhykMYAYt1ME
	U9a2BTm/U5V/RyRQVsZEcUFk55DPUiykhWP3l
X-Google-Smtp-Source: AGHT+IF+OtYyzaJVNyWjBlvrudwLW0SnTgGwplnwObfZ2pJURupaQ8qQ9cO6QkF/vSQbCQWw0HW5tzFSu4Oat16EF4o=
X-Received: by 2002:a19:c518:0:b0:52c:84a2:d848 with SMTP id
 2adb3069b0e04-52ea06d15aemr3829349e87.65.1720199272853; Fri, 05 Jul 2024
 10:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703180300.42959-3-james.quinlan@broadcom.com>
 <54dc90df-fc31-457d-a18d-b2070b055d60@web.de> <CA+-6iNxqZRdknUVammcgDC2HUmacZSAkdJNVLba32Ujgsa9vpg@mail.gmail.com>
 <ba9f5ed8-d548-4ec4-982c-b3f679270c64@web.de>
In-Reply-To: <ba9f5ed8-d548-4ec4-982c-b3f679270c64@web.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 5 Jul 2024 13:07:39 -0400
Message-ID: <CA+-6iNwCoMbfz3FEg_FVi1YVzzrVhxdJ3fZSjszOeayDQ9-BAw@mail.gmail.com>
Subject: Re: [v2 02/12] PCI: brcmstb: Use "clk_out" error path label
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Cyril Brulebois <kibi@debian.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Stanimir Varbanov <svarbanov@suse.de>, Jim Quinlan <jim2101024@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a02031061c831a52"

--000000000000a02031061c831a52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:45=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >     > [-- Attachment #1: Type: text/plain, Size: 1685 bytes --]
> >
> >     Can improved adjustments be provided as regular diff data
> >     (without an extra attachment)?
> >
> >
> > I'm not sure what you are referring to... I see no attachment in the co=
py of this email I received, =E2=80=A6
>
> Do I get inappropriate impressions here from published data representatio=
ns?
> https://lore.kernel.org/linux-kernel/20240703180300.42959-3-james.quinlan=
@broadcom.com/

Hi Markus,

Okay, I do see that :-).
It might be something my company is doing to the emails.  At one point
we had to stop sending submissions from our company email because it
would tag each email with
a long legal statement.  I will check with my manager (Florian
Fainaelli) to see if I can do something
about this.

Thanks for the heads-up,
Jim Quinlan
Broadcom STB/CM
>
>
>
> Regards,
> Markus

--000000000000a02031061c831a52
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDWk1xwggZ/FfhW9M9D173NkR5EigoF
k5QaTMWd14sxTTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MDUxNzA3NTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAn/INoDzbLA88KWjM0cmBHZNgh0QkjKoeWPD1oJDtJeDyrUwx
vYrQKhzogRtEDML/+BAxGyjpZt6sFxaNIUlcEhWrg3SgEFMRjSBw406IowdcIcCVsk+7053BTlhy
RXdQ3MGxDm0qBhlz8mvwp8zXkR2zd98rpilhf8+wq5TgV1v5g4RQaNedVAsDQossRek8Xq9uDRh3
x9lJhplt6IZ/099ddGuNYUzd6Y0KV1NOsXdPeSRlWY+u8nGjpgQ2iPbB9rK1RR7AKjv8TUrp12cm
Jpjn8bnrcb5eKfmghqJzUXoYZbb5xs4VrYOGJbXFhTw8xBf3K1yjP3PPmknl6h75ZA==
--000000000000a02031061c831a52--

