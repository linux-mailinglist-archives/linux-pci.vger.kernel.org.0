Return-Path: <linux-pci+bounces-30998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965FAEC720
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46842177AD0
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3823ED75;
	Sat, 28 Jun 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twO55Ffo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1162F1FF1;
	Sat, 28 Jun 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751114057; cv=none; b=f2XyIP3KwJ1w+qgr4rcWjAg5Tf7xUMJYNHpu5u6tmtuQYPs9sy1jFgfjMOz6HHouBX/x1X781n4uP7wESXbf1ttNGIavBPfN1BSt3S9fbHWjOJjt7gtzPNumXZf+owZNEZ0UNYeuR+eGAOhdWI8fRwZwsiSSqNoinxgQl+Zf6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751114057; c=relaxed/simple;
	bh=Gv8OZAS59VuowhMNvxr1kBxJNYmz6S/ffMO8w95ApdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCc5KU2h2/fVLHB3yac/gdwQgDWg53XYDeYIGXGxx9LBjUvPsGDqu3bOXvlPApCgd686VzFqxXGg2yZegegn+XBWsQtouH7AWtE579lcseACK2AOav+xgsESwaD2kQW/E91mk5ucBBrzhJrtdmBsS48sbzcxqoR4FKOOPkQu890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twO55Ffo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237EC4CEEA;
	Sat, 28 Jun 2025 12:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751114056;
	bh=Gv8OZAS59VuowhMNvxr1kBxJNYmz6S/ffMO8w95ApdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twO55Ffo5tiT0qncLDcjcnipq7VcjU8Nm4Y9P5oTopNqmVT8EmBWZqJwkVAx0gmt6
	 sePfRtnNb/GBnM2VBj8vrmWQ8Qm08zQ+ZIv/X1Bl5ASJEZPEESajBqhX1zJzThex+s
	 oLmAgFK+4fIvX308YNdwKC63WEV1TyInmmKCst38scYijOyyOcZZiGK0fTihwqeHSh
	 AiJQ6ZtEB/9wLHRRmMzyLWtPEMBjlyJUE0yr/xxRfJwsOruDQMYV9IZkMQM3Kk1pf+
	 QMeFbaQeTnUY/obXXj6gH2GPFysCCZ0bXLTCfAjs73AeDZiMD3mCkWtz5AaJS3s/Kw
	 cI6DI31LSqVPA==
Date: Sat, 28 Jun 2025 14:34:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <20250628-vigorous-benevolent-crayfish-bcbae5@krzk-bin>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
 <20250627-sensible-pigeon-of-reading-b021a3@krzk-bin>
 <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aF76jeV+8us82APv@lizhi-Precision-Tower-5810>

On Fri, Jun 27, 2025 at 04:09:49PM -0400, Frank Li wrote:
> On Fri, Jun 27, 2025 at 08:54:46AM +0200, Krzysztof Kozlowski wrote:
> > On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> > > Add one more reference clock "extref" to be onhalf the reference clock
> > > that comes from external crystal oscillator.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > index 34594972d8db..ee09e0d3bbab 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > > @@ -105,6 +105,12 @@ properties:
> > >              define it with this name (for instance pipe, core and aux can
> > >              be connected to a single source of the periodic signal).
> > >            const: ref
> > > +        - description:
> > > +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> > > +            inputs, one from internal PLL, the other from off chip crystal
> > > +            oscillator. Use extref clock name to be onhalf of the reference
> > > +            clock comes form external crystal oscillator.
> >
> > How internal PLL can be represented as 'ref' clock? Internal means it is
> > not outside, so impossible to represent.
> 
> Internal means in side SoC, but outside PCIe controller.

So external... It does not matter for PCIe controller whether clock is
coming from SoC or from some crystal.  It is still input pin. Same input
pin.

> 
> >
> > Where is the DTS so we can look at big picture?
> 
> imx94 pci's upstream is still on going, which quite similar with imx95.
> Just board design choose external crystal.
> 
> pcie_ref_clk: clock-pcie-ref {
>                 compatible = "gpio-gate-clock";
>                 clocks = <&xtal25m>;
>                 #clock-cells = <0>;
>                 enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
> };
> 
> &pcie0 {
>         pinctrl-0 = <&pinctrl_pcie0>;
>         pinctrl-names = "default";
>         clocks = <&scmi_clk IMX94_CLK_HSIO>,
>                  <&scmi_clk IMX94_CLK_HSIOPLL>,
>                  <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
>                  <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
>                  <&pcie_ref_clk>;
>         clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ext-ref";

So this is totally faked hardware property.

No, it is the same clock signal, not different. You write bindings from
this device point of view, not for your board.

Best regards,
Krzysztof


