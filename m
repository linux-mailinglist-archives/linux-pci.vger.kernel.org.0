Return-Path: <linux-pci+bounces-28118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C161ABDE60
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24F88C02B6
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071117E0;
	Tue, 20 May 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DtyGBiIB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03132505AC
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753609; cv=none; b=a5FLfzo7p11dx+NubpKet7tcpZDYpOqt8gP13L4pY9XvaxkWJmi4LgySzVRX0nJ6S9vofj71YXYeaKSCWrL7iGT5LuQFrOIduo2bxEaeEYB18qT8LpPFkYDw52BRe5GUELnvMGCABJajV1IdT4M5Mt/nKqp4INC7OcKK/WFGh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753609; c=relaxed/simple;
	bh=0Mq7mjNjvIQiw8yyLVyh17cLGIJADgtN6ovOX7pQ4lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQv2wUtQNso6PKqUdDKF/Z9XIHCOBCO2LTedlYOQgEmIpRvZlaAI4wBd9xwxChA4hPmR25GSQwB5O3s4t7mbo57Vo8nFRHpgyGY279/og0RtFhykLSn9jXMRkQu0skR6e74A/fwiWfy7h8X5HhNYzenzOs6FZ1/pLE0XJVkkNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DtyGBiIB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32803984059so29136471fa.2
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747753606; x=1748358406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GL/Pb9vaFedVUFHOdY7Mkx1QGiC0lFYhZaIW3ersmLk=;
        b=DtyGBiIBxooEqUKTYyvzI2CSOrWRq5fq0YUvIOHaBX9h2iPk7So6srVSbCerYGn0WE
         H6qF/kLo/8Gx/GYdou0M1EyuYWXKHqM8Whke23AVAzUCDT19Q8IxQn5p8/3BQz44PZON
         AvEI17de9K2y7SJEFbMiSH36MxlXR1ePPqCX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753606; x=1748358406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL/Pb9vaFedVUFHOdY7Mkx1QGiC0lFYhZaIW3ersmLk=;
        b=gdw4IMiCcoLYLZWQAItCc2Ixuqd+8nhCZZ/mLNe3M3zhruzE9Ljs2ygHYtJorR0bdi
         KauopVJ4Bya3VXweH6uCFOJPm2dYYiS6cqxoNyq27ulThSG2R7DvtgUvBPyX/hO4cJSC
         DyjVlckYUE2yD6pNwfGbS5oIFY4Fu/NDUuH26bntMliFPTaUP7Fl5Lee0ay77qgL310h
         9ayIoAGmajLMtR3NyyU+k1XXrQDHeaSaCYGp9JIc8YzdHFjynYq/dFobpsSvzc5Z3L82
         nbUMuWyLqZj+iofOpEgLJMm4Eo43Ax4lagvUu/OREWrai82NpGlkIKqA5cPH627tfbdW
         7F/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULO/sMP8TRRg34DpbYn1J19g9f0AHjmQIp69Vdko08YyJVMHN+a6Cv83b07xCvQyi7idus08SFwSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmU8HyeNibDiZ2mgHMmBuZDPxq0y7IQflvjUz2rLbk0TzdEqrH
	eWl4jOreS2M5IKT9AbzsrnS5euP1eSJJQE3yqOxDt6Apy2gZBk1aO5cnzKc2NUHJfPlCpo3IOTM
	SjD233CMbDyhjQg9HaQhk6XyzS2GdlfQ0NrmPhd/1
X-Gm-Gg: ASbGncvYArXszUBaxK2D01g2BOwHq6+scx4v168lRSBZS61aaoXJmkQ96CM8AXlcRup
	YKYhF55hP4wwtKNPl5Bh3J/4pFEFhBb3pIbU8/N5eqcAhFQ/HBQcHU3QhUnFlddWd47r/iwYlfV
	1/CORTZnF0F0PJhyqBZQ82N8B5dcns2kYLFg==
X-Google-Smtp-Source: AGHT+IHzPaCDyX+9ikgNl8RM2wbCirlqb4So0q0Kmdg+IEcjFCOXzg3mUVEscysrgr/e1FCWRf+igKNrkToyE2fZjCU=
X-Received: by 2002:a05:651c:552:b0:30a:2a8a:e4b5 with SMTP id
 38308e7fff4ca-328077917e1mr57821331fa.27.1747753605445; Tue, 20 May 2025
 08:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
 <20250519215601.GA1258127@bhelgaas> <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>
 <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
