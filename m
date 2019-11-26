Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9D10A723
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZXff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 18:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKZXff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 18:35:35 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119672068E;
        Tue, 26 Nov 2019 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574811334;
        bh=nsIh+FqfXE51KYxMP7orrQBf82TVEWdWTfUaHH5XBNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vwBDgqBh+LqCoJmpY3xFQYZ3DRKUkUG3Fyd0vkUS80M0xyPNcfD0rmNQmWqVkmc+v
         l7MDK1Nb1aKSeCtV5+VNLMaapx6ElnNW0WP/2Jw/HmcKgFbeyqrgzt+iu+wu0Q7vbo
         NnUkOogi0qgdOzhEck6mPiv3UkMfUyOPAowM3U5c=
Date:   Tue, 26 Nov 2019 17:35:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     natechancellor@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu
Subject: Re: [PATCH v2] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Message-ID: <20191126233532.GA215615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125195255.23740-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 25, 2019 at 01:52:52PM -0600, Navid Emamdoost wrote:
> In the implementation of pci_iov_add_virtfn() the allocated virtfn is
> leaked if pci_setup_device() fails. The error handling is not calling
> pci_stop_and_remove_bus_device(). Change the goto label to failed2.
> 
> Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Applied to pci/virtualization for v5.6, thanks!

> ---
> Changes in v2:
> 	- rename the labels for error paths
> ---
>  drivers/pci/iov.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b3f972e8cfed..deec9f9e0b61 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -187,10 +187,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	sprintf(buf, "virtfn%u", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
> -		goto failed2;
> +		goto failed1;
>  	rc = sysfs_create_link(&virtfn->dev.kobj, &dev->dev.kobj, "physfn");
>  	if (rc)
> -		goto failed3;
> +		goto failed2;
>  
>  	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>  
> @@ -198,11 +198,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  
>  	return 0;
>  
> -failed3:
> -	sysfs_remove_link(&dev->dev.kobj, buf);
>  failed2:
> -	pci_stop_and_remove_bus_device(virtfn);
> +	sysfs_remove_link(&dev->dev.kobj, buf);
>  failed1:
> +	pci_stop_and_remove_bus_device(virtfn);
>  	pci_dev_put(dev);
>  failed0:
>  	virtfn_remove_bus(dev->bus, bus);
> -- 
> 2.17.1
> 
