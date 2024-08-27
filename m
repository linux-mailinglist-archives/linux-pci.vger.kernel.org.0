Return-Path: <linux-pci+bounces-12290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2AD960FCE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 17:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7871C235EE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ED21C6894;
	Tue, 27 Aug 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KxOlWNHQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811B1C57A9
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770916; cv=none; b=t1JGdFGe2V8Kcqwm3PioNXRl6LSEBXxVpoKZPiCkPiB7E3QUfBHX5HAqNdGDy5tec5CGO6Dd7/aP+9lV8oG0S7ffiQuvgYH36JoXiinw1jI6f8jfii55q/nItriYLkJN/kjnoSoDKCZHbMFqBtOKXEWfzc+apPOLSUvVdEphd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770916; c=relaxed/simple;
	bh=yeybgHOlMEhNt5He/19hBRTY4431BMIPdxp1Q749q08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDK/lZg4f1404eelHSDVFPblIirBVZn1Ycy6p4CC/oCQn201oET9FwM3jGHKjawfm9DZmcQgZfL50/YXzfegonVZrQkxEuJeGeifmoB6bFHNaOF3xhm830ffArl9Rovhhtfo0ZUmwxMXqrn6kPBLX/H4IJ+kWMUkqWWQIiNqBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KxOlWNHQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4207834e87.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724770913; x=1725375713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMXbE2M5Od5WZwhRJRjRO7w0rWSP8gjHxAUOqL6nJGk=;
        b=KxOlWNHQkXvoFphRXJBigMSCGt6dT+umvTtdsCCNLJpo7Nstu+gnhqAVzgnixfJ7Ua
         QPWY70UkXFYGwbbfm4xQwqUeaUq4derRAStes/W/59ZfKJQ2L3sMUixZYfr8YJMgJrA7
         pohg6Gls4cb5KHu24Aku0RSxyNjoal2q3ekp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724770913; x=1725375713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMXbE2M5Od5WZwhRJRjRO7w0rWSP8gjHxAUOqL6nJGk=;
        b=cZa5vFdQsBrtv5FfZnQo/Wb5bxhcmko6LlsUhKA6KbzIchTE+UGLo8k/TJloMZ6nEg
         as9f6ZXeoQHGVJp/s+gkjz5iu1mQFsyLZMsI3yPkspssriYeAgTlTDIVKIZLJqUu8GdU
         7dTGERxkwxiV2NpV1yaOjt5upkArubbFwDomVhft0XnbkUhq4U6ye9xVWshZGjYcA6TI
         dbM2RRfj35rkXe8a25w9HL5U9Is9h0ci2h4u0/Gv8FWjSdEqfJ4+DA1TOs0fOWgS1PDF
         nXTcEmuYPjYo3oBRbmGUKyHybL7FNVU1t3FpquuppsG/RJbX7bZMaWhqB+2K2Vibz7VE
         PO0Q==
X-Gm-Message-State: AOJu0YwQECdqMIOvOgDkHwP2Ut0RuGJuGtYhXMvlZG4anxL96yPSaU/o
	duu+yVenK1EOebJ03rNBOg/Ehhbzum83rZ7JENd25W+ITjyuQ+hZShYVUdektVdaLrkJREJJI0Z
	8uxJxOfgY+lBZyLJCUFLcXRmq0ClKeuhbm7b6
X-Google-Smtp-Source: AGHT+IFYvEIBSbU/E9nH7ayxEGCNmkU+Chi28AndaI7JTEQDfzKJ499VWKq3Libwxraw4EmqszPC5e1s0l2UV3yQzAM=
X-Received: by 2002:a05:6512:1111:b0:52c:8abe:51fb with SMTP id
 2adb3069b0e04-5343875582emr8755403e87.10.1724770910565; Tue, 27 Aug 2024
 08:01:50 -0700 (PDT)
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
 <3bb5c6db-11d9-4e65-a581-1a7f6945450a@suse.de> <CA+-6iNy7souF-BZHV1sBk2nx04LwshB=6amnOixfPPza96RmWw@mail.gmail.com>
 <9b7cff3f-7d22-4bb5-a56e-11d93bd11456@suse.de>
In-Reply-To: <9b7cff3f-7d22-4bb5-a56e-11d93bd11456@suse.de>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 27 Aug 2024 11:01:37 -0400
Message-ID: <CA+-6iNwAfur96=kftP_pqZDGUoGkb3_rjKnxiGJmL4xxmzTNaA@mail.gmail.com>
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
	boundary="0000000000009cfa0f0620ab85eb"

