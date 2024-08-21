Return-Path: <linux-pci+bounces-11958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F9959FF4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F689B22BF7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0418E353;
	Wed, 21 Aug 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NJkynuV6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6081607B0
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250791; cv=none; b=T1PMf9RYOWeqThkkKtTpp0ykU0qiL+YJei5MnDDL3LhxaXJQyxWIqCVK/5pvGmdMOiqsnyjHWGXhCx3M7o37OshbUtj1utJUTg+y4dxBoVETzq0ndGdkG4pUdLuWdOAsDCIC1zIcKbiFb3UzorDVLL3rtAxSTAbg8DFvRwJig8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250791; c=relaxed/simple;
	bh=qhZ1KPlSrzfpCzOcKFq5hXaoTCc2yqhFKI2QxlgCRWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9Xgp+a3vnn9icqu1nPz/oms+efaRdGzfcCgD/iSLl5FlmGh1T4ZT7iIBnEUGX/9qv/UQ2EnPulS16H9Y6q433XTp/a7bytCC54U6227uuZ0lrvp9phcwYBaE2wTHWEYpMM87qEvgdfbi74Ha77Z3CZuzmutFgMNAPOfRyCTqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NJkynuV6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533461323cdso1804815e87.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724250788; x=1724855588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5i5gFoI2vYtCuhBq77xQoWmsn7LpduM17tHEzjgn3PQ=;
        b=NJkynuV6Ilz+UFWAFNS+4ZsyGjSn09ct1c+4VxsnFZTLiYFVN+6RRZ+IWB/+20Td/h
         8zA8owNTl2z72G3tERMTYedKj6LcDSXdkhQj7pMfhN3od2ip/mfx7Jssru27Jd/lX4cu
         FGmKaHK6e4DP2ULiBKg1PkYgcl2bsUupBiAOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250788; x=1724855588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i5gFoI2vYtCuhBq77xQoWmsn7LpduM17tHEzjgn3PQ=;
        b=kXrRuN60FSXpT0uqzMCY7dFPHxfRmXHZcU7niKmv0NLVQwSEG+i1oPFd9VlSbWSqUp
         0bkutNLe6KgMb25nc4Dr+ACp1tsp6KfW4cMJpPTG4FMgqfo6UmMSPPQbpATZQ76GEJDS
         WUwnENqXBohzg6dOePsvKM2V50hDIIv2tf1bm8Xni9mkuX0OWHOfKtw4hvMqyKjGB3Lx
         mNpHjjF5HWOoQFx24MEzKbb2q3fwbrNOnlJrSdHHDwnvLmnZsGMQnQCSm1kDbXnoUE1Q
         jptrIaddWq1Xr7H4Wcqn2X1bMNKw6WEf+gF/XwtdZI+ERZ9JFTdT5VZvwjevYgVuaJIw
         GdLA==
X-Forwarded-Encrypted: i=1; AJvYcCWITFZIRUoTcOkbfArx3UGFybbz9xTKJmYSnaiSHuYEGZgUKepPqnLke4DBU2iPLxqPvUMYxeo978A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CrtcO0r9dx7EUMV47SwDXeTFDsxce0rZ3q0jyFYJKsjiGEhr
	kOJiIzM94yyW8r2G5M+7yUSMTRjd3hQn1+ivRWr/sbWs2TvXr3CM658/Ee2pqdyQUzc1EIwHT0g
	NxS8tUb5W3D5shrhkEjkdiYCBXvenVv6Hjl7B
X-Google-Smtp-Source: AGHT+IF4ViaT9SDgYMT6c87n/ULlma8hp8hJkiUY7HZkSV/BLlfVWhsKb0VJg+KIu78dk9fw8Sp9FMgzhE9q5wfhXVc=
X-Received: by 2002:a05:6512:234a:b0:533:4620:ebfb with SMTP id
 2adb3069b0e04-5334855e001mr1710052e87.21.1724250787663; Wed, 21 Aug 2024
 07:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com> <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <2fb74b23-a862-4b1c-b1e1-a3e3abc4571b@broadcom.com> <51eff793-2b72-4e1c-a86e-149f17d08279@suse.de>
