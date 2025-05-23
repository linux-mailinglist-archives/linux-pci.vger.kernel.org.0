Return-Path: <linux-pci+bounces-28338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A4AC27BF
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19481BC0462
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33B222580;
	Fri, 23 May 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX3UR/6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA874120B;
	Fri, 23 May 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018374; cv=none; b=CYagrjqGngy4CfJA5JbZBctjttcmQ0V+BDYwxJpJ++h4dDw7U0Rb0AwtEGjOFkTFRpGb4IB1wU77lT3Uas8F6AuPXPhi9NBcI+IcOrr9G+T6r+6gaJ9FnFoaCDZi2C+pRElQlRcZTysir8BUDcBxuybnTWdNsmyC000WGPxIFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018374; c=relaxed/simple;
	bh=4E4NkvJq/R7U01X4XIKDFjPJuXJax6DDUhPYflAvPOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBCP7+SvB5AmBmFw4uMbPHKFdKVb/e7N3ilhMtPs/KrA7dhwWOB/ECR8zQNk6vVt93AGaa7iuNmvUNX8Lu53oqgOGax7naSlZr3/1quV6Na7Gp4A0ZiWW7AIZehMwIkwADqh8SC7HbtwlasUUp6xjfqZceCXumMnZwJDhNh1JMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX3UR/6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C05C4CEE9;
	Fri, 23 May 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748018373;
	bh=4E4NkvJq/R7U01X4XIKDFjPJuXJax6DDUhPYflAvPOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mX3UR/6Kl0MmdPgCRRIWz3uPT1hCf139/OspEcnnVyh2KlN2NZ/LRYlVV0R4upLEC
	 a6XrVyVUo0PqQ4GB1irujOO6r45TY9UiZDlCXNOt+gz8iYXbBIMdWk912XwQOFPmcD
	 oLjzcm7gCSY53ZFbSxdze68Z1b05jyrIpWMffj4eNUQQJJbY7sTpFhZeD7JvqNr5o2
	 GL/m9N/UD+GHuy2QDdV8UO3+byUZY4WIs27bvFCliqYDw4ly8hjd7W/miCl0unoAZ4
	 076tMCY3PJkl8kcEwc5Q+1We02OjL/clI8Ij5J/bFqkbaWaEwJKrgKjeYiwj/J+ACK
	 V0xTNVv6JXFhQ==
Date: Fri, 23 May 2025 11:39:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: grwhyte@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com,
	code@tyhicks.com, Okaya@kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reduce delay after FLR of Microsoft MANA devices
Message-ID: <20250523163932.GA1566378@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521231539.815264-1-grwhyte@linux.microsoft.com>

On Wed, May 21, 2025 at 11:15:39PM +0000, grwhyte@linux.microsoft.com wrote:
> From: Graham Whyte <grwhyte@linux.microsoft.com>
> 
> Add a device-specific reset for Microsoft MANA devices with the FLR
> delay reduced from 100ms to 10ms. While this is not compliant with the pci
> spec, these devices safely complete the FLR much quicker than 100ms and
> this can be reduced to optimize certain scenarios

It looks like this could be done generically if the device advertised
the Readiness Time Reporting Capability (PCIe r6.0, sec 7.9.16) and
Linux supported that Capability (which it currently does not)?

From 7.9.16.3:

  FLR Time - is the time that the Function requires to become
  Configuration-Ready after it was issued an FLR.

Does the device advertise that capability?  It would be much nicer if
we didn't have to add a device-specific quirk for this.

> Signed-off-by: Graham Whyte <grwhyte@linux.microsoft.com>
> ---
>  drivers/pci/pci.c    |  3 ++-
>  drivers/pci/pci.h    |  1 +
>  drivers/pci/quirks.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9cb1de7658b5..ad2960117acd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1262,7 +1262,7 @@ void pci_resume_bus(struct pci_bus *bus)
>  		pci_walk_bus(bus, pci_resume_one, NULL);
>  }
>  
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> +int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  {
>  	int delay = 1;
>  	bool retrain = false;
> @@ -1344,6 +1344,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_wait);
>  
>  /**
>   * pci_power_up - Put the given device into D0
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f2958318d259..3a98e00eb02a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -109,6 +109,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>  int __pci_reset_bus(struct pci_bus *bus);
> +int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout);
>  
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c354276d4bac..94bd2c82cbbd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4205,6 +4205,55 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define MSFT_PCIE_RESET_READY_POLL_MS 60000 /* msec */
> +#define MICROSOFT_2051_SVC 0xb210
> +#define MICROSOFT_2051_MANA_MGMT 0x00b8
> +#define MICROSOFT_2051_MANA_MGMT_GFT 0xb290
> +
> +/* Device specific reset for msft GFT and gdma devices */
> +static int msft_pcie_flr(struct pci_dev *dev)
> +{
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; "
> +			"performing function level reset anyway\n");
> +
> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
> +
> +	if (dev->imm_ready)
> +		return 0;
> +
> +	/*
> +	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
> +	 * 100ms, but may silently discard requests while the FLR is in
> +	 * progress. However, 100ms is much longer than required for modern
> +	 * devices, so we can afford to reduce the timeout to 10ms.
> +	 */
> +	usleep_range(10000, 10001);
> +
> +	return pci_dev_wait(dev, "FLR", MSFT_PCIE_RESET_READY_POLL_MS);
> +}
> +
> +/*
> + * msft_pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a function level reset on @dev.
> + */
> +static int msft_pcie_reset_flr(struct pci_dev *dev, bool probe)
> +{
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return msft_pcie_flr(dev);
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4220,6 +4269,12 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_SVC,
> +		msft_pcie_reset_flr},
> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT,
> +		msft_pcie_reset_flr},
> +	{ PCI_VENDOR_ID_MICROSOFT, MICROSOFT_2051_MANA_MGMT_GFT,
> +		msft_pcie_reset_flr},
>  	{ 0 }
>  };
>  
> -- 
> 2.25.1
> 

