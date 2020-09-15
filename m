Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D170A26B01D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgIOWBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgIOWBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 18:01:01 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEE02064B;
        Tue, 15 Sep 2020 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600207259;
        bh=RbHtH2BobjBBMOqbL+tss/LJHSaHhgqhPH96FK9FpQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0lN9w93GQw8yg+ctH6B42Oy55OhVRSqiPLGvPevM8n4f2IwYsSkI6AI3RGJbJKZ6s
         wMuUaNKcK1fqtSdpI4CcL9LEOD+Mye4tYHfsso3GhY/TNXiB1ZRJQnEGR1y717RHZl
         clpCXGl2eG18l4DKwCQU1Y2SqBVHSv5qdQkAmPIE=
Date:   Tue, 15 Sep 2020 17:00:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] PCI: Add support for LTR
Message-ID: <20200915220057.GA1429658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200825180131.17672-1-puranjay12@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 25, 2020 at 11:31:31PM +0530, Puranjay Mohan wrote:
> Add a new function pci_ltr_init() which will be called from
> pci_init_capabilities() to initialize every PCIe device's LTR values.
> Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
> v2 - add an #ifdefin pci-acpi.c to fix the bug reported by test bot.
> v1 - based the patch on v5.9-rc1 so it applies correctly.
> ---
>  drivers/pci/pci-acpi.c   | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pci.c        | 27 +++++++++++++++++++++++++++
>  drivers/pci/pci.h        |  5 +++++
>  drivers/pci/probe.c      |  6 ++++++
>  include/linux/pci-acpi.h |  1 +
>  include/linux/pci.h      |  2 ++
>  6 files changed, 71 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d5869a03f748..af8297040c38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1213,6 +1213,36 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +/* pci_acpi_evaluate_ltr_latency
> + *
> + * @dev - the pci_dev to evaluate and save latencies
> + */
> +void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCIASPM
> +	union acpi_object *obj, *elements;
> +	struct acpi_device *handle;

Nit: sort declarations in order of use: handle, obj, etc.

> +
> +	handle = ACPI_HANDLE(&dev->dev);
> +	if (!handle)
> +		return;
> +
> +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 0x2,
> +				DSM_PCI_LTR_MAX_LATENCY, NULL);
> +	if (!obj)
> +		return;

Sorry for the delay in responding.  Coincidentally, part of the reason
is that I've been consumed with some PCI Firmware spec updates related
to _DSM, which actually happens to affect this code.

_DSM is defined in the public ACPI spec; see ACPI v6.3, sec 9.1.1.
One problem with this interface is that it does not define any
standard return type or value, so there is no way to tell from the
return value whether the function is implemented.  That means I don't
think it's safe to rely on "!obj" meaning "DSM_PCI_LTR_MAX_LATENCY
isn't implemented".  Similarly, I don't think it's safe to assume
"obj" means it *is* implemented.

We have lots of places in the kernel that do this wrong.  One that
does it *right* is acpi_dpc_port_get().  Short story: we need to call
acpi_check_dsm() first before calling acpi_evaluate_dsm().

There's an ongoing discussion about what *revision* we should use.
For now I think the right thing is to use 2 as you did, since that's
the first revision where DSM_PCI_LTR_MAX_LATENCY is defined.  I would
use "2" (decimal) like the other uses in the file, though.

