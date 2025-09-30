Return-Path: <linux-pci+bounces-37260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC83BAD353
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749DF194093F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677DB2522A1;
	Tue, 30 Sep 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkRN56Td"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427221DE2BD
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243045; cv=none; b=hBUaVwkZbuMzM14Snl6ilEe8myual61SjiXJ+imlmDdhFn74Ws1kDsdWuUUwrzQCFrE61+VLJxejz3uMs5wYV0x+IRszshYIcBiEY5AIYqcboLTzMBVa8v4p8472uQZ9ZRj99N1FXbso1X1xV9Xx3b/u4dMP81kjyZLKs48HzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243045; c=relaxed/simple;
	bh=tv8tP3CbvwVbP03SYbdUFItd/4hYvZNZmJe7AJScMmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+CkRzEl+VIAhp1hZzMT0dEY3ddmYFVoY6voUQrEabZKQM3CX94uRMU9h9tzErTdJ4jl2W0kZTWgIt+BR9xcqVXQNVrymbktuDe/9TqfVhPPY2xYqgrrQQTtdK5Z+x3SJt+6tETR81KbE4ISygJ+iiV83BIXOGSqPVT03pbEPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkRN56Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F2AC116B1
	for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759243044;
	bh=tv8tP3CbvwVbP03SYbdUFItd/4hYvZNZmJe7AJScMmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CkRN56Td6SCuDMPQ18ZU2JIavowHvwXlGeNXcE4Pu8tuVn3e1qRJyRYaECvwrxUoc
	 YF15h6PZvs9Id8iUBeOOZxPeZTPArNGixSxZZioZgZdFYvwUNEPruOfLGLC72WcGt8
	 +7qDDhOconCwpRvM9AIOC/UWsQ/R9qt+Lil4XT/bm6QQJ3kecCrvE0Tt71vtg/g5Xy
	 gPdiSXTVVCwbRqS+ZV7DJQz4ctVnAjj0ZfmXoAbcvotnwwTBnTk38w1P/53DAXYS0D
	 h9TJQM1PdzRWb0utOd+jqjSeUDjHXwCgtShGoyho9rsa2jYFvgR52S8KZw6IisaTO5
	 5M6m6A0cOB9aA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so1178111966b.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Sep 2025 07:37:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7fgf2WuooJMg8jcydQqXTMwYOOny9h5OhTUAPbyUeZyp78aJ9NWhDh08ccfbR/jPLEePDTHNGWUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT1KdEF/8sXUZmImWtsk1RqXUQnZQopPPvYCQl9htAnyXitEf
	GzyGhbWwhirG62nYlk5afDVU63aHItuhKrSNGttQe2V0ec5tHwmiVxN7aUijC9L5r2M4fNOH/e1
	cBmtQHqJGBhrPAk8RlyB1qXr+QgJT4A==
X-Google-Smtp-Source: AGHT+IGgfxlodiz/IYQsAOQn6MLDa6csKlZJbZKJV75KAR1g4FNwPa42/5n0tcTx0LqLcbqk236kB6rAIkWIDfZAheg=
X-Received: by 2002:a17:907:d19:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b4631ce4b96mr125333766b.11.1759243043364; Tue, 30 Sep 2025
 07:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
 <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
 <CAL_JsqLsEDFv4T1ZMmjaoFfs7WNAjVvOk9o1eTXL2EeGF8uuDA@mail.gmail.com> <CANAwSgTuX3t2-SNPe4OAzGuDpL5RotxX8t+Zx+gcwFKdj3ZEng@mail.gmail.com>
In-Reply-To: <CANAwSgTuX3t2-SNPe4OAzGuDpL5RotxX8t+Zx+gcwFKdj3ZEng@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Sep 2025 09:37:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com>
X-Gm-Features: AS18NWCO_YKNXT00tTFZtChritiXVTRzlLdNG8gyHODI9fKqf3yCIJP6TlxUrps
Message-ID: <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com>
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

