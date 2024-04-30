Return-Path: <linux-pci+bounces-6910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495AE8B81BC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 23:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D9B216BE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513931A0B07;
	Tue, 30 Apr 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eQdFk98S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6FE1A0B14
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510981; cv=none; b=JgqQgdV3aZ8b5fYk/aVo2e+02S8zX77aiPJE9AsuiSc67pOq5D4aD03SGB0IF42dV81ubv59ClePpQwH9I6btGOWbpZ+9RviVXTEuQS+kd0ggZ6CiT+t5AXPSEYcl+UV6xEO7LBWlnT6iO2P7e+bk63FqyeJIC+Ig18HBconKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510981; c=relaxed/simple;
	bh=X8UE7Fek3X6N9kt55VHvDqJSuYKZL8go65JZPnxzQJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hasGZ39s7g2e7qRR95UaDACS5hTzOL5DXpCAjR+lrc+Qwo4lqMnnLTK6A7ddyP0qYVAnuRRVIbkkOW1DDDJjfFnmTRidCC/GE+CIDOKPY0TE8y/UHv99HqQ+DALnhepPe6lO0P7PJlan13OG9hj8+KgOuKmFcfYMzYyVkTXFbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eQdFk98S; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5176f217b7bso10986856e87.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714510977; x=1715115777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAsKwc0je8zs9zU0BPNUqcHwStc45tg8Obmds2jKHjs=;
        b=eQdFk98S2Z8M0yhBdqtoE7ptQGRsIdbZsLBIFnB7B8MDb8KzKy4oKjtA1mxEde4zUp
         /HD8x8gXm6MtgpiVGIfpU/wePGGt/uqk5sGsWkUbOgu/VHnp5/aSfRcyzQcD7DWjh1e5
         6bBELvp1uy3HtWJr+d9nc6l433lQc++WB7W7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714510977; x=1715115777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAsKwc0je8zs9zU0BPNUqcHwStc45tg8Obmds2jKHjs=;
        b=uXHGcje6gd85PUOL0da+jcX5HjXK125f1WJvVBRBq8N/3wPsxEYXQELevOfKqTjBV6
         NiFc8Iml/52OaMoTf090iW7dioUBzWx9DGRHYf5ScqgD4UPPjuboICy8H4BBEx/du4Jz
         OdPMfAK6qMUFc85VZ9iLAtWnUGx3/wwhecSd5k8cCPo6Hq+SCcx2SKrknADwQgrs973k
         ramMTPJ+fHL9/Hu9I+ih6o+Vyzxy6SLZwneQID9mJ1JTDuW4UOo1tpsIMbD1zfaWqyY7
         3sY7ihfpl71oZTAXrjmkbpwivlSj0jY67bTvvQL2PP/HrpqVy2rm/rK+hs3bEaGQdRG9
         idTA==
X-Gm-Message-State: AOJu0YzTBSUdrRB0eqt7y44ES34ULjEEo/1m1u071JO6/uUvECxo9Wq7
	yRnEKe08zy9r7Izplks7r3I5o77kOypCvc/N1FXKYFVWgz9xJC0IuJ5s1D05jCTEty5iUckHtQf
	waFoYqsCgKIFmOl7FUO1uyo8dssmuMn0Kc5LCRgpMPMNpt7bobw==
X-Google-Smtp-Source: AGHT+IHgAqjb4vbL/YJXOWO2pnGsbq+kv86t6WEIRYuAsVkdfRhKM4xCHP0QDOcoWnOmRwqqtvqTi+cW+d72Q5NVEGU=
X-Received: by 2002:ac2:4e94:0:b0:51c:d1ac:c450 with SMTP id
 o20-20020ac24e94000000b0051cd1acc450mr510771lfr.10.1714510976926; Tue, 30 Apr
 2024 14:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403213902.26391-1-james.quinlan@broadcom.com>
In-Reply-To: <20240403213902.26391-1-james.quinlan@broadcom.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 30 Apr 2024 17:02:45 -0400
Message-ID: <CA+-6iNynMc7-zZ0No0Y30of+uPiz0mSL9brV3R=UGJNC6ytoxg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] PCI: brcmstb: Configure appropriate HW CLKREQ# mode
To: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Phil Elwell <phil@raspberrypi.com>, 
	bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc: Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c44888061756b14e"

--000000000000c44888061756b14e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:39=E2=80=AFPM Jim Quinlan <james.quinlan@broadcom.=
com> wrote:
>
> v9 -- v8 was setting an internal bus timeout to accomodate large L1 exit
>       latencies.  After meeting the PCIe HW team it was revealed that the
>       HW default timeout value was set low for the purposes of HW debuggi=
ng
>       convenience; for nominal operation it needs to be set to a higher
>       value independent of this submission's purpose.  This is now a
>       separate commit.

Bjorn,

Did you have some time to look at this?  Do you have any comments or questi=
ons?

