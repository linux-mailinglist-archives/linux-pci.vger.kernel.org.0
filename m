Return-Path: <linux-pci+bounces-24153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103A0A697DD
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 19:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A7428310
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA41ACEAC;
	Wed, 19 Mar 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPbjBmZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DE1DC9A7
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408390; cv=none; b=KW38sYRqChuROhXUhPJxb2eA/e7cs07iVyJTC1fZrwvbgU2FAdXK5i2j0BkvQ3rZs4aBbFw+7oT5SWFd1aBA9BHnHk/nhlT1MTN3xwhEIHfe3bHvm/+ZYf9IYUsQoZRILXxFjNDhy3svEKxxhbTNgKdOK9KbF06bz9bBJPJGD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408390; c=relaxed/simple;
	bh=QnmVJFrgMx0HyNEicZyc1gcqUHXnaPSlBHj6+1oBoBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T/1/lhQorBBiT86GiozdrP+P32IUjvdteBzA3jksLzSpBkSU48A3mGpQ1zXMwfYttW34OTx2nMMCgyp8OdyItGSEyl1nmTaReYlzzvP20lL2Fasp6FMdp49W2xQEt9gD4/3xphuZC/epUO3RTvW7zw3jjWSKesDxQDGtSTjZzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPbjBmZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6741C4CEE4;
	Wed, 19 Mar 2025 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742408389;
	bh=QnmVJFrgMx0HyNEicZyc1gcqUHXnaPSlBHj6+1oBoBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nPbjBmZPxpJEVBG+lmKLwwx94aeoIQij/ZEm0a58YsYwJCfiafWQo/h/js2DDiioU
	 ufJ0+RwIlLGFXYK00eoC2a0z44xgGR5RzpHTosfXSlsnOt5Tg0mqETg1pSpKwPpAhP
	 IEdnRBBKXnpkVsIg2cZwVQTTE5JMqlyQvemDM8zf7iUBpr3vWiJj+7DSfT6gFFdNFb
	 fDiyhAgtrUo82WDj5Eq2u+bVdEUbbddnmb2/xQyIvKxl1ZICgZaA7euHs9/I9N0RAq
	 SKr5XQX3bru4Pu8hDiOI7VbtJvEAYJvUpCq6oqvVgftKwYA2SL0M/cdLQlOn11V0Qu
	 +FEHhT1ONlZBA==
Date: Wed, 19 Mar 2025 13:19:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v3 3/8] PCI/AER: Move AER stat collection out of
 __aer_print_error()
Message-ID: <20250319181948.GA1050371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319084050.366718-4-pandoh@google.com>

On Wed, Mar 19, 2025 at 01:40:44AM -0700, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. AERs from ghes
> or cxl drivers have stat collection in pci_print_aer() as that is where
> aer_err_info is populated.

This moves pci_dev_aer_stats_incr() from __aer_print_error() to

  - pci_print_aer(), used by CXL via cxl_handle_rdport_errors() and
    GHES via aer_recover_queue() and aer_recover_work_func()

  - aer_process_err_devices(), used by native AER handling via
    aer_irq(), aer_isr(), aer_isr_one_error(), and

  - dpc_process_error(), used by native DPC handling via dpc_handler()
    and by ACPI EDR Notify events via edr_handle_event()

And the reason for this is ...?

Maybe just to separate stats from printing, which does seem reasonable
to me, although pci_print_aer() is still primarily a printing
function, albeit also an external interface.

In any event, I would like to include the motivation.

> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>  drivers/pci/pci.h      |  1 +
>  drivers/pci/pcie/aer.c | 10 ++++++----
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 75985b96ecc1..9d63d32f041c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -551,6 +551,7 @@ struct aer_err_info {
>  };
>  
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
>  
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7eeaad917134..8e4d4f9326e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -617,8 +617,7 @@ const struct attribute_group aer_stats_attr_group = {
>  	.is_visible = aer_stats_attrs_are_visible,
>  };
>  
> -static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
> -				   struct aer_err_info *info)
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>  {
>  	unsigned long status = info->status & ~info->mask;
>  	int i, max = -1;
> @@ -691,7 +690,6 @@ static void __aer_print_error(struct pci_dev *dev,
>  		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error == i ? " (First)" : "");
>  	}
> -	pci_dev_aer_stats_incr(dev, info);
>  }
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> @@ -784,6 +782,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	info.mask = mask;
>  	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>  
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>  	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>  	__aer_print_error(dev, &info, level);
>  	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -1263,8 +1263,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
>  
>  	/* Report all before handle them, not to lost records by reset etc. */
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
> +			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
>  			aer_print_error(e_info->dev[i], e_info, level);
> +		}
>  	}
>  	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>  		if (aer_get_device_error_info(e_info->dev[i], e_info))
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 9e4c9ac737a7..81cd6e8ff3a4 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -289,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
> +		pci_dev_aer_stats_incr(pdev, &info);
>  		aer_print_error(pdev, &info, KERN_ERR);
>  		pci_aer_clear_nonfatal_status(pdev);
>  		pci_aer_clear_fatal_status(pdev);
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

