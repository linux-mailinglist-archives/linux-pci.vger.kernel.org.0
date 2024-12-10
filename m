Return-Path: <linux-pci+bounces-18040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3C9EB85B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F63285737
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323B86341;
	Tue, 10 Dec 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T39kgcRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522923ED49;
	Tue, 10 Dec 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852032; cv=none; b=J6R9qkbKo16RFXRaXin+MT4ic4xVVHwvXGqyScCutxZTdeF9awA00ROeRh7t3HA0e70t/xWSEfKYitqVrMA3+Lr9Vnjk84g9xlGYayKWexrFDJ565d4wGzVwpZFCcKppIiOu3zPHONvh1GBO8C/eAjIXqlClFxK4Ew9lTtCzo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852032; c=relaxed/simple;
	bh=ew+3ZtWBeaC/eFtZKLcAyztF4BPk9mI0PuL1WaDabJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PEmfnRn+AmkESXVGBGmPtWWQjnwEMV9PmEX5vVVKS1BFFwY0p29ARYIlnvJ/3QnqqmMHJsS8NDAfLI+Hn1LV73k8o1NIcbRAN/u6lU+9phr/mwSoknhJzXcpKWpkmqCcBVMPBW3ITAUK8zfsAgNBrdiGKPCk3LeOETEyqDtS9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T39kgcRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8385C4CED6;
	Tue, 10 Dec 2024 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733852031;
	bh=ew+3ZtWBeaC/eFtZKLcAyztF4BPk9mI0PuL1WaDabJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=T39kgcRf3GFXq4r2FXd0HCkM16w7yJpDM6dZFXf3pqdOuuqPtBo4O6XSg0ZYamK6c
	 uBM6kqoqiwa3v9XO4Um8GxmNm4IJVDVdbjCj4c3zDc2nSa1xCQgZYXtVSkfH1LIYo8
	 KvJina1zVOVksS411aPbRFITFJs7c7OAwDRViN+iBcgKak4I+TQ1zuWJToaL3IXb9C
	 JF5A2p6NaxoDV3vgnC0+tF2+X1Ih17zdfVCYOLgTk67ZwCVCftsO3iXY3w3/dRvI8M
	 7y1VBY9/afIPa/Mb7hjISoSDG/BftkD/w9XpVjT1XWbVCXgrXfxHP3ezku8c3xgA9X
	 /C/Cc1cvfEqkw==
Date: Tue, 10 Dec 2024 11:33:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20241210173350.GA3222084@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05998df400a64734308e986069ca0b337618e464.1733726572.git.unicorn_wang@outlook.com>

On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
> Add binding for Sophgo SG2042 PCIe host controller.

> +  sophgo,pcie-port:

This is just an index, isn't it?  I don't see why it should include
"sophgo" unless it encodes something sophgo-specific.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SG2042 uses Cadence IP, every IP is composed of 2 cores(called link0

Add space before "(".  More instances below.

> +      & link1 as Cadence's term). "sophgo,pcie-port" is used to identify which
> +      core/link the pcie host controller node corresponds to.

s/pcie/PCIe/ for consistency in the text.  More instances below.

> +      The Cadence IP has two modes of operation, selected by a strap pin.
> +
> +      In the single-link mode, the Cadence PCIe core instance associated
> +      with Link0 is connected to all the lanes and the Cadence PCIe core
> +      instance associated with Link1 is inactive.
> +
> +      In the dual-link mode, the Cadence PCIe core instance associated
> +      with Link0 is connected to the lower half of the lanes and the
> +      Cadence PCIe core instance associated with Link1 is connected to
> +      the upper half of the lanes.

I assume this means there are two separate Root Ports, one for Link0
and a second for Link1?

> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
> +
> +                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
> +                     |                                |                 |
> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
> +                     |                                |                 |
> +                     +-- Core(Link1) <---> disabled   +-----------------+
> +
> +                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
> +                     |                                |                 |
> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> +                     |                                |                 |
> +                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
> +
> +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
> +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
> +
> +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
> +      RC(Link)s may share different bits of the same register. For example,
> +      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.

An RC doesn't have a Link.  A Root Port does.

> +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
> +      this we can know what registers(bits) we should use.
> +
> +  sophgo,syscon-pcie-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the PCIe System Controller DT node. It's required to
> +      access some MSI operation registers shared by PCIe RCs.

I think this probably means "shared by PCIe Root Ports", not RCs.
It's unlikely that this hardware has multiple Root Complexes.

> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - vendor-id
> +  - device-id
> +  - sophgo,syscon-pcie-ctrl
> +  - sophgo,pcie-port

It looks like vendor-id and device-id apply to PCI devices, i.e.,
things that will show up in lspci, I assume Root Ports in this case.
Can we make this explicit in the DT, e.g., something like this?

  pcie@62000000 {
    compatible = "sophgo,sg2042-pcie-host";
    port0: pci@0,0 {
      vendor-id = <0x1f1c>;
      device-id = <0x2042>;
    };

> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pcie@62000000 {
> +      compatible = "sophgo,sg2042-pcie-host";
> +      device_type = "pci";
> +      reg = <0x62000000  0x00800000>,
> +            <0x48000000  0x00001000>;
> +      reg-names = "reg", "cfg";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +      bus-range = <0x80 0xbf>;
> +      vendor-id = <0x1f1c>;
> +      device-id = <0x2042>;
> +      cdns,no-bar-match-nbits = <48>;
> +      sophgo,pcie-port = <0>;
> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> +      msi-parent = <&msi_pcie>;
> +      msi_pcie: msi {
> +        compatible = "sophgo,sg2042-pcie-msi";
> +        msi-controller;
> +        interrupt-parent = <&intc>;
> +        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +      };
> +    };
> -- 
> 2.34.1
> 

