Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262AE16BF33
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBYK6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 05:58:15 -0500
Received: from foss.arm.com ([217.140.110.172]:49144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgBYK6P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 05:58:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B426C31B;
        Tue, 25 Feb 2020 02:58:14 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E928E3F6CF;
        Tue, 25 Feb 2020 02:58:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:58:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 1/2] PCI: Versal CPM: Add device tree binding forversal
 CPM host controller
Message-ID: <20200225105808.GA5089@e121166-lin.cambridge.arm.com>
References: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1576842072-32027-2-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576842072-32027-2-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 05:11:11PM +0530, Bharat Kumar Gogada wrote:
> Adding device tree binding documentation for versal CPM Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> new file mode 100644
> index 0000000..35f8556
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> @@ -0,0 +1,66 @@
> +* Xilinx Versal CPM DMA Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "xlnx,versal-cpm-host-1.00"
> +- reg: Should contain configuration space (includes bridge registers) and
> +	CPM system level control and status registers, and length
> +- reg-names: Must include the following entries:
> +	"cfg": configuration space region and bridge registers
> +	"cpm_slcr": CPM system level control and status registers
> +- interrupts: Should contain AXI PCIe interrupt
> +- interrupt-map-mask,
> +  interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +- msi-map: Maps a Requester ID to an MSI controller and associated MSI
> +	sideband data
> +- interrupt-names: Must include the following entries:
> +	"misc": interrupt asserted when legacy or error interrupt is received
> +
> +Interrupt controller child node
> ++++++++++++++++++++++++++++++++
> +Required properties:
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #address-cells: specifies the number of cells needed to encode an
> +	address. The value must be 0.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +
> +
> +Refer to the following binding document for more detailed description on
> +the use of 'msi-map':
> +	 Documentation/devicetree/bindings/pci/pci-msi.txt
> +
> +Example:
> +	pci@fca10000 {
> +		#address-cells = <3>;
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		compatible = "xlnx,versal-cpm-host-1.00";
> +		interrupt-map = <0 0 0 1 &pcie_intc_0 1>,
> +				<0 0 0 2 &pcie_intc_0 2>,
> +				<0 0 0 3 &pcie_intc_0 3>,
> +				<0 0 0 4 &pcie_intc_0 4>;

This is wrong, interrupts map to pin 0,1,2,3 of pcie_intc.

That's what's forcing you to use the pci_irqd_intx_xlate()
function and that's completely wrong.

I should find a way to write a common binding for all the
host bridges interrupt-map since this comes up over and over
again.

Please have a look at:

Documentation/devicetree/bindings/pci/faraday,ftpci100.txt


> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-parent = <&gic>;
> +		interrupt-names = "misc";
> +		interrupts = <0 72 4>;
> +		ranges = <0x02000000 0x00000000 0xE0000000 0x0 0xE0000000 0x00000000 0x10000000>,
> +			 <0x43000000 0x00000080 0x00000000 0x00000080 0x00000000 0x00000000 0x80000000>;
> +		msi-map = <0x0 &its_gic 0x0 0x10000>;
> +		reg = <0x6 0x00000000 0x0 0x1000000>,
> +		      <0x0 0xFCA10000 0x0 0x1000>;
> +		reg-names = "cfg", "cpm_slcr";
> +		pcie_intc_0: pci-interrupt-controller {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller ;
> +		};
> +	};
> -- 
> 2.7.4
> 