Regards,
Jim Quinlan
Broadcom STB/CM
>
>    -- With v8, Bjorne asked what was preventing a device from exceeding t=
he
>       time required for the above internal bus timeout.  The answer to th=
is
>       is for us to set the endpoints' max latency {no-,}snoop value to
>       something below this internal timeout value.  If the endpoint
>       respects this value as it should, it will not send an LTR request
>       with a larger latency value and not put itself in a situation
>       that requires more latency than is possible for the platform.
>
>       Typically, ACPI or FW sets these max latency values.  In most of ou=
r
>       systems we do not have this happening so it is up to the RC driver =
to
>       set these values in the endpoint devices.  If the endpoints already
>       have non-zero values that are lower than what we are setting, we le=
t
>       them be, as it is possible ACPI or FW set them and knows something
>       that we do not.
>
>    -- The "clkreq" commit has only been changed to remove the code that w=
as
>       setting the timeout value, as this code is now its own commit.
>
> v8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
>    -- Squashed last two commits of v7 (Bjorn)
>    -- Fix DT binding description text wrapping (Bjorn)
>    -- Fix incorrect Spec reference (Bjorn)
>          s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
>    -- Text substitutions (Bjorn)
>          s/WRT/With respect to/
>          s/Tclron/T_CLRon/
>
> v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
>       network phy-mode and (b) keeping the code simple (not counting clkr=
eq
>       signal appearances, un-advertising capabilites, etc).  This is
>       what I have done.  The property is now "brcm,clkreq-mode" and
>       the values may be one of "safe", "default", and "no-l1ss".  The
>       default setting is to employ the most capable power savings mode.
>
> v6 -- No code has been changed.
>    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril=
)
>    -- Changed sign-off and author email address for all commits.
>       This was due to a change in Broadcom's upstreaming policy.
>
> v5 -- Remove DT property "brcm,completion-timeout-us" from
>       "DT bindings" commit.  Although this error may be reported
>       as a completion timeout, its cause was traced to an
>       internal bus timeout which may occur even when there is
>       no PCIe access being processed.  We set a timeout of four
>       seconds only if we are operating in "L1SS CLKREQ#" mode.
>    -- Correct CEM 2.0 reference provided by HW engineer,
>       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
>    -- Add newline to dev_info() string (Stefan)
>    -- Change variable rval to unsigned (Stefan)
>    -- s/implementaion/implementation/ (Bjorn)
>    -- s/superpowersave/powersupersave/ (Bjorn)
>    -- Slightly modify message on "PERST#" commit.
>    -- Rebase to torvalds master
>
> v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
>       driver probe() time.  This is done in Raspian Linux and its
>       absence may be the cause of a failing test case.
>    -- New commit that removes stale comment.
>
> v3 -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
>    -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
>    -- Put binding names in DT commit Subject (Bjorn)
>    -- Add a verb to a commit's subject line (Bjorn)
>    -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
>    -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
>
> v2 -- Changed binding property 'brcm,completion-timeout-msec' to
>       'brcm,completion-timeout-us'.  (StefanW for standard suffix).
>    -- Warn when clamping timeout value, and include clamped
>       region in message. Also add min and max in YAML. (StefanW)
>    -- Qualify description of "brcm,completion-timeout-us" so that
>       it refers to PCIe transactions. (StefanW)
>    -- Remvove mention of Linux specifics in binding description. (StefanW=
)
>    -- s/clkreq#/CLKREQ#/g (Bjorn)
>    -- Refactor completion-timeout-us code to compare max and min to
>       value given by the property (as opposed to the computed value).
>
> v1 -- The current driver assumes the downstream devices can
>       provide CLKREQ# for ASPM.  These commits accomodate devices
>       w/ or w/o clkreq# and also handle L1SS-capable devices.
>
>    -- The Raspian Linux folks have already been using a PCIe RC
>       property "brcm,enable-l1ss".  These commits use the same
>       property, in a backward-compatible manner, and the implementaion
>       adds more detail and also automatically identifies devices w/o
>       a clkreq# signal, i.e. most devices plugged into an RPi CM4
>       IO board.
>
> Jim Quinlan (4):
>   dt-bindings: PCI: brcmstb: Add property "brcm,clkreq-mode"
>   PCI: brcmstb: Set reasonable value for internal bus timeout
>   PCI: brcmstb: Set downstream maximum {no-}snoop LTR values
>   PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
>     device
>
>  .../bindings/pci/brcm,stb-pcie.yaml           |  18 ++
>  drivers/pci/controller/pcie-brcmstb.c         | 161 +++++++++++++++++-
>  2 files changed, 170 insertions(+), 9 deletions(-)
>
>
> base-commit: 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
> --
> 2.17.1
>

--000000000000c44888061756b14e
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBqrVlur7mK6pQaTPQ7Uaf3L6eM3pE9
UV/lhX6GHR4iuDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA0
MzAyMTAyNTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAXLdOpomVsjiR0YJBvkScNCyVyPmsMjIM7OlYpn4FLnUJ6bXC
uNryUYuuT4WEKWquE0ww3Jjhq4Z5+qh+fQ3lvbuGbVFuf92PP1j9KqArITBNBqdxb1U+wVj4Dbyv
S/bqVi0HOpSMVVeZLTVw6u9ZfR27fD4KRP6VMgVWB3TuzEgME7aGzZvx0GW/TddEaa+GYebQ1n+z
LlSHeDmJ4yCJHl+i/8BqwAcpJOsIr8pVD9QVvqOcjmrMHLbEcK5fwxJGMTYu1ldUKJIjEveZdjKV
ytOXLgrD8PK/k/EID+aVEzPzrBQy55aldGtADEZW7n6SZK27IzDZlHO3PDgv0w1zkw==
--000000000000c44888061756b14e--

