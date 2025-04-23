Return-Path: <linux-pci+bounces-26533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941BA98A48
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC3C5A4555
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791435957;
	Wed, 23 Apr 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiChBJcf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B0BA50;
	Wed, 23 Apr 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413353; cv=none; b=fBWq67fkM6SPuzkNRiEuDqc+4Sp+yXvxsZds/yMy5avlQMPUh1EOVUPGk5GZcd5kh88FZSjuOOEo7Po50oNahcfjoZ7fEE4r6ncs1vJXpE3yS+F+y11VH9ZMU+aF87W/F2k35S/K43BQC9sij1U3C6bOOyfb4WZUDbtkxdEHdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413353; c=relaxed/simple;
	bh=PRh04SSEpvmrrEMEKu0f4KPtxIFVTGV6VTf/pzMW9PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlvidII7kXfjeWRF9Nh5I7jcZmoVq070N+BrMBUylvI7ZbmSneZg+y59fVhypZMWqyufqsXUle0yLSYnJazUUaJJn92v79zTXiLtd6rC0nDQuizGNgmaFZMsgp6ptoDL7h9i34N6lu+eEec2NCK6OKMup1kj9DPLWOZaqGRO4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiChBJcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF65C4CEEF;
	Wed, 23 Apr 2025 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745413351;
	bh=PRh04SSEpvmrrEMEKu0f4KPtxIFVTGV6VTf/pzMW9PA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hiChBJcfIDyoFjpXxQdz1+1BR4jg6JOMZGSbKXW6TXNLPw2rYfwumxvuzKYG94mTb
	 SI4L8WXEL/31FefubR4SpbWJnLxEr/Ifyluy5Qr9xR2dwOloKL3cjtCFYQQe5AahdQ
	 S3i4GYq4FgbdFZ0p2MaSq4zsrvoxD8lIdwKdKiw6PSjhtZZZtjcAOCct3uQfQInJbx
	 c8SIgJZpXJXA5H9qlA77V8tRA0gAiVjN7ZxRdkyDatShvZYY9GKlZAcqL52/B0nWfF
	 jOdB3JEbAHJ1h4BtH2DRnmSwMdUUl8GM4wh0S5ehjSRHgPkMbaznUOyYpomKM9OWtY
	 k6l7EYb2n/anA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54b10956398so1176217e87.0;
        Wed, 23 Apr 2025 06:02:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1jPavYpdfF4pXOF0a0INYi9Nj8WU9FYcanDamHy3/eOnpKrL2Dol0uUllC7QTKFDuyY9F0YGsE0zfEdKl@vger.kernel.org, AJvYcCWwhAB/6MKkvXQHObGMjZNZ+GEcVGbFMULh3z5FgwWILqF4VGforMQrdRMGk0kRSkWmL4vflDfu3STvBhk=@vger.kernel.org, AJvYcCXASmTBXBIap7zTgOOxZut0qzJCzeliqByaK2jdIPDZQg9Uz6arFKqy6dzjJUHv8aSxqvm1edIemUGr@vger.kernel.org, AJvYcCXwYTPmYyBDonVGIYOWDSXhn7rfP7rgRarGgBdcNlI6C/HKZ4A4MtWzOcKOsTmjvkrbOdSWkwaQ9buw@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0JBRaTFecRBWQtHuI2okC7r8uzZRhicqTwzNfTsu3nEUxtfD
	zEA5NTrDlgwXqpWTyqoetrmYjErXqzVNlKpUtVOuqMGUkTNmHM9aFfzC2GV4kWDpjPdlHyKdPsI
	5A23eQq6ffgSeC3o4zIzl63oBsw==
X-Google-Smtp-Source: AGHT+IFF61cNsysSViFU5Q1HGHd+IghJ6rm0yOqybKjpeUhaBtp/MtfvNvuL2E7bT+y7AYWOaIXE3wXMBX9+129E39Q=
X-Received: by 2002:a05:6402:42c9:b0:5f4:c7b5:fd16 with SMTP id
 4fb4d7f45d1cf-5f6cf41b4b2mr2527881a12.6.1745413338544; Wed, 23 Apr 2025
 06:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404221559.552201-1-robh@kernel.org> <20250422171830.GA335614@bhelgaas>
In-Reply-To: <20250422171830.GA335614@bhelgaas>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Apr 2025 08:02:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLS8qfRRRQ-FEirqo6FGWD4ypU5_=uc1mVu_U_Voga1=w@mail.gmail.com>
X-Gm-Features: ATxdqUGDmT6Oa9be3YThQJN1rEFFXXEIWZljvkTyKuzEsju7EEKCXD71GZrP2u8
Message-ID: <CAL_JsqLS8qfRRRQ-FEirqo6FGWD4ypU5_=uc1mVu_U_Voga1=w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.li@nxp.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Jean-Philippe for virtio dangling ref]
>
> On Fri, Apr 04, 2025 at 05:15:57PM -0500, Rob Herring (Arm) wrote:
> > The content in these files has been moved to the schemas in dtschema.
> > pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> > pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> > msi-map property in pci-host-bridge.yaml.
>
> I guess "dtschema" refers to
> https://github.com/devicetree-org/dt-schema?

Yes.

> I kinda wish there was some direct link from the Linux kernel source
> to dt-schema where all this information now lives (Requester ID
> format, iommu-map, msi-map, linux,pci-domain, reg (and reference to
> IEEE Std 1275-1994), interrupt mapping info, external-facing, etc).
> Being a DT neophyte, I need all the help I can get ;)

Links to each property wouldn't really scale. Might as well copy all
the common schemas into the kernel tree at that point.

I've thought about some tool to look-up the info. It would be easy
enough to write. I'm just not sure what's useful to folks and what the
interface should look like. It could be something like this:

$ dt-info iommu-map
schema file: path/to/schema.yaml
type: uint32-matrix
description:
 blah blah

But maybe that needs to be "dt-info property <prop>" so we could also
do "dt-info compatible <compat>".

>
> There are a few dangling references to pci.txt:
>
>   Documentation/devicetree/bindings/pci/aardvark-pci.txt: - max-link-spee=
d: see pci.txt
>   Documentation/devicetree/bindings/pci/aardvark-pci.txt: - reset-gpios: =
see pci.txt
>   Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:- bus-range: s=
ee pci.txt
>   Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:  1275-1994 (s=
ee pci.txt) with the following restriction:

If no one cares enough to convert these, then I don't think the link matter=
s.

>   Documentation/devicetree/bindings/virtio/pci-iommu.yaml:      zero. See=
 Documentation/devicetree/bindings/pci/pci.txt

That's fixed in my tree already.

Rob