In-Reply-To: <51eff793-2b72-4e1c-a86e-149f17d08279@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 21 Aug 2024 10:32:55 -0400
Message-ID: <CA+-6iNw0fa5_FApPX5r_4K69ZMLyUKz4fT+5kDL4FcfTv=OUvA@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, linux-pci@vger.kernel.org, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Cyril Brulebois <kibi@debian.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c22c040620326bea"

--000000000000c22c040620326bea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 7:38=E2=80=AFPM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Hi Florian,
>
> On 8/19/24 22:07, Florian Fainelli wrote:
> > On 8/17/24 10:41, Stanimir Varbanov wrote:
> >> Hi Jim,
> >>
> >> On 8/16/24 01:57, Jim Quinlan wrote:
> >>> The 7712 SOC has a bridge reset which can be described in the device
> >>> tree.
> >>> Use it if present.  Otherwise, continue to use the legacy method to
> >>> reset
> >>> the bridge.
> >>>
> >>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>> ---
> >>>   drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
> >>>   1 file changed, 19 insertions(+), 5 deletions(-)
> >>
> >> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> >>
> >> One problem though on RPi5 (bcm2712).
> >>
> >> With this series applied + my WIP patches for enablement of PCIe on
> >> bcm2712 when enable the pcie1 and pcie2 root ports in dts, I see kerne=
l
> >> boot stuck on pcie2 enumeration and I have to add this [1] to make it
> >> work again.
> >>
> >> Some more info about resets used:
> >>
> >> pcie0 @ 100000:
> >>     resets =3D <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
> >>     reset-names =3D "swinit", "bridge", "rescal";
> >>
> >> pcie1 @ 110000:
> >>     resets =3D <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
> >>     reset-names =3D "swinit", "bridge", "rescal";
> >>
> >> pcie2 @ 120000:
> >>     resets =3D <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
> >>     reset-names =3D "swinit", "bridge", "rescal"; >
> >>
> >> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
> >> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
> >> south bridge at all.
> >
> > The value 9 is unused, so I suppose it does not really hurt to use it,
> > but it is also unlikely to achieve what you desire. 32 is the correct
> > value since pcie2_sw_init is bit 0 within SW_INIT_1 (second bank of
> > resets).
>
> Good to know that 9 is not the proper reset line, thank you.
>
> Unfortunately, I'm unable to make it work with the proper reset line (32)=
.
>
> >
> > The file link you provided appears to be lacking support for the
> > "swinit" reset line, is that intentional? I don't think you can assume
>
> No idea why downstream RPi kernel does not use swinit reset.

I found out accidentally that one does not need this (swinit) to
properly function.
>
> > this will work without.
>
> If I do not populate swinit in PCIe DT node it works i.e. PCI
> enumeration is working and RP1 south-bridge is functional.
>
> ~Stan

--000000000000c22c040620326bea
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBsN9hmCpKPCe+FG31U9YLWdEdVHLWV
HPdIf8pUMxB+NTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MjExNDMzMDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAPccYSj1XdwviRgZnnBIhWtdGGoVKpZtCnfINY7y7kNp2H9pu
uhkVphE4Rha6qBwYSDt+7np1DRI7utwBL8tk/VRL+0T3+TRZk1cWxRqk8lKzPhmp2zf9tluysOr1
hmBuwZKIZpfZzRki8D5F54N8lV5TnpFPrj+KQ2JbnuZWWnr2Uiewu0OyA+aNP2KVwVjw5dz1oEUd
rGjalq6BHHF2dajEmvDd3WjKBw2PnMts952A2nWZg+tv/w9Ij5aWI6krn3aC6zOSsrsYtcn6bFAn
OwoMnfn782VaLJ1TeaO10f7MeclE3Kjd4efS3Dsa1+nPFCo4MrDD7mQLnHRQTxMnIA==
--000000000000c22c040620326bea--

