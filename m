Return-Path: <linux-pci+bounces-11843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310379576CF
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C8B1C23A72
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC1159596;
	Mon, 19 Aug 2024 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aoXRQQRP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C013F9CC
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104203; cv=none; b=QwKkQilgdJ06zo30OavbbNaHbHXjPXlG0XDd5ldt6qP7oT/NbkUjzLuOQTHbzJP7Q7C5wBlFRv0W9rJM+Mki6A/kdv3vuDBJalxBfe5hxutWfFAv6Ty1zTS6NBDqZjxJbuc1OdwiBkEvgUvthGCitU6sYp67ryMjyEKDh1eJ0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104203; c=relaxed/simple;
	bh=HzNhTBZ8dkfSPw9yIR7oylHOk1XBlhH6XXA6Qy+v8bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC/nPXM93PIq59pGVJGvo4PSBlwpTNjk0u7CHzetty9Kwg0tZKV0v2uqZ0dMkVf1elIF8RUDhrUO9aN+T/ERQZ3V+onz0JM4mzPB26SWVGD1rn1/6zThs24f6ME8kbYKPurAnVdt1pRFGJhSEGRgP3Sf8JCC15kvKd/hiY8EZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aoXRQQRP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53310adb4c3so5188284e87.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724104199; x=1724708999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieDAcEd0us6go99IKFKQ0C/OVARjW4SAEnGZCEdF0c0=;
        b=aoXRQQRPnC/Ca9mqmHgYfNHAeDniCnONlU5/pmMHwVv033BKUD3tUmfhZhixwinq1I
         /fNmRmhci4m96cJUnRrYEd9nQA2q71tkyNOxWDxq7kkN6yiUMKgop7p8aVHGgJOlaZTT
         oWa9FyXea2AM3EK0r2Y0TSSVc2U2XNDBwi62A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104199; x=1724708999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieDAcEd0us6go99IKFKQ0C/OVARjW4SAEnGZCEdF0c0=;
        b=bfyjC59+vlOogSYiYn6ns47yhXJXis4tuMdDhFBSXwVMG8K/hFxRDcLIb6Umw1sH4M
         kVXXjQtjY2IjXizyF/DhObuaTknKdCguDMQka2ACaIlLkx0eX791+ZQxwsxbZyyDMWjP
         m7MVSrOdL9oOrfdwDewOQ57/zhZeI2a5c1F9diSI6/02yppy4R04nPH6KSZPFhVhXWbU
         IxAO2s3Tcurxu9b5/N9HxJexR7SoczEtUnp2q3hRR4hlL1AyCAC7xGRe4JyVt1Z3HAsy
         5GKu8e7ZK9YY5wXQP2fbbdb4mJt9CMAOUE8NwF+fYbhRneUWwDTSXDE74TvF+XHf3UbD
         eMKg==
X-Gm-Message-State: AOJu0YyI9jynBP5/eEo6ZPUtbSUyFRMiVca5vsnODodFz+DdYBjDJXpX
	N/6ZBUpyDxCkaso4IHf0mdY+z3pklLWW8ZLNZwvpFJwRKS6p9FcOynrSoSTP9GHAXcJgkP02J/w
	yf4ZcajRr4AJzPsK8jSymPV9nV91t8EouIM4/
X-Google-Smtp-Source: AGHT+IGdJ4ehNuUuHnSHWv+cVb95szforNZt+8SHlUToWrWkjAxtxr8iwZEsnsbodIADOLzpsxu1+cw772rk7am3zmg=
X-Received: by 2002:a05:6512:2394:b0:52c:d7d9:9ba6 with SMTP id
 2adb3069b0e04-5331c6e3977mr7169352e87.50.1724104198934; Mon, 19 Aug 2024
 14:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com> <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com> <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de>
In-Reply-To: <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 19 Aug 2024 17:49:46 -0400
Message-ID: <CA+-6iNykVzd1do=dHDVD3_prJkvfRbA2U-DsLFhSA2S48L_A8A@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
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
	boundary="0000000000005e69100620104a89"

