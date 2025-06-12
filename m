Return-Path: <linux-pci+bounces-29576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F15AD78D7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55623B5656
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3B248F50;
	Thu, 12 Jun 2025 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3cj0ZP3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E72F431F;
	Thu, 12 Jun 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748777; cv=none; b=tZQA+r8GcqDJU0T1+Q1Hb9req5RMsdpb9o9tbkvoYt6Vz73fG2KEs4UKJafteKVET5pqtgCE7YU2AlQRe1f+3/pv6VV49Y/IQYPWrODjunni5SQKkDmpGWpu7ep4VOkca4H27CjRrrFX1wsTjsDMAe2gNSw8Q3fo1NzM62Bi3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748777; c=relaxed/simple;
	bh=KAMMKqVzdsVuZnPOPaGfiqiMehOKnAmXFo814aZimys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBq1VhZUWm6Bo8e88JyYSaWEjrAu/nQ4fn8GOaOkYBg6O8HqJKDJQBEaRap8ucUTaGRZY2ZT84hKvyohXt8JzszkpMComrL82yiDUK7jR/tKTeEYmTA9IkBDPq/C3NyDRFEUjwDqCEl9h72tbn+e2FgeyDdHoTz0g6pssvHWlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3cj0ZP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1693AC4CEEA;
	Thu, 12 Jun 2025 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749748774;
	bh=KAMMKqVzdsVuZnPOPaGfiqiMehOKnAmXFo814aZimys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3cj0ZP3QdZuDv5oZ43tHa4gOcrJFLLmFd1jglvQZtbp6q9AhBXLZbDz98A5oNpd8
	 9J1zryk3EmAXlb04ta1Gio1chgeG5g9qC00y/16DgfEng7+PI/nJPhpyT+N7y4e9oT
	 J1zuESkffa0raNlfO4zVr8sKEpQvZUsomcE/LT1oe6AC1jSdaWg8e+a/H4ksDpghkM
	 GA1d7R30+fL0zw+rtB1Bxr1FUyAfVfcsRJJ7vg1LdDL4D7jH3UdQGO3a5scUV0h6ib
	 Zk5bnWbzAdZOF3m+sGr6qAvAa6ViAw4dQ7B3B0S1FzgQWnwvQ6BF35t/xosVV/nOoD
	 wplhGqANytO2A==
Date: Thu, 12 Jun 2025 22:49:25 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Message-ID: <mwv2twlpknjecqf2ck2t3vcainvcitikblvylpd73mtzlhklfq@odmoplmctgy5>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
 <20250414032304.862779-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414032304.862779-3-sai.krishna.musham@amd.com>

