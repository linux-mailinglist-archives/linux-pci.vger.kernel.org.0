Return-Path: <linux-pci+bounces-6867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F908B7495
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42A11C225E7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302512D75C;
	Tue, 30 Apr 2024 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWPDVOBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946412D746;
	Tue, 30 Apr 2024 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476906; cv=none; b=Lq5ZkEfaChGRIIFkgS7lXclfyNW2NO2f/+Ncsl229hDFFQMGHl9Fbk0UMrETw5GHMUBqWsGVFAU1kn3YEM0N3W1jWN/ZW0rWvCuEMy4OedvyIIdiKsPZ3e32vZfwJEcEcLccEkCk+MNsg9Xrxo684eP79glw/DuGwjkgnRZnJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476906; c=relaxed/simple;
	bh=sxELeoveQyBre7ysa3POtgLGQh7DXaFQ4aIvHwFGZhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNsmgpiUZ0gMfRFK+qkRMoNmXezpMRuu0joTCiRgE5SWFASZoyft9F7waLN+/D8gSNjtErva1Ku0IDZc1V9oJ5DhsT3g7SemJII5ShsJqSfFYAzW2lHEI67kw6Y+ZCncd8us6BPwsoZSHtRH+0uRv8faTeJaUSBVAYy3tSIRoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWPDVOBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3966C2BBFC;
	Tue, 30 Apr 2024 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476905;
	bh=sxELeoveQyBre7ysa3POtgLGQh7DXaFQ4aIvHwFGZhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWPDVOBzUKxdgbVU/EzK2z365JwEkd273wG6jpr0AscMPIDuyLKa3lvcS0qHNglRX
	 Qr/viURln37ItxVtuRsv8KCJJ1jdyA4973LiWMRtsIQY85W8buB/ebiY4QmlM9u284
	 E7Qr3fVf1zF5TKXXsb9vW767PxP+RcegNHm9m9s4kx8Adpsh1O2ZaCkCKChA3cuOqI
	 e5fabNHp/kd7iv9PRbAJ6WefdVtewcDJ0sJZpkdLkSliwpXN67HRFfRoHS72A0U9MX
	 Ff5/5IqDARkSFlcqNWjBrTGz2aZySBunwGFRf+KWsCpgoRmGqYWuZu2cL5daV6e77A
	 SnWM2UKlAfNjQ==
Date: Tue, 30 Apr 2024 13:34:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 04/12] dt-bindings: rockchip: Add DesignWare based PCIe
 Endpoint controller
Message-ID: <ZjDXYguzuhnJAcfg@ryzen.lan>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-4-b1a02ddad650@kernel.org>
 <20240425160809.GA2613935-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425160809.GA2613935-robh@kernel.org>

On Thu, Apr 25, 2024 at 11:08:09AM -0500, Rob Herring wrote:
> On Wed, Apr 24, 2024 at 05:16:22PM +0200, Niklas Cassel wrote:
> > Document DT bindings for PCIe Endpoint controller found in Rockchip SoCs.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 192 +++++++++++++++++++++
> >  1 file changed, 192 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> > new file mode 100644
> > index 000000000000..57a6c542058f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> > @@ -0,0 +1,192 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DesignWare based PCIe Endpoint controller on Rockchip SoCs
> > +
> > +maintainers:
> > +  - Niklas Cassel <cassel@kernel.org>
> > +
> > +description: |+
> > +  RK3588 SoC PCIe Endpoint controller is based on the Synopsys DesignWare
> > +  PCIe IP and thus inherits all the common properties defined in
> > +  snps,dw-pcie-ep.yaml.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: rockchip,rk3588-pcie-ep
> 
> 3568 doesn't support endpoint mode? It would be good to keep the 
> bindings aligned.

It does.
However, it does not have the dedicated IRQ lines for the eDMA interrupts.
I will add rk3568 to the DT binding and to the driver.
If someone wants eDMA functional for rk3568, there is further code needed,
but EP mode without eDMA should work on rk3568 as is.


> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: pcie-phy
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 2
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pwr
> > +      - const: pipe
> 
> Most of this is all duplicated from rockchip-dw-pcie.yaml. Pull out the 
> common bits to a separate schema file and reference it from the RC and 
> endpoint schemas.

Ok, will fix in V2.


> You'll need to add to interrupts/interrupt-names in the common schema 
> and then restrict the number of items here and in the RC schema.

Remember that eDMA can be used also in RC mode.
Even if the RC binding doesn't allow it right now, these interrupts could
be optional also for RC mode, in case someone actually wants to use them
in the future.


> > +
> > +  vpcie3v3-supply: true
> 
> This doesn't make sense for endpoint mode. At least in the sense this 
> is supposed to be a standard slot voltage driven from the host side.

I tried not supplying the regulator for the EP side on my rock5b
(rk3588 based) platform.
The driver (in EP mode) probes correctly, but does not work without this,
regardless of how I try. Boot EP first, boot RC first.

Looking at the rock5b schematic:
https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf
Page 7, specifically VCC3V3_PCIE30.
It does seem to only support sourcing VIN from a regulator on the local
board (VCC5V0_SYS).

(Looking at a vendor using this SoC in a board that supports EP mode
(Mixtile Blade 3), they do supply the regulator also for the EP-mode
DT node.)

I will drop the "vpcie3v3-supply" from the EP binding and keep it
only in the RC binding. (As perhaps some other rk3588 based board can
actually source the 3.3v from the PCIe slot in EP mode.)

I will keep it in the rock5b (a rk3588 based board) DT overlay,
as it is obviously needed for rock5b.


> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - num-lanes
> > +  - phys
> > +  - phy-names
> > +  - power-domains
> > +  - resets
> > +  - reset-names
> 
> A bunch or all? of these can be in the common schema too.

Ok, will fix in V2.


Kind regards,
Niklas

