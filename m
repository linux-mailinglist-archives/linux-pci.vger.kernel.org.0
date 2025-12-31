Return-Path: <linux-pci+bounces-43886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4DDCEC4D9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 18:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E29E3005AA1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0029A9C3;
	Wed, 31 Dec 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU7ZJeWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3D284674;
	Wed, 31 Dec 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200512; cv=none; b=LwwNEScdusVE2VsQYuUVqJMcN0lJZelHXN7Y4WzpkAzG92E6Q4zbzhsNpFghHx/lTH1fHLuFVSQatjGJ7f9HUXod+alaVpJjxMC5tpfAYmXF0c764QdptRtNWCxT5Iwpxr0u3YTIhbwgP6BsDHLN7wJzrrk3afqIezQyPgiNMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200512; c=relaxed/simple;
	bh=N72JkyT+rZD9OdtAJl7cpuORygxpXKbwdLS5ZFP27ho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PlZDmdh5O721hySRvT69xaMYmoVY9TkRJv1O5uqOOG3xR81BpGzuhqgn9wXXrqvyBTnwMF61Y4SkbGNGt7guR6xFpPyoMTLku6WgsY+c2Nl8lNUkdXCCn7A3UucnwlnbL4nDLBXjC7k41Krmtk1gxb9vfJaUPd+ULHnp6M3Qag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU7ZJeWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F645C113D0;
	Wed, 31 Dec 2025 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767200511;
	bh=N72JkyT+rZD9OdtAJl7cpuORygxpXKbwdLS5ZFP27ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fU7ZJeWbC8t6neVjMX6DyP4JatoNd51EEAKbvpktdOf00vGrk+AsWav3Z1XRIb0n3
	 htqkQhcPmklDPjhpwlWIHkqOaVuSvqlcjey3NFwa0DTkNpX8Wm3/rq2EVKuU554niV
	 qsmbc6iBlAZM5OgWmWs6MsHoSJuFFswiSCB6a4+hNCQJ4ZTBlAZx2NiIJ95c446CeG
	 UBILGmy1ixWd5o6Q9Lb5eV+OoudBnWWB/1CohZiWulygtlR9xd5sNN+Btp5Wzx/b1l
	 s/KNv5phEM735Or8EOgjjyYFG6uBhOVivYbEHV2vULZ9wwHly8YwR82/DgYPglz7VN
	 DA36fHr15YHBQ==
Date: Wed, 31 Dec 2025 11:01:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: PCI: IRQ: Handle INTx GSIs as u32 values not int
Message-ID: <20251231170150.GA160311@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231092615.3014761-1-lpieralisi@kernel.org>

On Wed, Dec 31, 2025 at 10:26:15AM +0100, Lorenzo Pieralisi wrote:
> In ACPI Global System Interrupts (GSIs) are described using a 32-bit
> value.
> 
> ACPI/PCI legacy interrupts (INTx) parsing code treats GSIs as 'int', which
> poses issues if the GSI interrupt value is a 32-bit value with the MSB set
> (as required in some interrupt configurations - eg ARM64 GICv5 systems).
> 
> Fix ACPI/PCI legacy INTx parsing by converting variables representing
> GSIs from 'int' to 'u32' bringing the code in line with the ACPI
> specification.

