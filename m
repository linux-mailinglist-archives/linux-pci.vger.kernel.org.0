Return-Path: <linux-pci+bounces-8741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F0907783
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97611C21EEF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0912E1DD;
	Thu, 13 Jun 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc+oLWI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B526AE4;
	Thu, 13 Jun 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293896; cv=none; b=FdspVhcK+bnjWeE3PqmB3HXNlVPAERCUHjMLFkvJrIMb0jpscN0OISjkQYOfp+LLWHg0b/eZd9BUJO2/a94eQDYWYq7MtdecPO0s24g1yyikwFm7ogkkDLEpryq7M2ff8tDoo+sTl51QrR7UOyf9lHNNNLKq5lZMLK3BfsL0BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293896; c=relaxed/simple;
	bh=+Y5pdWBck8MRqEy7e3HpK1hthc5Zhr8DhE0bYidHEog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XmcJbXTTdsoglK63iT6hc8e6Yx+dBbLmDVarBXksrUWr6RREyqfevRNDAfe/2djqV4xUyd8gOguixVRJAMTbmdNXBnxKg2AZo+4kxcD0D+E9CS2Fcrgaqh/m1AZI/Srd1z35Qh+5+PaB0IA4J3f+eJ77o/K7zmMH+OIvp1nnAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc+oLWI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DF6C32786;
	Thu, 13 Jun 2024 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293896;
	bh=+Y5pdWBck8MRqEy7e3HpK1hthc5Zhr8DhE0bYidHEog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jc+oLWI45ECpvEtwv0CnM45spaX+HyHOIsJk4LBa2/Do3lfnehbqtiMFsiyAcGnph
	 wcrW18kD2CB6IHDFKounxKICJSD1T76uGbf1yABGm6M9a2Bga9h1kKxnG1I0maSKfV
	 RQQ3erzAjuSHolNGOybphwd1ZC/SfHZn6xDBg0dL9KJY5NNh/gOEFO/5mqRDshlesX
	 E+NkXIgJymIVEWAoIHHidBY4Jhci/oFsFECoa8iqb2084G2e5h/PsSi2z4ZtRtPoHe
	 1fiRSbxulKeSnlyAaemc5hbMqyaVQULnnqFi2airSKpwXpqw7t72ffpthNBPMDyUwx
	 EJVNiKFCN5jzA==
Date: Thu, 13 Jun 2024 10:51:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI: hotplug: Use atomic_{fetch_}andnot() where
 appropriate
Message-ID: <20240613155134.GA1062951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613082449.197397-1-ubizjak@gmail.com>

[+cc Lukas, Ilpo]

On Thu, Jun 13, 2024 at 10:24:24AM +0200, Uros Bizjak wrote:
> Use atomic_{fetch_}andnot(i, v) instead of atomic_{fetch_}and(~i, v).

If the purpose is to improve readability, let's mention that here.
Since this only touches pciehp, make the subject line "PCI: pciehp:
..." as was done in the past.

It looks like every use of atomic_and() uses a ~value and is hence a
candidate for a similar change, but I'm not sure that converting to
"andnot" and removing the explicit bitwise NOT is really a readability
benefit.

If it were named something like "atomic_clear_bits", I'd be totally in
favor since that's a little higher-level description, but that ship
has long since sailed.

But I don't really care and if this is the trend, I'm fine with this
if Lukas and Ilpo agree.

> No functional changes intended.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
>  drivers/pci/hotplug/pciehp_hpc.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index dcdbfcf404dd..7c775d9a6599 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -121,8 +121,8 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
>  		msleep(1000);
>  
>  		/* Ignore link or presence changes caused by power off */
> -		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> -			   &ctrl->pending_events);
> +		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
> +			      &ctrl->pending_events);
>  	}
>  
>  	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index b1d0a1b3917d..6d192f64ea19 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -307,8 +307,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>  
>  	/* ignore link or presence changes up to this point */
>  	if (found)
> -		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> -			   &ctrl->pending_events);
> +		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
> +			      &ctrl->pending_events);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>  	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> @@ -568,7 +568,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
>  	 * Could be several if DPC triggered multiple times consecutively.
>  	 */
>  	synchronize_hardirq(irq);
> -	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> +	atomic_andnot(PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
>  	if (pciehp_poll_mode)
>  		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>  					   PCI_EXP_SLTSTA_DLLSC);
> @@ -702,7 +702,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	pci_config_pm_runtime_get(pdev);
>  
>  	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
> -	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
> +	if (atomic_fetch_andnot(RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
>  		ret = pciehp_isr(irq, dev_id);
>  		enable_irq(irq);
>  		if (ret != IRQ_WAKE_THREAD)
> -- 
> 2.45.2
> 

