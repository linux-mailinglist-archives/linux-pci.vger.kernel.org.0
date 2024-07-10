Return-Path: <linux-pci+bounces-10083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56692D421
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7741F236AD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED819347C;
	Wed, 10 Jul 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGl0QoY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE619347B;
	Wed, 10 Jul 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621266; cv=none; b=NhO894TSWTnqP1IU6m25738hh+W15smObTwrIAQzCCYL6/kS90RKrV8bUowT7gFqSGxHWpvCAE83PGqxJj+COUvdtcJUYyeMiVZWR6H8HrXPRxCzGgjNafoRkqqdQ3/LQvutAUhn2reDHfRzFoIVHf8YxIp2c779EWDu3tH92kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621266; c=relaxed/simple;
	bh=bG7zb+CMHmlM3GA0oVeS0qwFu8tywgeMIPlwleskOXM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R1P5LB1QCXCqxYHn+UqNychPRK71do0bf30Do75sM3ek4xuyh+12DTOGfqMzDGwMvjYdeRzK8JisaMKRw2he5ApOCqz8Tu8KCb/zvYbVvexGmt3IJB4YFbDhRSusaH3O2/c6iGIqDaSLzndG1P2fuMi4JgxgPQS/r3EgLeiUzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGl0QoY4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720621266; x=1752157266;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bG7zb+CMHmlM3GA0oVeS0qwFu8tywgeMIPlwleskOXM=;
  b=cGl0QoY4zAzO7kY6uXknI644butTuxTBsyyX67bxtl7F3nX47MHyOYNb
   4n+1I6z6/VZSpWfJq2U0U5LZa9RkkLclknXtRoHR3KDqSorB4U/u57ADD
   JaN7KnwWt3O3fDEvvj5zVc+wnRHNiUZvCSFaUU8cQNBQNrIjlBdXZ1ZFf
   5NOWCrCY67gg7xzZNkug9hKUTxP+ztNZVX7aAzhcWTo1PiwMSJp46wa/4
   qrd2X3X9SRacRA+gsJU0untNYRAU+kLvYYgBjGdgN4us0AI1JFpf0d2RU
   eFEkbMpKP5XWMl3ex9G8wAekxOtMJOdiqK84wNEVUgsQIA/gx+4kQodC5
   w==;
X-CSE-ConnectionGUID: XS4cYT96TMGkCtwW6hdnOw==
X-CSE-MsgGUID: YYbvfmZgRFevto/RVzUQJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17889868"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17889868"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:21:05 -0700
X-CSE-ConnectionGUID: VfoH+6bHS6yJvt/tx0S6yg==
X-CSE-MsgGUID: PiRkMKV8R/iT/dFMPm8JHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="85737647"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:21:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 10 Jul 2024 17:20:58 +0300 (EEST)
To: George-Daniel Matei <danielgeorgem@chromium.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
In-Reply-To: <20240708153815.2757367-1-danielgeorgem@chromium.org>
Message-ID: <87b22115-2b88-db66-f97c-aa8eea22f8cf@linux.intel.com>
References: <20240708153815.2757367-1-danielgeorgem@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Jul 2024, George-Daniel Matei wrote:

> Added aspm suspend/resume hooks that run
> before and after suspend and resume to change
> the ASPM states of the PCI bus in order to allow
> the system suspend while trying to prevent card hangs
> 
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

Missing space.

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

Touching ASPM state should be done through aspm driver, not by writing 
directly into LNKCTL and L1SS registers.

> +		//configure device

Missing space.

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

Missing space

> +		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC, 0);

pcie_capability_clear_word()

> +
> +		pci_read_config_word(dev->bus->self,

A copy-paste error for the device???

> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				     &val);
> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
> +		pci_write_config_word(dev->bus->self,
> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				      val);
> +
> +		//configure parent

Missing space

> +		pcie_capability_clear_and_set_word(dev->bus->self,
> +						   PCI_EXP_LNKCTL,
> +						   PCI_EXP_LNKCTL_ASPMC, 0);

pcie_capability_clear_and_set_word()

> +
> +		pci_read_config_word(dev->bus->self,
> +				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				     &val);
> +		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
> +		pci_write_config_word(dev->bus->self,
> +				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
> +				      val);

Touching the same device twice here?

> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
> +			 rtl8169_resume_aspm_settings);
>  #endif

-- 
 i.