On Mon, Apr 14, 2025 at 08:53:04AM +0530, Sai Krishna Musham wrote:
> Add support for handling the PCIe Root Port (RP) PERST# signal using
> the GPIO framework, along with the PCIe IP reset. This reset is
> managed by the driver and occurs after the Initial Power Up sequence
> (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
> function is called.
> 
> This reset mechanism is particularly useful in warm reset scenarios,
> where the power rails remain stable and only PERST# signal is toggled
> through the driver. Applying both the PCIe IP reset and the PERST#
> improves the reliability of the reset process by ensuring that both
> the Root Port controller and the Endpoint are reset synchronously
> and avoid lane errors.
> 
> Adapt the implementation to use the GPIO framework for reset signal
> handling and make this reset handling optional, along with the
> `cpm_crx` property, to maintain backward compatibility with existing
> device tree binaries (DTBs).
> 
> Additionally, clear Firewall after the link reset for CPM5NC to allow
> further PCIe transactions.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes for v7:
> - Use platform_get_resource_byname() to make cpm_crx and cpm5nc_fw_attr
>   optional
> - Use 100us delay T_PERST as per PCIe spec before PERST# deassert.
> 
> Changes for v6:
> - Correct version check condition of CPM5NC_HOST.
> 
> Changes for v5:
> - Handle probe defer for reset_gpio.
> - Resolve ABI break.
> 
> Changes for v4:
> - Add PCIe PERST# support for CPM5NC.
> - Add PCIe IP reset along with PERST# to avoid Link Training Errors.
> - Remove PCIE_T_PVPERL_MS define and PCIE_T_RRS_READY_MS after
>   PERST# deassert.
> - Move PCIe PERST# assert and deassert logic to
>   xilinx_cpm_pcie_init_port() before cpm_pcie_link_up(), since
>   Interrupts enable and PCIe RP bridge enable should be done after
>   Link up.
> - Update commit message.
> 
> Changes for v3:
> - Use PCIE_T_PVPERL_MS define.
> 
> Changes for v2:
> - Make the request GPIO optional.
> - Correct the reset sequence as per PERST#
> - Update commit message
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 97 +++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 13ca493d22bd..c46642417d52 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -6,6 +6,8 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> @@ -21,6 +23,13 @@
>  #include "pcie-xilinx-common.h"
>  
>  /* Register definitions */
> +#define XILINX_CPM_PCIE0_RST		0x00000308
> +#define XILINX_CPM5_PCIE0_RST		0x00000318
> +#define XILINX_CPM5_PCIE1_RST		0x0000031C
> +#define XILINX_CPM5NC_PCIE0_RST		0x00000324
> +
> +#define XILINX_CPM5NC_PCIE0_FRWALL	0x00000140
> +
>  #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
>  #define XILINX_CPM_PCIE_REG_IMR		0x00000E14
>  #define XILINX_CPM_PCIE_REG_PSCR	0x00000E1C
> @@ -93,12 +102,16 @@ enum xilinx_cpm_version {
>   * @ir_status: Offset for the error interrupt status register
>   * @ir_enable: Offset for the CPM5 local error interrupt enable register
>   * @ir_misc_value: A bitmask for the miscellaneous interrupt status
> + * @cpm_pcie_rst: Offset for the PCIe IP reset
> + * @cpm5nc_fw_rst: Offset for the CPM5NC Firewall
>   */
>  struct xilinx_cpm_variant {
>  	enum xilinx_cpm_version version;
>  	u32 ir_status;
>  	u32 ir_enable;
>  	u32 ir_misc_value;
> +	u32 cpm_pcie_rst;
> +	u32 cpm5nc_fw_rst;
>  };
>  
>  /**
> @@ -106,6 +119,8 @@ struct xilinx_cpm_variant {
>   * @dev: Device pointer
>   * @reg_base: Bridge Register Base
>   * @cpm_base: CPM System Level Control and Status Register(SLCR) Base
> + * @crx_base: CPM Clock and Reset Control Registers Base
> + * @cpm5nc_fw_base: CPM5NC Firewall Attribute Base
>   * @intx_domain: Legacy IRQ domain pointer
>   * @cpm_domain: CPM IRQ domain pointer
>   * @cfg: Holds mappings of config space window
> @@ -118,6 +133,8 @@ struct xilinx_cpm_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
>  	void __iomem			*cpm_base;
> +	void __iomem			*crx_base;
> +	void __iomem			*cpm5nc_fw_base;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*cpm_domain;
>  	struct pci_config_window	*cfg;
> @@ -475,12 +492,57 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie *port)
>   * xilinx_cpm_pcie_init_port - Initialize hardware
>   * @port: PCIe port information
>   */
> -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  {
>  	const struct xilinx_cpm_variant *variant = port->variant;
> +	struct device *dev = port->dev;
> +	struct gpio_desc *reset_gpio;
> +	bool do_reset = false;
> +
> +	if (port->crx_base && (variant->version < CPM5NC_HOST ||
> +			       (variant->version == CPM5NC_HOST &&
> +				port->cpm5nc_fw_base))) {
> +		/* Request the GPIO for PCIe reset signal and assert */
> +		reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +		if (IS_ERR(reset_gpio))
> +			return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +					     "Failed to request reset GPIO\n");
> +		if (reset_gpio)
> +			do_reset = true;
> +	}
> +
> +	if (do_reset) {
> +		/* Assert the PCIe IP reset */
> +		writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
> +
> +		/*
> +		 * "PERST# active time", as per Table 2-10: Power Sequencing
> +		 * and Reset Signal Timings of the PCIe Electromechanical
> +		 * Specification, Revision 6.0, symbol "T_PERST".
> +		 */
> +		udelay(100);
> +

Are you sure that you need T_PERST here and not T_PVPERL? T_PERST is only valid
while resuming from D3Cold i.e., after power up, while T_PVPERL is valid during
the power up, which is usually the case when a controller driver probes. Is your
driver relying on power being enabled by the bootloader and the driver just
toggling PERST# to perform conventional reset of the endpoint?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

