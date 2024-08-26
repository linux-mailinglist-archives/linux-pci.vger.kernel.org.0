Return-Path: <linux-pci+bounces-12204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6695F3AD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153ECB20D1B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5814386B;
	Mon, 26 Aug 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QU0/YvMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4F1E864
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681854; cv=none; b=fph1K8oUOhF0hQCeE4GuczEghg5bufPLVcQ2fk/Jl2ED0YDuNM5mGExU736Hb0GwwMFe2FGzQ3RW5/98QIOau1NM2a0N3r+whm6O2qhDlFgdUO+KC81d0Bj0Uf4z9n8tL3dHqZChsPPruGchl3Bt03Fj6yi/C7/zM+gilbQHSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681854; c=relaxed/simple;
	bh=Tp5dc3Fei0faip5BHe95c07OdPjQJsnGolBuWv9J9jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5lr0hGOUAzLI1qbyGmFF91ke4Qf30LNpoti0SUKV0qUu00UA0IDKmX9ZZ+XZ5napkbZzzZvUeFPO011F2QS1p02vRtcE+EhZUhep4rL/NOkx4FMYnzDU8NI5NIGGNnq1jApPLNySoXV6OzSsKduRHUzM6PS00hF2IMm44vtz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QU0/YvMA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533488ffaf7so5905928e87.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724681850; x=1725286650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Diuad8T0BWfChpIUb/oh4AIHTNFCJ6sXSbqNIL4aS0o=;
        b=QU0/YvMAXdalcVbmWGKlB7rV/f3AmKwSSyH9a2lw4DDo19313v14azQwHnssT44mGA
         +jIOdCTBV36PDGlIFte/5h2ZK8MWolUNcU73LlIdA/UI8XJQqJWyu8t/CgrVsYvbnd0L
         /StWGoNNYLMw7vwicnARWy3PVX+Ue4ORGGl8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681850; x=1725286650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Diuad8T0BWfChpIUb/oh4AIHTNFCJ6sXSbqNIL4aS0o=;
        b=o34vKdBpEh5d3u3KuAMElbEKemHg6otqUNd7qlNu2EimyvXxlrSfT6DlSvye+qKwNm
         LdOalom+m5XOTVSXiY4pJQ+8qj4tUihss2Cb+pxUvLRjhs1WTWKAZwHuxVn5YFj7uDU5
         0ZK778tppxPhvdl5/9qG9gKhLb0fo9xyjul8U9Z+6Mvum5z8adpAn1wcfBLAufbYrVls
         hdqUvNMiQLktYPWGcEZDfHwnT785trBlLwr5T3W4GWU/t/sdsMrA4pFcVmRXH3btth0T
         9d9tBOiAEyBjpZVYprlpdvVVtn1ZbsaSOQ6bnVqO75kEb977QKzLq+KJSX4viawF/0qD
         kspA==
X-Gm-Message-State: AOJu0Yz1QDDIp6amkPoUH6KfIeadR7t9X4l6jnQJFcqGw0tz84wOstU/
	Y9msx4LNz7qyn8M170xplnS1NXIPrlrspA+2KLFAU+nv63Ud3NWSQtElECeY9pMrOTmQSHQFjbL
	x2v70zZLFqJ/hhhWuuOrtiquYl+MyTtBQOgp+
X-Google-Smtp-Source: AGHT+IGDnXq8lbBoLbszy+XWcdYKrSNmEQewgOdRcJFMVjUHHmBuh5rvOrWGuudGVSLUCudFPPB2kj5zgkVWjn/SQOQ=
X-Received: by 2002:a05:6512:39d5:b0:52c:90b6:170f with SMTP id
 2adb3069b0e04-53438783a93mr8763056e87.29.1724681849594; Mon, 26 Aug 2024
 07:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com> <1a6d6972-f2db-4d44-b79c-811ba44368f0@suse.de>
 <CA+-6iNxFotwXW4Cc31daT+KwE_LEdAR=pcpsg_3Ng0ep1vYLBA@mail.gmail.com>
 <76b528f8-88e2-4954-94cf-7e0933b4ad03@suse.de> <CA+-6iNykVzd1do=dHDVD3_prJkvfRbA2U-DsLFhSA2S48L_A8A@mail.gmail.com>
 <87b38984-0a54-4773-ba20-3445d9c9c149@suse.de> <CA+-6iNwJZ+OfYaCBBx04-hO1FmpDE36uJWd1jYvaVs_o4iwWqA@mail.gmail.com>
 <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de>
In-Reply-To: <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 26 Aug 2024 10:17:17 -0400
Message-ID: <CA+-6iNy7souF-BZHV1sBk2nx04LwshB=6amnOixfPPza96RmWw@mail.gmail.com>
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
	boundary="0000000000000f2fe1062096c9cd"

