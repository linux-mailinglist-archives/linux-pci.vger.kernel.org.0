Return-Path: <linux-pci+bounces-19183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDBA00040
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 21:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BB13A32AF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 20:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8261A2543;
	Thu,  2 Jan 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXDP6Ggu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E571C36;
	Thu,  2 Jan 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851368; cv=none; b=ZNeoxj5/W7fD4gzIsJKoH1knnbHvC2qv7KbISO+zAdsT8VeeOXsleH0ZLJ0q7wej4oDCuLJrmcz7Wynq6jm2CGcBegtBJnbUXgVHLsHGV1f8fbVTjVG9lUm2YE0qgdc/K1oSw4IEhPveNyVBBtr5gNfByKUj6xpnwu9hv2BdCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851368; c=relaxed/simple;
	bh=a0QfaE5pQxC6vlHdUKC7SuIHrZ6UIYAnTRzLKGxuMYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGnXxWY+oDjnIa7BKwFHw+/yhgGy8/hvww+uzpthvxWmy7q6NdiP7JQLTdobhEpTMWd8LcrT03cMiDRCAO2LpS9tH7lUgwO0w4N90fAD/bSAYsmf9FkQfDuY0koGCy7Gi4LlLKl/exq2gkUUHrKMUETDBM1W7ygI89568aYdg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXDP6Ggu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3C9C4CEDF;
	Thu,  2 Jan 2025 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735851367;
	bh=a0QfaE5pQxC6vlHdUKC7SuIHrZ6UIYAnTRzLKGxuMYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AXDP6GguHr55H/5CooFsp4XmuUjdizppyvL4IgBHfpWdxbGKOmDp734Axv6A760Mu
	 ePCqO6Q/d7uL9kO0Ii3IxeDIGBzPMTMvrIjQE2buE5L+qwTRSGsq6LbM/bnYl9xEvG
	 NHnJy8s1bqkBDcfnjP/UL3yBbDJepJxWPsWFJEzmkZHsMzw8xol1kH76eZJgnmKgfS
	 pS4WLRkHUtsOn1vcZkT7Peb4H6YYIsqE9RzSUxunoYHdlX0enqQ7pmyiiVXKsG2/nv
	 rntOGR1IeFvy9AGrebRSO8Ifv/yeXllxnyOl/HNzazCVHqNQkqgRI3y2ITfEWWGImy
	 +tcNZMtuNpdog==
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e4a6b978283so15753598276.0;
        Thu, 02 Jan 2025 12:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUABgr8dw4W/1VpJAvWHLoCGOhqkpQlYOWeFLSLzOKC7uVowHgB1p32Uqdf843q0mkwk31NmGrRfVc4@vger.kernel.org, AJvYcCUhGJxmSfeu6CHrJy/PcGUGow9sS1ayWbVE6sL+xIeZ7vjPf72wwmfzRK6K1so6f/Li0F6KWy8H1B6q@vger.kernel.org, AJvYcCV9i9kEVMNdVpzFBulHDp1bsUbZ3NK4cao7AMmwNbqY5XBiW+GKbt2SIyNznqynfuQ5MPRJXlzaTlEorY+S@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZzfEi9HmrTPrls1aBZKnF5FbYPDBO4YUWMovEdI2mYlWhbv3
	znrvo6qTAJxABRWXfClD5n1P9z3ej6219bi32A5tORQNfmFvBhIVEFS0yoaYyEmrvST3omxC9Op
	MY6IxMofx9vMZa4Hfi6HMXVmfnA==
X-Google-Smtp-Source: AGHT+IHtj7cfz+hI1abCkQt2vX9gx6KrcNx8cTdb6ZxAx+0QmvAHWd0hN+xY+1v1vIK146ymrQJx+TnN5gMSTiz0v2Q=
X-Received: by 2002:a05:690c:6908:b0:664:74cd:5548 with SMTP id
 00721157ae682-6f3e2a65668mr376448997b3.1.1735851366905; Thu, 02 Jan 2025
 12:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <20241213064035.1427811-3-thippeswamy.havalige@amd.com> <20241217151040.GA1667241-robh@kernel.org>
 <SN7PR12MB72015F80356A44D225F6E3408B052@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB72015F80356A44D225F6E3408B052@SN7PR12MB7201.namprd12.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 2 Jan 2025 14:55:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHMVSu9fdiARMSpyVaCjOCvnP=mo74L-3_F3nVNK_O8w@mail.gmail.com>
