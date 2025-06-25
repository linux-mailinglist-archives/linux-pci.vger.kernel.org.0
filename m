Return-Path: <linux-pci+bounces-30655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98309AE8EF3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4BF3BCE7D
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62D1FC7CA;
	Wed, 25 Jun 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eFm5f0TZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE691F2BB8
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880806; cv=none; b=JSkE1OKYD4aJvi0p5kfJeH1TuPjKsFvIGfH4zNJQnJM/V/xXerqlwCzJYJbqspQ/YcBDIMqr54o/x6DoCHYW9n+4gkq/v9511vs8nOu8XHLg+tRCuMbhojgvDC863q33r1IrPu6tRWOXHlLOwRAnBH8rLsImuHQPtpgLxsvYRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880806; c=relaxed/simple;
	bh=NbzuIuQ+bMRiLhGhFkcMwy5XjTYrmLEwrAzl77CTirI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8QbE0sxcFIExczKtA/anu+6iAyKkPW/D9/LGBXYfHxpyGfKKuAvaAeaDfk4X1tCJ5+57Xpq+N1Vx/6bmYuI05pqBBB/X0t+/OMS3wirXL8dVUM0Xf5J/Qo27Elh93OA+hBuz/9ItMudcTywfKISddsslrVUi8bWPnZT1/Q9Cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eFm5f0TZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b855b468bso2542141fa.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750880802; x=1751485602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVuQO3JCFoxcdr0cW/54+KiXTTTQuNvtjVqW1ptyZpU=;
        b=eFm5f0TZzH3AME7FXWgkT6aQ/r5o1tYh5KmAenMEXsi3zQ/2SZ+drCu3lTXxRgG5zA
         X0dcP+aelqFQrxoNfs725buQS5AzGAA0aI0+BWZLULi2ZAO0dqVDaJBjIs+gwiBkD7Rq
         E2monP/YPL0KYO26I7L/++Y5RWHAnHVE06xbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750880802; x=1751485602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVuQO3JCFoxcdr0cW/54+KiXTTTQuNvtjVqW1ptyZpU=;
        b=FH59J9EIrtTLekf84NwNisTt4gwy0Wn2WeJIEgtW2VPWS4ofafrFG8G+m+5c0/K+z3
         DuxkaeKikQpfJe99lMa05kt5k55PO3g773BFubCQuQweu2WmizV9d10wjSg/iQQp6gHy
         lTXm48dhQo16E+1q7CRtr0C4C9XrGhSxelJxAHnnDMbh0vSrRJSXPQweo3IEiCGYRqt3
         qaSw7vgJriHSdSK9ookhl14AeHiDiWqkoeRL5zt8DbpqRu2FIJhzjUhVmA74/tqF/D00
         R0+fnSAg74d9qJCcTF0qhHRwiMTL1o7jVO7HzZcoU+RNg1KCsE5al/xsA9eS5GV0dTqB
         T0Hw==
X-Gm-Message-State: AOJu0YxpIKh+Jue7m8rneAVrThG9nk+xkL875PbJS5iQhqLJWGAiRqHJ
	LH71DdOCMbKu8Ed/DyTrjox6BD6wyTEVit9kQhBPgakfutzIUd3JzsB2k3oBDXD+3k+VQAz1HnB
	Huimq3LGb3KvAlc36AkZxCIfh/ieaXSS8M+QGSp0t
X-Gm-Gg: ASbGnctVFzDx22JgRzhVfkc31zQFSrm81lOXajQyqFXzoj33o7hlsHWDbTAqTKr8DVj
	szl1NE2JLOd/YEyHJewUpwZqiOvwBRTm/C0jVeuNa+PTYvtBJtCb/O23e2ZcLZuGmGKi5gM68SB
	rh5AMumDuaDHE+hAeudyylPACVSfQx3YTtq4nVK9JklGty2PzN5N58jWg=
X-Google-Smtp-Source: AGHT+IEX/Wv8zky1sPyq3PYfiTdoTrNF0L+2QZwfiLjlF/x42QYkSdH1t/Zh97HknFzHkWgFfAFlMlexs8DY4OBLvzw=
X-Received: by 2002:a05:651c:e10:b0:32a:7979:47c3 with SMTP id
 38308e7fff4ca-32cc645ef38mr7365331fa.11.1750880802455; Wed, 25 Jun 2025
 12:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530224035.41886-3-james.quinlan@broadcom.com> <20250624220101.GA1532842@bhelgaas>
