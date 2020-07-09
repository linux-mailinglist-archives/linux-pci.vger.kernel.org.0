Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE921AA3F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIWGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 18:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 18:06:05 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E91206A1;
        Thu,  9 Jul 2020 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332364;
        bh=1E3KNYJwxzhk32vkxEFceHo/gsiJzSp6Aq70IvYmWQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hOh4lvO6KVrS6aI6+Ob+ftOEskN/RvK0Afz3UgwW9FW6/2X96hxs19EqA5He/U1bA
         +xP3oo0uep2m07nZQ4vYHju3ZIIj7vIK3v1ta6WdtVWZhpBWYnFslhv0cuX8rFBdem
         rfOv/uGGLlBSdNUzbFcGYr7H8NrfRXMLQFKOoWok=
Date:   Thu, 9 Jul 2020 17:06:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matt Jolly <Kangie@footclan.ninja>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/AER: Log correctable errors as warning, not error
Message-ID: <20200709220602.GA21872@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708001401.405749-2-helgaas@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 07, 2020 at 07:14:01PM -0500, Bjorn Helgaas wrote:
> From: Matt Jolly <Kangie@footclan.ninja>
> 
> PCIe correctable errors are recovered by hardware with no need for software
> intervention (PCIe r5.0, sec 6.2.2.1).
> 
> Reduce the log level of correctable errors from KERN_ERR to KERN_WARNING.
> 
> The bug reports below are for correctable error logging.  This doesn't fix
> the cause of those reports, but it may make the messages less alarming.
> 
> [bhelgaas: commit log, use pci_printk() to avoid code duplication]
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201517
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196183
> Link: https://lore.kernel.org/r/20200618155511.16009-1-Kangie@footclan.ninja
> Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied both of these to pci/error for v5.9.

> ---
>  drivers/pci/pcie/aer.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9176c8a968b9..ca886bf91fd9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -673,20 +673,23 @@ static void __aer_print_error(struct pci_dev *dev,
>  {
>  	const char **strings;
>  	unsigned long status = info->status & ~info->mask;
> -	const char *errmsg;
> +	const char *level, *errmsg;
>  	int i;
>  
> -	if (info->severity == AER_CORRECTABLE)
> +	if (info->severity == AER_CORRECTABLE) {
>  		strings = aer_correctable_error_string;
> -	else
> +		level = KERN_WARNING;
> +	} else {
>  		strings = aer_uncorrectable_error_string;
> +		level = KERN_ERR;
> +	}
>  
>  	for_each_set_bit(i, &status, 32) {
>  		errmsg = strings[i];
>  		if (!errmsg)
>  			errmsg = "Unknown Error Bit";
>  
> -		pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
> +		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>  				info->first_error == i ? " (First)" : "");
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
> @@ -696,6 +699,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int layer, agent;
>  	int id = ((dev->bus->number << 8) | dev->devfn);
> +	const char *level;
>  
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -706,13 +710,14 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		aer_error_severity_string[info->severity],
> -		aer_error_layer[layer], aer_agent_string[agent]);
> +	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> +
> +	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> +		   aer_error_severity_string[info->severity],
> +		   aer_error_layer[layer], aer_agent_string[agent]);
>  
> -	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> -		dev->vendor, dev->device,
> -		info->status, info->mask);
> +	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> +		   dev->vendor, dev->device, info->status, info->mask);
>  
>  	__aer_print_error(dev, info);
>  
> -- 
> 2.25.1
> 
