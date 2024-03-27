Return-Path: <linux-pci+bounces-5294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317E88F0E2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40E11F2F6FD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514DA153560;
	Wed, 27 Mar 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2wKEk/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BE4CB38;
	Wed, 27 Mar 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574792; cv=none; b=MltJqdRT03d2MftDWCc1JxuuJw7gPa3iC8IaHiD3ifEbqnofkOsLWpLJEoY81aCBdDMN7FWIHAXGPxiJxLSkz+WKtR7tCq7Hp3yMwBeupcTg+oKTHMv1G7IILA7r02JrNpEwsMc16/vRW0jg15L4/M/ux1qSONtZFjriihGQxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574792; c=relaxed/simple;
	bh=Wj0CQ4VM2u/E63IBHO/QtJw33yqvmZQ+FRrokKwKLyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QQ5RDRW47DhUezWtiQ8iXd9jlwgQzHxalpkbLpjEmtOFPpTkmbpKlqg+p6u+2+3OBIELky7DL+KJMu+ljbiJfVZv8kWGXZBcSscFtZ6Ov6CyxTIwXcC01Ir27vI0+Y4cUxx0qT4XqXGTeCmuBktLmQZr0gKwpjTX3e960lBfgyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2wKEk/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BE1C433C7;
	Wed, 27 Mar 2024 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711574791;
	bh=Wj0CQ4VM2u/E63IBHO/QtJw33yqvmZQ+FRrokKwKLyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i2wKEk/dhLTWhIigLIE23AM7jRLjmWJ1FusMg/PGhuVZT2lB2gONKjltObA18147i
	 RZ3ZTTR+ciw2a7q6mVm3NVHU3mGnTMqzsyLcIbKvIckxMUTU0sXiMFlyXNiyhwBV9M
	 5icxS+zNn6VIqrGAlTGt6n44gHzgBg6szKXExbjIMBZ+A8JuaFutocnUVcjQTuSIEh
	 fUL5iOWlzvjgtNZVwfZnWpVEt+p3UjK8OdSFBBqTyfmGOFCUKozBvRtogy/tHXgBa3
	 /K76ZQ6pX3J4wVCk+OdNO2gDGtzRGPSYS6YClzWVmaINKgiCJtfP63SoXa2eD0XZ6P
	 uGgeiI16UNYKg==
Date: Wed, 27 Mar 2024 16:26:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com,
	lukas@wunner.de
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240327212629.GA1533990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325235914.1897647-2-dave.jiang@intel.com>

On Mon, Mar 25, 2024 at 04:58:01PM -0700, Dave Jiang wrote:
> Per CXL spec r3.1 8.1.5.2, secondary bus reset is masked unless the
> "Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
> path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
> the CXL Port Control Extensions register by returning -ENOTTY.

s/secondary bus reset/Secondary Bus Reset (SBR)/
to show that this is defined by PCIe spec and introduce the
initialism.

> With the current behavior, the bus_reset would appear to have executed
> successfully, however the operation is actually masked if the "Unmask
> SBR" bit is set with the default value. The intention is to inform the
> user that SBR for the CXL device is masked and will not go through.

The default value of Unmask SBR isn't really relevant here.

> The expectation is that if a user overrides the "Unmask SBR" via a
> user tool such as setpci then they can trigger a bus reset successfully.

... if a user *sets* Unmask SBR ...
to be more specific about what value is required.

> Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Rename is_cxl_device() to pci_is_cxl(). (Lukas)
> - Inverse xmas tree var declaration for is_cxl_port_sbr_masked(). (Lukas)
> - Return -ENOTTY on error of reset method. (Lukas)
> - Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
> - Additional explanation in commit log on behavior. (Lukas)
> ---
>  drivers/cxl/cxlpci.h          |  2 --
>  drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  7 ++++++
>  3 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..55be4dccbed0 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -13,10 +13,8 @@
>   * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> -#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
>  
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
>  #define   CXL_DVSEC_CAP_OFFSET		0xA
>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e5f243dd4288..259e5d6538bb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static bool pci_is_cxl(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_PCIE_DEVICE);
> +}
> +
> +static bool is_cxl_port_sbr_masked(struct pci_dev *dev)

s/is_cxl_port_sbr_masked/cxl_sbr_masked/ or similar

> +{
> +	int dvsec;

u16

> +	u16 reg;
> +	int rc;
> +
> +	/*
> +	 * No DVSEC found, must not be CXL port.
> +	 */
> +	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_PORT);
> +	if (!dvsec)
> +		return false;
> +
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CONTROL, &reg);
> +	if (rc)
> +		return true;
> +
> +	/*
> +	 * CXL spec r3.1 8.1.5.2
> +	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
> +	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
> +	 * Control gets set to 1.
> +	 */
> +	if (reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
>  	int rc;
>  
> +	/* If it's a CXL port and the SBR control is masked, fail the SBR */
> +	if (pci_is_cxl(dev) && bridge && is_cxl_port_sbr_masked(bridge)) {

This sounds like solely a property of the bridge, so why do we care
what "dev" is?  I assume SBR is asserted in the standard PCIe way, and
the only question is whether the bridge itself masks it.  Would this
be enough?

  if (bridge && is_cxl_port_sbr_masked(bridge))

> +		if (probe)
> +			return 0;
> +
> +		return -ENOTTY;
> +	}
> +
>  	rc = pci_dev_reset_slot_function(dev, probe);
>  	if (rc != -ENOTTY)
>  		return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a39193213ff2..5f2c66987299 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1148,4 +1148,11 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
> +/* Compute Express Link (CXL) */
> +#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98

I see that you're just moving this #define from drivers/cxl/cxlpci.h,
but I'm scratching my head a bit.  As used here, this is to match the
DVSEC Vendor ID (PCIe r6.0, sec 7.9.6.2).

IIUC, this should be just a PCI SIG-defined "Vendor ID", e.g.,
"PCI_VENDOR_ID_CXL", that doesn't need the "DVSEC" qualifier in the
name, and would normally be defined in include/linux/pci_ids.h.

But I don't see CXL in pci_ids.h, and I don't see either "CXL" or the
value "1e98" in the PCI SIG list at
https://pcisig.com/membership/member-companies.

> +#define CXL_DVSEC_PCIE_DEVICE				0

I think this is the "DVSEC ID" (PCIe r6.0, sec 7.9.6.3), right?  And
the "0" value comes from CXL r3.1, sec 8.1.3?

Sec 8.1.3 says "Software may use the presence of this DVSEC to
differentiate between a CXL device and a PCIe device. As such, a
standard PCIe device must not expose this DVSEC."

I think the "PCIE" in the name here may end up being confusing since
the presence of this DVSEC means the device is a CXL device, *not* a
standard PCIe device.

> +#define CXL_DVSEC_PCIE_PORT				3

And "3" comes from CXL r3.1, sec 8.1.5?

Same here; I'm not sure "PCIE" should be in the name, or maybe it
should be at a different place, e.g., "PCI_DVSEC_CXL_PORT" or
something, since this DVSEC controls CXL-specific things.

I kind of think a "PCI_DVSEC_" prefix might be appropriate since
PCI is where the DVSEC concept is defined, and then the more specific
details can follow

> +#define CXL_DVSEC_PORT_CONTROL				0x0c
> +#define  CXL_DVSEC_PORT_CONTROL_UNMASK_SBR		0x00000001

s/CONTROL/CTL/ (or CTRL, though CTL is more common in this file)

Bjorn

