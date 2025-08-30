Return-Path: <linux-pci+bounces-35168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60FB3C797
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 05:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACFF566254
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 03:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB60256C70;
	Sat, 30 Aug 2025 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTAFArBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D125485A;
	Sat, 30 Aug 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756524445; cv=none; b=fCq0JlzJYKjLcWK8KqVG50EzB6pi9ZH5cDr1qbJ24OxSR8c4wDUmkAxJ5E2VrxekcdCRsr+Aqj5SDIxxRi3ADy4YaJDf5UCOTnXokslZUohBuhJ/yZzCHy06X6MDb8oMrBog+DOngETuhNn3bP5ORZANORPErChBtQEjAn6r4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756524445; c=relaxed/simple;
	bh=EeM6wlnVh/LaVPIABlVqVwrJnTHj5btsYvFNRr+o3EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU9pVUI4r17UfZFpik4flTsGDRuu3Q2uq1WSQXZYYcXrJFszvDKZDPvxsFP8lnrYYBblz1xE+yPoEPTCY3aBbbbnpCFaGlyef+xau/81VO72N4oLOvK9F01PKCwN16M0fNK1IdYXEgXiB8v3gAOeKFZ9+Y8zY7uMNDj+hsc1kIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTAFArBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8987C4CEF0;
	Sat, 30 Aug 2025 03:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756524444;
	bh=EeM6wlnVh/LaVPIABlVqVwrJnTHj5btsYvFNRr+o3EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTAFArBON0yO4GRK52P9RF2QBrxzNfdltDdA5zELoqtsVCQ8qiSO6pDUlks2ZZjEK
	 rzQyh3bjLI19GhDcj3+QqfT6AVed7T5PK/gdu9mq/PfFiUWq3Ji4tclqO5MdcUQqmE
	 ySIMTi1OyZVye6vts5e9F+Izv2qdvGyLjeAQKECltzDmsMd536rlLLAE2mxnj8I1aN
	 rYFzo6s9pJJHFJ8LQRCPsXESIvKeyFlVh0jgSu1MIsRS1vGNrMJpGP9sVTIxOTxVRl
	 B1Au4a4tvUyAIb3QmIDTbmabxrDQvssLhfIsQWbIKIAEJFTyx/LX7Cxc+s6M8LpvM+
	 O80tey/sz1fZQ==
Date: Sat, 30 Aug 2025 08:57:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de, 
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 07/12] dt-bindings: PCI: Add support for Tesla FSD SoC
Message-ID: <frnwfzh7j6x27evk6oo64cevpreq5s4tugewebcpropzmxpilf@trv2toljqptl>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097@epcas5p4.samsung.com>
 <20250811154638.95732-8-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811154638.95732-8-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:33PM GMT, Shradha Todi wrote:
> Add Tesla FSD SoC support for both RC and EP.

Add some info about the PCIe controller here. Like the data rate supported,
lanes, interrupts, any quirks etc...

> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../bindings/pci/tesla,fsd-pcie-ep.yaml       | 91 +++++++++++++++++++
>  .../bindings/pci/tesla,fsd-pcie.yaml          | 77 ++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/tesla,fsd-pcie.yaml
> 

[...]

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcierc1: pcie@16b00000 {
> +            compatible = "tesla,fsd-pcie";
> +            reg = <0x0 0x16b00000 0x0 0x2000>,
> +                  <0x0 0x168c0000 0x0 0x1000>,
> +                  <0x0 0x18000000 0x0 0x1000>;
> +            reg-names = "dbi", "elbi", "config";
> +            ranges =  <0x82000000 0x0 0x18001000 0x0 0x18001000 0x0 0xffefff>;
> +            clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
> +            clock-names = "aux", "dbi", "mstr", "slv";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            dma-coherent;
> +            device_type = "pci";
> +            interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;

Only one SPI interrupt? What about INTx? Don't you have any external/internal
MSI controller?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

