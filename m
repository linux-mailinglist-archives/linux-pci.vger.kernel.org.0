Return-Path: <linux-pci+bounces-12531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D550E966959
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051AC1C2299F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC41BD4E8;
	Fri, 30 Aug 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUNjx4jH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855751BD4E5;
	Fri, 30 Aug 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045091; cv=none; b=KLVTUJRtIs9CZq4ZzWvxM1nNicoT39D7mDV4RamP08QkUBK+XWc1E7GdbVw82XmgL6YjDUkEVF+UVr9JhpGFMst8Ma75x62TMSXdmvAVY5yB4QDsPg2L1nAHmoZ/++76+1iH0vtvE8dUrOqTWudiqtK+llenixOPmgOybb998XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045091; c=relaxed/simple;
	bh=t2rLa4qLBaeQmb8d7MyO0jie2JSa7eFtQpHu1NNFc8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R0ScKHjjV4rmz10xV9ToUWIMNM8KAPCoenoXHhYwpLAgEbCLpmeTzCCBLD2QE4UafufHuTZxCG4haZqYozWZCHFCqGYdMoPbZVWFgeqGB9Q6PILjc+fE4A0dOdRAi8xUtY7EnY0oP8nyVMaiqxicUpx2D1z3uPZ/OkcVjvNWCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUNjx4jH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D468DC4CEC2;
	Fri, 30 Aug 2024 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725045091;
	bh=t2rLa4qLBaeQmb8d7MyO0jie2JSa7eFtQpHu1NNFc8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sUNjx4jH+xRMLWMZWVXbXZhM3sIz2p+Fl09oo0Sv3dTSs2LbMQSYfrdAUuamBT1FM
	 CdRNKKrp38c9yp0x/vXtrtMgjE6zU7C9s6tyK3JAqdXynKzf4cLe+2V9ZSFOewOhOs
	 W/eyAoalF51GI5YCDLyI578onnyAQs+b0dxy+bajngoJGxlbaPuBgT5buSDqiy1Xfi
	 xEgQ2Ne3Hp8tOdv5UGyw8BPZJbz7tSpJJA/dd7GVtHXAWrD+St6z3XsJutPl3dSpVo
	 vYB6xPe8oJqWU3OuqC7PTbMobQG87x7xFMnAQUNiWX5NFkolEte4P2MH21gt/0GNDj
	 lQYY5mMajmKWA==
Date: Fri, 30 Aug 2024 14:11:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 7/7] PCI: Create helper to print TLP Header and Prefix
 Log
Message-ID: <20240830191129.GA115840@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240514113109.6690-8-ilpo.jarvinen@linux.intel.com>

On Tue, May 14, 2024 at 02:31:09PM +0300, Ilpo Järvinen wrote:
> Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
> Print End-End Prefixes only if they are non-zero.
> 
> Consolidate the few places which currently print TLP using custom
> formatting.
> 
> The first attempt used pr_cont() instead of building a string first but
> it turns out pr_cont() is not compatible with pci_err() and prints on a
> separate line. When I asked about this, Andy Shevchenko suggested
> pr_cont() should not be used in the first place (to eventually get rid
> of it) so pr_cont() is now replaced with building the string first.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/pcie/aer.c | 10 ++--------
>  drivers/pci/pcie/dpc.c |  5 +----
>  drivers/pci/pcie/tlp.c | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 7afdd71f9026..45083e62892c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -423,6 +423,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, struct pcie_tlp_log *log);
>  unsigned int aer_tlp_log_len(struct pci_dev *dev);
> +void pcie_print_tlp_log(const struct pci_dev *dev,
> +			const struct pcie_tlp_log *log, const char *pfx);
>  #endif	/* CONFIG_PCIEAER */
>  
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ecc1dea5a208..efb9e728fe94 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -664,12 +664,6 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  	}
>  }
>  
> -static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
> -{
> -	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
> -		t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
> -}
> -
>  static void __aer_print_error(struct pci_dev *dev,
>  			      struct aer_err_info *info)
>  {
> @@ -724,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	__aer_print_error(dev, info);
>  
>  	if (info->tlp_header_valid)
> -		__print_tlp_header(dev, &info->tlp);
> +		pcie_print_tlp_log(dev, &info->tlp, "  ");

I see you went to some trouble to preserve the previous output, down
to the number of spaces prefixing it.

But more than the leading spaces, I think what people will notice is
that previously AER and DPC dmesgs contain the "AER: " or "DPC: "
prefixes implicitly added by the dev_fmt definitions [1], where now
IIUC they won't.

I think adding dev_fmt("") here should take care of that, e.g.,

  pcie_print_tlp_log(dev, &info->tlp, dev_fmt(""));

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1990272

>  out:
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
> @@ -796,7 +790,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  			aer->uncor_severity);
>  
>  	if (tlp_header_valid)
> -		__print_tlp_header(dev, &aer->header_log);
> +		pcie_print_tlp_log(dev, &aer->header_log, "  ");
>  
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 5056cc6961ec..598f74384471 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -220,10 +220,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
>  			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
>  			  dpc_tlp_log_len(pdev), &tlp_log);
> -	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
> -		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
> -	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++)
> -		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.prefix[i]);
> +	pcie_print_tlp_log(pdev, &tlp_log, "");
>  
>  	if (pdev->dpc_rp_log_size < 5)
>  		goto clear_status;
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index def9dd7b73e8..097ac8514e96 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/aer.h>
> +#include <linux/array_size.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
>  
> @@ -76,3 +77,33 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  
>  	return 0;
>  }
> +
> +/**
> + * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
> + * @dev: PCIe device
> + * @log: TLP Log structure
> + * @pfx: String prefix (for print out indentation)
> + *
> + * Prints TLP Header and Prefix Log information held by @log.
> + */
> +void pcie_print_tlp_log(const struct pci_dev *dev,
> +			const struct pcie_tlp_log *log, const char *pfx)
> +{
> +	char buf[(10 + 1) * (4 + ARRAY_SIZE(log->prefix)) + 14 + 1];
> +	unsigned int i;
> +	int len;
> +
> +	len = scnprintf(buf, sizeof(buf), "%#010x %#010x %#010x %#010x",
> +			log->dw[0], log->dw[1], log->dw[2], log->dw[3]);
> +
> +	if (log->prefix[0])
> +		len += scnprintf(buf + len, sizeof(buf) - len, " E-E Prefixes:");
> +	for (i = 0; i < ARRAY_SIZE(log->prefix); i++) {
> +		if (!log->prefix[i])
> +			break;
> +		len += scnprintf(buf + len, sizeof(buf) - len,
> +				 " %#010x", log->prefix[i]);
> +	}
> +
> +	pci_err(dev, "%sTLP Header: %s\n", pfx, buf);
> +}
> -- 
> 2.39.2
> 

