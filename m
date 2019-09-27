Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8EC0DC6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2019 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfI0WBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 18:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0WBh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 18:01:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D221B2082F;
        Fri, 27 Sep 2019 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569621697;
        bh=3gKE7NR6aQzEoQPANayg8VF+vjEvBawquzUnQ3HOO9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VYwSf5PqkjJ2JobOy8WvasnNZ3WvFmaP8SFVwZcyFVuN5Fg7KgVkdxsUQCrjE+77r
         plMmJiTgWXq3/AAQCiu/J6PPxwUilv1znv/xF4viH8tLPbI9INAmzs2fYRWeBwyiAT
         Wxvk7JdwfwMlyu3n8HgjD16lipxW3I/VhKQkGyi0=
Date:   Fri, 27 Sep 2019 17:01:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH v5 02/23] PCI: Enable bridge's I/O and MEM access for
 hotplugged devices
Message-ID: <20190927220135.GA55204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165101.911-3-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 07:50:40PM +0300, Sergey Miroshnichenko wrote:
> The PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits of the bridge must be
> updated not only when enabling the bridge for the first time, but also if a
> hotplugged device requests these types of resources.

Yeah, this assumption that pci_is_enabled() means PCI_COMMAND_IO and
PCI_COMMAND_MEMORY are set correctly even though we may now need
*different* settings than when we incremented pdev->enable_cnt is
quite broken.

> Originally these bits were set by the pci_enable_device_flags() only, which
> exits early if the bridge is already pci_is_enabled(). So if the bridge was
> empty initially (an edge case), then hotplugged devices fail to IO/MEM.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7f8c354e644..61d951766087 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1652,6 +1652,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
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
> 2.21.0
> 
