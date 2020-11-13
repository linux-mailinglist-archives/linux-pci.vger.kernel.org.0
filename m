Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DF2B28C2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKMWr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 17:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKMWrZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 17:47:25 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F6F2222F;
        Fri, 13 Nov 2020 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605307644;
        bh=SVQcSQz/sZnsL3KN+ixJwKoq7zz3V8wfN8RLKz+T52E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nxCWuT/UIgu9izJ4MasMwYrxyg2dl3KXKBEYjNc84j+TQIQL8/WByyFDIU1AJ96P3
         zYV8qBOYNJJ4lBQ0Cy8/IkuEzxNy2xKjTkDSIWvkSK4xgPgGcb8HwF5Ys0AOmVb54v
         x879ckeuZRllQfHmE9w2q/UT/d02WATWiaDkyWyU=
Date:   Fri, 13 Nov 2020 16:47:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, hch@infradead.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] PCI: check also dynamic IDs for duplicate in
 new_id_store()
Message-ID: <20201113224723.GA1139246@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026035710.593-1-zhenzhong.duan@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex, Cornelia in case VFIO cares about new_id/remove_id
semantics]

On Mon, Oct 26, 2020 at 11:57:10AM +0800, Zhenzhong Duan wrote:
> When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
> only static ID table is checked for duplicate and multiple dynamic ID
> entries of same kind are allowed to exist in a dynamic linked list.

This doesn't quite say what the problem is.

I see that currently new_id_store() uses pci_match_id() to see if the
new device ID is in the static id_table, so adding the same ID twice
adds multiple entries to the dynids list.  That does seem wrong, and I
think we should fix it.

But I would like to clarify this commit log so we know whether the
current behavior causes user-visible broken behavior.  The dynids list
is mostly used by pci_match_device(), and it looks like duplicate
entries shouldn't cause it a problem.

I guess remove_id_store() will only remove one of the duplicate
entries, so if we add an ID several times, we would have to remove it
the same number of times before it's completely gone.

> Fix it by calling pci_match_device() which checks both dynamic and static
> IDs.
> 
> After fix, it shows below result which is expected.
> 
> echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> -bash: echo: write error: File exists
> 
> Drop the static specifier and add a prototype to avoid build error.

I don't get this part.  You added a prototype in include/linux/pci.h,
which means you expect callers outside drivers/pci.  But there aren't
any.

In fact, you're only adding a call in the same file where
pci_match_device() is defined.  The usual way to resolve that is to
move the pci_match_device() definition before the call, so no forward
declaration is needed and the function can remain static.

I think pci_match_id() and pci_match_device() should both be moved so
they remain together.  It would be nice if the move itself were a
no-op patch separate from the one that changes new_id_store().

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
> v2: revert the export of pci_match_device() per Christoph
>     combind PATCH1 and PATCH2 into one.
> 
>  drivers/pci/pci-driver.c | 4 ++--
>  include/linux/pci.h      | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 8b587fc..cdc7d13 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -125,7 +125,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
>  		pdev->subsystem_device = subdevice;
>  		pdev->class = class;
>  
> -		if (pci_match_id(pdrv->id_table, pdev))
> +		if (pci_match_device(pdrv, pdev))
>  			retval = -EEXIST;
>  
>  		kfree(pdev);
> @@ -250,7 +250,7 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>   * system is in its list of supported devices.  Returns the matching
>   * pci_device_id structure or %NULL if there is no match.
>   */
> -static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
> +const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  						    struct pci_dev *dev)
>  {
>  	struct pci_dynid *dynid;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a7..ec57312 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1409,6 +1409,8 @@ int pci_add_dynid(struct pci_driver *drv,
>  		  unsigned long driver_data);
>  const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>  					 struct pci_dev *dev);
> +const struct pci_device_id *pci_match_device(struct pci_driver *drv,
> +					     struct pci_dev *dev);
>  int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>  		    int pass);
>  
> -- 
> 1.8.3.1
> 
