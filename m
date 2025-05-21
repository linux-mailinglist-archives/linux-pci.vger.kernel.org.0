Return-Path: <linux-pci+bounces-28240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15696ABFF51
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C231BA292C
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14CF1D88A6;
	Wed, 21 May 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cR0IpvW1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4B154C17
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747865310; cv=none; b=nVRNjNZFIn3pgMbFl8oNH3Q5kYOruMBJG6xcSST6nILwlMVGpw35wS8qYHC7sPayd43PZ1Vro2bZ1Mo2jfH9IOlcCSx1OofHw3hKKeiHuLct0b6vguMD/lIrOvuoisJIj0C3kgG3BivjSslbLPEfwfeJn6DB9nDn4VyxPfyx5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747865310; c=relaxed/simple;
	bh=pVgv3Tevf5JCZbIa6yU7CAwFzSpF04+foexnjcKCCoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpESc1wd14KkqpyWbzCO22B38rdHPrLPbXPQZWpty3F8cUavZPRlT2aMSE0C8IakqM1UjWXCMh1jR7dSAvaUEJEf4op2oXpirobV3t0rAhqX5J00OzLG79qABci03uoN1Uqr95UeHAmUDZgWc9jvgC7sGhdw7fAW+N7iIPSCn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cR0IpvW1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32918fe5334so40138021fa.1
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747865306; x=1748470106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RqIuyzaHw+XWSD1StNjevbfVWmth+A0lDqc3BbiskD4=;
        b=cR0IpvW1W0FZlrDD5kCL1/+kdXA1szXWmIFpUcciI9tKnMaVfmFRTBmY+58AnhkiQl
         V8H7/t7UFs47YRqeoB6eVgZUey8L5c1IHdFUkA2WBmP15IiU7t/ULEaLyEjlYbczpyiR
         yp4LaRqF1WJCCRkvoxyM+vB+DU/mwd24sjZag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747865306; x=1748470106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqIuyzaHw+XWSD1StNjevbfVWmth+A0lDqc3BbiskD4=;
        b=vGwqbi3lV73AYgKgsosavBGwnOmk3o8DdBpIkywJTYCqX/P2hvomqmgJJWceEvTUfN
         6une2b5OvN1t0/Qh0vu+YOqUcUM5smk4/4162Dyh66MuRnUAggAb8Sdke07OLr06qP8D
         1e7ORAZpPGzXxBGcw479ALIOoZLxcqhTJdQf28GSAqnCIndTNYccL4//hFrp+o/pCL+M
         LValIZJa+xGHt1gyeVhhNhIqD3DxHixG3P9cTo+0NbhVSJOKY0inm4wn/zXipEO80If7
         FOowLfay7mWrSgVhpwRX262PYo8kxfg7uifv77sgIqDIhSApaVSfEkAqBD80pBZ82NdL
         0w9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA0/ORqL2Khr/Xh18D54KzKy4t4YbPUQ1xzpp65n7N/slFHCLImm95gJwRV1klhqa6aod3XrpscqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAI1kKC7kPryBaBF+cjmQ884HsWGCrx6+b9kFPcxsNuTEPgktT
	FtaEr+iXrrwGFWqHhAhmMklTEab1UVzaZu4uxVl/CYw2ipqFDL1E7TC/LMX9lG8Qo8Gwoesmgh6
	AEp4guUSRgY6B6F3BbJHzpLUPa0YZCrDe37Oc7k9UlpEuxcNmuRrCQQ==
X-Gm-Gg: ASbGncuTFfjl0dkOSyIk7OlY3QyGXoBQbrDU7MT+25H74Qfq+jquDrwYLdV5HE8b/62
	MIrhrHa5pIuOkX0F+uML4yM40ilEZ4ZWeGkRR5CheQh4nienVDqgE9wWa3FbbJYn/63Kp4v1qLh
	+ip235nRjPNQqMg0AbJUD/5mZkxzlhma2H8A==
