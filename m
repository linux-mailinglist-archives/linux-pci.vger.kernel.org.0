Return-Path: <linux-pci+bounces-42864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D32CB0DE4
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 440D830B1DBF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA6303A04;
	Tue,  9 Dec 2025 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGqtTbR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36337302CC0
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306020; cv=none; b=EzfU2+r/ENAh24gj5KoWWazmeqQo/HRyYaCJJwdY0Kckk/bAvIG2/laV9u8nu+UtgPxFxg56Y5C5YmYH2+qsHlfR+9zDLfFpurdQEfNxpy8zZdMMHkmFEek3MNIFDc1ZaGvOIBBP0Kgde+I8H/YPzu8GZazAprVLHvCNcr7sVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306020; c=relaxed/simple;
	bh=RwOQrdvCZOCfPcXTjdfzp8hxiecKCqijW9ilAgKJgbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRQJvZ1E7/wV27JOc8Fb17+KHll7RQZfVRqj7yZQXePOKnAEQDkmOi/M+xGK3OReVbTax1nYOrRA/dNxJbFvCCqb/VQpfCsGT57Fc9P+eTRVOt0SIHCWywzJYpEqeGlL+KJfeLr8d5Thur3QzRUwAL/Z2zVoESW1FP9h/l3qq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGqtTbR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AEDC2BC86
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765306019;
	bh=RwOQrdvCZOCfPcXTjdfzp8hxiecKCqijW9ilAgKJgbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rGqtTbR7LKuQG0njmH2ICqOSPikT2HBarN4T1/NcNvoh+90wCIKJ8OKdy0+Q2wzhN
	 lvCpLc1PWK+AyTP2Qcb0NK6xxYJJsFQonz1OfcpAZDHY2kPaOYjkrMn7v1UfN7zOUm
	 fSOW+fTDTGmzSMIy+SnELERctLJjqR+11yApyaD2XkcTLrpLorCNU8qk5pe0k7pJmL
	 Dgf4dl576c54fxpHuPnN3PLD7km/cgJR9UQN+n37ThE1HVPbU2ubQfac0Mg4en7yVs
	 Oz6GU8klBXtH1fMyyTr/kqSaUjBS+j9de6AQhE94zB1jKBCzaNrJPm/iXuOsuN7rq3
	 AhXh8x+pi27Mw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so10630092a12.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 10:46:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnpwEdpxiyiax5PqP6OtFLI9Wm4vRQSAloPGa+ETiHONsJYtGpctWMSBziT13aAQzjPce8xZY9BSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wA3MvpypSF61UqqquaJVh71DxEQjh7rgxJcM4vSkQzN0yFMf
	eRr084RgE8TgUQUVOAWzzfgn3Re9z8XkeufWb8ZXKP5rWkFevppMdISM7GkHiLLuL5mtr6Rrst5
	/+BgSj7zUQNoJkqhoMg0nSELOovBYsA==
X-Google-Smtp-Source: AGHT+IFiQ4wJ/VE1EASUueymKfss72+4pujtua9C+jSjLvlkO3/K2JEd2eLfJpaiVceQ4TlzGIbWBFlVQfUjIUYHCnc=
X-Received: by 2002:a05:6402:90d:b0:640:a9b1:870b with SMTP id
 4fb4d7f45d1cf-6491a3fefffmr9632476a12.14.1765306018059; Tue, 09 Dec 2025
 10:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812085037.13517-1-andrea.porta@suse.com> <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
 <aKc5nMT1xXpY03ip@apocalypse> <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>
 <aLVePQRfU4IB1zK8@apocalypse> <CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com>
 <aThjYt3ux0U-9-3A@apocalypse> <aThp99OfgAfNFUX-@apocalypse>
In-Reply-To: <aThp99OfgAfNFUX-@apocalypse>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Dec 2025 12:46:45 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VfWJtb_VEEmHCtDdKUUFWUrxw80FocuEiVwFTAM9zyg@mail.gmail.com>
X-Gm-Features: AQt7F2rQuv1o7PzOcLYEjioegQxnHbuyX-xlEY6nKer24-O9xmckn5nOlwjXHeI
Message-ID: <CAL_Jsq+VfWJtb_VEEmHCtDdKUUFWUrxw80FocuEiVwFTAM9zyg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC warning
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jim Quinlan <jim2101024@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de, 
	mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>, 
	Phil Elwell <phil@raspberrypi.com>, kernel test robot <lkp@intel.com>, 
	Herve Codina <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 12:24=E2=80=AFPM Andrea della Porta
