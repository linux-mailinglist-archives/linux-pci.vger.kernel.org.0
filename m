Return-Path: <linux-pci+bounces-6521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992D8AD00A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 16:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F21F224A0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE5147C81;
	Mon, 22 Apr 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT/3TJP+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5321E49F;
	Mon, 22 Apr 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797938; cv=none; b=mCT8ws6FU4k3YLbTowHIgPqK2sdIH9HqwkwLKhSUZKsFD+Z0e1zYogndOXl4IzfLsBtLh2IPpHnUEsFLZ/KB/HoUH0s6hcNJSgQ5ALkzwGe4k48tAY/1xEnL3vWF/26OWEKJTott9Wor3JY/vYccHKjl7Yo1cyw/Q5ORoKqGeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797938; c=relaxed/simple;
	bh=KgbM3k+jSRBzGRZiQzyCDCUnLSPGShDmfs2+LbcxB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLfUSOdMChyODhgxQOFMxXGbAooCUprwGz/Al1jNqc/TLAbr17nwjto6L7jPdFumWJC2O8FF+Ab2+83AOAJC6WN6ty99vjD0dEAZD/8irbhGjSal09ptzUYNQgXgTXTIg/YlHFtP+/O4a29aaI2zB34wdZ9LCAE+woDnzebtGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT/3TJP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B433FC113CC;
	Mon, 22 Apr 2024 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713797938;
	bh=KgbM3k+jSRBzGRZiQzyCDCUnLSPGShDmfs2+LbcxB7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nT/3TJP+dzwNxRWbeYbmeJVied1e70gL/B9J88fLb7P47PDm3Y1/yKw1A1eI829sK
	 ltcuub6sB/t4oBclXnDcrm6q9UrQtUbxzXsjvFtf9ZQBQivuVGx/dJ50o21Od500HB
	 PyQ90Wy2aesN0k/tWVDsHhAstXV70k2JtBagWBrQM41nyUHt13914bn3b8Dy/osSCf
	 poJQMVJfrJzto8zLzHsenkrP8SZfIxU2VzESxy9YXvZK4oFUhvvo+4gDjflrPiP1yr
	 IwBdaCUvOpg82wk5ETmJ57A7BAHRWCw1aUrFwrWTi4TkVAHLPv9ig7QEnvrRZCcg8v
	 D4/p46gUebNIw==
Date: Mon, 22 Apr 2024 09:58:55 -0500
From: Rob Herring <robh@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: PCI: altera: Convert to YAML
Message-ID: <20240422145855.GA1242711-robh@kernel.org>
References: <20240420145342.118643-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420145342.118643-1-matthew.gerlach@linux.intel.com>

On Sat, Apr 20, 2024 at 09:53:42AM -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Convert the device tree bindings for the Altera Root Port PCIe controller
> from text to YAML.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4:
>  - reorder reg-names to match original binding
>  - move reg and reg-names to top level with limits.
> 
> v3:
>  - Added years to copyright
>  - Correct order in file of allOf and unevaluatedProperties
>  - remove items: in compatible field
>  - fix reg and reg-names constraints
>  - replace deprecated pci-bus.yaml with pci-host-bridge.yaml
>  - fix entries in ranges property
>  - remove device_type from required
> 
> v2:
>  - Move allOf: to bottom of file, just like example-schema is showing
>  - add constraint for reg and reg-names
>  - remove unneeded device_type
>  - drop #address-cells and #size-cells
>  - change minItems to maxItems for interrupts:
>  - change msi-parent to just "msi-parent: true"
>  - cleaned up required:
>  - make subject consistent with other commits coverting to YAML
>  - s/overt/onvert/g
> ---
>  .../devicetree/bindings/pci/altera-pcie.txt   | 50 -----------
>  .../bindings/pci/altr,pcie-root-port.yaml     | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> deleted file mode 100644
> index 816b244a221e..000000000000
> --- a/Documentation/devicetree/bindings/pci/altera-pcie.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Altera PCIe controller
> -
> -Required properties:
> -- compatible :	should contain "altr,pcie-root-port-1.0" or "altr,pcie-root-port-2.0"
> -- reg:		a list of physical base address and length for TXS and CRA.
> -		For "altr,pcie-root-port-2.0", additional HIP base address and length.
> -- reg-names:	must include the following entries:
> -		"Txs": TX slave port region
> -		"Cra": Control register access region
> -		"Hip": Hard IP region (if "altr,pcie-root-port-2.0")
> -- interrupts:	specifies the interrupt source of the parent interrupt
> -		controller.  The format of the interrupt specifier depends
> -		on the parent interrupt controller.
> -- device_type:	must be "pci"
> -- #address-cells:	set to <3>
> -- #size-cells:		set to <2>
> -- #interrupt-cells:	set to <1>
> -- ranges:	describes the translation of addresses for root ports and
> -		standard PCI regions.
> -- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> -		mapping of the PCIe interface to interrupt numbers.
> -
> -Optional properties:
> -- msi-parent:	Link to the hardware entity that serves as the MSI controller
> -		for this PCIe controller.
> -- bus-range:	PCI bus numbers covered
> -
> -Example
> -	pcie_0: pcie@c00000000 {
> -		compatible = "altr,pcie-root-port-1.0";
> -		reg = <0xc0000000 0x20000000>,
> -			<0xff220000 0x00004000>;
> -		reg-names = "Txs", "Cra";
> -		interrupt-parent = <&hps_0_arm_gic_0>;
> -		interrupts = <0 40 4>;
> -		interrupt-controller;

What happened to this? It is clearly needed since the interrupt-map 
below points back to this node. Note that that didn't work at one point 
in time, but I think we fixed it.

It doesn't seem you are testing the binding against an actual DT. 
Please do that.

Rob

> -		#interrupt-cells = <1>;
> -		bus-range = <0x0 0xFF>;
> -		device_type = "pci";
> -		msi-parent = <&msi_to_gic_gen_0>;
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		interrupt-map-mask = <0 0 0 7>;
> -		interrupt-map = <0 0 0 1 &pcie_0 1>,
> -			            <0 0 0 2 &pcie_0 2>,
> -			            <0 0 0 3 &pcie_0 3>,
> -			            <0 0 0 4 &pcie_0 4>;
> -		ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> -			  0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> -	};

