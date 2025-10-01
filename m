Return-Path: <linux-pci+bounces-37358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201DBBB114F
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89711188720D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852020468E;
	Wed,  1 Oct 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqPCVFTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F141F03C5
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332849; cv=none; b=tFnuLFNG8hVXGpV1aaqZNBPjPiEVzBk4RxpLcWFq2FTv6V/mHxH2UOcwwrPXt4a4ahcXkGge38cbvcOHs/T09Ai9IFdawfztn3i6pdfAkYVZMTbDrGRPBCvQ84QFv9tVhV7ud+CJsmNACjgPQrZOjOmiECZQpRWQAv6XXdWEuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332849; c=relaxed/simple;
	bh=t+5oodR2WJ89UuewrgqF2t9gtUtjMDijBW3TB8kNAk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL5qUknu+WgL/6UsvC6euVi3kLbYMxjwjrjzr4m1sASyCB3tSknoa5MbaEePSSdGnf7JRBUv/wbPfW81aS9jwGbAk7uJDf9X4wkMovdwsOU2pv9xhDwTyX2zCoeY42/IyHN5gGWPxj0RYk7X4obvm2/GnHOXwvQO1E+p2hSbFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqPCVFTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C043C4AF0C
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759332849;
	bh=t+5oodR2WJ89UuewrgqF2t9gtUtjMDijBW3TB8kNAk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tqPCVFTynJONnF7xNecqWlPQkX1nanVmluWVaglGetbl8lXwFFIh7YHfq1h2iI2Wh
	 YT8Te7lMONjwYh2cxmbEQmUo31+seH30lTPApY5uiibFZMEszj1OeoBLXFpmQaCjKK
	 HuDXYKn0Z51kUb9cH68RaaWC1AmNXo3Zkso1+/4kn0vphGYDBmIEcpHo5TekRlBPLx
	 QXAHVFuSav2Ls0UMaIJMe/zEdCfRUWPxa2A9qIj2zA9yH/nTB6H4ZdwmB2/PuuO7pd
	 z77KRCWtyQSMp0xhvLqp9D2O+qo3xXPjNrZQORHHOW+j6ClXcWdNrjjzBTZCGC51kY
	 uXPyLKbOkjUFg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4539dddd99so1154766b.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 08:34:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOB65NsvP1cd2QA3nXacUNKe/2OfU65uhMqS8c+OtiqDy51mTpqQsDFvZu/Nutaltde60qf935FaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5q2DxbCB/M4KnocDWQFxEixjc6qiepdH++E1q+tt9CHkn2KG
	tafhBHT2rFNjg/jbcLsFMYKU8PHw5GZimOPOkaLka3IOMTT0gosP3Xc7eHlS3VnYav4qmm7AuYl
	FY5utjkDICNAaVotY2nj4AoUi/yYNHg==
X-Google-Smtp-Source: AGHT+IEDjD1QFaIHAE6AtoKL1XcfTfdfXJeMhpRYoI2QgQTpaRdosjYiVDpZeRAc/0K+l/wDiK57fn17gvANxESs9l4=
X-Received: by 2002:a17:906:1c15:b0:b48:549f:6d9e with SMTP id
 a640c23a62f3a-b4854aeb215mr10085766b.49.1759332847699; Wed, 01 Oct 2025
 08:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
 <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
 <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com>
 <CANAwSgTuX3t2-SNPe4OAzGuDpL5RotxX8t+Zx+gcwFKdj3ZEng@mail.gmail.com>
 <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com> <CANAwSgTKFSf-EUGSpErdS1Y93AwunFOK7omH4T+gE_z2XttVtw@mail.gmail.com>
In-Reply-To: <CANAwSgTKFSf-EUGSpErdS1Y93AwunFOK7omH4T+gE_z2XttVtw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 1 Oct 2025 10:33:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCPThkVhdTLPA_POn72LS16-e-TaRTiEYf+USYTFyNPQ@mail.gmail.com>
X-Gm-Features: AS18NWB8eFFyUEM-YcAGL07RUx2a3G2X2k8lVDyTqs54wImwsCWcRrCeTplqd6A
Message-ID: <CAL_JsqLCPThkVhdTLPA_POn72LS16-e-TaRTiEYf+USYTFyNPQ@mail.gmail.com>
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

