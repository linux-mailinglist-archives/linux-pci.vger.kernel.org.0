Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8DF2A9B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKGJ2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:28:51 -0500
Received: from foss.arm.com ([217.140.110.172]:52524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfKGJ2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:28:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A4646A;
        Thu,  7 Nov 2019 01:28:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDE3E3F71A;
        Thu,  7 Nov 2019 01:28:49 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:28:48 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/5] PCI/PTM: Remove spurious "d" from granularity message
Message-ID: <20191107092847.GP9723@e119886-lin.cambridge.arm.com>
References: <20191106222420.10216-1-helgaas@kernel.org>
 <20191106222420.10216-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-2-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:17PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The granularity message has an extra "d":
> 
>   pci 0000:02:00.0: PTM enabled, 4dns granularity
> 
> Remove the "d" so the message is simply "PTM enabled, 4ns granularity".
> 
> Fixes: 8b2ec318eece ("PCI: Add PTM clock granularity information")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Yong <jonathan.yong@intel.com
> ---
>  drivers/pci/pcie/ptm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 98cfa30f3fae..9361f3aa26ab 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -21,7 +21,7 @@ static void pci_ptm_info(struct pci_dev *dev)
>  		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
>  		break;
>  	default:
> -		snprintf(clock_desc, sizeof(clock_desc), "%udns",
> +		snprintf(clock_desc, sizeof(clock_desc), "%uns",
>  			 dev->ptm_granularity);
>  		break;
>  	}

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
