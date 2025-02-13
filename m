Return-Path: <linux-pci+bounces-21390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10806A350F9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C803AB00A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB7269888;
	Thu, 13 Feb 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2evO8Fl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6D269824;
	Thu, 13 Feb 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484646; cv=none; b=kH63UDbbwluRaroqMcRkJk+Vetzbzlu9uouvXwfa0ueZcNnVoOGNUkiav9q0O+EhLFahfrccv8tLWpjkgQ/mvHmMPqVCvM5lWS9LNecsMuzp/uJ+KRI61lDsbFZgN6xHfb8DJ1hr3QYdMgDm1LL9vjI8b51k8jzNolK+LCT7c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484646; c=relaxed/simple;
	bh=SOvHEA/CRJXJgXuokc//mSA8/PswxFWkOifChOXjk50=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PPCmppPihuK5EaTCCRBjUgmBQxXsOvrTZ8lbGky6IyeUBeNmmIcKxW83TZWouj/NAU66Um7LDLfjQ7k6UK88yThcZ2WY13HngVPEnW5K7KztE4NVJbx9g2QVVJr1Bq+af9zIkAmi9kfwZMO/U6DVVj+ihXdZLnBwDixpTmWYOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2evO8Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D83FC4CED1;
	Thu, 13 Feb 2025 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484645;
	bh=SOvHEA/CRJXJgXuokc//mSA8/PswxFWkOifChOXjk50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=B2evO8FlqWDQGTpnPn9pO+9+08ZJu0HcEjcVGn2ea0HwBI5gyNvfjfBmeUT2GTvWr
	 F0yw4oJ0bJn7lGpEKH9Fw6aEWLR5WSRSfMckrsaDo8xQo4Zm05bjm8COWcOLegjPqI
	 YRG2Lz1gVtwI0bar1pMWhnvQVQF+eJP1sHF7g4vJgX3uYWbCMoBOhTSEGXOzRHDL8/
	 P7gBOPGY8OxDqDARSujkwoIkmQDMEDDWuRgtm+cQcKNZF/uDy5Lo11D4+JzSRh7t6y
	 Yt3pMzRxEOYeijcOw/kZ/WdeZ47+YHmBqq3dxZrOfc30lSzOSdBqD/Onh8H4nMkwGL
	 05Mz2pAdpLmUw==
Date: Thu, 13 Feb 2025 16:10:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: Descope pci_printk() to aer_printk()
Message-ID: <20250213221043.GA136196@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216161012.1774-5-ilpo.jarvinen@linux.intel.com>

On Mon, Dec 16, 2024 at 06:10:12PM +0200, Ilpo Järvinen wrote:
> include/linux/pci.h provides low-level pci_printk() interface that is
> only used by AER because it needs to print the same message with
> different levels depending on the error severity. No other PCI code
> uses that functionality and calls pci_<level>() logging functions
> directly with the appropriate level.
> 
> Descope pci_printk() into AER as aer_printk().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I applied this patch by itself on pci/aer for v6.15.

We also have some work-in-progress on rate limiting errors, which
might conflict, but this is simple and shouldn't be hard to reconcile.

> ---
>  drivers/pci/pcie/aer.c | 10 +++++++---
>  include/linux/pci.h    |  3 ---
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 80c5ba8d8296..bfc6b94dad4d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -17,6 +17,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/cper.h>
> +#include <linux/dev_printk.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
>  #include <linux/sched.h>
> @@ -35,6 +36,9 @@
>  #include "../pci.h"
>  #include "portdrv.h"
>  
> +#define aer_printk(level, pdev, fmt, arg...) \
> +	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> +
>  #define AER_ERROR_SOURCES_MAX		128
>  
>  #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
> @@ -692,7 +696,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  		if (!errmsg)
>  			errmsg = "Unknown Error Bit";
>  
> -		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
> +		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error == i ? " (First)" : "");
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
> @@ -715,11 +719,11 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>  
> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>  		   aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>  		   dev->vendor, dev->device, info->status, info->mask);
>  
>  	__aer_print_error(dev, info);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..02d23e795915 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2685,9 +2685,6 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  
>  #include <linux/dma-mapping.h>
>  
> -#define pci_printk(level, pdev, fmt, arg...) \
> -	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> -
>  #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
>  #define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
>  #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
> -- 
> 2.39.5
> 