In-Reply-To: <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 20 May 2025 11:06:33 -0400
X-Gm-Features: AX0GCFuNIhCNhYvL7m3S9HXb6ZYw0sArm5aygfi48k_B5SZP1ot25KbvPObmWzA
Message-ID: <CA+-6iNz-qyKDKif5mv5FProqbpkQdfOYx+nSUA4NHSiCL9Ng5Q@mail.gmail.com>
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
	boundary="000000000000d735570635929873"

--000000000000d735570635929873
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:12=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, May 19, 2025 at 07:03:18PM -0400, Jim Quinlan wrote:
> > On Mon, May 19, 2025 at 5:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > >
> > > On Mon, May 19, 2025 at 03:59:10PM -0400, Jim Quinlan wrote:
> > > > On Mon, May 19, 2025 at 2:25=E2=80=AFPM Jim Quinlan <james.quinlan@=
broadcom.com> wrote:
> > > > > On Mon, May 19, 2025 at 1:28=E2=80=AFPM Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > > On Mon, May 19, 2025 at 09:05:57AM -0500, Bjorn Helgaas wrote:
> > > > > > > On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > I recently rebased to the latest Linux master
> > > > > > > >
> > > > > > > > ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> > > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > > > > > > >
> > > > > > > > and noticed that PCI is broken for
> > > > > > > > "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this
> > > > > > > > to the following commit
> > > > > > > >
> > > > > > > > 2489eeb777af PCI/pwrctrl: Skip scanning for the device furt=
her if pwrctrl device is created
> > > > > > > >
> > > > > > > > which is part of the series [1].  The driver in
> > > > > > > > pcie-brcmstb.c is expecting the add_bus() method to be
> > > > > > > > invoked twice per boot-up, but the second call does not
> > > > > > > > happen.  Not only does this code in brcm_pcie_add_bus() tur=
n
> > > > > > > > on regulators, it also subsequently initiates PCIe linkup.
> > > > > > > >
> > > > > > > > If I revert the aforementioned commit, all is well.
> > > > > > > >
> > > > > > > > FWIW, I have included the relevant sections of the PCIe DT
> > > > > > > > we use at [2].
> > > > > > >
> > > > > > > Mani, Bartosz, where are we at with this?  The 2489eeb777af
> > > > > > > commit log doesn't mention a problem fixed by that commit; it
> > > > > > > sounds more like an optimization -- just avoiding an
> > > > > > > unnecessary scan.
> > > > > > >
> > > > > > > 2489eeb777af appeared in v6.15-rc1, so there's still time to
> > > > > > > revert it before v6.15 if that's the right way to fix this
> > > > > > > regression.
> > > > > >
> > > > > > We need to find out what is happening in the pcie-brcmstb drive=
r
> > > > > > first. From Jim's report, it looks like the driver expects
> > > > > > add_bus() callback to be invoked twice, which seems weird.
> > > > >
> > > > > The pci_ops add_bus() method is invoked once for bus 0 and once
> > > > > for bus 1. Note that our controller only has one port.  If I do
> > > > > "lspci" I get (our controller is on pci domain=3D=3D1):
> > > > >
> > > > > 0001:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries Device 77=
12 (rev 20)
> > > > > 0001:01:00.0 Ethernet controller: Broadcom Inc. ...
> > > > >
> > > > > It is the second invocation of add_bus() that has the brcmstb
> > > > > driver turning on the regulators and the subsequent link-up, and
> > > > > this call never happens with the 2489eeb777aff9 commit.
> > > >
> > > > Actually, I don't think it is sufficient to just revert that one
> > > > commit.  If I checkout 6.14-rc1 and just bring in
> > > >
> > > > 06bf05d7349c PCI/pwrctrl: Move creation of pwrctrl devices to pci_s=
can_device()
> > >
> > > 06bf05d7349c doesn't exist upstream; I assume it is 957f40d039a9
> > > ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()"=
)
> >
> > Hi Bjorn,
> >
> > Yes, sorry, you are correct.
> >
> > >
> > > > I get the following after getting the Linux prompt:
> > > >
> > > > pci 0001:00:00.0: deferred probe pending: pci: supplier
> > > > 1000110000.pcie:pci@0,0 not ready
> > > > pci 0001:00:00.0: deferred probe pending: pci: supplier
> > > > 1000110000.pcie:pci@0,0 not ready
> > > >
> > > > Basically, brcmstb already picks up and controls the regulator node=
s
> > > > under the port driver node.  You folks are adding a new generic
> > > > system and we are stepping on one another's toes.  The problem here
> > > > is that I cannot seem to turn your system off using CONFIG_PWR*
> > > > settings.
> > > >
> > > > We would certainly be open to adopting your system when it meets ou=
r
> > > > requirements; such as turning off/on on regulators @suspend/resume,
> > > > and the ability to not do that if the downstream device has
> > > > device_may_wakeup(dev)=3D=3Dtrue.  But until then we need a way to
> > > > disable your system or allow brcmstb to "opt out".
> > > >
> > > > AFAICT this regression does not affect the RaspberryPi SoCs, so it
> > > > is not a big deal for us if we take our time to fix this.   But if
> > > > so, it is incumbent on you folks to help me get past this
> > > > regression.  Is that reasonable?
> > >
> > > What systems does the regression affect?
> >
> > All Broadcom STB chips, including the RPi sister chips.  Now is there
> > anyone but our team who runs upstream Linux on our boards?  Probably
> > not.
> >
>
> I forgot to ask you this question. Is your devicetree upstreamed? Because=
, while
> introducing the pwrctrl knobs, I made sure that there are no upstream use=
rs
> using the supply properties in child nodes. All our existing users are us=
ing the
> properties in controller nodes, so they are not impacted.
Hello Mani,