On Mon, Sep 29, 2025 at 10:25=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
>
> Hi Rob
>
> On Mon, 29 Sept 2025 at 19:19, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@gmail.c=
om> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks for your review comments
> > >
> > > On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@gma=
il.com> wrote:
> > > > >
> > > > > Convert the legacy text-based binding documentation for
> > > > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, foll=
owing
> > > >
> > > > s/YAML/DT/
> > > >
> > > Ok,
> > > > > the Devicetree Schema format. This improves validation coverage a=
nd enables
> > > > > dtbs_check compliance for Tegra PCIe nodes.
> > > >
> > > > Your subject needs some work too. 'existing' and 'bindings
> > > > documentation' are redundant.
> > > >
> > > Here is the simplified version
> > >
> > > dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings documentatio=
n
> > > into a YAML schema
> >
> > Still doesn't fit on one line and you say bindings twice:
> >
> > dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
> >
> Ok
> > >
> > > Convert the existing text-based DT bindings documentation for the
> > > NVIDIA Tegra PCIe host controller to a YAML schema format.
> >
> > s/YAML/DT/
> >
> > Lots of things are YAML. Only one thing is DT schema.
> Ok, understood.
> >
> > >
> > > > >
> > > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > ---
> > > > > v1: new patch in this series.
> > > > > ---
> > > > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++++++++=
+++++
> > > > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------=
------
> > > > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,=
tegra-pcie.yaml
> > > > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,=
tegra20-pcie.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-p=
cie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..dd8cba125b53
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yam=
l
> > > > > @@ -0,0 +1,651 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: NVIDIA Tegra PCIe Controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > > +
> > > > > +description: |
> > > >
> > > > Don't need '|'.
> > > >
> > > Ok
> > > > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20, T=
egra30,
> > > > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root ports=
 and
> > > > > +  platform-specific clock, reset, and power supply configuration=
s.
> > > >
> > > > I would suggest not listing every SoC here unless the list is not g=
oing to grow.
> > > >
> > > Here is the short format.
> > >   PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> > >   root ports and platform-specific clock, reset, and power supply
> > >   configurations.
> > > Ok
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > >
> > > > Only 1 entry here, don't need 'oneOf'.
> > >
> > > I am observing the following warning if I remove this.
> > >
> > >  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> > > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,tegra-=
pcie.yaml
> > >   CHKDT   ./Documentation/devicetree/bindings
> > > /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/=
bindings/pci/nvidia,tegra-pcie.yaml:
> > > properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
> > > 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pcie'=
,
> > > 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
> >
> > Because you made 'compatible' a list rather than a schema/map/dict.
> > IOW, You need to remove the '-' as well.
> >
> Ok fixed.
> >
> > > > > +  nvidia,num-lanes:
> > > > > +    description: Number of PCIe lanes used
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > > The examples show this in child nodes.
> > > yes it patternProperties example I missed this.
> > >
> > > patternProperties:
> > >   "^pci@[0-9a-f]+$":
> > >     type: object
> > >
> > >     properties:
> > >       reg:
> > >         maxItems: 1
> > >
> > >       nvidia,num-lanes:
> > >         description: Number of PCIe lanes used
> > >         $ref: /schemas/types.yaml#/definitions/uint32
> > >         minimum: 1
> > >
> > >     unevaluatedProperties: false
> >
> > What about all the other properties in the child nodes? You need a
> > $ref to pci-pci-bridge.yaml as well.
> Thanks for the input.
>
> patternProperties:
>   "^pci@[0-9a-f]+$":
>     type: object
>     allOf:
>       - $ref: /schemas/pci/pci-host-bridge.yaml#

That's not the one you need. Read my reply again.

>       - properties:

properties doesn't need to go under allOf. Actually, don't need allOf
here at all.

>           reg:
>             maxItems: 1

>           "#address-cells":
>             const: 3
>           "#size-cells":
>             const: 2

These 2 are already defined in the referenced schema.

>           nvidia,num-lanes:
>             description: Number of PCIe lanes used
>             $ref: /schemas/types.yaml#/definitions/uint32
>             minimum: 1

I assume there's a maximum <=3D16?

blank line here and between all DT properties.

>         required:
>           - "#address-cells"
>           - "#size-cells"

These 2 are already required in the referenced schema.

>           - nvidia,num-lanes
>     unevaluatedProperties: false
>
> > Rob
>
> Thanks
> -Anand
>

