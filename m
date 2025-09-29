Return-Path: <linux-pci+bounces-37200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED4BA9695
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C091921109
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCE2AD24;
	Mon, 29 Sep 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChFsUBXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6062306D57
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153740; cv=none; b=HX1M8d4EF+X038dtIYdIOODulRKwFQt/6v4dHENw2T3LfLInxskYXbqoDUax0VqOhHJ0n4Xp//5dGzuikeYRY1FbGaIm9aQKb17K1j9fb4ueuvcWukDd7vxXRdiNHsVW5o972i3YVsP2S3Sk70a5Cjw0NagCeDP12xFtIC6Joko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153740; c=relaxed/simple;
	bh=UMhXzzOUFx5OVA5APFYm6wVdOFYJfiFDk0hdKAQMemU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9HgKrSuOysoh5bQnSf/IR98KGZBW5SCrjtIKqqsLBkyCltAV4K0m80vsm5PutcqeTgvuzGVt9R7GDswQVA6DZOtQyYqE0HfXt5BEvQXPDCkSSgRgttT24nuQG14s/9aTMKE95OlOsiCfyMS+gmEXr623S9PMmEHvICHTh/GDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChFsUBXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B840CC4CEF7
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759153739;
	bh=UMhXzzOUFx5OVA5APFYm6wVdOFYJfiFDk0hdKAQMemU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ChFsUBXAfmJ9duD7PypxJDnR5EfU3aOqzqY6pWB9R2ARXYCjGbhWGtYDwgM21ZSf1
	 zdHS2PRQaB1QX0pIN1n0OBeDITboPEXBKmUtGkoA1qagfx/xW2en7HV35W+VTx9i0R
	 VLMwrcoBmtNjWeVJp5ZL92D9VKQhtyT0kVOiLsHKHblofZ+Dx+D38SRTiO/azLYJ6W
	 mGeAPZF6phSRpXIy21fXgc1fty5fpWCDxJvMjJeExdDjqojW+9D5+6xQniy3bN6tVi
	 9Tg//avx4ODQRozm8nuXNm1exO2m4lkz0n4HZ1Ee+DXc+/FKdyRQXrloOHwMUnLabo
	 IOCdiohpyVzSA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so6783563a12.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 06:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3rZaqnskUZCIvlJuI9jMG0xcZYqUCqd/RHOJ3eH2OKEAPuE8AYPH2FE0mBNtZ9iqGykk8ITaHSKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEu55FFmCA5oAElxi3ivOoGt96nMl39BxoqLWPovtjKhq9+39
	iaCT9dgD84C4Xjt9A9FVOXRXAwfRvOcOCPSS0bkAw8tW9QW4k9YjrgepB+hGwjvNSAD2I4tO/11
	lcz1Lj4cuvJie3Tf4aC1NBeccnzYFwg==
X-Google-Smtp-Source: AGHT+IGp3P9nyueKP0M2BInqNV2Yp9Q8g79qJkdJ0eIQaWWP9lVHyb/0kaXduZAtR3IUytj5WfB2U3A52fbCay57ueY=
X-Received: by 2002:a05:6402:1e90:b0:634:9e1c:dec4 with SMTP id
 4fb4d7f45d1cf-6349f71301bmr15430745a12.0.1759153738337; Mon, 29 Sep 2025
 06:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
 <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
In-Reply-To: <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Sep 2025 08:48:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
X-Gm-Features: AS18NWDakHhHSWT3Jre9Ui6cjFqDPCfR0uwc3QfRpTuxBBAWT7q1IOrL5oK7MiE
Message-ID: <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Convert the existing
 nvidia,tegra-pcie.txt bindings documentation into a YAML schema
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Rob,
>
> Thanks for your review comments
>
> On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@gmail.c=
om> wrote:
> > >
> > > Convert the legacy text-based binding documentation for
> > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, followin=
g
> >
> > s/YAML/DT/
> >
> Ok,
> > > the Devicetree Schema format. This improves validation coverage and e=
nables
> > > dtbs_check compliance for Tegra PCIe nodes.
> >
> > Your subject needs some work too. 'existing' and 'bindings
> > documentation' are redundant.
> >
> Here is the simplified version
>
> dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings documentation
> into a YAML schema

Still doesn't fit on one line and you say bindings twice:

dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema

>
> Convert the existing text-based DT bindings documentation for the
> NVIDIA Tegra PCIe host controller to a YAML schema format.

s/YAML/DT/

Lots of things are YAML. Only one thing is DT schema.

>
> > >
> > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v1: new patch in this series.
> > > ---
> > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++++++++++++=
+
> > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ----------------=
--
> > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegr=
a-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegr=
a20-pcie.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.=
yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..dd8cba125b53
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > @@ -0,0 +1,651 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVIDIA Tegra PCIe Controller
> > > +
> > > +maintainers:
> > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > +
> > > +description: |
> >
> > Don't need '|'.
> >
> Ok
> > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20, Tegra=
30,
> > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root ports and
> > > +  platform-specific clock, reset, and power supply configurations.
> >
> > I would suggest not listing every SoC here unless the list is not going=
 to grow.
> >
> Here is the short format.
>   PCIe controller found on NVIDIA Tegra SoCs which supports multiple
>   root ports and platform-specific clock, reset, and power supply
>   configurations.
> Ok
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> >
> > Only 1 entry here, don't need 'oneOf'.
>
> I am observing the following warning if I remove this.
>
>  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,tegra-pcie=
.yaml
>   CHKDT   ./Documentation/devicetree/bindings
> /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bind=
ings/pci/nvidia,tegra-pcie.yaml:
> properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
> 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pcie',
> 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'

Because you made 'compatible' a list rather than a schema/map/dict.
IOW, You need to remove the '-' as well.


> > > +  nvidia,num-lanes:
> > > +    description: Number of PCIe lanes used
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > The examples show this in child nodes.
> yes it patternProperties example I missed this.
>
> patternProperties:
>   "^pci@[0-9a-f]+$":
>     type: object
>
>     properties:
>       reg:
>         maxItems: 1
>
>       nvidia,num-lanes:
>         description: Number of PCIe lanes used
>         $ref: /schemas/types.yaml#/definitions/uint32
>         minimum: 1
>
>     unevaluatedProperties: false

What about all the other properties in the child nodes? You need a
$ref to pci-pci-bridge.yaml as well.

Rob