X-Google-Smtp-Source: AGHT+IEGRKpYfz0bsRPfZa6eQX7Id7r2LFfMAxiUXflk2OyKtqp2A3PF0G2jxNOepLGx1NlUIf3wkoiJBSpMMpEPq/c=
X-Received: by 2002:a05:651c:2142:b0:328:1364:7754 with SMTP id
 38308e7fff4ca-32813647891mr37648221fa.24.1747865306418; Wed, 21 May 2025
 15:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
 <20250519215601.GA1258127@bhelgaas> <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>
 <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
 <CA+-6iNz-qyKDKif5mv5FProqbpkQdfOYx+nSUA4NHSiCL9Ng5Q@mail.gmail.com> <uye7kpakmj5vx6bdzzy4tsmqqi777rhdb273tqsvgr6tv27apy@jyneanv3blit>
In-Reply-To: <uye7kpakmj5vx6bdzzy4tsmqqi777rhdb273tqsvgr6tv27apy@jyneanv3blit>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 21 May 2025 18:08:14 -0400
X-Gm-Features: AX0GCFsEgMov_S0n-Wwwa96bEIxnjAg-zSUryTmdMlwtHa5xXWGU7AB5FsDdANY
Message-ID: <CA+-6iNwTkrmVWuitrmkLJ+=B935LFuK6Q91obMWe03v7sZ_MCQ@mail.gmail.com>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, "'Cyril Brulebois" <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 
	"'Nicolas Saenz Julienne" <nsaenz@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000bb965c0635ac9ad1"

--000000000000bb965c0635ac9ad1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:40=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, May 20, 2025 at 11:06:33AM -0400, Jim Quinlan wrote:
>
> [...]
>
> > > > > What systems does the regression affect?
> > > >
> > > > All Broadcom STB chips, including the RPi sister chips.  Now is the=
re
> > > > anyone but our team who runs upstream Linux on our boards?  Probabl=
y
> > > > not.
> > > >
> > >
> > > I forgot to ask you this question. Is your devicetree upstreamed? Bec=
ause, while
> > > introducing the pwrctrl knobs, I made sure that there are no upstream=
 users
> > > using the supply properties in child nodes. All our existing users ar=
e using the
> > > properties in controller nodes, so they are not impacted.
> > Hello Mani,
> >
> > Our device tree is constructed on the fly by our custom bootloader
> > and passed to Linux, so it does not make sense (IMO) to put them
> > upstream as long as we strictly follow our upstreamed YAML bindings
> > file.  As I mentioned before, our  brcm,stb-pcie.yaml example, which
> > is upstream, contains a "vpcie3v3-supply" property under the pci@0,0
> > node.
> >
>
> Okay, thanks for the pointer. I was not aware that you have bootloader
> constructed DTB.
>
> > >
> > > Here it looks like you are running out-of-tree dts, which we do not s=
upport
> > > unfortunately.
> > The brcmstb YAML file is upstream, and a grep for the standard pcie
> > regulator names would have led you to it. I don't see how you can say
> > you don't support a DT that follows the upstream YAML file(s).
> >
>
> I didn't say that exactly. I thought you were using some out-of-tree vend=
or DTS
> which doesn't adhere to the DT bindings, but I was wrong. Your usecase is
> completely valid.
>
> > But it doesn't mean that I do not care about the issue you
> > > reported. I'm flying back home from vacation tomorrow and it will be =
the first
> > > thing I'm goona look into.
> > >
> > > Adding suspend/resume support is pretty much what I'm going to work o=
n the
> > > upcoming weeks (combined with some rework). So until then, I request =
you to
> > > revert the changes in your downstream tree and bear with me.
> >
> > I would rather our systems peacefully coexist, and take your changes
> > voluntarily and on my own schedule, rather than wait for you to add
> > future features.  I'm a little surprised that the CONFIG_PCI_PWRCTL
> > code seems to act on the PCI regulators even when its driver is not
> > present.
> >
>
> I overlooked at that part. Would the below diff help you?
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..b38a62f40448 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2514,6 +2514,9 @@ static struct platform_device *pci_pwrctrl_create_d=
evice(struct pci_bus *bus, in
>         struct platform_device *pdev;
>         struct device_node *np;
>
> +       if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
> +               return NULL;
> +
>         np =3D of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
>         if (!np || of_find_device_by_node(np))
>                 return NULL;
>
Hi Mani,
Yes that works but I have to set

CONFIG_ATH11K=3Dn
CONFIG_ATH12K=3Dn
CONFIG_ATH11K_PCI=3Dn

in order to get

CONFIG_PCI_PWRCTRL=3Dn

This would be a problem if we had a customer system that required
ATH1[2].  We do have one with ATH9k but we are safe for now.
>
> > In addition, I need the ability to cancel at runtime the
> > suspend/resume off/on of the regulators if the downstream device.
> >
>
> I don't get what you mean by 'ability to cancel at runtime'. Like I said =
before,
> I'm going to rework pwrctrl little bit and probably add suspend/resume (s=
ystem
> PM first) on the way, if that's what you are referring to.