In-Reply-To: <20250624220101.GA1532842@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 25 Jun 2025 15:46:28 -0400
X-Gm-Features: Ac12FXw88vFzk7hZ-yAaLhXL6W7paLjDU_tLqtbd5x9C7ir15h0P7lj-R1RryMI
Message-ID: <CA+-6iNw8ZuJbWu3E-BYYr-xwVoHwH2jf_sQ7NrubWHR9xEr+Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004d7cbc06386ab400"

--0000000000004d7cbc06386ab400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 6:01=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, May 30, 2025 at 06:40:33PM -0400, Jim Quinlan wrote:
> > By default, we use automatic HW negotiation to ascertain the number of
> > lanes of the PCIe connection.  If the "num-lanes" DT property is presen=
t,
> > assume that the chip's built-in capability information is incorrect or
> > undesired, and use the specified value instead.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index e19628e13898..79fc6d00b7bc 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -46,6 +46,7 @@
> >  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK   0xffffff
> >
> >  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY                    0x04dc
> > +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK       0=
x1f0
> >  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK 0xc00
> >
> >  #define PCIE_RC_CFG_PRIV1_ROOT_CAP                   0x4f8
>    #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK      0xf8
>
> If you squint, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY looks a little like
> these standard PCIe things:
>
>   #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
>   #define  PCI_EXP_LNKCAP_MLW     0x000003f0 /* Maximum Link Width */
>   #define  PCI_EXP_LNKCAP_ASPMS   0x00000c00 /* ASPM Support */
>
>   #define PCI_EXP_DEVCTL2         0x28    /* Device Control 2 */
>
> So I was hoping we had an opportunity to use PCI_EXP_LNKCAP_MLW and
> PCI_EXP_LNKCAP_ASPMS instead of
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK and
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK.
>
> But I guess PCIE_RC_CFG_PRIV1_LINK_CAPABILITY is probably not actually
> PCI_EXP_LNKCAP, because PCI_EXP_LNKCAP being 0x0c into a PCIe
> Capability would mean the cap started at 0x04d0, and
> PCIE_RC_CFG_PRIV1_ROOT_CAP would be at offset 0x28
> (0x04d0 + 0x28 =3D=3D 0x04f8).
>
> But offset 0x28 in a PCIe Capability would be PCI_EXP_DEVCTL2, not
> PCIE_RC_CFG_PRIV1_ROOT_CAP, and I can't squint hard enough to see
> anything related to L1SS anywhere in the PCIe Capability.
>
> So never mind ;)
Hi Bjorn,

Not only are the "priv" register offsets slightly different, the
values of the masks may be different as well.  For example,
PCI_EXP_LNKCAP_MLW  is 0x3f0 while our "priv" version is 0x1f0, as
something unrelated occupies the missing "priv" bit.

Cheers,
Jim Quinlan
Broadcom STB/CM


>
> Bjorn

--0000000000004d7cbc06386ab400
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
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICYDCC
AlwCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCgNF0e++Frypsja2iK1W2fwRnj1wCj
M9JROjSNXRa6ITAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA2
MjUxOTQ2NDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQB6TABY503aqyFPLpKASVV90KFna1+pw7FoY+aF2mrW76rHjnRh+dL5E1eJyUSvYfh6
Yy+j0kbaIj/0ijFEI5g7V2uCOzL5BgiyU4Ex93fET3Yc4E78l0bLRVhSACkladwyBbkmBcOto2xv
K/glrvlX7gDo1m/92DmvLM7f69yju6NllWC16uncXiPyu734vGGHhsoIgi6T9ZEHrfuIwv9zASNy
358gomVjho5cL5YY5vZ40JKM9jr9p7pJsVF9T81ZD34FVzl1AnoJ4JK7T8K3FyYi9nAx+WrG69K8
bKt2lEtVFUi1LnadGlN3Zy0gj1LCWCnwx9ilcpodkTyFkzwy
--0000000000004d7cbc06386ab400--