Message-ID: <CAL_JsqKHMVSu9fdiARMSpyVaCjOCvnP=mo74L-3_F3nVNK_O8w@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2
 MDB PCIe Root Port Bridge
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kw@linux.com" <kw@linux.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, 
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:28=E2=80=AFAM Havalige, Thippeswamy
<thippeswamy.havalige@amd.com> wrote:
>
> Hi Rob,
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, December 17, 2024 8:41 PM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > manivannan.sadhasivam@linaro.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg;
> > linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; jingoohan1@gmail.com; Simek, Michal
> > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>
> > Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD
> > Versal2 MDB PCIe Root Port Bridge
> >
> > On Fri, Dec 13, 2024 at 12:10:34PM +0530, Thippeswamy Havalige wrote:
> > > Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> > >
> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > ---
> > > Changes in v2:
> > > -------------
> > > - Modify patch subject.
> > > - Add pcie host bridge reference.
> > > - Modify filename as per compatible string.
> > > - Remove standard PCI properties.
> > > - Modify interrupt controller description.
> > > - Indentation
> > >
> > > Changes in v3:
> > > -------------
> > > - Modified SLCR to lower case.
> > > - Add dwc schemas.
> > > - Remove common properties.
> > > - Move additionalProperties below properties.
> > > - Remove ranges property from required properties.
> > > - Drop blank line.
> > > - Modify pci@ to pcie@
> > >
> > > Changes in v4:
> > > -------------
> > > - None.
> > >
> > > Changes in v5:
> > > -------------
> > > - None.
> > > ---
> > >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++=
++
> > > ---
> > >  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++=
++
> > >  1 file changed, 121 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2=
-mdb-
> > host.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-ho=
st.yaml
> > b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > > new file mode 100644
> > > index 000000000000..c319adeeee66
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> > > @@ -0,0 +1,121 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> > > +
> > > +maintainers:
> > > +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: amd,versal2-mdb-host
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: MDB PCIe controller 0 SLCR
> > > +      - description: configuration region
> > > +      - description: data bus interface
> > > +      - description: address translation unit register
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: mdb_pcie_slcr
> > > +      - const: config
> > > +      - const: dbi
> > > +      - const: atu
> > > +
> > > +  ranges:
> > > +    maxItems: 2
> > > +
> > > +  msi-map:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  interrupt-map-mask:
> > > +    items:
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 0
> > > +      - const: 7
> > > +
> > > +  interrupt-map:
> > > +    maxItems: 4
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1
> > > +
> > > +  interrupt-controller:
> > > +    description: identifies the node as an interrupt controller
> > > +    type: object
> > > +    additionalProperties: false
> > > +    properties:
> > > +      interrupt-controller: true
> > > +
> > > +      "#address-cells":
> > > +        const: 0
> > > +
> > > +      "#interrupt-cells":
> > > +        const: 1
> > > +
> > > +    required:
> > > +      - interrupt-controller
> > > +      - "#address-cells"
> > > +      - "#interrupt-cells"
> > > +
> > > +required:
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-map
> > > +  - interrupt-map-mask
> > > +  - msi-map
> > > +  - "#interrupt-cells"
> > > +  - interrupt-controller
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    soc {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +        pcie@ed931000 {
> > > +            compatible =3D "amd,versal2-mdb-host";
> > > +            reg =3D <0x0 0xed931000 0x0 0x2000>,
> > > +                  <0x1000 0x100000 0x0 0xff00000>,
> > > +                  <0x1000 0x0 0x0 0x100000>,
> >
> > DBI space is 1MB? Last I checked, there's less than 4KB worth of
> > registers.
> Thank you for your feedback. I will reduce the size to 4KB, as the DBI sp=
ace primarily
> uses less than 4KB for its registers. Beyond this, the space includes por=
t logic registers,
> which can be safely ignored in this context.
> > The address looks odd. The config space is purely iATU configuration.
> > Really, we should have described the entire address space (like the
> > endpoint) available to the ATU. So the 1MB offset in the base
> > address seems like just that. Most h/w design to cut down signal
> > routing would put the base address for the ATU input at something
> > aligned greater than the size of the address space.
> In AMD (Xilinx) PCIe IPs, the configuration space for the endpoint typica=
lly starts after 1MB.
> To align with this, I initially set the DBI size to 1MB. However, conside=
ring the actual utilization of less
> than 4KB for DBI registers, this allocation I'll update in the next patch=
.
> >
> > > +                  <0x0 0xed860000 0x0 0x2000>;
> >
> > And then the DBI and ATU registers are nowhere near each other?
> > Possible, but seems odd.
>
> Thank you for your feedback. The DBI address provided in the device tree =
serves as
> one way to access the local ECAM space, which corresponds to a relative a=
ddress
> of 0xED840000.
>
> The internal IP uses the 0xED840000 address to configure all PCIe attribu=
tes.
> When accessing the address 0x1000_0000_0000, PCIe internally translates a=
nd
> implicitly accesses the 0xED840000 address.

Using the 0xED840000 address would be more aligned with how everyone
else accesses the DBI. If you support ECAM, then doesn't
0x1000_0010_0000 also correspond to the same registers in the DBI
space? Though I thought only the generic PCI config space registers
would be exposed there.

Speaking of ECAM, if that's supported, it would be better if the
driver used that (there's not any support in the driver for that). The
advantage would be you could skip reconfiguring the iATU on every
access. Ideally, the result would be utilizing what's in
drivers/pci/ecam.c. Not something that needs to be done in this
series, but you need to make sure the DT correctly describes the ECAM
region (seems like it should be large enough). The hisi driver does
this though it suffers from not handling devfn>0 on the root bus
correctly (also a quirk in the generic ECAM based driver for DWC based
implementations) and also needs 32-bit accesses to the root bus.

Rob