On Tue, Sep 30, 2025 at 11:32=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
>
> Hi Rob
>
> On Tue, 30 Sept 2025 at 20:07, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Sep 29, 2025 at 10:25=E2=80=AFAM Anand Moon <linux.amoon@gmail.=
com> wrote:
> > >
> > > Hi Rob
> > >
> > > On Mon, 29 Sept 2025 at 19:19, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@gma=
il.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Thanks for your review comments
> > > > >
> > > > > On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrot=
e:
> > > > > >
> > > > > > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon=
@gmail.com> wrote:
> > > > > > >
> > > > > > > Convert the legacy text-based binding documentation for
> > > > > > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, =
following
> > > > > >
> > > > > > s/YAML/DT/
> > > > > >
> > > > > Ok,
> > > > > > > the Devicetree Schema format. This improves validation covera=
ge and enables
> > > > > > > dtbs_check compliance for Tegra PCIe nodes.
> > > > > >
> > > > > > Your subject needs some work too. 'existing' and 'bindings
> > > > > > documentation' are redundant.
> > > > > >
> > > > > Here is the simplified version
> > > > >
> > > > > dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings document=
ation
> > > > > into a YAML schema
> > > >
> > > > Still doesn't fit on one line and you say bindings twice:
> > > >
> > > > dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
> > > >
> > > Ok
> > > > >
> > > > > Convert the existing text-based DT bindings documentation for the
> > > > > NVIDIA Tegra PCIe host controller to a YAML schema format.
> > > >
> > > > s/YAML/DT/
> > > >
> > > > Lots of things are YAML. Only one thing is DT schema.
> > > Ok, understood.
> > > >
> > > > >
> > > > > > >
> > > > > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > > ---
> > > > > > > v1: new patch in this series.
> > > > > > > ---
> > > > > > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++++=
+++++++++
> > > > > > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 --------=
----------
> > > > > > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvi=
dia,tegra-pcie.yaml
> > > > > > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvi=
dia,tegra20-pcie.txt
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,teg=
ra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..dd8cba125b53
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie=
.yaml
> > > > > > > @@ -0,0 +1,651 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yam=
l#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: NVIDIA Tegra PCIe Controller
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > > > > +
> > > > > > > +description: |
> > > > > >
> > > > > > Don't need '|'.
> > > > > >
> > > > > Ok
> > > > > > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra2=
0, Tegra30,
> > > > > > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root p=
orts and
> > > > > > > +  platform-specific clock, reset, and power supply configura=
tions.
> > > > > >
> > > > > > I would suggest not listing every SoC here unless the list is n=
ot going to grow.
> > > > > >
> > > > > Here is the short format.
> > > > >   PCIe controller found on NVIDIA Tegra SoCs which supports multi=
ple
> > > > >   root ports and platform-specific clock, reset, and power supply
> > > > >   configurations.
> > > > > Ok
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    oneOf:
> > > > > >
> > > > > > Only 1 entry here, don't need 'oneOf'.
> > > > >
> > > > > I am observing the following warning if I remove this.
> > > > >
> > > > >  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> > > > > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,te=
gra-pcie.yaml
> > > > >   CHKDT   ./Documentation/devicetree/bindings
> > > > > /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicet=
ree/bindings/pci/nvidia,tegra-pcie.yaml:
> > > > > properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie=
',
> > > > > 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-p=
cie',
> > > > > 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
> > > >
> > > > Because you made 'compatible' a list rather than a schema/map/dict.
> > > > IOW, You need to remove the '-' as well.
> > > >
> > > Ok fixed.
> > > >
> > > > > > > +  nvidia,num-lanes:
> > > > > > > +    description: Number of PCIe lanes used
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > >
> > > > > > The examples show this in child nodes.
> > > > > yes it patternProperties example I missed this.
> > > > >
> > > > > patternProperties:
> > > > >   "^pci@[0-9a-f]+$":
> > > > >     type: object
> > > > >
> > > > >     properties:
> > > > >       reg:
> > > > >         maxItems: 1
> > > > >
> > > > >       nvidia,num-lanes:
> > > > >         description: Number of PCIe lanes used
> > > > >         $ref: /schemas/types.yaml#/definitions/uint32
> > > > >         minimum: 1
> > > > >
> > > > >     unevaluatedProperties: false
> > > >
> > > > What about all the other properties in the child nodes? You need a
> > > > $ref to pci-pci-bridge.yaml as well.
> > > Thanks for the input.
> > >
> > > patternProperties:
> > >   "^pci@[0-9a-f]+$":
> > >     type: object
> > >     allOf:
> > >       - $ref: /schemas/pci/pci-host-bridge.yaml#
> >
> > That's not the one you need. Read my reply again.
> >
> I'm sorry, I missed pci-pci-bridge.yaml
> > >       - properties:
> >
> > properties doesn't need to go under allOf. Actually, don't need allOf
> > here at all.
> >
> > >           reg:
> > >             maxItems: 1
> >
> > >           "#address-cells":
> > >             const: 3
> > >           "#size-cells":
> > >             const: 2
> >
> > These 2 are already defined in the referenced schema.
> Earlier, I had tried to search for these reference schemas,
> but I could not find them.

They are part of dtschema, so they are on your system wherever it is
installed. Most common schemas are in dtschema.

Rob

