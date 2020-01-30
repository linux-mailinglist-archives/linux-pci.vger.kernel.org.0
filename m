Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0D14E60D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 00:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgA3XM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 18:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3XM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 18:12:26 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B72920CC7;
        Thu, 30 Jan 2020 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580425945;
        bh=gzsMrTtb9Fq+c+LI9IZkZBwAoRsZIwEATMUcoPLVf3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1uzM9gxiRMrnyQ4DIqjYk0wcpIZpx5B75T1ImIK5LlmJ1OG8o/cvu+/Pf/c5D1y16
         OAS+ngx33JLldLY6S8TbbN2iGQJghTZ3sEfucszpffEj/V7Y9wlujgm4jNyWPDGJRn
         WyzIMlxGZ+hyUzVrVLS8g9N/T3TOBwM0NFQ1FvFk=
Date:   Thu, 30 Jan 2020 17:12:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com
Subject: Re: [PATCH v7 02/26] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
Message-ID: <20200130231222.GA141544@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129152937.311162-3-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 06:29:13PM +0300, Sergei Miroshnichenko wrote:
> The PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits of the bridge must be
> updated not only when enabling the bridge for the first time, but also if a
> hotplugged device requests these types of resources.
> 
> For example, if a bridge had all its slots empty, the IO and MEM bits will
> not be set, and a hot hotplugged device will fail.

s/hot hotplugged/hot-added/ or something similar

> Originally these bits were set by the pci_enable_device_flags() only, which
> exits early if the bridge is already pci_is_enabled(). So let's check them
> again when requested.

s/by the/by/
s/ only,/,

IIUC, in the current tree (before this series), we do set
PCI_COMMAND_IO and PCI_COMMAND_MEMORY on bridges leading to hot-added
devices, but this patch is needed because [01/26] "PCI: Fix race
condition in pci_enable/disable_device()" makes
pci_enable_device_flags() exit early without setting those bits.

That would mean there's a bisection hole between [01/26] and [02/26]
where hot-added devices will fail.  We don't want a hole like that.

> Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0366289c75e9..cb0042f28e6a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1679,6 +1679,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  		pci_enable_bridge(bridge);
>  
>  	if (pci_is_enabled(dev)) {
> +		int i, bars = 0;
> +
> +		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
> +			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
> +				bars |= (1 << i);
> +		}
> +		do_pci_enable_device(dev, bars);
> +
>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
>  		mutex_unlock(&dev->enable_mutex);
> -- 
> 2.24.1
> 
