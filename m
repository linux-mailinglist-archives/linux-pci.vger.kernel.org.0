Return-Path: <linux-pci+bounces-32201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD4B068BE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 23:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1895644E7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCE2C1585;
	Tue, 15 Jul 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEqwe/Kb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50C2C1582;
	Tue, 15 Jul 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615731; cv=none; b=Ylh96K6gth/VImi+GVcjkvhFTWo123lXT7KlvgGczHwbD2I8ibm3YnP4FvAFOJO/IhN+y3zfwEMBhBkbRPwPg+JM/FOPNdpRPai7sWcZeNfOinArwed2KsTimwd5gC1lNZ7WspaJ/KbeYWi/Oqte351wAK4JdqafuTRp5qcUEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615731; c=relaxed/simple;
	bh=guZSpdsSKl3YawdSkJgYATxoiaL2pmIvs8uhCzKiB9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9NOHiPqLwZ/dH+X3T9NBjk/wi/KtAU8wNi9LkzdGNx8j1DMYPy7+wvr3VZ5GGKThWIOMAFgK627/lNPREVYTvU0JR2WVOD2e4mzLOF/WCUe5YEjRJXleSNvYsxMktIjhyPiycqllPMqRhr+BYO+db1q43J6sFUjn11SHKDH54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEqwe/Kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F481C4CEF8;
	Tue, 15 Jul 2025 21:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752615730;
	bh=guZSpdsSKl3YawdSkJgYATxoiaL2pmIvs8uhCzKiB9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BEqwe/Kb0DhRjZq2j0U1+DBC1cNdamwTtpGrrd7qT87GjSS8y2mhHiM4biu1qyQgp
	 xJ3TNMT1j/pAJhLx2qv2IvBHSNgtb4M8LP/AXWaaj0k4B4QmHQ79rskGzY/Kd+XV4F
	 Wva9ZPmW5B9EyOlEgSWNRejkfzeXF99Zw7mi7OrF9IC+zXQ2/vyuTLo0Mk75B7Tew/
	 cdJwDhYr25xtyx46q4Cf0XvgfujttQGDsRVLNoJamb1PTWnyyQjYhiZw2T+w2xlaE5
	 zTi8XsJhXkYvEICXotpzqcCK938wfoh41n5Pq/3q3vP1cvAG0t05Ex2ToYJ3tIVCLG
	 N098WBs8yo4vg==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dad3a179so997472666b.1;
        Tue, 15 Jul 2025 14:42:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV71b5oIxckM3hq7sOvIJNMIO8SR084rjuSpkP1xN2G0AGlS0rSJ7rf/21Hc95n+5X9PE3Hcr8Y+kP87hOBZg==@vger.kernel.org, AJvYcCVkNEOKaFxz6juV7fq3WoSpM9X3z+0nAV2Tge4aTezxmHX5AGbIPRdNzUvulJCiszO56w8qeeTF1TmE@vger.kernel.org, AJvYcCWLbq9z0vUOCOZH007LIWPyl8tawWMT9KJw9QKyQfzm+yzIAqRVjpPw2ScxNM4QyIfQYM6vnZSS8Tfi@vger.kernel.org
X-Gm-Message-State: AOJu0YxztafTvzyx2KqaIg+qIuD7y0nWU9lsCgfN1QyQ2TNcT+AsfQWR
	2xWtTMBpDC4bvqdosG+VaNCqYzm7ebvjttdzSOOddhOxr3wFbnp5+ood/Xkf+Smuy2TEhtVniVq
	XGDaehUGa5+PA5W8J2nCRw7jRu0REiA==
X-Google-Smtp-Source: AGHT+IHk6W6e8djWeHYzn+8CUV4LV8uGMUKpxPq6AVlHjkreAUXtga07mMI0HX3Pd4JvMQBc4nDKswFGqoJez+XxEQI=
X-Received: by 2002:a17:907:c1e:b0:ae0:d201:a333 with SMTP id
 a640c23a62f3a-ae9c9aed1fbmr105692066b.30.1752615729077; Tue, 15 Jul 2025
 14:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ded76a-8bd7-43b5-932d-f139f4154320@oss.qualcomm.com> <20250701212604.GA1850816@bhelgaas>
