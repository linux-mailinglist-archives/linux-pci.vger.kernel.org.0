Return-Path: <linux-pci+bounces-37368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F95BB18A1
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 20:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2204A1F1F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03DB2D59FA;
	Wed,  1 Oct 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+aoQUWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D612D6E51
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345044; cv=none; b=bNu9JY0VLNtRLcxwnafXhICCLnRamRBFO3ptmWCJBIVxgb96L2x7jQpdHTiXV2UVMLD1yy/b8V42nPg4GF1BjyZuRcKPHghdjrk64HFsuSBrMTFMMYHRlFGdhle3bgQ6Oit6Dc2+Z0VgnsYet+flfwVs5jfd5N1PbTgVI85+etA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345044; c=relaxed/simple;
	bh=MMybpxGWCbBgve52l5mPOu9P+yIWJ6nBBYL5Mb2Kwmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMMUldl5jT4eFW8e+9F5cWH/r+Z/bzMwS9nOyy2eDIXX8od5Xw52aYHz6oKkKnnJU5OAGPlN8JTmjmcrYIRdKwrJ01e6qPHnk4rHCFzUsKbxy2Aq3km2esiOF58V0e+b/6EPuC7y8JPDlTmvnn8wKqu4I/vHZ+PI7Rv1/7nbcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+aoQUWr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso475637a12.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759345041; x=1759949841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoX3igMAB21gentWFZhiiyfl1G4d2d3BMnfktxV5lXY=;
        b=X+aoQUWrZMl73IohcuAFyaIFbS/MKhryFCpPBrHQdjKNcM8iLKP5A3glGnujVRNA5O
         Byxed9hvDLigB8MAyIhytIg28tqkCK1SPcZjYtWE4//T6ZYnox9cmdMquNjAgMaXZW4J
         5SNfBZoduX/sivbHW0bcV+hDoFD5CFGwfvk0E12WGnw2xxakyMHtFvroCmsSGH5tEAwN
         kt+5nDIYLFXZq16IBBGe2Z3jzJlmKVPH6hEA6dmWJHbrJi8PAAtPwrBDM0MzUAn2heRv
         mqFTrRH72xdwyZpTRaKnAa0JuJF2D6uU1SLaIzWSqLjuttG27kvLrftObiuCW8nuGmeS
         PDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345041; x=1759949841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoX3igMAB21gentWFZhiiyfl1G4d2d3BMnfktxV5lXY=;
        b=ucUpnO/zz1U4VFa77gc0vp7O0mEl+aHrsRfTL/6bHnALrlNMIf6eimlJ3UXuylvKxf
         vaFbI1d/XxwrYkVwH+cHk+CDMh/Vc6nWn+qmMPVjM6HAZvqtHH6atMScmNbDl0MmhERT
         lGO0IIb8lmYw1PP0hW+Du3B3gWx0aYD2FjvHUstvK8FbnrHb3bvKD1K6GXOd8G9Xdxq8
         f+VFZsvJvuMAit2Vg2zrogYlzJUIrft91gsJyMTtsxD3eOvX1gTR4ZAdv6AH/PWTlGOV
         g77ZsloQukgwHkOEGwZ8fn6Z8etUw8sayBkZ5zCuiulWcw/nLPrcACG5a38oSmguNpgL
         3goQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdTDPMkoWf58SE55YVHlFfNIqjIRIzPiM3bsXu//jd5t7MDLdLKsoxtb/ADH+VWl6EVBW5D2NMjnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNXFmytBB9Ausb+TymkRirnJsR0ouuMwCiO2TXySwmLj9SDGZ
	eOjKBlEMdFB9gN8O5usosqpWKu+e0znVXfqT4FWiyBtmaEbzG6AlQsvvPaDGuC5YgwccwewMqSj
	WPlQTlMgNmeDeDU/t63uo+GjdU1z4dNI=
