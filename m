Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8A233684
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3QQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QQu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 12:16:50 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 925452072A;
        Thu, 30 Jul 2020 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596125809;
        bh=hNfjKS+QR4p8l07gd55PXLnckFNFqYkpyTOwjMmoaSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HjKiDMPwCoi7NJ0Jz+lypkIjYiHzaqqEMdVa2qeT2bX1EJ8XMPQmSMm3N8TTlWjAZ
         mprTQhhuobed38hEWxNtazyYchMzB9pCo7YrSzNaFClPDPdzevsQsDD7JoC9YKr6BR
         n3lPugWvDcQkidk96W5jq2v68qfrj8SHGLSknx6U=
Date:   Thu, 30 Jul 2020 11:16:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] PCI: rpadlpar: Make some functions static
Message-ID: <20200730161648.GA2044795@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721151735.41181-1-weiyongjun1@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 11:17:35PM +0800, Wei Yongjun wrote:
> The sparse tool report build warnings as follows:
> 
> drivers/pci/hotplug/rpadlpar_core.c:355:5: warning:
>  symbol 'dlpar_remove_pci_slot' was not declared. Should it be static?
> drivers/pci/hotplug/rpadlpar_core.c:461:12: warning:
>  symbol 'rpadlpar_io_init' was not declared. Should it be static?
> drivers/pci/hotplug/rpadlpar_core.c:473:6: warning:
>  symbol 'rpadlpar_io_exit' was not declared. Should it be static?
> 
> Those functions are not used outside of this file, so marks them
> static.
> Also mark rpadlpar_io_exit() as __exit.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/hotplug for v5.9, thanks!

> ---
>  drivers/pci/hotplug/rpadlpar_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index c5eb509c72f0..f979b7098acf 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -352,7 +352,7 @@ static int dlpar_remove_vio_slot(char *drc_name, struct device_node *dn)
>   * -ENODEV		Not a valid drc_name
>   * -EIO			Internal PCI Error
>   */
> -int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
> +static int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
>  {
>  	struct pci_bus *bus;
>  	struct slot *slot;
> @@ -458,7 +458,7 @@ static inline int is_dlpar_capable(void)
>  	return (int) (rc != RTAS_UNKNOWN_SERVICE);
>  }
>  
> -int __init rpadlpar_io_init(void)
> +static int __init rpadlpar_io_init(void)
>  {
>  
>  	if (!is_dlpar_capable()) {
> @@ -470,7 +470,7 @@ int __init rpadlpar_io_init(void)
>  	return dlpar_sysfs_init();
>  }
>  
> -void rpadlpar_io_exit(void)
> +static void __exit rpadlpar_io_exit(void)
>  {
>  	dlpar_sysfs_exit();
>  }
> 
