Return-Path: <linux-pci+bounces-22920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F1A4F162
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A6188A9C2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85525DD1C;
	Tue,  4 Mar 2025 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDzGSlEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E81FBCB6;
	Tue,  4 Mar 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130552; cv=none; b=rmclfgk6RHu9BNFvr3xlb6ux6AXNsggVsPL/mxiRiPETKp37O0a7J9vSpizOvwgaccmhqFzL8db3oXef+0iDr6YwPxp3RDdZkf8457H25pXluwYhwqt7Mtgx8kUHtGpzpSyQ9Hmg9y02abJ3fZLTN4tHJcO2ynuhXBiAOhzyHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130552; c=relaxed/simple;
	bh=iiljtkG5DqNiUtL+acfsxJ6Pgz3aTmOCDfPZ887+nAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oVxvfSroENFdc83sv+zKFkb5+/fJ3re/0yDW/oLU+jY9Neb7NhutpVtKRg7L3BIbGK3Y/TOZHBxjzeVTztU4CfMWEHeBSZq3kh3iiM8Fr5zKN4PJZVqheKEWwt1IK2CnSfTyeiApE0GFhAlhdotaZIvQpJO9hewF2FDWEh8erCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDzGSlEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C02C4CEE9;
	Tue,  4 Mar 2025 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741130551;
	bh=iiljtkG5DqNiUtL+acfsxJ6Pgz3aTmOCDfPZ887+nAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gDzGSlEtb1YmIF4xksZ5KICBIE6jiYVJbX5zLBu6WeXSOzYETPbtl7pBlJT94TlJp
	 98429J1ufEerB9D5zlpi6FyT613n+XxiYpuLllRSd6Jc/Fs3vfixEBUwYjWesBxY9l
	 a8K/h4srMoPKUHE9zTyXl8ONAwuSY8OSQAC0Jh4COIA+1fe9FAyJfmIwAcBvTux2cM
	 t8d271Al1ktDKdM37p0xzAi2nHQW6mnONPflu+pwknzHC8p2CFcPRyN45RMbwDrxz7
	 uEeead0R9x5Cn7B8qN/mT3rCK2rHn1d/hHI82+wJb4MyIJEfLchmiyu7N5SKM/LKqF
	 9p3hjY0T3KyUA==
Date: Tue, 4 Mar 2025 17:22:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bijie Xu <bijie.xu@corigine.com>
Cc: oohall@gmail.com, mahesh@linux.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: Re: [PATCH] PCI/AER: Add kernel.aer_print_skip_mask to control aer
 log
Message-ID: <20250304232230.GA264709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108075703.410961-1-bijie.xu@corigine.com>

[+cc Jon, Karolina]

On Wed, Jan 08, 2025 at 03:57:03PM +0800, Bijie Xu wrote:
> Sometimes certain PCIE devices installed on some servers occasionally
> produce large number of AER correctable error logs, which is quite
> annoying. Add this sysctl parameter kernel.aer_print_skip_mask to
> skip printing AER errors of certain severity.
> 
> The AER severity can be 0(NONFATAL), 1(FATAL), 2(CORRECTABLE). The 3
> low bits of the mask are used to skip these 3 severities. Set bit 0
> can skip printing NONFATAL AER errors, and set bit 1 can skip printing
> FATAL AER errors, set bit 2 can skip printing CORRECTABLE AER errors.
> And multiple bits can be set to skip multiple severities.

This is definitely annoying, actually MORE than annoying in some
cases.

I'm hoping the correctable error rate-limiting work can reduce the
annoyance to an tolerable level:

  https://lore.kernel.org/r/20250214023543.992372-1-pandoh@google.com

Can you take a look at this and see if it's going the right direction
for you, or if it needs extensions to do what you need?

> Signed-off-by: Bijie Xu <bijie.xu@corigine.com>
> ---
>  drivers/pci/pcie/aer.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 80c5ba8d8296..b46973526bcf 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -698,6 +698,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  	pci_dev_aer_stats_incr(dev, info);
>  }
>  
> +unsigned int aer_print_skip_mask __read_mostly;
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int layer, agent;
> @@ -710,6 +711,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  		goto out;
>  	}
>  
> +	if ((1 << info->severity) & aer_print_skip_mask)
> +		goto out;
> +
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> @@ -1596,3 +1600,22 @@ int __init pcie_aer_init(void)
>  		return -ENXIO;
>  	return pcie_port_service_register(&aerdriver);
>  }
> +
> +static const struct ctl_table aer_print_skip_mask_sysctls[] = {
> +	{
> +		.procname       = "aer_print_skip_mask",
> +		.data           = &aer_print_skip_mask,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = &proc_douintvec,
> +	},
> +	{}
> +};
> +
> +static int __init aer_print_skip_mask_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", aer_print_skip_mask_sysctls);
> +	return 0;
> +}
> +
> +late_initcall(aer_print_skip_mask_sysctl_init);
> -- 
> 2.25.1
> 

