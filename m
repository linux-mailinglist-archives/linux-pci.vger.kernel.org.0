Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948A7217C1A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGHAKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 20:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGHAKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 20:10:11 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4ED820771;
        Wed,  8 Jul 2020 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594167010;
        bh=GRc7bmT28/LGGsLBxls6P/+Y6GitVFKoeGWw+LQ+Mwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v/atDYLgMKucbXsAUe1GUdgPRkPL0yNf7YGKKHQ5z4/k3CbENeBvSIhGrAZdQO++g
         F+BN9MXxPyuUjI72ftoxL941QdlK0rC+FHFMMbVHlc2EekTddVVfTZQZk8wOjRotJR
         tAAsdF9mi1WNnSuqgWU9/OkjzUQewK+8X08x9dCY=
Date:   Tue, 7 Jul 2020 19:10:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matt Jolly <Kangie@footclan.ninja>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: pcie: AER: Fix logging of Correctable errors
Message-ID: <20200708001008.GA404699@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618155511.16009-1-Kangie@footclan.ninja>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 01:55:11AM +1000, Matt Jolly wrote:
> The AER documentation indicates that correctable (severity=Corrected)
> errors should be output as a warning so that users can filter these
> errors if they choose to; This functionality does not appear to have been implemented.
> 
> This patch modifies the functions aer_print_error and __aer_print_error
> to send correctable errors as a warning (pci_warn), rather than as an error (pci_err). It
> partially addresses several bugs in relation to kernel message buffer
> spam for misbehaving devices - the root cause (possibly device firmware?) isn't
> addressed, but the dmesg output is less alarming for end users, and can
> be filtered separately from uncorrectable errors. This should hopefully
> reduce the need for users to disable AER to suppress corrected errors.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201517
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196183
> 
> Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
> ---
>  drivers/pci/pcie/aer.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 3acf56683915..131ecc0df2cb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -662,12 +662,18 @@ static void __aer_print_error(struct pci_dev *dev,
>  			errmsg = i < ARRAY_SIZE(aer_uncorrectable_error_string) ?
>  				aer_uncorrectable_error_string[i] : NULL;
>  
> -		if (errmsg)
> -			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
> -				info->first_error == i ? " (First)" : "");
> -		else
> +		if (errmsg) {
> +			if (info->severity == AER_CORRECTABLE) {
> +				pci_warn(dev, "   [%2d] %-22s%s\n", i, errmsg,

I think we can use pci_printk() here to reduce the code duplication.

And I think we can also simplify the aer_correctable_error_string/
aer_uncorrectable_error_string stuff above, which would make this even
simpler.

I'll respond to this with my proposal.

> +					info->first_error == i ? " (First)" : "");
> +			} else {
> +				pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
> +					info->first_error == i ? " (First)" : "");
> +			}
> +		} else {
>  			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
>  				i, info->first_error == i ? " (First)" : "");
> +		}
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
>  }
> @@ -686,13 +692,23 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		aer_error_severity_string[info->severity],
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	if  (info->severity == AER_CORRECTABLE) {
> +		pci_warn(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +			aer_error_severity_string[info->severity],
> +			aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> -		dev->vendor, dev->device,
> -		info->status, info->mask);
> +		pci_warn(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +			dev->vendor, dev->device,
> +			info->status, info->mask);
> +	} else {
> +		pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +			aer_error_severity_string[info->severity],
> +			aer_error_layer[layer], aer_agent_string[agent]);
> +
> +		pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +			dev->vendor, dev->device,
> +			info->status, info->mask);
> +	}
>  
>  	__aer_print_error(dev, info);
>  
> -- 
> 2.26.2
> 
