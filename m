Return-Path: <linux-pci+bounces-7762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B509C8CC910
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443D9B219D0
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 22:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F19B1487E8;
	Wed, 22 May 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gluCjXV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640AB1487E0;
	Wed, 22 May 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416920; cv=none; b=Ef+w9DSX/ENFkPJmoGCEb/HeclDG/lhAUU0Ghlc1SQLdL4f64jkYcWXhE4H+rcHLcr21wBbc6VEk95PXPRrIj5RMOU2FoFM1TKnAOskdl+aycFZI7H3HLx1iprmhMCu18+OnbRnE3/5aw9eF+ZjnUybZ0cs/MIGzVDWEAAMJfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416920; c=relaxed/simple;
	bh=FyDYtMT/2nQuK4XVRGpg4ULNIilNC8aI7hQ/yAbnWms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WyAgEtLLeCvvh6ILvrc/IzslpqsaIcZ14riXrmMMlzeVGxmM5joKZ/M/kWp4dAVf2H7A2E1zKtZCnjZJVWb4/nvqOrN5S5VAciSymN0wKcv0x3ZYmo3wjkn6GoW6MYkGqWTBXL/Wkg78tjJv1FdL6pU4F8dzg3icNluH7cILRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gluCjXV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD247C2BBFC;
	Wed, 22 May 2024 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716416920;
	bh=FyDYtMT/2nQuK4XVRGpg4ULNIilNC8aI7hQ/yAbnWms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gluCjXV/cS6TMjmiB4c6zKFpfxBVeYDczAlUg6W/JLtLxMPtImzQMvnjf9A+t7VIK
	 uDbNq3WmWVczLwFlWgq+wcDcktc17i3e4yaDT6A2nladW75Fg5OImyC9uZwjYF5vTA
	 f+NbS5JrNlVD3jD/XVSjogkAvsewrhQUlMvlfHNdnjZyLZLPupEQw37cEgZPjfAy17
	 Ax9dlOzm14HefTumxgJyGYv7mF/VLWWXDotCT/gID0HdWrB4V392HDTte33b1a0jGm
	 uxygzqywCVWx4FGqkAMmQflEjIBGqVzXyDahXa4ecaYsGbiPAtvzIi341WCut2EHVx
	 fYVS7cfIjrZbw==
Date: Wed, 22 May 2024 17:28:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>,
	g@bhelgaas.smtp.subspace.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Message-ID: <20240522222838.GA101305@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520145402.2526481-2-sean.anderson@linux.dev>

On Mon, May 20, 2024 at 10:53:56AM -0400, Sean Anderson wrote:
> Add phys properties so Linux can power-on/configure the GTR
> transcievers.

s/transcievers/transceivers/

Possibly s/phys/PHYs/ in subject, commit log, DT description to avoid
confusion with "phys" (short for generic "physical").  Or maybe even
just "PHY properties"?

What does "GTR" mean?  Possibly expand that?

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v3:
> - Document phys property
> 
> Changes in v2:
> - Remove phy-names
> - Add an example
> 
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> index 426f90a47f35..cc50795d170b 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -61,6 +61,11 @@ properties:
>    interrupt-map:
>      maxItems: 4
>  
> +  phys:
> +    minItems: 1
> +    maxItems: 4
> +    description: One phy per logical lane, in order
> +
>    power-domains:
>      maxItems: 1
>  
> @@ -110,6 +115,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/phy/phy.h>
>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>      soc {
>          #address-cells = <2>;
> @@ -138,6 +144,7 @@ examples:
>                              <0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
>                              <0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
>              msi-parent = <&nwl_pcie>;
> +            phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>              power-domains = <&zynqmp_firmware PD_PCIE>;
>              iommus = <&smmu 0x4d0>;
>              pcie_intc: legacy-interrupt-controller {
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