X-Gm-Gg: ASbGncvEQE8tHrNhT7kMmcP2uBZvu2jWN5tjCPx5mC3MV5ogAfshoI2bjdpkK6UzBiL
	fcmMXCNUGNHmCCfarJRxVH2QXL8tIVAViagy8XUhX3u3N93aCSwjltKI1MZsSVKqTz5I4/ZWJsz
	oSVXLzYEcEy3rYW5DliBcrj76LkdGlFoXHXq8aGAYWW7PVXBWRD6Cd+Lf/UIAW4Ipoxctm3jnkd
	D+2DE8wOIj4bNwMsnJdXyToMwOU3WKXw8KNRB4N
X-Google-Smtp-Source: AGHT+IGjZ/28ZD/9gb9yV5xN5I9eaIlMrP2dqIQmyLTpOWcXkwMpZirOBMDTOcsveRN3Fu86Dh/yn07ZPVnpzj22vHw=
X-Received: by 2002:a05:6402:2106:b0:636:6489:4db3 with SMTP id
 4fb4d7f45d1cf-63678c0e08emr5185166a12.1.1759345040725; Wed, 01 Oct 2025
 11:57:20 -0700 (PDT)
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
 <CAL_JsqKBhzPwxYguy+N=eddG2nwB54dzw307A6KT5NJpRSh-Mg@mail.gmail.com>
 <CANAwSgTKFSf-EUGSpErdS1Y93AwunFOK7omH4T+gE_z2XttVtw@mail.gmail.com> <CAL_JsqLCPThkVhdTLPA_POn72LS16-e-TaRTiEYf+USYTFyNPQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLCPThkVhdTLPA_POn72LS16-e-TaRTiEYf+USYTFyNPQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 2 Oct 2025 00:27:04 +0530
X-Gm-Features: AS18NWDE6lCO0n2IZ5w2RYV16F7fO6b4TX6QJWqMWLEqNsqSCGU_rf7Tga7xbxk
Message-ID: <CANAwSgTP+gK_nwADx8PpJt8-T4ZtViKorq1fuPmDnA3fLkaSFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Convert the existing
 nvidia,tegra-pcie.txt bindings documentation into a YAML schema
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, 1 Oct 2025 at 21:04, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Sep 30, 2025 at 11:32=E2=80=AFAM Anand Moon <linux.amoon@gmail.co=
m> wrote:
> >
> > Hi Rob
> >
> > On Tue, 30 Sept 2025 at 20:07, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Sep 29, 2025 at 10:25=E2=80=AFAM Anand Moon <linux.amoon@gmai=
l.com> wrote:
> > > >
> > > > Hi Rob
> > > >
> > > > On Mon, 29 Sept 2025 at 19:19, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Mon, Sep 29, 2025 at 2:40=E2=80=AFAM Anand Moon <linux.amoon@g=
mail.com> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > Thanks for your review comments
> > > > > >
> > > > > > On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > >
> > > > > > > On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amo=
on@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Convert the legacy text-based binding documentation for
> > > > > > > > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema=
, following
> > > > > > >
> > > > > > > s/YAML/DT/
> > > > > > >
> > > > > > Ok,
> > > > > > > > the Devicetree Schema format. This improves validation cove=
rage and enables
> > > > > > > > dtbs_check compliance for Tegra PCIe nodes.
> > > > > > >
> > > > > > > Your subject needs some work too. 'existing' and 'bindings
> > > > > > > documentation' are redundant.
> > > > > > >
> > > > > > Here is the simplified version
> > > > > >
> > > > > > dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings docume=
ntation
> > > > > > into a YAML schema
> > > > >
> > > > > Still doesn't fit on one line and you say bindings twice:
> > > > >
> > > > > dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
> > > > >
> > > > Ok
> > > > > >
> > > > > > Convert the existing text-based DT bindings documentation for t=
he
> > > > > > NVIDIA Tegra PCIe host controller to a YAML schema format.
> > > > >
> > > > > s/YAML/DT/
> > > > >
> > > > > Lots of things are YAML. Only one thing is DT schema.
> > > > Ok, understood.
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > > > ---
> > > > > > > > v1: new patch in this series.
> > > > > > > > ---
> > > > > > > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 ++++++=
+++++++++++
> > > > > > > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------=
------------
> > > > > > > >  2 files changed, 651 insertions(+), 670 deletions(-)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/pci/n=
vidia,tegra-pcie.yaml
> > > > > > > >  delete mode 100644 Documentation/devicetree/bindings/pci/n=
vidia,tegra20-pcie.txt
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,t=
egra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.ya=
ml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..dd8cba125b53
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pc=
ie.yaml
> > > > > > > > @@ -0,0 +1,651 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.y=
aml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: NVIDIA Tegra PCIe Controller
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > > > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > >
> > > > > > > Don't need '|'.
> > > > > > >
> > > > > > Ok
> > > > > > > > +  PCIe controller found on NVIDIA Tegra SoCs including Tgr=
a20, Tegra30,
> > > > > > > > +  Tegra124, Tegra210, and Tegra186. Supports multiple root=
 ports and
