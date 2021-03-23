Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F8F3462B2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhCWPXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 11:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232578AbhCWPXV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 11:23:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE1B619B7;
        Tue, 23 Mar 2021 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616513001;
        bh=jlJFnDJGjnsKl70hyRDGeEW3P/D+Q89ovrdknrtLq+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PJ/e5cb0kzWd1aK62SGJlHjH44f6UTyGm1Vt+R3QolE+2ue09shYeMoncuvJjBEUW
         cPaYl2jn6MisvRTNNP8z4nX0J9n1nlZIOsfix+Qnp/wMh2ryIpTmqqNIHY/2yRZEpK
         kIPmI9iKlEdMBPM46SwE24BykFmtwBb6rUNKiaPZz7Z2R2iL8C9QPMSMGGRC7xjzTR
         wWzsGoY9v94Cs682Y4h+5SCBvqkST+rWpkLwvOXANXVX28juH5iZIPk8jpr9m1WUdX
         nF7B5U8FV6Ra4o6NDFmAc0p3LD5COj0jPrC+eZMjaPedRVjQXTy8yO8nRACPZ3ImVc
         SLsijrGIjLrFQ==
Date:   Tue, 23 Mar 2021 10:23:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: free of node in pci_scan_device's error path
Message-ID: <20210323152319.GA578006@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124232826.1879-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 02:28:26AM +0300, Dmitry Baryshkov wrote:
> In the pci_scan_device() if pci_setup_device() fails for any reason, the
> code will not release device's of_node by calling pci_release_of_node().
> Fix that by calling the release function.
> 
> Fixes: 98d9f30c820d ("pci/of: Match PCI devices to OF nodes dynamically")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Applied with Leon's reviewed-by to pci/enumeration for v5.13, thanks!

> ---
> 
> Changes since v1:
>  - Changed the order of Fixes and S-o-B tags.
> 
> ---
>  drivers/pci/probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..be51670572fa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2353,6 +2353,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	pci_set_of_node(dev);
>  
>  	if (pci_setup_device(dev)) {
> +		pci_release_of_node(dev);
>  		pci_bus_put(dev->bus);
>  		kfree(dev);
>  		return NULL;
> -- 
> 2.29.2
> 