--0000000000009cfa0f0620ab85eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 8:28=E2=80=AFAM Stanimir Varbanov <svarbanov@suse.d=
e> wrote:
>
> Hi Jim,
>
> On 8/26/24 17:17, Jim Quinlan wrote:
> > On Mon, Aug 26, 2024 at 6:43=E2=80=AFAM Stanimir Varbanov <svarbanov@su=
se.de> wrote:
> >>
> >> Hi Jim,
> >>
> >> <cut>
> >>
> >>>
> >>> Hi Stan,
> >>>
> >>> Most of the clocks on the STB chips come up active so one does not
> >>> have to turn them on and off to have the device function.  It helps
> >>> power savings to do this although I'm not sure it is significant.
> >>>>
> >>>>>
> >>>>> Perhaps you don't see the dependence on the PCIe clocks if the 2712
> >>>>> does not give the PCIe node a clock property and instead keeps its
> >>>>> clocks on all of the time.  In that case I would think that your
> >>>>> solution would be fine.
> >>>>
> >>>> What you mean by my solution? The one where avoiding assert of
> >>>> bridge_reset at link [1] bellow?
> >>>
> >>> Yes.
> >>>>
> >>>> If so, I still cannot understand the relation between bridge_reset a=
nd
> >>>> rescal as the comment mentions:
> >>>>
> >>>> "Shutting down this bridge on pcie1 means accesses to rescal block w=
ill
> >>>> hang the chip if another RC wants to assert/deassert rescal".
> >>>
> >>> I was just describing my observations; this should not be happening.
> >>> I would say it is a HW bug for the 2712.  I can file a bug against th=
e
> >>> 2712 but that will not help us right now.  From what I was told by HW=
,
> >>> asserting the PCIe1 bridge reset does not affect the rescal settings,
> >>> but it does freeze access to the rescal registers, and that is game
> >>> over for the other PCIe controllers accessing the rescal registers.
> >>
> >> Good findings, thank you.
> >>
> >> The problem comes from this snippet from brcm_pcie_probe() :
> >>
> >>         ret =3D pci_host_probe(bridge);
> >>         if (!ret && !brcm_pcie_link_up(pcie))
> >>                 ret =3D -ENODEV;
> >>
> >>         if (ret) {
> >>                 brcm_pcie_remove(pdev);
> >>                 return ret;
> >>         }
> >>
> >> Even when pci_host_probe() is successful the .probe will fail if there
> >> are no endpoint devices on this root port bus. This is the case when
> >> probing pcie1 port which is the one with external connector. Cause the
> >> probe is failing we call reset_control_rearm(rescal) from
> >> brcm_pcie_remove(), after that during .probe of pcie2 (the root port
> >> where RP1 south-bridge is attached) reset_control_reset(rescal) will
> >> issue rescal reset thus rescal-reset driver will stuck on read/write
> >> registers.
> >>
> >> I think we have to drop this link-up check and allow the probe to fini=
sh
> >> successfully. Even that there no PCI devices attached to bus we want t=
he
> >> root port to be visible by lspci tool.
> >
> > Hi Stan,
> >
> > What is gained by having only the root bridge shown by lspci?  We do
> > not support PCIe hotplug so why have lspci reporting a bridge with no
> > devices?
> >
> > The reason we do this is to save power -- when we see no device we
> > turn off the clocks, put things in reset (e.g. bridge), and turn off
> > the regulators.  We have SoCs with multiple controllers  and they
> > cannot afford to be supplying power to controllers with non-populated
> > sockets; these may be products that are trying to conform to mandated
> > energy-mode specifications.
>
> I totally agree, although I do not see power consumption significantly
> increased. Also I checked all other PCI controller drivers and no one
> else doing this.

Hi Stan,
I  see a few drivers use runtime_pm but we  do not; our architecture
is old and not amenable to that system.  Discounting runtime_pm, we
seem to be the only controller that uses the .suspend* or .resume*
methods.

I think we are kind of unique in how we turn off/on voltage regulators
for the endpoint device -- we put the regulator node under the port
driver DT node.  This is what customers asked for and what made
customers happy -- they just add a regulator node and ref to the DT we
provide and they don't have to worry about syncing power for their
device on their board.

There was also a recent patch submission that implemented something
similar by making the port driver customizable so that it could pick
up regulators; I don't recall if that ever got accepted.  But if it
was, we were thinking of switching to it.

Let me ask the HW folks if it is acceptable to leave the bridge reset
unasserted on remove() or suspend().  Note that if RPi decides to give
<clocks> and <clock-names>  valid props then problem will still be
there.

Regards,
Jim Quiinlan
Broad


>
> >
> >  This will solve partially the
> >> issue with accessing rescal reset-controller registers after asserting
> >> bridge_reset. The other part of the problem will be solved by remove t=
he
> >> invocation of reset_control_rearm(rescal) from __brcm_pcie_remove().
> >> That way only the first probed root port will issue rescal reset and
> >> every next probe will not try to reset rescal because we do not call
> >> _rearm(rescal).
> >
> > In theory I agree with the above -- it should probably not be invoking
> > the rearm() when it is being deactivated.  However, I am concerned
> > about a controller(s) going into s2 suspend/resume or unbind/bind.
>
> In fact not calling rearm() from __brcm_pcie_remove() is not enough
> because the .probe will fail thus rescal reset will loose it's instance
> and next probed pcie root port will issue rescal reset again.
>
> I'd stick with avoiding assert of bridge_reset from brcm_pcie_turn_off()
> for now, and this will be true only for bcm2712.
>
> ~Stan

--0000000000009cfa0f0620ab85eb
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA2JvqfAWaIOEXhdmYkKqXcqppBwqLl
7P2QoZf2uqKKzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MjcxNTAxNTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEACf2oWhSh406CvXOYiRUcERQqMu7025sIbxTA0reDo4gy5LU9
Zm1Z8Wvu0nARtpZmJOcKOZfReS5KIF3NvOagdcz9c3Mg3sMPPu4p/ZgPYjD3jLKj7I9xa9aMdx9S
pPIezBIcJCxH/BAtbo832GGavVot3/cpE80+LG7q/EIPPmuotq/NA2NFlUOphyv0sk9zDj4O6nMI
OuMjZqtkcDiap1ZhiQIWM319wU4ro/MK/XT39U1KyCdycVMCzjdVGrVqjC3js5aF5yqWbN8ZkWNR
koSiRyUMgYUq5HU6eSoKrCwKTJVg2lopDgeEVmlAeDz1CVC7SzDGr7J/UWrkoFbD0w==
--0000000000009cfa0f0620ab85eb--

