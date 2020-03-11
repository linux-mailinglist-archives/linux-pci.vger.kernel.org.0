Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E564818169C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 12:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgCKLTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 07:19:04 -0400
Received: from foss.arm.com ([217.140.110.172]:48228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgCKLTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 07:19:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 596BA1FB;
        Wed, 11 Mar 2020 04:19:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B463F6CF;
        Wed, 11 Mar 2020 04:19:02 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:18:57 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Fix clearing start entry in configfs
Message-ID: <20200311111857.GA517@e121166-lin.cambridge.arm.com>
References: <1582696343-23049-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582696343-23049-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 02:52:23PM +0900, Kunihiko Hayashi wrote:
> After endpoint has started using configfs, if 0 is written to the entry
> 'start', the controller stops but the entry value remains 1.
> 
> At this time, unlinking the function from the controller, WARN_ON_ONCE()
> in pci_epc_epf_unlink() will be triggered despite right behavior.
> 
> This fixes the issue by clearing the entry when stopping the controller.
> 
> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/endpoint for v5.7.

Thanks,
Lorenzo

> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d1288a0..4fead88 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -58,6 +58,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
>  
>  	if (!start) {
>  		pci_epc_stop(epc);
> +		epc_group->start = 0;
>  		return len;
>  	}
>  
> -- 
> 2.7.4
> 
