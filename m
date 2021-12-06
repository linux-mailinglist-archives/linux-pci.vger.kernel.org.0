Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD60469535
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhLFLtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 06:49:04 -0500
Received: from foss.arm.com ([217.140.110.172]:55070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237397AbhLFLtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 06:49:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AA4B1042;
        Mon,  6 Dec 2021 03:45:35 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF63B3F73D;
        Mon,  6 Dec 2021 03:45:34 -0800 (PST)
Date:   Mon, 6 Dec 2021 11:45:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shunsuke Mie <mie@igel.co.jp>, kishon@ti.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix use after free in pci_epf_remove_cfs()
Message-ID: <20211206114532.GB18520@lpieralisi>
References: <20210621070058.37682-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621070058.37682-1-mie@igel.co.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[dropped stable, erroneously added to the CC list]

On Mon, Jun 21, 2021 at 04:00:58PM +0900, Shunsuke Mie wrote:
> All of entries are freed in a loop, however, the freed entry is accessed
> by list_del() after the loop.
> 
> When epf driver that includes pci-epf-test unload, the pci_epf_remove_cfs()
> is called, and occurred the use after free. Therefore, kernel panics
> randomly after or while the module unloading.
> 
> I tested this patch with r8a77951-Salvator-xs boards.
> 
> Fixes: ef1433f ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Kishon, please review this patch, thanks.

Lorenzo

> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index e9289d10f822..538e902b0ba6 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -202,8 +202,10 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  		return;
>  
>  	mutex_lock(&pci_epf_mutex);
> -	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
> +	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry) {
> +		list_del(&group->group_entry);
>  		pci_ep_cfs_remove_epf_group(group);
> +	}
>  	list_del(&driver->epf_group);
>  	mutex_unlock(&pci_epf_mutex);
>  }
> -- 
> 2.17.1
> 
