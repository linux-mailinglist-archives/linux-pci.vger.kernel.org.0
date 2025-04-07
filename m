Return-Path: <linux-pci+bounces-25420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B312A7E7A9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0318D1895A7C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDE215767;
	Mon,  7 Apr 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQVL1rTf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A712139CB;
	Mon,  7 Apr 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044940; cv=none; b=PJBEqKpXIQoD6+NYCr4MfnEsK5qTTWesE/+FSK4QxApuRdDkAjakS46JwWPjkwcv3wVMiOkcY/q/LAKyyn/g0n+F7hhqwBepnOf0A1XBE+6+t+BnsqdyFjE9PRLL236nFkPUS1bjqF3qSGDqKVm3p0lKeC/4m7lDo+Vg7c/rO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044940; c=relaxed/simple;
	bh=c2MKD/XKzSiKwW1/i7FUqEHwziXv/iFw3B4sgnw+bVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGvwC1iWRdpDdxAiQqISWK2Pf1eZPnT0iHKTunFhzqvobsNTLHZxiVb6rK/Qf+GX9D0unhSQfIdEHcVqbTVJoLAhwfoFXPB4t2vywz9tsx7jaMVNCmK0H3VpUqokoSViN4hgPL9cHqZ/WW4Xg2DCeV4tu0h1wrRI6SQCSWCQItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQVL1rTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711ACC4CEDD;
	Mon,  7 Apr 2025 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044940;
	bh=c2MKD/XKzSiKwW1/i7FUqEHwziXv/iFw3B4sgnw+bVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KQVL1rTftG/IrWL4PFKeSt7oXv+clC6wbH1FSt6Bj77JqHtLrM/hnt7aWZmW4wXon
	 HLJRMDdpXpLLwDKLl5UmTY4SGrRs47B77ktvFr5gDteoMJ9uNcFaUYQiaJkJDAi7MB
	 zQPS/cg3YmSmHJZ1saJtvolhumMVX4njdRpx/JGlN5XJ4uOQwPD5EhQIZfK3RiLS70
	 2bWFDwAhmT4wHItUiPJqIX4PRsgTPgR33opXSGJzH2ki2V3lewuHLDt4E/pmtwQjee
	 Mbc82pPT5RNDvOWbjufOcRjlS5i6OdcS5N3Fjv+E3fhlkDsXoNlFS563wCLkudZ+px
	 2d81T/08DtAIw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2c663a3daso870057166b.2;
        Mon, 07 Apr 2025 09:55:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5lTIA3t7z/hmjvTQXKrkrrxPMsxtswK5bNrNUKH40XPPwyHUQnzKU8w6iFheZ1HzMvTGlDK6dklmen/s=@vger.kernel.org, AJvYcCUFXTi5moF+eSUr9Om5pt7NOcYPBx26Ye9Z3R8z82B++Do66MFTAVdnUldvrvKPyUa2zbbjhhWUlv9Q@vger.kernel.org, AJvYcCVYnNiiuqALmXyBCL7C4AYWx2Mhtt1O5zGFSsk+0aD9VKhcLehPM8J/Bns7d4JC75vrUFL997WHBRY+za7c@vger.kernel.org, AJvYcCVmfvcII28cpv57NN7ejB3RBU3nWATfnHFx8ju22qEP/gxyPEQ2lUKmqg16Cu/z6iy9LGY7LpQAX6PS@vger.kernel.org
X-Gm-Message-State: AOJu0YwRp2YXTNz1yA8uBTLrJRss6lKPS3uN/0x8XSI9FPcPwOvaMamb
	BfFvdq/ypvZN1grqtaqjj0rEBt9ygs8+NhYc7iHFxFR2whL+apSZJXKKq2FFg+h9KGsDQ9ukGNr
	w1V7Cquw1T1dwTWYNDQiIDzV/1Q==
X-Google-Smtp-Source: AGHT+IEd0KrgFqiXEguYCKaGod1w87MoHOUslXzG8mwe6sn3+lvNHY/R8wCVUd9TUz9Kf+cBq/nGYese5yv4O8hDda0=
X-Received: by 2002:a17:907:a4d:b0:ac7:3456:7ece with SMTP id
 a640c23a62f3a-ac7d1b28752mr1313800366b.46.1744044939101; Mon, 07 Apr 2025
 09:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404221559.552201-1-robh@kernel.org> <174380891321.749968.3085053836966154334.robh@kernel.org>
In-Reply-To: <174380891321.749968.3085053836966154334.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Apr 2025 11:55:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+i012pE2vrSWc-Tro58aAEZY4xe5n-LcoqN1RWES6RQ@mail.gmail.com>
X-Gm-Features: ATxdqUFAzIqfYAmbp0OPypTNYKPyZk-fHySvRwAg51LjL3xBt7FwP5p8N5-z_nU
Message-ID: <CAL_JsqL+i012pE2vrSWc-Tro58aAEZY4xe5n-LcoqN1RWES6RQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.li@nxp.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 6:21=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Fri, 04 Apr 2025 17:15:57 -0500, Rob Herring (Arm) wrote:
> > The content in these files has been moved to the schemas in dtschema.
> > pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> > pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> > msi-map property in pci-host-bridge.yaml.
> >
> > Cc: Frank Li <Frank.li@nxp.com>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   2 +-
> >  .../devicetree/bindings/pci/pci-iommu.txt     | 171 --------------
> >  .../devicetree/bindings/pci/pci-msi.txt       | 220 ------------------
> >  Documentation/devicetree/bindings/pci/pci.txt |  84 -------
> >  4 files changed, 1 insertion(+), 476 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci.txt
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
>
>
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/virtio/pci-iommu.yaml referenc=
es a file that doesn't exist: Documentation/devicetree/bindings/pci/pci.txt
> Documentation/devicetree/bindings/virtio/pci-iommu.yaml: Documentation/de=
vicetree/bindings/pci/pci.txt

I've fixed this with this[1] patch.

Rob

[1] https://lore.kernel.org/r/20250407165341.2934499-1-robh@kernel.org