If you look at  drivers/pci/controller/pcie-brcmstb.c and search for
brcm_pcie_suspend_noirq(),, you will see that we only turn off/on the
regulators on suspend/resume if the downstream device has
device_may_wakeup(dev)=3D=3Dfalse.  We discover this at runtime by walking
the bus.  The idea here is to support an optional  WOL scenario.

I'm currently inquiring whether we can lessen this requirement somehow
and will let you know when I get the answer.

>
> > That being said,  I don't mind if the series stays as long as you
> > promise to work with me to have our systems coexist.  But I do not
> > want to wait for future features to be added for our code to work.
> > >
> > > Bjorn, FYI: We do not need any revert in mainline since the issue is =
not
> > > affecting upstream users.
> >
> > So is it a rule that all DT  must be upstreamed, or is it sufficient
> > to have a bindings YAML file that defines the DT for the driver?
> >
>
> The latter IMO. If the diff I supplied above works fine, I'll submit a pa=
tch for
> that. Eventually, we do like to control the supplies from the pwrctrl dri=
ver
> instead of from controller drivers. That's the whole point of introducing=
 this
> framework. But since it is not enabled in defconfig yet, your driver shou=
ld
> continue working in the meantime with the diff. Later on, I will modify b=
rcmstb
> driver to adapt to pwrctrl framework. Since the binding is same, the driv=
er is
> going to be backwards compatible also.
>
> Please let me know if it works of not!

Yes it does work.  Not a perfect situation, but it will keep me going
as we move toward having the pcie-brcmstb driver move to the pwrctrl
framework.

Thanks,
Jim Quinlan
Broadcom STB/CM


>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000bb965c0635ac9ad1
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBoPNy6se6VnU0Ao5xBA0oHJtW0D+An
eq4qiJmtYO4D4zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MjEyMjA4MjZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQBpU+Yfv5Dlt6xr6+32ONb5al6BxWN/BSnoiviWFqlukTiK1LU678NxSF+a0y+gDUOl
RkjH/KnMySMo5iecwJZQfz73RQGIVrSgHa/5PQSpEv7zKlr9rtNPdURteDTvt/sdNhJYnkY60IRn
Hu0x59o83F/0C+ZmjUcNDSKU8BfAkcMyZ9NUiNPrITxvl5glgoTvAEETOmcEgmVNAEbDivZnZSoa
/YUQOHuvHSzZa2Q9uqlYxO38ZvDix3sopOQj/AFan98Qs/zpkADywSoBGJnW4V+ZnJphyJoD9nOh
+/httypn/TzkI/k8zq85oEfMf5al085wZbvOr5/PVknYDE9Z
--000000000000bb965c0635ac9ad1--

