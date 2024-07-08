Return-Path: <linux-pci+bounces-9960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C992A82D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A10B214D9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B385147C82;
	Mon,  8 Jul 2024 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8T9CkcH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98EAD55;
	Mon,  8 Jul 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459421; cv=none; b=GQgutaRYyqwBj0VJvsfA+/jXGyDNFaAdLdLGcGOlXwzeEvi1l8RbWCdxa83cDz5q5qu8KZekXMrqBJB7WhRsjCy3QEOsw1R9aRRTWHW4Q57TlKQPO2oo1ZICOt7hSKPCUytJU86OdZogcQd9I5eyLH6ErsqNZ2sjcRVqla32eYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459421; c=relaxed/simple;
	bh=iDG5PVLfUhVuTtxCZMDuvVBUfkszB3K6aN+AKAT7Eak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HNMUeFpT4OLK7/ruUT5PD7XRdFsiaHLgb69I/FDbL49/7RLadtV36EwDK8ioxqE5a6rU14cYbTOTNPenwHnU2OFFPIFxYwHp+e0PsFgFp8r0P4JltQtYh4ew2u461uZHQk16kZFreKsu+J6LUlIivDacJfI6vlkdwtGU9ik/Vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8T9CkcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBABC116B1;
	Mon,  8 Jul 2024 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720459421;
	bh=iDG5PVLfUhVuTtxCZMDuvVBUfkszB3K6aN+AKAT7Eak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C8T9CkcHsm6gt91UDMN3evQKKlxupHYDMsz1tkr6pWJ0KF2LZ+h3oudd0lT28ooo5
	 Wyx7PlT1bv11RuXMeZxwvQdozYjC52MEwAFi1uKTSBCvBzr3hFvi9opQg4+8aAO8Wi
	 +MbHIH140PBCvFgJGOy0z5TCi7Kkd6XyRL+/AuBRI1G0WkFrlWHMQK8ix06d0EeAnt
	 YmX9gVNi6fTe97fT0ZCbJn8TdPa7XdPFYQldLyfhn5hbgnW+BCr43hQOEdo6Ze5CTo
	 xTsxBROhSHA6MBIFdL6/ecVqOz3PEYcLsJdtYDM84Fa3qS7HVh6kS2o9I/70FbFZL3
	 V5M8gbNS5eRWQ==
Date: Mon, 8 Jul 2024 12:23:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com, netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
Message-ID: <20240708172339.GA139099@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708153815.2757367-1-danielgeorgem@chromium.org>

[+cc r8169 folks]

On Mon, Jul 08, 2024 at 03:38:15PM +0000, George-Daniel Matei wrote:
> Added aspm suspend/resume hooks that run
> before and after suspend and resume to change
> the ASPM states of the PCI bus in order to allow
> the system suspend while trying to prevent card hangs

Why is this needed?  Is there a r8169 defect we're working around?
A BIOS defect?  Is there a problem report you can reference here?

s/Added/Add/

s/aspm/ASPM/ above

s/PCI bus/device and parent/

Add period at end of sentence.

Rewrap to fill 75 columns.

> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
> ---
>  drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index dc12d4a06e21..aa3dba2211d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
> +
> +static const struct dmi_system_id chromebox_match_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +		{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{
> +			.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +		}
> +	},
> +	{ }
> +};
> +
> +static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
> +{
> +	u16 val = 0;
> +
> +	if (dmi_check_system(chromebox_match_table)) {
> +		//configure parent
> +		pcie_capability_clear_and_set_word(dev->bus->self,
> +						   PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC,
> +						   PCI_EXP_LNKCTL_ASPM_L1);
> +
> +		pci_read_config_word(dev->bus->self,
> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				     &val);
> +		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> +		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
> +		      PCI_L1SS_CTL1_ASPM_L1_1;
> +		pci_write_config_word(dev->bus->self,
> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				      val);
> +
> +		//configure device
> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC,
> +						   PCI_EXP_LNKCTL_ASPM_L1);
> +
> +		pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val);
> +		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
> +		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
> +		      PCI_L1SS_CTL1_ASPM_L1_1;
> +		pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val);
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
> +			  rtl8169_suspend_aspm_settings);
> +
> +static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
> +{
> +	u16 val = 0;
> +
> +	if (dmi_check_system(chromebox_match_table)) {
> +		//configure device
> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC, 0);
> +
> +		pci_read_config_word(dev->bus->self,
> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				     &val);
> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
> +		pci_write_config_word(dev->bus->self,
> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				      val);
> +
> +		//configure parent
> +		pcie_capability_clear_and_set_word(dev->bus->self,
> +						   PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC, 0);
> +
> +		pci_read_config_word(dev->bus->self,
> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				     &val);
> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
> +		pci_write_config_word(dev->bus->self,
> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				      val);

Updates the parent (dev->bus->self) twice; was the first one supposed
to update the device (dev)?

This doesn't restore the state as it existed before suspend.  Does
this rely on other parts of restore to do that?

> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
> +			 rtl8169_resume_aspm_settings);
>  #endif
>  
>  #ifdef CONFIG_PCIE_DPC
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

