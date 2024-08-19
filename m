Return-Path: <linux-pci+bounces-11828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D995724C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 19:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D651C22822
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D2188016;
	Mon, 19 Aug 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LsErmui0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8171188008
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089491; cv=none; b=atKDusOirg2hxpZYJUXee0mVR8yP5Tl0qVruwydDdJIzDIKXPr6Y7DpCHFcgtO+38TqoZ5J/EjsPpsxQqIS7neO+a+fqNb/DPOH3B4+yvUk1a7PamGFT20guwkmI2eoGkSgVOZIKhXWjyf4wUW359nyLaIBYiVbU+sevMUu7bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089491; c=relaxed/simple;
	bh=SPQAgYpibdDnzQtgq2DrpwimQhvfhoUBBZ6HzEd0j/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EiZz/BTib/MgjkuQRbmZIqDOvsIZ7vsbK2qBxR+bzLJlzwkxBL0kxee/HUMEvKVk2h+ZxBeHYM98I80JuBfZbpjpRN4CoSa6BO98bYcZJ0c3AS6CbJit3u9u4Q5hVS9x16bdkuFuWZfcZDtI7ABnAHTTbUNLfbuV9yH4Z09lV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LsErmui0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd855adbso5665477e87.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724089486; x=1724694286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBYj3Zyvv6BVT2GusKy0K7Yf05oxCpIz4Te2PojhWUQ=;
        b=LsErmui0K6XoRBWuG/qJASMHh7p88+xu4+8RyWXZNR9RWViG71ngRCQzTOVStGvzSJ
         TCt6CDE1S36T+Y8C5+QX7dRfagscX1XPXIsQfk2cp0mJ4wekt+d+ieO5GYFo+pcUA5xJ
         T3kmmkN3/xwf+tBs+LA5lEgNt9yEw4MXOQiBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089486; x=1724694286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBYj3Zyvv6BVT2GusKy0K7Yf05oxCpIz4Te2PojhWUQ=;
        b=ISO7VYqIx5X2ARLL6+HJDnvRUg3raDga69mgovsLYN6/F8H5K4yYiP8ehT/9I1Aada
         Dr8Z5hMv5WFdqq+4p63Xif7raXDSRUbsLHZ1IzgMFVSgNYUr9Cbgz352LJT1jwlO8yQy
         GMvzhVOpnC++C+qYT6RO/P9VxVRq87KXHhFtq1H++82vCbvzl2SzaoCi2/kUfuercmnu
         utco6ADZ9avFKejqFTEFTS/gdJsy5sEERRZlfpc7Zxm3Rjx+d/00aJTL0IrxVGfWA3Wi
         YAGe3AqCkQ0hv9Kbv4iRdfd7Gxn3N6yOm3oy67t8ERfD9FVUCjCHiRzTxVW2WrB894j+
         L8eg==
X-Gm-Message-State: AOJu0Yyev4F4mBEVr7LDLWoy1zV9zEmFe7egwiHKlU4lvgSInn3qDIPU
	BiB5hlYeY/e8j70Qbrn6lzlhI5actbXtTIg4h4rOh+YIfno1Vb3n6iDXOfEqMlTse2nddCMKQgn
	U40/9CUeEL3JrHIc6FEEffxIqeNZGSyHzbTK7
X-Google-Smtp-Source: AGHT+IHVcvgPi4a2baQz/6Y53wCgutnPaPrDAYJ3M+YvYag+g6DGuSeq3sITgEslCPok9x5LjtvLOWOXIZGTRfCjL68=
X-Received: by 2002:a05:6512:3d27:b0:530:ea2b:1a92 with SMTP id
 2adb3069b0e04-5331c6dc3a3mr6939148e87.43.1724089485419; Mon, 19 Aug 2024
 10:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815225731.40276-1-james.quinlan@broadcom.com> <20240816071822.GO2331@thinkpad>
In-Reply-To: <20240816071822.GO2331@thinkpad>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 19 Aug 2024 13:44:33 -0400
Message-ID: <CA+-6iNz4+xP4abf6w6bcVwFxvjx8OhDZXNi5bwfaCNvyF2Mtng@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] PCI: brcnstb: Enable STB 7712 SOC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	jim2101024@gmail.com, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006106a306200cdd09"