--0000000000005e69100620104a89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:39=E2=80=AFPM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Hi Jim,
>
> On 8/19/24 21:09, Jim Quinlan wrote:
> > On Sat, Aug 17, 2024 at 1:41=E2=80=AFPM Stanimir Varbanov <svarbanov@su=
se.de> wrote:
> >>
> >> Hi Jim,
> >>
> >> On 8/16/24 01:57, Jim Quinlan wrote:
> >>> The 7712 SOC has a bridge reset which can be described in the device =
tree.
> >>> Use it if present.  Otherwise, continue to use the legacy method to r=
eset
> >>> the bridge.
> >>>
> >>> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> >>> ---
> >>>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
> >>>  1 file changed, 19 insertions(+), 5 deletions(-)
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
> >>         resets =3D <&bcm_reset 5>, <&bcm_reset 42>, <&pcie_rescal>;
> >>         reset-names =3D "swinit", "bridge", "rescal";
> >>
> >> pcie1 @ 110000:
> >>         resets =3D <&bcm_reset 7>, <&bcm_reset 43>, <&pcie_rescal>;
> >>         reset-names =3D "swinit", "bridge", "rescal";
> >>
> >> pcie2 @ 120000:
> >>         resets =3D <&bcm_reset 9>, <&bcm_reset 44>, <&pcie_rescal>;
> >>         reset-names =3D "swinit", "bridge", "rescal";
> >>
> >>
> >> I changed "swinit" reset for pcie2 to <&bcm_reset 9> (it is 32 in
> >> downstream rpi kernel) because otherwise I'm unable to enumerate RP1
> >> south bridge at all.
> >>
> >> Any help will be appreciated.
> >
> > Hi Stan,
> > Let me look into this.  Why is one of the controllers turning off --
> > is it not populated with a device?
>
> Yes, I enabled pcie1 but no PCI endpoint devices attached on the
> expansion connector.

Hi Stan,

I looked at our similar STB chip that has a rescal controller and
multiple PCIe controllers and it doesn't have this problem.  Our 7712
doesn't  have this problem either, only because it only has one PCIe
controller.

However, using my 7712 and unbinding the device (invokes
brcm_pcie_remove()) shows me behavior similar to yours (2712).  What I
do is read the rescal registers after the unbind, and they will either
be dead or alive.  If I comment out the
"pcie->bridge_sw_init_set(pcie, 1);" call, the rescal is still dead
after unbind.  However if I comment out that AND the
"clk_disable_unprepare(pcie->clk);" call,  the rescal registers remain
alive after unbind.

Perhaps you don't see the dependence on the PCIe clocks if the 2712
does not give the PCIe node a clock property and instead keeps its
clocks on all of the time.  In that case I would think that your
solution would be fine.

Regards,
Jim Quinlan
Broadcom STB/CM



>
> >
> > As you probably know the 7712 only has access to PCIe1.  But we do
> > have another chip with two controllers and I will try to reproduce
> > your failure and get to the bottom of it.
>
> Thank you for the help.
>
> ~Stan
>
> >
> > Regards,
> > Jim Quinlan
> > Broadcom STB/CM
> >>
> >> ~Stan
> >>
> >> [1]
> >> https://github.com/raspberrypi/linux/blob/rpi-6.11.y/drivers/pci/contr=
oller/pcie-brcmstb.c#L1711

--0000000000005e69100620104a89
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC9Jkuk/xyEkoEUEF4dzEtSjWOIvBrB
Gmpn5yGBicLxTTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTkyMTQ5NTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAEFDJyJkd+fnohE8QMTCQfANwddEf9Pd9MzIysdeHXuhl8z0e
GvsMJi1LPrmv0beop81Wa+D7Vlq8Jl6DKxJVEC/6zGBPKbK9F99SMJJMwa7jnUy+WR3Fz2uDAoLd
MZYyD8z7S4UU2HF8cPcjOYGUzPYyqbXVH4/zSTBgCg3ZQrIWu3mfucX8BukQMZ0Zd/njJI2z/7Ic
Y1KAXPH5IFrAArS8BqSssJQ5EW+1yUDIPEkyOOGdWG/W9LppeaTVBG9m7SthrtDNKmpfCM3cnGyr
mTO+PrCn7JJ56EYo03AvcIZeM+djKj7+fWeid5yXMnY3GLbxE/WK8pK803hHW30r7Q==
--0000000000005e69100620104a89--