<andrea.porta@suse.com> wrote:
>
> [+cc Herve]
>
> On 18:58 Tue 09 Dec     , Andrea della Porta wrote:
> > Hi Rob,
> >
> > On 11:09 Thu 04 Dec     , Rob Herring wrote:
> > > On Mon, Sep 1, 2025 at 3:48=E2=80=AFAM Andrea della Porta <andrea.por=
ta@suse.com> wrote:
> > > >
> > > > Hi Krzysztof,
> > > >
> > > > On 08:50 Fri 22 Aug     , Krzysztof Kozlowski wrote:
> > > > > On 21/08/2025 17:22, Andrea della Porta wrote:
> > > > > > Hi Krzysztof,
> > > > > >
> > > > > > On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> > > > > >> On 12/08/2025 10:50, Andrea della Porta wrote:
> > > > > >>> The devicetree compiler is complaining as follows:
> > > > > >>>
> > > > > >>> arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warnin=
g (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or =
ranges property, but no unit name
> > > > > >>> /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2=
712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('=
rp1_nexus' was unexpected)
> > > > > >>
> > > > > >> Please trim the paths.
> > > > > >
> > > > > > Ack.
> > > > > >
> > > > > >>
> > > > > >>>
> > > > > >>> Add the optional node that fix this to the DT binding.
> > > > > >>>
> > > > > >>> Reported-by: kernel test robot <lkp@intel.com>
> > > > > >>> Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.ba=
JDYBT4-lkp@intel.com/
> > > > > >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > > > >>> ---
> > > > > >>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9=
 +++++++++
> > > > > >>>  1 file changed, 9 insertions(+)
> > > > > >>>
> > > > > >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-p=
cie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > > >>> index 812ef5957cfc..7d8ba920b652 100644
> > > > > >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yam=
l
> > > > > >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yam=
l
> > > > > >>> @@ -126,6 +126,15 @@ required:
> > > > > >>>  allOf:
> > > > > >>>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > >>>    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > > > > >>> +  - if:
> > > > > >>> +      properties:
> > > > > >>> +        compatible:
> > > > > >>> +          contains:
> > > > > >>> +            const: brcm,bcm2712-pcie
> > > > > >>> +    then:
> > > > > >>> +      properties:
> > > > > >>> +        rp1_nexus:
> > > > > >>
> > > > > >> No, you cannot document post-factum... This does not follow DT=
S coding
> > > > > >> style.
> > > > > >
> > > > > > I think I didn't catch what you mean here: would that mean that
> > > > > > we cannot resolve that warning since we cannot add anything to =
the
> > > > > > binding?
> > > > >
> > > > > I meant, you cannot use a warning from the code you recently intr=
oduced
> > > > > as a reason to use incorrect style.
> > > > >
> > > > > Fixing warning is of course fine and correct, but for the code re=
cently
> > > > > introduced and which bypassed ABI review it is basically like new=
 review
> > > > > of new ABI.
> > > > >
> > > > > This needs standard review practice, so you need to document WHY =
you
> > > > > need such node. Warning is not the reason here why you are doing.=
 If
> > > > > this was part of original patchset, like it should have been, you=
 would
> > > > > not use some imaginary warning as reason, right?
> > > > >
> > > > > So provide reason why you need here this dedicated child, what is=
 that
> > > > > child representing.
> > > >
> > > > Ack.
> > > >
> > > > >
> > > > > Otherwise I can suggest: drop the child and DTSO, this also solve=
s the
> > > > > warning...
> > > >
> > > > This would not fix the issue: it's the non overlay that needs the s=
pecific
> > > > node. But I got the point, and we have a solution for that (see bel=
ow).
> > > >
> > > > >
> > > > > >
> > > > > > Regarding rp1_nexus, you're right I guess it should be
> > > > > > rp1-nexus as per DTS coding style.
> > > > > >
> > > > > >>
> > > > > >> Also:
> > > > > >>
> > > > > >> Node names should be generic. See also an explanation and list=
 of
> > > > > >> examples (not exhaustive) in DT specification:
> > > > > >> https://devicetree-specification.readthedocs.io/en/latest/chap=
ter2-devicetree-basics.html#generic-names-recommendation
> > > > > >
> > > > > > In this case it could be difficult: we need to search for a DT =
node
> > > > >
> > > > > Search like in driver? That's wrong, you should be searching by c=
ompatible.
> > > >
> > > > Thanks for the hint. Searching by compatble is the solution.
> > >
> > > No, it is not.
> >
> > This is partly true, indeed. On one side there's the need to avoid a
> > specific node name ('rp1_nexus'), so the only other unique identifier w=
ould
> > be the compatible string ('pci1de4,1' in this case, which identifies th=
at specific
> > device). Unfortunately, the same compatible string is also assigned to =
the pci
> > endpoint node filled automatically by enabling CONFIG_PCI_DYNAMIC_OF_NO=
DES.
> > We would end up with two nodes with the same compatible, which is not u=
nique
> > anymore.
> > This applies only when using 'full' dtb (bcm2712-rpi-5-b.dtb) *and* you=
 enable
> > CONFIG_PCI_DYNAMIC_OF_NODES, the latter being not necessary since the o=
verlay dtb
> > (...-ovl-rp1.dtb) is not in use here. To overcome this problem, the sol=
utions
> > I can think of are the following:
> >
> > 1- Just disable CONFIG_PCI_DYNAMIC_OF_NODES should work, but only when =
using the
> >    full dtb version. However, if the user enable that option for debug =
or to use
> >    the overlay dtb version, he better be sure not to use teh full dtb o=
r it won't
> >    work.
> >    This solution seems really weak.
> >
> > 2- Add another compatible string other than 'pci1de4,1', so it will be =
really
> >    unique.
> >
> > >
> > > > >
> > > > > > starting from the DT root and using generic names like pci@0,0 =
or
> > > > > > dev@0,0 could possibly led to conflicts with other peripherals.
> > > > > > That's why I chose a specific name.
> > > > >
> > > > > Dunno, depends what can be there, but you do not get a specific
> > > > > (non-generic) device node name for a generic PCI device or endpoi=
nt.
> > > >
> > > > I would use 'port' instead of rp1-nexus. Would it work for you?
> > >
> > > Do you still plan to fix this? This is broken far worse than just the=
 node name.
> >
> > Yes, if we want to get rid of that nasty warning and comply with DT gui=
delines,
> > I think I really need to fix that.
> >
> > >
> > > The 'rp1_nexus' node is applied to the PCI host bridge. That's wrong
> > > unless this is PCI rather than PCIe. There's the root port device in
> > > between.
> > >
> > > The clue that things are wrong are start in the driver here:
> > >
> > > rp1_node =3D of_find_node_by_name(NULL, "rp1_nexus");
> > > if (!rp1_node) {
> > >   rp1_node =3D dev_of_node(dev);
> > >   skip_ovl =3D false;
> > > }
> > >
> > > You should not need to do this nor care what the node name is. The PC=
I
> > > core should have populated pdev->dev.of_node for you. If not, your DT
> > > is wrong. Turn on CONFIG_PCI_DYNAMIC_OF_NODES and look at the
> > > resulting PCI nodes. They should also match what the hierarchy looks
> > > like with lspci. I don't recommend you rely on
> > > CONFIG_PCI_DYNAMIC_OF_NODES, but statically populate the nodes in the
> > > DT. First, CONFIG_PCI_DYNAMIC_OF_NODES is an under development thing
> > > and I hope to get rid of the config option. Second, your case is
> > > static (i.e. not a PCIe card in a slot) so there is no issue
> > > hardcoding the DT.
>
> Are you planning to get rid of the CONFIG_PCI_DYNAMIC_OF_NODES features?
> There could be other drivers relying on that besides RP1 in overlay mode,
> e.g. LAN966x for instance.

I only plan/want to get rid of the kconfig option, not the feature
itself! IOW, it will be enabled/disabled at runtime based on
something. I'm not sure what that something is.

Rob

