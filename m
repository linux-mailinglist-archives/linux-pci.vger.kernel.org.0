Return-Path: <linux-pci+bounces-18644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827609F4EEF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B55D7A5FD0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5DB1F707B;
	Tue, 17 Dec 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNIyrSc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5A1F4E3D;
	Tue, 17 Dec 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448242; cv=none; b=Mxg2SaZrhlnCv+ZEd/uy/WaTVlcphjYfXQ2pP1gk12HCFeUK089YMF8iW1LEpOCrkxqmnxMBQIEvWdxbUv8zrYKZz3EIfS0xRi1vJ9W0aoA6NCeW6VIh6VDS3GswhhrixCh+hh61EeRvCHKEJoz4OyH9RMMFDuiOzOk93r0ip9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448242; c=relaxed/simple;
	bh=LMggsVzwN2kSgQEeNn/tSwOxtfN7qlhVoAGwYEYNS38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG5jKnskXWaQ7NLfb4tGl6Py6qmpKEpdd6tHq2FjT9A58ipvCgh6VlC7but/SQXX5PmmL2DMXdTnMtOPJkfZIvJqAy34wDaZHmbCAE4U/is/P7Lrs7KXf3iiCgRIQYavE1rzR2UMCbJXUx2nK3SGuuBroJR1l8DNSL3PuR7vsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNIyrSc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067EFC4CED3;
	Tue, 17 Dec 2024 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448242;
	bh=LMggsVzwN2kSgQEeNn/tSwOxtfN7qlhVoAGwYEYNS38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNIyrSc2aX9d1rpbFx95IRXM2YtR+wHhrtZmr22cOrRrLxHib1f9ZkuCtfVhh/SX5
	 PUmzDdiSn/5KjRRcv6rbnzefMGe0Nx+Poxg1S3I8EsQ+tV8/IsaXQXQ6IpXeck4aek
	 ba0YLq0tgi59lJri764pVgBH2Zjnu+UPPW3F2yNSMEhs1DkL8gGi4GuoHlZSBGiFbp
	 fYt4f75nRAaLJ4clI7KDh8KVqtGelmXEOM4BrKR9cYfa8bLluvmMTFIyXu+lPhRYyp
	 aa3XcsOvp2PzU0VNH8Br4xDJExbIyoOMYhczhZzHKm6NoqJDTkRT+NUCB71DfQkNpb
	 +W0m90T4RcnKg==
Date: Tue, 17 Dec 2024 09:10:40 -0600
From: Rob Herring <robh@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2
 MDB PCIe Root Port Bridge
Message-ID: <20241217151040.GA1667241-robh@kernel.org>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <20241213064035.1427811-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064035.1427811-3-thippeswamy.havalige@amd.com>

On Fri, Dec 13, 2024 at 12:10:34PM +0530, Thippeswamy Havalige wrote:
> Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> -------------
> - Modify patch subject.
> - Add pcie host bridge reference.
> - Modify filename as per compatible string.
> - Remove standard PCI properties.
> - Modify interrupt controller description.
> - Indentation
> 
> Changes in v3:
> -------------
> - Modified SLCR to lower case.
> - Add dwc schemas.
> - Remove common properties.
> - Move additionalProperties below properties.
> - Remove ranges property from required properties.
> - Drop blank line.
> - Modify pci@ to pcie@
> 
> Changes in v4:
> -------------
> - None.
> 
> Changes in v5:
> -------------
> - None.
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> new file mode 100644
> index 000000000000..c319adeeee66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: amd,versal2-mdb-host
> +
> +  reg:
> +    items:
> +      - description: MDB PCIe controller 0 SLCR
> +      - description: configuration region
> +      - description: data bus interface
> +      - description: address translation unit register
> +
> +  reg-names:
> +    items:
> +      - const: mdb_pcie_slcr
> +      - const: config
> +      - const: dbi
> +      - const: atu
> +
> +  ranges:
> +    maxItems: 2
> +
> +  msi-map:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - interrupt-controller
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@ed931000 {
> +            compatible = "amd,versal2-mdb-host";
> +            reg = <0x0 0xed931000 0x0 0x2000>,
> +                  <0x1000 0x100000 0x0 0xff00000>,
> +                  <0x1000 0x0 0x0 0x100000>,

DBI space is 1MB? Last I checked, there's less than 4KB worth of 
registers.

The address looks odd. The config space is purely iATU configuration. 
Really, we should have described the entire address space (like the 
endpoint) available to the ATU. So the 1MB offset in the base 
address seems like just that. Most h/w design to cut down signal 
routing would put the base address for the ATU input at something 
aligned greater than the size of the address space. 

> +                  <0x0 0xed860000 0x0 0x2000>;

And then the DBI and ATU registers are nowhere near each other? 
Possible, but seems odd.

> +            reg-names = "mdb_pcie_slcr", "config", "dbi", "atu";
> +            ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x10000000>,
> +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000000>;
> +            interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent = <&gic>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> +                            <0 0 0 2 &pcie_intc_0 1>,
> +                            <0 0 0 3 &pcie_intc_0 2>,
> +                            <0 0 0 4 &pcie_intc_0 3>;
> +            msi-map = <0x0 &gic_its 0x00 0x10000>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            device_type = "pci";
> +            pcie_intc_0: interrupt-controller {
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +                interrupt-controller;
> +           };
> +        };
> +    };
> -- 
> 2.34.1
> 