> +	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 4) {
> +		elements = obj->package.elements;
> +		dev->max_snoop_latency = (u16)elements[1].integer.value |
> +				((u16)elements[0].integer.value << PCI_LTR_SCALE_SHIFT);
> +		dev->max_nosnoop_latency = (u16)elements[3].integer.value |
> +				((u16)elements[2].integer.value << PCI_LTR_SCALE_SHIFT);
> +	}
> +	ACPI_FREE(obj);
> +#endif
> +}
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>  	u8 val;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a458c46d7e39..b5531272b865 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3056,6 +3056,33 @@ void pci_pm_init(struct pci_dev *dev)
>  		dev->imm_ready = 1;
>  }
>  
> +/**
> + * pci_ltr_init - Initialize Latency Tolerance Information of given PCI device
> + * @dev: PCI device to handle.
> + */
> +void pci_ltr_init(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCIASPM
> +	int ltr;
> +	struct pci_dev *endpoint_dev = dev;

Nit: sort the declarations in order of use, i.e., endpoint_dev, ltr, ...

> +	u16 max_snoop_sum = 0;
> +	u16 max_nosnoop_sum = 0;
> +
> +	ltr = pci_find_ext_capability(endpoint_dev, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return;
> +
> +	dev = pci_upstream_bridge(dev);
> +	while (dev) {
> +		max_snoop_sum += dev->max_snoop_latency;
> +		max_nosnoop_sum += dev->max_nosnoop_latency;

dev->max_snoop_latency and dev->max_nosnoop_latency are not simple
scalars, are they?  Aren't they 3 bits of scale and 10 bits of value?
I don't think adding these is as easy as "+=" except in the simple
case when the scale is "000", i.e., "use the 10 bits of value as-is".

I think we have to decode scale * latency for each device in the path,
add all those up, then re-encode using the appropriate scale for the
config write below.

> +		dev = pci_upstream_bridge(dev);
> +	}
> +	pci_write_config_word(endpoint_dev, ltr + PCI_LTR_MAX_SNOOP_LAT, max_snoop_sum);
> +	pci_write_config_word(endpoint_dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, max_nosnoop_sum);

I think we definitely need to do this, but we need to be careful about
updating things here, since I suspect mistakes will cause
hard-to-debug problems.  PCIe r5.0, sec 6.18, says:

  Setting the value and scale fields to all 0’s indicates that the
  device will be impacted by any delay and that the best possible
  service is requested.

If I understand that correctly, larger values for these registers
indicate that the device can tolerate more latency, so we want to err
on the side of setting these fields too low rather than too high.

So I think maybe we should read the current values first.  If the
value we computed is the same, we can just skip the write.

What should we do if the value we computed is *larger* than the
current value?  Hot-added devices will power up with zeroes here, so I
think we probably should log a note (pci_info()) and do the write.  If
we don't do the write and we enable ASPM, LTR, and L1 Substates, the
zeroes mean the device will be requesting the best possible service,
so we won't use the L1.2 substate as much as we should, resulting in
more power consumption than necessary.

If we read something non-zero, it probably means firmware has already
configured this.  If we computed something larger, we should probably
still log a message, but maybe skip the write.  My thinking is that
this may be a firmware bug, and fixing it could reduce power usage.
If we do the write, we risk breaking something that used to work.

If the value we computed is *smaller* than the current value, I think
we should log a note just to show that we're changing something, and
we *should* do the write, because writing a smaller value should
always be safe.

The log messages should include both the current value and the new
value we computed (decoded so they're easy to read and compare).

> +#endif
> +}
> +
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
>  {
>  	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..ef3d22b82200 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -110,6 +110,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> +void pci_ltr_init(struct pci_dev *dev);
>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> @@ -680,11 +681,15 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
>  
>  #ifdef CONFIG_ACPI
>  int pci_acpi_program_hp_params(struct pci_dev *dev);
> +void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev);
>  #else
>  static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
>  {
>  	return -ENODEV;
>  }
> +static inline void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
> +{
> +}

Nit: all on one line as in rest of this file:

  static inline void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev) { }

>  #endif
>  
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d37128a24f..0257aa615665 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2140,6 +2140,11 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  		dev->ltr_path = 1;
>  	}
>  #endif
> +
> +	/*
> +	 * Read latency values from _DSM and save in pci_dev
> +	 */
> +	pci_acpi_evaluate_ltr_latency(dev);
>  }
>  
>  static void pci_configure_eetlp_prefix(struct pci_dev *dev)
> @@ -2400,6 +2405,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_ptm_init(dev);		/* Precision Time Measurement */
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
> +	pci_ltr_init(dev);		/* Latency Tolerance Reporting */
>  
>  	pcie_report_downtraining(dev);
>  
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 5ba475ca9078..e23236a4ff66 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -110,6 +110,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  
>  /* _DSM Definitions for PCI */
>  #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
> +#define DSM_PCI_LTR_MAX_LATENCY			0x06
>  #define DSM_PCI_DEVICE_NAME			0x07
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 835530605c0d..9de6b290ed81 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -380,6 +380,8 @@ struct pci_dev {
>  	struct pcie_link_state	*link_state;	/* ASPM link state */
>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>  					   supported from root to here */
> +	u16 max_snoop_latency;		/* LTR Max Snoop latency */
> +	u16 max_nosnoop_latency;	/* LTR Max No Snoop latency */

Nit: "Max No-Snoop" to match spec usage.

>  #endif
>  	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
>  
> -- 
> 2.27.0
> 