Our device tree is constructed on the fly by our custom bootloader
and passed to Linux, so it does not make sense (IMO) to put them
upstream as long as we strictly follow our upstreamed YAML bindings
file.  As I mentioned before, our  brcm,stb-pcie.yaml example, which
is upstream, contains a "vpcie3v3-supply" property under the pci@0,0
node.

>
> Here it looks like you are running out-of-tree dts, which we do not suppo=
rt
> unfortunately.
The brcmstb YAML file is upstream, and a grep for the standard pcie
regulator names would have led you to it. I don't see how you can say
you don't support a DT that follows the upstream YAML file(s).

But it doesn't mean that I do not care about the issue you
> reported. I'm flying back home from vacation tomorrow and it will be the =
first
> thing I'm goona look into.
>
> Adding suspend/resume support is pretty much what I'm going to work on th=
e
> upcoming weeks (combined with some rework). So until then, I request you =
to
> revert the changes in your downstream tree and bear with me.

I would rather our systems peacefully coexist, and take your changes
voluntarily and on my own schedule, rather than wait for you to add
future features.  I'm a little surprised that the CONFIG_PCI_PWRCTL
code seems to act on the PCI regulators even when its driver is not
present.

In addition, I need the ability to cancel at runtime the
suspend/resume off/on of the regulators if the downstream device.

That being said,  I don't mind if the series stays as long as you
promise to work with me to have our systems coexist.  But I do not
want to wait for future features to be added for our code to work.
>
> Bjorn, FYI: We do not need any revert in mainline since the issue is not
> affecting upstream users.

So is it a rule that all DT  must be upstreamed, or is it sufficient
to have a bindings YAML file that defines the DT for the driver?


Regards,
Jim Quinlan
Broadcom STB/CM

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--000000000000d735570635929873
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
MA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBprcKqv7pNZmByaisirWeeR+ytmWvz
VG3bs59Ln40opzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA1
MjAxNTA2NDZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQB2Mgj2NesEC1I/wXLVjzx1qgdvU+qxPHgYr0htjjB1gHlmnsZJkiE84qJJXftF/2PT
0oQC39/WVUsICg9U+JJa9SxNHKA0g6nzxlCh5avTHEInvIe3Js6ioYhm5PMufkGGHsQywpsfv9AL
4RyGlPhZyPTqkHcXNGramgvgQyCIGsMmaZNhYXDZ24Mw7DLXcWrBAREimwDIJTRLVo2Q3r00s7Q3
/xFJLcDDheQr5qJzKWIOurUBqOBJwwPIJB2GrWatJj0VXVcDJ8yWjTQgw7WMUW/qOVeiT10QMGiT
ljYaIiM0JaV6yuAMQz3DAVHtD+mB9e61B3PGxBGzb6jGvqDO
--000000000000d735570635929873--