> > > > > > > > +  platform-specific clock, reset, and power supply configu=
rations.
> > > > > > >
> > > > > > > I would suggest not listing every SoC here unless the list is=
 not going to grow.
> > > > > > >
> > > > > > Here is the short format.
> > > > > >   PCIe controller found on NVIDIA Tegra SoCs which supports mul=
tiple
> > > > > >   root ports and platform-specific clock, reset, and power supp=
ly
> > > > > >   configurations.
> > > > > > Ok
> > > > > > > > +
> > > > > > > > +properties:
> > > > > > > > +  compatible:
> > > > > > > > +    oneOf:
> > > > > > >
> > > > > > > Only 1 entry here, don't need 'oneOf'.
> > > > > >
> > > > > > I am observing the following warning if I remove this.
> > > > > >
> > > > > >  make ARCH=3Darm64 -j$(nproc) dt_binding_check
> > > > > > DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,=
tegra-pcie.yaml
> > > > > >   CHKDT   ./Documentation/devicetree/bindings
> > > > > > /media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devic=
etree/bindings/pci/nvidia,tegra-pcie.yaml:
> > > > > > properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pc=
ie',
> > > > > > 'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210=
-pcie',
> > > > > > 'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
> > > > >
> > > > > Because you made 'compatible' a list rather than a schema/map/dic=
t.
> > > > > IOW, You need to remove the '-' as well.
> > > > >
> > > > Ok fixed.
> > > > >
> > > > > > > > +  nvidia,num-lanes:
> > > > > > > > +    description: Number of PCIe lanes used
> > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > >
> > > > > > > The examples show this in child nodes.
> > > > > > yes it patternProperties example I missed this.
> > > > > >
> > > > > > patternProperties:
> > > > > >   "^pci@[0-9a-f]+$":
> > > > > >     type: object
> > > > > >
> > > > > >     properties:
> > > > > >       reg:
> > > > > >         maxItems: 1
> > > > > >
> > > > > >       nvidia,num-lanes:
> > > > > >         description: Number of PCIe lanes used
> > > > > >         $ref: /schemas/types.yaml#/definitions/uint32
> > > > > >         minimum: 1
> > > > > >
> > > > > >     unevaluatedProperties: false
> > > > >
> > > > > What about all the other properties in the child nodes? You need =
a
> > > > > $ref to pci-pci-bridge.yaml as well.
> > > > Thanks for the input.
> > > >
> > > > patternProperties:
> > > >   "^pci@[0-9a-f]+$":
> > > >     type: object
> > > >     allOf:
> > > >       - $ref: /schemas/pci/pci-host-bridge.yaml#
> > >
> > > That's not the one you need. Read my reply again.
> > >
> > I'm sorry, I missed pci-pci-bridge.yaml
> > > >       - properties:
> > >
> > > properties doesn't need to go under allOf. Actually, don't need allOf
> > > here at all.
> > >
> > > >           reg:
> > > >             maxItems: 1
> > >
> > > >           "#address-cells":
> > > >             const: 3
> > > >           "#size-cells":
> > > >             const: 2
> > >
> > > These 2 are already defined in the referenced schema.
> > Earlier, I had tried to search for these reference schemas,
> > but I could not find them.
>
> They are part of dtschema, so they are on your system wherever it is
> installed. Most common schemas are in dtschema.
>
Thanks, it's preset in the .local dir.

$ .local/lib/python3.13/site-packages/dtschema/schemas/

> Rob
Thanks
-Anand

