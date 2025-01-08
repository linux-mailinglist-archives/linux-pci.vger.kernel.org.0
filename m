Return-Path: <linux-pci+bounces-19575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33AEA06939
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81EA3A765D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479B204F84;
	Wed,  8 Jan 2025 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbB9nSuh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D57204C16;
	Wed,  8 Jan 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736377515; cv=none; b=Y2T2kOSrW+STp+3qsuDM3gHHlD6q4UC+eCuJzPGci+ITWQuAHtQBm0UnYoDbTyUbBnGM3qHF2+THE2oXptps5BcKBbQFqSWeId44JmvlESRcU8IOSytFnHT6SWxmQbbDkwnCcGa3fmzjRITjIMtwMuN5wGhNwowN9pJ7UWbXCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736377515; c=relaxed/simple;
	bh=CEx2keLXyISFWzlAHM0elee+jBtbjpYzQM1lS6MyArU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BjDSvsnsBMXUa2xlsb4EqMbbbqfpWFerbAbtVGFzLnLhSzJUS4AXoSupQgmtB2UdzQpeqviBQg3KSzt1FJ4YN5+15Srj6hE/h7X6F+MaXl2D6WDiVhCO85TazRDVBoU5qWwFqKADstLutv4+70D+7RkcWAxjvbVYT8SMZvo/PEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbB9nSuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF094C4CEE2;
	Wed,  8 Jan 2025 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736377514;
	bh=CEx2keLXyISFWzlAHM0elee+jBtbjpYzQM1lS6MyArU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tbB9nSuhdajIDS7pQiJIo2+q3uAMn87KxtdHXkPpvfdPTxNhfSzeFokVYcPOMgZw4
	 JA/BeKa6wL6YYWUmZpLJmlbfhetQm0dQtUbP6JgoUGZ4nK2nXMGOJijIIPU0XEwCtf
	 ZwULP4wYQ+t9YBPZIhEhjCPjouY4ZVKkJQXSBP5fAn7RbvUp8z4+kEqJiIhu4xF6i4
	 IiAytL+PUu6ghZRbOaPj3yskJOy1dDHLf+nwK5N5JXeBT8Rxelre1HVEG40MSPFyhJ
	 q0ULbwgTrsKfZ5MkrYi7d93gRd7f3A4Z/jWzpntohjg5MWKv1PwAgrO20LSVvc5pFt
	 l0Nzt0mQnoCjA==
Date: Wed, 8 Jan 2025 17:05:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, matthew.gerlach@altera.com
Subject: Re: [PATCH v3 3/5] arm64: dts: agilex: add dtsi for PCIe Root Port
Message-ID: <20250108230512.GA236229@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90879a6-979b-9b7f-1df8-44e8e1b7a23@linux.intel.com>

On Wed, Jan 08, 2025 at 02:53:50PM -0800, matthew.gerlach@linux.intel.com wrote:
> On Wed, 8 Jan 2025, Bjorn Helgaas wrote:
> > On Wed, Jan 08, 2025 at 10:59:07AM -0600, Matthew Gerlach wrote:
> > > Add the base device tree for support of the PCIe Root Port
> > > for the Agilex family of chips.
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v3:
> > >  - Remove accepted patches from patch set.
> > > 
> > > v2:
> > >  - Rename node to fix schema check error.
> > > ---
> > >  .../intel/socfpga_agilex_pcie_root_port.dtsi  | 55 +++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> > > new file mode 100644
> > > index 000000000000..50f131f5791b
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_pcie_root_port.dtsi
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier:     GPL-2.0
> > > +/*
> > > + * Copyright (C) 2024, Intel Corporation
> > > + */
> > > +&soc0 {
> > > +	aglx_hps_bridges: fpga-bus@80000000 {
> > > +		compatible = "simple-bus";
> > > +		reg = <0x80000000 0x20200000>,
> > > +		      <0xf9000000 0x00100000>;
> > > +		reg-names = "axi_h2f", "axi_h2f_lw";
> > > +		#address-cells = <0x2>;
> > > +		#size-cells = <0x1>;
> > > +		ranges = <0x00000000 0x00000000 0x80000000 0x00040000>,
> > > +			 <0x00000000 0x10000000 0x90100000 0x0ff00000>,
> > > +			 <0x00000000 0x20000000 0xa0000000 0x00200000>,
> > > +			 <0x00000001 0x00010000 0xf9010000 0x00008000>,
> > > +			 <0x00000001 0x00018000 0xf9018000 0x00000080>,
> > > +			 <0x00000001 0x00018080 0xf9018080 0x00000010>;
> > > +
> > > +		pcie_0_pcie_aglx: pcie@200000000 {
> > > +			reg = <0x00000000 0x10000000 0x10000000>,
> > > +			      <0x00000001 0x00010000 0x00008000>,
> > > +			      <0x00000000 0x20000000 0x00200000>;
> > > +			reg-names = "Txs", "Cra", "Hip";
> > > +			interrupt-parent = <&intc>;
> > > +			interrupts = <GIC_SPI 0x14 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-controller;
> > > +			#interrupt-cells = <0x1>;
> > > +			device_type = "pci";
> > > +			bus-range = <0x0000000 0x000000ff>;
> > 
> > I don't think this bus-range is needed since
> > pci_parse_request_of_pci_ranges() defaults to 00-ff when bus-range is
> > absent.
> 
> Yes, pci_parse_request_of_pci_ranges() does default to using 00-ff when the
> bus-range property is absent. Removing the bus-range property does result in
> an extra kernel message at startup:
>     No bus range found for ...,using [bus 00-ff].
> 
> If the extra kernel message is not a problem, then removing the bus-range
> property does result in a smaller device tree.

Interesting, I think we should remove that message.