--0000000000006106a306200cdd09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:18=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Aug 15, 2024 at 06:57:13PM -0400, Jim Quinlan wrote:
> > V6 Changes
> >   o Commit "Refactor for chips with many regular inbound windows"
> >     -- Use u8 for anything storing/counting # inbound windows (Stan)
> >     -- s/set_bar/add_inbound_win/g (Manivannan)
> >     -- Drop use of "inline" (Manivannan)
> >     -- Change cpu_beg to cpu_start, same with pcie_beg. (Manivannan)
> >     -- Used writel_relaxed() (Manivannan)
> >   o Use swinit reset if available
> >     -- Proper use of dev_err_probe() (Stan)
> >   o Commit "Use common error handling code in brcm_pcie_probe()"
> >     -- Rewrite commit msg in paragraph form (Manivannan)
> >     -- Refactor error path at end of probe func (Manivannan)
> >     -- Proper use of dev_err_probe() (Stan)
> >   o New commit "dt-bindings: PCI: Change brcmstb maintainer and cleanup=
"
> >     -- Break out maintainer change and small cleanup into a
> >        separate commit (Krzysztof)
> >
>
> Looks like you've missed adding the review tags...


I didn't mention this in the cover letter but I update the review tags
at each version.  The problem is that if someone has reviewed a
commit, and then that commit is subsequently changed due to another
reviewer, I have to remove the existing tag of the first reviewer
because the code has changed.

