Return-Path: <linux-pci+bounces-34757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C1BB3620F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 15:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD57BB3A8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39129D29D;
	Tue, 26 Aug 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSOiBNlX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B8238C07;
	Tue, 26 Aug 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213987; cv=none; b=U5N+Xf3mL0CgsA/fX9yNPrvj3uT2HUeXI+xZlN45aVfNohGPjBp28r4WlpJcilKkRgHZpQpB0EuEbMj0OQTEGwFshgTCHUySrd8JRd7oLld1T3PfOvgW+adYrl2B3AhFaUTgaO9IxcMDWEFS6jnb2rvL1WnJHHfS6/OgqPBYmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213987; c=relaxed/simple;
	bh=8Rs/KzG7jvMwItcdJJ435ArPOcL2peqcV5PN2CbYxgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fV6iO4x7bpKJksNSL1IbjH22VBfiETUya/00EEI7mLYE12Xydxhz5RHJ50qXRnIXyg1IhbaxVfjThoBAl/hfDVhnLeM1L53KPC0qD0OmbgI6swKnuXw0Za1Rzs6mATJXQGC75wwl8+DKoCDfxbx4kfRIDTMs91ZaWn6JoaXRt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSOiBNlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBBDC116B1;
	Tue, 26 Aug 2025 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756213986;
	bh=8Rs/KzG7jvMwItcdJJ435ArPOcL2peqcV5PN2CbYxgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WSOiBNlXpfNmbPywKaLsen/Ln/zE8ONmRBy0PtiQ4zh0R6guZtV7c4sdr0cCaP4p9
	 VPHR3oDdCNFCo6AuQKm4mIUg435tWL2+/MXXtiHxmx9pKvBApGO8mexxEi5MN/mgtK
	 GsCktvGa8zmPcqlvUwQLANujXJuwGWUTvhNlwuegUeK/2AWaMOvLau+yO/TiADFhh2
	 2w5pLkBcMw2v5j8URfSNPbxKm8iUPvCStz364vDBrNcNDsYriNCUp6mbjQ+hYbn5YQ
	 z1gI31TDmc4SahracFGzdAnf6OwZ1exX0HCwkfCv5DN+Vyf2BOarPgA5Bpmo4HW/zl
	 193NvIAIIYPPA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so752851166b.3;
        Tue, 26 Aug 2025 06:13:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCWE59ZZYAdDc4a1G2rTyyiTkErnN6Uoh4dRkIj0lMqlZuOAyzeQYivMxxg+UeB4sdXqACrGvMXRAQ@vger.kernel.org, AJvYcCVSC4RvvQSj6FJ46WHMdoT7cmhxogntOu/3zIiADdGAUcI2eib6O/kWj3wHPJLS7CbFm/zm0LvBru/4wCMbZA==@vger.kernel.org, AJvYcCWOVs8IlLQvzkk/QvmZXkYA2JPQpaBSjfeQE0pqJmRdPfGrYMpIb4BjqsewJDhX5B2uxSGwN+Oq/T5WRAlG@vger.kernel.org, AJvYcCWvda/rNxmG3pp15kYVIVgryD+EdiN7hrMJbzad2Jo6TMgorQAIZ2lfMZ1/RhSvuG/MDKLYfX8NS6kH@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGEyuhenI1V5z5WMYY8boWOEJ9sTHfz2rZHsA/j9udkIG30Sm
	OQWFrGC+jbg9Ox3jXNM/BrRJk3QBOhAN2FKpGmoghixXf/G4ZuEjGmeqT5YTN5KZPfRmBYLwpzz
	7KSdQYg893TXZYBiOaiC/fiw1UVRRqw==
X-Google-Smtp-Source: AGHT+IEG2XbEkRO5xnZYxC56oap2ApeXeEn+LTG8K4z8muNIvEWp3ReM3dmSHzLIW6gJLBWm5QfqGvxzSUrQ+JA/O+Y=
X-Received: by 2002:a17:907:6e8e:b0:af1:f259:254d with SMTP id
 a640c23a62f3a-afe28ec450fmr1281173366b.8.1756213985031; Tue, 26 Aug 2025
 06:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-4-4b74978d2007@oss.qualcomm.com>
 <20250822135147.GA3480664-robh@kernel.org> <nphfnyl4ps7y76ra4bvlyhl2rwcaal42zyrspzlmeqqksqa5bi@zzpiolboiomp>
 <20250825224315.GA771834-robh@kernel.org> <jqgvw3u6lkewaz2ycjkozcfqrmdln5gacgrog4lhioazhvk5yz@3ph2z25zwqvj>
In-Reply-To: <jqgvw3u6lkewaz2ycjkozcfqrmdln5gacgrog4lhioazhvk5yz@3ph2z25zwqvj>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Aug 2025 08:12:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+66jVM33oBCbCFjcZdd+veA-QKQRtG9iD6PP+8Bq7-Ug@mail.gmail.com>
X-Gm-Features: Ac12FXyxotUWYc0bYXHsCja7WJm4ZP4Tm5g0ZrX-FWoxMbdfgQ46x7AXHUeWNgE
Message-ID: <CAL_Jsq+66jVM33oBCbCFjcZdd+veA-QKQRtG9iD6PP+8Bq7-Ug@mail.gmail.com>
Subject: Re: [PATCH 4/6] PCI: of: Add an API to get the BDF for the device node
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:15=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Aug 25, 2025 at 05:43:15PM GMT, Rob Herring wrote:
> > On Fri, Aug 22, 2025 at 07:57:41PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Aug 22, 2025 at 08:51:47AM GMT, Rob Herring wrote:
> > > > On Tue, Aug 19, 2025 at 12:44:53PM +0530, Manivannan Sadhasivam wro=
te:
> > > > > Bus:Device:Function (BDF) numbers are used to uniquely identify a
> > > > > device/function on a PCI bus. Hence, add an API to get the BDF fr=
om the
> > > > > devicetree node of a device.
> > > >
> > > > For FDT, the bus should always be 0. It doesn't make sense for FDT.=
 The
> > > > bus number in DT reflects how firmware configured the PCI buses, bu=
t
> > > > there's no firmware configuration of PCI for FDT.
> > >
> > > This API is targeted for DT platforms only, where it is used to uniqu=
ely
> > > identify a devfn. What should I do to make it DT specific and not FDT=
?
> >
> > I don't understand. There are FDT and OF (actual OpenFirmware)
> > platforms. I'm pretty sure you don't care about the latter.
> >
>
> Sorry, I mixed the terminologies. Yes, I did refer the platforms making u=
se of
> the FDT binary and not OF platforms.
>
> In the DTS, we do use bus number to differentiate between devices, not ju=
st
> devfn. But I get your point, bus no other than 0 are not fixed and alloca=
ted by
> the OS during runtime or by the firmware.
>
> So how should we uniquely identify a PCIe node here, if not by BDF?

By path. Which is consistent since there is also no bus num in the unit-add=
ress.

Rob

