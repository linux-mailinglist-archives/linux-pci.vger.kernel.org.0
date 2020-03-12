Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5156183ACA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 21:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCLUpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 16:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCLUpR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 16:45:17 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067F0205F4;
        Thu, 12 Mar 2020 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584045916;
        bh=zZzSYd+OhEGo8pmui4OqaDSuxP1H2anQxWw6SpQUHb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nx7m7zJcnrAvX1RV8llWgsCoe4zJIRYbu9W2a5EFju1bjHduukyyrr861uJ2A38+c
         SD4yPMh1iEsi3jWdLg+wFDm11H4Mn213zXfKWrpetsfmbPZmH4P3EnuIJMFcVRAlzQ
         GHFsnrLuzMfgwFRn6465StIBaqkEOazOtFgUBYDc=
Date:   Thu, 12 Mar 2020 15:45:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
        baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 03/11] PCI: OF: Check whether the host bridge supports
 ATS
Message-ID: <20200312204514.GA178416@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 01:44:58PM +0100, Jean-Philippe Brucker wrote:
> When setting up a generic host on a device-tree based system, copy the
> ats-supported flag into the pci_host_bridge structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: keep the helper in pci-host-common.c
> ---
>  drivers/pci/controller/pci-host-common.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 250a3fc80ec6..2e800bc6ae7a 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -54,6 +54,16 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  	return ERR_PTR(err);
>  }
>  
> +static void of_pci_host_check_ats(struct pci_host_bridge *bridge)
> +{
> +	struct device_node *np = bridge->bus->dev.of_node;
> +
> +	if (!np)
> +		return;
> +
> +	bridge->ats_supported = of_property_read_bool(np, "ats-supported");
> +}
> +
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops)
>  {
> @@ -92,6 +102,7 @@ int pci_host_common_probe(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	of_pci_host_check_ats(bridge);

I would prefer to write this as a predicate instead of having the
assignment be a side-effect, e.g.,

  bridge->ats_supported = of_pci_host_ats_supported(bridge);

If that works for you,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  	platform_set_drvdata(pdev, bridge->bus);
>  	return 0;
>  }
> -- 
> 2.25.1
> 
