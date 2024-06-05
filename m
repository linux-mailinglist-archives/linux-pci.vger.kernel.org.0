Return-Path: <linux-pci+bounces-8333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E821E8FD025
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 15:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E9829B2E2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE384594D;
	Wed,  5 Jun 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8p0owIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52539FC5;
	Wed,  5 Jun 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595436; cv=none; b=AGqP4XvahFcoo/+P5PVKhe9wuQ3i++E7BDAjWp9P6mMnWRMqU8nJUDtdv0zc+y5tUKXlYKF1ByFM+Zn8v5UWZKwXGp1jGELqPG+B2NjaWVddaQv/36bzqL3YIcOpulDay7PQaEZjE300ZL5CQTFM27JZsYYrI3jel+AUHCCq0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595436; c=relaxed/simple;
	bh=THHBlGMAWjBLIyLgqNnLwR6wpLdgEYjBZqkS4AZkOjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCEUw269B9wSLbTxo24a2PjBpJNTq2sltedz1RzefduAeAx2sTOTjKyJ+E7uJrwSxRRtiVhEdjlU4qZkJhXodjz6YuUwO/8dR5a/WemlBq3Y0AHjvE0VUz9MPUUT9q8p2MtvVFrZpczitiUEv0BLDbH92JN2SwbEc4umfxANwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8p0owIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D80C2BD11;
	Wed,  5 Jun 2024 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595436;
	bh=THHBlGMAWjBLIyLgqNnLwR6wpLdgEYjBZqkS4AZkOjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8p0owIRpfWAL1ARg/L89LmAj7ogSBMECcOR4CTT0yLWi+ujkQviYKSDVcLHpcy7B
	 7uKjUCXsGp0I9pmaO3F2xN23u1McCNxgk6YXX731U9bui0uwJhZSxpc2MnJWWvQvM9
	 0BSSsv2nVL8NpimXBm0aaa6IZcDi9mylXq7Kd4hyvAetpGFaAV5BYmcPvlFuU1+M9g
	 +nRCbn73lBpreB+FNTnXiC4q/QvyHDj+oStaea+H8gl2ps7V98fWIs3BygmLg9CfID
	 gWtwIg/oqTcprkbGx8Bu52Nc3usAD6lcKBoJazdMXwdVWb8DseGdOOVOQ2dHvFqVap
	 NUrdNA6SIaDaw==
Date: Wed, 5 Jun 2024 07:50:33 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Fix register maps items and add
 3.3V supply
Message-ID: <20240605135033.GA2468218-robh@kernel.org>
References: <20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org>
 <20240604235806.GA1903493-robh@kernel.org>
 <20240605054928.GB2417@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605054928.GB2417@thinkpad>

On Wed, Jun 05, 2024 at 11:19:28AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jun 04, 2024 at 05:58:06PM -0600, Rob Herring wrote:
> > On Tue, Jun 04, 2024 at 07:05:12PM +0300, Abel Vesa wrote:
> > > All PCIe controllers found on X1E80100 have MHI register region and
> > > VDDPE supplies. Add them to the schema as well.
> > > 
> > > Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > > This patchset fixes the following warning:
> > > https://lore.kernel.org/all/171751454535.785265.18156799252281879515.robh@kernel.org/
> > > 
> > > Also fixes a MHI reg region warning that will be triggered by the following patch:
> > > https://lore.kernel.org/all/20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org/
> > > ---
> > >  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > index 1074310a8e7a..7ceba32c4cf9 100644
> > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > > @@ -19,11 +19,10 @@ properties:
> > >      const: qcom,pcie-x1e80100
> > >  
> > >    reg:
> > > -    minItems: 5
> > > +    minItems: 6
> > >      maxItems: 6
> > >  
> > >    reg-names:
> > > -    minItems: 5
> > >      items:
> > >        - const: parf # Qualcomm specific registers
> > >        - const: dbi # DesignWare PCIe registers
> > > @@ -71,6 +70,9 @@ properties:
> > >        - const: pci # PCIe core reset
> > >        - const: link_down # PCIe link down reset
> > >  
> > > +  vddpe-3v3-supply:
> > > +    description: A phandle to the PCIe endpoint power supply
> > 
> > TBC, this is a rail on the host side provided to a card? If so, we have 
> > standard properties for standard PCI voltage rails.
> 
> There is a 'vpcie3v3-supply' property and it should satisfy the requirement. But
> 'vddpe-3v3-supply' is already used on multiple Qcom SoCs. So changing the name
> in dts warrants the driver to support both supplies for backwards compatibility,
> but that should be fine.

Ideally, we would have a 'enable slot' or 'power on slot' function that 
turns on all the standard slot supplies and wiggles PERST# (and 
perhaps link state management) all following the timing defined in the 
PCI spec. Then the host drivers wouldn't have to do anything other than 
perhaps opt-in to use that.

> > It is also preferred that you put them in a root port node rather than the
> > host bridge.
> 
> Even though the resource split between root port and host bridge is not clear in
> Qcom SoCs, I think from logical stand point it makes sense.

Yeah, since it's typically 1:1 that's been blurred.

Rob