--0000000000000f2fe1062096c9cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 6:43=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Hi Jim,
>
> <cut>
>
> >
> > Hi Stan,
> >
> > Most of the clocks on the STB chips come up active so one does not
> > have to turn them on and off to have the device function.  It helps
> > power savings to do this although I'm not sure it is significant.
> >>
> >>>
> >>> Perhaps you don't see the dependence on the PCIe clocks if the 2712
> >>> does not give the PCIe node a clock property and instead keeps its
> >>> clocks on all of the time.  In that case I would think that your
> >>> solution would be fine.
> >>
> >> What you mean by my solution? The one where avoiding assert of
> >> bridge_reset at link [1] bellow?
> >
> > Yes.
> >>
> >> If so, I still cannot understand the relation between bridge_reset and
> >> rescal as the comment mentions:
> >>
> >> "Shutting down this bridge on pcie1 means accesses to rescal block wil=
l
> >> hang the chip if another RC wants to assert/deassert rescal".
> >
> > I was just describing my observations; this should not be happening.
> > I would say it is a HW bug for the 2712.  I can file a bug against the
> > 2712 but that will not help us right now.  From what I was told by HW,
> > asserting the PCIe1 bridge reset does not affect the rescal settings,
> > but it does freeze access to the rescal registers, and that is game
> > over for the other PCIe controllers accessing the rescal registers.
>
> Good findings, thank you.
>
> The problem comes from this snippet from brcm_pcie_probe() :
>
>         ret =3D pci_host_probe(bridge);
>         if (!ret && !brcm_pcie_link_up(pcie))
>                 ret =3D -ENODEV;
>
>         if (ret) {
>                 brcm_pcie_remove(pdev);
>                 return ret;
>         }
>
> Even when pci_host_probe() is successful the .probe will fail if there
> are no endpoint devices on this root port bus. This is the case when
> probing pcie1 port which is the one with external connector. Cause the
> probe is failing we call reset_control_rearm(rescal) from
> brcm_pcie_remove(), after that during .probe of pcie2 (the root port
> where RP1 south-bridge is attached) reset_control_reset(rescal) will
> issue rescal reset thus rescal-reset driver will stuck on read/write
> registers.
>
> I think we have to drop this link-up check and allow the probe to finish
> successfully. Even that there no PCI devices attached to bus we want the
> root port to be visible by lspci tool.

Hi Stan,

What is gained by having only the root bridge shown by lspci?  We do
not support PCIe hotplug so why have lspci reporting a bridge with no
devices?

The reason we do this is to save power -- when we see no device we
turn off the clocks, put things in reset (e.g. bridge), and turn off
the regulators.  We have SoCs with multiple controllers  and they
cannot afford to be supplying power to controllers with non-populated
sockets; these may be products that are trying to conform to mandated
energy-mode specifications.

 This will solve partially the
> issue with accessing rescal reset-controller registers after asserting
> bridge_reset. The other part of the problem will be solved by remove the
> invocation of reset_control_rearm(rescal) from __brcm_pcie_remove().
> That way only the first probed root port will issue rescal reset and
> every next probe will not try to reset rescal because we do not call
> _rearm(rescal).

In theory I agree with the above -- it should probably not be invoking
the rearm() when it is being deactivated.  However, I am concerned
about a controller(s) going into s2 suspend/resume or unbind/bind.

Let me run some tests.

Regards,
Jim Quinlan
Broadcom STB/CM


>
> What do you think?
>
> ~Stan

--0000000000000f2fe1062096c9cd
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBIqs1Lt1/cMgZ5tFzGwRAVvlKuY4g7
6oZq8dJ1LouIZDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MjYxNDE3MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAZwW1dkQMr6QuKCowgaSN1GJ3fXVVSFoBa36SoI4U5PvFP4Gg
bH0SykJVg58jjTfof0f6wp6D15HMRUvMcysvgxXrjoTahTA8R7Es2TePlOkJvKYkQgnYcdHdZgYQ
WMM3DZnz5RhzbJZndQyrq7GW4x4J1TFXgOUT4prrYafUtz/vg9RcDe85hBu+JtfiWGWTJ3ES0nVH
Ug5x2qOPNG3paMjxAXC3JJSf+CznAy2j3pke8rNJzh3z60jpW7myQFqY28wbu2DrXoT041dPrR1r
4NIFRD+Ft0axq0WRqZpxe7x/mGdRMzTUYA9zMh3N7ojODqQUnmwLQtGiIcm1TgqjJQ==
--0000000000000f2fe1062096c9cd--