Looks good to me.  Is there any symptom of what the issue looks like
that could be mentioned here?  Might also be useful in the subject,
which currently describes the C code without really saying why we want
to do this.

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/acpi/pci_irq.c      | 19 ++++++++++--------
>  drivers/acpi/pci_link.c     | 39 ++++++++++++++++++++++++-------------
>  drivers/xen/acpi.c          | 13 +++++++------
>  include/acpi/acpi_drivers.h |  2 +-
>  4 files changed, 44 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index ad81aa03fe2f..c416942ff3e2 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -188,7 +188,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
>  	 * the IRQ value, which is hardwired to specific interrupt inputs on
>  	 * the interrupt controller.
>  	 */
> -	pr_debug("%04x:%02x:%02x[%c] -> %s[%d]\n",
> +	pr_debug("%04x:%02x:%02x[%c] -> %s[%u]\n",
>  		 entry->id.segment, entry->id.bus, entry->id.device,
>  		 pin_name(entry->pin), prt->source, entry->index);
>  
> @@ -384,7 +384,7 @@ static inline bool acpi_pci_irq_valid(struct pci_dev *dev, u8 pin)
>  int acpi_pci_irq_enable(struct pci_dev *dev)
>  {
>  	struct acpi_prt_entry *entry;
> -	int gsi;
> +	u32 gsi;
>  	u8 pin;
>  	int triggering = ACPI_LEVEL_SENSITIVE;
>  	/*
> @@ -422,18 +422,21 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  			return 0;
>  	}
>  
> +	rc = -ENODEV;
> +
>  	if (entry) {
>  		if (entry->link)
> -			gsi = acpi_pci_link_allocate_irq(entry->link,
> +			rc = acpi_pci_link_allocate_irq(entry->link,
>  							 entry->index,
>  							 &triggering, &polarity,
> -							 &link);
> -		else
> +							 &link, &gsi);
> +		else {
>  			gsi = entry->index;
> -	} else
> -		gsi = -1;
> +			rc = 0;
> +		}
> +	}
>  
> -	if (gsi < 0) {
> +	if (rc < 0) {
>  		/*
>  		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
>  		 * driver reported one, then use it. Exit in any case.
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index bed7dc85612e..b91b039a3d20 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -448,7 +448,7 @@ static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] = {
>  	/* >IRQ15 */
>  };
>  
> -static int acpi_irq_pci_sharing_penalty(int irq)
> +static int acpi_irq_pci_sharing_penalty(u32 irq)
>  {
>  	struct acpi_pci_link *link;
>  	int penalty = 0;
> @@ -474,7 +474,7 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>  	return penalty;
>  }
>  
> -static int acpi_irq_get_penalty(int irq)
> +static int acpi_irq_get_penalty(u32 irq)
>  {
>  	int penalty = 0;
>  
> @@ -528,7 +528,7 @@ static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
>  static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  {
>  	acpi_handle handle = link->device->handle;
> -	int irq;
> +	u32 irq;
>  	int i;
>  
>  	if (link->irq.initialized) {
> @@ -598,44 +598,53 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  	return 0;
>  }
>  
> -/*
> - * acpi_pci_link_allocate_irq
> - * success: return IRQ >= 0
> - * failure: return -1
> +/**
> + * acpi_pci_link_allocate_irq(): Retrieve a link device GSI
> + *
> + * @handle: Handle for the link device
> + * @index: GSI index
> + * @triggering: pointer to store the GSI trigger
> + * @polarity: pointer to store GSI polarity
> + * @name: pointer to store link device name
> + * @gsi: pointer to store GSI number
> + *
> + * Returns:
> + *	0 on success with @triggering, @polarity, @name, @gsi initialized.
> + *	-ENODEV on failure
>   */
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> -			       int *polarity, char **name)
> +			       int *polarity, char **name, u32 *gsi)
>  {
>  	struct acpi_device *device = acpi_fetch_acpi_dev(handle);
>  	struct acpi_pci_link *link;
>  
>  	if (!device) {
>  		acpi_handle_err(handle, "Invalid link device\n");
> -		return -1;
> +		return -ENODEV;
>  	}
>  
>  	link = acpi_driver_data(device);
>  	if (!link) {
>  		acpi_handle_err(handle, "Invalid link context\n");
> -		return -1;
> +		return -ENODEV;
>  	}
>  
>  	/* TBD: Support multiple index (IRQ) entries per Link Device */
>  	if (index) {
>  		acpi_handle_err(handle, "Invalid index %d\n", index);
> -		return -1;
> +		return -ENODEV;
>  	}
>  
>  	mutex_lock(&acpi_link_lock);
>  	if (acpi_pci_link_allocate(link)) {
>  		mutex_unlock(&acpi_link_lock);
> -		return -1;
> +		return -ENODEV;
>  	}
>  
>  	if (!link->irq.active) {
>  		mutex_unlock(&acpi_link_lock);
>  		acpi_handle_err(handle, "Link active IRQ is 0!\n");
> -		return -1;
> +		return -ENODEV;
>  	}
>  	link->refcnt++;
>  	mutex_unlock(&acpi_link_lock);
> @@ -647,7 +656,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
>  	if (name)
>  		*name = acpi_device_bid(link->device);
>  	acpi_handle_debug(handle, "Link is referenced\n");
> -	return link->irq.active;
> +	*gsi = link->irq.active;
> +
> +	return 0;
>  }
>  
>  /*
> diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
> index d2ee605c5ca1..eab28cfe9939 100644
> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -89,11 +89,11 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  						  int *trigger_out,
>  						  int *polarity_out)
>  {
> -	int gsi;
> +	u32 gsi;
>  	u8 pin;
>  	struct acpi_prt_entry *entry;
>  	int trigger = ACPI_LEVEL_SENSITIVE;
> -	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
> +	int ret, polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
>  				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>  
>  	if (!dev || !gsi_out || !trigger_out || !polarity_out)
> @@ -105,17 +105,18 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  
>  	entry = acpi_pci_irq_lookup(dev, pin);
>  	if (entry) {
> +		ret = 0;
>  		if (entry->link)
> -			gsi = acpi_pci_link_allocate_irq(entry->link,
> +			ret = acpi_pci_link_allocate_irq(entry->link,
>  							 entry->index,
>  							 &trigger, &polarity,
> -							 NULL);
> +							 NULL, &gsi);
>  		else
>  			gsi = entry->index;
>  	} else
> -		gsi = -1;
> +		ret = -ENODEV;
>  
> -	if (gsi < 0)
> +	if (ret < 0)
>  		return -EINVAL;
>  
>  	*gsi_out = gsi;
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index b14d165632e7..402b97d12138 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -51,7 +51,7 @@
>  
>  int acpi_irq_penalty_init(void);
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> -			       int *polarity, char **name);
> +			       int *polarity, char **name, u32 *gsi);
>  int acpi_pci_link_free_irq(acpi_handle handle);
>  
>  /* ACPI PCI Device Binding */
> -- 
> 2.50.1
> 

