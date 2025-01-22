Return-Path: <linux-pci+bounces-20254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8ACA19ACF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 23:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2252816067C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08D1C5D5E;
	Wed, 22 Jan 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLpMLA+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE111BBBFE;
	Wed, 22 Jan 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584511; cv=none; b=SD8O6/mPw06d1ScGKFRtPUuZKuOmqupYS7SpSR3833wxePyH/9kbiRztNM7Q4iRBAB3DVzi0UCSPTPYdA2k5X3N/T9F/9nNx9zneS7W3fFC22/k2JFQHkh2BsiN46ymn984BD+XwEnBdrBshIJjZW7ggw/iaRQp7+VcVWHqqZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584511; c=relaxed/simple;
	bh=AzO+JSyUzXy+qOi48e/wWlbvtBwFmI982O1QafOWLBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y0+tFeizAul2r/xqigalBWV83SaLUdvUlGwOrajPRKyOEnUNwNLb7eW/CPCl6dZ0WC5MPEEhea+QONhvZPwa2bYALt6mo0+1bzCjPNLNXdnJdMUGtDVbZGuGjQTSbRj4+PY1Oc8qAxBVNTZOMQ928DyHNYv4X3F2O4Wi7ptCdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLpMLA+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD0BC4CED2;
	Wed, 22 Jan 2025 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737584510;
	bh=AzO+JSyUzXy+qOi48e/wWlbvtBwFmI982O1QafOWLBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YLpMLA+fOsLxhzm+tRIKfItoVnMCSXfHODRhiGgrbOreEEFRijdrx1EMv6n1ekqUx
	 MDUDM9CK6pNTZ29qBiHhZO0TKxQiP3/Y7W4M2/PfepN8vREFabp2BSIe7Okfg839vV
	 x3kLPG2WWkjldTHsuAlmiL75boIz/uFBfP2sWilWKCUYQSq5FvdHTvtPMj6UXD0tcP
	 KYzbhmexHmIO6+KCzEnS3E7pNjBwYPQovyeH/2g9Ad1s1gj2Gd0h2RZ8higcDSMTeZ
	 gDCP7W3vXZ7hwtuBRhiTfIkpJSRaga5lzrB39Y9vtjJEsOeO11rcqSmfKVoVQsXPGE
	 vQJ7pTEerJ7Hg==
Date: Wed, 22 Jan 2025 16:21:47 -0600
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
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250122222147.GA1117670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>

On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 PCIe host controller.

> +  sophgo,link-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
> +      & link1 as Cadence's term). Each core corresponds to a host bridge,
> +      and each host bridge has only one root port. Their configuration
> +      registers are completely independent. SG2042 integrates two Cadence IPs,
> +      so there can actually be up to four host bridges. "sophgo,link-id" is
> +      used to identify which core/link the PCIe host bridge node corresponds to.

IIUC, the registers of Cadence IP 1 and IP 2 are completely
independent, and if you describe both of them, you would have separate
"pcie@62000000" stanzas with separate 'reg' and 'ranges' properties.

From the driver, it does not look like the registers for Link0 and
Link1 are independent, since the driver claims the
"sophgo,sg2042-pcie-host", which includes two Cores, and it tests
pcie->link_id to select the correct register address and bit mask.

"sophgo,link-id" corresponds to Cadence documentation, but I think it
is somewhat misleading in the binding because a PCIe "Link" refers to
the downstream side of a Root Port.  If we use "link-id" to identify
either Core0 or Core1 of a Cadence IP, it sort of bakes in the
idea that there can never be more than one Root Port per Core.

Since each Core is the root of a separate PCI hierarchy, it seems like
maybe there should be a stanza for the Core so there's a place where
per-hierarchy things like "linux,pci-domain" properties could go,
e.g.,

  pcie@62000000 {		// IP 1, single-link mode
    compatible = "sophgo,sg2042-pcie-host";
    reg = <...>;
    ranges = <...>;

    core0 {
      sophgo,core-id = <0>;
      linux,pci-domain = <0>;

      port {
        num-lanes = <4>;	// all lanes
      };
    };
  };

  pcie@82000000 {		// IP 2, dual-link mode
    compatible = "sophgo,sg2042-pcie-host";
    reg = <...>;
    ranges = <...>;

    core0 {
      sophgo,core-id = <0>;
      linux,pci-domain = <1>;

      port {
        num-lanes = <2>;	// half of lanes
      };
    };

    core1 {
      sophgo,core-id = <1>;
      linux,pci-domain = <2>;

      port {
        num-lanes = <2>;	// half of lanes
      };
    };
  };

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
> +
> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
> +
> +                     +-- Core (Link0) <---> pcie_rc0  +-----------------+
> +                     |                                |                 |
> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
> +                     |                                |                 |
> +                     +-- Core (Link1) <---> disabled  +-----------------+
> +
> +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
> +                     |                                |                 |
> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> +                     |                                |                 |
> +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
> +
> +      pcie_rcX is PCIe node ("sophgo,sg2042-pcie-host") defined in DTS.
> +
> +      Sophgo defines some new register files to add support for their MSI
> +      controller inside PCIe. These new register files are defined in DTS as
> +      syscon node ("sophgo,sg2042-pcie-ctrl"), i.e. "cdns_pcie0_ctrl" /
> +      "cdns_pcie1_ctrl". cdns_pcieX_ctrl contains some registers shared by
> +      pcie_rcX, even two RC (Link)s may share different bits of the same
> +      register. For example, cdns_pcie1_ctrl contains registers shared by
> +      link0 & link1 for Cadence IP 2.
> +
> +      "sophgo,link-id" is defined to distinguish the two RC's in one Cadence IP,
> +      so we can know what registers (bits) we should use.

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
> +      bus-range = <0x00 0xff>;
> +      vendor-id = <0x1f1c>;
> +      device-id = <0x2042>;
> +      cdns,no-bar-match-nbits = <48>;
> +      sophgo,link-id = <0>;
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

It would be helpful for me if the example showed how both link-id 0
and link-id 1 would be used (or whatever they end up being named).
I assume both have to be somewhere in the same pcie@62000000 device to
make this work.

Bjorn

