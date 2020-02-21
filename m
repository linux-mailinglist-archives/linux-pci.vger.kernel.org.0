Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6B167FE5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 15:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBUOP7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 09:15:59 -0500
Received: from foss.arm.com ([217.140.110.172]:40260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgBUOP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 09:15:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0766C1FB;
        Fri, 21 Feb 2020 06:15:59 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575C73F703;
        Fri, 21 Feb 2020 06:15:58 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:15:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: endpoint: Fix clearing start entry in
 configfs
Message-ID: <20200221141553.GA15440@e121166-lin.cambridge.arm.com>
References: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576844677-24933-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 09:24:37PM +0900, Kunihiko Hayashi wrote:
> The value of 'start' entry is no change whenever writing 0 to configfs.
> So the endpoint that stopped once can't restart.
> 
> The following command lines are an example restarting endpoint and
> reprogramming configurations after receiving bus-reset.
> 
>     echo 0 > controllers/66000000.pcie-ep/start
>     rm controllers/66000000.pcie-ep/func1
>     ln -s functions/pci_epf_test/func1 controllers/66000000.pcie-ep/
>     echo 1 > controllers/66000000.pcie-ep/start
> 
> However, the first 'echo' can't set 0 to 'start', so the last 'echo' can't
> restart endpoint.

I think your description is not correct - pci_epc_group->start is
just used to check if an endpoint has been started or not (in
pci_epc_epf_unlink() and that's a WARN_ON) but nonetheless this
looks like a bug and ought to be fixed.

I need Kishon's ACK to proceed.

Thanks,
Lorenzo

> Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 1 +
>  1 file changed, 1 insertion(+)
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
