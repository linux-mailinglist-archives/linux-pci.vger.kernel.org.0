Return-Path: <linux-pci+bounces-35871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91867B52ADA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7D01C819EC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D02C11D6;
	Thu, 11 Sep 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kV3alzNE"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F372C11FC;
	Thu, 11 Sep 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577451; cv=none; b=UzOgDo1xmZdfju0JSn7B78I5VML7Olm5STGHXYcfHthp+XiIDOrgNDi0BGWgxwdwRC5uk64nigCZBuOYJtcnNY6jf2jjobXQcFukSHBsv18AxmM7p0eIqKsQrdtzWntGMG3G64vMcg/howubbCbPh2fAy5S5bv5Ptqt8TCd6t8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577451; c=relaxed/simple;
	bh=1zFS0OoHO7VitnBfjBYIM4BjL3McKXL3jTy4inK1e7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXWutFEOIJjy2qc784ZyeIk9MFOUpnlS+kaLlPiI/Jo6ppgzEveNiSUjN3bsO9ECQgGPmTjfGEhQoxnZ7ScBvP6nba/a7LeEdnear3Yz8kMisiXdGaGnumM9VEr+DPdOj1EgeV8syqK7bNdqs3KLANwm8xUTsDX3JwWu59cqqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kV3alzNE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2CADB25E06;
	Thu, 11 Sep 2025 09:57:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSO4ka3eDsHC; Thu, 11 Sep 2025 09:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757577440; bh=1zFS0OoHO7VitnBfjBYIM4BjL3McKXL3jTy4inK1e7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kV3alzNExe3pSnJskdNpJknNrA8TOAKDFoUaHQOuhhjqFbKz8B7243V4JJSFCj40A
	 scBWoagrfkx3ZkVn30FsSQuwDHkplcmu8+JzH1ZAGztanNI63le+YCKYzqFE0oBJyd
	 OWgajMh7rCBnvXo7i4LAtFpUrMwUaXs7x7ChH0+1qm7X9+oWvVn6YUNzkkNbNV8baR
	 gHgbBCkbxKqw1AmwTPW6IB6H5K95MX+uNAo+xRtHEkmo/VcRXuyuzKUgvkPqFfosPd
	 c0h3TgG7EXtPjM9C0gzOJTm40wZu+cP/4hJExVQLbmnHN+ZI0S3AfpSTdjwbtex67p
	 kcg1rohn2BV6Q==
Date: Thu, 11 Sep 2025 07:56:44 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for
 RK3528
Message-ID: <aMKAvCglcaC6-00k@pie>
References: <20250906135246.19398-1-ziyao@disroot.org>
 <20250906135246.19398-3-ziyao@disroot.org>
 <38e80b6d-1dc9-47a8-8b23-e875c2848e6e@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e80b6d-1dc9-47a8-8b23-e875c2848e6e@kwiboo.se>

On Wed, Sep 10, 2025 at 11:29:00PM +0200, Jonas Karlman wrote:
> Hi Yao Zi,
> 
> On 9/6/2025 3:52 PM, Yao Zi wrote:
> > Describes the PCIe Gen2x1 controller integrated in RK3528 SoC. The SoC
> > doesn't provide a separate MSI controller, thus the one integrated in
> > designware PCIe IP must be used.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 56 +++++++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > index db5dbcac7756..2d2af467e5ab 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > @@ -7,6 +7,7 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/pinctrl/rockchip.h>
> >  #include <dt-bindings/clock/rockchip,rk3528-cru.h>
> >  #include <dt-bindings/power/rockchip,rk3528-power.h>
> > @@ -239,7 +240,7 @@ gmac0_clk: clock-gmac50m {
> >  
> >  	soc {
> >  		compatible = "simple-bus";
> > -		ranges = <0x0 0xfe000000 0x0 0xfe000000 0x0 0x2000000>;
> > +		ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x44400000>;
> 
> We should use the dbi reg area in the 32-bit address space, please use:
> 
>   ranges = <0x0 0xfc000000 0x0 0xfc000000 0x0 0x4000000>;

This seems strange to me. I read through TRMs for RK3562 and RK3576, and
found it's common for Rockchip SoCs to map DBI regions of PCIe
controllers to two separate MMIO regions, but am still not sure why it's
necessary to use the mapping in the 32-bit address space.

However, I'm willing to follow the vendor's decision here in order to
avoid unexpected problems. Will adapt this in v2.

> >  		#address-cells = <2>;
> >  		#size-cells = <2>;
> >  
> > @@ -1133,6 +1134,59 @@ combphy: phy@ffdc0000 {
> >  			rockchip,pipe-phy-grf = <&pipe_phy_grf>;
> >  			status = "disabled";
> >  		};
> > +
> > +		pcie: pcie@fe4f0000 {
> 
> With the dbi reg area changed below, please update the node name and
> move this node to top of the soc node.
> 
>   pcie@fe000000
> 
> > +			compatible = "rockchip,rk3528-pcie",
> > +				     "rockchip,rk3568-pcie";
> > +			reg = <0x1 0x40000000 0x0 0x400000>,
> 
> We should use the dbi reg area in the 32-bit address space, please use:
> 
>   reg = <0x0 0xfe000000 0x0 0x400000>,
> 
> > +			      <0x0 0xfe4f0000 0x0 0x10000>,
> > +			      <0x0 0xfc000000 0x0 0x100000>;
> > +			reg-names = "dbi", "apb", "config";
> > +			bus-range = <0x0 0xff>;
> > +			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
> > +				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
> > +				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;
> > +			clock-names = "aclk_mst", "aclk_slv",
> > +				      "aclk_dbi", "pclk",
> > +				      "aux", "pipe";
> 
> In my U-Boot test I did not have the pipe/phy clock here, do we need it?

Just as mentioned by Chukun, the clock should indeed be managed by phy
instead of the PCIe controller. Will fix it as well.

> With above fixed this more or less matches my U-Boot testing, and is:
> 
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Much thanks.

> Regards,
> Jonas

Best regards,
Yao Zi