In-Reply-To: <20250701212604.GA1850816@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Jul 2025 16:41:57 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+z+5_=YXiyCW1sbKDe0cjGNG7Qk=uRQ3efAFTd1J2ayQ@mail.gmail.com>
X-Gm-Features: Ac12FXyuoicKuvNm6HvWPrbRH78YKSuEAn2LB-taGjeNjInaSIyRSsZYTEiDvxY
Message-ID: <CAL_Jsq+z+5_=YXiyCW1sbKDe0cjGNG7Qk=uRQ3efAFTd1J2ayQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM
 compliant PCIe root complex
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mayank Rana <mayank.rana@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	will@kernel.org, lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	andersson@kernel.org, mani@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com, 
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com, 
	quic_nitegupt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 4:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Rob]
>
> On Tue, Jul 01, 2025 at 01:21:29PM -0700, Mayank Rana wrote:
> > On 7/1/2025 9:52 AM, Bjorn Helgaas wrote:
> > > On Mon, Jun 16, 2025 at 03:42:58PM -0700, Mayank Rana wrote:
> > > > Document the required configuration to enable the PCIe root complex=
 on
> > > > SA8255p, which is managed by firmware using power-domain based hand=
ling
> > > > and configured as ECAM compliant.
> > >
> > > > +    soc {
> > > > +        #address-cells =3D <2>;
> > > > +        #size-cells =3D <2>;
> > > > +
> > > > +        pci@1c00000 {
> > > > +           compatible =3D "qcom,pcie-sa8255p";
> > > > +           reg =3D <0x4 0x00000000 0 0x10000000>;
> > > > +           device_type =3D "pci";
> > > > +           #address-cells =3D <3>;
> > > > +           #size-cells =3D <2>;
> > > > +           ranges =3D <0x02000000 0x0 0x40100000 0x0 0x40100000 0x=
0 0x1ff00000>,
> > > > +                    <0x43000000 0x4 0x10100000 0x4 0x10100000 0x0 =
0x40000000>;
> > > > +           bus-range =3D <0x00 0xff>;
> > > > +           dma-coherent;
> > > > +           linux,pci-domain =3D <0>;
> > > > ...
> > >
> > > > +           pcie@0 {
> > > > +                   device_type =3D "pci";
> > > > +                   reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > > > +                   bus-range =3D <0x01 0xff>;
> > >
> > > This is a Root Port, right?  Why do we need bus-range here?  I assume
> > > that even without this, the PCI core can detect and manage the bus
> > > range using PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS.
> >
> > On Qualcomm SOCs, root complex based root host bridge is connected to s=
ingle
> > PCIe bridge
> > with single root port. I have added bus-range based on discussion on th=
is
> > thread https://lore.kernel.org/all/20240321-pcie-qcom-bridge-dts-
> > 2-0-1eb790c53e43@linaro.org/
>
> I think you mean
> https://lore.kernel.org/all/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e=
43@linaro.org/
> so I assume you're looking at the conversation at
> https://lore.kernel.org/all/20250103210531.GA3252@bhelgaas/t/#u.

That's all misguided...

> So I guess the answer to my question is basically "to shut up DTC
> check":

It's possible DTC checks are wrong, I wrote them.

>   Some DT for qcom,pcie-sa8255p might describe an Endpoint below this
>   Root Port, and the Endpoint's 'reg' property includes a bus number
>   determined by the Root Port configuration.
>
>   DTC check validates the Endpoint's bus number by comparing it with
>   the parent's 'bus-range', so it complains unless the Root Port
>   includes a 'bus-range' property.

The complication here is how flattened DT works compared to
OpenFirmware. In OF, bus-range reflects how firmware assigned bus
numbers. In FDT, bus-range should only be present if there are
restrictions in bus numbers. So for most h/w, there should be no
bus-range properties anywhere. This also means the addressing should
just set the bus to 0 everywhere and only the devfn part is relevant.
Also note that the unit-addresses don't have the bus number so that
the device paths are consistent. The dtc check only says if the parent
has 'bus-range', then the address (reg) should have a bus number
within that range. There's never a warning that 'bus-range' is
missing.

Rob

