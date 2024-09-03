Return-Path: <linux-pci+bounces-12665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218B96A074
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582FDB2519E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252EA13C906;
	Tue,  3 Sep 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I9UMXtUq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A769D31
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373602; cv=none; b=GL4PcpafTLmtjQUKQb73elEeoLOKpepHI17jGMDXf+N7GufY/XhpDYwCbzYAyDz8QY7aF3nwc9geDmdQO2s23q2OgbnmpkcZo0MSS8D731tQcTsy7Z2V84ATC0YmVUamuVLlXxUrph80NxaUAAy3pcV9/LPfQz/CG0kjE22ox3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373602; c=relaxed/simple;
	bh=FMYlpl0ws9wVludyr5l0btYcuTh1pw13zO3+YC/GyXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDDnztFraBXiE+NyNZoqWJ9o+1H3mvlqri9CE/K85GruhUln2Bf2ohht+h3y2TuzaNmvuMbXrWLTw4ifBd0SzOKGAzc3vk7fbVlvEwmK6EDR6MMgfcWSY885UXBYCSs5Yj7GLdfAYSH3AHRxBhPfbkvaXPLlB/h+UxrSLp/dP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I9UMXtUq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so61796541fa.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2024 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725373598; x=1725978398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPsWa9VOzVCgirJOwuUr+2ivvDDszmP6GcZp9IJP6bw=;
        b=I9UMXtUqcyJP4/A2Pai2mXurbLLgpneWEni6EBYAmFkAeFJVP6O8rWRpFuF+7Kv/4m
         Gol6Xg3plWZXb90vU8eFeg+Nxby1gD9aBve+y9vlduq8FnbJauW92wtMejBdNk53h6F0
         h9fr/A0DaYIxhisEIpDEfVb81EAIu6U9E9C6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373598; x=1725978398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPsWa9VOzVCgirJOwuUr+2ivvDDszmP6GcZp9IJP6bw=;
        b=sHYMaFSqE9OtMf+YuJokM/vcoLdlAJ2IbBl9hXZlIS5bDXTUL7foMzSpcbR1a7Nse/
         UXZEKmMQvLx1R/mQvTYg19c1ojMlZC9kQto2qO94+Lw+PtWl2kWdPnvYZ0HWAtyHyuHW
         KN+FxtsxEXtCoTajXhZfPJ4IMwu7Fi6+yUS7aClLJ3TWlI5FNs2bI/gJV6X4zIK5s1Ll
         DOW9izPz/ia7BIkHa9O5LPdzJo9fWieW1J6AQxIwvPByITUwPciJjk92YCf1Y5pqBVBb
         WA275pJOIUSAxAsera1dyEDFf5Gm0DWIFuG4+SjAXGPE82wVJU0WxJgdJx9jXP4UOnm0
         TPIA==
X-Gm-Message-State: AOJu0YzKiWLAjxuRlf5Fjj/2waJHKLoYb3iqup1cyNJjratlHUjD8lp3
	nkZafVETNo/Lq1qLOeyMy+PTmVNsow4iS6e4BeG1MbRMeq4wC2GLCJ24iA/Lkxba8oN0zAQ8umP
	t3vwcojmfmjDx3/ZXSS9mkqUqWcKrlbrKc3KQ
X-Google-Smtp-Source: AGHT+IFWHIrQ2aIrLwGxyf+RqLMdXhsgSsJGAMAAVKOAOAj0LtTktf/D92/Wll7afKJLsYR1ftwbJuT6fgTM0BIkOm8=
X-Received: by 2002:a2e:be09:0:b0:2f4:f255:4fc1 with SMTP id
 38308e7fff4ca-2f636a0c7f2mr56347951fa.11.1725373597820; Tue, 03 Sep 2024
 07:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815225731.40276-6-james.quinlan@broadcom.com> <20240902191827.GA224376@bhelgaas>
In-Reply-To: <20240902191827.GA224376@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 3 Sep 2024 10:26:24 -0400
Message-ID: <CA+-6iNywkWq=H1WRTWaVbPwa9aBTZxyhwfsWqX5eYh22L7P1ag@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000078935a062137d8d1"

--00000000000078935a062137d8d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Aug 15, 2024 at 06:57:18PM -0400, Jim Quinlan wrote:
> > The 7712 SOC has a bridge reset which can be described in the device tr=
ee.
> > Use it if present.  Otherwise, continue to use the legacy method to res=
et
> > the bridge.
>
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
>
> This pattern looks goofy:
>
>   reset_control_assert(pcie->bridge_reset);
>   if (!pcie->bridge_reset) {
>     ...
>
> If we're going to test pcie->bridge_reset at all, it should be first
> so it's obvious what's going on and the reader doesn't have to go
> verify that reset_control_assert() ignores and returns success for a
> NULL pointer:
>
>   if (pcie->bridge_reset) {
>     if (val)
>       reset_control_assert(pcie->bridge_reset);
>     else
>       reset_control_deassert(pcie->bridge_reset);
>
>     return;
>   }
>
>   u32 tmp, mask =3D  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>   ...
>
Will do.

Jim Quinlan
Broadcom STB/CM

> Krzysztof, can you amend this on the branch?
>
> It will also make the eventual return checking and error message
> simpler because we won't have to initialize "ret" first, and we can
> "return 0" directly for the legacy case.
>
> Bjorn

--00000000000078935a062137d8d1
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCdG0CREno6Irm7ymgcrzXeAHrsr/4F
Bvtqd9EQ/4hP7DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA5
MDMxNDI2MzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAjj52JPbEsA3Q3mSY0qI5+z2Dm2ZdzhXjHASwB1tmned06UuE
VBr8Q4lo+X0K96YLoa52S0swb3exgd3deFR0hHRD3btdhYt3CXSru9uhsWQ8BpBiPF0SI0sBGbfy
hec7fnTamj+0qnOijLIafy0CwyGFj4JciiuT+l93MdEpPM8R6v4o2eSNPaoZaJYWQZ/QWD7SLGlf
zK3OIAAI1C75gOuHAzUTjiaSRoq1H+dB8Wbqg/feJHx7k5JiimfQxaMxOd1wa4GbsmNiKp8uf1zI
YvdGqXZsMVD5FNe901vk7anYI1Fnnz7X9IWJsOdxqSATR1LloeLxMLCw74AplVJoVw==
--00000000000078935a062137d8d1--