Regards,
Jim Quinlan
Broadcom STB/CM
>
>
> - Mani
>
> > V5 Changes:
> >   o All commits: Use imperative voice in commit subjects/messages
> >        (Manivannan)
> >   o Commit "PCI: brcmstb: Enable 7712 SOCs"
> >     -- Augment commit message to include PCIe details and revision.
> >        (Manivannan)
> >   o Commit "PCI: brcmstb: Change field name from 'type' to 'model'"
> >     -- Instead of "model" use "soc_base" (Manivannan)
> >   o Commit "PCI: brcmstb: Refactor for chips with many regular inbound =
BARs"
> >     -- Get rid of the confusing "BAR" variable names and types and use
> >        something like "inbound_win". (Manivannan)
> >   o Commit "PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE=
..."
> >     -- Mention in the commit message that this change is in preparation
> >        for the 7712 SoC. (Manivannan)
> >   o Commit: "PCI: brcmstb: Use swinit reset if available"
> >     -- Change reset name "swinit" to "swinit_reset" (Manivannan)
> >     -- Add 1us delay for reset (Manivannan)
> >     -- Use dev_err_probe() (Multiple reviewers)
> >   o Commit "PCI: brcmstb: Use bridge reset if available"
> >     -- Change reset name "bridge" to "bridge_reset" (Manivannan)
> >     -- The Reset API can take NULL so need need to test variable
> >        before calling (Manivannan)
> >     -- Added a call to bridge_sw_init_set() method in probe()
> >        as some registers cannot be accessed w/o this. (JQ)
> >   o Commit "PCI: brcmstb: Use common error handling code in ..."
> >     -- Use more descriptive goto label (Manivannan)
> >     -- Refactor error paths to be less encumbered (Manivannan)
> >     -- Use dev_err_probe() (Multiple reviewers)
> >   o Commits "dt-bindings: PCI: brcmstb: ..."
> >     -- Specify the "resets" and "reset-names" in the same manner
> >        as does qcom,ufs.yaml specifies "clocks" and
> >        "clock-names" (Krzysztof)
> >     -- Drop reset desccriptions as they were pretty content-free
> >        anyhow. (Krzysztof)
> >
> > V4 Changes:
> >   o Commit "Check return value of all reset_control_xxx calls"
> >     -- Blank line before "return" (Stan)
> >   o Commit "Use common error handling code in brcmstb_probe()"
> >     -- Drop the "Fixes" tag (Stan)
> >   o Commit "dt-bindings: PCI ..."
> >     -- Separate the main commit into two: cleanup and adding the
> >        7712 SoC (Krzysztof)
> >     -- Fold maintainer change commit into cleanup change (Krzysztof)
> >     -- Use minItems/maxItems where appropriate (Krzysztof)
> >     -- Consistent order of resets/reset-names in decl and usage
> >        (Krzysztof)
> >
> > V3 Changes:
> >   o Commit "Enable 7712 SOCs"
> >     -- Move "model" check from outside to inside func (Stan)
> >   o Commit "Check return value of all reset_control_xxx calls"
> >     -- Propagate errors up the chain instead of ignoring them (Stan)
> >   o Commit "Refactor for chips with many regular inbound BARs"
> >     -- Nine suggestions given, nine implemented (Stan)
> >   o Commit "Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
> >     -- Drop tab, add parens around macro params in expression (Stan)
> >   o Commit "Use swinit reset if available"
> >     -- Treat swinit the same as other reset controllers (Stan)
> >        Stan suggested to use dev_err_probe() for getting resources
> >        but I will defer that to future series (if that's okay).
> >   o Commit "Get resource before we start asserting resets"
> >     -- Squash this with previous commit (Stan)
> >   o Commit "Use "clk_out" error path label"
> >     -- Move clk_prepare_enable() after getting resouurces (Stan)
> >     -- Change subject to "Use more common error handling code in
> >        brcm_pcie_probe()" (Markus)
> >     -- Use imperative commit description (Markus)
> >     -- "Fixes:" tag added for missing error return. (Markus)
> >   o Commit "dt-bindings: PCI ..."
> >     -- Split off maintainer change in separate commit.
> >     -- Tried to accomodate Krzysztof's requests, I'm not sure I
> >        have succeeded.  Krzysztof, please see [1] below.
> >
> >   [1] Wrt the YAML of brcmstb PCIe resets, here is what I am trying
> >       to describe:
> >
> >       CHIP       NUM_RESETS    NAMES
> >       =3D=3D=3D=3D       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=
=3D
> >       4908       1             perst
> >       7216       1             rescal
> >       7712       3             rescal, bridge, swinit
> >       Others     0             -
> >
> >
> > V2 Changes (note: four new commits):
> >   o Commit "dt-bindings: PCI ..."
> >     -- s/Adds/Add/, fix spelling error (Bjorn)
> >     -- Order compatible strings alphabetically (Krzysztof)
> >     -- Give definitions first then rules (Krzysztof)
> >     -- Add reason for change in maintainer (Krzysztof)
> >   o Commit "Use swinit reset if available"
> >     -- no need for "else" clause (Philipp)
> >     -- fix improper use of dev_err_probe() (Philipp)
> >   o Commit "Use "clk_out" error path label"
> >     -- Improve commit message (Bjorn)
> >   o Commit "PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-s=
pecific"
> >     -- Improve commit subject line (Bjorn)
> >   o Commit (NEW) -- Change field name from 'type' to 'model'
> >     -- Added as requested (Stanimir)
> >   o Commit (NEW) -- Check return value of all reset_control_xxx calls
> >     -- Added as requested (Stanimir)
> >   o Commit (NEW) "Get resource before we start asserting reset controll=
ers"
> >     -- Added as requested (Stanimir)
> >   o Commit (NEW) -- "Remove two unused constants from driver"
> >
> >
> > V1:
> >   This submission is for the Broadcom STB 7712, sibling SOC of the RPi5=
 chip.
> >   Stanimir has already submitted a patch "Add PCIe support for bcm2712"=
 for
> >   the RPi version of the SOC.  It is hoped that Stanimir will allow us =
to
> >   submit this series first and subsequently rebase his patch(es).
> >
> >   The largest commit, "Refactor for chips with many regular inbound BAR=
s"
> >   affects both the STB and RPi SOCs.  It allows for multiple inbound ra=
nges
> >   where previously only one was effectively used.  This feature will al=
so
> >   be present in future STB chips, as well as Broadcom's Cable Modem gro=
up.
> >
> > Jim Quinlan (13):
> >   dt-bindings: PCI: Change brcmstb maintainer and cleanup
> >   dt-bindings: PCI: Use maxItems for reset controllers
> >   dt-bindings: PCI: brcmstb: Add 7712 SoC description
> >   PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
> >   PCI: brcmstb: Use bridge reset if available
> >   PCI: brcmstb: Use swinit reset if available
> >   PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets
> >     SoC-specific
> >   PCI: brcmstb: Remove two unused constants from driver
> >   PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
> >   PCI: brcmstb: Refactor for chips with many regular inbound windows
> >   PCI: brcmstb: Check return value of all reset_control_xxx calls
> >   PCI: brcmstb: Change field name from 'type' to 'soc_base'
> >   PCI: brcmstb: Enable 7712 SOCs
> >
> >  .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
> >  drivers/pci/controller/pcie-brcmstb.c         | 513 +++++++++++++-----
> >  2 files changed, 412 insertions(+), 141 deletions(-)
> >
> >
> > base-commit: e724918b3786252b985b0c2764c16a57d1937707
> > --
> > 2.17.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

--0000000000006106a306200cdd09
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCu9dnpqGpGKOhK9qRtHZ8Xu262s1iB
ZhU/5Xpt0mJ7QzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA4
MTkxNzQ0NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAjYEmNfKzYn0XivBhllxQyDSLegtznekHKVj38c4BBjddGptv
n1qkehO92fT5C+p9S4/HuEjk1BqAbDXoEAHLqBdpvzjY8tSKs4kJE9LtoiNxQLc2FaM36VlWWKQ+
/Ir8HjeBOBUN9HO1tfyv+DcX3mg/i1bVucS13J4J5w9bsRhEoyOpStUq6OLP6P4/FZTFdpTCdDQF
ZAACQPGutNJNeiZcJAsZYaHo1X1KBr8HrxnNsxPv6mcsDwDNZq4tBoANh/6JNdP8H74ZPwcvVvoP
QHlbRCAXnBHsEv5Zr7Yv3CIXHki+BuoJsiqW182rcgu4kMi2VLJ+ECBFHK0MbbUDig==
--0000000000006106a306200cdd09--

