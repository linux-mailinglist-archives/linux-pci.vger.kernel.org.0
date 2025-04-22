Return-Path: <linux-pci+bounces-26416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07ADA9736E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 19:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51913B4DC7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F550296D0A;
	Tue, 22 Apr 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEkxkbYf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190617A2ED;
	Tue, 22 Apr 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342313; cv=none; b=qTnhQ9R836sHZoap4P84myUee4kPCpAJ8YByF4IoYDE1Alq5zM+f8vrKVJxQYDxrmy3jzarQd7sBh9m//6PGI7h81aQrCYHw2zjOCZl+vHRCNCwbBrSV9heKisRi4bYLX2vz8Nfje/M5lzuYPoHQCIfelorfNgayb+VltCZxf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342313; c=relaxed/simple;
	bh=TiHnklRHaI5Nn6C657v9VO8chrK1SPWryZVTduT7KXg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uj8MjsDVzdJLx1fyYkbgeelf524EvTtFnUyUjnygE/YFWHfscw+nafA4uxIX48vmWbG/DdsxMI5cOjoav2x34GxcFRAGse9ChkRbyOcdZzVC0eCkMsDyJ3K1wI23HkTihGPmG1A38hEOIDDQMtJCKFGogZSngafdeTIRqMq/B7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEkxkbYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4B5C4CEE9;
	Tue, 22 Apr 2025 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745342312;
	bh=TiHnklRHaI5Nn6C657v9VO8chrK1SPWryZVTduT7KXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kEkxkbYf1dnxSGOITjgHt/l03NYAqVQR0mm4D0cWauvzRMjlqbt0brNj9ixW5SCz9
	 7bfA3c71tKFLX/yiad9C71RrQrtXx6BFzgtoDOp3w/Xli4v5sjgdgMofK2K1xwzku8
	 YXJ3qXa/O6Xwpw27yTTHb1Oq3tnq6j3eGYYKeEaV3siulEu+gFozqeh8gbsMNHsesZ
	 Rt5dFlulyxl82WlVdyWHEoOmfZ2zll35dyS+A5k5CoX65hVIQzq88NG+q9mcwv8VeX
	 m9TkIWHN+q5iwknuF1HO04ZDPZG402mNKK9sJqctPYcZIJd+0yewEittSuOQ3Br/Os
	 Ghf73+qUTzOOA==
Date: Tue, 22 Apr 2025 12:18:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
Message-ID: <20250422171830.GA335614@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404221559.552201-1-robh@kernel.org>

[+cc Jean-Philippe for virtio dangling ref]

On Fri, Apr 04, 2025 at 05:15:57PM -0500, Rob Herring (Arm) wrote:
> The content in these files has been moved to the schemas in dtschema.
> pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> msi-map property in pci-host-bridge.yaml.

I guess "dtschema" refers to
https://github.com/devicetree-org/dt-schema?

I kinda wish there was some direct link from the Linux kernel source
to dt-schema where all this information now lives (Requester ID
format, iommu-map, msi-map, linux,pci-domain, reg (and reference to
IEEE Std 1275-1994), interrupt mapping info, external-facing, etc).
Being a DT neophyte, I need all the help I can get ;)

There are a few dangling references to pci.txt:

  Documentation/devicetree/bindings/pci/aardvark-pci.txt: - max-link-speed: see pci.txt
  Documentation/devicetree/bindings/pci/aardvark-pci.txt: - reset-gpios: see pci.txt
  Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:- bus-range: see pci.txt
  Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt:  1275-1994 (see pci.txt) with the following restriction:
  Documentation/devicetree/bindings/virtio/pci-iommu.yaml:      zero. See Documentation/devicetree/bindings/pci/pci.txt

> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> +++ /dev/null
> @@ -1,171 +0,0 @@
> -This document describes the generic device tree binding for describing the
> -relationship between PCI(e) devices and IOMMU(s).
> -
> -Each PCI(e) device under a root complex is uniquely identified by its Requester
> -ID (AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> -Function number.
> -
> -For the purpose of this document, when treated as a numeric value, a RID is
> -formatted such that:
> -
> -* Bits [15:8] are the Bus number.
> -* Bits [7:3] are the Device number.
> -* Bits [2:0] are the Function number.
> -* Any other bits required for padding must be zero.
> -
> -IOMMUs may distinguish PCI devices through sideband data derived from the
> -Requester ID. While a given PCI device can only master through one IOMMU, a
> -root complex may split masters across a set of IOMMUs (e.g. with one IOMMU per
> -bus).
> -
> -The generic 'iommus' property is insufficient to describe this relationship,
> -and a mechanism is required to map from a PCI device to its IOMMU and sideband
> -data.
> -
> -For generic IOMMU bindings, see
> -Documentation/devicetree/bindings/iommu/iommu.txt.
> -
> -
> -PCI root complex
> -================
> -
> -Optional properties
> --------------------
> -
> -- iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifier
> -  data.
> -
> -  The property is an arbitrary number of tuples of
> -  (rid-base,iommu,iommu-base,length).
> -
> -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed IOMMU, with the IOMMU specifier (r - rid-base + iommu-base).
> -
> -- iommu-map-mask: A mask to be applied to each Requester ID prior to being
> -  mapped to an IOMMU specifier per the iommu-map property.
> -
> -
> -Example (1)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID,
> -		 * identity-mapped.
> -		 */
> -		iommu-map = <0x0 &iommu 0x0 0x10000>;
> -	};
> -};
> -
> -
> -Example (2)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID with the
> -		 * function bits masked out.
> -		 */
> -		iommu-map = <0x0 &iommu 0x0 0x10000>;
> -		iommu-map-mask = <0xfff8>;
> -	};
> -};
> -
> -
> -Example (3)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the IOMMU is the RID,
> -		 * but the high bits of the bus number are flipped.
> -		 */
> -		iommu-map = <0x0000 &iommu 0x8000 0x8000>,
> -			    <0x8000 &iommu 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (4)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	iommu_a: iommu@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	iommu_b: iommu@b {
> -		reg = <0xb 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	iommu_c: iommu@c {
> -		reg = <0xc 0x1>;
> -		compatible = "vendor,some-iommu";
> -		#iommu-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * Devices with bus number 0-127 are mastered via IOMMU
> -		 * a, with sideband data being RID[14:0].
> -		 * Devices with bus number 128-255 are mastered via
> -		 * IOMMU b, with sideband data being RID[14:0].
> -		 * No devices master via IOMMU c.
> -		 */
> -		iommu-map = <0x0000 &iommu_a 0x0000 0x8000>,
> -			    <0x8000 &iommu_b 0x0000 0x8000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> deleted file mode 100644
> index b73d839657b6..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
> +++ /dev/null
> @@ -1,220 +0,0 @@
> -This document describes the generic device tree binding for describing the
> -relationship between PCI devices and MSI controllers.
> -
> -Each PCI device under a root complex is uniquely identified by its Requester ID
> -(AKA RID). A Requester ID is a triplet of a Bus number, Device number, and
> -Function number.
> -
> -For the purpose of this document, when treated as a numeric value, a RID is
> -formatted such that:
> -
> -* Bits [15:8] are the Bus number.
> -* Bits [7:3] are the Device number.
> -* Bits [2:0] are the Function number.
> -* Any other bits required for padding must be zero.
> -
> -MSIs may be distinguished in part through the use of sideband data accompanying
> -writes. In the case of PCI devices, this sideband data may be derived from the
> -Requester ID. A mechanism is required to associate a device with both the MSI
> -controllers it can address, and the sideband data that will be associated with
> -its writes to those controllers.
> -
> -For generic MSI bindings, see
> -Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> -
> -
> -PCI root complex
> -================
> -
> -Optional properties
> --------------------
> -
> -- msi-map: Maps a Requester ID to an MSI controller and associated
> -  msi-specifier data. The property is an arbitrary number of tuples of
> -  (rid-base,msi-controller,msi-base,length), where:
> -
> -  * rid-base is a single cell describing the first RID matched by the entry.
> -
> -  * msi-controller is a single phandle to an MSI controller
> -
> -  * msi-base is an msi-specifier describing the msi-specifier produced for the
> -    first RID matched by the entry.
> -
> -  * length is a single cell describing how many consecutive RIDs are matched
> -    following the rid-base.
> -
> -  Any RID r in the interval [rid-base, rid-base + length) is associated with
> -  the listed msi-controller, with the msi-specifier (r - rid-base + msi-base).
> -
> -- msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
> -  to an msi-specifier per the msi-map property.
> -
> -- msi-parent: Describes the MSI parent of the root complex itself. Where
> -  the root complex and MSI controller do not pass sideband data with MSI
> -  writes, this property may be used to describe the MSI controller(s)
> -  used by PCI devices under the root complex, if defined as such in the
> -  binding for the root complex.
> -
> -
> -Example (1)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, identity-mapped.
> -		 */
> -		msi-map = <0x0 &msi_a 0x0 0x10000>,
> -	};
> -};
> -
> -
> -Example (2)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, masked to only the device and function bits.
> -		 */
> -		msi-map = <0x0 &msi_a 0x0 0x100>,
> -		msi-map-mask = <0xff>
> -	};
> -};
> -
> -
> -Example (3)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, but the high bit of the bus number is
> -		 * ignored.
> -		 */
> -		msi-map = <0x0000 &msi 0x0000 0x8000>,
> -			  <0x8000 &msi 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (4)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to the MSI controller is
> -		 * the RID, but the high bit of the bus number is
> -		 * negated.
> -		 */
> -		msi-map = <0x0000 &msi 0x8000 0x8000>,
> -			  <0x8000 &msi 0x0000 0x8000>;
> -	};
> -};
> -
> -
> -Example (5)
> -===========
> -
> -/ {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -
> -	msi_a: msi-controller@a {
> -		reg = <0xa 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	msi_b: msi-controller@b {
> -		reg = <0xb 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	msi_c: msi-controller@c {
> -		reg = <0xc 0x1>;
> -		compatible = "vendor,some-controller";
> -		msi-controller;
> -		#msi-cells = <1>;
> -	};
> -
> -	pci: pci@f {
> -		reg = <0xf 0x1>;
> -		compatible = "vendor,pcie-root-complex";
> -		device_type = "pci";
> -
> -		/*
> -		 * The sideband data provided to MSI controller a is the
> -		 * RID, but the high bit of the bus number is negated.
> -		 * The sideband data provided to MSI controller b is the
> -		 * RID, identity-mapped.
> -		 * MSI controller c is not addressable.
> -		 */
> -		msi-map = <0x0000 &msi_a 0x8000 0x08000>,
> -			  <0x8000 &msi_a 0x0000 0x08000>,
> -			  <0x0000 &msi_b 0x0000 0x10000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> deleted file mode 100644
> index 6a8f2874a24d..000000000000
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -PCI bus bridges have standardized Device Tree bindings:
> -
> -PCI Bus Binding to: IEEE Std 1275-1994
> -https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> -
> -And for the interrupt mapping part:
> -
> -Open Firmware Recommended Practice: Interrupt Mapping
> -https://www.devicetree.org/open-firmware/practice/imap/imap0_9d.pdf
> -
> -Additionally to the properties specified in the above standards a host bridge
> -driver implementation may support the following properties:
> -
> -- linux,pci-domain:
> -   If present this property assigns a fixed PCI domain number to a host bridge,
> -   otherwise an unstable (across boots) unique number will be assigned.
> -   It is required to either not set this property at all or set it for all
> -   host bridges in the system, otherwise potentially conflicting domain numbers
> -   may be assigned to root buses behind different host bridges.  The domain
> -   number for each host bridge in the system must be unique.
> -- max-link-speed:
> -   If present this property specifies PCI gen for link capability.  Host
> -   drivers could add this as a strategy to avoid unnecessary operation for
> -   unsupported link speed, for instance, trying to do training for
> -   unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
> -   for gen2, and '1' for gen1. Any other values are invalid.
> -- reset-gpios:
> -   If present this property specifies PERST# GPIO. Host drivers can parse the
> -   GPIO and apply fundamental reset to endpoints.
> -- supports-clkreq:
> -   If present this property specifies that CLKREQ signal routing exists from
> -   root port to downstream device and host bridge drivers can do programming
> -   which depends on CLKREQ signal existence. For example, programming root port
> -   not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> -
> -PCI-PCI Bridge properties
> --------------------------
> -
> -PCIe root ports and switch ports may be described explicitly in the device
> -tree, as children of the host bridge node. Even though those devices are
> -discoverable by probing, it might be necessary to describe properties that
> -aren't provided by standard PCIe capabilities.
> -
> -Required properties:
> -
> -- reg:
> -   Identifies the PCI-PCI bridge. As defined in the IEEE Std 1275-1994
> -   document, it is a five-cell address encoded as (phys.hi phys.mid
> -   phys.lo size.hi size.lo). phys.hi should contain the device's BDF as
> -   0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
> -
> -   The bus number is defined by firmware, through the standard bridge
> -   configuration mechanism. If this port is a switch port, then firmware
> -   allocates the bus number and writes it into the Secondary Bus Number
> -   register of the bridge directly above this port. Otherwise, the bus
> -   number of a root port is the first number in the bus-range property,
> -   defaulting to zero.
> -
> -   If firmware leaves the ARI Forwarding Enable bit set in the bridge
> -   above this port, then phys.hi contains the 8-bit function number as
> -   0b00000000 bbbbbbbb ffffffff 00000000. Note that the PCIe specification
> -   recommends that firmware only leaves ARI enabled when it knows that the
> -   OS is ARI-aware.
> -
> -Optional properties:
> -
> -- external-facing:
> -   When present, the port is external-facing. All bridges and endpoints
> -   downstream of this port are external to the machine. The OS can, for
> -   example, use this information to identify devices that cannot be
> -   trusted with relaxed DMA protection, as users could easily attach
> -   malicious devices to this port.
> -
> -Example:
> -
> -pcie@10000000 {
> -	compatible = "pci-host-ecam-generic";
> -	...
> -	pcie@0008 {
> -		/* Root port 00:01.0 is external-facing */
> -		reg = <0x00000800 0 0 0 0>;
> -		external-facing;
> -	};
> -};
> -- 
> 2.47.2
> 

